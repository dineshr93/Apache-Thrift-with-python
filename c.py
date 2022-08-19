import sys
import glob
sys.path.append('gen-py')
sys.path.insert(0, glob.glob('lib'))

from tutorial import Calculator
from tutorial.ttypes import InvalidOperation, Operation, Work

from thrift import Thrift
from thrift.transport import TSocket
from thrift.transport import TTransport
from thrift.protocol import TBinaryProtocol


def main():
    # Make socket
    transport = TSocket.TSocket('localhost', 9090)

    # Buffering is critical. Raw sockets are very slow
    transport = TTransport.TBufferedTransport(transport)

    # Wrap in a protocol
    protocol = TBinaryProtocol.TBinaryProtocol(transport)

    # Create a client to use the protocol encoder
    client = Calculator.Client(protocol)

    # Connect!
    transport.open()

    client.ping()
    print('ping()')
    
    a=100
    b=5

    sum_ = client.add(a, b)
    print(f"{a}+{b}={sum_}")

    work = Work()

    work.op = Operation.DIVIDE
    work.num1 = 100
    work.num2 = 2

    try:
        quotient = client.calculate(1, work)
        print('Whoa? You know how to divide by zero?')
        print('FYI the answer is %d' % quotient)
    except InvalidOperation as e:
        print('InvalidOperation: %r' % e)

    work.op = Operation.SUBTRACT
    work.num1 = 150
    work.num2 = 200

    diff = client.calculate(1, work)
    print(f"{work.num1}-{work.num2}={diff}")

    log = client.getStruct(1)
    print(f"Check log: {log.value}")

    # Close!
    transport.close()
    
if __name__ == '__main__':
    main()