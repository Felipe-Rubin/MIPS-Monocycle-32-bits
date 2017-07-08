-- T2 Organizacao e Arquitetura de Computadores I
-- Year 2017/1
-- Members: Felipe Rubin, Yuri Bittencourt, Vinicius Cerutti
-- File:  cpu.vhd
-- Description: Connects the architecture components




library ieee;
use ieee.std_logic_1164.all;

entity cpu is
	port(
		clk,rst : in std_logic
	);
end entity;

architecture acpu of cpu is

	signal instruction : std_logic_vector(31 downto 0);
	signal pc : std_logic_vector(31 downto 0);
	signal new_pc : std_logic_vector(31 downto 0);
	
	signal branch_ne : std_logic;
	signal sign_extend : std_logic;
	signal RegWrite,RegDst,ALUSrc : std_logic;
	signal Branch,MemRead,MemWrite,MemToReg : std_logic;
	signal ALUOp : std_logic_vector(2 downto 0);

	signal pc_adder_out : std_logic_vector(31 downto 0);

	signal writeReg : std_logic_vector(4 downto 0);
	signal writeData : std_logic_vector(31 downto 0);
	signal readData1, readData2 : std_logic_vector(31 downto 0);

	signal sign_extend_out : std_logic_vector(31 downto 0);
	signal zero_extend_out : std_logic_vector(31 downto 0);

	signal mux_sign_ext_out : std_logic_vector(31 downto 0);

	-- alu control operation
	signal aluco : std_logic_vector(3 downto 0);

	-- Entrada da 1 da ula, saida do mux
	signal alu_e2 : std_logic_vector(31 downto 0);

	--
	signal Zero : std_logic;
	signal ALUresult : std_logic_vector(31 downto 0);

	signal shift_left_2_out : std_logic_vector(31 downto 0);

	signal branch_adder_out : std_logic_vector(31 downto 0);

	signal PCSrc : std_logic;

	signal ram_read_data : std_logic_vector(31 downto 0);

	--

	signal opcode,func : std_logic_vector(5 downto 0);
	signal rs,rt,rd,shamt : std_logic_vector(4 downto 0);
	signal imm : std_logic_vector(15 downto 0);


begin
	PC_ENTITY : entity work.pc
		port map(
				clk => clk,
				rst => rst,
				pc_in => new_pc,
				pc_out => pc
			);

	INSTRUCTION_MEMORY : entity work.InstructionMemory
		port map(
	 		clk => clk,
	 		rst => rst,
	 		address => pc,
	 		instr_out => instruction

		);

	opcode <= instruction(31 downto 26);
	rs <= instruction(25 downto 21);
	rt <= instruction(20 downto 16);
	rd <= instruction(15 downto 11);
	shamt <= instruction(10 downto 6);
	func <= instruction(5 downto 0);
	imm <= instruction(15 downto 0);

	CONTROL : entity work.control
		port map (
			clk => clk,
			rst => rst,
			instr => opcode,
			Branch_NE => branch_ne,
			Sign_Ext => sign_extend,
			RegWrite => RegWrite,
			RegDst => RegDst,
			ALUSrc => ALUSrc,
			Branch => Branch,
			MemRead => MemRead,
			MemWrite => MemWrite,
			MemToReg => MemToReg,
			ALUOp => ALUOp
	 	);

	-- Adder logo apos o pc
	PC_ADDER : entity work.adder
		port map(
			e0 => pc,
			e1 => "00000000000000000000000000000100",
			s1 => pc_adder_out
		);

	-- mux que decide qual registrador em que vai ser escrito
	MUX_WRITE_REG : entity work.mux
		generic map (n => 5)
		port map(
			  e0 => rt,
			  e1 => rd,
			  sel => RegDst,
			  s1 => writeReg
		);

		-- Banco de Registradores
	REGISTER_BLOCK : entity work.registerBlock
		port map(
			regWrite => regWrite,
			clk => clk,
			rst => rst,
			readReg1 => rs,
			readReg2 => rt,
			writeReg => writeReg,
			writeData => writeData,
			readData1 => readData1,
			readData2 => readData2
		);

	SIGN_EXT : entity work.signExtend
		port map(
			in_16 => imm,
			out_32 => sign_extend_out
		);

	ZERO_EXT : entity work.zeroExtend
		port map(
			in_16 => imm,
			out_32 => zero_extend_out

		);
	MUX_SIGN_EXT : entity work.mux
		generic map (n => 32)
		port map(
			  e0 => zero_extend_out,
			  e1 => sign_extend_out,
			  sel => sign_extend,
			  s1 => mux_sign_ext_out
		);

	ALU_CONTROL : entity work.alucontrol
		port map(
			clk => clk,
			rst => rst,
			ALUOp => ALUOp,
			func => func,
			aluco => aluco -- alu control op
		);

	MUX_ALU : entity work.mux
		generic map (n => 32)
		port map(
			  e0 => readData2,
			  e1 => mux_sign_ext_out,
			  sel => ALUSrc,
			  s1 => alu_e2
		);

	ALU : entity work.alu
		port map(
			clk => clk,
			rst => rst,
			e1 => readData1,
			e2 => alu_e2,
			aluco => aluco,
			shamt => shamt,
			ALUresult => ALUresult,
			Zero => Zero
		);

	SHIFT_LEFT_2 : entity work.shiftleft2
		port map(
			e1 => mux_sign_ext_out,
			s1 => shift_left_2_out
		);

	-- Adder logo apos o pc
	BRANCH_ADDER : entity work.adder
		port map(
			e0 => pc_adder_out,
			e1 => shift_left_2_out,
			s1 => branch_adder_out
		);

	MUX_BRANCH : entity work.mux
		generic map (n => 32)
		port map(
			  e0 => pc_adder_out,
			  e1 => branch_adder_out,
			  sel => PCSrc,
			  s1 => new_pc
		);		

	RAM : entity work.ram
		port map(
			memWrite => memWrite,
			memRead => memRead,
			clk => clk,
			rst => rst,
			address => ALUresult,
			writeData => readData2,
			readData => ram_read_data
		);
	
	MUX_RAM : entity work.mux
		generic map (n => 32)
		port map(
			  e1 => ram_read_data,
			  e0 => ALUresult,
			  sel => MemToReg,
			  s1 => writeData
		);	

-- PCSrc alterado pro caso do Branch_NE
PCSrc <= (Branch and Zero) or (Branch_NE and (not Zero));



end architecture;

