Return-Path: <linux-pci+bounces-22091-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47AE8A407CA
	for <lists+linux-pci@lfdr.de>; Sat, 22 Feb 2025 12:01:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 875133B3988
	for <lists+linux-pci@lfdr.de>; Sat, 22 Feb 2025 10:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8DC20A5E7;
	Sat, 22 Feb 2025 10:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="rGc1r6yl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15672209F2A
	for <linux-pci@vger.kernel.org>; Sat, 22 Feb 2025 10:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740221971; cv=none; b=cK9au2/mh+uKxXHpuHrqChrPiUK7y+gVCPrg2mnRk2TfRHGHfaZCuo1u8Hd5g5tWUBrYJSXHRnDbIm1VX0fPmPldOVlH6brt36KCGttL/75II39Mt97PMC93uYe7ZzgamaIKjV9G+RhJtjlFlBtM/yGmZnenmHlixhKFkUFo49k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740221971; c=relaxed/simple;
	bh=F+7hgIHXKwy4XkfrX/Tv5E5Ob7pgP01m8EMAPNRiKnY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:Content-Type:
	 References; b=X5ZZl7vl64y5m1SfDG3ooCC9B+SRuYgMdGqup7vJ88hhWwriVlcBb+SeqkkFvVVxtMguMfSjzavD6LT/yNUhwFqFlqratK+4hs8aoCfr7xVOIgNFzP5rDZr4FY7vz3MzEXXtM4LaNWnz6WR+QMaEif/f7VkbXRfWErcSVusw564=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=rGc1r6yl; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250222105927epoutp0254cbf9bdcdb6fc79e6749f5acbe98892~mgqi9Dyvo3039330393epoutp02Q
	for <linux-pci@vger.kernel.org>; Sat, 22 Feb 2025 10:59:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250222105927epoutp0254cbf9bdcdb6fc79e6749f5acbe98892~mgqi9Dyvo3039330393epoutp02Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1740221967;
	bh=z6f4nMvOZhyzDf2i0PcLJ5jRQ2jdAo61YqVs07awoek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rGc1r6yleyhcpSeH3PfCbJNGXuULATAO0xiRRxerKOTuU0wC+D5b1OhBF7oV3Ohs/
	 fc8g5vpwWuN2jCLPeSAm/CiS/1L9/w1AQWI+9zPVIlA8OHxZB+CtiCg6msdcS3Iv0G
	 zMyRLgQiNQQhuGuMGRzHP5FqzuyHKzT5YHjEnY4c=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20250222105926epcas5p41fb34d3445510c9f0dab91b2f7f3a59c~mgqiKPYg-2088720887epcas5p49;
	Sat, 22 Feb 2025 10:59:26 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.175]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4Z0PC03NM3z4x9Pw; Sat, 22 Feb
	2025 10:59:24 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	21.22.19710.C0EA9B76; Sat, 22 Feb 2025 19:59:24 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20250221132043epcas5p27fde98558b13b3311cdc467e8f246380~mO8nAdHi_1832518325epcas5p2o;
	Fri, 21 Feb 2025 13:20:43 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250221132043epsmtrp2fb6af07052063d3524500efe8fea4b11~mO8m-AojY1951819518epsmtrp2M;
	Fri, 21 Feb 2025 13:20:43 +0000 (GMT)
X-AuditID: b6c32a44-363dc70000004cfe-45-67b9ae0cda57
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	8B.59.18729.BAD78B76; Fri, 21 Feb 2025 22:20:43 +0900 (KST)
Received: from cheetah.samsungds.net (unknown [107.109.115.53]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250221132040epsmtip235ddeb74662141dea8de29ac3d819bec~mO8kA6IBJ0684606846epsmtip2-;
	Fri, 21 Feb 2025 13:20:40 +0000 (GMT)
From: Shradha Todi <shradha.t@samsung.com>
To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org
Cc: manivannan.sadhasivam@linaro.org, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, bhelgaas@google.com, jingoohan1@gmail.com,
	Jonathan.Cameron@Huawei.com, fan.ni@samsung.com, nifan.cxl@gmail.com,
	a.manzanares@samsung.com, pankaj.dubey@samsung.com, cassel@kernel.org,
	18255117159@163.com, xueshuai@linux.alibaba.com, renyu.zj@linux.alibaba.com,
	will@kernel.org, mark.rutland@arm.com, Shradha Todi <shradha.t@samsung.com>
Subject: [PATCH v7 5/5] Add debugfs based statistical counter support in DWC
Date: Fri, 21 Feb 2025 18:45:48 +0530
Message-Id: <20250221131548.59616-6-shradha.t@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250221131548.59616-1-shradha.t@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VTe0xTVxze6W1vC6HspiA7sIh45x6QFdtJywGBsUnwZiNZjTNuLlm5wrUl
	lLa0ZczNTYQ6HgqRRQcDeWOohcAsUN6kAwRx4OJa0W2wDASHM25REHGIrLSw/ff9vt/3nd/j
	nMPDBFfwAF6K2sDo1LSKxD3Z1sHgEKFXc5dCVJflhxy5K1xUMrgd1Wcr0fAZE4ayG6c4yLT4
	LReZayZwlHV6hYMstyc4yN59HkfjlSM4crQ3s5HxqZGNpoz5HHTh5nUWWrX2AVTbvshFNTl3
	AVrr7eSiwsEvkHFSgv5+0orH+lF1prMcqqmyCVBdZVNcqtqSQRmH7nMoizkfpyYnenGqazqC
	mnWUsKjW+uNUUZsZUAuWQJnXodQoJUMnM7ogRp2kSU5RK6LJd/fL98glUpFYKI5A4WSQmk5j
	osm4BJkwPkXlnJYM+oRWZTgpGa3XkztjonSaDAMTpNToDdEko01WacO0oXo6TZ+hVoSqGUOk
	WCR6Q+IUJqYqu+rGudqzyk8vnVhjZYGOgwXAgweJMNjb7WAXAE+egOgB8HG3mesOHgJ4rn2O
	5Q6WAJzLu8fetCyXz3PXsYDoA/Dyg2Nu0SKAo9Zp1noCJ0LgiUcF2Dr2JU4COHTHb12EEVYM
	2kwmV8KHSIB5A9+7TmITL8Mq06CL5xORMGv4JstdbRts/M7m4j2I3dB8rcTVEiQmedBhe7Qh
	ioO/WS0b7fnAP0fauG4cABf+6sPdWAEvtpZibqyCS631G943oc1x3unlObsLhi3dO930Vnju
	arNLghHesHBldkPOh52Vm/gluLjau1HWH1YO2zluTMHSMhvu3koRgD9ZZthnQGDZ/yWqATAD
	f0arT1MwSRKtWM1k/ndtSZo0C3A96ZC4TnCr6lnoAGDxwACAPIz05QsNnQoBP5k++hmj08h1
	GSpGPwAkzgUWYwFbkjTOP6E2yMVhEaIwqVQaFrFLKiZf4Od0GRUCQkEbmFSG0TK6TR+L5xGQ
	xTL2PdUO9u8tr7p3OfxnJXvIRrXIS8nXGoXy/lfLc7fGPN539RiWGCva/U3AK2NjU7La3NK8
	il+Xx1+83nZB3vFL5Kl9W270jHnsKjGXWt+j7T/cPnorePXHlr1rsvmVYt0DXvr97Yr4NNFo
	fnzHs/fvHk4VfPlVaHPmttrPk4KWhm6wZwufzOjQPw+vNYymeBVm9h+INnzMvzgl2XFgZLRu
	XBvzUY63XZlu/z3xeDE6nf1OxaUGaZOq4utqXd4d+xE/SdNibHPZkbcarlQdLviAs/+kr/dz
	wfa3PbloIVDW4z+/lF40/YdBPj/6+qnA8JrqQ1Ef+sh6n08Q8uOVO5bnKuZmDq6RbL2SFodg
	Oj39L4kdTUhbBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgkeLIzCtJLcpLzFFi42LZdlhJXnd17Y50g6+z5S2utP9mt5h+WNFi
	SVOGxbEJK5gtmlbfZbVY8WUmu8WqhdfYLBp6frNabHp8jdXi8q45bBZn5x1ns7iydR2LRcuf
	FhaLuy2drBZLr19ksvi7bS+jxaKtX9gtFja/ZLT4v2cHu0Xv4VqLljumFu9/bmZzEPNYvGIK
	q8eaeWsYPXbOusvusWBTqUfLkbesHptWdbJ53Lm2h81j50NLjydXpjN5bF5S79G3ZRWjx+dN
	cgE8UVw2Kak5mWWpRfp2CVwZOxefZS+YklGxsfE/UwPj9vAuRk4OCQETiR+zX7B3MXJxCAns
	ZpQ4feAPM0RCUuLzxXVMELawxMp/z6GKPjFKXH55ng0kwSagJdH4tYsZJCEi0MkosffIO7Aq
	ZoFzzBIzP7cwglQJC/hIdBw6yA5iswioSsxfcRhsBa+AlUTDsetQK+QlVm84ABbnFLCWWHVu
	OlhcCKhmz5b7rBMY+RYwMqxilEwtKM5Nzy02LDDMSy3XK07MLS7NS9dLzs/dxAiOJC3NHYzb
	V33QO8TIxMF4iFGCg1lJhFe3ZEe6EG9KYmVValF+fFFpTmrxIUZpDhYlcV7xF70pQgLpiSWp
	2ampBalFMFkmDk6pBqaweEOledoPPhQ8KeXba516k7l10sbibRPnLvz06kH+7sfZtXMqC5bI
	xrypj++8Pm1nlsi16e94ukslJtvJaCwLK+S/Uh+dJChQsTspehb7ktfiPYEfteoZPcq45P1k
	7Cf5/bDe1drt/fCJXXx29ZW5CdfmHdl2eH7umnX3d4UuX3uBy6joipDVqjeTosTtk902OPF2
	zswqU/Q4c3ZqnJjSDjaj06dmHZMWjf7uui1565Pu1KW/5tY77L+1vPKcmKiHwbGj5aXJfo2b
	t1js8fmtoSot2cuU/KA0X7UqKGhOfumWWw9sPt54KXf0qWXYvCq3+NUhk+Jfie5vk3Sa+MZ1
	ft/7+CbrOmEDjQkq0UosxRmJhlrMRcWJAF6i09UTAwAA
X-CMS-MailID: 20250221132043epcas5p27fde98558b13b3311cdc467e8f246380
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250221132043epcas5p27fde98558b13b3311cdc467e8f246380
References: <20250221131548.59616-1-shradha.t@samsung.com>
	<CGME20250221132043epcas5p27fde98558b13b3311cdc467e8f246380@epcas5p2.samsung.com>
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
index 6ee0897fe753..650a89b0511e 100644
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
+		(RW) Write 1 to enable the event counter and write 0 to disable the event counter.
+		Read will return whether the counter is currently enabled or disabled. Counter is
+		disabled by default.
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
index b7260edd2336..dca1e9999113 100644
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
 
 /**
@@ -113,6 +124,61 @@ static const u32 err_inj_type_mask[] = {
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
@@ -230,6 +296,127 @@ static ssize_t err_inj_write(struct file *file, const char __user *buf, size_t c
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
+	ssize_t pos;
+	u32 val;
+
+	mutex_lock(&rinfo->reg_event_lock);
+	set_event_number(pdata, pci, rinfo);
+	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_CTRL_REG);
+	mutex_unlock(&rinfo->reg_event_lock);
+	val = FIELD_GET(EVENT_COUNTER_STATUS, val);
+	if (val)
+		pos = scnprintf(debugfs_buf, DWC_DEBUGFS_BUF_MAX, "Counter Enabled\n");
+	else
+		pos = scnprintf(debugfs_buf, DWC_DEBUGFS_BUF_MAX, "Counter Disabled\n");
+
+	return simple_read_from_buffer(buf, count, ppos, debugfs_buf, pos);
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
+	mutex_lock(&rinfo->reg_event_lock);
+	set_event_number(pdata, pci, rinfo);
+	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_CTRL_REG);
+	if (enable)
+		val |= FIELD_PREP(EVENT_COUNTER_ENABLE, PER_EVENT_ON);
+	else
+		val |= FIELD_PREP(EVENT_COUNTER_ENABLE, PER_EVENT_OFF);
+
+	dw_pcie_writel_dbi(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_CTRL_REG, val);
+	mutex_unlock(&rinfo->reg_event_lock);
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
+	ssize_t pos;
+	u32 val;
+
+	mutex_lock(&rinfo->reg_event_lock);
+	set_event_number(pdata, pci, rinfo);
+	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_CTRL_REG);
+	mutex_unlock(&rinfo->reg_event_lock);
+	val = FIELD_GET(EVENT_COUNTER_LANE_SELECT, val);
+	pos = scnprintf(debugfs_buf, DWC_DEBUGFS_BUF_MAX, "Lane: %d\n", val);
+
+	return simple_read_from_buffer(buf, count, ppos, debugfs_buf, pos);
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
+	mutex_lock(&rinfo->reg_event_lock);
+	set_event_number(pdata, pci, rinfo);
+	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_CTRL_REG);
+	val &= ~(EVENT_COUNTER_LANE_SELECT);
+	val |= FIELD_PREP(EVENT_COUNTER_LANE_SELECT, lane);
+	dw_pcie_writel_dbi(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_CTRL_REG, val);
+	mutex_unlock(&rinfo->reg_event_lock);
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
+	ssize_t pos;
+	u32 val;
+
+	mutex_lock(&rinfo->reg_event_lock);
+	set_event_number(pdata, pci, rinfo);
+	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_DATA_REG);
+	mutex_unlock(&rinfo->reg_event_lock);
+	pos = scnprintf(debugfs_buf, DWC_DEBUGFS_BUF_MAX, "Counter value: %d\n", val);
+
+	return simple_read_from_buffer(buf, count, ppos, debugfs_buf, pos);
+}
+
 #define dwc_debugfs_create(name)			\
 debugfs_create_file(#name, 0644, rasdes_debug, pci,	\
 			&dbg_ ## name ## _fops)
@@ -249,6 +436,23 @@ static const struct file_operations dwc_pcie_err_inj_ops = {
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
@@ -258,7 +462,7 @@ static void dwc_pcie_rasdes_debugfs_deinit(struct dw_pcie *pci)
 
 static int dwc_pcie_rasdes_debugfs_init(struct dw_pcie *pci, struct dentry *dir)
 {
-	struct dentry *rasdes_debug, *rasdes_err_inj;
+	struct dentry *rasdes_debug, *rasdes_err_inj, *rasdes_event_counter, *rasdes_events;
 	struct dwc_pcie_rasdes_info *rasdes_info;
 	struct dwc_pcie_rasdes_priv *priv_tmp;
 	struct device *dev = pci->dev;
@@ -277,6 +481,7 @@ static int dwc_pcie_rasdes_debugfs_init(struct dw_pcie *pci, struct dentry *dir)
 	/* Create subdirectories for Debug, Error injection, Statistics */
 	rasdes_debug = debugfs_create_dir("rasdes_debug", dir);
 	rasdes_err_inj = debugfs_create_dir("rasdes_err_inj", dir);
+	rasdes_event_counter = debugfs_create_dir("rasdes_event_counter", dir);
 
 	mutex_init(&rasdes_info->reg_event_lock);
 	rasdes_info->ras_cap_offset = ras_cap;
@@ -299,6 +504,28 @@ static int dwc_pcie_rasdes_debugfs_init(struct dw_pcie *pci, struct dentry *dir)
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


