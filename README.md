# 🛒 Shopping Cart App (Flutter + Firebase)

[![MIT License](https://img.shields.io/badge/license-MIT-green)](LICENSE)

## 📱 Overview

A simple **Shopping Cart application** with buyer and seller modules, built using **Flutter** and integrated with **Firebase Firestore** for real-time database management.

---

## ✨ Features

- 👤 **Buyer Module**
  - View products in real-time
  - Add products to cart with quantity selection
  - Checkout cart items

- 🛍️ **Seller Module**
  - Add new products
  - Update existing products
  - Delete products
  - Manage inventory

---

## 🚀 Setup Instructions

1. **Clone the repository**

   ```bash
   git clone https://github.com/callmeNoorulHuda/Flutter-Shopping-App
   cd Flutter-Shopping-App

```

2. **Install dependencies**

   ```bash
   flutter pub get
   ```

3. **Firebase Configuration**

    * Create a project in Firebase Console.
    * Enable Authentication (Email/Password) and Cloud Firestore.
    * Download your Firebase config files and add them:

      ```
      android/app/google-services.json
      ios/Runner/GoogleService-Info.plist
      ```

4. **Run the app**

   ```bash
   flutter run
   ```

> ⚠️ 🔑 Note: google-services.json and GoogleService-Info.plist are ignored for security. Add your own from Firebase Console after setup.
---

## 📂 Folder Structure

```
lib/
┣ authorize/           # Authentication and authorization       
┣ models/              # Data models (Product, CartItem)
┣ ui/
┃ ┣ screens/
┃ ┃ ┣ buyer/           # Buyer screens
┃ ┃ ┗ seller/          # Seller screens
┣ widgets/             # Login screen and splash screen
┗ main.dart            # App entry point
```

---

## 🛠️ Technologies Used
- **Flutter – Frontend UI development**

- **Firebase Authentication – User login and signup**

- **Cloud Firestore – Real-time database**

- **Dart – Programming language for Flutter apps**

## 📸 Screenshots

### 🖼️ **App Logo**

<p align="center">
  <img src="assets/screenshots/app_logo.jpg" alt="App Logo" width="246"/>
</p>

### 🖼️ **Login Screen**
<p align="center">
  <img src="assets/screenshots/app_logo.jpg" alt="Login Screen" width="246"/>
</p>

### 🔑 **Authentication Screens**

| Buyer Login                                                                    | Seller Login                                                                    |
|--------------------------------------------------------------------------------|---------------------------------------------------------------------------------|
| <img src="assets/screenshots/login_screen.jpg" alt="Buyer Login" width="250"/> | <img src="assets/screenshots/seller_login.jpg" alt="Seller Login" width="250"/> |

---

### 🛒 **Buyer Module**

| Home Screen                                                                 | Add to Cart                                                                   | Cart Screen                                                                   |
|-----------------------------------------------------------------------------|-------------------------------------------------------------------------------|-------------------------------------------------------------------------------|
| <img src="assets/screenshots/buyer_home.jpg" alt="Buyer Home" width="250"/> | <img src="assets/screenshots/add_to_cart.jpg" alt="Add to Cart" width="250"/> | <img src="assets/screenshots/cart_screen.jpg" alt="Cart Screen" width="250"/> |

| Remove Item                                                                   | Checkout                                                                              | Checkout Complete                                                                 |
|-------------------------------------------------------------------------------|---------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------|
| <img src="assets/screenshots/remove_item.jpg" alt="Remove Item" width="250"/> | <img src="assets/screenshots/checkout_screen.jpg" alt="Checkout Screen" width="250"/> | <img src="assets/screenshots/checkout_done.jpg" alt="Checkout Done" width="250"/> |

---

### 🏪 **Seller Module**

| Seller Home                                                                   | Add Product                                                                   | Edit Product                                                                    |
|-------------------------------------------------------------------------------|-------------------------------------------------------------------------------|---------------------------------------------------------------------------------|
| <img src="assets/screenshots/seller_home.jpg" alt="Seller Home" width="250"/> | <img src="assets/screenshots/add_product.jpg" alt="Add Product" width="250"/> | <img src="assets/screenshots/edit_product.jpg" alt="Edit Product" width="250"/> |

---


## 🎬 Demo

[![Watch the demo on LinkedIn](https://img.shields.io/badge/Watch%20Demo-LinkedIn-blue?logo=linkedin)](YOUR_LINKEDIN_POST_URL)

> Click to view the full app demo on LinkedIn.

---

## 🤝 Contributing

```
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.
```

