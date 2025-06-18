#pragma once

#include "file.hpp"
#include "noncopyable.hpp"

#include <string>

class Sniffer
{
private:
    static File get_available_bpf_device();

public:
    explicit Sniffer(const std::string &interface_name);
    // Sniffer(Sniffer &&other) = delete;

public:
    Buffer read_next_capture();

public:
    std::string get_interface_name() const;

private:
    void init_bpf_device();

private:
    const std::string _interface_name;
    File _bpf_device;
    uint _read_buffer_size;
    Buffer _read_buffer;
    Buffer::const_iterator _current_bpf_capture;
};