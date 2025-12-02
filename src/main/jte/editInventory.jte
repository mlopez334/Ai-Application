@param cs3220.aiapplication.model.IngredientJDBC ingredient


<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>
</head>
<body>

<form method="post">
    <input type="text" name="name" value="${ingredient.getName()}"><br>
    <input type="text" name="quantity" value="${ingredient.getQuantity()}"><br>
    <button>Save</button>
</form>
</body>
</html>