#include "file.hpp"
#include "string_utils.hpp"

#include <exception>
#include <iostream>

#include <sys/ioctl.h>
#include <fcntl.h>
#include <unistd.h>

int lib::File::open(const std::string &path, int flags)
{
    int fd = ::open(path.c_str(), flags);
    if (fd < 0)
    {
        throw std::runtime_error(string_format("Failed to open %s", path.c_str()));
    }

    return fd;
}

lib::File::File(const std::string &path, int flags) : path(path),
                                                      _fd(open(path, flags))
{
}

lib::File::File(File &&other)
{
    std::swap(other._fd, _fd);
}

lib::File::~File()
{
    try
    {
        if (_fd > 0 && close(_fd) != 0)
        {
            std::cerr << "Failed to close file " << path << std::endl;
        }
    }
    catch (...)
    {
        std::cerr << "Caught exception while trying to close file " << path << std::endl;
    }
}

void lib::File::ioctl(unsigned long request, void *parameter)
{
    if (::ioctl(_fd, request, parameter) == -1)
    {
        throw std::runtime_error(string_format("ioctl failed (fd: %d, request: 0x%x, errno: %d)", _fd, request, errno));
    }
}

lib::Buffer lib::File::read(size_t length)
{
    Buffer buffer(length);
    const ssize_t bytes_read = ::read(_fd, buffer.data(), buffer.size());
    if (bytes_read == -1)
    {
        throw std::runtime_error(string_format("Failed to read from file %s (errno %d)", path.c_str(), errno));
    }

    buffer.resize(bytes_read);
    return buffer;
}
