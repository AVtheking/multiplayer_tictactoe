const mongoose = require('mongoose');
const playerSchema = require('./player');
const roomSchema = mongoose.Schema({
    occupancy: {
        type: Number,
        default:2
    },
    maxRounds: {
        type: Number,
        default:5
    },
    currentRound: {
        required: true,
        type: Number,
        default:1
    },
    players: [playerSchema],
    isJoin: {
        type: Boolean,
        default:true
    },
})