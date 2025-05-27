<?php

// === CABECERAS CORS ===
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");
header("Content-Type: application/json");

// === RESPUESTA A OPTIONS (preflight CORS) ===
if ($_SERVER['REQUEST_METHOD'] == 'OPTIONS') {
    http_response_code(200);
    exit();
}

// === INCLUSIÓN DEL CONTROLADOR ===
require_once __DIR__ . '/./controllers/productocontroller.php';
$controller = new ProductoController();

// === ENTRADA JSON (para POST, PUT, DELETE) ===
$data = json_decode(file_get_contents("php://input"), true);

// === PARÁMETRO DE ACCIÓN ===
$action = $_GET['action'] ?? '';

// === SWITCH DE ACCIONES ===
switch ($action) {
    case "crear":
        echo json_encode($controller->crear($data));
        break;

    case "listar":
        echo json_encode($controller->listar());
        break;

    case "obtener":
        echo json_encode($controller->obtener($_GET["id_producto"] ?? null));
        break;

    case "actualizar":
        echo json_encode($controller->actualizar($data));
        break;

    case "eliminar":
        // Si usas método DELETE y el id va por GET
        $id = $_GET["id_producto"] ?? null;
        echo json_encode($controller->eliminar($id));
        break;

    case "eliminarConTodo":
        echo json_encode($controller->eliminarConTodo($data));
        break;

    case "listarPorVendedor":
        echo json_encode($controller->listarPorVendedor($_GET["id_vendedor"] ?? null));
        break;

    case "obtenerIdVendedor":
        echo json_encode($controller->obtenerIdVendedorPorUsuario($_GET["id_usu"] ?? null));
        break;

    case "subirImagenes":
        echo json_encode($controller->subirImagenes($data));
        break;

    case "insertarCategoria":
        echo json_encode($controller->insertarCategoria($data));
        break;

    case "crearTodo":
        echo json_encode($controller->insertarProductoConTodo($data));
        break;
        case 'productoVendido':
            if (isset($_GET['id_producto'])) {
                $resultado = $controller->productoVendido($_GET['id_producto']);
                echo json_encode($resultado);  // Solo se codifica una vez aquí
            } else {
                echo json_encode(["error" => "Falta el parámetro id_producto"]);
            }
            break;
            case 'editarProductoConTodo':
                // Asegúrate de recibir correctamente el ID
                if (isset($_GET['id_producto'])) {
                    $id_producto = $_GET['id_producto'];
                    // Lee el body como JSON
                    $json = file_get_contents("php://input");
                    $data = json_decode($json, true);
            
                    if ($data) {
                        require_once __DIR__ . '/../controllers/ProductoController.php';
                        $controller = new ProductoController();
                        echo json_encode($controller->editarProductoConTodo($id_producto, $data));
                    } else {
                        echo json_encode(["error" => "Datos JSON inválidos"]);
                    }
                } else {
                    echo json_encode(["error" => "Falta el parámetro id_producto"]);
                }
                break;
            
        

    default:
        echo json_encode(["error" => "Acción no válida"]);
        break;
}