<%@ page import="model.User" %>
<%@ page session="true" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<head>
    <title>Home - eCommerce</title>
    <style>
        /* Global */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(135deg, #f6f8ff, #e3f2fd);
            color: #222;
        }
        a {
            text-decoration: none;
        }

        /* Navbar */
        .nav {
            background: #111827;
            padding: 12px 5%;
            display: flex;
            align-items: center;
            justify-content: space-between;
            position: sticky;
            top: 0;
            z-index: 100;
            box-shadow: 0 2px 8px rgba(0,0,0,0.25);
        }
        .nav-left {
            display: flex;
            align-items: center;
            gap: 12px;
        }
        .logo {
            font-size: 22px;
            font-weight: bold;
            color: #38bdf8;
            letter-spacing: 1px;
        }
        .nav-links {
            display: flex;
            gap: 18px;
        }
        .nav-links a {
            color: #e5e7eb;
            font-size: 15px;
            position: relative;
            padding-bottom: 3px;
        }
        .nav-links a::after {
            content: "";
            position: absolute;
            left: 0;
            bottom: 0;
            width: 0;
            height: 2px;
            background: #38bdf8;
            transition: width 0.3s ease;
        }
        .nav-links a:hover::after {
            width: 100%;
        }
        .nav-right {
            display: flex;
            align-items: center;
            gap: 10px;
            color: #e5e7eb;
            font-size: 14px;
        }
        .nav-btn {
            border: 1px solid #38bdf8;
            border-radius: 20px;
            padding: 5px 14px;
            font-size: 13px;
            background: transparent;
            color: #e5e7eb;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        .nav-btn:hover {
            background: #38bdf8;
            color: #0b1120;
            transform: translateY(-1px);
        }

        /* Container / Hero */
        .container {
            width: 90%;
            max-width: 1100px;
            margin: 0 auto;
            padding: 40px 0 60px 0;
        }
        .hero {
            display: grid;
            grid-template-columns: 1.2fr 1fr;
            gap: 30px;
            align-items: center;
            min-height: 70vh;
            animation: fadeInUp 0.8s ease-out;
        }
        .hero-text h1 {
            font-size: 40px;
            line-height: 1.2;
            margin-bottom: 16px;
            color: #0f172a;
        }
        .hero-text h1 span {
            color: #2563eb;
        }
        .hero-text p {
            font-size: 16px;
            color: #4b5563;
            margin-bottom: 24px;
        }
        .hero-buttons {
            display: flex;
            gap: 12px;
        }
        .btn-primary {
            background: linear-gradient(135deg,#2563eb,#38bdf8);
            border: none;
            padding: 12px 22px;
            border-radius: 999px;
            font-size: 15px;
            color: white;
            cursor: pointer;
            font-weight: bold;
            box-shadow: 0 8px 20px rgba(37,99,235,0.3);
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 12px 28px rgba(37,99,235,0.4);
        }
        .btn-secondary {
            background: white;
            border: 1px solid #d1d5db;
            padding: 12px 22px;
            border-radius: 999px;
            font-size: 15px;
            color: #111827;
            cursor: pointer;
            font-weight: 500;
            transition: background 0.2s ease, transform 0.2s ease;
        }
        .btn-secondary:hover {
            background: #e5e7eb;
            transform: translateY(-2px);
        }

        /* Hero image / card */
        .hero-card {
            background: white;
            border-radius: 24px;
            padding: 22px;
            box-shadow: 0 20px 40px rgba(15,23,42,0.12);
            position: relative;
            overflow: hidden;
        }
        .hero-tag {
            display: inline-block;
            font-size: 12px;
            padding: 4px 10px;
            border-radius: 999px;
            background: #ecfeff;
            color: #0e7490;
            margin-bottom: 10px;
        }
        .hero-product {
            margin: 18px 0;
        }
        .hero-product-title {
            font-weight: 600;
            margin-bottom: 4px;
        }
        .hero-product-price {
            color: #16a34a;
            font-weight: bold;
            margin-bottom: 6px;
        }
        .hero-product-text {
            font-size: 13px;
            color: #6b7280;
        }
        .hero-badge {
            position: absolute;
            top: 16px;
            right: 16px;
            background: #22c55e;
            color: white;
            padding: 6px 10px;
            border-radius: 999px;
            font-size: 11px;
            font-weight: bold;
            box-shadow: 0 8px 16px rgba(34,197,94,0.4);
            animation: pulse 1.6s infinite;
        }

        /* Message */
        .message {
            color: #16a34a;
            font-weight: bold;
            margin-top: 18px;
            padding: 10px 16px;
            border-radius: 10px;
            background: #ecfdf3;
            display: inline-block;
            animation: fadeIn 0.4s ease-out;
        }

        /* Highlights section */
        .highlights {
            margin-top: 40px;
            display: grid;
            grid-template-columns: repeat(3, minmax(0, 1fr));
            gap: 18px;
        }
        .highlight-card {
            background: white;
            border-radius: 18px;
            padding: 16px;
            box-shadow: 0 8px 18px rgba(15,23,42,0.08);
            font-size: 14px;
            color: #4b5563;
            text-align: left;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }
        .highlight-card h3 {
            font-size: 15px;
            margin-bottom: 6px;
            color: #111827;
        }
        .highlight-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 14px 28px rgba(15,23,42,0.15);
        }

        /* Animations */
        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(15px); }
            to   { opacity: 1; transform: translateY(0); }
        }
        @keyframes pulse {
            0%, 100% { transform: scale(1); }
            50%      { transform: scale(1.05); }
        }
        @keyframes fadeIn {
            from { opacity: 0; }
            to   { opacity: 1; }
        }

        /* Responsive */
        @media (max-width: 800px) {
            .hero {
                grid-template-columns: 1fr;
                text-align: center;
            }
            .hero-buttons {
                justify-content: center;
            }
            .hero-card {
                margin-top: 10px;
            }
            .highlights {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>

    <div class="nav">
        <div class="nav-left">
            <div class="logo">ShardaBazaar</div>
            <div class="nav-links">
                <a href="index.jsp">Home</a>
                <a href="products.jsp">Products</a>
                <a href="cart.jsp">Cart</a>
            </div>
        </div>

        <div class="nav-right">
            <%
                User user = (User) session.getAttribute("user");
                if (user != null) {
            %>
                <span>Welcome, <%= user.getName() %></span>
                <a href="logout.jsp"><button class="nav-btn">Logout</button></a>
            <%
                } else {
            %>
                <a href="login.jsp"><button class="nav-btn">Login</button></a>
                <a href="register.jsp"><button class="nav-btn">Register</button></a>
            <%
                }
            %>
        </div>
    </div>

    <div class="container">
        <!-- HERO SECTION -->
        <div class="hero">
            <div class="hero-text">
                <h1>
                    Your <span>One-Stop</span> Online Shopping Destination
                </h1>
                <p>
                    Discover trending gadgets, fashion, and home essentials with fast delivery,
                    secure payments, and exclusive deals tailored just for you.
                </p>
                <div class="hero-buttons">
                    <a href="products.jsp">
                        <button class="btn-primary">Shop Now</button>
                    </a>
                    <a href="products.jsp">
                        <button class="btn-secondary">View Deals</button>
                    </a>
                </div>

                <% 
                    String message = (String) session.getAttribute("message");
                    if (message != null) {
                %>
                    <p class="message"><%= message %></p>
                <%
                        session.removeAttribute("message");
                    }
                %>
            </div>

            <div class="hero-card">
                <div class="hero-badge">🔥 Today’s Pick</div>
                <span class="hero-tag">Up to 50% OFF</span>

                <div class="hero-product">
                    <div class="hero-product-title">Wireless Noise-Cancelling Headphones</div>
                    <div class="hero-product-price">₹3,499</div>
                    <div class="hero-product-text">
                        Crisp sound, deep bass, 30-hour battery, and ultra-soft ear cushions.
                        Perfect for work, travel, and entertainment.
                    </div>
                </div>

                <a href="products.jsp">
                    <button class="btn-primary" style="width:100%; margin-top:10px;">Grab This Deal</button>
                </a>
            </div>
        </div>

        <!-- HIGHLIGHTS SECTION -->
        <div class="highlights">
            <div class="highlight-card">
                <h3>Fast & Secure Delivery</h3>
                <p>Get your orders delivered quickly with real-time tracking and trusted couriers.</p>
            </div>
            <div class="highlight-card">
                <h3>Best Price Guarantee</h3>
                <p>Exclusive discounts, seasonal offers, and combo deals every single day.</p>
            </div>
            <div class="highlight-card">
                <h3>Safe Payments</h3>
                <p>Multiple payment options with secure encryption and hassle-free refunds.</p>
            </div>
        </div>
    </div>

</body>
</html>
