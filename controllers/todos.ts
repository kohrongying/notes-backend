import todos from "../stub.ts";
import { Todo } from "../types.ts";

const getTodos = ({ response }: { response: any }) => {
  response.body = {
    success: true,
    data: todos,
  };
};

const getTodo = (
  { params, response }: { params: { id: string }; response: any },
) => {
  const todo: Todo | undefined = todos.find((p) => p.id === params.id);

  if (todo) {
    response.status = 200;
    response.body = {
      success: true,
      data: todo,
    };
  } else {
    response.status = 404;
    response.body = {
      success: false,
      msg: "No todo found",
    };
  }
};
export { getTodos, getTodo };
