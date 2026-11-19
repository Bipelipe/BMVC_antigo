from bottle import HTTPError, template


class Application:
    """Controlador central: escolhe a action e prepara dados para a view."""

    def __init__(self):
        self.pages = {
            "foco": self.foco,
        }

    def render(self, page):
        action = self.pages.get(page)
        if action is None:
            raise HTTPError(404, "Página não encontrada")
        return action()

    def foco(self):
        """Entrega um plano ilustrativo para o template Bottle."""
        tarefas = [
            {
                "id": "classes-objetos",
                "area": "Fundamentos",
                "titulo": "Revisar classes e objetos",
                "descricao": "Transformar um problema simples em atributos e métodos.",
                "tempo": "25 min",
            },
            {
                "id": "encapsulamento",
                "area": "Projeto",
                "titulo": "Praticar encapsulamento",
                "descricao": "Proteger o estado interno e expor uma interface coerente.",
                "tempo": "30 min",
            },
            {
                "id": "heranca",
                "area": "Reuso",
                "titulo": "Comparar herança e composição",
                "descricao": "Registrar quando cada relação deixa o código mais claro.",
                "tempo": "35 min",
            },
            {
                "id": "polimorfismo",
                "area": "Comportamento",
                "titulo": "Criar um exemplo polimórfico",
                "descricao": "Usar a mesma operação com implementações diferentes.",
                "tempo": "40 min",
            },
        ]

        return template(
            "app/views/html/foco",
            tarefas=tarefas,
            total_tarefas=len(tarefas),
        )
