all:
	mkdir -p database-data && docker compose build && docker compose up -d

logback:
	docker logs back

logfront:
	docker logs front

clean:
	docker compose down

fclean:
	@docker system prune -af

.PHONY: all clean fclean logback logfront