#pragma once

#include <memory>
#include <string>
#include <stdexcept>

namespace lib
{
    template <typename... Args>
    std::string string_format(const std::string &format, Args... args)
    {
        static constexpr size_t NULL_TERMINATOR_SIZE = 1;
        int size_s = std::snprintf(nullptr, 0, format.c_str(), args...) + NULL_TERMINATOR_SIZE;
        if (size_s <= 0)
        {
            throw std::runtime_error("Error during formatting.");
        }
        auto size = static_cast<size_t>(size_s);
        std::unique_ptr<char[]> buf(new char[size]);
        std::snprintf(buf.get(), size, format.c_str(), args...);
        return std::string(buf.get(), buf.get() + size - NULL_TERMINATOR_SIZE);
    }
}