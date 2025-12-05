@param cs3220.aiapplication.model.UserJDBC user
@param java.util.List<cs3220.aiapplication.model.RecipeJDBC> recipeHistory
@param java.util.List<cs3220.aiapplication.model.RecipeJDBC> favoriteHistory
@param int ingredientCount
@param String tab

<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" />
    <title>${user.getUsername()}'s info</title>
    <style>

        body{
            background: floralwhite;
        }

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

    .profilebtn{
        margin: 4px;
    }
    .user-info {
    margin: 0;
    padding-top: 25px;
    padding-bottom: 25px;
    padding-left: 10px;
    font-size: 26px;
    text-align: left;
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

<body>
<header class = "bg-success">

    <div class = "col-md-1"></div>

    <div class="title col-md-10 text-center">
        <img src="images/logo.png" height="40">
        <a href = "/home?tab=${tab}" class = "fs-1"> Recipe Maker</a>
    </div>

    <div class = "col-md-1 text-end">
        <a href="/logout" class="btn btn-secondary col-lg-auto bg-info float-right" role="button" aria-disabled="true">Logout</a>
    </div>

</header>
<div class="d-flex justify-content-between align-items-center mb-3" style="padding: 0 10px;">
    <h1 class="user-info mb-0">${user.getUsername()}'s Info:</h1>
    <div class="profile mt-2">
        @if(user.getProfilePicture() != null && !user.getProfilePicture().isEmpty())
            <img src="/images/${user.getProfilePicture()}" width="100" height="100" class="rounded-circle"/>
        @else
            <i class="bi bi-person-circle text-dark fs-1"></i>
        @endif
    </div>
</div>

<div class="container-fluid text-center">

    <div class = "mx-90 container-fluid text-start p-5 " style = "background-color: floralwhite">
        <p>Email: ${user.getEmail()}</p>
<%--        change profile icon--%>
        <input type="file" name="profilePic" class="form-control mb-2" form="uploadForm" required>

        <div class="d-flex justify-content-start">
            <form id="uploadForm" action="/uploadProfilePicture" method="post" class="profilebtn" enctype="multipart/form-data">
                <button type="submit" class="btn btn-success">Upload</button>
            </form>

            <form action="/deleteProfilePicture?tab=${tab}" class="profilebtn" method="post">
                <button type="submit" class="btn btn-danger">Delete</button>
            </form>
        </div>




        <br>
        <p>Username: ${user.getUsername()} | <a href="changeUsername">Change Username</a></p>
        <p>Total Recipes: (${recipeHistory.size()}) | <a href="/home?tab=history">View Recipes</a></p>
        <p>Favorite Recipes: (${favoriteHistory.size()}) | <a href="/home?tab=favorites">View Favorites</a></p>
        <p>Ingredients: (${ingredientCount}) | <a href="/inventory?tab=${tab}">View Inventory</a></p>
        <p></p>
    </div>
</div>
</body>
</html>