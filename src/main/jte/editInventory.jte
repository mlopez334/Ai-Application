@param cs3220.aiapplication.model.IngredientJDBC ingredient
@param String tab
<!doctype html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit ${ingredient.getName()}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
    <!-- in page style sheet -->
    <style>
        body {
            overflow-x: hidden;

            background-color: lightgray;

        }

        header {
            font-size: 50px;
            border-bottom: black 2px solid;
            color: black;
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
        .sidebar .nav-link {
            color: black;
        }
        .sidebar .nav-link:hover {
            background-color: lightgray;
        }

        header.navbar{
            background-color: lightgray;
            color: black;
        }

        /* Show the delete icon when the parent row is hovered */
        tr:hover .delete-icon {
            opacity: 1;
        }
        th, td {
            font-size: large;
        }


    </style>
</head>


    <header class="navbar sticky-top d-none d-sm-flex bg-success">
        <div class="container-fluid">
            <div></div>
            <div class="title">
                &nbsp;
                <img src="/images/logo.png" height="40" alt="[Logo]">
                <a href="/home?tab=${tab}">Recipe Maker</a>
            </div>
            <div></div>
        </div>
    </header>


    <body>

    <br><br><br>
    <div class = "d-flex justify-content-center">
        <div class = "col-6 text-end pe-5 fs-3 ">Item</div><div class = "col-6 ps-5 fs-3">Quantity</div>

    </div>
    <form method="post" class = "text-center">
        <input class = "p-3 text-center form-control-sm" type="text" name="name" value="${ingredient.getName()}">
        <input class = "p-3 text-center form-control-sm" type="text" name="quantity" value="${ingredient.getQuantity()}"><br><br>
        <button>Save</button>

        <a href="/inventory"> <button type = "button">Cancel</button></a>

    </form>

</body>
</html>