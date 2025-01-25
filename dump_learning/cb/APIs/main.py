from fastapi import FastAPI

app = FastAPI()


food_items = {
    'indian': ['Samosa', 'Curry'],
    'italian': ['Pizza', 'Pasta']
}

@app.get("/get_items/{cuisine}")
def get_items(cuisine):
    items = food_items.get(cuisine)
    if not items:
        return f"{cuisine} is not available"
    return items



# @app.get("/")
# def hello():
#     return "hello"