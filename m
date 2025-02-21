Return-Path: <linux-pci+bounces-22089-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B6CA407C2
	for <lists+linux-pci@lfdr.de>; Sat, 22 Feb 2025 12:00:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B239706DDD
	for <lists+linux-pci@lfdr.de>; Sat, 22 Feb 2025 10:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E412209F4E;
	Sat, 22 Feb 2025 10:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="YdhfHQ4o"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DFF20ADDC
	for <linux-pci@vger.kernel.org>; Sat, 22 Feb 2025 10:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740221947; cv=none; b=ey65/CamKMKqn6qsZLXt/a4CkaVu2B0Ryx4U//7TkvqQbvJ34cX1tz1tfm7zlah/KAUU+4lh7JzuB0EYjpCSg5cY5zzjjZlABSgSMhcoAoedA2JhisLzrmdhrJ7tDdPoiInPMT1B73un1XQ/LpSovtnbTRSRouCsAbVDnIq5yqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740221947; c=relaxed/simple;
	bh=UErRy9Sw4+TXAHSMmOVde1Pi1qst9FmVWm11bO2eWmc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:Content-Type:
	 References; b=EKoFyj2WSL8oAPTlqFZI96tVwkoXLaar8xxkPXLh925K/dZ6wQNVhFUJWATrwIY0v728BNcjkmWXZDdRAhYgPnEBJpPHQgO6buRsMfKgGUONxSEUK5LfqKjEeg6TSTn4HsPvS3Qa7FanBS2ImQAkhFNo4y/PJGpiWMnel0U/AEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=YdhfHQ4o; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250222105903epoutp041e6163b99f9e9e04b2ff2a62d0b554ba~mgqMqTdTx2163121631epoutp04T
	for <linux-pci@vger.kernel.org>; Sat, 22 Feb 2025 10:59:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250222105903epoutp041e6163b99f9e9e04b2ff2a62d0b554ba~mgqMqTdTx2163121631epoutp04T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1740221943;
	bh=iSdQRQyM2uFwkHH+hdSLfO37l0/r8LVgCgbkFMLODJw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YdhfHQ4oVL+jYrjIPIyAU9P0bEc7bvXjTH2i4vk/9BQWvGdbTGunQnx9IzTiXqAAA
	 H1Pg/1qcimwOONIbsEgkguYaeE4/XNnlmI4T4q+lH2TIkyDt9nT+bpyeUGdbcDoOMO
	 rCh/C6ms+gMMZXgun5UwC+uFTfJfyvqeDtmL5l+k=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20250222105902epcas5p12535730417f5320269778e70eb9adc18~mgqMB0gGV1724917249epcas5p1B;
	Sat, 22 Feb 2025 10:59:02 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.180]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4Z0PBX6PN2z4x9Pv; Sat, 22 Feb
	2025 10:59:00 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	CA.12.19710.4FDA9B76; Sat, 22 Feb 2025 19:59:00 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250221132035epcas5p47221a5198df9bf86020abcefdfded789~mO8fWGfF42570425704epcas5p4k;
	Fri, 21 Feb 2025 13:20:35 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250221132035epsmtrp1068507ee0e753fde911714b6ad54e3ad~mO8fVGF833121131211epsmtrp1k;
	Fri, 21 Feb 2025 13:20:35 +0000 (GMT)
X-AuditID: b6c32a44-36bdd70000004cfe-24-67b9adf41b9f
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	80.3F.18949.3AD78B76; Fri, 21 Feb 2025 22:20:35 +0900 (KST)
Received: from cheetah.samsungds.net (unknown [107.109.115.53]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250221132032epsmtip2990f5d7d3223c90064ce128a52b2e813~mO8caHK4o0684606846epsmtip28;
	Fri, 21 Feb 2025 13:20:32 +0000 (GMT)
From: Shradha Todi <shradha.t@samsung.com>
To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org
Cc: manivannan.sadhasivam@linaro.org, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, bhelgaas@google.com, jingoohan1@gmail.com,
	Jonathan.Cameron@Huawei.com, fan.ni@samsung.com, nifan.cxl@gmail.com,
	a.manzanares@samsung.com, pankaj.dubey@samsung.com, cassel@kernel.org,
	18255117159@163.com, xueshuai@linux.alibaba.com, renyu.zj@linux.alibaba.com,
	will@kernel.org, mark.rutland@arm.com, Shradha Todi <shradha.t@samsung.com>
Subject: [PATCH v7 3/5] Add debugfs based silicon debug support in DWC
Date: Fri, 21 Feb 2025 18:45:46 +0530
Message-Id: <20250221131548.59616-4-shradha.t@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250221131548.59616-1-shradha.t@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WTe0xbVRzHPfe2twWH3vGYBwyzu4wsAyntKN1hPMYiIZfMhDISNRjDarlp
	CaVt+pgwIVSozjFhY2524ICCIF2Zg5RHyitrgAx14KYg2xRkQ0ICPpG6ZLIy+5r+9/md7/d7
	fjm/cw4XD50iorjFKj2jVUmVFBHMGpzYvy/B9cWQXHDblYDmTm1xkHliD+qoVqAb56w4qu5e
	ZCOrq5GDbG3zBDJ+tMVG9p/n2Wh2+DKBZlqmCDQ3cI2FTI9NLLRoOs1GnXe+xZB7cAyg9gEX
	B7XVrAH0ZNTBQXUTlci0kIz+eNRHZO6iP7NeYNNXW64CeqhpkUNb7AbaNPkbm7bbThP0wvwo
	QQ89SKFX5swY3ddRRdf32wC9ad8t2VFQkqZgpEWMlseoZOqiYpU8nTqaX/hKYbJYIEwQpqCD
	FE8lLWXSqaxXJQnZxUrPaSneCanS4FmSSHU6KjEjTas26BmeQq3Tp1OMpkipEWn4OmmpzqCS
	81WM/pBQIDiQ7DEeL1F0zHdxND8wZZa2T1hGcOq1WsDlQlIEP3ZX1IJgbig5AmBvTxPLX/wF
	4IzzHvAXDwG09Ex7lCBfwnjpdkAYA/BKqxXzCqGkC8Dm33leJsg4+N7ftbiXw8n3AZxc3eUN
	4OQgDp1Wq08II7Ph+BmnL8wiY+Fj5wLbyyHkIdi+vYr7u70Eu3udPg4iU6HtGzPm3QiSK1zo
	nlkn/KYs2FC3HAiEwfWpfo6fo+Da2Q8CLIdX+i4FPEr4sK8D8/Nh6Jy7zPIOAyf3w57hRP9y
	NLz49TWfBSefg3VbKwF7CHS0POUY6HKPBqYSCVtuzLL9TMOGrU7MP6F6AOvcJtY5sLvp/xYW
	AGwgktHoSuWMLFkjVDHv/HdrMnWpHfhedFyWA9xt3eaPA4wLxgHk4lR4SILeIQ8NKZKWn2S0
	6kKtQcnoxkGyZ4ANeFSETO35Eip9oVCUIhCJxWJRSpJYSL0QUjNkkoeScqmeKWEYDaN9msO4
	QVFGLH9r6XD+0t3ce+U/yZbib2JUSWRnZWZnqitv/MTL2/EXlsNizAX63AdHCcNmY8Snbblv
	0/vCovZMVnSvLSdZinvl0xn1Bwfi1wduTYtWH/FNrVXumtfXjj+hJ2PA2pm8mtKKiBziZGy0
	7cjYG5UlVdvsD+38t1KDBL1xWFnawK2Cncdks5V5/Irq+Xcnn9178cfMvS9mGL5UpJrB2Y07
	O5e5z69ayooaGmOGv7s+PRVOj5h/uZmoUm7EWsxWXub9z7scvc+E7Tig/id1QbK6UH3/q+Gu
	P8eOOMrzNJv917M3m40zb07lSDKSNmZl328zzTmSDbFxNLh95Pyv8vPHKqI1gxRLp5AK43Ct
	TvovVCc0t1oEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgkeLIzCtJLcpLzFFi42LZdlhJXndx7Y50g4tNwhZX2n+zW0w/rGix
	pCnD4tiEFcwWTavvslqs+DKT3WLVwmtsFg09v1ktNj2+xmpxedccNouz846zWVzZuo7FouVP
	C4vF3ZZOVoul1y8yWfzdtpfRYtHWL+wWC5tfMlr837OD3aL3cK1Fyx1Ti/c/N7M5iHksXjGF
	1WPNvDWMHjtn3WX3WLCp1KPlyFtWj02rOtk87lzbw+ax86Glx5Mr05k8Ni+p9+jbsorR4/Mm
	uQCeKC6blNSczLLUIn27BK6MJdeWsxfcSq1YsHAaSwNje1gXIyeHhICJRMOMC4xdjFwcQgK7
	GSWedrxhg0hISny+uI4JwhaWWPnvOTtE0SdGiSud/1lAEmwCWhKNX7uYQRIiAp2MEnuPvAOr
	YhY4xywx83MLI0iVsICbxKHuA2CjWARUJf4cuMMKYvMKWEks+veMGWKFvMTqDQfAbE4Ba4lV
	56aD1QsB1ezZcp91AiPfAkaGVYySqQXFuem5xYYFRnmp5XrFibnFpXnpesn5uZsYwZGkpbWD
	cc+qD3qHGJk4GA8xSnAwK4nw6pbsSBfiTUmsrEotyo8vKs1JLT7EKM3BoiTO++11b4qQQHpi
	SWp2ampBahFMlomDU6qBad5KjXXOaVU/7r37ki8jcIzp+818w6tLNjw0scwOP3jtebHo380l
	rw2Ef2dZed4s2KmVLyJz2v771JAl1QKi7fNKrDZvSDy6W+CpoN9a84btfx88L7gZZ3z1hmn3
	tM3f/89r/X9472yLL2pdPAvztppO4I5y+Vd0TNVjVqPJZkW+3ScfP3uS9bpC/bWopPmWhJPf
	2jd5Vvav+CV07GuIwAPOczf6smYsmZiVtyGtSjNoW63g4z2SF5K4J/GrrLCc9sRht0b+zDiG
	bzNuVt1X2WZ5xWzLXUvNyqrjJe0X5ThWuP6/dGPrXpNrqneL2CvNPz+T5xCUKC7+8P73C7VC
	9XNyAg9uvwl/Nl10paWbaakSS3FGoqEWc1FxIgAB/lHIEwMAAA==
X-CMS-MailID: 20250221132035epcas5p47221a5198df9bf86020abcefdfded789
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250221132035epcas5p47221a5198df9bf86020abcefdfded789
References: <20250221131548.59616-1-shradha.t@samsung.com>
	<CGME20250221132035epcas5p47221a5198df9bf86020abcefdfded789@epcas5p4.samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Add support to provide silicon debug interface to userspace. This set
of debug registers are part of the RASDES feature present in DesignWare
PCIe controllers.

Signed-off-by: Shradha Todi <shradha.t@samsung.com>
---
 Documentation/ABI/testing/debugfs-dwc-pcie    |  13 ++
 drivers/pci/controller/dwc/Kconfig            |  10 +
 drivers/pci/controller/dwc/Makefile           |   1 +
 .../controller/dwc/pcie-designware-debugfs.c  | 176 ++++++++++++++++++
 .../pci/controller/dwc/pcie-designware-ep.c   |   5 +
 .../pci/controller/dwc/pcie-designware-host.c |   6 +
 drivers/pci/controller/dwc/pcie-designware.c  |   6 +
 drivers/pci/controller/dwc/pcie-designware.h  |  21 +++
 include/linux/pcie-dwc.h                      |   2 +
 9 files changed, 240 insertions(+)
 create mode 100644 Documentation/ABI/testing/debugfs-dwc-pcie
 create mode 100644 drivers/pci/controller/dwc/pcie-designware-debugfs.c

diff --git a/Documentation/ABI/testing/debugfs-dwc-pcie b/Documentation/ABI/testing/debugfs-dwc-pcie
new file mode 100644
index 000000000000..e8ed34e988ef
--- /dev/null
+++ b/Documentation/ABI/testing/debugfs-dwc-pcie
@@ -0,0 +1,13 @@
+What:		/sys/kernel/debug/dwc_pcie_<dev>/rasdes_debug/lane_detect
+Date:		Feburary 2025
+Contact:	Shradha Todi <shradha.t@samsung.com>
+Description:	(RW) Write the lane number to be checked for detection.	Read
+		will return whether PHY indicates receiver detection on the
+		selected lane. The default selected lane is Lane0.
+
+What:		/sys/kernel/debug/dwc_pcie_<dev>/rasdes_debug/rx_valid
+Date:		Feburary 2025
+Contact:	Shradha Todi <shradha.t@samsung.com>
+Description:	(RW) Write the lane number to be checked as valid or invalid. Read
+		will return the status of PIPE RXVALID signal of the selected lane.
+		The default selected lane is Lane0.
diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index b6d6778b0698..48a10428a492 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -6,6 +6,16 @@ menu "DesignWare-based PCIe controllers"
 config PCIE_DW
 	bool
 
+config PCIE_DW_DEBUGFS
+	default y
+	depends on DEBUG_FS
+	depends on PCIE_DW_HOST || PCIE_DW_EP
+	bool "DWC PCIe debugfs entries"
+	help
+	  Enables debugfs entries for the DW PCIe Controller. These entries
+	  provide all debug features related to DW controller including the RAS
+	  DES features to help in debug, error injection and statistical counters.
+
 config PCIE_DW_HOST
 	bool
 	select PCIE_DW
diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
index a8308d9ea986..54565eedc52c 100644
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
index 000000000000..3887a6996706
--- /dev/null
+++ b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
@@ -0,0 +1,176 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Synopsys DesignWare PCIe controller debugfs driver
+ *
+ * Copyright (C) 2025 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * Author: Shradha Todi <shradha.t@samsung.com>
+ */
+
+#include <linux/debugfs.h>
+
+#include "pcie-designware.h"
+
+#define SD_STATUS_L1LANE_REG		0xb0
+#define PIPE_RXVALID			BIT(18)
+#define PIPE_DETECT_LANE		BIT(17)
+#define LANE_SELECT			GENMASK(3, 0)
+
+#define DWC_DEBUGFS_BUF_MAX		128
+
+/**
+ * struct dwc_pcie_rasdes_info - Stores controller common information
+ * @ras_cap_offset: RAS DES vendor specific extended capability offset
+ * @reg_event_lock: Mutex used for RASDES shadow event registers
+ *
+ * Any parameter constant to all files of the debugfs hierarchy for a single controller
+ * will be stored in this struct. It is allocated and assigned to controller specific
+ * struct dw_pcie during initialization.
+ */
+struct dwc_pcie_rasdes_info {
+	u32 ras_cap_offset;
+	struct mutex reg_event_lock;
+};
+
+static ssize_t lane_detect_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
+{
+	struct dw_pcie *pci = file->private_data;
+	struct dwc_pcie_rasdes_info *rinfo = pci->debugfs->rasdes_info;
+	char debugfs_buf[DWC_DEBUGFS_BUF_MAX];
+	ssize_t pos;
+	u32 val;
+
+	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset + SD_STATUS_L1LANE_REG);
+	val = FIELD_GET(PIPE_DETECT_LANE, val);
+	if (val)
+		pos = scnprintf(debugfs_buf, DWC_DEBUGFS_BUF_MAX, "Lane Detected\n");
+	else
+		pos = scnprintf(debugfs_buf, DWC_DEBUGFS_BUF_MAX, "Lane Undetected\n");
+
+	return simple_read_from_buffer(buf, count, ppos, debugfs_buf, pos);
+}
+
+static ssize_t lane_detect_write(struct file *file, const char __user *buf,
+				 size_t count, loff_t *ppos)
+{
+	struct dw_pcie *pci = file->private_data;
+	struct dwc_pcie_rasdes_info *rinfo = pci->debugfs->rasdes_info;
+	u32 lane, val;
+
+	val = kstrtou32_from_user(buf, count, 0, &lane);
+	if (val)
+		return val;
+
+	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset + SD_STATUS_L1LANE_REG);
+	val &= ~(LANE_SELECT);
+	val |= FIELD_PREP(LANE_SELECT, lane);
+	dw_pcie_writel_dbi(pci, rinfo->ras_cap_offset + SD_STATUS_L1LANE_REG, val);
+
+	return count;
+}
+
+static ssize_t rx_valid_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
+{
+	struct dw_pcie *pci = file->private_data;
+	struct dwc_pcie_rasdes_info *rinfo = pci->debugfs->rasdes_info;
+	char debugfs_buf[DWC_DEBUGFS_BUF_MAX];
+	ssize_t pos;
+	u32 val;
+
+	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset + SD_STATUS_L1LANE_REG);
+	val = FIELD_GET(PIPE_RXVALID, val);
+	if (val)
+		pos = scnprintf(debugfs_buf, DWC_DEBUGFS_BUF_MAX, "RX Valid\n");
+	else
+		pos = scnprintf(debugfs_buf, DWC_DEBUGFS_BUF_MAX, "RX Invalid\n");
+
+	return simple_read_from_buffer(buf, count, ppos, debugfs_buf, pos);
+}
+
+static ssize_t rx_valid_write(struct file *file, const char __user *buf, size_t count, loff_t *ppos)
+{
+	return lane_detect_write(file, buf, count, ppos);
+}
+
+#define dwc_debugfs_create(name)			\
+debugfs_create_file(#name, 0644, rasdes_debug, pci,	\
+			&dbg_ ## name ## _fops)
+
+#define DWC_DEBUGFS_FOPS(name)					\
+static const struct file_operations dbg_ ## name ## _fops = {	\
+	.open = simple_open,				\
+	.read = name ## _read,				\
+	.write = name ## _write				\
+}
+
+DWC_DEBUGFS_FOPS(lane_detect);
+DWC_DEBUGFS_FOPS(rx_valid);
+
+static void dwc_pcie_rasdes_debugfs_deinit(struct dw_pcie *pci)
+{
+	struct dwc_pcie_rasdes_info *rinfo = pci->debugfs->rasdes_info;
+
+	mutex_destroy(&rinfo->reg_event_lock);
+}
+
+static int dwc_pcie_rasdes_debugfs_init(struct dw_pcie *pci, struct dentry *dir)
+{
+	struct dentry *rasdes_debug;
+	struct dwc_pcie_rasdes_info *rasdes_info;
+	struct device *dev = pci->dev;
+	int ras_cap;
+
+	ras_cap = dw_pcie_find_rasdes_capability(pci);
+	if (!ras_cap) {
+		dev_dbg(dev, "no RASDES capability available\n");
+		return -ENODEV;
+	}
+
+	rasdes_info = devm_kzalloc(dev, sizeof(*rasdes_info), GFP_KERNEL);
+	if (!rasdes_info)
+		return -ENOMEM;
+
+	/* Create subdirectories for Debug, Error injection, Statistics */
+	rasdes_debug = debugfs_create_dir("rasdes_debug", dir);
+
+	mutex_init(&rasdes_info->reg_event_lock);
+	rasdes_info->ras_cap_offset = ras_cap;
+	pci->debugfs->rasdes_info = rasdes_info;
+
+	/* Create debugfs files for Debug subdirectory */
+	dwc_debugfs_create(lane_detect);
+	dwc_debugfs_create(rx_valid);
+
+	return 0;
+}
+
+void dwc_pcie_debugfs_deinit(struct dw_pcie *pci)
+{
+	dwc_pcie_rasdes_debugfs_deinit(pci);
+	debugfs_remove_recursive(pci->debugfs->debug_dir);
+}
+
+int dwc_pcie_debugfs_init(struct dw_pcie *pci)
+{
+	char dirname[DWC_DEBUGFS_BUF_MAX];
+	struct device *dev = pci->dev;
+	struct debugfs_info *debugfs;
+	struct dentry *dir;
+	int ret;
+
+	/* Create main directory for each platform driver */
+	snprintf(dirname, DWC_DEBUGFS_BUF_MAX, "dwc_pcie_%s", dev_name(dev));
+	dir = debugfs_create_dir(dirname, NULL);
+	debugfs = devm_kzalloc(dev, sizeof(*debugfs), GFP_KERNEL);
+	if (!debugfs)
+		return -ENOMEM;
+
+	debugfs->debug_dir = dir;
+	pci->debugfs = debugfs;
+	ret = dwc_pcie_rasdes_debugfs_init(pci, dir);
+	if (ret)
+		dev_dbg(dev, "RASDES debugfs init failed\n");
+
+	return 0;
+}
diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 72418160e658..f9d7f3f989ad 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -814,6 +814,7 @@ void dw_pcie_ep_cleanup(struct dw_pcie_ep *ep)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 
+	dwc_pcie_debugfs_deinit(pci);
 	dw_pcie_edma_remove(pci);
 }
 EXPORT_SYMBOL_GPL(dw_pcie_ep_cleanup);
@@ -989,6 +990,10 @@ int dw_pcie_ep_init_registers(struct dw_pcie_ep *ep)
 
 	dw_pcie_ep_init_non_sticky_registers(pci);
 
+	ret = dwc_pcie_debugfs_init(pci);
+	if (ret)
+		goto err_remove_edma;
+
 	return 0;
 
 err_remove_edma:
diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index ffaded8f2df7..2081e8c72d12 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -548,6 +548,10 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 	if (pp->ops->post_init)
 		pp->ops->post_init(pp);
 
+	ret = dwc_pcie_debugfs_init(pci);
+	if (ret)
+		goto err_stop_link;
+
 	return 0;
 
 err_stop_link:
@@ -572,6 +576,8 @@ void dw_pcie_host_deinit(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 
+	dwc_pcie_debugfs_deinit(pci);
+
 	pci_stop_root_bus(pp->bridge->bus);
 	pci_remove_root_bus(pp->bridge->bus);
 
diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index a7c0671c6715..3d1d95d9e380 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -323,6 +323,12 @@ static u16 dw_pcie_find_vsec_capability(struct dw_pcie *pci,
 	return 0;
 }
 
+u16 dw_pcie_find_rasdes_capability(struct dw_pcie *pci)
+{
+	return dw_pcie_find_vsec_capability(pci, dwc_pcie_rasdes_vsec_ids);
+}
+EXPORT_SYMBOL_GPL(dw_pcie_find_rasdes_capability);
+
 int dw_pcie_read(void __iomem *addr, int size, u32 *val)
 {
 	if (!IS_ALIGNED((uintptr_t)addr, size)) {
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 501d9ddfea16..7f9807d4e5de 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -437,6 +437,11 @@ struct dw_pcie_ops {
 	void	(*stop_link)(struct dw_pcie *pcie);
 };
 
+struct debugfs_info {
+	struct dentry		*debug_dir;
+	void			*rasdes_info;
+};
+
 struct dw_pcie {
 	struct device		*dev;
 	void __iomem		*dbi_base;
@@ -465,6 +470,7 @@ struct dw_pcie {
 	struct reset_control_bulk_data	core_rsts[DW_PCIE_NUM_CORE_RSTS];
 	struct gpio_desc		*pe_rst;
 	bool			suspended;
+	struct debugfs_info	*debugfs;
 };
 
 #define to_dw_pcie_from_pp(port) container_of((port), struct dw_pcie, pp)
@@ -478,6 +484,7 @@ void dw_pcie_version_detect(struct dw_pcie *pci);
 
 u8 dw_pcie_find_capability(struct dw_pcie *pci, u8 cap);
 u16 dw_pcie_find_ext_capability(struct dw_pcie *pci, u8 cap);
+u16 dw_pcie_find_rasdes_capability(struct dw_pcie *pci);
 
 int dw_pcie_read(void __iomem *addr, int size, u32 *val);
 int dw_pcie_write(void __iomem *addr, int size, u32 val);
@@ -806,4 +813,18 @@ dw_pcie_ep_get_func_from_ep(struct dw_pcie_ep *ep, u8 func_no)
 	return NULL;
 }
 #endif
+
+#ifdef CONFIG_PCIE_DW_DEBUGFS
+int dwc_pcie_debugfs_init(struct dw_pcie *pci);
+void dwc_pcie_debugfs_deinit(struct dw_pcie *pci);
+#else
+static inline int dwc_pcie_debugfs_init(struct dw_pcie *pci)
+{
+	return 0;
+}
+static inline void dwc_pcie_debugfs_deinit(struct dw_pcie *pci)
+{
+}
+#endif
+
 #endif /* _PCIE_DESIGNWARE_H */
diff --git a/include/linux/pcie-dwc.h b/include/linux/pcie-dwc.h
index 40f3545731c8..6436e7fadc75 100644
--- a/include/linux/pcie-dwc.h
+++ b/include/linux/pcie-dwc.h
@@ -28,6 +28,8 @@ static const struct dwc_pcie_vsec_id dwc_pcie_rasdes_vsec_ids[] = {
 	  .vsec_id = 0x02, .vsec_rev = 0x4 },
 	{ .vendor_id = PCI_VENDOR_ID_QCOM,
 	  .vsec_id = 0x02, .vsec_rev = 0x4 },
+	{ .vendor_id = PCI_VENDOR_ID_SAMSUNG,
+	  .vsec_id = 0x02, .vsec_rev = 0x4 },
 	{} /* terminator */
 };
 
-- 
2.17.1


