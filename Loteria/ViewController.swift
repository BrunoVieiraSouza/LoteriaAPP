//
//  ViewController.swift
//  Loteria
//
//  Created by Bruno Vieira Souza on 04/10/21.
//

import UIKit


enum GameType: String {  // faco um enum para informar quais sao os dois tipo de jogos que temos e ja setar um valor para cada um deles
    case megasena = "Mega-Sena"
    case quina = "Quina"
}

func sorteioRandomico (total: Int, universe: Int) -> [Int] {
    var resultado: [Int] = []
    while resultado.count < total {
        let randomicos = Int(arc4random_uniform(UInt32(universe))+1)
        if !resultado.contains(randomicos) {
            resultado.append(randomicos)
        }
    }
    return resultado.sorted()
}



class ViewController: UIViewController {

    @IBOutlet weak var labelGameType: UILabel!
    @IBOutlet weak var scLabelGameType: UISegmentedControl!
    @IBOutlet var balls: [UIButton]! //AQUI EU CRIO UMA ARRAY DE BUTOES... CRIANDO EM ORDENS PARA MANTER O INDICE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        aparecerNumeros(for: .megasena)
       
    }
    
    
    func aparecerNumeros (for type: GameType) {
        labelGameType.text = type.rawValue
        var game:[Int] = []
        switch type {
        case .megasena :
            game = sorteioRandomico(total: 6, universe: 60)
            balls.last!.isHidden = false
        case .quina :
            game = sorteioRandomico(total: 5, universe: 80)
            balls.last!.isHidden = true
        }
        
        for (index, game) in game.enumerated() { // enumerated, ele traz uma tupla ... com o indice e valor. logo apos eu faco um for pegando o indicce da balls e colocando o valor game em cada indice correspodente.
            balls[index].setTitle("\(game)", for: .normal)
        }
    }
    
    @IBAction func geradorJogos() {
        switch scLabelGameType.selectedSegmentIndex { // metodo selected para verificar qual item esta selecionada
        case 0:
            aparecerNumeros(for: .megasena)
        default:
            aparecerNumeros(for: .quina)
        }
        
    }
    
    
}

