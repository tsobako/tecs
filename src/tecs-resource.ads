generic
   type Resource_Type is private;
package Tecs.Resource is

   type Storage_Type is private;

   procedure Add (Storage : in out Storage_Type; Resource : Resource_Type);
   procedure Set (Storage : in out Storage_Type; Resource : Resource_Type);
   procedure Update
     (Storage : in out Storage_Type;
      F       : not null access procedure (Resource : in out Resource_Type));
   procedure Remove (Storage : in out Storage_Type);
   function Get (Storage : Storage_Type) return Resource_Type;

   function Not_Empty (Storage : Storage_Type) return Boolean;
   function Is_Added (Storage : Storage_Type) return Boolean;
   function Is_Removed (Storage : Storage_Type) return Boolean;
   function Is_Updated (Storage : Storage_Type) return Boolean;

   procedure Flush (Storage : in out Storage_Type);

private

   type Storage_Type is record
      Exists    : Boolean := False;
      Added     : Boolean := False;
      Removed   : Boolean := False;
      Updated   : Boolean := False;
      To_Add    : Boolean := False;
      To_Remove : Boolean := False;
      To_Update : Boolean := False;
      Value     : Resource_Type;
   end record;

end Tecs.Resource;
