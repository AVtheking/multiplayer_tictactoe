const mongoose = require('mongoose');

const playerSchema = mongoose.Schema({
    nickname: {
        type: String,
        trim: true,
    },
    socketId: {
        type: String,
        
    },
    points: {
        type: Number,
        default: 0
    },
    playertype: {
        required: true,
        type: String,
    }
});
module.exports = playerSchema;