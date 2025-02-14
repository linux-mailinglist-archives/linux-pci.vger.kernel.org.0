Return-Path: <linux-pci+bounces-21446-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89969A35BFC
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 11:57:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40F7516E9F8
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 10:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE22261566;
	Fri, 14 Feb 2025 10:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="bjmiseX4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F0C25C6FD
	for <linux-pci@vger.kernel.org>; Fri, 14 Feb 2025 10:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739530647; cv=none; b=gyP4KBNnKtkC70HEVceor+c9s4WGdmKIkkDMilRYiiJGPRoraeN/SuPKDQG2vdHN5gHTSwMwlvPMIMqmfE0+SSrlxqCcgCXrCz5m3EkYiD1SrQ8xCY/emf4m+utXIw/seyN3znEqemXkYBWdKZblSTqSxarwzPimgjkVBvhCKJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739530647; c=relaxed/simple;
	bh=v0aTtAeIVgfdVeGqO4MS66uOFpjcd9/+tgLOgAszsVg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:Content-Type:
	 References; b=maEV0xBf/DhdGjxc06plDcrGmEArNlMWUNolO61WuekVf5+4nJ1dTyzc3TegX2HGa02Lw+YFvo8HSjyL/108GbHq0QtJkexCLKK/jdMKZfhQhFZ0fm87B2VE6iYpGf9bhPPhZ+cj7UMxiXiJD+YkQ0+FIZVM1cxwGknu3KM+CKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=bjmiseX4; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250214105722epoutp02e4a78de46ffef3acf6bf4a623330d76e~kDecwY5Yy2613726137epoutp02f
	for <linux-pci@vger.kernel.org>; Fri, 14 Feb 2025 10:57:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250214105722epoutp02e4a78de46ffef3acf6bf4a623330d76e~kDecwY5Yy2613726137epoutp02f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1739530642;
	bh=hAepq2SEkPzoubr/G4hDCXcbTPHzh3WFsnq5wCOXkR8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bjmiseX4b4ACiRqGj8vAAcXu6zXRySBq/7OI5wDPHT48N8PButASSxfnlKiOnFVbZ
	 W6lbcLsgaLN56Zm8FIvEh4g9WMcghG3fSqGXALy0PvZDGbulCgP9uOykKFKciPG6zA
	 wxnPzxKU6DAXqSrYho89EF30UyXv1buWA9MQD49E=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20250214105722epcas5p1153f89c32267e8c413949f5aca8f5b4e~kDecTOJ9D2004420044epcas5p1P;
	Fri, 14 Feb 2025 10:57:22 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.176]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4YvTXJ6NHfz4x9Pq; Fri, 14 Feb
	2025 10:57:20 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	65.1A.29212.0912FA76; Fri, 14 Feb 2025 19:57:20 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250214105347epcas5p1205c5925fd239e34b3608ded2c0349c7~kDbURJUyn1084410844epcas5p1J;
	Fri, 14 Feb 2025 10:53:47 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250214105347epsmtrp1be53328563fbede8351a375f7183d894~kDbUQXMKG1673516735epsmtrp1x;
	Fri, 14 Feb 2025 10:53:47 +0000 (GMT)
X-AuditID: b6c32a50-801fa7000000721c-26-67af2190b10c
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	F4.BE.33707.BB02FA76; Fri, 14 Feb 2025 19:53:47 +0900 (KST)
Received: from cheetah.samsungds.net (unknown [107.109.115.53]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250214105344epsmtip1aeea8630c960c561edb3c064ac55a4bc~kDbRvNZGx1117711177epsmtip1d;
	Fri, 14 Feb 2025 10:53:44 +0000 (GMT)
From: Shradha Todi <shradha.t@samsung.com>
To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc: manivannan.sadhasivam@linaro.org, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, bhelgaas@google.com, jingoohan1@gmail.com,
	Jonathan.Cameron@Huawei.com, fan.ni@samsung.com, nifan.cxl@gmail.com,
	a.manzanares@samsung.com, pankaj.dubey@samsung.com, cassel@kernel.org,
	18255117159@163.com, quic_nitegupt@quicinc.com, quic_krichai@quicinc.com,
	gost.dev@samsung.com, Shradha Todi <shradha.t@samsung.com>
Subject: [PATCH v6 3/4] Add debugfs based error injection support in DWC
Date: Fri, 14 Feb 2025 16:20:06 +0530
Message-Id: <20250214105007.97582-4-shradha.t@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250214105007.97582-1-shradha.t@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPJsWRmVeSWpSXmKPExsWy7bCmuu4ExfXpBkd3GVpcaf/NbjH9sKLF
	kqYMi2MTVjBbNK2+y2px88BOJosVX2ayW6xaeI3NoqHnN6vF5V1z2CzOzjvOZtHyp4XF4m5L
	J6vF3217GS0Wbf3CbvHgQaVF55wjzBb/9+xgt+g9XOsg7LF4xRRWj52z7rJ7LNhU6tFy5C2r
	x6ZVnWwed67tYfN4cmU6k8fEPXUefVtWMXp83iQXwBWVbZORmpiSWqSQmpecn5KZl26r5B0c
	7xxvamZgqGtoaWGupJCXmJtqq+TiE6DrlpkD9JWSQlliTilQKCCxuFhJ386mKL+0JFUhI7+4
	xFYptSAlp8CkQK84Mbe4NC9dLy+1xMrQwMDIFKgwITtj+5cDbAWPwypWNC5mbGB85dbFyMkh
	IWAi8ej7NOYuRi4OIYE9jBK9Tz+wQzifGCXWLP7EDOdMWPGZEabl3LFdTBCJnYwS3/ecZIRw
	vjBKbD/WzgpSxSagJdH4tYsZxBYRsJY43L6FDcRmFljELDG3OxHEFhbwkLj79A9YDYuAqsSD
	e71MIDavgJXEjS8XmCC2yUus3nAArIYTaM7b819YIeI7OCT2XWOHsF0kWjres0DYwhKvjm+B
	iktJvOxvg7LTJVZunsEMYedIfNu8BGq+vcSBK3OAejmAbtOUWL9LHyIsKzH11DomiJP5JHp/
	P4Eq55XYMQ/GVpb48ncP1FpJiXnHLkOd5iGx6VcDWI2QQB+jxMHLmhMY5WYhbFjAyLiKUSq1
	oDg3PTXZtMBQNy+1HB5ryfm5mxjBKVcrYAfj6g1/9Q4xMnEwHmKU4GBWEuGVmLYmXYg3JbGy
	KrUoP76oNCe1+BCjKTD8JjJLiSbnA5N+Xkm8oYmlgYmZmZmJpbGZoZI4b/POlnQhgfTEktTs
	1NSC1CKYPiYOTqkGptgt5yY7poQXP9igd1HySC/3ZOPdunLbknkOZ55MCeg++WjjlCmK67te
	Lv2k55JT/C7oWpRP/4OE+7uWGy11by21jH+XdmVxdanfkfntF+vd9wsduPz86WMPx5bwjNuy
	oWc0i9Py3JXf7Fv2vfQCg92iykb2ORIfP7qYhOjpSmxotVJrbj+pe/t95HTDa0eyV/su95/F
	Uv3sg0BLtM85hnOzPIJr9l8vq/kkWu9Z4i4lvfvVqv3KC4P2lU69++JgWv+b3YxR3x8arpZY
	+HPPw4v3vTO21/yYNTmR1y7IZvNFoaTNFUbRx9+mmc6eafbo07OWJ4fC3n64bPMmVW+ikFLR
	jNOnbgkdc0i7LiP9IUaJpTgj0VCLuag4EQDYXbaHQgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMLMWRmVeSWpSXmKPExsWy7bCSnO5uhfXpBgu/CFhcaf/NbjH9sKLF
	kqYMi2MTVjBbNK2+y2px88BOJosVX2ayW6xaeI3NoqHnN6vF5V1z2CzOzjvOZtHyp4XF4m5L
	J6vF3217GS0Wbf3CbvHgQaVF55wjzBb/9+xgt+g9XOsg7LF4xRRWj52z7rJ7LNhU6tFy5C2r
	x6ZVnWwed67tYfN4cmU6k8fEPXUefVtWMXp83iQXwBXFZZOSmpNZllqkb5fAlbH9ywG2gsdh
	FSsaFzM2ML5y62Lk5JAQMJE4d2wXUxcjF4eQwHZGiQcTtjJBJCQlPl9cB2ULS6z895wdougT
	o0Tn7M/MIAk2AS2Jxq9dYLaIgK3E/UeTWUGKmAV2MEv8nbeVHSQhLOAhcffpH7AiFgFViQf3
	esGm8gpYSdz4cgFqg7zE6g0HwGo4Bawl3p7/wgpiCwHV/Fhzg3ECI98CRoZVjKKpBcW56bnJ
	BYZ6xYm5xaV56XrJ+bmbGMHxoBW0g3HZ+r96hxiZOBgPMUpwMCuJ8EpMW5MuxJuSWFmVWpQf
	X1Sak1p8iFGag0VJnFc5pzNFSCA9sSQ1OzW1ILUIJsvEwSnVwLTEO1o95Kz2ymlJPg1M2/Ik
	Gr3+ZzZ5b6uQsJLI9TXZse8s86GYOUKH/JiPGrasCGPseFnrs6hg9QnDaY4z1500tXrq8ap+
	hs8T3VzFT0vemCfKXzmjtvnXnOu1nlVMXsFX14oxvPU7fVlwTrxoV0Ld43OHtCI+tNznE+6+
	e8OL2agpdtcXI52FjtvSN4j1ZN8/q/fsSsEEvZ/Muzpm/yzIUWDp2/Ex59S/5792+lTcWlzM
	KPznP6Pj3yjnJcwvnp2eXNniUi8u6jD9uPCK2zrK/jzhjn6z9r5JjbwlaDBXXVr3mDn3pLWL
	Ahy5tqS6rJogdn7NL6EX96yr5fIZL//4YbbQdcb2tZvDlDLlHyqxFGckGmoxFxUnAgBRugsG
	9gIAAA==
X-CMS-MailID: 20250214105347epcas5p1205c5925fd239e34b3608ded2c0349c7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250214105347epcas5p1205c5925fd239e34b3608ded2c0349c7
References: <20250214105007.97582-1-shradha.t@samsung.com>
	<CGME20250214105347epcas5p1205c5925fd239e34b3608ded2c0349c7@epcas5p1.samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Add support to provide error injection interface to userspace. This set
of debug registers are part of the RASDES feature present in DesignWare
PCIe controllers.

Signed-off-by: Shradha Todi <shradha.t@samsung.com>
---
 Documentation/ABI/testing/debugfs-dwc-pcie    |  70 ++++++++
 .../controller/dwc/pcie-designware-debugfs.c  | 165 +++++++++++++++++-
 2 files changed, 233 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/debugfs-dwc-pcie b/Documentation/ABI/testing/debugfs-dwc-pcie
index e8ed34e988ef..9eae0ab1dbea 100644
--- a/Documentation/ABI/testing/debugfs-dwc-pcie
+++ b/Documentation/ABI/testing/debugfs-dwc-pcie
@@ -11,3 +11,73 @@ Contact:	Shradha Todi <shradha.t@samsung.com>
 Description:	(RW) Write the lane number to be checked as valid or invalid. Read
 		will return the status of PIPE RXVALID signal of the selected lane.
 		The default selected lane is Lane0.
+
+What:		/sys/kernel/debug/dwc_pcie_<dev>/rasdes_err_inj/<error>
+Date:		Feburary 2025
+Contact:	Shradha Todi <shradha.t@samsung.com>
+Description:	rasdes_err_inj is the directory which can be used to inject errors in the
+		system. The possible errors that can be injected are:
+
+		1) TLP LCRC error injection TX Path - tx_lcrc
+		2) 16b CRC error injection of ACK/NAK DLLP - b16_crc_dllp
+		3) 16b CRC error injection of Update-FC DLLP - b16_crc_upd_fc
+		4) TLP ECRC error injection TX Path - tx_ecrc
+		5) TLP's FCRC error injection TX Path - fcrc_tlp
+		6) Parity error of TSOS - parity_tsos
+		7) Parity error on SKPOS - parity_skpos
+		8) LCRC error injection RX Path - rx_lcrc
+		9) ECRC error injection RX Path - rx_ecrc
+		10) TLPs SEQ# error - tlp_err_seq
+		11) DLLPS ACK/NAK SEQ# error - ack_nak_dllp_seq
+		12) ACK/NAK DLLPs transmission block - ack_nak_dllp
+		13) UpdateFC DLLPs transmission block - upd_fc_dllp
+		14) Always transmission for NAK DLLP - nak_dllp
+		15) Invert SYNC header - inv_sync_hdr_sym
+		16) COM/PAD TS1 order set - com_pad_ts1
+		17) COM/PAD TS2 order set - com_pad_ts2
+		18) COM/FTS FTS order set - com_fts
+		19) COM/IDL E-idle order set - com_idl
+		20) END/EDB symbol - end_edb
+		21) STP/SDP symbol - stp_sdp
+		22) COM/SKP SKP order set - com_skp
+		23) Posted TLP Header credit value control - posted_tlp_hdr
+		24) Non-Posted TLP Header credit value control - non_post_tlp_hdr
+		25) Completion TLP Header credit value control - cmpl_tlp_hdr
+		26) Posted TLP Data credit value control - posted_tlp_data
+		27) Non-Posted TLP Data credit value control - non_post_tlp_data
+		28) Completion TLP Data credit value control - cmpl_tlp_data
+		29) Generates duplicate TLPs - duplicate_dllp
+		30) Generates Nullified TLPs - nullified_tlp
+
+		Each of the possible errors are WO attributes. Write to the attribute will
+		prepare controller to inject the respective error in the next transmission
+		of data. Parameter required to write will change in the following ways:
+
+		i) Errors 9) - 10) are sequence errors. The write command for these will be
+
+			echo <count> <diff> > /sys/kernel/debug/dwc_pcie_<dev>/rasdes_err_inj/<error>
+
+			<count>
+				Number of errors to be injected
+			<diff>
+				The difference to add or subtract from natural sequence number to
+				generate sequence error. Range (-4095 : 4095)
+
+		ii) Errors 23) - 28) are credit value error insertions. Write command:
+
+			echo <count> <diff> <vc> > /sys/kernel/debug/dwc_pcie_<dev>/rasdes_err_inj/<error>
+
+			<count>
+				Number of errors to be injected
+			<diff>
+				The difference to add or subtract from UpdateFC credit value.
+				Range (-4095 : 4095)
+			<vc>
+				Target VC number
+
+		iii) All other errors. Write command:
+
+			echo <count> > /sys/kernel/debug/dwc_pcie_<dev>/rasdes_err_inj/<error>
+
+			<count>
+				Number of errors to be injected
diff --git a/drivers/pci/controller/dwc/pcie-designware-debugfs.c b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
index fe799d36fa7f..dfb0840390d3 100644
--- a/drivers/pci/controller/dwc/pcie-designware-debugfs.c
+++ b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
@@ -17,6 +17,20 @@
 #define PIPE_DETECT_LANE		BIT(17)
 #define LANE_SELECT			GENMASK(3, 0)
 
+#define ERR_INJ0_OFF			0x34
+#define EINJ_VAL_DIFF			GENMASK(28, 16)
+#define EINJ_VC_NUM			GENMASK(14, 12)
+#define EINJ_TYPE_SHIFT			8
+#define EINJ0_TYPE			GENMASK(11, 8)
+#define EINJ1_TYPE			BIT(8)
+#define EINJ2_TYPE			GENMASK(9, 8)
+#define EINJ3_TYPE			GENMASK(10, 8)
+#define EINJ4_TYPE			GENMASK(10, 8)
+#define EINJ5_TYPE			BIT(8)
+#define EINJ_COUNT			GENMASK(7, 0)
+
+#define ERR_INJ_ENABLE_REG		0x30
+
 #define DWC_DEBUGFS_BUF_MAX		128
 
 struct dwc_pcie_vsec_id {
@@ -55,6 +69,72 @@ struct dwc_pcie_rasdes_info {
 	struct mutex reg_lock;
 };
 
+/**
+ * struct dwc_pcie_rasdes_priv - Stores file specific private data information
+ * @pci: Reference to the dw_pcie structure
+ * @idx: Index to point to specific file related information in array of structs
+ *
+ * All debugfs files will have this struct as its private data.
+ */
+struct dwc_pcie_rasdes_priv {
+	struct dw_pcie *pci;
+	int idx;
+};
+
+/**
+ * struct dwc_pcie_err_inj - Store details about each error injection supported by DWC RASDES
+ * @name: Name of the error that can be injected
+ * @err_inj_group: Group number to which the error belongs to. Value can range from 0 - 5
+ * @err_inj_type: Each group can have multiple types of error
+ */
+struct dwc_pcie_err_inj {
+	const char *name;
+	u32 err_inj_group;
+	u32 err_inj_type;
+};
+
+static const struct dwc_pcie_err_inj err_inj_list[] = {
+	{"tx_lcrc", 0x0, 0x0},
+	{"b16_crc_dllp", 0x0, 0x1},
+	{"b16_crc_upd_fc", 0x0, 0x2},
+	{"tx_ecrc", 0x0, 0x3},
+	{"fcrc_tlp", 0x0, 0x4},
+	{"parity_tsos", 0x0, 0x5},
+	{"parity_skpos", 0x0, 0x6},
+	{"rx_lcrc", 0x0, 0x8},
+	{"rx_ecrc", 0x0, 0xb},
+	{"tlp_err_seq", 0x1, 0x0},
+	{"ack_nak_dllp_seq", 0x1, 0x1},
+	{"ack_nak_dllp", 0x2, 0x0},
+	{"upd_fc_dllp", 0x2, 0x1},
+	{"nak_dllp", 0x2, 0x2},
+	{"inv_sync_hdr_sym", 0x3, 0x0},
+	{"com_pad_ts1", 0x3, 0x1},
+	{"com_pad_ts2", 0x3, 0x2},
+	{"com_fts", 0x3, 0x3},
+	{"com_idl", 0x3, 0x4},
+	{"end_edb", 0x3, 0x5},
+	{"stp_sdp", 0x3, 0x6},
+	{"com_skp", 0x3, 0x7},
+	{"posted_tlp_hdr", 0x4, 0x0},
+	{"non_post_tlp_hdr", 0x4, 0x1},
+	{"cmpl_tlp_hdr", 0x4, 0x2},
+	{"posted_tlp_data", 0x4, 0x4},
+	{"non_post_tlp_data", 0x4, 0x5},
+	{"cmpl_tlp_data", 0x4, 0x6},
+	{"duplicate_dllp", 0x5, 0x0},
+	{"nullified_tlp", 0x5, 0x1},
+};
+
+static const u32 err_inj_type_mask[] = {
+	EINJ0_TYPE,
+	EINJ1_TYPE,
+	EINJ2_TYPE,
+	EINJ3_TYPE,
+	EINJ4_TYPE,
+	EINJ5_TYPE,
+};
+
 static ssize_t lane_detect_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 {
 	struct dw_pcie *pci = file->private_data;
@@ -115,6 +195,63 @@ static ssize_t rx_valid_write(struct file *file, const char __user *buf, size_t
 	return lane_detect_write(file, buf, count, ppos);
 }
 
+static ssize_t err_inj_write(struct file *file, const char __user *buf, size_t count, loff_t *ppos)
+{
+	struct dwc_pcie_rasdes_priv *pdata = file->private_data;
+	struct dw_pcie *pci = pdata->pci;
+	struct dwc_pcie_rasdes_info *rinfo = pci->debugfs->rasdes_info;
+	u32 val, counter, vc_num, err_group, type_mask;
+	int val_diff = 0;
+	char *kern_buf;
+
+	err_group = err_inj_list[pdata->idx].err_inj_group;
+	type_mask = err_inj_type_mask[err_group];
+
+	kern_buf = memdup_user_nul(buf, count);
+	if (IS_ERR(kern_buf))
+		return PTR_ERR(kern_buf);
+
+	if (err_group == 4) {
+		val = sscanf(kern_buf, "%u %d %u", &counter, &val_diff, &vc_num);
+		if ((val != 3) || (val_diff < -4095 || val_diff > 4095)) {
+			kfree(kern_buf);
+			return -EINVAL;
+		}
+	} else if (err_group == 1) {
+		val = sscanf(kern_buf, "%u %d", &counter, &val_diff);
+		if ((val != 2) || (val_diff < -4095 || val_diff > 4095)) {
+			kfree(kern_buf);
+			return -EINVAL;
+		}
+	} else {
+		val = kstrtou32(kern_buf, 0, &counter);
+		if (val) {
+			kfree(kern_buf);
+			return val;
+		}
+	}
+
+	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset + ERR_INJ0_OFF + (0x4 * err_group));
+	val &= ~(type_mask | EINJ_COUNT);
+	val |= ((err_inj_list[pdata->idx].err_inj_type << EINJ_TYPE_SHIFT) & type_mask);
+	val |= FIELD_PREP(EINJ_COUNT, counter);
+
+	if (err_group == 1 || err_group == 4) {
+		val &= ~(EINJ_VAL_DIFF);
+		val |= FIELD_PREP(EINJ_VAL_DIFF, val_diff);
+	}
+	if (err_group == 4) {
+		val &= ~(EINJ_VC_NUM);
+		val |= FIELD_PREP(EINJ_VC_NUM, vc_num);
+	}
+
+	dw_pcie_writel_dbi(pci, rinfo->ras_cap_offset + ERR_INJ0_OFF + (0x4 * err_group), val);
+	dw_pcie_writel_dbi(pci, rinfo->ras_cap_offset + ERR_INJ_ENABLE_REG, (0x1 << err_group));
+
+	kfree(kern_buf);
+	return count;
+}
+
 #define dwc_debugfs_create(name)			\
 debugfs_create_file(#name, 0644, rasdes_debug, pci,	\
 			&dbg_ ## name ## _fops)
@@ -129,6 +266,11 @@ static const struct file_operations dbg_ ## name ## _fops = {	\
 DWC_DEBUGFS_FOPS(lane_detect);
 DWC_DEBUGFS_FOPS(rx_valid);
 
+static const struct file_operations dwc_pcie_err_inj_ops = {
+	.open = simple_open,
+	.write = err_inj_write,
+};
+
 static void dwc_pcie_rasdes_debugfs_deinit(struct dw_pcie *pci)
 {
 	struct dwc_pcie_rasdes_info *rinfo = pci->debugfs->rasdes_info;
@@ -138,11 +280,12 @@ static void dwc_pcie_rasdes_debugfs_deinit(struct dw_pcie *pci)
 
 static int dwc_pcie_rasdes_debugfs_init(struct dw_pcie *pci, struct dentry *dir)
 {
-	struct dentry *rasdes_debug;
+	struct dentry *rasdes_debug, *rasdes_err_inj;
 	struct dwc_pcie_rasdes_info *rasdes_info;
+	struct dwc_pcie_rasdes_priv *priv_tmp;
 	const struct dwc_pcie_vsec_id *vid;
 	struct device *dev = pci->dev;
-	int ras_cap;
+	int ras_cap, i, ret;
 
 	for (vid = dwc_pcie_vsec_ids; vid->vendor_id; vid++) {
 		ras_cap = dw_pcie_find_vsec_capability(pci, vid->vendor_id,
@@ -161,6 +304,7 @@ static int dwc_pcie_rasdes_debugfs_init(struct dw_pcie *pci, struct dentry *dir)
 
 	/* Create subdirectories for Debug, Error injection, Statistics */
 	rasdes_debug = debugfs_create_dir("rasdes_debug", dir);
+	rasdes_err_inj = debugfs_create_dir("rasdes_err_inj", dir);
 
 	mutex_init(&rasdes_info->reg_lock);
 	rasdes_info->ras_cap_offset = ras_cap;
@@ -170,7 +314,24 @@ static int dwc_pcie_rasdes_debugfs_init(struct dw_pcie *pci, struct dentry *dir)
 	dwc_debugfs_create(lane_detect);
 	dwc_debugfs_create(rx_valid);
 
+	/* Create debugfs files for Error injection subdirectory */
+	for (i = 0; i < ARRAY_SIZE(err_inj_list); i++) {
+		priv_tmp = devm_kzalloc(dev, sizeof(*priv_tmp), GFP_KERNEL);
+		if (!priv_tmp) {
+			ret = -ENOMEM;
+			goto err_deinit;
+		}
+
+		priv_tmp->idx = i;
+		priv_tmp->pci = pci;
+		debugfs_create_file(err_inj_list[i].name, 0200, rasdes_err_inj, priv_tmp,
+				    &dwc_pcie_err_inj_ops);
+	}
 	return 0;
+
+err_deinit:
+	dwc_pcie_rasdes_debugfs_deinit(pci);
+	return ret;
 }
 
 void dwc_pcie_debugfs_deinit(struct dw_pcie *pci)
-- 
2.17.1


