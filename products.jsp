<%@page import="dao.ProductDao"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Product" %>
<%@ page import="model.User" %>
<%@ page session="true" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Products - ShardaBazaar</title>

    <style>
        /* --- GLOBAL & NAVBAR STYLES (COPIED FROM PREVIOUS PAGES) --- */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(135deg, #f6f8ff, #e3f2fd);
            color: #111827;
        }
        a {
            text-decoration: none;
        }

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
            padding: 6px 14px;
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

        /* PAGE WRAPPER */
        .page-wrapper {
            width: 100%;
            min-height: calc(100vh - 60px);
            padding: 35px 5%;
        }

        /* --- PRODUCT GRID STYLES --- */
        .products-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 30px;
            margin-top: 25px;
        }

        .product-card {
            background: #ffffff;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 10px 20px rgba(15,23,42,0.1);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            text-align: center;
            overflow: hidden;
            animation: fadeUp 0.6s ease-out;
            height: 100%; /* Ensure all cards are same height */
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }
        .product-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 30px rgba(15,23,42,0.15);
        }

        .product-image {
            width: 100%;
            max-width: 180px;
            height: 180px;
            object-fit: contain;
            border-radius: 8px;
            margin-bottom: 15px;
            border: 1px solid #e5e7eb;
        }

        .product-info h3 {
            font-size: 18px;
            color: #0f172a;
            margin-bottom: 5px;
        }
        .product-info p {
            font-size: 15px;
            color: #4b5563;
            margin-bottom: 15px;
            font-weight: 600;
        }
        .product-info strong {
             color: #2563eb; /* Theme blue for price */
             font-size: 17px;
        }

        /* BUTTONS */
        .action-button {
            display: block;
            width: 100%;
            padding: 10px 0;
            border-radius: 999px;
            border: none;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s ease;
        }

        .add-to-cart-btn {
            background: linear-gradient(135deg,#2563eb,#38bdf8); /* Theme Blue Gradient */
            color: #ffffff;
            box-shadow: 0 4px 12px rgba(37,99,235,0.3);
        }
        .add-to-cart-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 15px rgba(37,99,235,0.4);
        }

        .login-btn {
            background: #9ca3af; /* Grey for login prompt */
            color: #ffffff;
        }
        .login-btn:hover {
            background: #6b7280;
            transform: translateY(-1px);
        }
        
        /* Checkout Link Button */
        .checkout-link {
            display: inline-block;
            margin-top: 30px;
            padding: 12px 30px;
            background: linear-gradient(135deg, #10b981, #059669); /* Green Gradient for Checkout */
            color: white;
            text-decoration: none;
            border-radius: 999px;
            font-size: 16px;
            font-weight: 600;
            box-shadow: 0 8px 20px rgba(16, 185, 129, 0.35);
            transition: all 0.2s ease;
        }
        .checkout-link:hover {
            transform: translateY(-2px);
            box-shadow: 0 12px 26px rgba(16, 185, 129, 0.45);
        }

        /* Animation */
        @keyframes fadeUp {
            from { opacity: 0; transform: translateY(20px); }
            to   { opacity: 1; transform: translateY(0); }
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
                User loggedInUser = (User) session.getAttribute("user");
                if (loggedInUser != null) { 
            %>
                <a href="logout.jsp"><button class="nav-btn">Logout (<%= loggedInUser.getName() %>)</button></a>
            <% } else { %>
                <a href="login.jsp"><button class="nav-btn">Login</button></a>
                <a href="register.jsp"><button class="nav-btn">Register</button></a>
            <% } %>
        </div>
    </div>

    <div class="page-wrapper">
        <h2 style="text-align: center; color: #0f172a; margin-bottom: 30px;">Available Products</h2>

        <% 
            List<Product> products = ProductDao.getAllProducts();
            if (products != null && !products.isEmpty()) {
        %>
            <div class="products-grid">
                <% for (Product product : products) { %>
                    <div class="product-card">
                        <div class="product-info">
                            <img src="<%= product.getImage() %>" alt="<%= product.getName() %>" class="product-image" loading="lazy">
                            <h3><%= product.getName() %></h3>
                            <p>Price: <strong>$<%= String.format("%.2f", product.getPrice()) %></strong></p>
                        </div>
                        
                        <div class="product-actions">
                            <% if (loggedInUser != null) { %>
                                <a href="AddToCartServlet?productId=<%= product.getId() %>" class="action-button add-to-cart-btn">Add to Cart</a>
                            <% } else { %>
                                <a href="login.jsp" class="action-button login-btn">Login to Add to Cart</a>
                            <% } %>
                        </div>
                    </div>
                <% } %>
            </div>
            
            <% if (loggedInUser != null) { %>
                <div style="text-align: center;">
                    <a href="cart.jsp" class="checkout-link">View Cart / Proceed to Checkout</a>
                </div>
            <% } %>

        <% } else { %>
            <div style="text-align: center; padding: 50px; color: #6b7280; background: #ffffff; border-radius: 12px; box-shadow: 0 10px 20px rgba(0,0,0,0.05);">
                <p>Sorry, no products are currently available.</p>
            </div>
        <% } %>

    </div>

</body>
</html>