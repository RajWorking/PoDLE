import Foundation
// import Security
import secp256k1

class PoDLE {

    func generate_podle(priv: Int, index: Int = 0) -> [String: String] {

        print(priv, index)

        /*
        RANDOM:
        var bytes = [UInt8](repeating: 0, count: 32)
        SecRandomCopyBytes(kSecRandomDefault, bytes.count, &bytes)
        let k = Data(bytes: bytes)
        */        

        let baseGen = secp256k1()
        let k = 1987
    
        //// kG
        let kG = baseGen.publicKey(priv: k)

        //// P = xG
        let P = baseGen.publicKey(priv: priv)


        //// J = getNUMS(index)
        

        // let altGen = secp256k1(J)

        //// kJ
        // let kJ = altGen.publicKey(priv: k)

        //// P2 = xJ (x is priv)
        // let P2 = altGen.publicKey(priv: priv)

        //// H(P2) is commitment
        let commit = SHA256(P)
        print(commit)

        // Schnorr 
        // e = H(kG + kJ + P + P2)
        // s = k + x*e

        /*
            e is hash of 1024 bit integer
        */

        let s = (k + (priv * e)%secp256k1.N)%secp256k1.N

        return ["P": P, 
                "P2": "", 
                "commit": commit, 
                "sig": s, 
                "e": e]
    }
    
    func exec() -> String {

        let key = Data.init(_: 
                [0xca, 0xf1, 0xba, 0xb5, 0xca, 0xef, 0xba, 0xd1,
                0x1b, 0xfe, 0xbd, 0xbe, 0x4a, 0xed, 0xbb, 0x2e,
                0xda, 0xfd, 0xaa, 0xbc, 0x2a, 0xe3, 0x44, 0x3e,
                0x1a, 0x3f, 0xbd, 0x4e, 0x62, 0xfe, 0xea, 0xae])
        

        return "\(key)"
    }
}

let p = PoDLE()

print(p.exec())