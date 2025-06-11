// GET Data
fetch('api/get.php')
    .then(response => response.json())
    .then(data => console.log(data));

// POST Data
fetch('api/post.php', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ name: 'New Item', description: 'Description here' })
})
    .then(response => response.json())
    .then(data => console.log(data));

// PUT Data
fetch('api/put.php', {
    method: 'PUT',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ id: 1, name: 'Updated Item', description: 'Updated description' })
})
    .then(response => response.json())
    .then(data => console.log(data));

// DELETE Data
fetch('api/delete.php', {
    method: 'DELETE',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ id: 1 })
})
    .then(response => response.json())
    .then(data => console.log(data));
