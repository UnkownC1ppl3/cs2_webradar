import { WebSocketServer, WebSocket } from 'ws';
import http from "http";
import url from "url";

console.log("web_server started");

const port = 22006;
const server = http.createServer();
const web_socket_server = new WebSocketServer({
    server: server, path: "/cs2_webradar"
});

// Store clients by User
const Users = {};

web_socket_server.on("connection", (web_socket, request) => {
    const client_address = request.socket.remoteAddress.replace("::ffff:", "");
    const query = url.parse(request.url, true).query;
    const User = query.User || 'default'; // Use 'default' User if none specified

    console.info(`${client_address} connected to User '${User}'`);

    // Initialize the User if it doesn't exist
    if (!Users[User]) {
        Users[User] = new Set();
    }

    // Add the client to the User
    Users[User].add(web_socket);

    web_socket.on("message", (message) => {
        // Broadcast to all clients in the same User
        Users[User].forEach(client => {
            if (client !== web_socket && client.readyState === WebSocket.OPEN) {
                client.send(message);
            }
        });
    });

    web_socket.on("close", () => {
        console.info(`${client_address} disconnected from User '${User}'`);
        // Remove the client from the User
        Users[User].delete(web_socket);
        // Optionally, clean up empty Users
        if (Users[User].size === 0) {
            delete Users[User];
        }
    });

    web_socket.on("error", (error) => {
        console.error(error);
    });
});

server.listen(port);
console.info(`listening on port '${port}'`);
