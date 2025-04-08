with Ada.Containers.Vectors;

generic
   type Event_Type is private;
package TECS.Events is

   type Storage is private;

   package Events_Storage is new Ada.Containers.Vectors
     (Index_Type => Natural, Element_Type => Event_Type);

   subtype Events_Vector is Events_Storage.Vector;

   procedure Add (S : in out Storage; E : Event_Type);
   function Get_All (S : Storage) return Events_Vector;
   procedure Flush (S : in out Storage);
   function Contains (S : Storage; E : Event_Type) return Boolean;

private

   type Storage is record
      Current : Events_Storage.Vector;
      Buffer  : Events_Storage.Vector;
   end record;

end TECS.Events;
