with Ada.Containers.Vectors;

generic
   type Command_Type is private;
package TECS.Commands is

   type Queue is private;

   package Commands_Queue is new Ada.Containers.Vectors
     (Index_Type => Natural, Element_Type => Command_Type);

   subtype Commands_Vector is Commands_Queue.Vector;

   procedure Push (Commands : in out Queue; Command : Command_Type);
   function Exists (Commands: Queue) return Boolean;
   function Get_All (Commands : Queue) return Commands_Vector;
   procedure Flush (Commands : in out Queue);

private

   type Queue is record
      Data : Commands_Vector;
   end record;

end TECS.Commands;
