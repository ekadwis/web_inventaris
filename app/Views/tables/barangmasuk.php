<?= $this->extend('layouts/template'); ?>

<?= $this->section('content'); ?>

<div class="container">
    <table class="table table-dark table-striped">
        <thead>
            <tr>
                <th scope="col">No.</th>
                <th scope="col">ID Barang</th>
                <th scope="col">Tanggal Masuk</th>
                <th scope="col">Jumlah Masuk</th>
                <th scope="col">Supplier</th>
            </tr>
            <tr>
                <?php $i = 1; ?>
                <?php foreach ($barang_masuk as $brgmsk) : ?>
                    <td><?= $i++; ?>.</td>
                    <td><?= $brgmsk['id_barang']; ?></td>
                    <td><?= $brgmsk['tgl_masuk']; ?></td>
                    <td><?= $brgmsk['jml_masuk']; ?></td>
                    <td><?= $brgmsk['supplier']; ?></td>
            </tr>
        <?php endforeach; ?>

        </thead>
    </table>
</div>
<?= $this->endSection(); ?>