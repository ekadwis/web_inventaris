<?= $this->extend('layouts/template'); ?>

<?= $this->section('content'); ?>

<button type="button" class="btn btn-primary float-end" style="margin-right: 7.5%;" data-bs-toggle="modal" data-bs-target="#exampleModal">
    Tambah data
</button>

<!-- Modal -->
<!-- Form tambah barang -->
<form action="/tambahbarang" method="POST" enctype="multipart/form-data">
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
                        <input type="text" class="form-control" id="id_barang" aria-describedby="emailHelp" name="id_barang" autofocus value="<?= $id_barang; ?>" readonly>
                    </div>

                    <div class="mb-3">
                        <label for="nama_barang" class="form-label">Nama Barang</label>
                        <input type="text" class="form-control" id="nama_barang" aria-describedby="emailHelp" name="nama_barang">
                    </div>
                    <div class="mb-3">
                        <label for="spesifikasi" class="form-label">Spesifikasi</label>
                        <input type="text" class="form-control" id="spesifikasi" aria-describedby="emailHelp" name="spesifikasi">
                    </div>
                    <div class="mb-3">
                        <label for="lokasi" class="form-label">Lokasi</label>
                        <select class="form-select" aria-label="Default select example" name="lokasi">
                            <option selected value="R001">Lab RPL 1</option>
                            <option value="R002">Lab RPL 2</option>
                            <option value="R003">Lab TKJ 1</option>
                            <option value="R004">Lab TKJ 2</option>
                            <option value="R005">Lab Multimedia</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="kondisi" class="form-label">Kondisi</label>
                        <input type="text" class="form-control" id="kondisi" aria-describedby="emailHelp" name="kondisi">
                    </div>
                    <div class="mb-3">
                        <label for="jumlah_barang" class="form-label">Jumlah Barang</label>
                        <input type="text" class="form-control" id="jumlah_barang" aria-describedby="emailHelp" name="jumlah_barang">
                    </div>
                    <div class="mb-3">
                        <label for="sumber_dana" class="form-label">Sumber Dana</label>
                        <select class="form-select" aria-label="Default select example" name="sumber_dana">
                            <option selected value="S001">Komite 07/09</option>
                            <option value="S002">Komite 13</option>
                            <option value="S003">Sed t-vet</option>
                            <option value="S004">BOPD 2020</option>
                            <option value="S005">BOSDA 2018</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="gambar" class="form-label">Gambar</label>
                        <input type="file" class="form-control" id="gambar" aria-describedby="emailHelp" name="gambar">
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
                    <img src="/img/<?= $b['image']; ?>" class="card-img-top img-thumbnail img-size">
                    <div class="card-body">
                        <h4 class="fs-6 text-secondary float-end"><?= $b['lokasi']; ?></h4>
                        <h5 class="card-title nama-barang"><?= $b['nama_barang']; ?></h5>

                        <p class="card-text fs-6 spek">
                            <?= $b['nama_barang']; ?> dengan kondisi <?= $b['kondisi']; ?> dengan bahan/spesifikasi yaitu:
                            <?= $b['spesifikasi']; ?>
                        </p>
                    </div>
                    <div class="card-body col">
                        <div class="float-end">
                            <a href="/hapus/<?= $b['id_barang']; ?>" class="card-link">
                                <i class="fas fa-trash text-danger" title="delete"></i>
                            </a>
                            <a href="/edit/<?= $b['id_barang']; ?>" class="card-link">
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

<!-- parameternya adalah ('nama_tabel', 'nama_pagination') -->
<?= $pager->links('barang', 'barang_pagination'); ?>


<?= $this->endSection(); ?>