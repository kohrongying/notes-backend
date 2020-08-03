import { superoak } from "https://deno.land/x/superoak@2.0.0/mod.ts";
import { app } from "../server.ts";
import {
  assertEquals,
} from "https://deno.land/std/testing/asserts.ts";
import todos from "../stub.ts";

Deno.test("Get root path returns hello world", async () => {
  const request = await superoak(app);
  await request.get("/").expect("hello world");
});

Deno.test("Get all todos", async () => {
  const request = await superoak(app);
  await request.get("/todos").expect((res) => {
    assertEquals(res.status, 200);
    assertEquals(res.body.success, true);
    assertEquals(res.body.data.length, todos.length);
  });
});

Deno.test("Get todo when id is invalid", async () => {
  const request = await superoak(app);
  const todo = todos[0];
  await request.get(`/todos/${todo.id}`).expect((res) => {
    assertEquals(res.status, 200);
    assertEquals(res.body.success, true);
    assertEquals(res.body.data, todo);
  });
});

Deno.test("Get 404 when todo id is invalid ", async () => {
  const request = await superoak(app);
  await request.get(`/todos/abc`).expect((res) => {
    assertEquals(res.status, 404);
    assertEquals(res.body.success, false);
  });
});
