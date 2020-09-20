# as_test

In HDL folder, it's hardware design VHDL code files, as figure below shown.

![image](https://github.com/qiaosiyi/qiaosiyi.github.io/blob/master/figs/bpu2.jpg)

An opensourced packet generator can be find in the project of [PacketGenerator](https://github.com/NetFPGA/netfpga/wiki/PacketGenerator).

The key contribution in PL part is dispatch module that is combined from (1)input_arb.v, (2)crossbar.v and (3)selector.v.

Also, we implemented the key module in SS, such as (1)MMU.v.

The packet generator: (1)pcapparser1gbtest.v, the packet data is read from PCAP files.

Besides, other important modules are the data bus converter (1)c8to512.v, (2)lookup.v.

Use cases: (1)statefull.v (2)ndp48.v (3)ndpqs.v (4)measure.v




The SA-based heuristic algorithm is following the processing graph below.

![image](https://github.com/qiaosiyi/qiaosiyi.github.io/blob/master/figs/saprocess.png)

The algorithm is implemented in heuristic.py file.

