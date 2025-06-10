import ReactDOM from 'react-dom/client';

function App() {
  return (
    <div>
      <h1>Witaj ze Świata Reacta!</h1>
      <p>Ta aplikacja została zbudowana za pomocą Webpacka i jest serwowana przez Nginx w kontenerze Docker.</p>
      <p>Pozdrowienia z Gdyni!</p>
    </div>
  );
}

const container = document.getElementById('root');
const root = ReactDOM.createRoot(container);
root.render(<App />);