
import express, {Application, Request, Response, NextFunction} from "express";

const app:Application = express();

app.get("/",(req:Request, res:Response, next:NextFunction) => {
    res.json({"message":"OK"})
})

app.listen(8080, () => {
    console.log("Server running on port ", 8080)
});

export { app }

