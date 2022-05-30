package workers

func PostWork(w func()) {
	go w()
}
