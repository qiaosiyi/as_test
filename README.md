# as_test

In HDL folder, there are the hardware design VHDL code files.

The key contribution in PL part is dispatch module that is combined from input_arb.v, crossbar.v and selector.v.

Also, we implemented the key module in SS, such as MMU.v.

The packet gen: pcapparser1gbtest.v, the packet data is read from PCAP files.

Besides, other important modules are the data bus converter c8to512.v, lookup.v.

Use cases: statefull.v ndp48.v ndpqs.v measure.v



The Flow Entry Allocation (FEA) algorithm is implemented in heuristic.py file.
