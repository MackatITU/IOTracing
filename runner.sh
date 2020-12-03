
#fio /home/mack/ResearchProject/xnvme/pro-512G/iopath-exp/io_uring/uring.fio > uring.txt &
#fio /home/mack/ResearchProject/xnvme/pro-512G/iopath-exp/laio/laio.fio > laio.txt &
#fio /home/mack/ResearchProject/xnvme/pro-512G/iopath-exp/xnvme_laio/xnvme-laio.fio > xnvme_laio.txt &
fio /home/mack/ResearchProject/xnvme/pro-512G/iopath-exp/sync/sync.fio > sync.txt &
#fio /home/mack/ResearchProject/xnvme/pro-512G/iopath-exp/xnvme_io_uring/xnvme-uring.fio > xnvme_uring.txt &

mypid=$!
sleep 5

#/usr/lib/linux-tools-5.4.0-54/perf stat -a -- sleep 240

#echo "ran stat"
/usr/lib/linux-tools-5.4.0-54/perf record -F 99 -g --call-graph dwarf -p $mypid sleep 240
#echo "ran record"
/usr/lib/linux-tools-5.4.0-54/perf script > out.perf

#fold stacks
./FlameGraph/stackcollapse-perf.pl out.perf > perf.folded

# make svg graph
./FlameGraph/flamegraph.pl perf.folded > kernel.svg
