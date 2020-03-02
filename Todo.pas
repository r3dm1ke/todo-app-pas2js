program Todo;

{$mode objfpc}

uses
  JS, Classes, SysUtils, Web;

type
  task = record
    name: String;
    completed: Boolean;
  end;

var
  tasks: array[100] of task;
  listElement, inputElement, submitButton: TJSElement;

procedure AddTask();
begin
end;

procedure CompleteTask();
begin
end;

procedure Blit();
begin
end;

begin
  WriteLn('Hello world');
  listElement := document.querySelector('#list');
  inputElement := document.querySelector('#newTaskInput');
  submitButton := document.querySelector('#submitButton');
  document.
end.
