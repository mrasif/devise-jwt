# Note API Server
### Login:
```
curl -X POST \
  http://localhost:3000/api/login.json \
  -H 'Content-Type: application/json' \
  -d '{"email":"test@example.in","password":"12345678"}'
```
### Registration:
```
curl -X POST \
  http://localhost:3000/api/register.json \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  -H 'content-type: multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW' \
  -F 'user[email]=test@example.in' \
  -F 'user[password]=12345678' \
  -F 'user[profile_attributes][name]=Your name' \
  -F 'user[profile_attributes][address]=Kolkata' \
  -F 'user[profile_attributes][age]=26' \
  -F 'user[profile_attributes][image]=@/home/.../image.png'
```
### User Details:
```
curl -X POST \
  http://localhost:3000/api/user.json \
  -H 'Authorization: <token>' \
```
### Update User:
```
curl -X PATCH \
  http://localhost:3000/api/update_user.json \
  -H 'Authorization: <token>' \
  -H 'Content-Type: application/json' \
  -d '{"user": {
        "email": "test@example.in",
        "profile_attributes": {
            "name": "Your name",
            "age": 26,
            "address": "Kolkata"
        }
    }
}'
```
### Logout:
```
curl -X POST \
  http://localhost:3000/api/logout.json \
  -H 'Authorization: <token>' \
```
### Get Notes:
```
curl -X GET \
  http://localhost:3000/api/notes.json \
  -H 'Authorization: <token>' \
```
### Create Note:
```
curl -X POST \
  http://localhost:3000/api/notes.json \
  -H 'Authorization: <token>' \
  -H 'Content-Type: application/json' \
  -d '{"note":{
        "title": "note 3",
        "body": "text 3"
	}
}'
```
### Update Note:
```
curl -X PATCH \
  http://localhost:3000/api/notes.json \
  -H 'Authorization: <token>' \
  -H 'Content-Type: application/json' \
  -d '{"note":{
		"id":5,
        "title": "note 4",
        "body": "text 4"
	}
}'
```
### Delete Note:
```
curl -X DELETE \
  http://localhost:3000/api/notes.json \
  -H 'Authorization: <token>' \
  -H 'Content-Type: application/json' \
  -d '{"note":{
		"id":5,
        "title": "note 4",
        "body": "text 4"
	}
}'
```
