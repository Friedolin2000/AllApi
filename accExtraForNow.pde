


// used by?
public byte[] int2b(int value){
  return java.nio.ByteBuffer.allocate(4).putInt(value).array();
}
