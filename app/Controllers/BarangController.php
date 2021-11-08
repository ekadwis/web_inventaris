<?php

namespace App\Controllers;

use App\Models\BarangModel;
use App\Controllers\BaseController;

class BarangController extends BaseController
{
    protected $BarangModel;
    public function __construct()
    {
        $this->BarangModel = new BarangModel();
        $db = \Config\Database::connect();
    }

    public function index()
    {

        $query = $this->BarangModel->query("SELECT newkodebarang()"); // ambil function
        $id =  $query->getRow(); // ngambil 1 data
        foreach ($id as $idnew) // nggk tau knp harus di foreach dulu

            $data = [
                'barang' => $this->BarangModel->paginate(6, 'barang'), // tampilkan hanya 6 data per halaman, parameter barang adalah nama groupnya(namanya bebas)
                'pager' => $this->BarangModel->pager,
                'id_barang' => $idnew // ambil data yang sudah di foreach tadi
            ];

        return view('tables/barang', $data);
    }

    public function tambahbarang()
    {
        $gambar = $this->request->getFile('gambar'); // ambil inputan gambar
        if ($gambar->getError() == 4) : // jika terdapat error di gambar
            $namabaru = 'default.jpg'; // gunakan gambar default.jpg
        else : // jika benar
            $namabaru = $gambar->getRandomName(); // dapatkan nama random dari gambar
            $gambar->move('img', $namabaru); // lalu pindahkan gambar ke folder img dengan nama gambar baru yang ada di $namabaru
        endif;

        // Tangkap semua data yang di input
        $data = [
            'id_barang' => $this->request->getVar('id_barang'),
            'nama_barang' => $this->request->getVar('nama_barang'),
            'spesifikasi' => $this->request->getVar('spesifikasi'),
            'lokasi' => $this->request->getVar('lokasi'),
            'kondisi' => $this->request->getVar('kondisi'),
            'jumlah_barang' => $this->request->getVar('jumlah_barang'),
            'sumber_dana' => $this->request->getVar('sumber_dana'),
            'image' => $namabaru
        ];

        $this->BarangModel->insert($data); // Insert data dari $data ke database

        return redirect()->to('/barang'); // kembalikan ke routes /barang
    }

    public function hapus($id = null)
    {
        $hapus = $this->BarangModel->where(array('id_barang' => $id))->delete(); // jika type data idnya string, maka harus gunakan where()

        if ($hapus) : // jika kondisi true
            return redirect()->to('/barang'); // kembalikan ke routes /barang
        else :

        endif;
    }

    public function edit($id)
    {
        $result = $this->BarangModel->find($id);

        $data = [
            'result' => $result
        ];

        return view('/tables/edit', $data);
    }

    public function save()
    {
        $gambar = $this->request->getFile('gambar'); // ambil inputan gambar
        if ($gambar->getError() == 4) : // jika terdapat error di gambar
            $namabaru = $this->request->getVar('gambarlama'); // gunakan gambar lama
        else : // jika benar
            $namabaru = $gambar->getRandomName(); // dapatkan nama random dari gambar
            $gambar->move('img', $namabaru); // lalu pindahkan gambar ke folder img dengan nama gambar baru yang ada di 
            unlink('img/' . $this->request->getVar('gambarlama'));
        endif;

        $data = [
            'id_barang' => $this->request->getVar('id_barang'),
            'nama_barang' => $this->request->getVar('nama_barang'),
            'spesifikasi' => $this->request->getVar('spesifikasi'),
            'lokasi' => $this->request->getVar('lokasi'),
            'kondisi' => $this->request->getVar('kondisi'),
            'jumlah_barang' => $this->request->getVar('jumlah_barang'),
            'sumber_dana' => $this->request->getVar('sumber_dana'),
            'image' => $namabaru
        ];

        $this->BarangModel->save($data); // update data

        return redirect()->to('/barang');
    }
}
