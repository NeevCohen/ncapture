#include "sniffer.hpp"

#include <iostream>

#include <net/ethernet.h>

int main()
{
    try
    {
        lib::Sniffer sniffer("en0");
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