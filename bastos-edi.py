#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
BASTOS-EDI Server
Serves the BASTOS-EDI SPA and handles file uploads via PUT requests.
"""

import http.server
import socketserver
import os
import json
from urllib.parse import urlparse
from pathlib import Path

# Configuration
PORT = 9000
DISK_FOLDER = 'disk'

# Create disk folder if it doesn't exist
Path(DISK_FOLDER).mkdir(exist_ok=True)


class BastosEDIHandler(http.server.SimpleHTTPRequestHandler):
    """
    HTTP request handler for BASTOS-EDI server.
    Serves static files and handles PUT requests for file uploads.
    """

    def do_PUT(self):
        """Handle PUT requests to save files."""
        parsed_path = urlparse(self.path)

        if parsed_path.path.startswith('/bastos/'):
            # Extract filename from URL
            filename = parsed_path.path[len('/bastos/'):]

            if not filename:
                self.send_error(400, "Filename is required")
                return

            # Prevent directory traversal
            if '..' in filename or filename.startswith('/'):
                self.send_error(400, "Invalid filename")
                return

            try:
                # Read content length
                content_length = int(self.headers.get('Content-Length', 0))

                # Read the request body
                body = self.rfile.read(content_length)

                # Save file to disk folder
                file_path = os.path.join(DISK_FOLDER, filename)

                # Create subdirectories if needed
                os.makedirs(os.path.dirname(file_path) or '.', exist_ok=True)

                with open(file_path, 'wb') as f:
                    f.write(body)

                # Send success response
                self.send_response(200)
                self.send_header('Content-Type', 'application/json')
                self.send_header('Access-Control-Allow-Origin', '*')
                self.end_headers()

                response = {
                    'status': 'success',
                    'message': f'File {filename} saved successfully',
                    'path': file_path
                }
                self.wfile.write(json.dumps(response).encode())
                print(f"✓ File saved: {file_path}")

            except Exception as e:
                self.send_error(500, f"Error saving file: {str(e)}")
                print(f"✗ Error saving file: {str(e)}")
        else:
            self.send_error(404, "Not found")

    def do_DELETE(self):
        """Handle DELETE requests to remove files."""
        parsed_path = urlparse(self.path)

        if parsed_path.path.startswith('/bastos/'):
            # Extract filename from URL
            filename = parsed_path.path[len('/bastos/'):]

            if not filename:
                self.send_error(400, "Filename is required")
                return

            # Prevent directory traversal
            if '..' in filename or filename.startswith('/'):
                self.send_error(400, "Invalid filename")
                return

            try:
                # Construct file path
                file_path = os.path.join(DISK_FOLDER, filename)

                # Check if file exists
                if not os.path.exists(file_path):
                    self.send_error(404, "File not found")
                    return

                # Delete the file
                os.remove(file_path)

                # Send success response
                self.send_response(200)
                self.send_header('Content-Type', 'application/json')
                self.send_header('Access-Control-Allow-Origin', '*')
                self.end_headers()

                response = {
                    'status': 'success',
                    'message': f'File {filename} deleted successfully'
                }
                self.wfile.write(json.dumps(response).encode())
                print(f"✓ File deleted: {file_path}")

            except Exception as e:
                self.send_error(500, f"Error deleting file: {str(e)}")
                print(f"✗ Error deleting file: {str(e)}")
        else:
            self.send_error(404, "Not found")

    def do_GET(self):
        """Handle GET requests for serving static files."""
        # Serve index.html for root path
        if self.path == '/' or self.path == '':
            self.path = '/index.html'

        return super().do_GET()

    def end_headers(self):
        """Add CORS headers to all responses."""
        self.send_header('Access-Control-Allow-Origin', '*')
        self.send_header('Access-Control-Allow-Methods', 'GET, PUT, OPTIONS')
        self.send_header('Access-Control-Allow-Headers', 'Content-Type')
        super().end_headers()

    def do_OPTIONS(self):
        """Handle CORS preflight requests."""
        self.send_response(200)
        self.send_header('Content-Type', 'text/plain')
        self.end_headers()
        self.wfile.write(b'OK')


def run_server(port=PORT):
    """Start the HTTP server."""
    handler = BastosEDIHandler

    # Use allow_reuse_address to avoid "Address already in use" errors
    socketserver.TCPServer.allow_reuse_address = True

    with socketserver.TCPServer(("", port), handler) as httpd:
        print(f"🚀 BASTOS-EDI Server started on http://localhost:{port}")
        print(f"📁 Disk folder: {os.path.abspath(DISK_FOLDER)}")
        print(f"🌐 Press Ctrl+C to stop the server")
        try:
            httpd.serve_forever()
        except KeyboardInterrupt:
            print("\n🛑 Server stopped")


if __name__ == '__main__':
    run_server()
