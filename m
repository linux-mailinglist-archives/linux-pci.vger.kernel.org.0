Return-Path: <linux-pci+bounces-21445-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 564A5A35BFB
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 11:57:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 661C03AC7BD
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 10:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7BD425E44F;
	Fri, 14 Feb 2025 10:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="UX1p8YHO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E99225A64C
	for <linux-pci@vger.kernel.org>; Fri, 14 Feb 2025 10:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739530642; cv=none; b=ZEM04nHzMeqNev8GH/aZHgwBvbjtU95AB7goDuPpbq2GMBe0NKMxpnicW7aGkqGt1HU0kqZXHJr6Z9t0yblZUN62cSWaErm9Y5yqwgLqZBtkCS8R831Ae7bKu/yg6QqQctJU6gIY4gAEwQHF4kylQOIV9I+xJFx1rrX0N36QMts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739530642; c=relaxed/simple;
	bh=6B0P3OaJHDDXvBbXWuAHZWs+PcUPnm+2emquuPlqq+4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:Content-Type:
	 References; b=m0gm8Lt/prLOpgLJd21jPsM+afSuMeRnYu9saniomWWsTzlJ21Yp64RwWnprjaGqlFND8lHGjn8tTyrVNzkyPJNYK4ERWsCS01ai1uOlQNOl2+38IAq2+5Z7JIQt7BneK1WTBO33Y4BojnTlWynmJuF6Ka8mKGJhC3t1EGyLDAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=UX1p8YHO; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250214105718epoutp02cb4bd848ca8ff05f2b76a0ddbd46f231~kDeYr1r8J2398623986epoutp02X
	for <linux-pci@vger.kernel.org>; Fri, 14 Feb 2025 10:57:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250214105718epoutp02cb4bd848ca8ff05f2b76a0ddbd46f231~kDeYr1r8J2398623986epoutp02X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1739530638;
	bh=TpVozyZir8X8MadiuvwH6FZ55tUbw/dLkczdc7ttUDI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UX1p8YHOkrqLFHMw3JayDFI7T0dSEJsWei/1UclAkSp6k9FqZJH9L1BU8MzKubdUy
	 6/6toOctq1jsyElJZ+KtC+1bkrjVFojGS50f27qPN2FKSzznRoJOjUcAa19Gj2Tawh
	 y5QUZ468eKNrZfgi6ItPT2m0YFxXXPSEZ3VlUI8k=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20250214105717epcas5p23d4e88e16857dc3addfed2d944f91f78~kDeYNChHq0997409974epcas5p2d;
	Fri, 14 Feb 2025 10:57:17 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.177]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4YvTXC6KWVz4x9Pr; Fri, 14 Feb
	2025 10:57:15 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	22.1A.29212.B812FA76; Fri, 14 Feb 2025 19:57:15 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250214105341epcas5p11ea07dba0a55700bc098077eb53e79b8~kDbPJm9s81079310793epcas5p1z;
	Fri, 14 Feb 2025 10:53:41 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250214105341epsmtrp15c74c342ce061a23c046bafce73f9e51~kDbPIsLuq1673516735epsmtrp1p;
	Fri, 14 Feb 2025 10:53:41 +0000 (GMT)
X-AuditID: b6c32a50-7ebff7000000721c-17-67af218b54ac
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	66.47.18729.5B02FA76; Fri, 14 Feb 2025 19:53:41 +0900 (KST)
Received: from cheetah.samsungds.net (unknown [107.109.115.53]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250214105339epsmtip155e056fc10410fcceb63a0d16185fedf~kDbMlRusr1058810588epsmtip1u;
	Fri, 14 Feb 2025 10:53:39 +0000 (GMT)
From: Shradha Todi <shradha.t@samsung.com>
To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc: manivannan.sadhasivam@linaro.org, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, bhelgaas@google.com, jingoohan1@gmail.com,
	Jonathan.Cameron@Huawei.com, fan.ni@samsung.com, nifan.cxl@gmail.com,
	a.manzanares@samsung.com, pankaj.dubey@samsung.com, cassel@kernel.org,
	18255117159@163.com, quic_nitegupt@quicinc.com, quic_krichai@quicinc.com,
	gost.dev@samsung.com, Shradha Todi <shradha.t@samsung.com>
Subject: [PATCH v6 2/4] Add debugfs based silicon debug support in DWC
Date: Fri, 14 Feb 2025 16:20:05 +0530
Message-Id: <20250214105007.97582-3-shradha.t@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250214105007.97582-1-shradha.t@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPJsWRmVeSWpSXmKPExsWy7bCmlm634vp0gyfLDC2utP9mt5h+WNFi
	SVOGxbEJK5gtmlbfZbW4eWAnk8WKLzPZLVYtvMZm0dDzm9Xi8q45bBZn5x1ns2j508Jicbel
	k9Xi77a9jBaLtn5ht3jwoNKic84RZov/e3awW/QernUQ9li8Ygqrx85Zd9k9Fmwq9Wg58pbV
	Y9OqTjaPO9f2sHk8uTKdyWPinjqPvi2rGD0+b5IL4IrKtslITUxJLVJIzUvOT8nMS7dV8g6O
	d443NTMw1DW0tDBXUshLzE21VXLxCdB1y8wB+kpJoSwxpxQoFJBYXKykb2dTlF9akqqQkV9c
	YquUWpCSU2BSoFecmFtcmpeul5daYmVoYGBkClSYkJ1xsHcGa8HF+IrJO2+wNzBuCuhi5OSQ
	EDCRmHZ9B3MXIxeHkMAeRon7LRuhnE+MEsf6L7FBON8YJR5cbGeHaTn3+DQrRGIvo8T09oOM
	EM4XRolFsy+AVbEJaEk0fu1iBrFFBKwlDrdvYQOxmQUWMUvM7U7sYuTgEBZwk2g8xgESZhFQ
	lXg+ZxoriM0rYCWxZ/NuVohl8hKrNxwAG8MJNObt+S9Q8QMcEusbEyFsF4nZy1azQNjCEq+O
	b4E6VEriZX8blJ0usXLzDGYIO0fi2+YlTBC2vcSBK3NYQM5hFtCUWL9LHyIsKzH11DomiIv5
	JHp/P4Eq55XYMQ/GVpb48ncP1FpJiXnHLkOd5iHx7dBDaPj0MUrsWfeWfQKj3CyEFQsYGVcx
	SqUWFOempyabFhjq5qWWw2MtOT93EyM45WoF7GBcveGv3iFGJg7GQ4wSHMxKIrwS09akC/Gm
	JFZWpRblxxeV5qQWH2I0BQbgRGYp0eR8YNLPK4k3NLE0MDEzMzOxNDYzVBLnbd7Zki4kkJ5Y
	kpqdmlqQWgTTx8TBKdXAVLbYcdeEJZoTD2nNL/atkFxQqT1nldYvs6XtQZIT/LvYG39MOuxu
	OFWSVe7YGdmSsEtdcyrdb3V8UvbvN2F1bqxJ8JJheny0Yd8fUc2uGXkqK6aJX/PKWSB12dSG
	edWefY07Ek5n8txxFzvmwak5bZuH4LVHbq9LVpn2h+8s33//W7IOD5v3uhe8ooaKjdWe7AJm
	OV5V+Z/3TN9cofNktUd86ly9uEDnWMdjRsczbWoVrttxLi4Kfvn4TNnthJ87mk+dK9/jcj5r
	Ra3Mgn1605j4xSwyr8t3zIt8u4T7Kn/MoQP/P1jJTG/qO+g7VeTHPpfsC4zPKlov39V9w1TC
	11F04Z6y25rDk9YJdxYosRRnJBpqMRcVJwIAYj9cvEIEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGLMWRmVeSWpSXmKPExsWy7bCSnO5WhfXpBht36Fpcaf/NbjH9sKLF
	kqYMi2MTVjBbNK2+y2px88BOJosVX2ayW6xaeI3NoqHnN6vF5V1z2CzOzjvOZtHyp4XF4m5L
	J6vF3217GS0Wbf3CbvHgQaVF55wjzBb/9+xgt+g9XOsg7LF4xRRWj52z7rJ7LNhU6tFy5C2r
	x6ZVnWwed67tYfN4cmU6k8fEPXUefVtWMXp83iQXwBXFZZOSmpNZllqkb5fAlXGwdwZrwcX4
	isk7b7A3MG4K6GLk5JAQMJE49/g0axcjF4eQwG5GiZbzLYwQCUmJzxfXMUHYwhIr/z1nhyj6
	xCgxbfEFFpAEm4CWROPXLmYQW0TAVuL+o8lgk5gFdjBL/J23FaiDg0NYwE2i8RgHSA2LgKrE
	8znTWEFsXgEriT2bd7NCLJCXWL3hANgcTgFribfnv4DFhYBqfqy5wTiBkW8BI8MqRsnUguLc
	9NxiwwLDvNRyveLE3OLSvHS95PzcTYzgqNDS3MG4fdUHvUOMTByMhxglOJiVRHglpq1JF+JN
	SaysSi3Kjy8qzUktPsQozcGiJM4r/qI3RUggPbEkNTs1tSC1CCbLxMEp1cCk8cMzc13P6qqX
	s4XYamZEyP9d+4nt//pbzBuVF0fv7bWcLZg4p7u3SmfK6dmrZM7u8TGTDv0deWzjjaLIH8dq
	d5oHX1txQ1X39X6R/rSUbvmfm+8Zym9QrZzAe8nr3LGEePdCr8VGib8Wf2c8zhJYE3WdPezk
	7FNsvVZPj/J/PP7P4VbRhMAg6/+av69a5HrO3tDcYlsc9vWEQfPWiOnlmYYVjDJhIteDjZ/d
	Xla35Moqnrn2lUHNpzZ8O1W4KbhY+RP/c32LI83FEzcwtjf52CztyDrB43t/gkHssjnRItcU
	rC6KfXi3uuGealw0t/gz/s5ZhyWbpC7H7zXvzGVdpvJag6fuhd/cKz3BIjpKLMUZiYZazEXF
	iQDJlnuO+QIAAA==
X-CMS-MailID: 20250214105341epcas5p11ea07dba0a55700bc098077eb53e79b8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250214105341epcas5p11ea07dba0a55700bc098077eb53e79b8
References: <20250214105007.97582-1-shradha.t@samsung.com>
	<CGME20250214105341epcas5p11ea07dba0a55700bc098077eb53e79b8@epcas5p1.samsung.com>
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
 .../controller/dwc/pcie-designware-debugfs.c  | 207 ++++++++++++++++++
 .../pci/controller/dwc/pcie-designware-ep.c   |   5 +
 .../pci/controller/dwc/pcie-designware-host.c |   6 +
 drivers/pci/controller/dwc/pcie-designware.h  |  20 ++
 7 files changed, 262 insertions(+)
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
index 000000000000..fe799d36fa7f
--- /dev/null
+++ b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
@@ -0,0 +1,207 @@
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
+struct dwc_pcie_vsec_id {
+	u16 vendor_id;
+	u16 vsec_id;
+	u8 vsec_rev;
+};
+
+/*
+ * VSEC IDs are allocated by the vendor, so a given ID may mean different
+ * things to different vendors. See PCIe r6.0, sec 7.9.5.2.
+ */
+static const struct dwc_pcie_vsec_id dwc_pcie_vsec_ids[] = {
+	{ .vendor_id = PCI_VENDOR_ID_ALIBABA,
+		.vsec_id = 0x02, .vsec_rev = 0x4 },
+	{ .vendor_id = PCI_VENDOR_ID_AMPERE,
+		.vsec_id = 0x02, .vsec_rev = 0x4 },
+	{ .vendor_id = PCI_VENDOR_ID_QCOM,
+		.vsec_id = 0x02, .vsec_rev = 0x4 },
+	{ .vendor_id = PCI_VENDOR_ID_SAMSUNG,
+		.vsec_id = 0x02, .vsec_rev = 0x4 },
+	{} /* terminator */
+};
+
+/**
+ * struct dwc_pcie_rasdes_info - Stores controller common information
+ * @ras_cap_offset: RAS DES vendor specific extended capability offset
+ * @reg_lock: Mutex used for RASDES shadow event registers
+ *
+ * Any parameter constant to all files of the debugfs hierarchy for a single controller
+ * will be stored in this struct. It is allocated and assigned to controller specific
+ * struct dw_pcie during initialization.
+ */
+struct dwc_pcie_rasdes_info {
+	u32 ras_cap_offset;
+	struct mutex reg_lock;
+};
+
+static ssize_t lane_detect_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
+{
+	struct dw_pcie *pci = file->private_data;
+	struct dwc_pcie_rasdes_info *rinfo = pci->debugfs->rasdes_info;
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
+static void dwc_pcie_rasdes_debugfs_deinit(struct dw_pcie *pci)
+{
+	struct dwc_pcie_rasdes_info *rinfo = pci->debugfs->rasdes_info;
+
+	mutex_destroy(&rinfo->reg_lock);
+}
+
+static int dwc_pcie_rasdes_debugfs_init(struct dw_pcie *pci, struct dentry *dir)
+{
+	struct dentry *rasdes_debug;
+	struct dwc_pcie_rasdes_info *rasdes_info;
+	const struct dwc_pcie_vsec_id *vid;
+	struct device *dev = pci->dev;
+	int ras_cap;
+
+	for (vid = dwc_pcie_vsec_ids; vid->vendor_id; vid++) {
+		ras_cap = dw_pcie_find_vsec_capability(pci, vid->vendor_id,
+							vid->vsec_id);
+		if (ras_cap)
+			break;
+	}
+	if (!ras_cap) {
+		dev_dbg(dev, "no rasdes capability available\n");
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
+	mutex_init(&rasdes_info->reg_lock);
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
+	if (IS_ERR(dir))
+		return PTR_ERR(dir);
+
+	debugfs = devm_kzalloc(dev, sizeof(*debugfs), GFP_KERNEL);
+	if (!debugfs)
+		return -ENOMEM;
+
+	debugfs->debug_dir = dir;
+	pci->debugfs = debugfs;
+	ret = dwc_pcie_rasdes_debugfs_init(pci, dir);
+	if (ret)
+		dev_dbg(dev, "rasdes debugfs init failed\n");
+
+	return 0;
+}
diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index f3ac7d46a855..a87a714bb472 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -642,6 +642,7 @@ void dw_pcie_ep_cleanup(struct dw_pcie_ep *ep)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 
+	dwc_pcie_debugfs_deinit(pci);
 	dw_pcie_edma_remove(pci);
 }
 EXPORT_SYMBOL_GPL(dw_pcie_ep_cleanup);
@@ -813,6 +814,10 @@ int dw_pcie_ep_init_registers(struct dw_pcie_ep *ep)
 
 	dw_pcie_ep_init_non_sticky_registers(pci);
 
+	ret = dwc_pcie_debugfs_init(pci);
+	if (ret)
+		goto err_remove_edma;
+
 	return 0;
 
 err_remove_edma:
diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index d2291c3ceb8b..6b03ef7fd014 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -524,6 +524,10 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 	if (ret)
 		goto err_remove_edma;
 
+	ret = dwc_pcie_debugfs_init(pci);
+	if (ret)
+		goto err_remove_edma;
+
 	if (!dw_pcie_link_up(pci)) {
 		ret = dw_pcie_start_link(pci);
 		if (ret)
@@ -571,6 +575,8 @@ void dw_pcie_host_deinit(struct dw_pcie_rp *pp)
 
 	dw_pcie_stop_link(pci);
 
+	dwc_pcie_debugfs_deinit(pci);
+
 	dw_pcie_edma_remove(pci);
 
 	if (pp->has_msi_ctrl)
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 02e94bd9b042..8543b4f38d24 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -435,6 +435,11 @@ struct dw_pcie_ops {
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
@@ -463,6 +468,7 @@ struct dw_pcie {
 	struct reset_control_bulk_data	core_rsts[DW_PCIE_NUM_CORE_RSTS];
 	struct gpio_desc		*pe_rst;
 	bool			suspended;
+	struct debugfs_info	*debugfs;
 };
 
 #define to_dw_pcie_from_pp(port) container_of((port), struct dw_pcie, pp)
@@ -796,4 +802,18 @@ dw_pcie_ep_get_func_from_ep(struct dw_pcie_ep *ep, u8 func_no)
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
-- 
2.17.1


