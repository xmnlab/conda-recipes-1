import sys
import os
from numba.cuda.cudadrv.libs import test

sys.exit(0 if test() else 1)
