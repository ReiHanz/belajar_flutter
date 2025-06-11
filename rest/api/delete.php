<?php
header("Content-Type: application/json; charset=UTF-8");
include_once "../config/database.php";

$database = new Database();
$db = $database->getConnection();

$data = json_decode(file_get_contents("php://input"));

$query = "DELETE FROM items WHERE id = :id";
$stmt = $db->prepare($query);

$stmt->bindParam(":id", $data->id);

if ($stmt->execute()) {
    echo json_encode(["message" => "Item deleted successfully."]);
} else {
    echo json_encode(["message" => "Failed to delete item."]);
}
?>
