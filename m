Return-Path: <linux-pci+bounces-20185-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A190FA17DA1
	for <lists+linux-pci@lfdr.de>; Tue, 21 Jan 2025 13:15:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9997B3A3124
	for <lists+linux-pci@lfdr.de>; Tue, 21 Jan 2025 12:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 578091F2378;
	Tue, 21 Jan 2025 12:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="JjSFTiBw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8015C1F2365
	for <linux-pci@vger.kernel.org>; Tue, 21 Jan 2025 12:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737461691; cv=none; b=nsht/hebLYxIaXRF29ew/8uUJU2PGxwAfP2punWU6by2ayhv7NsU9BEoiKlUccMjcG9n7AlqIioPxJSsZKCHn14YBFytnmNWfVJpF+LwfyswuiKa55Ecbh6i/Ubk/UY3y7gAMiZziMt9whshm4KqeDt0ydJYkLSbL7eEaxFHc80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737461691; c=relaxed/simple;
	bh=bWW45EpU4eofPQ7rVUlr43FcN8WWbF671ps8Q9RunVc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:Content-Type:
	 References; b=ssg7rOjHbbx5HhXSPAfKDxixbeZBealqAio2uablgsb+FruZLMV3KZ4iWzxBrETPaXPxPdSHFUvfpvzOSoZsh9uf16ky92XG/ifoPCZRN1Faiwr7jejjw5YSTKcEL3HSFPXcSEBMNFS+2JjJdGYw/CDQ9u5QW6JArcfDL+NGo/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=JjSFTiBw; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250121121445epoutp01af0fed974f02586bfe2a571a0bf6e2e5~ctDKTel140885408854epoutp01N
	for <linux-pci@vger.kernel.org>; Tue, 21 Jan 2025 12:14:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250121121445epoutp01af0fed974f02586bfe2a571a0bf6e2e5~ctDKTel140885408854epoutp01N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1737461685;
	bh=izn50hHVilbiavuM9SxsRoBx1zbvwXMzVWNpemgwipw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JjSFTiBwwEeq9S2MSjzg0cm/7b7gccUSV1AQ/npDW8SS4tOJ+RUtEWNlzOnZSTGG2
	 SrMnokYZypcvk9TBEcGW6cUHFRDT1KtDbDEY3clOeniT+RGhlbkR1NIZubFm2MVM8C
	 eheGB+yLt+q4tRxS+yRbwT/nXU1BZ+1kRQ3tCWbo=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20250121121444epcas5p1acd55f9306b562879a2da73b216e46eb~ctDJwfUYM0889308893epcas5p1h;
	Tue, 21 Jan 2025 12:14:44 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.180]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4YcmNg1cDgz4x9Pq; Tue, 21 Jan
	2025 12:14:43 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	B3.1E.19710.3BF8F876; Tue, 21 Jan 2025 21:14:43 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250121115206epcas5p42ce605e6c8500fd2cdfea83a82b101a5~csvYTuPQc0408004080epcas5p4E;
	Tue, 21 Jan 2025 11:52:06 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250121115206epsmtrp213bbe9516751739df0a531153f8a453d~csvYR9CnF1523215232epsmtrp2d;
	Tue, 21 Jan 2025 11:52:06 +0000 (GMT)
X-AuditID: b6c32a44-36bdd70000004cfe-a6-678f8fb3c634
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	A9.BB.18949.56A8F876; Tue, 21 Jan 2025 20:52:06 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
	[107.109.115.6]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250121115203epsmtip1c91f42914922686799b4797c5330bb73~csvWC2urJ1602616026epsmtip1_;
	Tue, 21 Jan 2025 11:52:03 +0000 (GMT)
From: Shradha Todi <shradha.t@samsung.com>
To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc: manivannan.sadhasivam@linaro.org, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, bhelgaas@google.com, jingoohan1@gmail.com,
	Jonathan.Cameron@Huawei.com, fan.ni@samsung.com, a.manzanares@samsung.com,
	pankaj.dubey@samsung.com, quic_nitegupt@quicinc.com,
	quic_krichai@quicinc.com, gost.dev@samsung.com, Shradha Todi
	<shradha.t@samsung.com>
Subject: [PATCH v5 2/4] Add debugfs based silicon debug support in DWC
Date: Tue, 21 Jan 2025 16:44:19 +0530
Message-Id: <20250121111421.35437-3-shradha.t@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250121111421.35437-1-shradha.t@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNJsWRmVeSWpSXmKPExsWy7bCmpu7m/v50g3vXWC2mH1a0WNKUYdG0
	+i6rxc0DO5ksVnyZyW6xauE1NouGnt+sFpd3zWGzODvvOJtFy58WFou7LZ2sFou2fmG3ePCg
	0qJzzhFmi/97drBb9B6udRDw2DnrLrvHgk2lHi1H3rJ6bFrVyeZx59oeNo8nV6YzeUzcU+fR
	t2UVo8fnTXIBnFHZNhmpiSmpRQqpecn5KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJuam2Si4+
	AbpumTlAHygplCXmlAKFAhKLi5X07WyK8ktLUhUy8otLbJVSC1JyCkwK9IoTc4tL89L18lJL
	rAwNDIxMgQoTsjMmbZvFXrAzrGJn/2fmBsZ+zy5GTg4JAROJxZ0/WbsYuTiEBHYzShxueMwC
	4XxilDjwrhHK+cYo8WTzE1aYloNPZzOC2EICexklpu9VhyhqZpLo+fmJGSTBJqAl0fi1C8wW
	EbCWONy+hQ2kiFngKZNE6/GfQA4Hh7CAm8TZVcIgNSwCqhJLD2wEW8ArYCVx8vt7Fohl8hKr
	NxwAm8MJNOfNkTtgt0oIzOWQ6DyzhgmiyEViwxUYW1ji1fEt7BC2lMTnd3vZIOx0iZWbZzBD
	2DkS3zYvgaq3lzhwZQ4LyD3MApoS63fpQ4RlJaaeWgdWwizAJ9H7+wlUOa/EjnkwtrLEl797
	oO6UlJh37DI0gDwkDk+czggJlD5GiZOzj7BPYJSbhbBiASPjKkbJ1ILi3PTUZNMCw7zUcnis
	JefnbmIEp1Itlx2MN+b/0zvEyMTBeIhRgoNZSYRX9ENPuhBvSmJlVWpRfnxRaU5q8SFGU2AA
	TmSWEk3OBybzvJJ4QxNLAxMzMzMTS2MzQyVx3uadLelCAumJJanZqakFqUUwfUwcnFINTJuD
	ZYuMz2SkqjuluD2QunFKL7bYyZgtsu39o22CDI8usX6NYcq6dJdt9u4ZXdmvJY9XXmG8uavq
	0j6/lQJKOyazfy2zf3MwcZ12bdRUxXNdrJX36q+K3cwSW9bnKnxQquL41b/JX/ZvdDpUcOqV
	6+z0NWdF1T8kT0kqfh+wMiHJ4/yFvleOrG4fj65PCn/fl7pPgUM9v+D5Cj7WxSt2vWcwUWeT
	0LC5r6m5o3mr20HHUg9HnxKPq0rJC6y6T6i2VK0Vl5FaX/nwS2tQyuYmScED32RMmqNl7X5s
	ODqn0vST1WvO4x8Lr9cpdn44/ea+3tyXMQtq9/TIWiu9rUqdcf1XlLsvO7f4eo+He4RnKLEU
	ZyQaajEXFScCALP1L4guBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrELMWRmVeSWpSXmKPExsWy7bCSnG5aV3+6wdIzTBbTDytaLGnKsGha
	fZfV4uaBnUwWK77MZLdYtfAam0VDz29Wi8u75rBZnJ13nM2i5U8Li8Xdlk5Wi0Vbv7BbPHhQ
	adE55wizxf89O9gteg/XOgh47Jx1l91jwaZSj5Yjb1k9Nq3qZPO4c20Pm8eTK9OZPCbuqfPo
	27KK0ePzJrkAzigum5TUnMyy1CJ9uwSujEnbZrEX7Ayr2Nn/mbmBsd+zi5GTQ0LAROLg09mM
	XYxcHEICuxklGv7uZINISEp8vriOCcIWllj57zk7RFEjk8SBrotgCTYBLYnGr13MILaIgK3E
	/UeTWUGKmAW+Mkl8/HQDKMHBISzgJnF2lTBIDYuAqsTSAxtZQWxeASuJk9/fs0AskJdYveEA
	2BxOAWuJN0fugNUIAdXM3n6KdQIj3wJGhlWMkqkFxbnpucWGBUZ5qeV6xYm5xaV56XrJ+bmb
	GMHBrqW1g3HPqg96hxiZOBgPMUpwMCuJ8Ip+6EkX4k1JrKxKLcqPLyrNSS0+xCjNwaIkzvvt
	dW+KkEB6YklqdmpqQWoRTJaJg1Oqgant2UXWRZqHj3E1XBbw8vivmJGrMdGLi/9hobyvxuEr
	F055WtRkhfbZGTQsDf9d9PJPVBS3ac+xU/nXNWeWzzm/qM9RP71OMfkBa1T54cpShqemHUG/
	90vEyEj/0MmdLTXtWKCESc9V7RlpuV/9Plet+fYrMqJT+NH2rR8vWbu1OxxeN7HxKEN1rrrY
	ywNH5eOfX8s966y9xuOgg3u76/daacNsJ76d/V/t5mzQ1xeb+tNH5fadjwfyMh/+qMuazqm8
	ctvE4ozU1PfHH2469Gz2H0m1BrMKQf/Jb+bfOHs7TTS6aq107h2m+99efAkwk/ka4Zb65KiQ
	c3PqrOksR/54OnhkLf70WlYsb8IdOyWW4oxEQy3mouJEAOofCo7lAgAA
X-CMS-MailID: 20250121115206epcas5p42ce605e6c8500fd2cdfea83a82b101a5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250121115206epcas5p42ce605e6c8500fd2cdfea83a82b101a5
References: <20250121111421.35437-1-shradha.t@samsung.com>
	<CGME20250121115206epcas5p42ce605e6c8500fd2cdfea83a82b101a5@epcas5p4.samsung.com>
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
 .../controller/dwc/pcie-designware-debugfs.c  | 173 ++++++++++++++++++
 .../pci/controller/dwc/pcie-designware-ep.c   |   5 +
 .../pci/controller/dwc/pcie-designware-host.c |   6 +
 drivers/pci/controller/dwc/pcie-designware.h  |  15 ++
 7 files changed, 223 insertions(+)
 create mode 100644 Documentation/ABI/testing/debugfs-dwc-pcie
 create mode 100644 drivers/pci/controller/dwc/pcie-designware-debugfs.c

diff --git a/Documentation/ABI/testing/debugfs-dwc-pcie b/Documentation/ABI/testing/debugfs-dwc-pcie
new file mode 100644
index 000000000000..e7920ac82e38
--- /dev/null
+++ b/Documentation/ABI/testing/debugfs-dwc-pcie
@@ -0,0 +1,13 @@
+What:		/sys/kernel/debug/dwc_pcie_<dev>/rasdes_debug/lane_detect
+Date:		January 2025
+Contact:	Shradha Todi <shradha.t@samsung.com>
+Description:	(RW) Write the lane number to be checked for detection.	Read
+		will return whether PHY indicates receiver detection on the
+		selected lane. The default selected lane is Lane0.
+
+What:		/sys/kernel/debug/dwc_pcie_<dev>/rasdes_debug/rx_valid
+Date:		January 2025
+Contact:	Shradha Todi <shradha.t@samsung.com>
+Description:	(RW) Write the lane number to be checked as valid or invalid. Read
+		will return the status of PIPE RXVALID signal of the selected lane.
+		The default selected lane is Lane0.
diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index b6d6778b0698..99ddc1e18f72 100644
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
+	  make use of the RAS features in the DW controller to help in debug,
+	  error injection and statistical counters.
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
index 000000000000..907864c35ef3
--- /dev/null
+++ b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
@@ -0,0 +1,173 @@
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
+struct dwc_pcie_vendor_id {
+	u16 vendor_id;
+	u16 vsec_rasdes_cap_id;
+};
+
+static const struct dwc_pcie_vendor_id dwc_pcie_vendor_ids[] = {
+	{PCI_VENDOR_ID_SAMSUNG,	0x2},
+	{} /* terminator */
+};
+
+/**
+ * struct dwc_pcie_rasdes_info - Stores controller common information
+ * @ras_cap_offset: RAS DES vendor specific extended capability offset
+ * @reg_lock: Mutex used for RASDES shadow event registers
+ * @rasdes_dir: Top level debugfs directory entry
+ *
+ * Any parameter constant to all files of the debugfs hierarchy for a single controller
+ * will be stored in this struct. It is allocated and assigned to controller specific
+ * struct dw_pcie during initialization.
+ */
+struct dwc_pcie_rasdes_info {
+	u32 ras_cap_offset;
+	struct mutex reg_lock;
+	struct dentry *rasdes_dir;
+};
+
+static ssize_t lane_detect_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
+{
+	struct dw_pcie *pci = file->private_data;
+	struct dwc_pcie_rasdes_info *rinfo = pci->rasdes_info;
+	char debugfs_buf[DWC_DEBUGFS_BUF_MAX];
+	ssize_t off = 0;
+	u32 val;
+
+	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset + SD_STATUS_L1LANE_REG);
+	val = FIELD_GET(PIPE_DETECT_LANE, val);
+	if (val)
+		off += scnprintf(debugfs_buf, DWC_DEBUGFS_BUF_MAX - off, "Lane Detected\n");
+	else
+		off += scnprintf(debugfs_buf, DWC_DEBUGFS_BUF_MAX - off, "Lane Undetected\n");
+
+	return simple_read_from_buffer(buf, count, ppos, debugfs_buf, off);
+}
+
+static ssize_t lane_detect_write(struct file *file, const char __user *buf,
+				 size_t count, loff_t *ppos)
+{
+	struct dw_pcie *pci = file->private_data;
+	struct dwc_pcie_rasdes_info *rinfo = pci->rasdes_info;
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
+	struct dwc_pcie_rasdes_info *rinfo = pci->rasdes_info;
+	char debugfs_buf[DWC_DEBUGFS_BUF_MAX];
+	ssize_t off = 0;
+	u32 val;
+
+	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset + SD_STATUS_L1LANE_REG);
+	val = FIELD_GET(PIPE_RXVALID, val);
+	if (val)
+		off += scnprintf(debugfs_buf, DWC_DEBUGFS_BUF_MAX - off, "RX Valid\n");
+	else
+		off += scnprintf(debugfs_buf, DWC_DEBUGFS_BUF_MAX - off, "RX Invalid\n");
+
+	return simple_read_from_buffer(buf, count, ppos, debugfs_buf, off);
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
+void dwc_pcie_rasdes_debugfs_deinit(struct dw_pcie *pci)
+{
+	struct dwc_pcie_rasdes_info *rinfo = pci->rasdes_info;
+
+	debugfs_remove_recursive(rinfo->rasdes_dir);
+	mutex_destroy(&rinfo->reg_lock);
+}
+
+int dwc_pcie_rasdes_debugfs_init(struct dw_pcie *pci)
+{
+	struct dentry *dir, *rasdes_debug;
+	struct dwc_pcie_rasdes_info *rasdes_info;
+	const struct dwc_pcie_vendor_id *vid;
+	char dirname[DWC_DEBUGFS_BUF_MAX];
+	struct device *dev = pci->dev;
+	int ras_cap;
+
+	for (vid = dwc_pcie_vendor_ids; vid->vendor_id; vid++) {
+		ras_cap = dw_pcie_find_vsec_capability(pci, vid->vendor_id,
+							vid->vsec_rasdes_cap_id);
+		if (ras_cap)
+			break;
+	}
+	if (!ras_cap) {
+		dev_dbg(dev, "No RASDES capability available\n");
+		return -ENODEV;
+	}
+
+	rasdes_info = devm_kzalloc(dev, sizeof(*rasdes_info), GFP_KERNEL);
+	if (!rasdes_info)
+		return -ENOMEM;
+
+	/* Create main directory for each platform driver */
+	snprintf(dirname, DWC_DEBUGFS_BUF_MAX, "dwc_pcie_%s", dev_name(dev));
+	dir = debugfs_create_dir(dirname, NULL);
+	if (IS_ERR(dir))
+		return PTR_ERR(dir);
+
+	/* Create subdirectories for Debug, Error injection, Statistics */
+	rasdes_debug = debugfs_create_dir("rasdes_debug", dir);
+
+	mutex_init(&rasdes_info->reg_lock);
+	rasdes_info->ras_cap_offset = ras_cap;
+	rasdes_info->rasdes_dir = dir;
+	pci->rasdes_info = rasdes_info;
+
+	/* Create debugfs files for Debug subdirectory */
+	dwc_debugfs_create(lane_detect);
+	dwc_debugfs_create(rx_valid);
+
+	return 0;
+}
diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index f3ac7d46a855..84b5f27a2c69 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -642,6 +642,7 @@ void dw_pcie_ep_cleanup(struct dw_pcie_ep *ep)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 
+	dwc_pcie_rasdes_debugfs_deinit(pci);
 	dw_pcie_edma_remove(pci);
 }
 EXPORT_SYMBOL_GPL(dw_pcie_ep_cleanup);
@@ -813,6 +814,10 @@ int dw_pcie_ep_init_registers(struct dw_pcie_ep *ep)
 
 	dw_pcie_ep_init_non_sticky_registers(pci);
 
+	ret = dwc_pcie_rasdes_debugfs_init(pci);
+	if (ret)
+		goto err_remove_edma;
+
 	return 0;
 
 err_remove_edma:
diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index d2291c3ceb8b..1cd282f70830 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -524,6 +524,10 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 	if (ret)
 		goto err_remove_edma;
 
+	ret = dwc_pcie_rasdes_debugfs_init(pci);
+	if (ret)
+		goto err_remove_edma;
+
 	if (!dw_pcie_link_up(pci)) {
 		ret = dw_pcie_start_link(pci);
 		if (ret)
@@ -571,6 +575,8 @@ void dw_pcie_host_deinit(struct dw_pcie_rp *pp)
 
 	dw_pcie_stop_link(pci);
 
+	dwc_pcie_rasdes_debugfs_deinit(pci);
+
 	dw_pcie_edma_remove(pci);
 
 	if (pp->has_msi_ctrl)
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 02e94bd9b042..8d5dc22f06f7 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -463,6 +463,7 @@ struct dw_pcie {
 	struct reset_control_bulk_data	core_rsts[DW_PCIE_NUM_CORE_RSTS];
 	struct gpio_desc		*pe_rst;
 	bool			suspended;
+	void			*rasdes_info;
 };
 
 #define to_dw_pcie_from_pp(port) container_of((port), struct dw_pcie, pp)
@@ -796,4 +797,18 @@ dw_pcie_ep_get_func_from_ep(struct dw_pcie_ep *ep, u8 func_no)
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


