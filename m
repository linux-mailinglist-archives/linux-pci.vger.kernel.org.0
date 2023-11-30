Return-Path: <linux-pci+bounces-286-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 426957FF0C1
	for <lists+linux-pci@lfdr.de>; Thu, 30 Nov 2023 14:52:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E58B9281FDA
	for <lists+linux-pci@lfdr.de>; Thu, 30 Nov 2023 13:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603D346553;
	Thu, 30 Nov 2023 13:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="tNywrz5C"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F0AEC4
	for <linux-pci@vger.kernel.org>; Thu, 30 Nov 2023 05:52:13 -0800 (PST)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20231130135211epoutp0429e19f073f38d68ab6b565caf36745fb~cau6HXCUe0047900479epoutp04T
	for <linux-pci@vger.kernel.org>; Thu, 30 Nov 2023 13:52:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20231130135211epoutp0429e19f073f38d68ab6b565caf36745fb~cau6HXCUe0047900479epoutp04T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1701352331;
	bh=el2EMF2pw9poBvudu5k2NHrrxT2CJUFD6UGrLP2gnFw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tNywrz5CEcnYxIVJP8SCIj9doXeSHtgNq4LuaqIITTvQHdxy1pGTCnwQdbTee8mDG
	 RtNpBz6OKyDucB3iNnaxvrPYOsXwN/Dx64Xeh9obf2lsuPZs71PU6zSoLlwJfRcU0V
	 pGADB64roPXDB8sV+au2vRTFaxO3JwqAJ5qgF/Hw=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20231130135211epcas5p4db69fa1ae2996a3ea71f22bdd45a51d8~cau5kHveo3224032240epcas5p4M;
	Thu, 30 Nov 2023 13:52:11 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.174]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4SgyL161Z4z4x9Pr; Thu, 30 Nov
	2023 13:52:09 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	8C.79.19369.98398656; Thu, 30 Nov 2023 22:52:09 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20231130115108epcas5p1b874d14bc1e306a0860c6671b149a35c~cZFN2qmrg0515605156epcas5p1F;
	Thu, 30 Nov 2023 11:51:08 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20231130115108epsmtrp22ec59bcdb948287c6be7b84bc800251c~cZFN1z0ab1512415124epsmtrp20;
	Thu, 30 Nov 2023 11:51:08 +0000 (GMT)
X-AuditID: b6c32a50-c99ff70000004ba9-fd-65689389f44d
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	85.51.07368.C2778656; Thu, 30 Nov 2023 20:51:08 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
	[107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20231130115106epsmtip1e8bf73fc5b021d813fd5fc2c7c3a7050~cZFL1358T1476714767epsmtip1k;
	Thu, 30 Nov 2023 11:51:06 +0000 (GMT)
From: Shradha Todi <shradha.t@samsung.com>
To: manivannan.sadhasivam@linaro.org, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, bhelgaas@google.com, jingoohan1@gmail.com,
	gustavo.pimentel@synopsys.com, josh@joshtriplett.org,
	lukas.bulwahn@gmail.com, hongxing.zhu@nxp.com, pankaj.dubey@samsung.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, Shradha Todi
	<shradha.t@samsung.com>
Subject: [PATCH v2 2/3] PCI: debugfs: Add support for RASDES framework in
 DWC
Date: Thu, 30 Nov 2023 17:20:43 +0530
Message-Id: <20231130115044.53512-3-shradha.t@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231130115044.53512-1-shradha.t@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFJsWRmVeSWpSXmKPExsWy7bCmpm7n5IxUg0n/NCyWNGVY7LrbwW4x
	a9tcRosVX2ayW/xfkG/R0POb1eLyrjlsFmfnHWezaPnTwmLRcrSdxeJuSyerxaKtX4DK9uxg
	t+g9XOvA57Fz1l12jwWbSj1uvbb12LSqk83jzrU9bB5Prkxn8tj4bgeTR9+WVYweW/Z/ZvT4
	vEkugCsq2yYjNTEltUghNS85PyUzL91WyTs43jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DXLTMH
	6HolhbLEnFKgUEBicbGSvp1NUX5pSapCRn5xia1SakFKToFJgV5xYm5xaV66Xl5qiZWhgYGR
	KVBhQnbG+pXnWAtWdTNWnOzvY2tgXFncxcjJISFgInHlSAc7iC0ksIdR4tF9jy5GLiD7E6NE
	/4JuVgjnG6PEvm1XGWE6vk7dB5XYyyjxZkUjC4TTyiQx9XgPC0gVm4CWROPXLmaQhIhAF5PE
	oxUnwZYwCyRLzOu/wwRiCwv4S8xeuZ0ZxGYRUJVo/fGcDcTmFbCSWD1jKzPEOnmJ1RsOgNmc
	AtYSz1ZdYQQZKiEwlUNiY/MpqCIXibYTt6FsYYlXx7ewQ9hSEp/f7WWDsNMlVm6eAVWTI/Ft
	8xImCNte4sCVOUBXcwAdpymxfpc+RFhWYuqpdUwQN/NJ9P5+AlXOK7FjHoytLPHl7x4WCFtS
	Yt6xy6wQtofE2btL2SCh0sco8eP3OrYJjHKzEFYsYGRcxSiVWlCcm56abFpgqJuXWg6PuOT8
	3E2M4ESqFbCDcfWGv3qHGJk4GA8xSnAwK4nwXn+anirEm5JYWZValB9fVJqTWnyI0RQYghOZ
	pUST84GpPK8k3tDE0sDEzMzMxNLYzFBJnPd169wUIYH0xJLU7NTUgtQimD4mDk6pBqaNH8t7
	hSVbbh52WFa2YNly7cbsttKK227Pw7adfZd8oKDj/rk586PVzX9scHbottBL+FC/J778sLlp
	iZGIyS6B3K9f/XZOcLQLkhUz1ue5rvVng6ybj77B1rJJKtK782Js60rPeMg7Zufk92xniHqZ
	IXPMzTnhSMuhM17c890+LQqeP0tUn/tsJv97r28zYkWYTFY9Dn3b7BxkueXAFk4/tt17OpKv
	v1Q7slXxpmGg2k+uz9OU9jWdVw5TLpFs/5GvFjA3cZ+5ePqTww8vnzw+g/nv9s/ac7oicozW
	C2g88dr6/vm2vA694/xHw//saWs+18m36sfzT4aOGnN0tJ43Rqj8tlzxckNZ7ON7LEosxRmJ
	hlrMRcWJAA+ii38tBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrALMWRmVeSWpSXmKPExsWy7bCSnK5OeUaqwaMTmhZLmjIsdt3tYLeY
	tW0uo8WKLzPZLf4vyLdo6PnNanF51xw2i7PzjrNZtPxpYbFoOdrOYnG3pZPVYtHWL0Ble3aw
	W/QernXg89g56y67x4JNpR63Xtt6bFrVyeZx59oeNo8nV6YzeWx8t4PJo2/LKkaPLfs/M3p8
	3iQXwBXFZZOSmpNZllqkb5fAlbF+5TnWglXdjBUn+/vYGhhXFncxcnJICJhIfJ26j7WLkYtD
	SGA3o8SFZR/YIRKSEp8vrmOCsIUlVv57zg5R1MwkceTXLTaQBJuAlkTj1y5mkISIwAwmiZbu
	+ywgCWaBVInbh+eAFQkL+ErMOPkZzGYRUJVo/fEczOYVsJJYPWMrM8QGeYnVGw6A2ZwC1hLP
	Vl1hBLGFgGoW/frBPIGRbwEjwypGydSC4tz03GTDAsO81HK94sTc4tK8dL3k/NxNjOBA19LY
	wXhv/j+9Q4xMHIyHGCU4mJVEeK8/TU8V4k1JrKxKLcqPLyrNSS0+xCjNwaIkzms4Y3aKkEB6
	YklqdmpqQWoRTJaJg1OqgSle+2Pv3NaQ7x8ChaJ+vfpqsOi79ap7H9OTJ3Uvurg8PD5x5b2j
	/S4PXk7tvRaXvqk5YP450ehFh9s7PUX3TI6eLLkuL2xehtxze2aNfXO0f82Le1651Cnuo9Fm
	jnP+YWl/PBXV31RPjmgI8ZI/tfqufetCpi8MNcZ3C63e7592Z33sprxZzmJCqtGXwvhtWJpy
	7vYLesvHHYpZvOSvlMPh+9/DP1uvNPn6unXJQwXmRB4e82s8Czgf75GP+iKtsyLI/nlCb4Zg
	R6H946uvP15N/qXVO8PwZeVj/U9FSh7J2Ue+LAz9xlX7v4zlqeOsNFe/pzHGVQ/6uw1PXGEr
	SmCbaW6SdKeddfeMs9ZnuZVYijMSDbWYi4oTAVTatVbjAgAA
X-CMS-MailID: 20231130115108epcas5p1b874d14bc1e306a0860c6671b149a35c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231130115108epcas5p1b874d14bc1e306a0860c6671b149a35c
References: <20231130115044.53512-1-shradha.t@samsung.com>
	<CGME20231130115108epcas5p1b874d14bc1e306a0860c6671b149a35c@epcas5p1.samsung.com>
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
 .../controller/dwc/pcie-designware-debugfs.c  | 476 ++++++++++++++++++
 .../controller/dwc/pcie-designware-debugfs.h  |   0
 drivers/pci/controller/dwc/pcie-designware.h  |  17 +
 5 files changed, 502 insertions(+)
 create mode 100644 drivers/pci/controller/dwc/pcie-designware-debugfs.c
 create mode 100644 drivers/pci/controller/dwc/pcie-designware-debugfs.h

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index ab96da43e0c2..fc84ba03b20e 100644
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
index bf5c311875a1..cbd1618b0b20 100644
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
index 000000000000..46481650ed6b
--- /dev/null
+++ b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
@@ -0,0 +1,476 @@
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
+static ssize_t err_inj_read(struct file *file, char __user *buf,
+				  size_t count, loff_t *ppos)
+{
+	struct rasdes_priv *pdata = file->private_data;
+	struct dw_pcie *pci = pdata->pci;
+	struct rasdes_info *rinfo = pci->dump_info;
+	u32 val;
+	ssize_t off = 0;
+	char debugfs_buf[DWC_DEBUGFS_MAX];
+
+	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap + ERR_INJ0_OFF +
+			(0x4 * err_inj_list[pdata->idx].err_inj_group));
+	val &= EINJ_COUNT_MASK;
+	off += scnprintf(debugfs_buf, DWC_DEBUGFS_MAX - off,
+				 "Count: %d\n", val);
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
+	.read = err_inj_read,
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
+		debugfs_create_file(err_inj_list[i].name, 0644,
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
+		debugfs_create_file("counter_value", 0644, rasdes_events, priv_tmp,
+				    &cnt_val_ops);
+		debugfs_create_file("counter_enable", 0444, rasdes_events, priv_tmp,
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
index b7ea1db14f6a..d3453db34c1f 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -222,6 +222,8 @@
 
 #define PCIE_RAS_DES_EVENT_COUNTER_DATA		0xc
 
+#define DW_PCIE_RAS_DES_CAP			0x2
+
 /*
  * The default address offset between dbi_base and atu_base. Root controller
  * drivers are not required to initialize atu_base if the offset matches this
@@ -406,6 +408,7 @@ struct dw_pcie {
 	struct reset_control_bulk_data	core_rsts[DW_PCIE_NUM_CORE_RSTS];
 	struct gpio_desc		*pe_rst;
 	bool			suspended;
+	void			*dump_info;
 };
 
 #define to_dw_pcie_from_pp(port) container_of((port), struct dw_pcie, pp)
@@ -643,4 +646,18 @@ dw_pcie_ep_get_func_from_ep(struct dw_pcie_ep *ep, u8 func_no)
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


