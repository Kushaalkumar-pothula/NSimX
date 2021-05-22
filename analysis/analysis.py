# Import required libraries
import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import axes3d
import imageio


# Set up filenames
fid = [str(i) for i in range(1,10)] # File 'IDs' or iteration numbers
fname = ["snapshot"+ str(i)+".txt" for i in fid] # Get full filenames
imname = [str(i)+".png" for i in fname]


# Make frames for animation
for file in fname:
    pos = np.loadtxt(file)
    
    x = pos[:,0]
    y = pos[:,1]
    z = pos[:,2]
    
    fig = plt.figure(figsize=(10, 10))
    ax = fig.add_subplot(111, projection='3d')
    
    ax.set_xlim(0,100)
    ax.set_ylim(0,100)
    ax.set_zlim(0,100)
    
    ax.scatter3D(x,y,z,color='b',alpha=0.5)
    
    plt.savefig(file+'.png')
    plt.close()

    
# Make animation from saved frames
writer = imageio.get_writer('movie.mp4')

for im in imname:
    writer.append_data(imageio.imread(im))
writer.close()
