with Ada.Containers.Vectors;

generic
   type State_Type is (<>);
package Tecs.State is

   type Storage is private;

   procedure Init (State : in out Storage; Next : State_Type);

   procedure Set (State : in out Storage; Next : State_Type);

   function Contains (State : Storage; Current : State_Type) return Boolean;

   function Current (State : Storage) return State_Type;

   --  Вошли ли в стейт
   function Entered_In (State : Storage; S : State_Type) return Boolean;

   --  Вышли ли из стейта
   function Leaved_Out (State : Storage; S : State_Type) return Boolean;

   --  Был ли переход из стейта в стейт
   function Transitioned
     (State : Storage; From : State_Type; To : State_Type) return Boolean;

   procedure Flush (State : in out Storage);

private

   package State_Queue is new Ada.Containers.Vectors
     (Index_Type => Natural, Element_Type => State_Type);

   type Storage is record
      --  Предыдущее состояние после переключения (кроме самого начала)
      Previous : State_Type;

      --  Текущее состояние
      Current : State_Type;

      --  Кэш всех запросов на переключение
      Set_Queue : State_Queue.Vector;

      --  Было ли переключено состояние
      Switched : Boolean;

   end record;

end Tecs.State;
