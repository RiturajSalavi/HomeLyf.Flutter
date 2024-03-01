const express = require("express");
const Partner = require("../../models/partner/partner");
const bcryptjs = require("bcryptjs");

const partnerRouter = express.Router();
const jwt = require("jsonwebtoken");

const partner = require("../../middlewares/partnerMiddelware");
const { sendEmail, generateOTP } = require("../../services/util");
const otpVerification = require("../../models/common/otpModel");
const googleAuthRouter = require("./googleAuthRoute");

partnerRouter.use(googleAuthRouter);

const swaggerJSDoc = require("swagger-jsdoc");
const swaggerUI = require("swagger-ui-express");

const options = {
  definition: {
    openapi: "3.0.0",
    info: {
      title: "HomeLyf API Testing",
      version: "1.0.0",
    },
    servers: [
      {
        url: "https://demo-homelyf.onrender.com",
      },
    ],
  },
  apis: ["./auth.js"], // files containing annotations as above
};

const swaggerSpec = swaggerJSDoc(options);
partnerRouter.use("/api-docs", swaggerUI.serve, swaggerUI.setup(swaggerSpec));

/**
 * @swagger
 * /sp/sendEmail-otp-partner:
 *   post:
 *     summary: Send OTP via email
 *     tags:
 *       - Partner
 *     description: Send OTP to the provided email address for verification.
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               email:
 *                 type: string
 *                 description: The email address of the Partner.
 *                 example: partner@example.com
 *     responses:
 *       200:
 *         description: OTP sent successfully
 *       401:
 *         description: Failed to send OTP
 *       400:
 *         description: Partner with same email or mobile already exists!
 */
partnerRouter.post("/sp/sendEmail-otp-partner", async (req, res) => {
  try {
    const { email, mobile } = req.body;
    const existingPartner = await Partner.findOne({
      email: email,
    });
    if (existingPartner) {
      return res
        .status(400)
        .json({ msg: "User with same email or mobile already exists!" });
    } else {
      const OTP = generateOTP();
      const otpBody = await otpVerification.create({ email: email, otp: OTP });
      console.log(otpBody);

      res.status(200).json({ msg: "OTP sent succesfully" });
    }
  } catch (error) {
    console.log(error);
    res.status(401).json({ msg: "Failed to send OTP." });
  }
});

// authRouter.post("/api/verify-otp", async (req, res) => {
//   try {
//     const { email, otp } = req.body;

//     // Fetch the latest OTP from the database
//     const latestOTP = await otpVerification
//       .find({ email })
//       .sort({ createdAt: -1 })
//       .limit(1);

//     if (latestOTP.length === 0 || otp !== latestOTP[0].otp) {
//       return res.status(400).json({
//         success: false,
//         message: "Invalid OTP.",
//       });
//     }

//     // OTP is valid, you can proceed with user authentication
//     res.json({ success: true, message: "OTP verified successfully." });
//   } catch (e) {
//     res.status(500).json({ error: e.message });
//   }
// });

/**
 * @swagger
 * /sp/verify-otp-partner:
 *   post:
 *     summary: Verify OTP
 *     tags:
 *       - Partner
 *     description: Verify the OTP sent to the partner's email address.
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               email:
 *                 type: string
 *                 description: The email address of the partner.
 *                 example: partner@example.com
 *               otp:
 *                 type: string
 *     responses:
 *       200:
 *         description: OTP verified successfully
 *       400:
 *         description: Invalid OTP
 */
partnerRouter.post("/sp/verify-otp-partner", async (req, res) => {
  const { email, otp } = req.body;

  try {
    const response = await otpVerification
      .find({ email })
      .sort({ createdAt: -1 })
      .limit(1);

    if (response.length === 0 || otp !== response[0].otp) {
      return res.status(400).json({
        success: false,
        message: "The OTP is not valid",
      });
    }

    // OTP is valid, you can perform additional actions here if needed
    console.log(email);
    console.log(otp);
    return res.status(200).json({
      success: true,
      message: "OTP verification successful",
    });
  } catch (error) {
    console.error(error);
    return res.status(500).json({
      success: false,
      message: "Internal server error",
    });
  }
});

/**
 * @swagger
 * /sp/signup-partner:
 *   post:
 *     summary: Partner Sign Up
 *     tags:
 *       - Partner
 *     description: Register a new Partner account.
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               name:
 *                 type: string
 *                 description: The name of the Partner.
 *                 example: PartnerName PartnerSurname
 *               email:
 *                 type: string
 *                 description: The email address of the Partner.
 *                 example: partner@example.com
 *               mobile:
 *                 type: string
 *                 description: The mobile no. of the Partner.
 *                 example: 0000000000
 *               serviceCategory:
 *                 type: array
 *                 description: The name of the Partner.
 *                 example: [{"name": "Plumbing","description": "Fixing plumbing issues"},{"name": "Electrical","description": "Electrical installations and repairs"}]
 *               aadharCard:
 *                 type: string
 *                 description: The name of the Partner.
 *                 example: PartnerName PartnerSurname
 *               address:
 *                 type: string
 *                 description: The name of the Partner.
 *                 example: PartnerName PartnerSurname
 *               experience:
 *                 type: string
 *                 description: The name of the Partner.
 *                 example: PartnerName PartnerSurname
 *               password:
 *                 type: string
 *               otp:
 *                 type: string
 *     responses:
 *       200:
 *         description: Partner signed up successfully
 *       400:
 *         description: Invalid data or partner already exists
 */
partnerRouter.post("/sp/signup-partner", async (req, res) => {
  try {
    const {
      name,
      email,
      mobile,
      serviceCategory,
      aadharCard,
      address,
      experience,
      password,
      otp,
    } = req.body;
    console.log(req.body, typeof otp);

    const existingPartner = await Partner.findOne({
      $or: [{ email: email }, { mobile: mobile }, { aadharCard: aadharCard }],
    });
    if (existingPartner) {
      return res
        .status(400)
        .json({ msg: "User with same email or mobile already exists!" });
    }

    const response = await otpVerification
      .find({ email })
      .sort({ createdAt: -1 })
      .limit(1);
    console.log("otp is :", response);
    if (response.length === 0) {
      return res.status(400).json({
        success: false,
        msg: "The OTP is not valid",
      });
    } else if (otp != response[0].otp) {
      return res.status(400).json({
        success: false,
        msg: "The OTP is not valid",
      });
    }

    const hashedPassword = await bcryptjs.hash(password, 8);

    let partner = new Partner({
      name,
      email,
      mobile,
      serviceCategory,
      aadharCard,
      address,
      experience,
      password: hashedPassword,
    });
    partner = await partner.save();
    await sendEmail(
      email,
      "",
      "",
      "welcome to homeLyf services. You are registered as a partner."
    );

    const token = jwt.sign({ id: partner.email }, process.env.JWT_KEY_PARTNER);

    res.json({ token, ...partner._doc });
  } catch (e) {
    console.log(e);
    res.status(500).json({ error: e.message });
  }
});

/**
 * @swagger
 * /sp/signin-partner:
 *   post:
 *     summary: Partner Sign In
 *     tags:
 *       - Partner
 *     description: Authenticate a partner and generate an access token.
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               email:
 *                 type: string
 *                 description: The email address of the partner.
 *                 example: partner@example.com
 *               password:
 *                 type: string
 *     responses:
 *       200:
 *         description: Partner signed in successfully
 *       400:
 *         description: Incorrect email or password
 */
partnerRouter.post("/sp/signin-partner", async (req, res) => {
  try {
    const { email, password } = req.body;

    const partner = await Partner.findOne({ email });
    if (!partner) {
      return res
        .status(400)
        .json({ msg: "User with this email does not exist!" });
    }

    const isMatch = await bcryptjs.compare(password, partner.password);
    if (!isMatch) {
      return res.status(400).json({ msg: "Incorrect password." });
    }
    console.log(process.env.JWT_KEY_PARTNER);
    const token = jwt.sign({ id: partner._id }, process.env.JWT_KEY_PARTNER);
    res.json({ token, ...partner._doc });
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

/**
 * @swagger
 * /sp/sendEmail-forgotPassword-otp-partner:
 *   post:
 *     summary: Send OTP via email For forgot password
 *     tags:
 *       - Partner
 *     description: Send OTP to the provided email address for verification.
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               email:
 *                 type: string
 *                 description: The email address of the partner.
 *                 example: partner@example.com
 *     responses:
 *       200:
 *         description: OTP sent successfully
 *       401:
 *         description: Failed to send OTP
 *       400:
 *         description: Partner with this email doesn't exist!
 */
partnerRouter.post(
  "/sp/sendEmail-forgotPassword-otp-partner",
  async (req, res) => {
    try {
      const { email, mobile } = req.body;
      const existingPartner = await Partner.findOne({
        email: email,
      });

      if (existingPartner) {
        const OTP = generateOTP();
        const otpBody = await otpVerification.create({
          email: email,
          mobile: mobile,
          otp: OTP,
        });
        console.log(otpBody);

        res.status(200).json({ msg: "OTP sent succesfully" });
      } else {
        return res
          .status(400)
          .json({ msg: "Partner with this email doesn't exist!" });
      }
    } catch (error) {
      console.log(error);
      res.status(401).json({ msg: "Failed to send OTP." });
    }
  }
);

/**
 * @swagger
 * /sp/forgotpassword-partner:
 *   post:
 *     summary: Forgot Password
 *     tags:
 *       - Partner
 *     description: Reset the partner's password using OTP.
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               email:
 *                 type: string
 *                 description: The email address of the partner.
 *                 example: partner@example.com
 *               newPassword:
 *                 type: string
 *               otp:
 *                 type: string
 *     responses:
 *       200:
 *         description: Password updated successfully
 *       400:
 *         description: Invalid email, OTP, or failed to update password
 */
partnerRouter.post("/sp/forgotpassword-partner", async (req, res) => {
  try {
    const { email, newPassword, otp } = req.body;
    console.log(email, newPassword, otp);
    if (!email || !newPassword || !otp) {
      return res.status(400).json({ msg: "Enter valid email or password." });
    }

    const existingPartner = await Partner.findOne({
      $or: [{ email: email }],
    });
    console.log(existingPartner);
    if (existingPartner == null || existingPartner.length == 0) {
      return res.status(400).json({ msg: "User with email does not exist.." });
    }

    const response = await otpVerification
      .find({ email })
      .sort({ createdAt: -1 })
      .limit(1);
    console.log("otp is :", response);
    if (!response || response.length == 0 || response[0].otp !== otp) {
      return res.status(400).json({ msg: "Failed to verify otp." });
    }

    const hashedPassword = await bcryptjs.hash(newPassword, 8);
    let doc = await Partner.findOneAndUpdate(
      { email: email },
      { password: hashedPassword }
    );
    console.log("updated : ", doc);
    if (!doc || doc.length == 0) {
      return res.status(400).json({ msg: "Failed to update password." });
    }

    return res.status(200).json({ msg: "Password updated successfully." });
  } catch (error) {
    console.log(error);
    return res.status(400).json({ msg: "Failed to update password" });
  }
});

partnerRouter.post("/sp/tokenIsValid-partner", async (req, res) => {
  try {
    const token = req.header("x-auth-token");
    if (!token) return res.json(false);
    const verified = jwt.verify(token, process.env.JWT_KEY_PARTNER);
    if (!verified) return res.json(false);

    const partner = await Partner.findById(verified.id);
    if (!partner) return res.json(false);
    res.json(true);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

partnerRouter.get("/sp/get-partner-data", partner, async (req, res) => {
  const partner = await Partner.findById(req.partner);
  res.json({ ...partner._doc, token: req.token });
});

module.exports = partnerRouter;
