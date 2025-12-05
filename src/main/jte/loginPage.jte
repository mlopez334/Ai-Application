<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta
            name="viewport"
            content="width=device-width, initial-scale=1, shrink-to-fit=no"
    />
    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
            rel="stylesheet"
            integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
            crossorigin="anonymous"
    />
    <link
            rel="stylesheet"
            href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css"
    />
    <title>Login Page</title>
    <style>
        body {
            overflow-x: hidden;
        }
        header {
            font-size: 50px;
            border-bottom: black 2px solid;
        }

        header a:hover {
            transform: scale(1.05);
        }
        .title,
        .title a {
            font-size: 40px;
            list-style: none;
            color: black;
            text-decoration: none;
        }
        .title:hover {
            transform: scale(1.05);
        }
        h1 {
            font-size: 50px;
            font-family: Arial, Helvetica, sans-serif;
            text-align: center;
            margin-top: 20px;
            margin-bottom: 20px;
        }
        form,
        p {
            max-width: 400px;
            margin: 0 auto;
            padding: 20px;
            background-color: #f9f9f9;
        }

        footer {
            position: fixed;
            height: 200px;
        }
    </style>
</head>

<body>
<header class="navbar d-none d-sm-flex bg-success px-4 py-2">
    <div class="mx-auto title">
        <img src="images/logo.png" height="40" />
        <a>Recipe Maker</a>
    </div>
</header>
<h1>Login</h1>

<form method="post" action="/login">
    <label for="username">Username:</label><br />
    <input type="text" id="username" name="username" size="40" required/><br /><br />

    <label for="password">Password:</label><br />
    <input
            type="password"
            id="password"
            name="password"
            size="40"
            required
    /><br /><br />
    <input type="submit" value="Log In" />
</form>

<p>
    <a href="createAccount">Create Account</a>
</p>

<footer
        class="d-flex justify-content-center align-items-center position-relative"
>
    <span><h2>Copyright &copy; Recipe Maker 2024</h2></span>
</footer>

<script
        src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"
></script>
</body>
</html>
