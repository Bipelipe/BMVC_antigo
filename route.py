from pathlib import Path

from bottle import Bottle, redirect, run, static_file

from app.controllers.application import Application


BASE_DIR = Path(__file__).resolve().parent
STATIC_DIR = BASE_DIR / "app" / "static"

app = Bottle()
controller = Application()


@app.get("/static/<filepath:path>")
def serve_static(filepath):
    """Entrega os arquivos CSS, JavaScript e imagens da aplicação."""
    return static_file(filepath, root=str(STATIC_DIR))


@app.get("/")
def index():
    """Mantém uma única URL principal e descritiva para o projeto."""
    return redirect("/foco")


@app.get("/foco")
def foco():
    """Rota da página estática renderizada pelo controlador BMVC."""
    return controller.render("foco")


if __name__ == "__main__":
    run(app, host="0.0.0.0", port=8080, debug=True)
