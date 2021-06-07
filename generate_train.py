import os

os.getcwd()
def generatetxt(selection):
  test_image_files = []
  os.chdir(os.path.join("data", selection))
  for filename in os.listdir(os.getcwd()):
    if filename.endswith(".jpeg") or filename.endswith(".jpg"):
      test_image_files.append(f"data/{selection}/" + filename)
  os.chdir("..")
  with open(f"{selection}.txt", "w") as outfile:
    for image in test_image_files:
      outfile.write(image)
      outfile.write("\n")
    outfile.close()
  os.chdir("..")

generatetxt("train")
generatetxt("test")