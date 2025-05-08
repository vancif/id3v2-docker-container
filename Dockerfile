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

# Optionally, copy libs if they were installed in /usr/local/lib
COPY --from=builder /usr/local/lib/ /usr/local/lib/
COPY --from=builder /lib/aarch64-linux-gnu/ /lib/aarch64-linux-gnu/

CMD ["bash"]
