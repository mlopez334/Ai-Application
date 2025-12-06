<!doctype html>
<html lang="en">

<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" />
    <title>Set Username</title>
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

        form {
            background-color: white;
            gap: 15px;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }

        input[type="text"] {
            padding: 12px 15px;
            width: 250px;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 6px;
        }

        button {
            padding: 10px;
            font-size: 16px;
            width: 200px;
            border: none;
            background: lightgrey;
            color: black;
            border-radius: 6px;
            cursor: pointer;
            display: block;
            margin: 0 auto;
        }

        button:hover {
            background: gray;
            color: white;
        }


    </style>
</head>

<header class="navbar sticky-top d-none d-sm-flex bg-success">
    <div class="container-fluid">
        <div class="title mx-auto">
            <img src="images/logo.png" height="40">
            <a href="/home">Recipe Maker</a>
        </div>

    </div>
</header>

<body style = "background-color: lightgray;">
<br/><div class = "h1 text-center">Change Username</div><br/>
<form method="post" action="/changeUsername" class = "mx-auto text-center col-6" style = "min-width: 300px;">
    <input type="text" required = "e" name="username" placeholder="New Username"><br>
    <br/>
    <button>Change Username</button>
    <br/>
    <a href = "profile"><button type = "button">Cancel</button></a>
</form>
</body>
</html>