<?php
header("Content-Type: application/json; charset=UTF-8");
include_once "../config/database.php";

$database = new Database();
$db = $database->getConnection();

$data = json_decode(file_get_contents("php://input"));

$query = "UPDATE items SET name = :name, description = :description WHERE id = :id";
$stmt = $db->prepare($query);

$stmt->bindParam(":name", $data->name);
$stmt->bindParam(":description", $data->description);
$stmt->bindParam(":id", $data->id);

if ($stmt->execute()) {
    echo json_encode(["message" => "Item updated successfully."]);
} else {
    echo json_encode(["message" => "Failed to update item."]);
}
?>
