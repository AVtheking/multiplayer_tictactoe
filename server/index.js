const express = require('express');
const app = express();
const http = require('http');
const PORT =  3000;
const server = http.createServer(app);
const { Server } = require("socket.io");
const io = new Server(server);

const mongoose = require('mongoose');

const DB = "mongodb+srv://Ankit:Ankit123@cluster0.vjwi9kc.mongodb.net/?retryWrites=true&w=majority";

app.use(express.json());

io.on("connection", (socket) => {
    console.log("connected!", socket.id);
    socket.on("createRoom", async ({ nickname }) => {
        console.log("hello");
    })
});

mongoose.connect(DB).then(() => {
    console.log("connected successfully")
}).catch(e => {
    console.log(e);
});

server.listen(PORT, "0.0.0.0", async () => {
    console.log("server started and running on port " + PORT);
});
