Return-Path: <linux-pci+bounces-20184-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4651FA17D9F
	for <lists+linux-pci@lfdr.de>; Tue, 21 Jan 2025 13:14:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 412253A31BB
	for <lists+linux-pci@lfdr.de>; Tue, 21 Jan 2025 12:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2517C1F191E;
	Tue, 21 Jan 2025 12:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ZxgXYAe/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6157A1F193F
	for <linux-pci@vger.kernel.org>; Tue, 21 Jan 2025 12:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737461689; cv=none; b=NhLJgSqtcg4VXzkMs1kQCkk1bxgpxkdzCyvDXREeT/fy1SUpch+k4I5a2dKhPZXQwiXEXhvboNElahBFWq3qVFMMALYdo9XgD1YJZeObRYeZX2Q5lxQpr//Qh6bUrPxMdsLWZh56OMwPR3ieLqhYpCHqTXsB/VOsdWY+cvDurGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737461689; c=relaxed/simple;
	bh=5adRfrzZxmkOwnYYUxs/QxgMeVRUHf/I0jq+wE26w68=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:Content-Type:
	 References; b=We2VP9u/I4YRT5yi1diD/T0uwLW1D55IXBXg+xrkHz0at5NMGLsxjP8mnAJt6FmfayE+SQBVHKHwqwjorxquTD7vo33QOAZqV5IU1nfCk16lMJpXU4TOGmjypNFVNPe5jmvqFLTICuwxL+GQjZPU0wPeCfUrVPBp3Dn6VskhAHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ZxgXYAe/; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250121121438epoutp020ae590df4cf84f4022f1bdf4c6eacaa8~ctDDic9y72361923619epoutp02J
	for <linux-pci@vger.kernel.org>; Tue, 21 Jan 2025 12:14:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250121121438epoutp020ae590df4cf84f4022f1bdf4c6eacaa8~ctDDic9y72361923619epoutp02J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1737461678;
	bh=RFOVXKR7bc7/bHPo+3Ty6gn2tlgKFINmXdaMP9FPMgc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZxgXYAe/yJ4Qv5uGM/6meQdhp2AlFS23NRE0hM+2p62pnLa/rUZW5QegIsaTca3AT
	 gTpwvebVe2qMSunyZmvYZvGvcy52OgR9QMQswD2ic6tAqcFSQgc4aqtjeC7peDkMtB
	 YxEvQz3f6CJ2ssPV2QOXhjsjB+ISBqrpt2NU68rI=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20250121121437epcas5p310d498123652c5711c00b19cb31f2a57~ctDDD9X733019030190epcas5p3M;
	Tue, 21 Jan 2025 12:14:37 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.182]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4YcmNX3XsJz4x9Pt; Tue, 21 Jan
	2025 12:14:36 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	44.B5.29212.CAF8F876; Tue, 21 Jan 2025 21:14:36 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20250121115209epcas5p3c5974d568705bc669645c72026dcba22~csvbz4Am91183111831epcas5p3k;
	Tue, 21 Jan 2025 11:52:09 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250121115209epsmtrp1740d04a859650e2cff5accccc7da3ff3~csvbzCsF-0976909769epsmtrp1Y;
	Tue, 21 Jan 2025 11:52:09 +0000 (GMT)
X-AuditID: b6c32a50-801fa7000000721c-14-678f8faccace
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	BB.84.23488.96A8F876; Tue, 21 Jan 2025 20:52:09 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
	[107.109.115.6]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250121115207epsmtip1e36221c73876013b8df774fee51fbd46~csvZm_vpg1806918069epsmtip1X;
	Tue, 21 Jan 2025 11:52:07 +0000 (GMT)
From: Shradha Todi <shradha.t@samsung.com>
To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc: manivannan.sadhasivam@linaro.org, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, bhelgaas@google.com, jingoohan1@gmail.com,
	Jonathan.Cameron@Huawei.com, fan.ni@samsung.com, a.manzanares@samsung.com,
	pankaj.dubey@samsung.com, quic_nitegupt@quicinc.com,
	quic_krichai@quicinc.com, gost.dev@samsung.com, Shradha Todi
	<shradha.t@samsung.com>
Subject: [PATCH v5 3/4] Add debugfs based error injection support in DWC
Date: Tue, 21 Jan 2025 16:44:20 +0530
Message-Id: <20250121111421.35437-4-shradha.t@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250121111421.35437-1-shradha.t@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNJsWRmVeSWpSXmKPExsWy7bCmpu6a/v50g7lvxSymH1a0WNKUYdG0
	+i6rxc0DO5ksVnyZyW6xauE1NouGnt+sFpd3zWGzODvvOJtFy58WFou7LZ2sFou2fmG3ePCg
	0qJzzhFmi/97drBb9B6udRDw2DnrLrvHgk2lHi1H3rJ6bFrVyeZx59oeNo8nV6YzeUzcU+fR
	t2UVo8fnTXIBnFHZNhmpiSmpRQqpecn5KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJuam2Si4+
	AbpumTlAHygplCXmlAKFAhKLi5X07WyK8ktLUhUy8otLbJVSC1JyCkwK9IoTc4tL89L18lJL
	rAwNDIxMgQoTsjOeXupgL/gWWrF0x2nGBsZety5GTg4JAROJeX0TWUBsIYE9jBKfrzND2J8Y
	JU5O8+li5AKyvzFKnNh6mgmm4cGEJ8wQib2MEu9XX4Fympkk1mxZwA5SxSagJdH4tQtslIiA
	tcTh9i1sIEXMAk+ZJFqP/wRyODiEBTwkrl73AqlhEVCVONh6HKyXV8BK4uTdkywQ2+QlVm84
	ADaHE2jOmyN3WEHmSAgs5JA4+b0P6iQXiTu/2tkhbGGJV8e3QNlSEi/726DsdImVm2cwQ9g5
	Et82L4HqtZc4cGUOC8g9zAKaEut36UOEZSWmnloHVsIswCfR+/sJVDmvxI55MLayxJe/e6Du
	lJSYd+wyK4TtIXF01gd2SKD0MUr83/2BdQKj3CyEFQsYGVcxSqUWFOempyabFhjq5qWWw2Mt
	OT93EyM4lWoF7GBcveGv3iFGJg7GQ4wSHMxKIryiH3rShXhTEiurUovy44tKc1KLDzGaAkNw
	IrOUaHI+MJnnlcQbmlgamJiZmZlYGpsZKonzNu9sSRcSSE8sSc1OTS1ILYLpY+LglGpgqt3h
	Ibsv6Kqhy4Enh+b2yazi4Z8ie7gnXtY3ZUO6pMNnod/NhS+n3XlUelbic8OZTRI8LqcSMlXr
	qheeyX3sb3HobsBXBqV/Lnp7zAtErqnNDup4v2rhJ44MXX/frWneF49kTFjApniiS3Rjd9ex
	b4/ezF9+sz5sseTCYlvFl2xy1+ZKyD+YUOqdevGqxJF3IT96phbtne8d9MX9hOneuod1jcuK
	H1zbqbjucWwao9SxOU3cC/9eqyo7PX/zZhHfi1odybF/93y+Y+Q2e/UR8SKe6jJj6fXSn39X
	mHalTb90XX93o8rnE9oz9/z9WvtaYkalmY5rZ9ydK1zHb+4KlSpmXZ530rrw7ysXgd1rDymx
	FGckGmoxFxUnAgBhzU2uLgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrILMWRmVeSWpSXmKPExsWy7bCSnG5mV3+6wbEvxhbTDytaLGnKsGha
	fZfV4uaBnUwWK77MZLdYtfAam0VDz29Wi8u75rBZnJ13nM2i5U8Li8Xdlk5Wi0Vbv7BbPHhQ
	adE55wizxf89O9gteg/XOgh47Jx1l91jwaZSj5Yjb1k9Nq3qZPO4c20Pm8eTK9OZPCbuqfPo
	27KK0ePzJrkAzigum5TUnMyy1CJ9uwSujKeXOtgLvoVWLN1xmrGBsdeti5GTQ0LAROLBhCfM
	XYxcHEICuxkldl48zAiRkJT4fHEdE4QtLLHy33N2EFtIoJFJYsccZhCbTUBLovFrF5gtImAr
	cf/RZFaQQcwCX5kkPn66AZTg4BAW8JC4et0LpIZFQFXiYOtxsDm8AlYSJ++eZIGYLy+xesMB
	sDmcAtYSb47cYYXYZSUxe/sp1gmMfAsYGVYxSqYWFOem5yYbFhjmpZbrFSfmFpfmpesl5+du
	YgSHupbGDsZ335r0DzEycTAeYpTgYFYS4RX90JMuxJuSWFmVWpQfX1Sak1p8iFGag0VJnHel
	YUS6kEB6YklqdmpqQWoRTJaJg1OqgUlxf90xq6vPe3rNMtfs4ZCrOdq+x17x5+tPW8ykExsn
	FzlEfTguldSan7foANu0p1OSXp/ZaCI240pw2qqAtWcYvaI+vlXInuGwctpcpxqxibcrdOxd
	eHIfvi+Zz7HZ1na56YxkCeYvd/87Obw41dHd8OJLh6S228Opjxkas14s/iGwgH/Zkje1eyp6
	XzKL75D3Xvtpwp3H5u+X7QlqiIjdHLFa+vXpnuiDwj49r1mulnDKhnfLHGzvumH8w2y98v+s
	J18/KO2NnbvqV6xtVMy/dUyrnl7Tf7r147qFKhOeMu7/J/rT48lMyUilmzP+zOR4WVTxme2A
	UMEOv7KEub2vuVukI4oe3Hw0J3jTo1eLlFiKMxINtZiLihMBGMp2peQCAAA=
X-CMS-MailID: 20250121115209epcas5p3c5974d568705bc669645c72026dcba22
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250121115209epcas5p3c5974d568705bc669645c72026dcba22
References: <20250121111421.35437-1-shradha.t@samsung.com>
	<CGME20250121115209epcas5p3c5974d568705bc669645c72026dcba22@epcas5p3.samsung.com>
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
index e7920ac82e38..cff205ab2678 100644
--- a/Documentation/ABI/testing/debugfs-dwc-pcie
+++ b/Documentation/ABI/testing/debugfs-dwc-pcie
@@ -11,3 +11,73 @@ Contact:	Shradha Todi <shradha.t@samsung.com>
 Description:	(RW) Write the lane number to be checked as valid or invalid. Read
 		will return the status of PIPE RXVALID signal of the selected lane.
 		The default selected lane is Lane0.
+
+What:		/sys/kernel/debug/dwc_pcie_<dev>/rasdes_err_inj/<error>
+Date:		January 2025
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
index 907864c35ef3..801d51d8786f 100644
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
 
 struct dwc_pcie_vendor_id {
@@ -45,6 +59,72 @@ struct dwc_pcie_rasdes_info {
 	struct dentry *rasdes_dir;
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
@@ -105,6 +185,63 @@ static ssize_t rx_valid_write(struct file *file, const char __user *buf, size_t
 	return lane_detect_write(file, buf, count, ppos);
 }
 
+static ssize_t err_inj_write(struct file *file, const char __user *buf, size_t count, loff_t *ppos)
+{
+	struct dwc_pcie_rasdes_priv *pdata = file->private_data;
+	struct dw_pcie *pci = pdata->pci;
+	struct dwc_pcie_rasdes_info *rinfo = pci->rasdes_info;
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
@@ -119,6 +256,11 @@ static const struct file_operations dbg_ ## name ## _fops = {	\
 DWC_DEBUGFS_FOPS(lane_detect);
 DWC_DEBUGFS_FOPS(rx_valid);
 
+static const struct file_operations dwc_pcie_err_inj_ops = {
+	.open = simple_open,
+	.write = err_inj_write,
+};
+
 void dwc_pcie_rasdes_debugfs_deinit(struct dw_pcie *pci)
 {
 	struct dwc_pcie_rasdes_info *rinfo = pci->rasdes_info;
@@ -129,12 +271,13 @@ void dwc_pcie_rasdes_debugfs_deinit(struct dw_pcie *pci)
 
 int dwc_pcie_rasdes_debugfs_init(struct dw_pcie *pci)
 {
-	struct dentry *dir, *rasdes_debug;
+	struct dentry *dir, *rasdes_debug, *rasdes_err_inj;
 	struct dwc_pcie_rasdes_info *rasdes_info;
+	struct dwc_pcie_rasdes_priv *priv_tmp;
 	const struct dwc_pcie_vendor_id *vid;
 	char dirname[DWC_DEBUGFS_BUF_MAX];
 	struct device *dev = pci->dev;
-	int ras_cap;
+	int ras_cap, i, ret;
 
 	for (vid = dwc_pcie_vendor_ids; vid->vendor_id; vid++) {
 		ras_cap = dw_pcie_find_vsec_capability(pci, vid->vendor_id,
@@ -159,6 +302,7 @@ int dwc_pcie_rasdes_debugfs_init(struct dw_pcie *pci)
 
 	/* Create subdirectories for Debug, Error injection, Statistics */
 	rasdes_debug = debugfs_create_dir("rasdes_debug", dir);
+	rasdes_err_inj = debugfs_create_dir("rasdes_err_inj", dir);
 
 	mutex_init(&rasdes_info->reg_lock);
 	rasdes_info->ras_cap_offset = ras_cap;
@@ -169,5 +313,22 @@ int dwc_pcie_rasdes_debugfs_init(struct dw_pcie *pci)
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
-- 
2.17.1


