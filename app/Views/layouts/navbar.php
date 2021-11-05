<div class="content">
    <nav class="navbar navbar-expand-lg">

        <button type="button" id="sidebarCollapse" class="btn btn-toggler">
            <i class="fa fa-bars"></i>
        </button>

        <!--<a class="navbar-brand" href="#">Navbar</a> -->
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a class="nav-link link-light" href="#"><i class="fas fa-sign-out-alt"> Logout</i></a>
                </li>
            </ul>
        </div>
    </nav>

    <?= $this->renderSection('content'); ?>

</div>






<!-- button buat buka tutupya -->
<!-- 
<button class="btn btn-primary" type="button" data-bs-toggle="collapse" data-bs-target="#collapseWidthExample" aria-expanded="false" aria-controls="collapseWidthExample">
    Toggle width collapse
</button> -->