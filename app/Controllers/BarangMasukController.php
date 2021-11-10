<?php

namespace App\Controllers;

use App\Controllers\BaseController;
use App\Models\BarangMasukModel;

class BarangMasukController extends BaseController
{
    protected $BarangMasukModel;
    public function __construct()
    {
        $this->BarangMasukModel = new BarangMasukModel();
        $db = \Config\Database::connect();
    }

    public function index()
    {
        $data = [
            'barang_masuk' => $this->BarangMasukModel->findAll()
        ];

        return view('tables/barangmasuk', $data);
    }
}
