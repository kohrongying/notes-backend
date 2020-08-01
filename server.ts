import { Application } from 'https://deno.land/x/oak/mod.ts'
import { Router } from 'https://deno.land/x/oak/mod.ts'
import * as flags from "https://deno.land/std/flags/mod.ts";

import todos from "./stub.ts";

const {args} = Deno;
const DEFAULT_PORT = 8000;
const argPort = flags.parse(args).port;
const port = argPort ? Number(argPort) : DEFAULT_PORT;

const app = new Application();
const router = new Router();

app.use(router.routes());
app.use(router.allowedMethods());


router.get('/todos', ({response}: {response:any})=>{
    response.body = todos;
});

console.log(`Server is running on port ${port}`)

await app.listen({ port });