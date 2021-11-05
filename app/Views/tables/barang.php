<?= $this->extend('layouts/template'); ?>

<?= $this->section('content'); ?>

<button type="button" class="btn btn-primary float-end" style="margin-right: 7.5%;" data-bs-toggle="modal" data-bs-target="#exampleModal">
    Tambah data
</button>

<!-- Modal -->
<!-- Form tambah barang -->
<form action="/tambahbarang" method="POST">
    <?= csrf_field(); ?>
    <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Masukkan data barang</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="mb-3">
                        <label for="id_barang" class="form-label">ID Barang</label>
                        <input type="text" class="form-control" id="id_barang" aria-describedby="emailHelp" name="id_barang" autofocus>
                    </div>

                    <div class="mb-3">
                        <label for="nama_barang" class="form-label">Nama Barang</label>
                        <input type="text" class="form-control" id="nama_barang" aria-describedby="emailHelp" name="nama_barang" autofocus>
                    </div>
                    <div class="mb-3">
                        <label for="spesifikasi" class="form-label">Spesifikasi</label>
                        <input type="text" class="form-control" id="spesifikasi" aria-describedby="emailHelp" name="spesifikasi" autofocus>
                    </div>
                    <div class="mb-3">
                        <label for="lokasi" class="form-label">Lokasi</label>
                        <input type="text" class="form-control" id="lokasi" aria-describedby="emailHelp" name="lokasi" autofocus>
                    </div>
                    <div class="mb-3">
                        <label for="kondisi" class="form-label">Kondisi</label>
                        <input type="text" class="form-control" id="kondisi" aria-describedby="emailHelp" name="kondisi" autofocus>
                    </div>
                    <div class="mb-3">
                        <label for="jumlah_barang" class="form-label">Jumlah Barang</label>
                        <input type="text" class="form-control" id="jumlah_barang" aria-describedby="emailHelp" name="jumlah_barang" autofocus>
                    </div>
                    <div class="mb-3">
                        <label for="sumber_dana" class="form-label">Sumber Dana</label>
                        <input type="text" class="form-control" id="sumber_dana" aria-describedby="emailHelp" name="sumber_dana" autofocus>
                    </div>
                    <div class="mb-3">
                        <label for="image" class="form-label">Image</label>
                        <input type="text" class="form-control" id="image" aria-describedby="emailHelp" name="image" autofocus>
                    </div>

                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-primary">Tambah</button>
                </div>
            </div>
        </div>
    </div>
</form>





<!-- Tabel barang -->
<h2 class="text-light" style="margin: 0 7.5%;">
    <i class="fas fa-box"></i> Barang
</h2>
<hr class="text-light mt-2 mb-4" style="height: 5px; margin: 0 7.5%">
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