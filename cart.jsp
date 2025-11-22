<%@ page import="java.util.List" %>
<%@ page import="model.CartItem" %>
<%@ page session="true" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Shopping Cart - ShardaBazaar</title>

    <style>
        /* --- STYLES COPIED FROM login.jsp --- */
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
            display: flex;
            justify-content: center;
            align-items: flex-start; /* Aligned to start to allow card to grow */
            padding: 35px 15px;
        }

        .card {
            background: #ffffff;
            width: 100%;
            max-width: 900px; /* Wider card for table */
            padding: 28px 26px;
            border-radius: 22px;
            box-shadow: 0 20px 40px rgba(15,23,42,0.15);
            animation: fadeUp 0.6s ease-out;
            position: relative;
            overflow: hidden;
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
        .card-header p {
            font-size: 14px;
            color: #6b7280;
        }

        /* Animation */
        @keyframes fadeUp {
            from { opacity: 0; transform: translateY(20px); }
            to   { opacity: 1; transform: translateY(0); }
        }
        /* --- END STYLES COPIED FROM login.jsp --- */


        /* --- CART SPECIFIC STYLES --- */
        table {
            width: 100%;
            border-collapse: separate; /* Use separate for rounded corners */
            border-spacing: 0;
            margin-top: 25px;
            overflow: hidden; /* For border-radius on table */
            box-shadow: 0 4px 10px rgba(0,0,0,0.05);
        }
        th, td {
            padding: 14px 10px;
            text-align: left;
            border-bottom: 1px solid #e5e7eb;
            color: #374151;
            font-size: 14px;
        }
        th {
            background: #f9fafb;
            font-weight: 600;
            color: #111827;
            text-transform: uppercase;
        }
        /* Style for total row */
        tr:last-child td {
            border-bottom: none;
            font-weight: 700;
            background: #eff6ff; /* Light blue background for emphasis */
            color: #1f2937;
        }
        td:nth-child(4), td:nth-child(5) { /* Quantity and Total columns */
            text-align: center;
        }
        td:nth-child(3) { /* Price column */
             text-align: right;
        }
        tr:hover {
            background-color: #f5f7fa;
        }
        .cart-image {
            width: 50px;
            height: 50px;
            object-fit: cover;
            border-radius: 8px;
            border: 1px solid #e5e7eb;
        }

        .empty-cart-message {
            text-align: center;
            padding: 40px 20px;
            font-size: 16px;
            color: #6b7280;
        }
        
        .action-cell {
            text-align: center;
        }

        /* Action Buttons */
        .remove-btn {
            padding: 6px 12px;
            background: #ef4444; /* Red color */
            color: white;
            border: none;
            border-radius: 6px;
            font-size: 13px;
            cursor: pointer;
            transition: background 0.2s ease, transform 0.2s ease;
        }
        .remove-btn:hover {
            background: #dc2626;
            transform: translateY(-1px);
        }

        .checkout-container {
            margin-top: 25px;
            display: flex;
            justify-content: flex-end;
            gap: 15px;
        }

        .checkout-btn {
            padding: 10px 20px;
            background: linear-gradient(135deg, #10b981, #059669); /* Green Gradient */
            color: white;
            text-decoration: none;
            border-radius: 999px;
            font-size: 15px;
            font-weight: 600;
            box-shadow: 0 8px 15px rgba(16, 185, 129, 0.3);
            transition: all 0.2s ease;
        }
        .checkout-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 12px 20px rgba(16, 185, 129, 0.4);
        }
        .continue-shopping-btn {
            padding: 10px 20px;
            background: #6b7280;
            color: white;
            text-decoration: none;
            border-radius: 999px;
            font-size: 15px;
            font-weight: 600;
            transition: all 0.2s ease;
        }
        .continue-shopping-btn:hover {
            background: #4b5563;
        }

        @media (max-width: 600px) {
            .card {
                padding: 22px 18px;
            }
            th, td {
                padding: 10px 6px;
                font-size: 12px;
            }
            .checkout-container {
                flex-direction: column;
                align-items: stretch;
            }
            .checkout-btn, .continue-shopping-btn {
                text-align: center;
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
            <a href="login.jsp"><button class="nav-btn">Login</button></a>
            <a href="register.jsp"><button class="nav-btn">Register</button></a>
        </div>
    </div>

    <div class="page-wrapper">
        <div class="card">
            <div class="card-header">
                <h2>Your Shopping Cart</h2>
                <p>Review and finalize your order</p>
            </div>
            
            <%
                List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
                if (cart == null || cart.isEmpty()) {
            %>
                <div class="empty-cart-message">
                    <p>Your cart is currently empty.</p>
                    <a href="products.jsp" class="continue-shopping-btn" style="margin-top: 15px; display: inline-block;">Continue Shopping</a>
                </div>
            <%
                } else {
            %>

            <table>
                <thead>
                    <tr>
                        <th>Product</th>
                        <th>Image</th>
                        <th style="text-align: right;">Price</th>
                        <th style="text-align: center;">Quantity</th>
                        <th style="text-align: center;">Total</th>
                        <th style="text-align: center;">Action</th>
                    </tr>
                </thead>
                <tbody>
                <%
                    double totalAmount = 0;
                    for (CartItem item : cart) {
                        double subtotal = item.getProduct().getPrice() * item.getQuantity();
                        totalAmount += subtotal;
                %>
                <tr>
                    <td><%= item.getProduct().getName() %></td>
                    <td><img src="<%= request.getContextPath() + "/" + item.getProduct().getImage() %>" alt="<%= item.getProduct().getName() %>" class="cart-image"></td>
                    <td style="text-align: right;">$<%= String.format("%.2f", item.getProduct().getPrice()) %></td>
                    <td style="text-align: center;"><%= item.getQuantity() %></td>
                    <td style="text-align: center;">$<%= String.format("%.2f", subtotal) %></td>
                    <td class="action-cell">
                        <a href="RemoveFromCartServlet?productId=<%= item.getProduct().getId() %>" class="remove-btn">Remove</a>
                    </td>
                </tr>
                <%
                    }
                %>
                </tbody>
                <tfoot>
                    <tr>
                        <td colspan="4" style="text-align: right;"><strong>Grand Total:</strong></td>
                        <td style="text-align: center;"><strong>$<%= String.format("%.2f", totalAmount) %></strong></td>
                        <td></td>
                    </tr>
                </tfoot>
            </table>

            <div class="checkout-container">
                <a href="products.jsp" class="continue-shopping-btn">Continue Shopping</a>
                <a href="checkout.jsp" class="checkout-btn">Proceed to Checkout</a>
            </div>
            <%
                }
            %>
        </div>
    </div>

</body>
</html>