@param java.util.List<cs3220.aiapplication.model.RecipeJDBC> recipes
@param java.util.List<cs3220.aiapplication.model.RecipeJDBC> favorites
@param String tab
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Recipe Maker</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
    <!--    <link rel="stylesheet" href="homeStyle.css">-->
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
            width: 250px;
            transition: all 0.3s;
            background-color: lightgray;
            color: black;
            border-right: black 2px solid;

            height: 100vh;
            overflow-y: auto;
            overflow-x:hidden;
        }
        .sidebar.collapsed {
            margin-left: -250px;
        }
        .content {
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
            <a href="home">Recipe Maker</a>
        </div>
        <div class="profile">
            <a href="profile"><i class="bi bi-person-circle text-dark" ></i></a>
        </div>
    </div>
</header>

<!-- Sidebar -->
<div id="sidebar" class="position-absolute h-100 sidebar p-3">
    <div class="menu">
        <h1 class="mb-0">Menu</h1>
    </div>
    <div class="menu-btns">
        <div class="btn-group" role="group" aria-label="Navigation button group">
            <a href="/home?tab=history" class="btn btn-outline-secondary btn-lg">History</a>
            <a href="/home?tab=favorites" class="btn btn-outline-secondary btn-lg">Favorites</a>
        </div>
    </div>
    <h6 class="mt-3">Recent Recipes</h6>
    <!--    similar to Lab6 create a List of History and load them using for loop-->
    <ul class="history-item">
        @if(tab.equals("favorites"))

        @if(favorites.isEmpty())
            <li>No Recept Recipes...</li>
        @endif
        @for(var recipe: favorites)
            <a href="viewRecipe?id=${recipe.getId()}" class="nav-link">
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
            <a href="viewRecipe?id=${recipe.getId()}" class="nav-link">
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
        <a class="btn btn-success btn-lg" href="inventory" role="button">Inventory</a>
    </div>
</div>

<!-- Main Content -->
<main id="content" class="content p-4 d-flex flex-column justify-content-center align-items-center" style="min-height: 80vh;">
    <!-- Chat box -->
    <!--    chat box form-->
<%--    send to viewRecipe.jte but also update in home, results, and favorites--%>
    <form action="/home" method="post" class="w-100" style="max-width: 600px;">
        <div class="input-group">
            <input type="text" name="prompt" class="form-control" placeholder="What's for dinner?">
            <button class="btn btn-success" type="submit">&rarr;</button>
        </div>

        <!-- NEW: Radio Buttons Below -->
        <div class="mt-3 d-flex justify-content-center gap-4">
            <div class="form-check form-check-inline">
                <input class="form-check-input" type="radio" name="level" id="beginner" value="beginner">
                <label class="form-check-label" for="beginner">Beginner</label>
            </div>

            <div class="form-check form-check-inline">
                <input class="form-check-input" type="radio" name="level" id="expert" value="expert">
                <label class="form-check-label" for="expert">Expert</label>
            </div>
        </div>
    </form>


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
