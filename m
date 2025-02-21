Return-Path: <linux-pci+bounces-22090-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99BD9A407BA
	for <lists+linux-pci@lfdr.de>; Sat, 22 Feb 2025 11:59:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8352189D818
	for <lists+linux-pci@lfdr.de>; Sat, 22 Feb 2025 10:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8BA20AF75;
	Sat, 22 Feb 2025 10:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="VLmQffxj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E07520A5D3
	for <linux-pci@vger.kernel.org>; Sat, 22 Feb 2025 10:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740221953; cv=none; b=f175SfwoKdnYsaTOXmw/eHzUmoNvvaq5v/ykVLUmUnncNCYQ2jHbZDi4SR+IoN0VOKb4HKTijP5W5d5Xo1Zj0NRIvfP3U4JqaZHJRi8AH1VG4xXJc8GH+pvW7uiRa7R4o3rL5vHiYd821bvO0IUDLetpbpezKyoe8xX86gUqkn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740221953; c=relaxed/simple;
	bh=IU4D9P66rcXqVX2QpLPkErMi2fV+zIesymeVGlSjcig=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:Content-Type:
	 References; b=GUTKRccZ53aYNC0mIyY09DwZVsnsuKo7h/SKt2rL9MZU6v6YRb9rP4pHmf2WyueGgUMCRb15u0Byxa3Nmt6B8vzYGkD7ZVNcTfQwURwJ1wSqGB7LBJPhJ1FG1GYxX/yEw8vUaSBp8xTU5H2GqiHaG/YCdlC++o0y0HtjATM8IJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=VLmQffxj; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250222105909epoutp026c1d23323933edfae669d640132cf409~mgqSaa2HM0186801868epoutp02O
	for <linux-pci@vger.kernel.org>; Sat, 22 Feb 2025 10:59:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250222105909epoutp026c1d23323933edfae669d640132cf409~mgqSaa2HM0186801868epoutp02O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1740221949;
	bh=WV2F5kFF2eQG4mwm95oOYvl4a0oTGlcASHC3wW3MN80=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VLmQffxj26GM2cKGCIxRd4LY2RBlFP41oFTSWyhi4w9STsrXPjB+sU0MN930rdjbz
	 pW5p8mJNrc27HLpH/YIt3tkKer4QvgKy5Ih36XOONRMoZ8/5RIHIDttMbbJlKXtK7H
	 awoXgHq3spyXEQE8g0RIQUfuAhTgSbQim5WUmWWk=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20250222105908epcas5p374fbcea14c3beb3a22e447b44868bda0~mgqRK1BUI0419204192epcas5p37;
	Sat, 22 Feb 2025 10:59:08 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.183]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4Z0PBf2s78z4x9Pt; Sat, 22 Feb
	2025 10:59:06 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	F6.0B.19933.AFDA9B76; Sat, 22 Feb 2025 19:59:06 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20250221132039epcas5p31913eab0acec1eb5e7874897a084c725~mO8jFSuCe1687416874epcas5p3X;
	Fri, 21 Feb 2025 13:20:39 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250221132039epsmtrp1d732a928118ec902b19646a9c107ddd3~mO8jEUNkn3135131351epsmtrp1I;
	Fri, 21 Feb 2025 13:20:39 +0000 (GMT)
X-AuditID: b6c32a4a-c1fda70000004ddd-ac-67b9adfa4c79
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	99.59.18729.7AD78B76; Fri, 21 Feb 2025 22:20:39 +0900 (KST)
Received: from cheetah.samsungds.net (unknown [107.109.115.53]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250221132036epsmtip239bbfc8d2110e7dfeca37e78d74bc091~mO8gNLdXG0774707747epsmtip2G;
	Fri, 21 Feb 2025 13:20:36 +0000 (GMT)
From: Shradha Todi <shradha.t@samsung.com>
To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org
Cc: manivannan.sadhasivam@linaro.org, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, bhelgaas@google.com, jingoohan1@gmail.com,
	Jonathan.Cameron@Huawei.com, fan.ni@samsung.com, nifan.cxl@gmail.com,
	a.manzanares@samsung.com, pankaj.dubey@samsung.com, cassel@kernel.org,
	18255117159@163.com, xueshuai@linux.alibaba.com, renyu.zj@linux.alibaba.com,
	will@kernel.org, mark.rutland@arm.com, Shradha Todi <shradha.t@samsung.com>
Subject: [PATCH v7 4/5] Add debugfs based error injection support in DWC
Date: Fri, 21 Feb 2025 18:45:47 +0530
Message-Id: <20250221131548.59616-5-shradha.t@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250221131548.59616-1-shradha.t@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WTe0xTVxjAd3pvby9g5fIYHjsELDNTNqBVWg8gvlByM91GsrElW5Z6pdcW
	KbddH6JmbkWKTiKvZY7JkIh0hBVhhAoWBYeAwDSwMAi6jGYYGQwNAwc6B8LW0rL99zvf9zvn
	O+c755BYYC8hIjM4I6vnGI2Y8MWbOze9Ej1f16KSXJoNQEOnFwSotHM9sp5Uo+7iGgydrHXy
	Uc3ceQGyVQ4TyHx2gY8aHwzz0eC1cgL1VfQQaKipHkeW5xYcOS1n+OibuwM8tNjcBtClpjkB
	qsydBOifVocAFXSeQJYRGZr+207sDKGrar7g05crLgO6pcwpoC82mmhL1xSfbrSdIeiR4VaC
	brkfT48NlfJou/VTuvCKDdCzjWGpq97P3KZmGSWrj2C5dK0yg1Mlife9rUhWyOQSabQ0Hm0V
	R3BMFpsk3rM/NTolQ+M6rTjiCKMxuUKpjMEgjt2+Ta81GdkItdZgTBKzOqVGF6eLMTBZBhOn
	iuFYY4JUItksc4kHMtXVV8t4up/SjjYtWTEzmN6bD3xISMXBz5aeYfnAlwykrgPYMPrYO/gT
	wL571XzP4CmAA4+6iZUpo7kNuCfRBuC5G9Neaw7A4bpqntsiqCiY8yQfc3MwlQdg13iIW8Ko
	Zgy219QsJ4IoGjrKhnE349QGOHHvd1ecJIVUArzzl7+nWjisbWhf1n2oRGjrL+W514HUGAnP
	/tLD90h74N2cKczDQfBhzxWBh0VwsuiUl1XwW/tXXkcDn9qtPA/vgO1D5bi7LkZtgt9di/WE
	18Fzt+uXFYxaDQsWxry6EDoqVjgSzi224h5eCyu6B73boeEd5ylvhwoBfPLlb7xiEFb2f4mL
	ANjAWlZnyFKxBpluM8dm/3dt6dqsRrD8pKNed4D7ozMxHYBHgg4ASUwcLIw2OlSBQiVz7Dir
	1yr0Jg1r6AAyV/9KMNGL6VrXn+CMCmlcvCROLpfHxW+RS8VrhLktFlUgpWKMbCbL6lj9yjwe
	6SMy8w47PgiN3RuJ80SKnhThRuuPoC2yqvXY8aleYtfuyIP8VRvXBf8wLp+4eSK3RHurJHxn
	duwixryMd119lFY4cT7yrZmpjiRjSlCi+l3Zjnx/H7yw3T8hDdYF5IXjt53aWltff2VVx67H
	B0vXVLxkFn39QmiiXP/hkWTYUFKOBpOJj5XP2skbD17tDXeW7O+Tc6MBxZ9TqZ/cmgOvUe8l
	5i1prBxzWunMwWYzBybm/fxSFvyKtoL68aIDz38eOjwfbddYcsz18+9M2r8fM4U40Udhg9cX
	sJkCc9vD7RPW/jfHfLe8kXdh/WpB0oZQjeRodn9uOjkS/+uhQ0LFTTM1+4cYN6gZaRSmNzD/
	AliZQORbBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHLMWRmVeSWpSXmKPExsWy7bCSvO7y2h3pBvtuSlhcaf/NbjH9sKLF
	kqYMi2MTVjBbNK2+y2qx4stMdotVC6+xWTT0/Ga12PT4GqvF5V1z2CzOzjvOZnFl6zoWi5Y/
	LSwWd1s6WS2WXr/IZPF3215Gi0Vbv7BbLGx+yWjxf88Odovew7UWLXdMLd7/3MzmIOaxeMUU
	Vo8189YweuycdZfdY8GmUo+WI29ZPTat6mTzuHNtD5vHzoeWHk+uTGfy2Lyk3qNvyypGj8+b
	5AJ4orhsUlJzMstSi/TtErgylm2fxVRwKbRi678lzA2M7127GDk5JARMJB40b2ABsYUEdjNK
	vJthBxGXlPh8cR0ThC0ssfLfc/YuRi6gmk+MEif2bQNrYBPQkmj82sUMkhAR6GSU2HvkHVgV
	s8A5ZomZn1sYQaqEBTwkdsy6BtbBIqAq8fzGC6AODg5eASuJ09/5ITbIS6zecIAZxOYUsJZY
	dW46E8RFVhJ7ttxnncDIt4CRYRWjZGpBcW56brFhgWFearlecWJucWleul5yfu4mRnAUaWnu
	YNy+6oPeIUYmDsZDjBIczEoivLolO9KFeFMSK6tSi/Lji0pzUosPMUpzsCiJ84q/6E0REkhP
	LEnNTk0tSC2CyTJxcEo1ME0NrXt9W5UnxsC8vnODVvuTStH2pO6vX1oeB5vscmyd/fMLW0RX
	RMKm6w0Vj5okjmm+f8/8cja37yStvLI/8Yr7S169jzmfF7lMJKLlwTkur6wHL123TH4xJU/o
	++69N89asGyVdt5tonZwTXf6Ta08XdvbpZ6fJc36fk6tO36qI6/puMDmdVNfFhiWWbw667r/
	5fcZL+cxNPvsY/8892NawPWLa24rZfhzpSu+CDuZz3tw7RVG9l0Tg7Ol3/ieVTq/vHmKyI5b
	lllTLEQSlgXwxDQsqeO9F7DCQHHbto0PTy7/bP6/8lLIiyCrphJv28cLDX6yTC10fu11IWJO
	WRyP7ToL05s/BWYqv2zKnqLEUpyRaKjFXFScCAACJQ+rEQMAAA==
X-CMS-MailID: 20250221132039epcas5p31913eab0acec1eb5e7874897a084c725
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250221132039epcas5p31913eab0acec1eb5e7874897a084c725
References: <20250221131548.59616-1-shradha.t@samsung.com>
	<CGME20250221132039epcas5p31913eab0acec1eb5e7874897a084c725@epcas5p3.samsung.com>
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
index e8ed34e988ef..6ee0897fe753 100644
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
+		(WO) Write to the attribute will prepare controller to inject the respective
+		error in the next transmission of data. Parameter required to write will
+		change in the following ways:
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
index 3887a6996706..b7260edd2336 100644
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
 
 /**
@@ -33,6 +47,72 @@ struct dwc_pcie_rasdes_info {
 	struct mutex reg_event_lock;
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
@@ -93,6 +173,63 @@ static ssize_t rx_valid_write(struct file *file, const char __user *buf, size_t
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
@@ -107,6 +244,11 @@ static const struct file_operations dbg_ ## name ## _fops = {	\
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
@@ -116,10 +258,11 @@ static void dwc_pcie_rasdes_debugfs_deinit(struct dw_pcie *pci)
 
 static int dwc_pcie_rasdes_debugfs_init(struct dw_pcie *pci, struct dentry *dir)
 {
-	struct dentry *rasdes_debug;
+	struct dentry *rasdes_debug, *rasdes_err_inj;
 	struct dwc_pcie_rasdes_info *rasdes_info;
+	struct dwc_pcie_rasdes_priv *priv_tmp;
 	struct device *dev = pci->dev;
-	int ras_cap;
+	int ras_cap, i, ret;
 
 	ras_cap = dw_pcie_find_rasdes_capability(pci);
 	if (!ras_cap) {
@@ -133,6 +276,7 @@ static int dwc_pcie_rasdes_debugfs_init(struct dw_pcie *pci, struct dentry *dir)
 
 	/* Create subdirectories for Debug, Error injection, Statistics */
 	rasdes_debug = debugfs_create_dir("rasdes_debug", dir);
+	rasdes_err_inj = debugfs_create_dir("rasdes_err_inj", dir);
 
 	mutex_init(&rasdes_info->reg_event_lock);
 	rasdes_info->ras_cap_offset = ras_cap;
@@ -142,7 +286,24 @@ static int dwc_pcie_rasdes_debugfs_init(struct dw_pcie *pci, struct dentry *dir)
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


