<?= $this->extend('layouts/template'); ?>

<?= $this->section('content'); ?>
<form action="/save" method="POST" enctype="multipart/form-data" class="mx-4">
    <?= csrf_field();; ?>
    <input type="hidden" name="gambarlama" value="<?= $result['image']; ?>"> <!-- untuk menyimpan gambar lama =-->
    <div class="mb-3">
        <label for="id_barang" class="form-label text-light">ID Barang</label>
        <input type="text" class="form-control" id="id_barang" aria-describedby="emailHelp" name="id_barang" value="<?= $result['id_barang']; ?>" readonly>
    </div>
    <div class="mb-3">
        <label for="nama_barang" class="form-label text-light">Nama Barang</label>
        <input type="text" class="form-control" id="nama_barang" aria-describedby="emailHelp" name="nama_barang" value="<?= $result['nama_barang']; ?>">
    </div>
    <div class="mb-3">
        <label for="spesifikasi" class="form-label text-light">Spesifikasi</label>
        <input type="text" class="form-control" id="spesifikasi" aria-describedby="emailHelp" name="spesifikasi" value="<?= $result['spesifikasi']; ?>">
    </div>
    <div class="mb-3">
        <label for="lokasi" class="form-label text-light">Lokasi</label>
        <select class="form-select" aria-label="Default select example" name="lokasi">
            <option selected value="<?= $result['lokasi']; ?>"><?= $result['lokasi']; ?></option>
            <option value="R001">Lab RPL 1</option>
            <option value="R002">Lab RPL 2</option>
            <option value="R003">Lab TKJ 1</option>
            <option value="R004">Lab TKJ 2</option>
            <option value="R005">Lab Multimedia</option>
        </select>
    </div>
    <label for="kondisi" class="form-label text-light">Kondisi</label>
    <input type="text" class="form-control" id="kondisi" aria-describedby="emailHelp" name="kondisi" value="<?= $result['kondisi']; ?>">
    <div class="mb-3">
        <label for="jumlah_barang" class="form-label text-light">Jumlah Barang</label>
        <input type="text" class="form-control" id="jumlah_barang" aria-describedby="emailHelp" name="jumlah_barang" value="<?= $result['jumlah_barang']; ?>">
    </div>
    <div class="mb-3">
        <label for="sumber_dana" class="form-label text-light">Sumber Dana</label>
        <select class="form-select" aria-label="Default select example" name="sumber_dana">
            <option selected value="<?= $result['sumber_dana']; ?>"><?= $result['sumber_dana']; ?></option>
            <option value="S002">Komite 13</option>
            <option value="S003">Sed t-vet</option>
            <option value="S004">BOPD 2020</option>
            <option value="S005">BOSDA 2018</option>
        </select>
    </div>
    <div class="mb-3">
        <label for="gambar" class="form-label text-light">Gambar</label>
        <input type="file" class="form-control mb-2" id="gambar" aria-describedby="emailHelp" name="gambar" value="<?= $result['image']; ?>">
        <img src="/img/<?= $result['image']; ?>" class="img-thumbnail img-preview img-size" alt="">
    </div>


    <button type="submit" class="btn btn-primary float-end">Ubah data</button>
</form>
<?= $this->endSection(); ?>