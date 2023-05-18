// Declaración del contrato
contract Apuesta {
    // Variable para almacenar el saldo del contrato
    uint public saldoContrato;
    // Mapeo para almacenar los saldos de los participantes
    mapping(address => uint) public saldosParticipantes;

    // Evento para notificar cuando se realiza un pago
    event PagoRealizado(address apostador, uint monto);

    // Función para realizar una apuesta y enviar el monto al contrato
    function apostar() public payable {
        require(msg.value > 0, "El monto de la apuesta debe ser mayor a cero.");
        
        // Aumentar el saldo del contrato
        saldoContrato += msg.value;
        // Añadir el monto apostado al saldo del participante
        saldosParticipantes[msg.sender] += msg.value;
    }

    // Función para realizar el pago cuando se gana la apuesta
    function pagarGanador(address ganador, uint montoPremio) public {
        require(saldosParticipantes[ganador] >= montoPremio, "No hay suficiente saldo para realizar el pago.");
        
        // Reducir el saldo del ganador
        saldosParticipantes[ganador] -= montoPremio;
        // Reducir el saldo del contrato
        saldoContrato -= montoPremio;
        
        // Realizar el pago al ganador
        payable(ganador).transfer(montoPremio);
        emit PagoRealizado(ganador, montoPremio);
    }
}