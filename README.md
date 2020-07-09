# Routes

| HTTP Verb |  Path  | Controller#Action | Request's Body Params | Respnse If Fails |         Response If Successfull           |
| --------- |  ----  | ----------------- | --------------------- | ---------------- |         -----------------------           |
|   GET     | /posts | posts#index       |           _           |        _         |   {successfull: true, posts: __posts__}   |
| --------- |  ----  | ----------------- | --------------------- | ---------------- |         -----------------------           |
| GET | /posts/:id | posts#show | _ | _ | {successfull: true, post: __post__}
| --------- |  ----  | ----------------- | --------------------- | ---------------- |         -----------------------           |
| POST | /posts | posts#destroy | {post: {title: __title__, body: __body__}} | {successfull: false, errors: __post.errors__} | {successfull: true}
| --------- |  ----  | ----------------- | --------------------- | ---------------- |         -----------------------           |
| PUT | /posts/:id | posts#update | {post: {title, __title__, body: __body__}} | {successfull: false, errors: __post.errors__} | {successfull: true}
| --------- |  ----  | ----------------- | --------------------- | ---------------- |         -----------------------           |
| DELETE | /posts/:id | posts#destroy | _ | {successfull: false, errors: __post.errors__} | {successfull: true}
| --------- |  ----  | ----------------- | --------------------- | ---------------- |         -----------------------           |
| POST | /login | sessions#create | {email: __email__, password: __password__} | {successfull: false, errors: __auth.errors/"Invalid Credentials"__} | {successfull: true, code: code}
| --------- |  ----  | ----------------- | --------------------- | ---------------- |         -----------------------           |
| DELETE | /logout | sessions#destroy | _ | {successfull: false, errors: __auth.errors__} | {successfull: true}
| --------- |  ----  | ----------------- | --------------------- | ---------------- |         -----------------------           |
| GET | /dashboard | authors#dashboard | _ | _ | {successfull: true, user: __user__}
| --------- |  ----  | ----------------- | --------------------- | ---------------- |         -----------------------           |
| PUT | /dashboard | authors#update | {author: {full_name: __full_name__}} | {successfull: false, errors: __author.errors__} | {successfull: true}
| --------- |  ----  | ----------------- | --------------------- | ---------------- |         -----------------------           |
| DELETE | /dashboard | authors#destroy | _ | {successfull: false, errors: __author.errors__} | {successfull: true}
| --------- |  ----  | ----------------- | --------------------- | ---------------- |         -----------------------           |
| POST | /sign_up | authors#create | {author: {full_name: __full_name__, email: __email__, password: __password__, password_confirmation: _password_confirmation__}}
