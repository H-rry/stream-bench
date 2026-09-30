CC = gcc
CFLAGS = -O3 -fopenmp -Wall

# For STREAM, the arrays must be significantly larger than the Last Level Cache (LLC).
# 100,000,000 elements = ~2.2 GB of total memory used.
# If you run out of memory, lower this number. If you have huge cache, increase it.
DEFINES = -DSTREAM_ARRAY_SIZE=100000000

# Optional: To use NVIDIA HPC SDK (nvc) instead of gcc, uncomment this:
# CC = nvc
# CFLAGS = -fast -mp

all: stream

stream: stream.c
	$(CC) $(CFLAGS) $(DEFINES) stream.c -o stream

run: stream
	@mkdir -p results
	@echo "Running benchmark and saving output..."
	./stream | tee results/stream_run_$$(date +%Y-%m-%d_%H-%M-%S).txt

clean:
	rm -f stream
