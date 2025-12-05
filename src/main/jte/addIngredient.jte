<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous" />
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" />
        <title>Add Ingredient</title>
        <style>

            .titletext {
                display: flex;
                justify-content: space-between;
                align-items: flex-start;
                padding: 15px;
                border-bottom: 2px solid black;
            }

            /* clickable title */
            .title, .title a{
                font-size: 40px;
                list-style: none;
                color: black;
                text-decoration: none;
            }
            .title:hover{
                transform: scale(1.05);
            }

        </style>
    </head>

    <body style = "background: lightgray;">

        <header class = "bg-success titletext">
            <div class = "col-md-2"></div>
            <div class="title col-md-8 text-center">
                <img src="images/logo.png" height="40">
                <a href = "home"> Recipe Maker</a>
            </div>
            <div class = "col-md-2 text-end">
                <a href="/inventory" class="btn btn-secondary col-lg-auto bg-warning" role="button" aria-disabled="true">Inventory</a>
            </div>
        </header>


        <div class = "text-center">
            <h1 class = "p-3">Add Ingredient</h1>
            <form action="/addIngredientPage" method="post">
                <input class = "p-3 text-center form-control-sm" type="text" name="name" placeholder="Ingredient name" required>
                <input class = "p-3 text-center form-control-sm" type="text" name="quantity" placeholder="Quantity" style="width: 100px;" required><br><br>
                <button type="submit">Add Ingredient</button>
            </form>
        </div>
    </body>
</html>
`