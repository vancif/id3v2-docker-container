# -------- Stage 1: build --------
FROM debian:bookworm-slim AS builder

RUN apt-get update && \
    apt-get install -y git clang zlib1g-dev && \
    git clone https://github.com/rstemmer/libprinthex.git && \
    cd libprinthex && \
    ./build.sh && \
    ./install.sh && \
    cd .. && \
    git clone https://github.com/rstemmer/id3edit.git && \
    cd id3edit && \
    ./build.sh && \
    ./install.sh && \
    apt-get install -y id3v2

# -------- Stage 2: runtime --------
FROM debian:bookworm-slim

# Copy built binaries from builder
COPY --from=builder /usr/bin/id3v2 /usr/bin/id3v2
COPY --from=builder /usr/local/bin/id3edit /usr/local/bin/id3edit

# Copy required libraries
COPY --from=builder /lib/aarch64-linux-gnu/libid3-3.8.so.3 /lib/aarch64-linux-gnu/libid3-3.8.so.3
COPY --from=builder /lib/aarch64-linux-gnu/libstdc++.so.6 /lib/aarch64-linux-gnu/libstdc++.so.6
COPY --from=builder /lib/aarch64-linux-gnu/libgcc_s.so.1 /lib/aarch64-linux-gnu/libgcc_s.so.1
COPY --from=builder /lib/aarch64-linux-gnu/libc.so.6 /lib/aarch64-linux-gnu/libc.so.6
COPY --from=builder /lib/aarch64-linux-gnu/libz.so.1 /lib/aarch64-linux-gnu/libz.so.1
COPY --from=builder /lib/aarch64-linux-gnu/libm.so.6 /lib/aarch64-linux-gnu/libm.so.6
COPY --from=builder /lib/ld-linux-aarch64.so.1 /lib/ld-linux-aarch64.so.1

RUN mkdir /music

WORKDIR /music

CMD ["bash"]
