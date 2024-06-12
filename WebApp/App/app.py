from flask import Flask

app = Flask(__name__)

@app.route("/read")
def read_messages():
    f_read = open("./data/data.txt", "r")
    file_content = ""

    i = 0
    for line in f_read:
        i += 1
        file_content += f"{i}. {line} <br>"

    f_read.close()
    return file_content

@app.route("/append")
def add_message():
    f_append = open("./data/data.txt", "a")
    f_append.write("new message\n")
    f_append.close()

    return "YOU SUCCESFULLY ADD MESSAGE"

@app.route("/")
def home():
    return "Flask project ver. 1"

if __name__ == '__main__':  
   app.run(host='0.0.0.0', port=5000, threaded=True)
