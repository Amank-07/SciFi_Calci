# 🧮 SciFi Calci — Scientific Calculator (Flutter)

A **production-grade scientific calculator** built using **Flutter**, following **Clean Architecture** and modern state management practices.

Designed to demonstrate **scalable architecture, UI/UX problem-solving, and real-world engineering decisions**.

---

## 🚀 Features

### 🔢 Basic Operations

* Addition, Subtraction, Multiplication, Division
* Modulus (%)
* Parentheses support

### 📐 Scientific Functions

* Trigonometry: `sin`, `cos`, `tan`
* Logarithmic: `log`, `ln`
* Roots: `√`, `∛`

### ⚡ Advanced Operations

* Powers: `x²`, `x³`, `xʸ`
* Factorial `!`
* Inverse `1/x`
* Absolute `|x|`

### 🔣 Constants

* π (pi)
* e (Euler’s number)

---

## 🧠 Key Highlights

* 🏗️ **Clean Architecture**

  * Separation into `data`, `domain`, `presentation`
* 🔄 **State Management**

  * Implemented using Provider
* 🧩 **Reusable UI Components**

  * Modular button + display widgets
* 🧮 **Expression Parsing Engine**

  * Powered by `math_expressions`
* 📱 **Tab-Based UI**

  * Solves real-world **overflow issues** on small screens
* 🌗 **Dark / Light Theme Support**
* 🕘 **In-Memory History Tracking**
* 🚀 **Splash Screen Navigation Flow**

---

## 🎯 Engineering Decisions

* Avoided scroll-based hacks → used **TabBar layout for scalability**
* Delegated expression parsing to a library → ensures correctness & extensibility
* Separated UI and logic → improves maintainability

---

## 🏗️ Project Structure

```
lib/
  core/          # constants, utilities
  data/          # repositories, models
  domain/        # entities, use cases
  presentation/  # UI, state, widgets, screens
```

---

## 🛠️ Tech Stack

* Flutter
* Dart
* Provider
* math_expressions

---

## ▶️ Run Locally

```bash
flutter pub get
flutter run
```

---

## 🧪 Testing

```bash
flutter test
flutter analyze
```

---

## 📦 APK Download

👉 [Download APK]([ADD_RELEASE_LINK_HERE](https://tinyurl.com/2w7ppaxb))

---

## 👨‍💻 Author

**Aman Khan**
B.Tech CSE | IIIT Surat

---

## ⭐ If you like this project, consider giving it a star!
