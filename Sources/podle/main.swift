import Foundation
import secp256k1
// import Security

class PoDLE {

    func generate_podle(priv: Data, index: Int = 0) -> [String: String] {

        print(priv, index)

        /*
        RANDOM:
        var bytes = [UInt8](repeating: 0, count: 32)
        SecRandomCopyBytes(kSecRandomDefault, bytes.count, &bytes)
        let k = Data(bytes: bytes)
        */
        

        // J = getNUMS(index)



        // kG



        // kJ



        // P = xG



        // P2 = xJ (x is priv)



        // H(P2) is commitment


        // Schnorr 
        // e = H(kG + kJ + P + P2)
        // s = k + x*e





        return ["P": "", 
                "P2": "", 
                "commit": "", 
                "sig": "", 
                "e": ""]
    }
    
    func exec() -> String {

        let k = Data.init(_: 
                [0xca, 0xf1, 0xba, 0xb5, 0xca, 0xef, 0xba, 0xd1,
                0x1b, 0xfe, 0xbd, 0xbe, 0x4a, 0xed, 0xbb, 0x2e,
                0xda, 0xfd, 0xaa, 0xbc, 0x2a, 0xe3, 0x44, 0x3e,
                0x1a, 0x3f, 0xbd, 0x4e, 0x62, 0xfe, 0xea, 0xae])
        
        let key = try! secp256k1.Signing.PublicKey(rawRepresentation: k)
        print(key)

        return "\(key)"
    }
}

let p = PoDLE()

let key = Data.init(_: 
                [0xca, 0xfe, 0xba, 0xb5, 0xca, 0xfe, 0xba, 0xde,
                0x1a, 0xfe, 0xbd, 0xbe, 0x4a, 0xed, 0xbd, 0xae,
                0xca, 0xfd, 0xaa, 0xbc, 0xca, 0xfe, 0xba, 0xde,
                0x1a, 0xfe, 0xbd, 0xbe, 0x62, 0xfe, 0xea, 0xae])

// print(p.generate_podle(priv: key, index: 11))

print(p.exec())