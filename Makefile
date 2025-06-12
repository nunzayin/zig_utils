help:
	@echo "Usage:"
	@echo "	make clean - clean all cache and output results"

clean:
	rm -rvf ./*/\.zig-cache ./*/zig-out
