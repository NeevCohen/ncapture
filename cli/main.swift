import snifferLib
import CxxStdlib

var sniffer = Sniffer("en0")
print(sniffer.read_next_capture()[0])