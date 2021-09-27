// import Accelerate
/* 
    replace Int with UInt512
    (UInt256 does not suffice because of modulo operation)
*/

struct Point {
    var x: Int
    var y: Int

    init(_ x: Int = 0, _ y: Int = 0)
    {
        self.x = x
        self.y = y
    }
}

class secp256k1 {
    // y**2 = x**3 + 7

    // p = 115792089237316195423570985008687907853269984665640564039457584007908834671663
    // N = 115792089237316195423570985008687907852837564279074904382605163141518161494337
    static let p: Int = 11 // prime
    static let N: Int = 19

    static func modinv(_ num: Int) -> Int
    {
        var inv: Int = 1
        var a = num
        if a < 0 {a += p}

        var w: Int = p - 2;
    
        while w > 0 {
            if w % 2 == 1 {inv = (inv * a) % p}
            a = (a * a) % p
            w = w / 2;
        }
        return inv
    }

    // x = 55066263022277343669578718895168534326250603453777594175500187360389116729240
    // y = 32670510020758816978083085130507043184471273380659243275938904335757337482424
    static var G: Point = Point(2, 3)

    let basePoint: Point
    init(_ p: Point = G) {
        basePoint = p
    }

    // P + Q
    static func add(P: Point, Q: Point) -> Point
    {
        let lamda = ((Q.y - P.y)%p * modinv((Q.x - P.x)%p))%p

        var R = Point()
        R.x = ((lamda * lamda)%p - (P.x + Q.x)%p)%p
        if R.x < 0 {R.x += p}

        R.y = ((lamda * (P.x - R.x)%p)%p - P.y)%p
        if R.y < 0 {R.y += p}

        return R
    }

    // 2*P
    static func double(P: Point) -> Point
    {
        let lamda = ((3*(P.x * P.x)%p)%p * modinv((2 * P.y)%p)%p)%p

        var R = Point()
        R.x = ((lamda * lamda)%p - (P.x + P.x)%p)%p
        if R.x < 0 {R.x += p}

        R.y = ((lamda * (P.x - R.x)%p)%p - P.y)%p
        if R.y < 0 {R.y += p}

        return R
    }

    // s*P
    static func multiply(P: Point, s: Int) -> Point
    {
        var Q = P, R = P
        var m = s - 1

        while m > 0
        {
            if m % 2 == 1 {
                if Q.x == R.x {R = double(P: R)}
                else {R = add(P: R, Q: Q)}
            }
            Q = double(P: Q)
            m = m / 2
        }
        return R
    }

    func publicKey(priv: Int) -> Point
    {
        return secp256k1.multiply(P: self.basePoint, s: priv)
    }
}
