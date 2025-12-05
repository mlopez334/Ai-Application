<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" />
    <title>Register</title>
</head>
<body>

<header class="navbar d-none d-sm-flex bg-success px-4 py-2">

    <div class="mx-auto fs-1">
        <img src="images/logo.png" height="40">
        Recipe Maker
    </div>
    <a href="/" class="btn btn-warning col-lg-auto" role="button" aria-disabled="true">Cancel</a>
    <a href="login" class="btn btn-secondary col-lg-auto bg-info" role="button" aria-disabled="true">Login</a>


</header>
<main class="container-fluid text-center" style="background-color: #f9f9f9;">
    <div class = "mt-5 mb-5" >
        <h1>Create Account</h1>
    </div>

    <form method="post" action="/newAccount">
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            Email: <input type="text" name="email" required><br/><br/>

            Password: <input type="password" name="password" required><br/><br/>
            <button type="submit">Create Account</button>
        </form>
</main>
</body>
</html>