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
}
