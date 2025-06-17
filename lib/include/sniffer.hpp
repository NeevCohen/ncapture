#pragma once

#include "file.hpp"
#include "noncopyable.hpp"

#include <string>

#include "net/bpf.h"

namespace lib
{
    class Sniffer : noncopyable
    {
    private:
        static lib::File get_available_bpf_device();

    public:
        Sniffer(const std::string &interface_name);
        Sniffer(Sniffer &&other) = delete;

    public:
        Buffer read_next_capture();

    private:
        void
        init_bpf_device();

    private:
        const std::string _interface_name;
        File _bpf_device;
        uint _read_buffer_size;
        Buffer _read_buffer;
    };
}