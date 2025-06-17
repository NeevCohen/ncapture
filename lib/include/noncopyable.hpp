#pragma once

namespace lib
{
    class noncopyable
    {
    public:
        noncopyable() = default;
        noncopyable(const noncopyable &) = delete;
        noncopyable &operator=(const noncopyable &) = delete;
        virtual ~noncopyable() = default;
    };
}