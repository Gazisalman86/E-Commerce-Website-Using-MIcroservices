<%@ page session="true" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Product - Admin</title>

    <style>
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

        /* PAGE WRAPPER & CARD */
        .page-wrapper {
            width: 100%;
            min-height: calc(100vh - 60px);
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 35px 15px;
        }

        .card {
            background: #ffffff;
            width: 100%;
            max-width: 500px; /* Slightly wider for form elements */
            padding: 28px 26px;
            border-radius: 22px;
            box-shadow: 0 20px 40px rgba(15,23,42,0.15);
            animation: fadeUp 0.6s ease-out;
            position: relative;
            overflow: hidden;
            text-align: left; /* Align form content */
        }
        .card::before {
            content: "";
            position: absolute;
            width: 160%;
            height: 60px;
            top: -40px;
            left: -20%;
            background: linear-gradient(135deg,#2563eb,#38bdf8);
            opacity: 0.22;
            transform: skewY(-6deg);
        }

        .card-header {
            position: relative;
            z-index: 1;
            text-align: center;
            margin-bottom: 20px;
        }
        .card-header h2 {
            font-size: 24px;
            color: #0f172a;
            margin-bottom: 6px;
        }
        
        /* FORM STYLES */
        .form-group {
            margin-bottom: 14px;
        }
        label {
            font-size: 13px;
            display: block;
            margin-bottom: 6px;
            color: #374151;
            font-weight: 600;
        }
        .input-field, textarea {
            width: 100%;
            padding: 10px 12px;
            border: 1px solid #d1d5db;
            border-radius: 10px;
            font-size: 14px;
            outline: none;
            transition: border 0.2s ease, box-shadow 0.2s ease;
            resize: vertical;
        }
        .input-field:focus, textarea:focus {
            border-color: #2563eb;
            box-shadow: 0 0 0 3px rgba(37,99,235,0.2);
        }
        textarea {
            min-height: 80px;
        }

        /* SUCCESS MESSAGE */
        .success-message {
            color: #10b981; /* Green color for success */
            font-weight: 600;
            padding: 10px;
            background: #ecfdf5;
            border: 1px solid #a7f3d0;
            border-radius: 8px;
            margin-bottom: 15px;
            text-align: center;
        }
        
        /* SUBMIT BUTTON */
        .submit-btn {
            width: 100%;
            padding: 11px 0;
            border-radius: 999px;
            border: none;
            background: linear-gradient(135deg,#2563eb,#38bdf8); /* Theme Blue Gradient */
            color: #ffffff;
            font-size: 15px;
            cursor: pointer;
            font-weight: 600;
            box-shadow: 0 8px 20px rgba(37,99,235,0.35);
            transition: all 0.2s ease;
            margin-top: 15px;
        }
        .submit-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 12px 26px rgba(37,99,235,0.45);
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
            <a href="login.jsp"><button class="nav-btn">Login</button></a>
            <a href="register.jsp"><button class="nav-btn">Register</button></a>
        </div>
    </div>

    <div class="page-wrapper">
        <div class="card">
            <div class="card-header">
                <h2>Add New Product</h2>
            </div>

            <% 
                String message = (String) session.getAttribute("message");
                if (message != null) {
            %>
                <p class="success-message"><%= message %></p>
            <%
                session.removeAttribute("message");
                }
            %>
            
            <form action="AddProductServlet" method="post">
                <div class="form-group">
                    <label for="name">Product Name:</label>
                    <input class="input-field" type="text" id="name" name="name" required>
                </div>

                <div class="form-group">
                    <label for="description">Description:</label>
                    <textarea class="input-field" id="description" name="description" required></textarea>
                </div>

                <div class="form-group">
                    <label for="price">Price:</label>
                    <input class="input-field" type="number" id="price" name="price" step="0.01" required>
                </div>

                <div class="form-group">
                    <label for="image">Image URL:</label>
                    <input class="input-field" type="text" id="image" name="image" required>
                </div>

                <button type="submit" class="submit-btn">Add Product</button>
            </form>
        </div>
    </div>

</body>
</html>