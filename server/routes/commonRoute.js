const express = require("express");
const ServicesModel = require("../models/partner/servicesModel");
const commonRouter = express.Router();

commonRouter.get("/api/getCategories", async (req, res) => {
  try {
    const categories = await ServicesModel.find({});
    console.log(categories);
    res.status(200).json({ categories });
  } catch (error) {
    console.log(error);
  }
});

commonRouter.post("/api/addCategory", async (req, res) => {
  try {
    const { category } = req.body;
    let categories = new ServicesModel({ name: category });
    await categories.save();

    res.status(201).json({ msg: "category added sucessfully." });
  } catch (error) {
    console.log(error);
    res.status(400).json({ msg: error.message });
  }
});

module.exports = commonRouter;
