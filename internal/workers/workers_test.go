package workers_test

import (
	"fmt"
	"sync"
	"testing"
	"time"

	"github.com/cesarFuhr/workers-io/internal/workers"
)

func TestPostWork(_ *testing.T) {
	var wg sync.WaitGroup

	work := func() {
		defer wg.Done()
		fmt.Println(time.Now().Nanosecond(), "show!")
	}

	wg.Add(1)
	workers.PostWork(work)

	fmt.Println(time.Now().Nanosecond())
	wg.Wait()
}
