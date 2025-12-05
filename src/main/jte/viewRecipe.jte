@param cs3220.aiapplication.model.RecipeJDBC recipeById
@param java.util.List<cs3220.aiapplication.model.RecipeJDBC> recipes
@param java.util.List<cs3220.aiapplication.model.RecipeJDBC> favorites
@param String tab
@param cs3220.aiapplication.model.UserJDBC user
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>${recipeById.getTitle()}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
    <style>
        body {
            overflow-x: hidden;
            background-color: lightgray;

        }
        header{
            font-size: 50px;
            border-bottom: black 2px solid;

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

        /* profile icon */
        .profile {
            font-size: 50px;
            text-align: right;
            justify-self: right;
            color: black;
        }

        .menu {
            font-size: 50px;
            text-align: center;
            justify-self: center;
            width: 228px;
        }

        /* History and Favorites Tabs */
        .menu-btns{
            text-decoration: none;
            justify-self: center;
            justify-content: center;
            text-align: center;
        }
        /* Histoty Cards */
        .history-item {
            display: flex;
            flex-direction: column;
            list-style-type: none;
            background: white;
            border-radius: 10px;
            padding: 10px;
            margin-top: 10px;
            max-height:300px;
            overflow-y:auto;
            padding-right: 5px;
        }

        .sidebar {
            flex-shrink: 0;
            width: 250px;
            transition: all 0.3s;
            background-color: lightgray;
            color: black;
            height: 100vh;

        }
        .sidebar.collapsed {
            margin-left: -250px;
        }
        .content {
            border-left: black 2px solid;
            transition: margin-left 0.3s;
            margin-left: 250px;
        }
        .content.expanded {
            margin-left: 0;
        }
        .sidebar .nav-link {
            color: black;
        }
        .sidebar .nav-link:hover {
            background-color: lightgray;
        }

        .inventory {
            margin-top: auto;
            padding: 20px;
            justify-self: center;
            text-align: center;

        }

    </style>
</head>
<body>

<!-- Header -->
<header class="navbar sticky-top d-none d-sm-flex bg-success">
    <div class="container-fluid">
        <!-- Hamburger button -->
        <button class="btn btn-outline-dark me-2 " id="toggleSidebar">&#9776;</button>
        <div class="title">
            <img src="images/logo.png" height="40">
            <a href="/home?tab=${tab}">Recipe Maker</a>
        </div>
        <div class="profile">
            <a href="/profile?tab=${tab}">
                @if(user.getProfilePicture() != null && !user.getProfilePicture().isEmpty())
                    <img src="/images/${user.getProfilePicture()}" width="100" height="100" class="rounded-circle"/>
                @else
                    <i class="bi bi-person-circle text-dark fs-3"></i>
                @endif
            </a>
        </div>
    </div>
</header>


<!-- Sidebar -->
<div id="sidebar" class="position-absolute h-100 sidebar p-3">
    <div class="menu">
        <h1 class="mb-0">Menu</h1>
    </div>
    <div class="btn-group" role="group" aria-label="Navigation button group">
        <a href="/viewRecipe?id=${recipeById.getId()}&tab=history"
           class="btn btn-lg ${tab.equals("history") ? "btn-secondary" : "btn-outline-secondary"}">
            History
        </a>

        <a href="/viewRecipe?id=${recipeById.getId()}&tab=favorites"
           class="btn btn-lg ${tab.equals("favorites") ? "btn-secondary" : "btn-outline-secondary"}">
            Favorites
        </a>
    </div>



    @if(tab.equals("favorites"))

        <h6 class="mt-3">Favorites</h6>
    @else
        <h6 class="mt-3">Recent Recipes</h6>

    @endif

    <ul class="history-item">
        @if(tab.equals("favorites"))

            @if(favorites.isEmpty())
                <li>No Favorite Recipies...</li>
            @endif
            @for(var recipe: favorites)
                <a href="viewRecipe?id=${recipe.getId()}&tab=${tab}" class="nav-link">
                    <div>
                        <small>#${recipe.getId()}</small>
                        <strong>${recipe.getTitle()}</strong><br>
                        Date: ${recipe.getDate().toString()}<br>
                        Main Ingredients: ${recipe.getMainIngredients()}
                    </div>
                </a>
                <br>
            @endfor
        @elseif(tab.equals("history"))
            @if(recipes.isEmpty())
                <li>No Recept Recipes...</li>
            @endif
            @for(var recipe: recipes)
                <a href="viewRecipe?id=${recipe.getId()}&tab=${tab}" class="nav-link">
                    <div>
                        <small>#${recipe.getId()}</small>
                        <strong>${recipe.getTitle()}</strong><br>
                        Date: ${recipe.getDate().toString()}<br>
                        Main Ingredients: ${recipe.getMainIngredients()}
                    </div>
                </a>
                <br>
            @endfor
        @endif
    </ul>
    <div class="inventory">
        <a class="btn btn-success btn-lg" href="inventory?tab=${tab}" role="button">Inventory</a>
    </div>
</div>

<main id="content" class="content p-4 d-flex flex-column " style="min-height: 80vh;">


    <div class = "hstack">

        <div class = "col-3 text-end">
            <a href="/home?tab=${tab}" class="btn btn-secondary">&larr; Back Home</a>
        </div>
            <div class = "col-6 text-center">
                <a href="file.mp3" download="file.mp3"> <button>Export</button></a>
            </div>
        <div class = "col-3">
            <a href="/favoriteRecipe?id=${recipeById.getId()}&tab=${tab}" class="btn btn-warning">${recipeById.isFavorite() ? "Unfavorite" : "Favorite"}</a>
        </div>
    </div>
    <div class = "text-center pt-2">
        <h1>${recipeById.getTitle()}</h1>
        <p>Date: ${recipeById.getDate().toString()}</p>
        <p>Main Ingredients: ${recipeById.getMainIngredients()}</p>

        <h2>Instructions</h2>
        <pre style="white-space: pre-wrap;">${recipeById.getContent()}</pre>
    </div>
    <br/>
    <div class = "text-center pt-5">
        <a href="/deleteRecipe?id=${recipeById.getId()}&tab=${tab}" class="btn btn-danger" onclick="return confirm('Are you sure you want to delete this recipe?');">Delete Recipe</a>
    </div>
</main>



<script>
    const sidebar = document.getElementById("sidebar");
    const content = document.getElementById("content");

    function handleResize() {
        // Collapse sidebar on small screens < 576 or small devices
        if (window.innerWidth < 576) {
            sidebar.classList.add("collapsed");
            content.classList.add("expanded");
        } else {
            sidebar.classList.remove("collapsed");
            content.classList.remove("expanded");
        }
    }

    // Run on load
    handleResize();

    // Run on window resize
    window.addEventListener("resize", handleResize);

    // Burger button toggle
    const toggleBtn = document.getElementById("toggleSidebar");
    const toggleBtnMobile = document.getElementById("toggleSidebarMobile");

    function toggleSidebar() {
        sidebar.classList.toggle("collapsed");
        content.classList.toggle("expanded");
    }

    if (toggleBtn) toggleBtn.addEventListener("click", toggleSidebar);
    if (toggleBtnMobile) toggleBtnMobile.addEventListener("click", toggleSidebar);
</script>
</body>
</html>