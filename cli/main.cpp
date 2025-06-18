#include "sniffer.hpp"

#include <iostream>

#include <net/ethernet.h>
#include <netinet/tcp.h>
#include <netinet/ip.h>
#include <netinet/if_ether.h>
#include <netinet/in.h>
#include <net/if.h>
#include <arpa/inet.h>

int main()
{
    try
    {
        lib::Sniffer sniffer("en0");
        while (true)
        {
            lib::Buffer capture = sniffer.read_next_capture();

            struct ether_header *eh = (struct ether_header *)capture.data();
            printf(" Ethernet Frame\n");
            printf("  src mac address: %x:%x:%x:%x:%x:%x\n",
                   eh->ether_shost[0],
                   eh->ether_shost[1],
                   eh->ether_shost[2],
                   eh->ether_shost[3],
                   eh->ether_shost[4],
                   eh->ether_shost[5]);

            printf("  dst mac address: %x:%x:%x:%x:%x:%x\n",
                   eh->ether_dhost[0],
                   eh->ether_dhost[1],
                   eh->ether_dhost[2],
                   eh->ether_dhost[3],
                   eh->ether_dhost[4],
                   eh->ether_dhost[5]);
            if (ntohs(eh->ether_type) == ETHERTYPE_IP)
            {
                printf("  type: IPv4, %x\n", eh->ether_type);

                struct ip *ip = (struct ip *)((long)eh + sizeof(struct ether_header));
                printf(" IP Frame\n");
                printf("  headerLength: %d\n", ip->ip_hl * 4);
                printf("  version: %d\n", ip->ip_v);
                printf("  protocol: %d\n", ip->ip_p);
                printf("  ttl: %d\n", ip->ip_ttl);
                printf("  dst ip: %s\n", inet_ntoa(ip->ip_dst));
                printf("  src ip: %s\n", inet_ntoa(ip->ip_src));

                if (ip->ip_p == IPPROTO_TCP)
                {
                    struct tcphdr *tcp = (struct tcphdr *)((long)ip + (ip->ip_hl * 4));
                    printf(" TCP Packet\n");
                    printf("  dst port: %d\n", ntohs(tcp->th_dport));
                    printf("  src port: %d\n", ntohs(tcp->th_sport));
                }
            }
            else
            {
                printf("  type: Other, %x\n", eh->ether_type);
            }
        }
        return EXIT_SUCCESS;
    }
    catch (const std::exception &e)
    {
        std::cerr << "ERROR: " << std::endl
                  << "\t" << e.what() << std::endl;
    }
    catch (...)
    {
        std::cerr << "ERROR: Caught unexpected exception" << std::endl;
    }

    return EXIT_FAILURE;
}