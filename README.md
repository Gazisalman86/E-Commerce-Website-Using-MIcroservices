## Ecommerce-Website
This project is a fully functional **E-Commerce Web Application** built using **Java (Servlets & JSP)**, **JDBC**, and **MySQL**.  
It supports all core features of an online shopping platform including **user authentication**, **product management**, **shopping cart**, and **payment workflow**.

## Features

### User Module
- User Registration
- Secure Login
- Session-based authentication
- Profile details stored in MySQL

### Product Module
- View all available products
- Search & filter products (optional)
- Add product details (Admin functionality)
- Edit / Delete products
- Product images support

### Shopping Cart
- Add items to cart
- Remove items from cart
- Update quantity
- View total price
- Session-based cart system

### Payment Module
- Checkout page
- Order summary
- Payment integration (dummy payment or COD)
- Stores order details in the database

## Tech Stack

| Layer | Technology |
|------|------------|
| Frontend | HTML, CSS, JSP, Bootstrap |
| Backend | Java Servlets, JSP, JDBC |
| Database | MySQL |
| Server | Apache Tomcat |
| Build Tool | Maven (optional) |

## Project Structure

/src
 ├── controller (Servlets)
 ├── dao (Database operations)
 ├── model (Java Beans)
 ├── views (JSP files)
 └── util (DB connection)

/webapp
 ├── css
 ├── js
 ├── images
 └── WEB-INF

## Installation & Setup

1. Clone the Repository
git clone https://github.com/Gazisalman86/E-Commerce-Website-Using-MIcroservices

2. Import to IDE
- Open Eclipse / IntelliJ
- Select Import → Existing Maven Project or Dynamic Web Project

3. Configure Database
CREATE DATABASE ecommerce;

Update DBConnection.java with your credentials.

4. Deploy on Tomcat
Visit:
http://localhost:8080/Ecommerce/

## Core Functionalities Working Properly
- Register User
- Login User
- Add Product
- Remove Product
- Add to Cart
- Remove from Cart
- Checkout System
- Payment Flow
- Fully Connected with MySQL

## Author
**Salman Gazi**

