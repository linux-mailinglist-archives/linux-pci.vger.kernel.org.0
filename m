Return-Path: <linux-pci+bounces-21447-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E47A35C04
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 11:58:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6673F3ABF9F
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 10:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B1025A353;
	Fri, 14 Feb 2025 10:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="sy5zFLpn"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6935A2566C9
	for <linux-pci@vger.kernel.org>; Fri, 14 Feb 2025 10:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739530684; cv=none; b=k5GMpBz+3kP5zC3bGHQ7FYtiixWvuKjplptYGcN4aMOaPTCzJqr4ASlxv8KhXU6BXp2GssJClP2esCVaS8N5NlxezLinUN1okk1uhQEMdJZUfEbqiJGQvG8CAdZDmoqOwowal1qFU4CHf539KsvWJr7nIhJDZeKDOkuT3ngk8WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739530684; c=relaxed/simple;
	bh=2Po+ug5g5fQD9oDys3Be+rFy6xFTBVx52LX/wk0Gm2s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:Content-Type:
	 References; b=t2z/7UXMviIZN30gO4PmGV8AiaNfcwTbb+NqBFot13fdpUFZce0XfjdJCfDw4VdWCI3F3uE3pERGzKsTuJ+SsH0xZwP+9//S1YP1rEzTFvcRT3qSOij7YOoJ82NzVQyhMfkiE65FlZyEUt71OZcQZDwsDs6NeI+N9tKWYflJKac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=sy5zFLpn; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250214105800epoutp01008a69e862554f5aa6ab8ea7927bd869~kDfABV-KO1299712997epoutp010
	for <linux-pci@vger.kernel.org>; Fri, 14 Feb 2025 10:58:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250214105800epoutp01008a69e862554f5aa6ab8ea7927bd869~kDfABV-KO1299712997epoutp010
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1739530680;
	bh=hFftrDph6E1OBXFPA6FhS5hReFuVWz+bzLQVedfvQW8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sy5zFLpnVbOdq7vsRokLJDVzYNd29gIwXumQ7/qGWY9/2mB2kJ4PxoH9ChgkAq6nL
	 wWU8ssURlvzSiWsGl4ti9MQhHz4C2cvhIF1gBS4BN41VItxWZ59DGihHZeYROzW0Xu
	 Fx5aOQiSyIvKZJHxKBJ+58bP54SCKn0yrsOEMAM0=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20250214105800epcas5p347a860a63d618c19fbb4410951e4bb3c~kDe-pVG0c3071030710epcas5p3f;
	Fri, 14 Feb 2025 10:58:00 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.181]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4YvTY21Q0Yz4x9Pv; Fri, 14 Feb
	2025 10:57:58 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	0F.1F.20052.6B12FA76; Fri, 14 Feb 2025 19:57:58 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250214105352epcas5p17fa94017786a363f4381c9b11ae43e24~kDbY2aVek1079310793epcas5p1U;
	Fri, 14 Feb 2025 10:53:52 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250214105352epsmtrp19c05001687e7c18525b3169e28477fef~kDbY1LmT91673516735epsmtrp12;
	Fri, 14 Feb 2025 10:53:52 +0000 (GMT)
X-AuditID: b6c32a49-3fffd70000004e54-e0-67af21b6a9ea
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	A9.47.18729.0C02FA76; Fri, 14 Feb 2025 19:53:52 +0900 (KST)
Received: from cheetah.samsungds.net (unknown [107.109.115.53]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250214105349epsmtip16daee21d171e9bc52e9bbfda31683239~kDbWTgzud1117611176epsmtip12;
	Fri, 14 Feb 2025 10:53:49 +0000 (GMT)
From: Shradha Todi <shradha.t@samsung.com>
To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc: manivannan.sadhasivam@linaro.org, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, bhelgaas@google.com, jingoohan1@gmail.com,
	Jonathan.Cameron@Huawei.com, fan.ni@samsung.com, nifan.cxl@gmail.com,
	a.manzanares@samsung.com, pankaj.dubey@samsung.com, cassel@kernel.org,
	18255117159@163.com, quic_nitegupt@quicinc.com, quic_krichai@quicinc.com,
	gost.dev@samsung.com, Shradha Todi <shradha.t@samsung.com>
Subject: [PATCH v6 4/4] Add debugfs based statistical counter support in DWC
Date: Fri, 14 Feb 2025 16:20:07 +0530
Message-Id: <20250214105007.97582-5-shradha.t@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250214105007.97582-1-shradha.t@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSf0xTVxTHc/va1wdb2Qu4eWnQ1WeI2gxsXamXnyMB9BmYwwzjhpruAY+2
	UtqmP5wsQRHJgDILRBHEghbNrODGUqABxYQAyn7KNli3JTYBZ0Y2pjJW6xwS1vLK9t/nfO85
	33PuuZfAontwMaHVW1iTntFReCTfM7ZtS4JnU69a5r0tQNO1S0LUOrYJXanWoDtNLgxV9/gE
	6OeRIR5y+c8LUbfTi6Oqj5YEaOqGA0ffdE7gqOZ5DR/5auoFaNlzC6CuAb8QzcxUoHrHOIZW
	hgeF6PRYZWYMfdl1VkAPtfuE9CW3la4Zfyig3d31OH3PO4zTD6ZbeXTz8HHa3t8N6L/cG/Mj
	C8vSNCxTwpokrL7YUKLVq9Op3LdVWaokpUyeIE9GOymJniln06nsvPyEXVpd8FaU5Cijswal
	fMZsprZnpJkMVgsr0RjMlnSKNZbojApjopkpN1v16kQ9a0mRy2Q7koKJ75VpHj3+Djd+rDm2
	0F5aBQYP2EAEAUkFnJ/sADYQSUSTNwGsv1mHccEigA1/tgq4IACg29nKXyu5O3AfhDiavAXg
	F1/lc0l+AH/xdPJCBzgphSef2LAQryNT4VhtPx5ijOzCYEcDYwMEEUPmwa9nc0Myn4yHvrqZ
	VX8RmQIv3L4u5Hq9Cns+G1m1iQjaPJz0Czh9hIDeroiQDSSzoXMxnZNj4O8T/eFSMfyt8cMw
	q+G1vjaMYx0M9F3hcfwGHJl28EM2GLkN9t7YzskbYMuXn/K4gaPg6aUH4XQRHOxc483Qvzwc
	3kgs7LwzFZ6Mho7+CSG3ETuA/sYnoAlsbP+/xSUAukEsazSXq1lzklGuZ9//78WKDeVusPpr
	pXsGgW9mIXEU8AgwCiCBUetE8Nx1dbSohKn4gDUZVCarjjWPgqTg+pox8cvFhuC311tUckWy
	TKFUKhXJryvl1HrRqaEadTSpZixsGcsaWdNaHY+IEFfxGu4HVOcPqF2z++eJZytHj0Tu2Wpw
	Vm6liiTHF9iVnMK02QlT3GV72dMfBY48U8tELvTC9qaonYpr9kT7gpy4W9D47ZuLXiO1r2ju
	oEq7bOkq+GfZik6Qz1UvZrzgKZrseKVt+qIuqnt/8+YjbUbtQJzKnu1cysRHPLVTv9oC3+/6
	YXeaq2Iu/mr1PUVBaaDubO9s/GNR/E+P3ko9vJCJsVv4p2KtuizjJI93AjtXq+sZPRPQu2UZ
	c8mmmI5jO3bvTZm2/V362rgNa736ueCT9e+8VPmHVSfvq3IfzNmXOp9zOO7iIWF7y6FnT30S
	514xM1XqOym98G5h4WDWhl4pRfHNGkYuxUxm5l9DBd/6PgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCLMWRmVeSWpSXmKPExsWy7bCSnO4BhfXpBvee8lpcaf/NbjH9sKLF
	kqYMi2MTVjBbNK2+y2px88BOJosVX2ayW6xaeI3NoqHnN6vF5V1z2CzOzjvOZtHyp4XF4m5L
	J6vF3217GS0Wbf3CbvHgQaVF55wjzBb/9+xgt+g9XOsg7LF4xRRWj52z7rJ7LNhU6tFy5C2r
	x6ZVnWwed67tYfN4cmU6k8fEPXUefVtWMXp83iQXwBXFZZOSmpNZllqkb5fAlfHu/UW2gmUZ
	FR9mpTUw7gjvYuTkkBAwkTi39RFjFyMXh5DAbkaJtVs62CESkhKfL65jgrCFJVb+ew4WFxL4
	xCjRNzELxGYT0JJo/NrFDGKLCNhK3H80mRVkELPADmaJv/O2AjVwcAgL+EiceegNUsMioCpx
	t+MBC4jNK2AlMfvoGqhd8hKrNxwAm8MpYC3x9vwXVohdVhI/1txgnMDIt4CRYRWjZGpBcW56
	brFhgWFearlecWJucWleul5yfu4mRnBEaGnuYNy+6oPeIUYmDsZDjBIczEoivBLT1qQL8aYk
	VlalFuXHF5XmpBYfYpTmYFES5xV/0ZsiJJCeWJKanZpakFoEk2Xi4JRqYGp4GsHKXb9BqK7r
	+p5b6TF8BUvqttrOs1dylpObzJy2eO2stTfnbHxWmvxeeMp1c/5+LvPdp9/vnNM6hcdR8cye
	pPzLpj3tt14yTYp08bqXNGuW9sUvvmHsNy6bKrw59MXT+KEIh16crqCqU4Dj8991LobOvT9m
	9Lz/Pu+gWe3B1VyLXT+EdgYpeh//vadf5ZGDlJBd/CQldfPPy0RbC41uuupuuhyY92HHjcOX
	dq0Ps7i/b6nhZlMZlsUPP/IGPt9h8WH7MSGpM+4szk3zdOY9ZVu5jytfPOYgx4xFD9ekJO1R
	7rNoU/0ZdmPSGpVp0/xetvEKe6yfqSP8XtJtQnHLDCPLH+dmLmbq/tX9vVqJpTgj0VCLuag4
	EQDHpKwo9wIAAA==
X-CMS-MailID: 20250214105352epcas5p17fa94017786a363f4381c9b11ae43e24
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250214105352epcas5p17fa94017786a363f4381c9b11ae43e24
References: <20250214105007.97582-1-shradha.t@samsung.com>
	<CGME20250214105352epcas5p17fa94017786a363f4381c9b11ae43e24@epcas5p1.samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Add support to provide statistical counter interface to userspace. This set
of debug registers are part of the RASDES feature present in DesignWare
PCIe controllers.

Signed-off-by: Shradha Todi <shradha.t@samsung.com>
---
 Documentation/ABI/testing/debugfs-dwc-pcie    |  61 +++++
 .../controller/dwc/pcie-designware-debugfs.c  | 229 +++++++++++++++++-
 2 files changed, 289 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/debugfs-dwc-pcie b/Documentation/ABI/testing/debugfs-dwc-pcie
index 9eae0ab1dbea..01aa9d3a00c6 100644
--- a/Documentation/ABI/testing/debugfs-dwc-pcie
+++ b/Documentation/ABI/testing/debugfs-dwc-pcie
@@ -81,3 +81,64 @@ Description:	rasdes_err_inj is the directory which can be used to inject errors
 
 			<count>
 				Number of errors to be injected
+
+What:		/sys/kernel/debug/dwc_pcie_<dev>/rasdes_event_counters/<event>/counter_enable
+Date:		Feburary 2025
+Contact:	Shradha Todi <shradha.t@samsung.com>
+Description:	rasdes_event_counters is the directory which can be used to collect
+		statistical data about the number of times a certain event has occurred
+		in the controller. The list of possible events are:
+
+		1) EBUF Overflow
+		2) EBUF Underrun
+		3) Decode Error
+		4) Running Disparity Error
+		5) SKP OS Parity Error
+		6) SYNC Header Error
+		7) Rx Valid De-assertion
+		8) CTL SKP OS Parity Error
+		9) 1st Retimer Parity Error
+		10) 2nd Retimer Parity Error
+		11) Margin CRC and Parity Error
+		12) Detect EI Infer
+		13) Receiver Error
+		14) RX Recovery Req
+		15) N_FTS Timeout
+		16) Framing Error
+		17) Deskew Error
+		18) Framing Error In L0
+		19) Deskew Uncompleted Error
+		20) Bad TLP
+		21) LCRC Error
+		22) Bad DLLP
+		23) Replay Number Rollover
+		24) Replay Timeout
+		25) Rx Nak DLLP
+		26) Tx Nak DLLP
+		27) Retry TLP
+		28) FC Timeout
+		29) Poisoned TLP
+		30) ECRC Error
+		31) Unsupported Request
+		32) Completer Abort
+		33) Completion Timeout
+		34) EBUF SKP Add
+		35) EBUF SKP Del
+
+		counter_enable is RW. Write 1 to enable the event counter and write 0 to
+		disable the event counter. Read will return whether the counter is currently
+		enabled	or disabled. Counter is disabled by default.
+
+What:		/sys/kernel/debug/dwc_pcie_<dev>/rasdes_event_counters/<event>/counter_value
+Date:		Feburary 2025
+Contact:	Shradha Todi <shradha.t@samsung.com>
+Description:	(RO) Read will return the current value of the event counter. To reset the counter,
+		counter should be disabled and enabled back using the 'counter_enable' attribute.
+
+What:		/sys/kernel/debug/dwc_pcie_<dev>/rasdes_event_counters/<event>/lane_select
+Date:		Feburary 2025
+Contact:	Shradha Todi <shradha.t@samsung.com>
+Description:	(RW) Some lanes in the event list are lane specific events. These include
+		events 1) - 11) and 34) - 35).
+		Write lane number for which counter needs to be enabled/disabled/dumped.
+		Read will return the current selected lane number. Lane0 is selected by default.
diff --git a/drivers/pci/controller/dwc/pcie-designware-debugfs.c b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
index dfb0840390d3..2087185a1968 100644
--- a/drivers/pci/controller/dwc/pcie-designware-debugfs.c
+++ b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
@@ -31,6 +31,17 @@
 
 #define ERR_INJ_ENABLE_REG		0x30
 
+#define RAS_DES_EVENT_COUNTER_DATA_REG	0xc
+
+#define RAS_DES_EVENT_COUNTER_CTRL_REG	0x8
+#define EVENT_COUNTER_GROUP_SELECT	GENMASK(27, 24)
+#define EVENT_COUNTER_EVENT_SELECT	GENMASK(23, 16)
+#define EVENT_COUNTER_LANE_SELECT	GENMASK(11, 8)
+#define EVENT_COUNTER_STATUS		BIT(7)
+#define EVENT_COUNTER_ENABLE		GENMASK(4, 2)
+#define PER_EVENT_ON			0x3
+#define PER_EVENT_OFF			0x1
+
 #define DWC_DEBUGFS_BUF_MAX		128
 
 struct dwc_pcie_vsec_id {
@@ -135,6 +146,61 @@ static const u32 err_inj_type_mask[] = {
 	EINJ5_TYPE,
 };
 
+/**
+ * struct dwc_pcie_event_counter - Store details about each event counter supported in DWC RASDES
+ * @name: Name of the error counter
+ * @group_no: Group number that the event belongs to. Value ranges from 0 - 4
+ * @event_no: Event number of the particular event. Value ranges from -
+ *		Group 0: 0 - 10
+ *		Group 1: 5 - 13
+ *		Group 2: 0 - 7
+ *		Group 3: 0 - 5
+ *		Group 4: 0 - 1
+ */
+struct dwc_pcie_event_counter {
+	const char *name;
+	u32 group_no;
+	u32 event_no;
+};
+
+static const struct dwc_pcie_event_counter event_list[] = {
+	{"ebuf_overflow", 0x0, 0x0},
+	{"ebuf_underrun", 0x0, 0x1},
+	{"decode_err", 0x0, 0x2},
+	{"running_disparity_err", 0x0, 0x3},
+	{"skp_os_parity_err", 0x0, 0x4},
+	{"sync_header_err", 0x0, 0x5},
+	{"rx_valid_deassertion", 0x0, 0x6},
+	{"ctl_skp_os_parity_err", 0x0, 0x7},
+	{"retimer_parity_err_1st", 0x0, 0x8},
+	{"retimer_parity_err_2nd", 0x0, 0x9},
+	{"margin_crc_parity_err", 0x0, 0xA},
+	{"detect_ei_infer", 0x1, 0x5},
+	{"receiver_err", 0x1, 0x6},
+	{"rx_recovery_req", 0x1, 0x7},
+	{"n_fts_timeout", 0x1, 0x8},
+	{"framing_err", 0x1, 0x9},
+	{"deskew_err", 0x1, 0xa},
+	{"framing_err_in_l0", 0x1, 0xc},
+	{"deskew_uncompleted_err", 0x1, 0xd},
+	{"bad_tlp", 0x2, 0x0},
+	{"lcrc_err", 0x2, 0x1},
+	{"bad_dllp", 0x2, 0x2},
+	{"replay_num_rollover", 0x2, 0x3},
+	{"replay_timeout", 0x2, 0x4},
+	{"rx_nak_dllp", 0x2, 0x5},
+	{"tx_nak_dllp", 0x2, 0x6},
+	{"retry_tlp", 0x2, 0x7},
+	{"fc_timeout", 0x3, 0x0},
+	{"poisoned_tlp", 0x3, 0x1},
+	{"ecrc_error", 0x3, 0x2},
+	{"unsupported_request", 0x3, 0x3},
+	{"completer_abort", 0x3, 0x4},
+	{"completion_timeout", 0x3, 0x5},
+	{"ebuf_skp_add", 0x4, 0x0},
+	{"ebuf_skp_del", 0x4, 0x1},
+};
+
 static ssize_t lane_detect_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 {
 	struct dw_pcie *pci = file->private_data;
@@ -252,6 +318,127 @@ static ssize_t err_inj_write(struct file *file, const char __user *buf, size_t c
 	return count;
 }
 
+static void set_event_number(struct dwc_pcie_rasdes_priv *pdata, struct dw_pcie *pci,
+			     struct dwc_pcie_rasdes_info *rinfo)
+{
+	u32 val;
+
+	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_CTRL_REG);
+	val &= ~EVENT_COUNTER_ENABLE;
+	val &= ~(EVENT_COUNTER_GROUP_SELECT | EVENT_COUNTER_EVENT_SELECT);
+	val |= FIELD_PREP(EVENT_COUNTER_GROUP_SELECT, event_list[pdata->idx].group_no);
+	val |= FIELD_PREP(EVENT_COUNTER_EVENT_SELECT, event_list[pdata->idx].event_no);
+	dw_pcie_writel_dbi(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_CTRL_REG, val);
+}
+
+static ssize_t counter_enable_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
+{
+	struct dwc_pcie_rasdes_priv *pdata = file->private_data;
+	struct dw_pcie *pci = pdata->pci;
+	struct dwc_pcie_rasdes_info *rinfo = pci->debugfs->rasdes_info;
+	char debugfs_buf[DWC_DEBUGFS_BUF_MAX];
+	ssize_t off = 0;
+	u32 val;
+
+	mutex_lock(&rinfo->reg_lock);
+	set_event_number(pdata, pci, rinfo);
+	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_CTRL_REG);
+	mutex_unlock(&rinfo->reg_lock);
+	val = FIELD_GET(EVENT_COUNTER_STATUS, val);
+	if (val)
+		off += scnprintf(debugfs_buf, DWC_DEBUGFS_BUF_MAX - off, "Counter Enabled\n");
+	else
+		off += scnprintf(debugfs_buf, DWC_DEBUGFS_BUF_MAX - off, "Counter Disabled\n");
+
+	return simple_read_from_buffer(buf, count, ppos, debugfs_buf, off);
+}
+
+static ssize_t counter_enable_write(struct file *file, const char __user *buf,
+				    size_t count, loff_t *ppos)
+{
+	struct dwc_pcie_rasdes_priv *pdata = file->private_data;
+	struct dw_pcie *pci = pdata->pci;
+	struct dwc_pcie_rasdes_info *rinfo = pci->debugfs->rasdes_info;
+	u32 val, enable;
+
+	val = kstrtou32_from_user(buf, count, 0, &enable);
+	if (val)
+		return val;
+
+	mutex_lock(&rinfo->reg_lock);
+	set_event_number(pdata, pci, rinfo);
+	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_CTRL_REG);
+	if (enable)
+		val |= FIELD_PREP(EVENT_COUNTER_ENABLE, PER_EVENT_ON);
+	else
+		val |= FIELD_PREP(EVENT_COUNTER_ENABLE, PER_EVENT_OFF);
+
+	dw_pcie_writel_dbi(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_CTRL_REG, val);
+	mutex_unlock(&rinfo->reg_lock);
+
+	return count;
+}
+
+static ssize_t counter_lane_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
+{
+	struct dwc_pcie_rasdes_priv *pdata = file->private_data;
+	struct dw_pcie *pci = pdata->pci;
+	struct dwc_pcie_rasdes_info *rinfo = pci->debugfs->rasdes_info;
+	char debugfs_buf[DWC_DEBUGFS_BUF_MAX];
+	ssize_t off = 0;
+	u32 val;
+
+	mutex_lock(&rinfo->reg_lock);
+	set_event_number(pdata, pci, rinfo);
+	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_CTRL_REG);
+	mutex_unlock(&rinfo->reg_lock);
+	val = FIELD_GET(EVENT_COUNTER_LANE_SELECT, val);
+	off += scnprintf(debugfs_buf, DWC_DEBUGFS_BUF_MAX - off, "Lane: %d\n", val);
+
+	return simple_read_from_buffer(buf, count, ppos, debugfs_buf, off);
+}
+
+static ssize_t counter_lane_write(struct file *file, const char __user *buf,
+				  size_t count, loff_t *ppos)
+{
+	struct dwc_pcie_rasdes_priv *pdata = file->private_data;
+	struct dw_pcie *pci = pdata->pci;
+	struct dwc_pcie_rasdes_info *rinfo = pci->debugfs->rasdes_info;
+	u32 val, lane;
+
+	val = kstrtou32_from_user(buf, count, 0, &lane);
+	if (val)
+		return val;
+
+	mutex_lock(&rinfo->reg_lock);
+	set_event_number(pdata, pci, rinfo);
+	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_CTRL_REG);
+	val &= ~(EVENT_COUNTER_LANE_SELECT);
+	val |= FIELD_PREP(EVENT_COUNTER_LANE_SELECT, lane);
+	dw_pcie_writel_dbi(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_CTRL_REG, val);
+	mutex_unlock(&rinfo->reg_lock);
+
+	return count;
+}
+
+static ssize_t counter_value_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
+{
+	struct dwc_pcie_rasdes_priv *pdata = file->private_data;
+	struct dw_pcie *pci = pdata->pci;
+	struct dwc_pcie_rasdes_info *rinfo = pci->debugfs->rasdes_info;
+	char debugfs_buf[DWC_DEBUGFS_BUF_MAX];
+	ssize_t off = 0;
+	u32 val;
+
+	mutex_lock(&rinfo->reg_lock);
+	set_event_number(pdata, pci, rinfo);
+	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_DATA_REG);
+	mutex_unlock(&rinfo->reg_lock);
+	off += scnprintf(debugfs_buf, DWC_DEBUGFS_BUF_MAX - off, "Counter value: %d\n", val);
+
+	return simple_read_from_buffer(buf, count, ppos, debugfs_buf, off);
+}
+
 #define dwc_debugfs_create(name)			\
 debugfs_create_file(#name, 0644, rasdes_debug, pci,	\
 			&dbg_ ## name ## _fops)
@@ -271,6 +458,23 @@ static const struct file_operations dwc_pcie_err_inj_ops = {
 	.write = err_inj_write,
 };
 
+static const struct file_operations dwc_pcie_counter_enable_ops = {
+	.open = simple_open,
+	.read = counter_enable_read,
+	.write = counter_enable_write,
+};
+
+static const struct file_operations dwc_pcie_counter_lane_ops = {
+	.open = simple_open,
+	.read = counter_lane_read,
+	.write = counter_lane_write,
+};
+
+static const struct file_operations dwc_pcie_counter_value_ops = {
+	.open = simple_open,
+	.read = counter_value_read,
+};
+
 static void dwc_pcie_rasdes_debugfs_deinit(struct dw_pcie *pci)
 {
 	struct dwc_pcie_rasdes_info *rinfo = pci->debugfs->rasdes_info;
@@ -280,7 +484,7 @@ static void dwc_pcie_rasdes_debugfs_deinit(struct dw_pcie *pci)
 
 static int dwc_pcie_rasdes_debugfs_init(struct dw_pcie *pci, struct dentry *dir)
 {
-	struct dentry *rasdes_debug, *rasdes_err_inj;
+	struct dentry *rasdes_debug, *rasdes_err_inj, *rasdes_event_counter, *rasdes_events;
 	struct dwc_pcie_rasdes_info *rasdes_info;
 	struct dwc_pcie_rasdes_priv *priv_tmp;
 	const struct dwc_pcie_vsec_id *vid;
@@ -305,6 +509,7 @@ static int dwc_pcie_rasdes_debugfs_init(struct dw_pcie *pci, struct dentry *dir)
 	/* Create subdirectories for Debug, Error injection, Statistics */
 	rasdes_debug = debugfs_create_dir("rasdes_debug", dir);
 	rasdes_err_inj = debugfs_create_dir("rasdes_err_inj", dir);
+	rasdes_event_counter = debugfs_create_dir("rasdes_event_counter", dir);
 
 	mutex_init(&rasdes_info->reg_lock);
 	rasdes_info->ras_cap_offset = ras_cap;
@@ -327,6 +532,28 @@ static int dwc_pcie_rasdes_debugfs_init(struct dw_pcie *pci, struct dentry *dir)
 		debugfs_create_file(err_inj_list[i].name, 0200, rasdes_err_inj, priv_tmp,
 				    &dwc_pcie_err_inj_ops);
 	}
+
+	/* Create debugfs files for Statistical counter subdirectory */
+	for (i = 0; i < ARRAY_SIZE(event_list); i++) {
+		priv_tmp = devm_kzalloc(dev, sizeof(*priv_tmp), GFP_KERNEL);
+		if (!priv_tmp) {
+			ret = -ENOMEM;
+			goto err_deinit;
+		}
+
+		priv_tmp->idx = i;
+		priv_tmp->pci = pci;
+		rasdes_events = debugfs_create_dir(event_list[i].name, rasdes_event_counter);
+		if (event_list[i].group_no == 0 || event_list[i].group_no == 4) {
+			debugfs_create_file("lane_select", 0644, rasdes_events,
+					    priv_tmp, &dwc_pcie_counter_lane_ops);
+		}
+		debugfs_create_file("counter_value", 0444, rasdes_events, priv_tmp,
+				    &dwc_pcie_counter_value_ops);
+		debugfs_create_file("counter_enable", 0644, rasdes_events, priv_tmp,
+				    &dwc_pcie_counter_enable_ops);
+	}
+
 	return 0;
 
 err_deinit:
-- 
2.17.1


