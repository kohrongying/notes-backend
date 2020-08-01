Deploy to heroku instructions
```
# Procfile
web: deno run --allow-net=:${PORT} --cached-only server.ts --port=${PORT}
```

In the terminal, run:
```
heroku create ry-deno
heroku buildpacks:set https://github.com/chibat/heroku-buildpack-deno.git -a ry-deno
git push heroku master
```