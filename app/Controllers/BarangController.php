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
        // $idnew = json_encode($id);
        foreach ($id as $idnew)

            $data = [
                'barang' => $this->BarangModel->findAll(),
                'id_barang' => $idnew
            ];

        return view('tables/barang', $data);
    }

    public function tambahbarang()
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
