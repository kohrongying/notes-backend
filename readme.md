# Deployment
## Deploy to heroku

1. Add procfile
```
# Procfile
web: deno run --allow-net=:${PORT} --cached-only server.ts --port=${PORT}
```

2. Set up Git repo
```
git init
git add .
git commit -m "First commit"
```

3. In the terminal, run:
```
heroku create ry-deno
heroku buildpacks:set https://github.com/chibat/heroku-buildpack-deno.git -a ry-deno
git remote add heroku https://git.heroku.com/ry-deno.git
git push heroku master
```

Go to https://ry-deno.herokuapp.com/todos