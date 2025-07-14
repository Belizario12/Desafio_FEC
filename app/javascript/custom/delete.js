document.addEventListener('DOMContentLoaded', () => {
  document.querySelectorAll('.btn-delete').forEach(link => {
    link.addEventListener('click', function(event) {
      event.preventDefault();

      if (confirm(this.dataset.confirm)) {
        fetch(this.href, {
          method: 'DELETE',
          headers: {
            'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content,
            'Accept': 'application/json' // pode ajustar conforme resposta
          },
          credentials: 'same-origin'
        }).then(response => {
          if (response.ok) {
            // Aqui você pode recarregar a página ou remover a linha da tabela
            location.reload();
          } else {
            alert('Erro ao excluir o notebook.');
          }
        }).catch(() => alert('Erro ao conectar com o servidor.'));
      }
    });
  });
});
