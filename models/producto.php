<?php
require_once __DIR__ . '/../config/database.php';

class Producto {
    private $conn;
    
    public function __construct() {
        $database = new Database();
        $this->conn = $database->getConnection();
    }

    public function crear($nombre, $descripcion, $precio, $id_categoria, $id_estado, $id_vendedor, $id_img) {
        $stmt = $this->conn->prepare("INSERT INTO producto 
            (nombre, descripcion, precio, id_categoria, id_estado, id_vendedor, id_img)
            VALUES (?, ?, ?, ?, ?, ?, ?)");
        $stmt->execute([$nombre, $descripcion, $precio, $id_categoria, $id_estado, $id_vendedor, $id_img]);
    
        return $this->conn->lastInsertId(); // ✅ CORREGIDO
    }

    public function marcarComoVendido($id_producto) {
        $sql = "UPDATE producto SET id_estado = ? WHERE id_producto = ?";
        $stmt = $this->conn->prepare($sql);
        
        if ($stmt->execute([2, $id_producto])) { // Suponiendo que "2" representa estado "vendido"
            return ["mensaje" => "Producto marcado como vendido"];
        } else {
            return ["error" => "No se pudo actualizar el estado del producto"];
        }
    }
    public function listar() {
        $sql = "SELECT 
                    p.*, 
                    i.imagen1, 
                    i.imagen2, 
                    i.imagen3,
                    c.categoria1,
                    c.categoria2,
                    c.categoria3
                FROM producto p
                LEFT JOIN imagen i ON p.id_img = i.id_imagen
                LEFT JOIN categoria c ON p.id_categoria = c.id_categoria";
        
        $stmt = $this->conn->query($sql);
        $productos = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
        foreach ($productos as &$producto) {
            // Agrupar imágenes en un array
            $producto['imagenes'] = array_filter([
                $producto['imagen1'],
                $producto['imagen2'],
                $producto['imagen3']
            ]);
            unset($producto['imagen1'], $producto['imagen2'], $producto['imagen3']);
    
            // Agrupar categorías en un array
            $producto['categorias'] = array_filter([
                $producto['categoria1'],
                $producto['categoria2'],
                $producto['categoria3']
            ]);
            unset($producto['categoria1'], $producto['categoria2'], $producto['categoria3']);
        }
    
        return $productos;
    }
      

    public function obtener($id_producto) {
        // Consulta principal del producto
        $sql = "SELECT 
                    p.id_producto, 
                    p.nombre, 
                    p.descripcion, 
                    p.precio, 
                    p.id_categoria, 
                    c.categoria1, 
                    c.categoria2, 
                    c.categoria3,
                    p.id_estado, 
                    p.id_vendedor, 
                    p.id_img,
                    i.imagen1,
                    i.imagen2,
                    i.imagen3,
                    v.nombre AS vendedor_nombre,
                    v.imagen AS vendedor_imagen,
                    v.ubicacion AS vendedor_ubicacion,
                    v.telefono AS vendedor_telefono
                FROM producto p
                JOIN vendedor v ON p.id_vendedor = v.id_vendedor
                JOIN categoria c ON p.id_categoria = c.id_categoria
                LEFT JOIN imagen i ON p.id_img = i.id_imagen
                WHERE p.id_producto = ?";
        
        $stmt = $this->conn->prepare($sql);
        $stmt->execute([$id_producto]);
        $producto = $stmt->fetch(PDO::FETCH_ASSOC);
    
        // Si el producto existe, organizamos sus imágenes y categorías
        if ($producto) {
            // Combinar imágenes en array
            $producto['imagenes'] = array_filter([
                $producto['imagen1'],
                $producto['imagen2'],
                $producto['imagen3']
            ]);
            unset($producto['imagen1'], $producto['imagen2'], $producto['imagen3']);
    
            // Agrupar categorías si existen
            $producto['categorias'] = array_filter([
                $producto['categoria1'],
                $producto['categoria2'],
                $producto['categoria3']
            ]);
            unset($producto['categoria1'], $producto['categoria2'], $producto['categoria3']);
        }
    
        return $producto;
    }
    
    

    public function listarPorVendedor($id_vendedor) {
        $sql = "SELECT 
                    p.*, 
                    i.imagen1, 
                    i.imagen2, 
                    i.imagen3,
                    c.categoria1,
                    c.categoria2,
                    c.categoria3
                FROM producto p
                LEFT JOIN imagen i ON p.id_img = i.id_imagen
                LEFT JOIN categoria c ON p.id_categoria = c.id_categoria
                WHERE p.id_vendedor = ?";
        
        $stmt = $this->conn->prepare($sql);
        $stmt->execute([$id_vendedor]);
        
        $productos = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
        foreach ($productos as &$producto) {
            // Combina imágenes en un array
            $producto['imagenes'] = array_filter([
                $producto['imagen1'],
                $producto['imagen2'],
                $producto['imagen3']
            ]);
            unset($producto['imagen1'], $producto['imagen2'], $producto['imagen3']);
    
            // Agrupa las categorías si existen
            $producto['categorias'] = array_filter([
                $producto['categoria1'],
                $producto['categoria2'],
                $producto['categoria3']
            ]);
            unset($producto['categoria1'], $producto['categoria2'], $producto['categoria3']);
        }
    
        return $productos;
    }
    

    public function actualizar($id_producto, $nombre, $descripcion, $precio, $id_categoria, $id_estado, $id_vendedor, $id_img) {
        $sql = "UPDATE producto 
                SET nombre = ?, descripcion = ?, precio = ?, id_categoria = ?, id_estado = ?, id_vendedor = ?, id_img = ? 
                WHERE id_producto = ?";
        $stmt = $this->conn->prepare($sql);
        
        if ($stmt->execute([$nombre, $descripcion, $precio, $id_categoria, $id_estado, $id_vendedor, $id_img, $id_producto])) {
            return ["message" => "Producto actualizado correctamente"];
        } else {
            return ["error" => "No se pudo actualizar el producto"];
        }
    }

    public function eliminarConTodo($id_producto) {
        try {
            $this->conn->beginTransaction();
    
            // Obtener ids relacionados
            $stmt = $this->conn->prepare("SELECT id_img, id_categoria FROM producto WHERE id_producto = ?");
            $stmt->execute([$id_producto]);
            $relaciones = $stmt->fetch(PDO::FETCH_ASSOC);
    
            if (!$relaciones) {
                throw new Exception("Producto no encontrado.");
            }
    
            $id_img = $relaciones['id_img'];
            $id_categoria = $relaciones['id_categoria'];
    
            // Eliminar producto
            $stmt = $this->conn->prepare("DELETE FROM producto WHERE id_producto = ?");
            $stmt->execute([$id_producto]);
    
            // Eliminar imagen
    
            // Eliminar categoría
            $stmt = $this->conn->prepare("DELETE FROM categoria WHERE id_categoria = ?");
            $stmt->execute([$id_categoria]);
    
            $this->conn->commit();
            return ["mensaje" => "Producto, imagen y categoría eliminados correctamente"];
    
        } catch (Exception $e) {
            $this->conn->rollBack();
            return ["error" => $e->getMessage()];
        }
    }

    public function obtenerIdVendedorPorUsuario($id_usu) {
        $sql = "SELECT id_vendedor FROM vendedor WHERE id_usu = ?";
        $stmt = $this->conn->prepare($sql);
        $stmt->execute([$id_usu]);
    
        $resultado = $stmt->fetch(PDO::FETCH_ASSOC);
        return $resultado ? $resultado['id_vendedor'] : null;
    }


    public function insertarCategoria($categoria1, $categoria2 = null, $categoria3 = null) {
        $sql = "INSERT INTO categoria (categoria1, categoria2, categoria3) VALUES (?, ?, ?)";
        $stmt = $this->conn->prepare($sql);
    
        if ($stmt->execute([$categoria1, $categoria2, $categoria3])) {
            return [
                "mensaje" => "Categoría insertada correctamente",
                "id_categoria" => $this->conn->lastInsertId()
            ];
        } else {
            return ["error" => "No se pudo insertar la categoría"];
        }
    }

    public function insertarProductoConTodo($data) {
        try {
            // Iniciar transacción
            $this->conn->beginTransaction();
    
            // 1. Insertar en imagen
            $stmtImg = $this->conn->prepare("INSERT INTO imagen (imagen1, imagen2, imagen3) VALUES (?, ?, ?)");
            $stmtImg->execute([
                $data['imagenes']['imagen1'] ?? null,
                $data['imagenes']['imagen2'] ?? null,
                $data['imagenes']['imagen3'] ?? null
            ]);
            $id_img = $this->conn->lastInsertId();
    
            // 2. Insertar en categoria
            $stmtCat = $this->conn->prepare("INSERT INTO categoria (categoria1, categoria2, categoria3) VALUES (?, ?, ?)");
            $stmtCat->execute([
                $data['categoria']['categoria1'],
                $data['categoria']['categoria2'],
                $data['categoria']['categoria3']
            ]);
            $id_categoria = $this->conn->lastInsertId();
    
            // 3. Insertar en producto
            $stmtProd = $this->conn->prepare("INSERT INTO producto (nombre, descripcion, precio, id_categoria, id_estado, id_vendedor, id_img) VALUES (?, ?, ?, ?, ?, ?, ?)");
            $stmtProd->execute([
                $data['producto']['nombre'],
                $data['producto']['descripcion'],
                $data['producto']['precio'],
                $id_categoria,
                $data['producto']['id_estado'],
                $data['producto']['id_vendedor'],
                $id_img
            ]);
            $id_producto = $this->conn->lastInsertId();
    
            // Confirmar transacción
            $this->conn->commit();
    
            return [
                "mensaje" => "Producto, imágenes y categoría insertados correctamente",
                "id_producto" => $id_producto,
                "id_categoria" => $id_categoria,
                "id_img" => $id_img
            ];
    
        } catch (PDOException $e) {
            $this->conn->rollBack();
            return ["error" => "Error al insertar: " . $e->getMessage()];
        }
    }

    public function editarProductoConTodo($id_producto, $data) {
        try {
            $this->conn->beginTransaction();
    
            // Obtener IDs relacionados
            $stmt = $this->conn->prepare("SELECT id_img, id_categoria FROM producto WHERE id_producto = ?");
            $stmt->execute([$id_producto]);
            $relaciones = $stmt->fetch(PDO::FETCH_ASSOC);
    
            if (!$relaciones) {
                return ["error" => "Producto no encontrado"];
            }
    
            $id_img = $relaciones['id_img'];
            $id_categoria = $relaciones['id_categoria'];
    
            // 1. Actualizar imagen
            $stmtImg = $this->conn->prepare("UPDATE imagen SET imagen1 = ?, imagen2 = ?, imagen3 = ? WHERE id_imagen = ?");
            $stmtImg->execute([
                $data['imagenes']['imagen1'] ?? null,
                $data['imagenes']['imagen2'] ?? null,
                $data['imagenes']['imagen3'] ?? null,
                $id_img
            ]);
    
            // 2. Actualizar categoría
            $stmtCat = $this->conn->prepare("UPDATE categoria SET categoria1 = ?, categoria2 = ?, categoria3 = ? WHERE id_categoria = ?");
            $stmtCat->execute([
                $data['categoria']['categoria1'],
                $data['categoria']['categoria2'],
                $data['categoria']['categoria3'],
                $id_categoria
            ]);
    
            // 3. Actualizar producto
            $stmtProd = $this->conn->prepare("UPDATE producto SET nombre = ?, descripcion = ?, precio = ?, id_estado = ?, id_vendedor = ? WHERE id_producto = ?");
            $stmtProd->execute([
                $data['producto']['nombre'],
                $data['producto']['descripcion'],
                $data['producto']['precio'],
                $data['producto']['id_estado'],
                $data['producto']['id_vendedor'],
                $id_producto
            ]);
    
            $this->conn->commit();
    
            return ["mensaje" => "Producto actualizado correctamente"];
        } catch (PDOException $e) {
            $this->conn->rollBack();
            return ["error" => "Error al editar: " . $e->getMessage()];
        }
    }
    
    
    
}
?>