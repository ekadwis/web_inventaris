<?= $this->extend('layouts/template'); ?>

<?= $this->section('content'); ?>
<div class="card-group" style="margin: 0 6%;">
    <?php foreach ($barang as $b) : ?>

        <div class="row">
            <div class="col-sm-3">
                <div class="card mx-3 my-2" style="width: 18rem;">
                    <img src="/img/<?= $b['image']; ?>.png" class="card-img-top img-thumbnail">
                    <div class="card-body">
                        <h4 class="fs-6 text-secondary float-end"><?= $b['lokasi']; ?></h4>
                        <h5 class="card-title"><?= $b['nama_barang']; ?></h5>

                        <p class="card-text fs-6">
                            <?= $b['nama_barang']; ?> dengan kondisi <?= $b['kondisi']; ?> dengan bahan/spesifikasi yaitu:
                            <?= $b['spesifikasi']; ?>
                        </p>
                    </div>
                    <div class="card-body col">
                        <div class="float-end">
                            <a href="#" class="card-link">
                                <i class="fas fa-trash text-danger" title="delete"></i>
                            </a>
                            <a href="#" class="card-link">
                                <i class="fas fa-edit text-dark" title="edit"></i>
                            </a>
                        </div>
                        <p class="card-text fs-6">
                            Stok: <?= $b['jumlah_barang']; ?>

                        </p>

                    </div>
                </div>
            </div>
        </div>
    <?php endforeach; ?>
</div>
<?= $this->endSection(); ?>