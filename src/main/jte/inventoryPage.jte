@param java.util.List<cs3220.aiapplication.model.IngredientJDBC> ingredients
@param java.util.List<cs3220.aiapplication.model.RecipeJDBC> recipes
@param java.util.List<cs3220.aiapplication.model.RecipeJDBC> favorites
@param String tab
@param cs3220.aiapplication.model.UserJDBC user

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inventory</title>
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
        /* profile icon */
        .profile {
            font-size: 50px;
            text-align: right;
            justify-self: right;
        }

        .menu {
            font-size: 50px;
            text-align: center;
            justify-self: center;
            width: 228px;
        }
        /* History and Favorites Tabs Button */
        .menu-btns{
            text-decoration: none;
            justify-self: center;
            justify-content: center;
            text-align: center;
        }

        /* history cards */
        .history-item {
            display: flex;
            flex-direction: column;
            list-style-type: none;
            background: white;
            border-radius: 10px;
            padding: 10px;
            margin-top: 10px;
        }

        /* Results Blocks */
        .result-card{
            background: white;
            border-radius: 10px;
        }

        .history-btn{
            text-decoration: none;
            color: black;
        }
        /* orange favorite button */
        .favorite-button {
            display: flex;
            float: right;
            border: 2px solid orange;
        }
        /* inventory button */
        .inventory {
            margin-top: auto;
            padding: 20px;
            justify-self: center;
            text-align: center;

        }
        /* sidebar button */
        .sidebar {
            position: sticky;
            width: 250px;
            transition: all 0.3s;
            background-color: lightgray;
            color: black;

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
            border-left: black 2px solid;
            height: 100vh;
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

        header.navbar{
            background-color: lightgray;
            color: black;
        }

        /* Hide the delete icon for tables by default */
        .delete-icon {
            opacity: 0;
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

<body>

<!-- Header -->
<header class="navbar sticky-top d-none d-sm-flex bg-success">
    <div class="container-fluid">
        <!-- Hamburger button -->
        <button class="btn btn-outline-dark me-2 " id="toggleSidebar">&#9776;</button>
        <div class="title">
            &nbsp;
            <img src="images/logo.png" height="40">
            <a href="/home?tab=${tab}">Recipe Maker</a>
        </div>
        <div class="profile">
            <a href="/profile?tab=${tab}">
                @if(user.getProfilePicture() != null && !user.getProfilePicture().isEmpty())
                    <img src="/images/${user.getProfilePicture()}" width="75" height="75" class="rounded-circle"/>
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
    <div class="menu-btns">
        <div class="btn-group" role="group" aria-label="Navigation button group">
            <a href="/inventory?tab=history" class="btn btn-lg ${tab.equals("history") ? "btn-secondary" : "btn-outline-secondary"}">History</a>
            <a href="/inventory?tab=favorites" class="btn btn-lg ${tab.equals("favorites") ? "btn-secondary" : "btn-outline-secondary"}">Favorites</a>
        </div>
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

<main id="content" class="content p-4 d-flex flex-column justify content-center align-items-center">
    <h1>Ingredients</h1>
    <form id="inventoryForm" action="inventory" method="post">
        @if( ingredients != null && !ingredients.isEmpty())
        <table id="ingredientsTable" class="table table-hover table-bordered table-striped">
            <thead>
            <tr>
                <th></th>
                <th>Ingredient</th>
                <th>Quantity</th>
                <th>Options</th>
            </tr>
            </thead>
            <tbody id="ingredientsBody">

                @for(int i = 0; i < ingredients.size(); i++)
                    <tr>
<%--                        unique ingredient number starting from 1--%>
                        <td>
                            ${i + 1}.
                        </td>
                        <td>
                          ${ingredients.get(i).getName()}
                        </td>
                        <td>
                               ${ingredients.get(i).getQuantity()}
                        </td>
                        <td><a href="edit/${ingredients.get(i).getId()}?tab=${tab}">Edit</a> | <a href="delete/${ingredients.get(i).getId()}?tab=${tab}" onclick="return confirm('Are you sure you want to Delete?');">Delete</a></td>
                    </tr>
                @endfor
            @else
                <div class="centered-text-div"> No Ingredients added...</div><br>
            @endif
            </tbody>


        </table>
        <a href="/addIngredientPage" class="btn btn-primary">Add Ingredient</a>

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