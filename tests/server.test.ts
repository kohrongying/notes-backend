import { superoak } from "https://deno.land/x/superoak@main/mod.ts";
import { app } from "../server.ts"

Deno.test("Get root path returns hello world", async () => {
  const request = await superoak(app);
  await request.get("/").expect("hello world");
});