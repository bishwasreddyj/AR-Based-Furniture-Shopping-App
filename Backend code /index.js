

const express = require('express');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const cors = require('cors');
const { MongoClient, ObjectId } = require('mongodb');

const MONGO_URI = 'mongodb+srv://arfurnitureapp:wyEGNVPVfYnSfFnv@arfurniture.qhkgv8u.mongodb.net/';
const JWT_SECRET = 'fW7^3k@1z$L9vQm#Ht4N%jXp!rZ2uSe8';

const app = express();
const PORT = parseInt(process.env.PORT) || 3000;

app.use(cors());
app.use(express.json());

let db;
   
// 🔌 Connect to MongoDB
async function connectDB() {
  const client = new MongoClient(MONGO_URI);
  await client.connect();
  db = client.db('furniture_app');
  console.log('MongoDB connected');
}

// 🔐 Auth middleware
function authMiddleware(req, res, next) {
  const token = req.headers.authorization?.split(' ')[1];
  if (!token) return res.status(401).json({ error: 'No token provided' });
  try {
    const decoded = jwt.verify(token, JWT_SECRET);
    req.userId = decoded.id;
    next();
  } catch {
    res.status(401).json({ error: 'Invalid token' });
  }
}

// 📝 Register
app.post('/register', async (req, res) => {
  console.log("/register");
  const { email, password } = req.body;

console.log(email, password);
  const existing = await db.collection('users').findOne({ email });
  if (existing) return res.status(400).json({ error: 'Email already exists' });

  const hash = await bcrypt.hash(password, 10);
  await db.collection('users').insertOne({ email, password: hash, cart: [] });
  res.status(200).json({ message: 'User registered' });
});

// 🔑 Login
app.post('/login', async (req, res) => {
  const { email, password } = req.body;
  const user = await db.collection('users').findOne({ email });
  if (!user || !(await bcrypt.compare(password, user.password))) {
    return res.status(400).json({ error: 'Invalid credentials' });
  }
  const token = jwt.sign({ id: user._id }, JWT_SECRET);
  res.status(200).json({ token });
});

// 👤 Get user data
app.get('/userdata', authMiddleware, async (req, res) => {
  const user = await db.collection('users').findOne({ _id: new ObjectId(req.userId) });
  if (!user) return res.status(404).json({ error: 'User not found' });
  res.json({ email: user.email, cart: user.cart });
});

// 🛒 Get cart
app.get('/cart', authMiddleware, async (req, res) => {
  const user = await db.collection('users').findOne({ _id: new ObjectId(req.userId) });
  if (!user) return res.status(404).json({ error: 'User not found' });

  const productIds = user.cart.map(id => new ObjectId(id));
  const cartProducts = await db.collection('products').find({ _id: { $in: productIds } }).toArray();

  res.json(cartProducts);
});
// ➕ Add to cart
app.post('/addtocart', authMiddleware, async (req, res) => {
  const { productId } = req.body;
  await db.collection('users').updateOne(
    { _id: new ObjectId(req.userId) },
    { $addToSet: { cart: productId } }
  );
  res.json({ message: 'Product added to cart' });
});

// ❌ Remove a product from cart
app.post('/removefromcart', authMiddleware, async (req, res) => {
  const { productId } = req.body;

  if (!productId) return res.status(400).json({ error: 'productId is required' });

  try {
    await db.collection('users').updateOne(
      { _id: new ObjectId(req.userId) },
      { $pull: { cart: productId } }
    );
    res.json({ message: 'Product removed from cart' });
  } catch (err) {
    res.status(500).json({ error: 'Failed to remove product from cart' });
  }
});

// 📦 get all product
app.get('/getallproducts', async (req, res) => {
  try {
    const products = await db.collection('products').find().toArray();
    res.json(products);
  } catch (err) {
    res.status(500).json({ error: 'Failed to fetch products' });
  }
});

// 📦 Add product
app.post('/addproduct', async (req, res) => {
  const { title, description, price, images, arModel } = req.body;
  const product = { title, description, price, images, arModel };
  const result = await db.collection('products').insertOne(product);
  res.status(201).json({ id: result.insertedId, ...product });
});


// 🧪 Add sample product to DB
app.get('/addsampleproduct', async (req, res) => {
  const sampleProduct = {
    title: "Barton Sofa",
    description: `A chair is a piece of furniture designed for a single person to sit on, typically featuring a seat, backrest, and legs. 
Key Characteristics of a Chair:
Seat: The flat or slightly angled surface that the person sits on.
Backrest: Provides support for the person's back. 
Legs: Usually four legs to provide stability and support. 
Material: Chairs can be made of various materials, such as wood, metal, or synthetic materials.
Upholstery: May be padded or upholstered in different fabrics and colors.
Types of Chairs:`,
    price: 23.8,
    images: [
      "https://atlas-content-cdn.pixelsquid.com/stock-images/mid-century-modern-chair-WyLz5ZC-600.jpg"
    ],
    arModel: "https://gallery.yopriceville.com/var/albums/Free-Clipart-Pictures/Furniture-PNG/Arm_Chair_PNG_Clipart_Image.png?m=1629803149"
  };

  try {
    const result = await db.collection('products').insertOne(sampleProduct);
    res.status(201).json({ message: 'Sample product added', id: result.insertedId });
  } catch (err) {
    res.status(500).json({ error: 'Failed to add sample product' });
  }
});


// 🔥 Start server
connectDB().then(() => {
  app.listen(PORT, () => console.log(`Server running on http://localhost:${PORT}`));
});
