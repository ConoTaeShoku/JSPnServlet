package sebank.vo;

public class Reply {

	private int replynum;
	private int boardnum;
	private String id;
	private String text;
	private String inputdate;

	public Reply() {
	}

	public Reply(int boardnum, String id, String text) {
		this.boardnum = boardnum;
		this.id = id;
		this.text = text;
	}
	
	public Reply(int replynum, int boardnum, String id, String text, String inputdate) {
		this.replynum = replynum;
		this.boardnum = boardnum;
		this.id = id;
		this.text = text;
		this.inputdate = inputdate;
	}

	public int getReplynum() {
		return replynum;
	}

	public void setReplynum(int replynum) {
		this.replynum = replynum;
	}

	public int getBoardnum() {
		return boardnum;
	}

	public void setBoardnum(int boardnum) {
		this.boardnum = boardnum;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public String getInputdate() {
		return inputdate;
	}

	public void setInputdate(String inputdate) {
		this.inputdate = inputdate;
	}

	@Override
	public String toString() {
		return "Reply [replynum=" + replynum + ", boardnum=" + boardnum + ", id=" + id + ", text=" + text
				+ ", inputdate=" + inputdate + "]";
	}

}
