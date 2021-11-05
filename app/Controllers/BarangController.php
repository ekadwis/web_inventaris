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
    }

    public function index()
    {
        $data = [
            'barang' => $this->BarangModel->findAll()
        ];

        return view('tables/barang', $data);
    }

    public function tambah()
    {
        $data = [
            'id_barang' => $this->request->getVar('id_barang'),
            'nama_barang' => $this->request->getVar('nama_barang'),
            'spesifikasi' => $this->request->getVar('spesifikasi'),
            'lokasi' => $this->request->getVar('lokasi'),
            'kondisi' => $this->request->getVar('kondisi'),
            'jumlah_barang' => $this->request->getVar('jumlah_barang'),
            'sumber_dana' => $this->request->getVar('sumber_dana'),
            'image' => $this->request->getVar('image')
        ];

        $this->BarangModel->insert($data);

        return redirect()->to('/');
    }
}
