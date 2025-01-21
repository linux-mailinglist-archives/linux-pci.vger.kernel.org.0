Return-Path: <linux-pci+bounces-20183-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1F8A17D9D
	for <lists+linux-pci@lfdr.de>; Tue, 21 Jan 2025 13:14:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77B351885740
	for <lists+linux-pci@lfdr.de>; Tue, 21 Jan 2025 12:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C33C81F193F;
	Tue, 21 Jan 2025 12:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ZpOVpIcW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1DB1F192A
	for <linux-pci@vger.kernel.org>; Tue, 21 Jan 2025 12:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737461672; cv=none; b=q+VfoU+YUb7v7wJ6/5q9PATkA4wMNSfsaUQfPrWdFYt8bq8zPAHx6WnTZpFUbaBif302iuf+1rum4IWKbcZr3ob7OnllPw+uZUG3JsvtYziFRIC9o/RKWNZ1G1gXcqb2G/gBQlFVDycEwYSvJ32KCvFSjQJuMxj0gRuxa0JosjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737461672; c=relaxed/simple;
	bh=oGpRp1ZJErLrFBo9XqKuEX/A0IR8jq5a4lX0B8kKt08=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:Content-Type:
	 References; b=N6B0RjxbEeuSU7vWu6Z8pb0UuEKPf8XcEGMZgLsHPTP1WySF42cAII/ksaNBxnH4n7sH2ygEXQsIXAsiYoX5OMrzRWzO1+H9ajyA+8f/9mfNvakRL5T5ie+CovmwD9SjP8yUkqPhmR4Rv4e2+PhXM/sB/HxOy33S+EYl5kSkbRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ZpOVpIcW; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250121121423epoutp039d720dbbefff667b4d075a277010440b~ctC1YZCes1707417074epoutp03C
	for <linux-pci@vger.kernel.org>; Tue, 21 Jan 2025 12:14:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250121121423epoutp039d720dbbefff667b4d075a277010440b~ctC1YZCes1707417074epoutp03C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1737461663;
	bh=v/VXEw+Nf97jMo1Q+NvRDbGc4fCNgcVdNPd07N1C7YM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZpOVpIcW17jQvvCvt1gCRQ2O8Ds8u5XEtwIMvVTUcimGQxllidQ6bZmVncf7XMPw9
	 +y9yxKHfEATdNL/WxlBUqqgAjDQE8i8O4F8ckAJ8u88dRLes3BrtAnv3p4GPO4L200
	 blhXrTeZGalCTsJiGj0+FwH2WBQd1VldXmWRBpxg=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20250121121421epcas5p1f32067773456f9808091c778f6e14608~ctC0BICG51323213232epcas5p1h;
	Tue, 21 Jan 2025 12:14:21 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.183]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4YcmND2G1Kz4x9Pp; Tue, 21 Jan
	2025 12:14:20 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	AA.3A.20052.C9F8F876; Tue, 21 Jan 2025 21:14:20 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250121115213epcas5p14d712e58b5bf6505b0bd729fb33b25b8~csvfZAqAi1625416254epcas5p1x;
	Tue, 21 Jan 2025 11:52:13 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250121115213epsmtrp1b14c75c5157af5c74474e89896e13da6~csvfXasw_0976909769epsmtrp1j;
	Tue, 21 Jan 2025 11:52:13 +0000 (GMT)
X-AuditID: b6c32a49-3d20270000004e54-57-678f8f9c64a4
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	8B.BB.18949.D6A8F876; Tue, 21 Jan 2025 20:52:13 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
	[107.109.115.6]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250121115211epsmtip19f988ed6d8c1f80c8391dba98cdd45a1~csvdIKuRU1750517505epsmtip1D;
	Tue, 21 Jan 2025 11:52:11 +0000 (GMT)
From: Shradha Todi <shradha.t@samsung.com>
To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc: manivannan.sadhasivam@linaro.org, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, bhelgaas@google.com, jingoohan1@gmail.com,
	Jonathan.Cameron@Huawei.com, fan.ni@samsung.com, a.manzanares@samsung.com,
	pankaj.dubey@samsung.com, quic_nitegupt@quicinc.com,
	quic_krichai@quicinc.com, gost.dev@samsung.com, Shradha Todi
	<shradha.t@samsung.com>
Subject: [PATCH v5 4/4] Add debugfs based statistical counter support in DWC
Date: Tue, 21 Jan 2025 16:44:21 +0530
Message-Id: <20250121111421.35437-5-shradha.t@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250121111421.35437-1-shradha.t@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFJsWRmVeSWpSXmKPExsWy7bCmhu6c/v50g8VfeS2mH1a0WNKUYdG0
	+i6rxc0DO5ksVnyZyW6xauE1NouGnt+sFpd3zWGzODvvOJtFy58WFou7LZ2sFou2fmG3ePCg
	0qJzzhFmi/97drBb9B6udRDw2DnrLrvHgk2lHi1H3rJ6bFrVyeZx59oeNo8nV6YzeUzcU+fR
	t2UVo8fnTXIBnFHZNhmpiSmpRQqpecn5KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJuam2Si4+
	AbpumTlAHygplCXmlAKFAhKLi5X07WyK8ktLUhUy8otLbJVSC1JyCkwK9IoTc4tL89L18lJL
	rAwNDIxMgQoTsjPerpvGXjAvvWLvGb0Gxj1hXYycHBICJhL/1u1h7WLk4hAS2M0o0dh8HMr5
	xCjx9e8UdgjnG6PE0dsdQA4HWMurJUkQ8b2MEhOmHIYqamaSaD73jhVkLpuAlkTj1y5mEFtE
	wFricPsWNpAiZoGnTBKtx3+ygSSEBXwk1k/dxQ5iswioSqxvOwjWzCtgJXG59zELxIHyEqs3
	HAAbxAk06M2RO2D3SQgs5JB4duEQM8RJLhI7z8dD1AtLvDq+hR3ClpJ42d8GZadLrNw8gxnC
	zpH4tnkJE4RtL3HgyhwWkDHMApoS63fpQ4RlJaaeWgdWwizAJ9H7+wlUOa/EjnkwtrLEl797
	oM6UlJh37DIrhO0h8ff5J2ZIoPQxSmy68pRxAqPcLIQVCxgZVzFKphYU56anFpsWGOallsMj
	LTk/dxMjOJFqee5gvPvgg94hRiYOxkOMEhzMSiK8oh960oV4UxIrq1KL8uOLSnNSiw8xmgLD
	byKzlGhyPjCV55XEG5pYGpiYmZmZWBqbGSqJ8zbvbEkXEkhPLEnNTk0tSC2C6WPi4JRqYEr+
	X2XbtOXSfffZc7aqyfrIx52ofTNl9coJe4SeXQ2Icv0zVc6ffc7Xid7CHcsCbZ98z3R4p/t7
	8fK4o/s0ziYI3UtZsUTXo+OXxuZ1JVIxmc/+ML4rcVGPeF6z10LeLFc+IHipvLmP6/m9yyqE
	nt0tjfwzocddtuLWc4vLBo1J+o8rvuTWfD32LGTV/N2XjTTqWieLcc8+PcmssV/q7o8g1sDw
	3zv2O70sTFNNPfS7puLxZ+bfpfeE2Fa9bm78IPxR+8/zhybxQkvFN/A0+Fcb8d38uf3NTp0/
	fopVu2yavhz92f/kcsuUuH/HdTgVZonkrF7fELuJ7QmPj4fi9E1P+f4/9mAS3THt8YI/dbZK
	LMUZiYZazEXFiQCdZwjULQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrILMWRmVeSWpSXmKPExsWy7bCSnG5uV3+6wYKLqhbTDytaLGnKsGha
	fZfV4uaBnUwWK77MZLdYtfAam0VDz29Wi8u75rBZnJ13nM2i5U8Li8Xdlk5Wi0Vbv7BbPHhQ
	adE55wizxf89O9gteg/XOgh47Jx1l91jwaZSj5Yjb1k9Nq3qZPO4c20Pm8eTK9OZPCbuqfPo
	27KK0ePzJrkAzigum5TUnMyy1CJ9uwSujLfrprEXzEuv2HtGr4FxT1gXIweHhICJxKslSV2M
	XBxCArsZJRa8fMPaxcgJFJeU+HxxHROELSyx8t9zdoiiRiaJjatusYEk2AS0JBq/djGD2CIC
	thL3H01mBSliFvjKJPHx0w2whLCAj8T6qbvYQWwWAVWJ9W0HwTbwClhJXO59zAKxQV5i9YYD
	YPWcAtYSb47cAasRAqqZvf0U6wRGvgWMDKsYJVMLinPTc4sNC4zyUsv1ihNzi0vz0vWS83M3
	MYJDXUtrB+OeVR/0DjEycTAeYpTgYFYS4RX90JMuxJuSWFmVWpQfX1Sak1p8iFGag0VJnPfb
	694UIYH0xJLU7NTUgtQimCwTB6dUAxOffPeT58/Vvt8sLtogq5PH+0VoRWzw748P7Rs+NH0W
	WhBTulXPYN2qW9ILPn6UNDSNvvku4KDby4CFvLlWNjcMFjys2PLhy+Q93x/PmDVPY8WS55oL
	GfNvx0WeeLzMcJ7RlCDHuhtTwz/NCaoLKV0d6bY9Y9K1LUyiD+7WLPlap3GY+Zq86uvSYM1H
	n74GOknOXFV1To6hReHPtcR88/RnJ1TEVzXVRohOmCMtrjPT7dH8m/rJsxpTl0ot4NZSnbp0
	b8Xa1eHyZ82dH526qb1mr4evcPrnWu+N0S8FpP9IrZa2d5n6d6LkrAcfjuoGKWxdGPvzWEzK
	6oRFualGKUzsEzlKFnAUhi76dUomrfaBEktxRqKhFnNRcSIANbBp9eQCAAA=
X-CMS-MailID: 20250121115213epcas5p14d712e58b5bf6505b0bd729fb33b25b8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250121115213epcas5p14d712e58b5bf6505b0bd729fb33b25b8
References: <20250121111421.35437-1-shradha.t@samsung.com>
	<CGME20250121115213epcas5p14d712e58b5bf6505b0bd729fb33b25b8@epcas5p1.samsung.com>
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
index cff205ab2678..d3f84f46b400 100644
--- a/Documentation/ABI/testing/debugfs-dwc-pcie
+++ b/Documentation/ABI/testing/debugfs-dwc-pcie
@@ -81,3 +81,64 @@ Description:	rasdes_err_inj is the directory which can be used to inject errors
 
 			<count>
 				Number of errors to be injected
+
+What:		/sys/kernel/debug/dwc_pcie_<dev>/rasdes_event_counters/<event>/counter_enable
+Date:		January 2025
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
+Date:		January 2025
+Contact:	Shradha Todi <shradha.t@samsung.com>
+Description:	(RO) Read will return the current value of the event counter. To reset the counter,
+		counter should be disabled and enabled back using the 'counter_enable' attribute.
+
+What:		/sys/kernel/debug/dwc_pcie_<dev>/rasdes_event_counters/<event>/lane_select
+Date:		January 2025
+Contact:	Shradha Todi <shradha.t@samsung.com>
+Description:	(RW) Some lanes in the event list are lane specific events. These include
+		events 1) - 11) and 34) - 35).
+		Write lane number for which counter needs to be enabled/disabled/dumped.
+		Read will return the current selected lane number. Lane0 is selected by default.
diff --git a/drivers/pci/controller/dwc/pcie-designware-debugfs.c b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
index 801d51d8786f..5d883b13be84 100644
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
 
 struct dwc_pcie_vendor_id {
@@ -125,6 +136,61 @@ static const u32 err_inj_type_mask[] = {
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
@@ -242,6 +308,127 @@ static ssize_t err_inj_write(struct file *file, const char __user *buf, size_t c
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
+	struct dwc_pcie_rasdes_info *rinfo = pci->rasdes_info;
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
+	struct dwc_pcie_rasdes_info *rinfo = pci->rasdes_info;
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
+	struct dwc_pcie_rasdes_info *rinfo = pci->rasdes_info;
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
+	struct dwc_pcie_rasdes_info *rinfo = pci->rasdes_info;
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
+	struct dwc_pcie_rasdes_info *rinfo = pci->rasdes_info;
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
@@ -261,6 +448,23 @@ static const struct file_operations dwc_pcie_err_inj_ops = {
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
 void dwc_pcie_rasdes_debugfs_deinit(struct dw_pcie *pci)
 {
 	struct dwc_pcie_rasdes_info *rinfo = pci->rasdes_info;
@@ -271,7 +475,7 @@ void dwc_pcie_rasdes_debugfs_deinit(struct dw_pcie *pci)
 
 int dwc_pcie_rasdes_debugfs_init(struct dw_pcie *pci)
 {
-	struct dentry *dir, *rasdes_debug, *rasdes_err_inj;
+	struct dentry *dir, *rasdes_debug, *rasdes_err_inj, *rasdes_event_counter, *rasdes_events;
 	struct dwc_pcie_rasdes_info *rasdes_info;
 	struct dwc_pcie_rasdes_priv *priv_tmp;
 	const struct dwc_pcie_vendor_id *vid;
@@ -303,6 +507,7 @@ int dwc_pcie_rasdes_debugfs_init(struct dw_pcie *pci)
 	/* Create subdirectories for Debug, Error injection, Statistics */
 	rasdes_debug = debugfs_create_dir("rasdes_debug", dir);
 	rasdes_err_inj = debugfs_create_dir("rasdes_err_inj", dir);
+	rasdes_event_counter = debugfs_create_dir("rasdes_event_counter", dir);
 
 	mutex_init(&rasdes_info->reg_lock);
 	rasdes_info->ras_cap_offset = ras_cap;
@@ -326,6 +531,28 @@ int dwc_pcie_rasdes_debugfs_init(struct dw_pcie *pci)
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


