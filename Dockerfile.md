Create a Dockerfile with :

- Linux image based on a light debian 13 without GUI with bash and python3
- The esp-tool utility
- vsftpd sharing a subfolder "bastos", anonymous login only, read / write operation
- The bastos binary in this repo
- The websocat binary on this system
- The bastos-edi.* scripts
- SPA in this repo : app, css, font, icon, import, library and sound folders and
  index.html

Create a compose file to be able to launch the image in a container :

- start the vsftpd server in the docker, must be accessible from the host on
  port 2121
- Start the bastos-edi.sh script and share the port 9000 to allow the host to
  access the SPA
