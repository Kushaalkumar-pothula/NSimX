import numpy as np
import matplotlib.pyplot as plt
import imageio

fid = [str(i) for i in range(1,38)] # File 'IDs' or iteration numbers
fname = ["particles."+ str(i)+".dat" for i in fid] # Get full filenames
imname = [str(i)+".png" for i in fname]

for file in fname:
    pos = np.loadtxt(file)
    
    x = pos[:,0]
    y = pos[:,1]
    
    
    
    fig = plt.figure(figsize=(10, 10))
    plt.scatter(x,y,color='black')
    plt.xlim((-0.5,0.5))
    plt.ylim((-0.5,0.5))
    plt.grid(True)
    plt.savefig(file+'.png')
    plt.close()

writer = imageio.get_writer('movie.mp4')

for im in imname:
    writer.append_data(imageio.imread(im))
writer.close()
    