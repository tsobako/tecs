----
--  Хранилище компонентов для даннвх.
--  С помощью этого хранилища мы запоминаем данные определенного типа для Entity.
---

with Ada.Containers.Ordered_Maps;
with Ada.Containers.Ordered_Sets;

generic
   type Element_Type is private;
package TECS.Component.DataStorage is

   type Storage is private;

   type Entity_Cursor is private;

   procedure Add
     (Components : in out Storage; Id : TECS.EntityId; A : Element_Type);
   procedure Update
     (Components : in out Storage; Id : TECS.EntityId; A : Element_Type);
   procedure Remove (Components : in out Storage; Id : TECS.EntityId);
   function Get (Components : Storage; Id : TECS.EntityId) return Element_Type;
   function Contains (Components : Storage; Id : TECS.EntityId) return Boolean;
   function Get_All
     (Components : Storage) return TECS.EntityVectorPackage.Vector;

   function Get_Cursor (Components : Storage) return Entity_Cursor;
   function Has_Element (Cursor : Entity_Cursor) return Boolean;
   procedure Next (Cursor : in out Entity_Cursor);
   function Get_Entity (Cursor : Entity_Cursor) return TECS.EntityId;
   function Get_Component_Data (Cursor : Entity_Cursor) return Element_Type;

   function Added
     (Components : in out Storage; Id : TECS.EntityId) return Boolean;
   function Updated
     (Components : in out Storage; Id : TECS.EntityId) return Boolean;
   function Removed
     (Components : in out Storage; Id : TECS.EntityId) return Boolean;

   procedure Flush (Components : in out Storage);

private
   package Component_Storage is new Ada.Containers.Ordered_Maps
     (Key_Type => TECS.EntityId, Element_Type => Element_Type);

   package EntityId_Set is new Ada.Containers.Ordered_Sets
     (Element_Type => TECS.EntityId);

   type Storage is record
      Data            : Component_Storage.Map;
      Current_Added   : EntityId_Set.Set;
      Current_Updated : EntityId_Set.Set;
      Current_Removed : EntityId_Set.Set;
      Before_Added    : EntityId_Set.Set;
      Before_Updated  : EntityId_Set.Set;
      Before_Removed  : EntityId_Set.Set;
   end record;

   type Entity_Cursor is record
      Data : Component_Storage.Cursor;
   end record;

end TECS.Component.DataStorage;
