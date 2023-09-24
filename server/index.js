const express = require('express');
const app = express();
const http = require('http');
const PORT =  process.env.PORT|| 4000;
const server = http.createServer(app);
const { Server } = require("socket.io");
const io = new Server(server);

const mongoose = require('mongoose');
const Room = require('./models/room');
const { REPL_MODE_SLOPPY } = require('repl');

const DB = "mongodb+srv://Ankit:Ankit123@cluster0.vjwi9kc.mongodb.net/?retryWrites=true&w=majority";

app.use(express.json());

io.on("connection", (socket) => {
    console.log("connected!", socket.id);   
    socket.on("createRoom", async ({ nickname }) => {
        try
        {
        let room = new Room();
        let player = {
            socketId: socket.id,
            nickname,
            playertype: 'X'
        };
        room.players.push(player);
        room.turn = player
            room = await room.save();
            // console.log(room);
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
                console.log("Please Enter valid room id ");
                return;
            }
            let room = await Room.findById(roomId);
            if(room.isJoin==true)
           { let player = {
                socketId: socket.id,
                nickname,
                playertype: 'O'
                
            };
                socket.join(roomId);
                room.players.push(player);
                room.isJoin = false;
                room = await room.save();
                // console.log(room);
                io.to(roomId).emit("joinRoomSuccess", room);
                io.to(roomId).emit("updatePlayers", room.players);
                io.to(roomId).emit("updateRoom",room);
            }
            
            else {
                socket.emit("error", "The game is in progress ,try again later")
                console.log('The game is in progress ,try again later');
            }
        
        }
        catch (e) {
            console.log(e);
        }
    })
    socket.on("tap", async ({ roomId, index }) => {
    try
      {  let room = await Room.findById(roomId);
        let choice = room.turn.playertype;
        if (room.turnIndex == 0) {
            room.turnIndex = 1;
            room.turn = room.players[1];
        }
        else {
            room.turnIndex = 0;
            room.turn = room.players[0];
        }
        room = await room.save();
        io.to(roomId).emit("tapped", {
            index,
            choice,
            room
        });
    }
    catch (e) {
        console.log(e);
        }
    })
    socket.on("winner", async ({ winnerSocketId, roomId }) => {
        try {
            let room = await Room.findById(roomId);
            let winner = room.players.find((player) => player.socketId == winnerSocketId);
            winner.points += 1;
            room = await room.save();
            if (winner.points >= room.maxRounds) {
                socket.emit("endgame", winner);
            }
            else {
                socket.emit("pointIncrease", winner);
            }
            
        } catch (e) {
            console.log(e);
        }
    })
});

mongoose.connect(DB).then(() => {
    console.log("connected successfully")
}).catch(e => {
    console.log("hi");
});

server.listen(PORT, "0.0.0.0", async () => {
    console.log("server started and running on port " + PORT);
});
