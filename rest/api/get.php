<?php
header("Content-Type: application/json; charset=UTF-8");
include_once "../config/database.php";

$database = new Database();
$db = $database->getConnection();

$query = "SELECT * FROM items";
$stmt = $db->prepare($query);
$stmt->execute();

$data = $stmt->fetchAll(PDO::FETCH_ASSOC);

echo json_encode($data);
?>
