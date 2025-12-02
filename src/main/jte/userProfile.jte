@param cs3220.aiapplication.model.UserJDBC user
@param java.util.List<cs3220.aiapplication.model.RecipeJDBC> recipeHistory
@param java.util.List<cs3220.aiapplication.model.RecipeJDBC> favoriteHistory
@param int ingredientCount

<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>
    <style>

    header {
    display: flex;
    justify-content: space-between;
    align-items: flex-start;
    padding: 15px;
        border-bottom: 2px solid black;
    }

    .left-section {
    display: flex;
    flex-direction: column;
    align-items: flex-start;
    gap: 10px;
    }

    .user-info {
    margin: 0;
    padding-top: 5px;
    text-align: left;
    }

    .logout{
        margin-top: 10px;
        align-content: end;
    }

    </style>
</head>
<body>
<%--list user information like username (needs to be added), email, and number of recipes created/favorites--%>
<%--ability to change username--%>
<%--Log out button--%>

<header>
    <div class="left-section">
        <div class="back-btn">
            <button><a href="home">Back Home</a></button>
        </div>
        <div class="user-info">
            <h1> ${user.getUsername()}'s Info:</h1>
            <p><a href="changeUsername">Change Username</a></p>
        </div>
    </div>

    <div class="logout">
        <button><a href="/logout">Log Out</a></button>
    </div>
</header>
<p>Total Recipes: (${recipeHistory.size()}) | <a href="/home?tab=history">View Recipes</a></p>
<p>Favorite Recipes: (${favoriteHistory.size()}) | <a href="/home?tab=favorites">View Favorites</a></p>
<p>Ingredients: (${ingredientCount}) | <a href="inventory">View Inventory</a></p>
<p></p>

</body>
</html>