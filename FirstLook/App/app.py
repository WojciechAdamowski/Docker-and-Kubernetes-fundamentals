from flask import Flask

app = Flask(__name__)

'''
Check that is file exist, if not it will create it
'''
def check_file():
    try:
        f = open("./data/data.txt", "r")
    except:
        f = open("./data/data.txt", "w")
        f.write("Hey thanks for look at my project!\n")
'''
When you route to "/read" it will read a file and return content to the website 
'''
@app.route("/read")
def read_messages():
    check_file()
    f_read = open("./data/data.txt", "r")
    file_content = ""

    i = 0
    for line in f_read:
        i += 1
        file_content += f"{i}. {line} <br>"

    f_read.close()
    return file_content

'''
When you route to "/append" it will add "new message" to the data.txt file
'''
@app.route("/append")
def add_message():
    check_file()
    f_append = open("./data/data.txt", "a")
    f_append.write("new message\n")
    f_append.close()

    return "YOU SUCCESFULLY ADD MESSAGE"

'''
When you open http://127.0.0.1:5000 it returns the following text
'''
@app.route("/")
def home():
    return "Flask project ver. 1"

if __name__ == '__main__':  
   app.run(host='0.0.0.0', port=5000, threaded=True)
