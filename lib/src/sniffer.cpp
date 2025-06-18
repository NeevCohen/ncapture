#include "sniffer.hpp"
#include "sniffer.hpp"
#include "string_utils.hpp"

#include <iostream>

#include <fcntl.h>
#include <sys/types.h>
#include <sys/time.h>
#include <sys/ioctl.h>
#include <net/bpf.h>

File Sniffer::get_available_bpf_device()
{
    static constexpr size_t MAX_BPF_DEVICES = 99;
    static constexpr char BPF_DEVICE_FORMAT[] = "/dev/bpf%u";

    for (size_t i = 0; i < 99; ++i)
    {
        try
        {
            const std::string bpf_dev_path = string_format(BPF_DEVICE_FORMAT, i);
            return File{bpf_dev_path, O_RDONLY};
        }
        catch (const std::runtime_error &)
        {
        }
    }

    throw std::runtime_error("Failed to find available bpf device");
}

Sniffer::Sniffer(const std::string &interface_name) : _interface_name(interface_name),
                                                      _bpf_device(get_available_bpf_device()),
                                                      _read_buffer_size(0),
                                                      _read_buffer({}),
                                                      _current_bpf_capture(_read_buffer.cend())
{
    init_bpf_device();
}

Buffer Sniffer::read_next_capture()
{
    if (_current_bpf_capture >= _read_buffer.cend())
    {
        _read_buffer = _bpf_device.read(_read_buffer_size);
        _current_bpf_capture = _read_buffer.cbegin();
    }

    const bpf_hdr *bpf_header = reinterpret_cast<const bpf_hdr *>(&(*_current_bpf_capture));
    const Buffer::const_iterator capture_data_start = _current_bpf_capture + bpf_header->bh_hdrlen;
    const Buffer::const_iterator capture_data_end = _current_bpf_capture + bpf_header->bh_hdrlen + bpf_header->bh_datalen;

    if (capture_data_start >= _read_buffer.cend())
    {
        throw std::logic_error("Reading past end of read buffer");
    }

    const Buffer capture_data(capture_data_start, capture_data_end);

    std::advance(_current_bpf_capture, BPF_WORDALIGN(bpf_header->bh_hdrlen + bpf_header->bh_caplen));
    return capture_data;
}

std::string Sniffer::get_interface_name() const
{
    return _interface_name;
}

void Sniffer::init_bpf_device()
{
    _bpf_device.ioctl(BIOCGBLEN, &_read_buffer_size);
    _bpf_device.ioctl(BIOCSBLEN, &_read_buffer_size);

    ifreq interface{};
    std::strcpy(interface.ifr_name, _interface_name.c_str());
    _bpf_device.ioctl(BIOCSETIF, &interface);

    static u_int IMMEDIATE = 1;
    _bpf_device.ioctl(BIOCIMMEDIATE, &IMMEDIATE);

    _bpf_device.ioctl(BIOCPROMISC, nullptr);
}
