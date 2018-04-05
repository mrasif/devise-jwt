# Note API Server

```
curl -X POST \
  http://localhost:3000/api/login.json \
  -H 'Content-Type: application/json' \
  -d '{"email":"test@example.in","password":"12345678"}'
```
```
curl -X POST \
  http://localhost:3000/api/register.json \
  -H 'Content-Type: application/json' \
  -d '{"user":{"email":"test@example.in","password":"12345678", "profile_attributes":{"name":"Your name", "address":"Kolkata", "age":26}}}'
```
```
curl -X POST \
  http://localhost:3000/api/user.json \
  -H 'Authorization: <token>' \
```
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
            "address": "Kolkata",
            "created_at": "2018-04-05T05:00:40.430Z",
            "updated_at": "2018-04-05T07:37:12.546Z"
        }
    }
}'
```
```
curl -X POST \
  http://localhost:3000/api/logout.json \
  -H 'Authorization: <token>' \
```
```
curl -X GET \
  http://localhost:3000/api/notes.json \
  -H 'Authorization: <token>' \
```
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
