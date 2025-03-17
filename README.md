# Concept3D Interview: The Rails Technical Challenge

## Overview

Hello prospective candidate! In this repo, you're given a boilerplate application that contains most of the libraries you'll need to complete the challenge. It's intended to examine your abilities in the following areas:

1. Rails and React knowledge
2. General self-ownership of code in order to solve a problem
3. Comfort diving into the docs in order to learn new technologies
4. Ability to write clean, well organized, and refactored code
5. Git usage and best practices

### Instructions

Requirements: Ruby 3.3.1, Node >= 20. You may use the dev container if you don't have these versions.

1. Clone this repo to your own machine (do not fork it)
2. `cd C3D-Rails-Challenge`
3. Delete the `.git` directory
4. Initialize git. Host this project as a new repo on your own Github profile
5. `bin/setup`
6. Use `bin/dev` to start the server and webpack compiler.
7. Visit http://localhost:3000
8. Good luck!

> We rely heavily upon Git. Be sure to create new branches for new features, as if you're creating a pull request. Commit early and commit often.

### Overview

This repository is a simple Rails application, representative of our Localist Events product. Localist is a traditional, server-rendered Rails application, which uses React for enhanced interaction across the product, rather than a single page application.

### Requirements

The app currently just displays a list of events, and allows you to create, view and edit them.

When you click on an event, we want a section that lets you add guests with just their "Name" and "Email". Currently, it is just a placeholder React component. We also want to show the number of guests on each event card.

> "When I'm viewing an event, I want to be able to add a guest with their name and email address."

Notes:
* The guest list must persist.
* Both name and email are required. Display meaningful error messages when appropriate.
* Implement the guest manager as a React component on the Event show page.
* It should allow adding guests inline, without a page refresh.
* All forms and UI should be accessible.

**Bonus:** Allow removal of guests.

> "I want to see the number of guests on each event card, such as '12 guests'."

Notes:
* Think about efficiency, especially as the number of events increases.

#### BONUS TIME!

If you have some extra time, feel free to implement any of the following. No stress.

* Allow changing the sort order of the events on the homepage.
* As the number of events scale up, there's an efficiency improvement to be made on the homepage, can you find and implement it?
* Add management of `Place`s
* Tests are always appreciated. See what you can do here.

### Helpful Links:

- [Shakapacker](https://github.com/shakacode/shakapacker)


### Final notes:

Take as long as you need to feel to do your best work. However, this challenge should realistically take no longer than approximately 3-4 hours.

Have fun!