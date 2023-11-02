// Подтверждение удаления при нажатии кнопки "Да"
document.querySelectorAll('[data-bs-toggle="modal"]').forEach(function (button) {
  button.addEventListener('click', function () {
      var targetModal = document.querySelector(this.getAttribute('data-bs-target'));
      var deleteForm = targetModal.querySelector('form');
      var deleteButton = targetModal.querySelector('[type="submit"]');

      deleteForm.addEventListener('submit', function (event) {
          event.preventDefault();
          if (confirm('Вы уверены, что хотите удалить книгу?')) {
              deleteButton.disabled = true;
              deleteForm.submit();
          }
      });
  });
});
// Добавление EasyMDE
document.addEventListener('DOMContentLoaded', function() {
    var descriptionTextarea = document.getElementById('description');
    if (descriptionTextarea) {
        var easyMDE = new EasyMDE({ element: descriptionTextarea });
    }
});