----
--  Хранилище компонентов для флагов.
--  С помощью этого хранилища мы запоминаем имеет ли Entity признак или нет.
--  Поэтому операция Get недоступна
---

with Ada.Containers.Ordered_Sets;

package Tecs.Component.FlagStorage is

   type Storage is private;

   type Entity_Cursor is private;

   procedure Add (Components : in out Storage; Id : Tecs.EntityId);
   procedure Remove (Components : in out Storage; Id : Tecs.EntityId);
   function Contains (Components : Storage; Id : Tecs.EntityId) return Boolean;
   function Get_All
     (Components : Storage) return Tecs.EntityVectorPackage.Vector;

   function Get_Cursor (Components : Storage) return Entity_Cursor;
   function Has_Element (Cursor : Entity_Cursor) return Boolean;
   procedure Next (Cursor : in out Entity_Cursor);
   function Get_Entity
     (Cursor : Entity_Cursor) return Tecs.EntityId;

   function Added (Components : Storage; Id : Tecs.EntityId) return Boolean;
   function Removed (Components : Storage; Id : Tecs.EntityId) return Boolean;

   procedure Flush (Components : in out Storage);

private
   package Component_Storage is new Ada.Containers.Ordered_Sets
     (Element_Type => Tecs.EntityId);

   type Storage is record
      Data            : Component_Storage.Set;
      To_Add          : Component_Storage.Set;
      To_Remove       : Component_Storage.Set;
      Current_Added   : Component_Storage.Set;
      Current_Removed : Component_Storage.Set;
   end record;

   type Entity_Cursor is record
      Data : Component_Storage.Cursor;
   end record;

end Tecs.Component.FlagStorage;
