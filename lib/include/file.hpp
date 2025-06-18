#pragma once

#include "noncopyable.hpp"
#include "types.hpp"

#include <string>

namespace lib
{
    class File : public noncopyable
    {
    private:
        int open(const std::string &path, int flags);

    public:
        explicit File(const std::string &path, int flags);
        File(File &&other);
        ~File();

    public:
        void ioctl(unsigned long request, void *parameter);
        Buffer read(size_t length);

    public:
        const std::string path;

    private:
        int _fd;
    };
}