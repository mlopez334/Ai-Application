<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" />
    <title>Landing Page</title>
    <style>
        body {
            overflow-x: hidden;


        }
        header{
            font-size: 50px;
            border-bottom: black 2px solid;

        }

        header a:hover{
            transform:scale(1.05);
        }
        .title, .title a{
            font-size: 40px;
            list-style: none;
            color: black;
            text-decoration: none;
        }
        .title:hover{
            transform: scale(1.05);
        }


        #logo {
            width: 300px;
            display: block;
            margin-left: auto;
            margin-right: auto;
        }

        footer{
            border-top: 2px solid black;
            height: 200px;
        }


    </style>
</head>

<body>
<!-- <body class="container">
  <div id="header" class="row d-flex justify-content-between align-items-center">
    <h2 class="col-lg-auto text-center">Recipe Maker</h2>
    <a href="#" class="btn btn-secondary col-lg-auto" tabindex="-1" role="button" aria-disabled="true">Login</a>
  </div> -->
<header class="navbar d-none d-sm-flex bg-success px-4 py-2">

    <div class="mx-auto title">
        <img src="images/logo.png" height="40">
        <a>Recipe Maker</a>
    </div>
    <a href="login" class="btn btn-secondary col-lg-auto bg-info" role="button" aria-disabled="true">Login</a>


</header>

<!-- main -->
<main class="container-fluid px-4 py-4">
    <img src="images/logo.png" id="logo" />
    <div>
        <h3>About Us</h3>
        <p>
            We are a team of food enthusiasts dedicated to bringing you the best
            recipes from around the world. Whether you're a beginner or a seasoned
            chef, our platform offers something for everyone. Join us on a
            culinary journey and discover new flavors and techniques to elevate
            your cooking skills using an AI assistant.
        </p>
    </div>
    <div>
        <h3>Goals & Vision</h3>
        <p class="mb-2">
            Our goal is to make cooking simple, fun, and accessible to everyone.
            We strive to create a space where creativity in the kitchen thrives,
            offering easy to follow recipes, personalized recommendations, and
            step by step guidance powered by AI. Our vision is to become a trusted
            companion for home cooks and professional chefs alike helping people
            explore diverse cuisines, reduce food waste through smart meal
            planning, and build confidence in theirir culinary journey. We aim to
            inspire a community where food brings people together, one recipe at a
            time.
        </p>
    </div>

</main>

<footer class="d-flex justify-content-center align-items-center position-relative">
    <div class="position-absolute start-0 ps-3 text-start">
        <h3>Contact Us:</h3>
        <ul class="list-unstyled mb-0">
            <li><a href="#">Email</a></li>
            <li><a href="#">Instagram</a></li>
            <li><a href="#">Twitter</a></li>
        </ul>
    </div>
    <span><h2>Copyright &copy; Recipe Maker 2024</h2></span>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>
</body>

</html>
