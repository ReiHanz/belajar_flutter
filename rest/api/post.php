<?php
header("Content-Type: application/json; charset=UTF-8");
include_once "../config/database.php";

$database = new Database();
$db = $database->getConnection();

$data = json_decode(file_get_contents("php://input"));

$query = "INSERT INTO items (name, description) VALUES (:name, :description)";
$stmt = $db->prepare($query);

$stmt->bindParam(":name", $data->name);
$stmt->bindParam(":description", $data->description);

if ($stmt->execute()) {
    echo json_encode(["message" => "Item created successfully."]);
} else {
    echo json_encode(["message" => "Failed to create item."]);
}
?>
