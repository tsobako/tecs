package body TECS.Commands is

   procedure Push (Commands : in out Queue; Command : Command_Type) is
   begin
      Commands_Queue.Append (Commands.Data, Command);
   end Push;

   function Exists (Commands : Queue) return Boolean is
   begin
      return not Commands_Queue.Is_Empty(Commands.Data);
   end Exists;

   function Get_All (Commands : Queue) return Commands_Vector is
   begin
      return Commands_Queue.Copy (Commands.Data, Commands.Data.Length);
   end Get_All;

   procedure Flush (Commands : in out Queue) is
   begin
      Commands_Queue.Clear (Commands.Data);
   end Flush;

end TECS.Commands;