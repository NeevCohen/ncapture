#include "if_utils.hpp"
#include "string_utils.hpp"

#include <memory>

#include <sys/types.h>
#include <sys/socket.h>
#include <ifaddrs.h>

std::vector<std::string> get_interfaces_names() noexcept
{
    try
    {
        auto deleter = [](ifaddrs **addrs)
        {
            if (addrs == nullptr)
            {
                return;
            }
            freeifaddrs(*addrs);
        };

        std::unique_ptr<ifaddrs *, decltype(deleter)> interfaces(new ifaddrs *, deleter);

        if (getifaddrs(interfaces.get()) != 0)
        {
            throw std::runtime_error(string_format("Failed to get list of network interfaces (errno: %d)", errno));
        }

        std::vector<std::string> result{};
        ifaddrs *current = (*interfaces);
        while (current != nullptr)
        {
            result.push_back(current->ifa_name);
            current = current->ifa_next;
        }

        return result;
    }
    catch (...)
    {
        return {};
    }
}