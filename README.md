# 🎵 Docker Image for `id3edit` and `id3v2`

This Docker image provides a ready-to-use environment with the following software preinstalled:

✅ **[`id3edit`](https://github.com/rstemmer/id3edit)** — a command-line tool to edit ID3 tags in MP3 files  
✅ **[`id3v2`](https://linux.die.net/man/1/id3v2)** — standard ID3 tag manipulation tool available from Debian packages

---

## 🏗️ How is this image built?

This image is built in **two stages**:

1. **Build Stage:**
   - Based on `debian:bookworm-slim`
   - Clones, builds, and installs:
     - [`libprinthex`](https://github.com/rstemmer/libprinthex) (dependency)
     - [`id3edit`](https://github.com/rstemmer/id3edit)
   - Installs `id3v2` from Debian repositories

2. **Runtime Stage:**
   - Copies the built binaries (`id3edit` and `id3v2`) into a fresh minimal Debian image
   - Copies any necessary libraries from the build stage to ensure runtime compatibility
   - Uses `bash` as the default command for interactive use

---

## 🚀 Usage

You can run this image interactively:

```bash
docker run -it <your-image-name>
```
Once inside the container, you can use:

```bash
id3edit --help
id3v2 --help
```
to view available options.

## 📝 Notes
id3edit is built from source from the official GitHub repository at [`id3edit`](https://github.com/rstemmer/id3edit).

```id3v2``` is installed from Debian official packages.

The image is based on ```debian:bookworm-slim``` for a small footprint.
