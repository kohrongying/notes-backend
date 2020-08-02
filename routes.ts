import { Router } from 'https://deno.land/x/oak/mod.ts'
import { getTodos, getTodo } from "./controllers/todos.ts"

const router = new Router();

router.get('/', ({response}: {response:any}) => {
  response.body = 'hello world';
});

router.get('/todos', getTodos)
      .get('/todos/:id', getTodo)

export default router;