const express = require('express');
const app = express();
const http = require('http');
const PORT =  3000;
const server = http.createServer(app);
const { Server } = require("socket.io");
const io = new Server(server);

const mongoose = require('mongoose');
const Room = require('./models/room');

const DB = "mongodb+srv://Ankit:Ankit123@cluster0.vjwi9kc.mongodb.net/?retryWrites=true&w=majority";

app.use(express.json());

io.on("connection", (socket) => {
    console.log("connected!", socket.id);
    socket.on("createRoom", async ({ nickname }) => {
        try
        {console.log("hello");
        let room = new Room();
        let player = {
            socketId: socket.id,
            nickname,
            playertype: 'X'
        };
        room.players.push(player);
        room.turn = player
            room = await room.save();
            console.log(room);
        const roomId = room._id.toString();
        socket.join(roomId);//so that If we emit out data it will go to only in this room not others one
        //io->send data to everyone
        // socket->sending data to yourself
            io.to(roomId).emit('createRoomSuccess', room);
        }
        catch (e) {
            console.log(e);
        }
    })
    socket.on("joinRoom", async({
        nickname,roomId
    }) => {
        try {
            if (!roomId.match(/^[0-9a-fA-F]{24}$/)) {
                socket.emit("error", "Please Enter valid room id ")//Here socket is user instead of io because we want to send message to ourselves
                return;
            }
            let room = await Room.findById(roomId);
            if(room.isJoin)
           { let player = {
                socketId: socket.id,
                nickname,
                playertype: 'O'
                
            };
                socket.join(roomId);
                room.players.push(player);
                room.isJoin = false;
                room = await room.save();
                io.to(roomId).emit("join Room success", room);
            }
            
            else {
                socket.emit("error","The game is in progress ,try again later")
            }
        
        }
        catch (e) {
            console.log(e);
        }
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
