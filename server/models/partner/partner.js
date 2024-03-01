const mongoose = require('mongoose');
const ServicesModel = require('./servicesModel');

const servicesSchema = new mongoose.Schema({
    name: {
        type: String
    },
    description: {
        type: String
    }
});

const partnerSchema = new mongoose.Schema({
    name: {
        type: String
    },
    email: {
        required: true,
        unique: true,
        type: String,
        trim: true,
    },
    mobile: {
        unique: true,
        type: String
    },
    serviceCategory: [servicesSchema],
    aadharCard: {
        unique: true,
        type: String
    },
    address: {
        type: String,
    },
    experience: {
        type: String
    },
    password: {
        type: String
    },
    type: {
        type: String,
        default: "partner",
    },
});

const Partner = mongoose.model("Partner", partnerSchema);
module.exports = Partner;