# BASTOS-EDI Docker Setup

This Docker configuration provides a complete BASTOS-EDI environment with:
- Debian 13 Linux base image (lightweight)
- BASTOS binary for Minitel emulation
- WebSocat for WebSocket connectivity
- vsftpd FTP server for file transfers
- Python3 HTTP server for the SPA
- esptool for ESP device programming

## Network Mode

The container runs with **host network mode**, which means services are directly accessible on the host machine's ports without port mapping. This provides better performance and simpler networking configuration.

## Services

### FTP Server (vsftpd)
- **Port:** 2121
- **Authentication:** Anonymous login only
- **Access:** Read/Write to `/data/bastos` folder
- **Passive Mode:** Ports 30000-30100

### Web Server (BASTOS-EDI SPA)
- **Port:** 9000
- **URL:** `http://localhost:9000`
- **Features:** Code editor, Minitel viewer, file upload/download

### WebSocket Server (WebSocat)
- **Port:** 1967 (internal only, linked to BASTOS)
- **Purpose:** Real-time communication between SPA and Minitel emulator

## Quick Start

### Using Docker Compose (Recommended)

```bash
# Build and start the container
docker-compose up -d

# View logs
docker-compose logs -f

# Stop the container
docker-compose down

# Stop and remove all data
docker-compose down -v
```

### Using Docker directly

```bash
# Build the image
docker build -t bastos-edi .

# Run the container (with host network mode)
docker run -d \
  --network host \
  -v bastos-data:/data/bastos \
  --name bastos-edi \
  bastos-edi
```

**Note:** The `--network host` flag is used to match the docker-compose configuration, allowing services to run directly on the host's network interface.

## Accessing the Services

### Web Browser
- Open `http://localhost:9000` to access the BASTOS-EDI SPA

### FTP Client
- Use any FTP client to connect
  - **Host:** localhost
  - **Port:** 2121
  - **Username:** anonymous
  - **Password:** anonymous (or empty)
  - **Folder:** /

## Volume Mapping

- **bastos-data:** Persistent storage for BASTOS files (mounted at `/data/bastos` in container)
- **disk:** Local folder synced with container `/app/disk`

## Environment Variables

Currently, no environment variables need to be set. The configuration is hardcoded, but can be extended if needed.

## Troubleshooting

### Connection refused on port 2121
- Ensure the container is running: `docker-compose ps`
- Check logs: `docker-compose logs`
- Allow firewall access to port 2121

### Cannot write to FTP
- Verify proper permissions on the bastos-data volume
- Check vsftpd logs in container: `docker-compose logs`

### Port already in use
- Change port mappings in `docker-compose.yml`
- Kill existing processes: `lsof -i :2121` then `kill <PID>`

## File Structure

```
/app/
├── app/              # JavaScript application code
├── css/              # Stylesheets
├── font/             # Font files
├── icon/             # Icons
├── import/           # HTML imports
├── library/          # Third-party libraries (CodeMirror, x-minitel, etc.)
├── sound/            # Audio files
├── disk/             # Upload/download directory
├── index.html        # Main SPA page
├── bastos-edi.py     # Python web server
└── bastos-edi.sh     # Startup script

/data/bastos/         # FTP accessible directory for file storage
```

## Building from Source

The Dockerfile expects the following in your working directory:
- Compiled `bastos` binary
- `bastos-edi.py` and `bastos-edi.sh` scripts
- SPA folders: app, css, font, icon, import, library, sound
- `index.html`

## Performance Notes

- Uses Debian 13 slim image (~170MB)
- WebSocket connection runs on localhost:1967 (internal)
- FTP passive mode requires ports 30000-30100 to be open

## License

Match the license of the BASTOS project.
