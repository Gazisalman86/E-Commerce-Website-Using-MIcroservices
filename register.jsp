<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Register - eCommerce</title>
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

        /* NAVBAR (same look as home page) */
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

        /* PAGE LAYOUT */
        .page-wrapper {
            width: 100%;
            min-height: calc(100vh - 60px);
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 30px 15px;
        }

        /* CARD */
        .card {
            background: #ffffff;
            width: 100%;
            max-width: 420px;
            padding: 28px 26px 30px 26px;
            border-radius: 22px;
            box-shadow: 0 20px 40px rgba(15,23,42,0.15);
            animation: slideUp 0.6s ease-out;
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
            opacity: 0.2;
            transform: skewY(-6deg);
        }
        .card-header {
            margin-bottom: 18px;
            position: relative;
            z-index: 1;
        }
        .card-header h2 {
            font-size: 24px;
            color: #0f172a;
            margin-bottom: 4px;
        }
        .card-header p {
            font-size: 14px;
            color: #6b7280;
        }

        /* FORM */
        form {
            position: relative;
            z-index: 1;
        }
        .form-group {
            margin-bottom: 14px;
            text-align: left;
        }
        label {
            display: block;
            font-size: 13px;
            margin-bottom: 5px;
            color: #374151;
        }
        .input-field {
            width: 100%;
            padding: 10px 12px;
            border-radius: 10px;
            border: 1px solid #d1d5db;
            font-size: 14px;
            outline: none;
            transition: border 0.2s ease, box-shadow 0.2s ease, transform 0.1s ease;
        }
        .input-field:focus {
            border-color: #2563eb;
            box-shadow: 0 0 0 3px rgba(37,99,235,0.2);
            transform: translateY(-1px);
        }

        .submit-btn {
            width: 100%;
            margin-top: 8px;
            padding: 11px 0;
            border-radius: 999px;
            border: none;
            background: linear-gradient(135deg,#2563eb,#38bdf8);
            color: #ffffff;
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
            box-shadow: 0 8px 20px rgba(37,99,235,0.35);
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }
        .submit-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 12px 26px rgba(37,99,235,0.45);
        }

        .helper-text {
            margin-top: 12px;
            font-size: 13px;
            text-align: center;
            color: #6b7280;
        }
        .helper-text a {
            color: #2563eb;
            font-weight: 600;
        }
        .helper-text a:hover {
            text-decoration: underline;
        }

        @keyframes slideUp {
            from { opacity: 0; transform: translateY(20px); }
            to   { opacity: 1; transform: translateY(0); }
        }

        @media (max-width: 600px) {
            .card {
                padding: 22px 18px 24px 18px;
            }
        }
    </style>
</head>
<body>

    <!-- NAVBAR (no User object, just static links) -->
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

    <!-- REGISTRATION CARD -->
    <div class="page-wrapper">
        <div class="card">
            <div class="card-header">
                <h2>Create your account</h2>
                <p>Join ShardaBazaar and start shopping smarter today.</p>
            </div>

            <form action="RegisterServlet" method="post">
                <div class="form-group">
                    <label for="name">Full Name</label>
                    <input class="input-field" type="text" id="name" name="name" required="required">
                </div>

                <div class="form-group">
                    <label for="email">Email Address</label>
                    <input class="input-field" type="email" id="email" name="email" required="required">
                </div>

                <div class="form-group">
                    <label for="password">Password Daal le Bhai</label>
                    <input class="input-field" type="password" id="password" name="password" required="required">
                </div>

                <input type="submit" value="Create Account" class="submit-btn">
            </form>

            <div class="helper-text">
                Already have an account?
                <a href="login.jsp">Login here</a>
            </div>
        </div>
    </div>

</body>
</html>
