import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["calendarMain", "headerTitle", "input", "days"];
  static values = {
      month: Number,
      year: Number,
      selectedDay: Number
  }

  connect() {
      this.initializeCalendar();
  }

  initializeCalendar() {
      let today = new Date();
      this.monthValue = today.getMonth();
      this.yearValue = today.getFullYear();
      this.updateCalendar();
      // Set the input value to today's date
        if (this.hasInputTarget) {
          this.inputTarget.value = this.formatDate(today);
      }
      console.log(this.inputTarget.value)
  }

formatDate(date) {
    // Format the date as 'MM/DD/YYYY'. Modify this if you need a different format.
    let day = date.getDate().toString().padStart(2, '0');
    let month = (date.getMonth() + 1).toString().padStart(2, '0'); // +1 because months are 0-indexed
    let year = date.getFullYear();
    return `${month}/${day}/${year}`;
  }

  updateCalendar() {
      let monthDetails = this.getMonthDetails(this.yearValue, this.monthValue);
      this.setHeader(this.yearValue, this.monthValue);
      this.setCalBody(monthDetails);
  }

  setHeader(year, month) {
      if (this.hasHeaderTitleTarget) {
          this.headerTitleTarget.innerHTML = `${this.getMonthStr(month)} ${year}`;
      }
  }

  getMonthDetails(year, month) {
      let firstDay = new Date(year, month).getDay();
      let numberOfDays = this.getNumberOfDays(year, month);
      let monthArray = [];
      for (let i = 0; i < numberOfDays; i++) {
          let dayDetails = this.getDayDetails(i, firstDay, numberOfDays, year, month);
          monthArray.push(dayDetails);
      }
      return monthArray;
  }

  getMonthDetails(year, month) {
    let firstDay = new Date(year, month, 1).getDay();  // First day of the month
    let daysInMonth = new Date(year, month + 1, 0).getDate(); // Days in the month
    let monthArray = [];

    // Calculate the start index depending on the first day of the month
    let startIndex = -firstDay;

    for (let i = startIndex; i < daysInMonth; i++) {
        let date = new Date(year, month, i + 1); // Correcting date creation
        let timestamp = date.getTime();
        let dayIndex = (i + firstDay) % 7;
        let isCurrentMonth = i >= 0 && i < daysInMonth;
        monthArray.push({date: date.getDate(), day: dayIndex, month: isCurrentMonth ? 0 : (i < 0 ? -1 : 1), timestamp});
    }
    return monthArray;
}

  getNumberOfDays(year, month) {
      return new Date(year, month + 1, 0).getDate();
  }

  setCalBody(monthDetails) {
      this.calendarMainTarget.innerHTML = ""; // Clear existing content
      const todayTimestamp = new Date();
      todayTimestamp.setHours(0, 0, 0, 0); // Normalize today to midnight for comparison
      monthDetails.forEach(day => {
          let div = document.createElement("div"),
              span = document.createElement("span");
          div.className = "cell_wrapper cal_date";
          span.className = "cell_item";
          span.textContent = day.date;
          div.appendChild(span);
          this.calendarMainTarget.appendChild(div);
          if (day.month === 0 && day.timestamp >= todayTimestamp.getTime()) {
            div.classList.add("current");
          }
          if (day.month === 0) {
              this.isCurrentDay(day, div);
          }
          if (day.month === 0 && day.timestamp >= todayTimestamp.getTime()) {
            div.addEventListener('click', () => {
              this.selectDay(div, day.timestamp);
          });
          }
      });
  }

  selectDay(selectedDiv, timestamp) {
    // Remove 'active' class from all other days
    const allDays = this.calendarMainTarget.querySelectorAll('.cal_date');
    allDays.forEach(day => day.classList.remove('active'));

    // Add 'active' class to the clicked day
    selectedDiv.classList.add('active');

    // Optional: perform any additional actions, e.g., updating an input field
    this.inputTarget.value = new Date(timestamp).toLocaleDateString();
    console.log(this.inputTarget.value)
}

  isCurrentDay(day, cell) {
      if (day.timestamp === new Date().setHours(0, 0, 0, 0)) {
          cell.classList.add("active", "isCurrent");
      }
  }

  setHeaderNav(event) {
      let offset = parseInt(event.currentTarget.dataset.offset);
      this.monthValue += offset;
      if (this.monthValue === -1) {
          this.monthValue = 11;
          this.yearValue--;
      } else if (this.monthValue === 12) {
          this.monthValue = 0;
          this.yearValue++;
      }
      this.updateCalendar();
  }

  getMonthStr(month) {
      const months = ["January", "February", "March", "April", "May", "June",
                      "July", "August", "September", "October", "November", "December"];
      return months[month];
  }
}