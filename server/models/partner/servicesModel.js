const mongoose = require('mongoose');

const partnerSchema = new mongoose.Schema({
    name: {
        type: String
    },
    description: {
        type: String
    }
});
module.exports = mongoose.model("Services", partnerSchema);