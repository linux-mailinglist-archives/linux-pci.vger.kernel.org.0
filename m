Return-Path: <linux-pci+bounces-9224-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2000091656E
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jun 2024 12:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB3112846D4
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jun 2024 10:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4FE514A4D9;
	Tue, 25 Jun 2024 10:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="OqTZI+ot"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360441465BA
	for <linux-pci@vger.kernel.org>; Tue, 25 Jun 2024 10:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719312147; cv=none; b=glc1KGmWWKSL6CsjKDZ2EMPV0K2xRc1IUuaDBHmYyKeziQK8ao0FqL6J4iR4c1cExhxv84F1Cmw69oPAMB2bHgYCVx+RS501WbmE2IEX2K4eiG1+P18+7sRtyPjcDBYmtO35IRpiU0A4KeKZklP1Yr/o7b9llDFCpm+GpGqtAjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719312147; c=relaxed/simple;
	bh=ZiMOROs3SbFUcN8w27eex4s85npjeSVsG6rog5OfktU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:Content-Type:
	 References; b=A5/E8J8n1d8etuhhpOL5P73HEYl8M+N3wwFiZ3amc0/RDpgzP7M1MCIo0Ijd1wocj+U7KGC6fI8fuvBollNQ5jAQQ+DPv3Ym/ZYJd+j99msWMjZkhjczg3A2qrtTq036UWezC8Wze9f+CsiNDOWQHxzKDgXUdqgdClcG9amcCVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=OqTZI+ot; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240625104220epoutp01072e318d3dc942824173845f45d93332~cOUhocdov0611106111epoutp01q
	for <linux-pci@vger.kernel.org>; Tue, 25 Jun 2024 10:42:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240625104220epoutp01072e318d3dc942824173845f45d93332~cOUhocdov0611106111epoutp01q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1719312140;
	bh=wcPKInS+CZCayfdveZAr8MZPCKgSJslBXrWjoQgaz3U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OqTZI+ot0N1uE6f+DBfr4ameBUbl1X5M3bdAa2CfTik60RR9JVuTzcxEUdFwx3a6g
	 eFemWR5eQrwlQqlBVNQJI8ZN0+lkBUWx0DTiudVRBLAo6fIYIsRAyhbasF7qy4u2xy
	 FUVNDQbB/Sonx/+aNMhf6CkftW91rrKtqG/Vj/FI=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20240625104220epcas5p4a0979b4455616538d0c720f1e7b475b8~cOUg5Tf1Z0612606126epcas5p4M;
	Tue, 25 Jun 2024 10:42:20 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.183]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4W7hGy2l0Fz4x9Py; Tue, 25 Jun
	2024 10:42:18 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	A3.6B.06857.A0F9A766; Tue, 25 Jun 2024 19:42:18 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20240625094443epcas5p3093ac786a7d0f09de5a3bba17bbd4458~cNiN6lVPo1825618256epcas5p3J;
	Tue, 25 Jun 2024 09:44:43 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240625094443epsmtrp10d87009b8991100ad62cdb00d8db9308~cNiN5vBE21600816008epsmtrp1Q;
	Tue, 25 Jun 2024 09:44:43 +0000 (GMT)
X-AuditID: b6c32a4b-88bff70000021ac9-41-667a9f0a2870
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	ED.88.07412.B819A766; Tue, 25 Jun 2024 18:44:43 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
	[107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240625094441epsmtip1b263dfb07428b25d5f7f97564f23da4f~cNiLvoeCL0560105601epsmtip1G;
	Tue, 25 Jun 2024 09:44:41 +0000 (GMT)
From: Shradha Todi <shradha.t@samsung.com>
To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc: manivannan.sadhasivam@linaro.org, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, bhelgaas@google.com, jingoohan1@gmail.com,
	fancer.lancer@gmail.com, yoshihiro.shimoda.uh@renesas.com,
	conor.dooley@microchip.com, pankaj.dubey@samsung.com, gost.dev@samsung.com,
	Shradha Todi <shradha.t@samsung.com>
Subject: [PATCH 2/3] PCI: debugfs: Add support for RASDES framework in DWC
Date: Tue, 25 Jun 2024 15:08:12 +0530
Message-Id: <20240625093813.112555-3-shradha.t@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240625093813.112555-1-shradha.t@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKJsWRmVeSWpSXmKPExsWy7bCmhi7X/Ko0g2efuC2WNGVYTNm0g91i
	Q8ccVoubB3YyWaz4MpPdoqHnN6vF5V1z2CzOzjvOZtHyp4XF4m5LJ6vFoq1f2C3+7wHq6D1c
	a/F172c2Bz6PnbPusnss2FTqsWlVJ5vHnWt72DyeXJnO5HHnx1JGj29nJrJ49G1ZxejxeZNc
	AGdUtk1GamJKapFCal5yfkpmXrqtkndwvHO8qZmBoa6hpYW5kkJeYm6qrZKLT4CuW2YO0OlK
	CmWJOaVAoYDE4mIlfTubovzSklSFjPziElul1IKUnAKTAr3ixNzi0rx0vbzUEitDAwMjU6DC
	hOyMhZ8fMBX0dDNWfNj2hb2BcXJxFyMnh4SAicSPSTfZuhi5OIQEdjNKnD/aywThfGKUWN6y
	jBnC+cYoMffwY2aYlnW71rNAJPYySnyYMZ8JJCEk0Mok8edFGYjNJqAl0fi1C6xBRMBa4nD7
	FrAdzAK7mCR6npxjBEkIC3hJvP94gh3EZhFQlbh6ahULiM0L1LD0724miG3yEqs3HAAaxMHB
	KWAjMfGyEsgcCYGZHBI7LjyBqnGRWHz6DCuELSzx6vgWdghbSuJlfxuUnS6xcvMMqA9yJL5t
	XgLVay9x4MocFpD5zAKaEut36UOEZSWmnloHVsIswCfR+xtmFa/EjnkwtrLEl797WCBsSYl5
	xy5DneAhMfX7b2gw9jNKfJxynG0Co9wshBULGBlXMUqmFhTnpqcWmxYY56WWw6MtOT93EyM4
	fWp572B89OCD3iFGJg7GQ4wSHMxKIryhJVVpQrwpiZVVqUX58UWlOanFhxhNgeE3kVlKNDkf
	mMDzSuINTSwNTMzMzEwsjc0MlcR5X7fOTRESSE8sSc1OTS1ILYLpY+LglGpgMu5kn26zt37G
	grKjVqVuXycJF4a275jmvEi54cG0p0dedihdk5S4yGCTm1Hdkepu39PvNkly1u2SgxEHz0xV
	1Zv03f/bnJt3K3sXaq5b3Ditr/TtKvEdD4r3B1omTd243EDG9HNiVPz3mcwOLVr2fgmeM+/9
	c1Nc9NXpPG/eZjd2pxf7Z+/nsftQtDFxpqaEj7FZ08t/J944qezc659UbNy0RkAsvj5iwV/l
	+MMWGzfcz5676OgL1hJREUGeVxn+hT4vHrOmFFslvlyxupi/uKpo9SFNvVmLHBlEzs9qspDP
	36h5QTckuC6lk8OWfwm/p6+C5bMDxybMPyP4+LDeHMPA7zrcd3eGRDFYlv9UYinOSDTUYi4q
	TgQAFKR9QygEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDLMWRmVeSWpSXmKPExsWy7bCSnG73xKo0g88PVSyWNGVYTNm0g91i
	Q8ccVoubB3YyWaz4MpPdoqHnN6vF5V1z2CzOzjvOZtHyp4XF4m5LJ6vFoq1f2C3+7wHq6D1c
	a/F172c2Bz6PnbPusnss2FTqsWlVJ5vHnWt72DyeXJnO5HHnx1JGj29nJrJ49G1ZxejxeZNc
	AGcUl01Kak5mWWqRvl0CV8bCzw+YCnq6GSs+bPvC3sA4ubiLkZNDQsBEYt2u9SxdjFwcQgK7
	GSW2P57CDpGQlPh8cR0ThC0ssfLfc3aIomYmiYl/r7CCJNgEtCQav3Yxg9giArYS9x9NZgUp
	YhY4wSRxe/IGsCJhAS+J9x9PgE1lEVCVuHpqFQuIzStgLbH0726oDfISqzccABrEwcEpYCMx
	8bISSFgIqOTulb+sExj5FjAyrGKUTC0ozk3PTTYsMMxLLdcrTswtLs1L10vOz93ECA5wLY0d
	jPfm/9M7xMjEwXiIUYKDWUmEN7SkKk2INyWxsiq1KD++qDQntfgQozQHi5I4r+GM2SlCAumJ
	JanZqakFqUUwWSYOTqkGpnllcY6167/sEcptPx/48FnU/rq/VQmPLIIeHvi04+M1xQehxpOL
	LOdkpTX6xkn67k29+DT676aouBVTs4wueMyc+k77h0eC6B//y9lngg7aqN9vkrlx1UWPZTWT
	r+Icg2XBrx2WtO78vOGY7ak7d9pbGiWnin2/3Hel7V1aueap2LqZnyYlLEq+O+lftdL5mB/B
	3ve1Lnse2jpplunmDgEF3ld3FtvNjGK40K10226CQcWf3fHa07sb6/d67Z7lz3pP+3fX8xoR
	p98PbU+HatnsePiR58K0O+zz7bQrrxw7teD4y2fvlk/NWaIT4b2d8ZL7u7mxdz06NE2fyU89
	tWPK/mI9CYmOg24fqplT571VYinOSDTUYi4qTgQAmQ9KWt8CAAA=
X-CMS-MailID: 20240625094443epcas5p3093ac786a7d0f09de5a3bba17bbd4458
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240625094443epcas5p3093ac786a7d0f09de5a3bba17bbd4458
References: <20240625093813.112555-1-shradha.t@samsung.com>
	<CGME20240625094443epcas5p3093ac786a7d0f09de5a3bba17bbd4458@epcas5p3.samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Add support to use the RASDES feature of DesignWare PCIe controller
using debugfs entries.

RASDES is a vendor specific extended PCIe capability which reads the
current hardware internal state of PCIe device. Following primary
features are provided to userspace via debugfs:
- Debug registers
- Error injection
- Statistical counters

Signed-off-by: Shradha Todi <shradha.t@samsung.com>
---
 drivers/pci/controller/dwc/Kconfig            |   8 +
 drivers/pci/controller/dwc/Makefile           |   1 +
 .../controller/dwc/pcie-designware-debugfs.c  | 474 ++++++++++++++++++
 .../controller/dwc/pcie-designware-debugfs.h  |   0
 drivers/pci/controller/dwc/pcie-designware.h  |  17 +
 5 files changed, 500 insertions(+)
 create mode 100644 drivers/pci/controller/dwc/pcie-designware-debugfs.c
 create mode 100644 drivers/pci/controller/dwc/pcie-designware-debugfs.h

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index 8afacc90c63b..e8e920470412 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -6,6 +6,14 @@ menu "DesignWare-based PCIe controllers"
 config PCIE_DW
 	bool
 
+config PCIE_DW_DEBUGFS
+	bool "DWC PCIe debugfs entries"
+	help
+	  Enables debugfs entries for the DWC PCIe Controller.
+	  These entries make use of the RAS features in the DW
+	  controller to help in debug, error injection and statistical
+	  counters
+
 config PCIE_DW_HOST
 	bool
 	select PCIE_DW
diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
index bac103faa523..77bd4f7a2f75 100644
--- a/drivers/pci/controller/dwc/Makefile
+++ b/drivers/pci/controller/dwc/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_PCIE_DW) += pcie-designware.o
+obj-$(CONFIG_PCIE_DW_DEBUGFS) += pcie-designware-debugfs.o
 obj-$(CONFIG_PCIE_DW_HOST) += pcie-designware-host.o
 obj-$(CONFIG_PCIE_DW_EP) += pcie-designware-ep.o
 obj-$(CONFIG_PCIE_DW_PLAT) += pcie-designware-plat.o
diff --git a/drivers/pci/controller/dwc/pcie-designware-debugfs.c b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
new file mode 100644
index 000000000000..af5e4ad53fcb
--- /dev/null
+++ b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
@@ -0,0 +1,474 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Synopsys DesignWare PCIe controller debugfs driver
+ *
+ * Copyright (C) 2023 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * Author: Shradha Todi <shradha.t@samsung.com>
+ */
+
+#include <linux/debugfs.h>
+
+#include "pcie-designware.h"
+
+#define RAS_DES_EVENT_COUNTER_CTRL_REG	0x8
+#define RAS_DES_EVENT_COUNTER_DATA_REG	0xc
+#define SD_STATUS_L1LANE_REG		0xb0
+#define ERR_INJ_ENABLE_REG		0x30
+#define ERR_INJ0_OFF			0x34
+
+#define LANE_DETECT_SHIFT		17
+#define LANE_DETECT_MASK		0x1
+#define PIPE_RXVALID_SHIFT		18
+#define PIPE_RXVALID_MASK		0x1
+
+#define LANE_SELECT_SHIFT		8
+#define LANE_SELECT_MASK		0xf
+#define EVENT_COUNTER_STATUS_SHIFT	7
+#define EVENT_COUNTER_STATUS_MASK	0x1
+#define EVENT_COUNTER_ENABLE		(0x7 << 2)
+#define PER_EVENT_OFF			(0x1 << 2)
+#define PER_EVENT_ON			(0x3 << 2)
+
+#define EINJ_COUNT_MASK			0xff
+#define EINJ_TYPE_MASK			0xf
+#define EINJ_TYPE_SHIFT			8
+#define EINJ_INFO_MASK			0xfffff
+#define EINJ_INFO_SHIFT			12
+
+#define DWC_DEBUGFS_MAX			128
+
+struct rasdes_info {
+	/* to store rasdes capability offset */
+	u32 ras_cap;
+	struct mutex dbg_mutex;
+	struct dentry *rasdes;
+};
+
+struct rasdes_priv {
+	struct dw_pcie *pci;
+	int idx;
+};
+
+struct event_counter {
+	const char *name;
+	/* values can be between 0-15 */
+	u32 group_no;
+	/* values can be between 0-32 */
+	u32 event_no;
+};
+
+static const struct event_counter event_counters[] = {
+	{"ebuf_overflow", 0x0, 0x0},
+	{"ebuf_underrun", 0x0, 0x1},
+	{"decode_err", 0x0, 0x2},
+	{"running_disparity_err", 0x0, 0x3},
+	{"skp_os_parity_err", 0x0, 0x4},
+	{"sync_header_err", 0x0, 0x5},
+	{"detect_ei_infer", 0x1, 0x5},
+	{"receiver_err", 0x1, 0x6},
+	{"rx_recovery_req", 0x1, 0x7},
+	{"framing_err", 0x1, 0x9},
+	{"deskew_err", 0x1, 0xa},
+	{"bad_tlp", 0x2, 0x0},
+	{"lcrc_err", 0x2, 0x1},
+	{"bad_dllp", 0x2, 0x2},
+};
+
+struct err_inj {
+	const char *name;
+	/* values can be from group 0 - 6 */
+	u32 err_inj_group;
+	/* within each group there can be types */
+	u32 err_inj_type;
+	/* More details about the error */
+	u32 err_inj_12_31;
+};
+
+static const struct err_inj err_inj_list[] = {
+	{"tx_lcrc", 0x0, 0x0, 0x0},
+	{"tx_ecrc", 0x0, 0x3, 0x0},
+	{"rx_lcrc", 0x0, 0x8, 0x0},
+	{"rx_ecrc", 0x0, 0xb, 0x0},
+	{"b16_crc_dllp", 0x0, 0x1, 0x0},
+	{"b16_crc_upd_fc", 0x0, 0x2, 0x0},
+	{"fcrc_tlp", 0x0, 0x4, 0x0},
+	{"parity_tsos", 0x0, 0x5, 0x0},
+	{"parity_skpos", 0x0, 0x6, 0x0},
+	{"ack_nak_dllp", 0x2, 0x0, 0x0},
+	{"upd_fc_dllp", 0x2, 0x1, 0x0},
+	{"nak_dllp", 0x2, 0x2, 0x0},
+	{"inv_sync_hdr_sym", 0x3, 0x0, 0x0},
+	{"com_pad_ts1", 0x3, 0x1, 0x0},
+	{"com_pad_ts2", 0x3, 0x2, 0x0},
+	{"com_fts", 0x3, 0x3, 0x0},
+	{"com_idl", 0x3, 0x4, 0x0},
+	{"end_edb", 0x3, 0x5, 0x0},
+	{"stp_sdp", 0x3, 0x6, 0x0},
+	{"com_skp", 0x3, 0x7, 0x0},
+	{"duplicate_dllp", 0x5, 0x0, 0x0},
+	{"nullified_tlp", 0x5, 0x1, 0x0},
+};
+
+static ssize_t dbg_lane_detect_read(struct file *file, char __user *buf,
+				    size_t count, loff_t *ppos)
+{
+	struct dw_pcie *pci = file->private_data;
+	struct rasdes_info *rinfo = pci->dump_info;
+	u32 val;
+	ssize_t off = 0;
+	char debugfs_buf[DWC_DEBUGFS_MAX];
+
+	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap + SD_STATUS_L1LANE_REG);
+	val = (val >> LANE_DETECT_SHIFT) & LANE_DETECT_MASK;
+	if (val)
+		off += scnprintf(debugfs_buf, DWC_DEBUGFS_MAX - off,
+				 "Detected\n");
+	else
+		off += scnprintf(debugfs_buf, DWC_DEBUGFS_MAX - off,
+				 "Undetected\n");
+
+	return simple_read_from_buffer(buf, count, ppos, debugfs_buf, off);
+}
+
+static ssize_t dbg_lane_detect_write(struct file *file, const char __user *buf,
+				     size_t count, loff_t *ppos)
+{
+	struct dw_pcie *pci = file->private_data;
+	struct rasdes_info *rinfo = pci->dump_info;
+	u32 val;
+	u32 lane;
+
+	val = kstrtou32_from_user(buf, count, 0, &lane);
+	if (val)
+		return val;
+
+	if (lane > 15)
+		return -EINVAL;
+
+	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap + SD_STATUS_L1LANE_REG);
+	val &= ~LANE_SELECT_MASK;
+	val |= lane;
+	dw_pcie_writel_dbi(pci, rinfo->ras_cap + SD_STATUS_L1LANE_REG, val);
+
+	return count;
+}
+
+static ssize_t dbg_rx_valid_read(struct file *file, char __user *buf,
+				 size_t count, loff_t *ppos)
+{
+	struct dw_pcie *pci = file->private_data;
+	struct rasdes_info *rinfo = pci->dump_info;
+	u32 val;
+	ssize_t off = 0;
+	char debugfs_buf[DWC_DEBUGFS_MAX];
+
+	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap + SD_STATUS_L1LANE_REG);
+	val = (val >> PIPE_RXVALID_SHIFT) & PIPE_RXVALID_MASK;
+	if (val)
+		off += scnprintf(debugfs_buf, DWC_DEBUGFS_MAX - off,
+				 "Valid\n");
+	else
+		off += scnprintf(debugfs_buf, DWC_DEBUGFS_MAX - off,
+				 "Invalid\n");
+
+	return simple_read_from_buffer(buf, count, ppos, debugfs_buf, off);
+}
+
+static ssize_t dbg_rx_valid_write(struct file *file, const char __user *buf,
+				  size_t count, loff_t *ppos)
+{
+	return dbg_lane_detect_write(file, buf, count, ppos);
+}
+
+static void set_event_number(struct rasdes_priv *pdata, struct dw_pcie *pci,
+			     struct rasdes_info *rinfo)
+{
+	u32 val;
+
+	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap +
+				RAS_DES_EVENT_COUNTER_CTRL_REG);
+	val &= ~EVENT_COUNTER_ENABLE;
+	val &= ~(0xFFF << 16);
+	val |= (event_counters[pdata->idx].group_no << 24);
+	val |= (event_counters[pdata->idx].event_no << 16);
+	dw_pcie_writel_dbi(pci, rinfo->ras_cap +
+			   RAS_DES_EVENT_COUNTER_CTRL_REG, val);
+}
+
+static ssize_t cnt_en_read(struct file *file, char __user *buf, size_t count,
+			   loff_t *ppos)
+{
+	struct rasdes_priv *pdata = file->private_data;
+	struct dw_pcie *pci = pdata->pci;
+	struct rasdes_info *rinfo = pci->dump_info;
+	u32 val;
+	ssize_t off = 0;
+	char debugfs_buf[DWC_DEBUGFS_MAX];
+
+	mutex_lock(&rinfo->dbg_mutex);
+	set_event_number(pdata, pci, rinfo);
+	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap +
+				RAS_DES_EVENT_COUNTER_CTRL_REG);
+	mutex_unlock(&rinfo->dbg_mutex);
+	val = (val >> EVENT_COUNTER_STATUS_SHIFT) & EVENT_COUNTER_STATUS_MASK;
+	if (val)
+		off += scnprintf(debugfs_buf, DWC_DEBUGFS_MAX - off,
+				 "Enabled\n");
+	else
+		off += scnprintf(debugfs_buf, DWC_DEBUGFS_MAX - off,
+				 "Disabled\n");
+
+	return simple_read_from_buffer(buf, count, ppos, debugfs_buf, off);
+}
+
+static ssize_t cnt_en_write(struct file *file, const char __user *buf,
+			    size_t count, loff_t *ppos)
+{
+	struct rasdes_priv *pdata = file->private_data;
+	struct dw_pcie *pci = pdata->pci;
+	struct rasdes_info *rinfo = pci->dump_info;
+	u32 val;
+	u32 enable;
+
+	val = kstrtou32_from_user(buf, count, 0, &enable);
+	if (val)
+		return val;
+
+	mutex_lock(&rinfo->dbg_mutex);
+	set_event_number(pdata, pci, rinfo);
+	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap +
+				RAS_DES_EVENT_COUNTER_CTRL_REG);
+	if (enable)
+		val |= PER_EVENT_ON;
+	else
+		val |= PER_EVENT_OFF;
+
+	dw_pcie_writel_dbi(pci, rinfo->ras_cap +
+			   RAS_DES_EVENT_COUNTER_CTRL_REG, val);
+	mutex_unlock(&rinfo->dbg_mutex);
+
+	return count;
+}
+
+static ssize_t cnt_lane_read(struct file *file, char __user *buf, size_t count,
+			     loff_t *ppos)
+{
+	struct rasdes_priv *pdata = file->private_data;
+	struct dw_pcie *pci = pdata->pci;
+	struct rasdes_info *rinfo = pci->dump_info;
+	u32 val;
+	ssize_t off = 0;
+	char debugfs_buf[DWC_DEBUGFS_MAX];
+
+	mutex_lock(&rinfo->dbg_mutex);
+	set_event_number(pdata, pci, rinfo);
+	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap +
+				RAS_DES_EVENT_COUNTER_CTRL_REG);
+	mutex_unlock(&rinfo->dbg_mutex);
+	val = (val >> LANE_SELECT_SHIFT) & LANE_SELECT_MASK;
+	off += scnprintf(debugfs_buf, DWC_DEBUGFS_MAX - off,
+				 "Lane: %d\n", val);
+
+	return simple_read_from_buffer(buf, count, ppos, debugfs_buf, off);
+}
+
+static ssize_t cnt_lane_write(struct file *file, const char __user *buf,
+			      size_t count, loff_t *ppos)
+{
+	struct rasdes_priv *pdata = file->private_data;
+	struct dw_pcie *pci = pdata->pci;
+	struct rasdes_info *rinfo = pci->dump_info;
+	u32 val;
+	u32 lane;
+
+	val = kstrtou32_from_user(buf, count, 0, &lane);
+	if (val)
+		return val;
+
+	if (lane > 15)
+		return -EINVAL;
+
+	mutex_lock(&rinfo->dbg_mutex);
+	set_event_number(pdata, pci, rinfo);
+	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap +
+				RAS_DES_EVENT_COUNTER_CTRL_REG);
+	val &= ~(LANE_SELECT_MASK << LANE_SELECT_SHIFT);
+	val |= (lane << LANE_SELECT_SHIFT);
+	dw_pcie_writel_dbi(pci, rinfo->ras_cap +
+			   RAS_DES_EVENT_COUNTER_CTRL_REG, val);
+	mutex_unlock(&rinfo->dbg_mutex);
+
+	return count;
+}
+
+static ssize_t cnt_val_read(struct file *file, char __user *buf, size_t count,
+			    loff_t *ppos)
+{
+	struct rasdes_priv *pdata = file->private_data;
+	struct dw_pcie *pci = pdata->pci;
+	struct rasdes_info *rinfo = pci->dump_info;
+	u32 val;
+	ssize_t off = 0;
+	char debugfs_buf[DWC_DEBUGFS_MAX];
+
+	mutex_lock(&rinfo->dbg_mutex);
+	set_event_number(pdata, pci, rinfo);
+	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap +
+				RAS_DES_EVENT_COUNTER_DATA_REG);
+	mutex_unlock(&rinfo->dbg_mutex);
+	off += scnprintf(debugfs_buf, DWC_DEBUGFS_MAX - off,
+				 "Value: %d\n", val);
+
+	return simple_read_from_buffer(buf, count, ppos, debugfs_buf, off);
+}
+
+static ssize_t err_inj_write(struct file *file, const char __user *buf,
+			     size_t count, loff_t *ppos)
+{
+	struct rasdes_priv *pdata = file->private_data;
+	struct dw_pcie *pci = pdata->pci;
+	struct rasdes_info *rinfo = pci->dump_info;
+	u32 val;
+	u32 counter;
+
+	val = kstrtou32_from_user(buf, count, 0, &counter);
+	if (val)
+		return val;
+
+	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap + ERR_INJ0_OFF +
+			(0x4 * err_inj_list[pdata->idx].err_inj_group));
+	val &= ~(EINJ_TYPE_MASK << EINJ_TYPE_SHIFT);
+	val |= err_inj_list[pdata->idx].err_inj_type << EINJ_TYPE_SHIFT;
+	val &= ~(EINJ_INFO_MASK << EINJ_INFO_SHIFT);
+	val |= err_inj_list[pdata->idx].err_inj_12_31 << EINJ_INFO_SHIFT;
+	val &= ~EINJ_COUNT_MASK;
+	val |= counter;
+	dw_pcie_writel_dbi(pci, rinfo->ras_cap + ERR_INJ0_OFF +
+			(0x4 * err_inj_list[pdata->idx].err_inj_group), val);
+	dw_pcie_writel_dbi(pci, rinfo->ras_cap + ERR_INJ_ENABLE_REG,
+			   (0x1 << err_inj_list[pdata->idx].err_inj_group));
+
+	return count;
+}
+
+#define dwc_debugfs_create(name)			\
+debugfs_create_file(#name, 0644, rasdes_debug, pci,	\
+			&dbg_ ## name ## _fops)
+
+#define DWC_DEBUGFS_FOPS(name)					\
+static const struct file_operations dbg_ ## name ## _fops = {	\
+	.read = dbg_ ## name ## _read,				\
+	.write = dbg_ ## name ## _write				\
+}
+
+DWC_DEBUGFS_FOPS(lane_detect);
+DWC_DEBUGFS_FOPS(rx_valid);
+
+static const struct file_operations cnt_en_ops = {
+	.open = simple_open,
+	.read = cnt_en_read,
+	.write = cnt_en_write,
+};
+
+static const struct file_operations cnt_lane_ops = {
+	.open = simple_open,
+	.read = cnt_lane_read,
+	.write = cnt_lane_write,
+};
+
+static const struct file_operations cnt_val_ops = {
+	.open = simple_open,
+	.read = cnt_val_read,
+};
+
+static const struct file_operations err_inj_ops = {
+	.open = simple_open,
+	.write = err_inj_write,
+};
+
+void dwc_pcie_rasdes_debugfs_deinit(struct dw_pcie *pci)
+{
+	struct rasdes_info *rinfo = pci->dump_info;
+
+	debugfs_remove_recursive(rinfo->rasdes);
+	mutex_destroy(&rinfo->dbg_mutex);
+}
+
+int dwc_pcie_rasdes_debugfs_init(struct dw_pcie *pci)
+{
+	struct device *dev = pci->dev;
+	int ras_cap;
+	struct rasdes_info *dump_info;
+	char dirname[DWC_DEBUGFS_MAX];
+	struct dentry *dir, *rasdes_debug, *rasdes_err_inj;
+	struct dentry *rasdes_event_counter, *rasdes_events;
+	int i;
+	struct rasdes_priv *priv_tmp;
+
+	ras_cap = dw_pcie_find_vsec_capability(pci, DW_PCIE_RAS_DES_CAP);
+	if (!ras_cap) {
+		dev_err(dev, "No RASDES capability available\n");
+		return -ENODEV;
+	}
+
+	dump_info = devm_kzalloc(dev, sizeof(*dump_info), GFP_KERNEL);
+	if (!dump_info)
+		return -ENOMEM;
+
+	/* Create main directory for each platform driver */
+	sprintf(dirname, "pcie_dwc_%s", dev_name(dev));
+	dir = debugfs_create_dir(dirname, NULL);
+
+	/* Create subdirectories for Debug, Error injection, Statistics */
+	rasdes_debug = debugfs_create_dir("rasdes_debug", dir);
+	rasdes_err_inj = debugfs_create_dir("rasdes_err_inj", dir);
+	rasdes_event_counter = debugfs_create_dir("rasdes_event_counter", dir);
+
+	mutex_init(&dump_info->dbg_mutex);
+	dump_info->ras_cap = ras_cap;
+	dump_info->rasdes = dir;
+	pci->dump_info = dump_info;
+
+	/* Create debugfs files for Debug subdirectory */
+	dwc_debugfs_create(lane_detect);
+	dwc_debugfs_create(rx_valid);
+
+	/* Create debugfs files for Error injection subdirectory */
+	for (i = 0; i < ARRAY_SIZE(err_inj_list); i++) {
+		priv_tmp = devm_kzalloc(dev, sizeof(*priv_tmp), GFP_KERNEL);
+		if (!priv_tmp)
+			goto err;
+
+		priv_tmp->idx = i;
+		priv_tmp->pci = pci;
+		debugfs_create_file(err_inj_list[i].name, 0200,
+				    rasdes_err_inj, priv_tmp, &err_inj_ops);
+	}
+
+	/* Create debugfs files for Statistical counter subdirectory */
+	for (i = 0; i < ARRAY_SIZE(event_counters); i++) {
+		priv_tmp = devm_kzalloc(dev, sizeof(*priv_tmp), GFP_KERNEL);
+		if (!priv_tmp)
+			goto err;
+
+		priv_tmp->idx = i;
+		priv_tmp->pci = pci;
+		rasdes_events = debugfs_create_dir(event_counters[i].name,
+						   rasdes_event_counter);
+		if (event_counters[i].group_no == 0) {
+			debugfs_create_file("lane_select", 0644, rasdes_events,
+					    priv_tmp, &cnt_lane_ops);
+		}
+		debugfs_create_file("counter_value", 0444, rasdes_events, priv_tmp,
+				    &cnt_val_ops);
+		debugfs_create_file("counter_enable", 0644, rasdes_events, priv_tmp,
+				    &cnt_en_ops);
+	}
+
+	return 0;
+err:
+	dwc_pcie_rasdes_debugfs_deinit(pci);
+	return -ENOMEM;
+}
diff --git a/drivers/pci/controller/dwc/pcie-designware-debugfs.h b/drivers/pci/controller/dwc/pcie-designware-debugfs.h
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 77686957a30d..9fa9f33e4ddb 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -223,6 +223,8 @@
 
 #define PCIE_RAS_DES_EVENT_COUNTER_DATA		0xc
 
+#define DW_PCIE_RAS_DES_CAP			0x2
+
 /*
  * The default address offset between dbi_base and atu_base. Root controller
  * drivers are not required to initialize atu_base if the offset matches this
@@ -410,6 +412,7 @@ struct dw_pcie {
 	struct reset_control_bulk_data	core_rsts[DW_PCIE_NUM_CORE_RSTS];
 	struct gpio_desc		*pe_rst;
 	bool			suspended;
+	void			*dump_info;
 };
 
 #define to_dw_pcie_from_pp(port) container_of((port), struct dw_pcie, pp)
@@ -745,4 +748,18 @@ dw_pcie_ep_get_func_from_ep(struct dw_pcie_ep *ep, u8 func_no)
 	return NULL;
 }
 #endif
+
+#ifdef CONFIG_PCIE_DW_DEBUGFS
+int dwc_pcie_rasdes_debugfs_init(struct dw_pcie *pci);
+void dwc_pcie_rasdes_debugfs_deinit(struct dw_pcie *pci);
+#else
+static inline int dwc_pcie_rasdes_debugfs_init(struct dw_pcie *pci)
+{
+	return 0;
+}
+static inline void dwc_pcie_rasdes_debugfs_deinit(struct dw_pcie *pci)
+{
+}
+#endif
+
 #endif /* _PCIE_DESIGNWARE_H */
-- 
2.17.1


