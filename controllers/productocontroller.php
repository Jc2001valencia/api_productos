<?php
require_once __DIR__ . '/../models/producto.php';

class ProductoController {
    private $producto;

    public function __construct() {
        $this->producto = new Producto();
    }

    public function crear($data) {
        if (!isset($data["nombre"], $data["precio"], $data["id_categoria"], $data["id_estado"], $data["id_vendedor"])) {
            return ["error" => "Datos incompletos"];
        }
    
        // Paso 1: Insertar imágenes y obtener ID
        $id_img = $this->producto->crearImagen(
            $data["imagen1"] ?? null,
            $data["imagen2"] ?? null,
            $data["imagen3"] ?? null
        );
    
        // Paso 2: Crear producto con ID de imagen
        $id_producto = $this->producto->crear(
            $data["nombre"],
            $data["descripcion"] ?? "",
            $data["precio"],
            $data["id_categoria"],
            $data["id_estado"],
            $data["id_vendedor"],
            $id_img
        );
    
        return ["mensaje" => "Producto creado", "id_producto" => $id_producto];
    }

    public function listar() {
        return $this->producto->listar();
    }

    public function obtener($id_producto) {
        $producto = $this->producto->obtener($id_producto);
        return $producto ?: ["error" => "Producto no encontrado"];
    }

    public function listarPorVendedor($id_vendedor) {
        if (!isset($id_vendedor)) {
            return ["error" => "ID del vendedor requerido"];
        }

        return $this->producto->listarPorVendedor($id_vendedor);
    }

    public function actualizar($data) {
        if (!isset($data["id_producto"], $data["nombre"], $data["precio"], $data["id_categoria"], $data["id_estado"], $data["id_vendedor"])) {
            return ["error" => "Datos incompletos"];
        }

        $imagen = $data["imagen"] ?? "";
        $this->producto->actualizar(
            $data["id_producto"],
            $data["nombre"],
            $data["descripcion"] ?? "",
            $data["precio"],
            $data["id_categoria"],
            $data["id_estado"],
            $data["id_vendedor"],
            $imagen
        );

        return ["mensaje" => "Producto actualizado"];
    }

    public function eliminarConTodo($data) {
        if (!isset($data["id_producto"])) {
            return ["error" => "ID del producto requerido"];
        }
    
        return $this->producto->eliminarConTodo($data["id_producto"]);
    }
    public function productoVendido($id_producto) {
        require_once __DIR__ . '/../models/Producto.php';
        $producto = new Producto();
        $resultado = $producto->marcarComoVendido($id_producto);
        return $resultado;  // Devuelves el resultado directamente, no lo codificas en JSON aquí
    }
    

    public function obtenerIdVendedorPorUsuario($id_usu) {
        if (!isset($id_usu)) {
            return ["error" => "ID de usuario requerido"];
        }

        $id_vendedor = $this->producto->obtenerIdVendedorPorUsuario($id_usu);
        return $id_vendedor ? ["id_vendedor" => $id_vendedor] : ["error" => "Vendedor no encontrado"];
    }
    public function subirImagenes($data) {
        $producto = new Producto();
        return $producto->subirImagenesProducto($data);
    }
    public function insertarCategoria($data) {
        $categoria1 = $data['categoria1'] ?? null;
        $categoria2 = $data['categoria2'] ?? null;
        $categoria3 = $data['categoria3'] ?? null;
    
        if (!$categoria1) {
            return ["error" => "categoria1 es requerida"];
        }
    
        $producto = new Producto();
        return $producto->insertarCategoria($categoria1, $categoria2, $categoria3);
    }
    public function insertarProductoConTodo($data) {
        return $this->producto->insertarProductoConTodo($data);
    }
    public function editarProductoConTodo($id_producto, $data) {
        require_once __DIR__ . '/../models/Producto.php';
        $producto = new Producto();
        return $producto->editarProductoConTodo($id_producto, $data);
    }
    
    
    
}
?>