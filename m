Return-Path: <linux-pci+bounces-20804-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B75C7A2AC3E
	for <lists+linux-pci@lfdr.de>; Thu,  6 Feb 2025 16:14:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4497C16A976
	for <lists+linux-pci@lfdr.de>; Thu,  6 Feb 2025 15:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4F21EA7F1;
	Thu,  6 Feb 2025 15:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="pFzIhik+"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC011A5BBD;
	Thu,  6 Feb 2025 15:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738854891; cv=none; b=Jf7+n85YCdw3U7HJIxTsQLP4GNTp4aY0BM8oNShIJi3+Qqr2CAb99n6MxwWlc49TdgZHNtvIGbQr9N5hHv3G8qYThhgQfLJWTFyJKZHq3ojzSetv7qYOVi4rlVE8wBK+TLh0JtkPppsAXHAkpjsKGFLc6WaT4Ism9BpX2+8jkDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738854891; c=relaxed/simple;
	bh=THHeSWzWqdi+rHd9N14KmDq3qXNDaIZicWrt1Um9iNk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Q+EXpAgcRD5aWNt44nqIbm6l66yzREX+8UyICW4+jee81Hf/HJS6jkN7AOPchC6G7sM9PvmxuQzwq2/Zxw5y8Ob6F60qoKVOjH9QDxin4uoXY+lCpkVeQ2uvGqyTFzFDQUnwDHU5OHKrzo9Td5535mxBA1cNM0c7WExa50e/wVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=pFzIhik+; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=24UwM
	qhVnv7oQWifOAu1e14eK5QqgdytWOv2YcNIUeE=; b=pFzIhik+DfQbeHTRAgj4i
	eQQ+xj54Uq/BlSbQKoqMfeIEaIzi+YryNoTGqZH/Ln2j39v+gZG0sOW69tf3Pv+b
	LHSQ4ZivMZYQsUZJiape7mo6/EbeQ306j7ZQMNQ4sIHOHZsdo+qgNL+Tvfe+eyly
	tev5hT3JAxeLZW9fznTApE=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wDXRyeq0aRnSD6NKQ--.56583S2;
	Thu, 06 Feb 2025 23:13:47 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: jingoohan1@gmail.com,
	shradha.t@samsung.com
Cc: manivannan.sadhasivam@linaro.org,
	lpieralisi@kernel.org,
	kw@linux.com,
	robh@kernel.org,
	bhelgaas@google.com,
	Frank.Li@nxp.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rockswang7@gmail.com,
	Hans Zhang <18255117159@163.com>
Subject: [v2] PCI: dwc: Add the debugfs property to provide the LTSSM status of the PCIe link
Date: Thu,  6 Feb 2025 23:13:43 +0800
Message-Id: <20250206151343.26779-1-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXRyeq0aRnSD6NKQ--.56583S2
X-Coremail-Antispam: 1Uf129KBjvAXoWfGr47Kw1UKFy7Xry8Ar43KFg_yoW8Jw45uo
	Z3GF1fW3WxAa4jva47ZF17GFy8Zw1I9a47tF4vyF4rur9xC3WUt3yUXrn5Ja1Ykr48Aw4U
	Zr4DX3W7Gr4UWrnrn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjTRajg3UUUUU
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWwHro2ekx5WKvgAAs3

Add the debugfs property to provide a view of the current link's LTSSM
status from the root port device.

  /sys/kernel/debug/dwc_pcie_<dev>/ltssm_status

Signed-off-by: Hans Zhang <18255117159@163.com>
---
Changes since v1:
https://lore.kernel.org/linux-pci/20250123071326.1810751-1-18255117159@163.com/

- Do not place into sysfs node as recommended by maintainer. Shradha-based patch
  is put into debugfs.
- Submissions based on the following patches:
https://patchwork.kernel.org/project/linux-pci/patch/20250121111421.35437-2-shradha.t@samsung.com/
https://patchwork.kernel.org/project/linux-pci/patch/20250121111421.35437-3-shradha.t@samsung.com/
https://patchwork.kernel.org/project/linux-pci/patch/20250121111421.35437-4-shradha.t@samsung.com/
https://patchwork.kernel.org/project/linux-pci/patch/20250121111421.35437-5-shradha.t@samsung.com/
---
 Documentation/ABI/testing/debugfs-dwc-pcie    |  6 ++
 .../controller/dwc/pcie-designware-debugfs.c  | 70 ++++++++++++++++---
 .../pci/controller/dwc/pcie-designware-ep.c   |  4 +-
 .../pci/controller/dwc/pcie-designware-host.c | 54 +++++++++++++-
 drivers/pci/controller/dwc/pcie-designware.h  | 43 ++++++++++--
 5 files changed, 159 insertions(+), 18 deletions(-)

diff --git a/Documentation/ABI/testing/debugfs-dwc-pcie b/Documentation/ABI/testing/debugfs-dwc-pcie
index d3f84f46b400..bf0116012175 100644
--- a/Documentation/ABI/testing/debugfs-dwc-pcie
+++ b/Documentation/ABI/testing/debugfs-dwc-pcie
@@ -142,3 +142,9 @@ Description:	(RW) Some lanes in the event list are lane specific events. These i
 		events 1) - 11) and 34) - 35).
 		Write lane number for which counter needs to be enabled/disabled/dumped.
 		Read will return the current selected lane number. Lane0 is selected by default.
+
+What:		/sys/kernel/debug/dwc_pcie_<dev>/ltssm_status
+Date:		February 2025
+Contact:	Hans Zhang <18255117159@163.com>
+Description:	(RO) Read will return the current value of the PCIe link status raw value and
+		string status.
diff --git a/drivers/pci/controller/dwc/pcie-designware-debugfs.c b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
index 5d883b13be84..ddfb854aa684 100644
--- a/drivers/pci/controller/dwc/pcie-designware-debugfs.c
+++ b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
@@ -465,7 +465,7 @@ static const struct file_operations dwc_pcie_counter_value_ops = {
 	.read = counter_value_read,
 };
 
-void dwc_pcie_rasdes_debugfs_deinit(struct dw_pcie *pci)
+static void dwc_pcie_rasdes_debugfs_deinit(struct dw_pcie *pci)
 {
 	struct dwc_pcie_rasdes_info *rinfo = pci->rasdes_info;
 
@@ -473,13 +473,12 @@ void dwc_pcie_rasdes_debugfs_deinit(struct dw_pcie *pci)
 	mutex_destroy(&rinfo->reg_lock);
 }
 
-int dwc_pcie_rasdes_debugfs_init(struct dw_pcie *pci)
+static int dwc_pcie_rasdes_debugfs_init(struct dw_pcie *pci, struct dentry *dir)
 {
-	struct dentry *dir, *rasdes_debug, *rasdes_err_inj, *rasdes_event_counter, *rasdes_events;
+	struct dentry *rasdes_debug, *rasdes_err_inj, *rasdes_event_counter, *rasdes_events;
 	struct dwc_pcie_rasdes_info *rasdes_info;
 	struct dwc_pcie_rasdes_priv *priv_tmp;
 	const struct dwc_pcie_vendor_id *vid;
-	char dirname[DWC_DEBUGFS_BUF_MAX];
 	struct device *dev = pci->dev;
 	int ras_cap, i, ret;
 
@@ -498,12 +497,6 @@ int dwc_pcie_rasdes_debugfs_init(struct dw_pcie *pci)
 	if (!rasdes_info)
 		return -ENOMEM;
 
-	/* Create main directory for each platform driver */
-	snprintf(dirname, DWC_DEBUGFS_BUF_MAX, "dwc_pcie_%s", dev_name(dev));
-	dir = debugfs_create_dir(dirname, NULL);
-	if (IS_ERR(dir))
-		return PTR_ERR(dir);
-
 	/* Create subdirectories for Debug, Error injection, Statistics */
 	rasdes_debug = debugfs_create_dir("rasdes_debug", dir);
 	rasdes_err_inj = debugfs_create_dir("rasdes_err_inj", dir);
@@ -559,3 +552,60 @@ int dwc_pcie_rasdes_debugfs_init(struct dw_pcie *pci)
 	dwc_pcie_rasdes_debugfs_deinit(pci);
 	return ret;
 }
+
+static int dwc_pcie_ltssm_status_show(struct seq_file *s, void *v)
+{
+	struct dw_pcie *pci = s->private;
+	enum dw_pcie_ltssm val;
+
+	val = dw_pcie_get_ltssm(pci);
+	seq_printf(s, "%s (0x%02x)\n", dw_ltssm_sts_string(val), val);
+
+	return 0;
+}
+
+static int dwc_pcie_ltssm_status_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, dwc_pcie_ltssm_status_show, inode->i_private);
+}
+
+static const struct file_operations dwc_pcie_ltssm_status_ops = {
+	.open = dwc_pcie_ltssm_status_open,
+	.read = seq_read,
+};
+
+static void dwc_pcie_ltssm_debugfs_init(struct dw_pcie *pci, struct dentry *dir)
+{
+	debugfs_create_file("ltssm_status", 0444, dir, pci,
+			    &dwc_pcie_ltssm_status_ops);
+}
+
+void dwc_pcie_debugfs_deinit(struct dw_pcie *pci)
+{
+	dwc_pcie_rasdes_debugfs_deinit(pci);
+	debugfs_remove_recursive(pci->debugfs);
+}
+
+int dwc_pcie_debugfs_init(struct dw_pcie *pci)
+{
+	char dirname[DWC_DEBUGFS_BUF_MAX];
+	struct device *dev = pci->dev;
+	struct dentry *dir;
+	int ret;
+
+	/* Create main directory for each platform driver */
+	snprintf(dirname, DWC_DEBUGFS_BUF_MAX, "dwc_pcie_%s", dev_name(dev));
+	dir = debugfs_create_dir(dirname, NULL);
+	if (IS_ERR(dir))
+		return PTR_ERR(dir);
+
+	pci->debugfs = dir;
+	ret = dwc_pcie_rasdes_debugfs_init(pci, dir);
+	if (ret)
+		dev_dbg(dev, "rasdes debugfs init failed\n");
+
+	dwc_pcie_ltssm_debugfs_init(pci, dir);
+
+	return 0;
+}
+
diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 84b5f27a2c69..a87a714bb472 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -642,7 +642,7 @@ void dw_pcie_ep_cleanup(struct dw_pcie_ep *ep)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 
-	dwc_pcie_rasdes_debugfs_deinit(pci);
+	dwc_pcie_debugfs_deinit(pci);
 	dw_pcie_edma_remove(pci);
 }
 EXPORT_SYMBOL_GPL(dw_pcie_ep_cleanup);
@@ -814,7 +814,7 @@ int dw_pcie_ep_init_registers(struct dw_pcie_ep *ep)
 
 	dw_pcie_ep_init_non_sticky_registers(pci);
 
-	ret = dwc_pcie_rasdes_debugfs_init(pci);
+	ret = dwc_pcie_debugfs_init(pci);
 	if (ret)
 		goto err_remove_edma;
 
diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 1cd282f70830..a271dcd260c5 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -418,6 +418,56 @@ static void dw_pcie_host_request_msg_tlp_res(struct dw_pcie_rp *pp)
 	}
 }
 
+char *dw_ltssm_sts_string(enum dw_pcie_ltssm ltssm)
+{
+	char *str;
+
+	switch (ltssm) {
+#define DW_PCIE_LTSSM_NAME(n) case n: str = #n; break
+	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_DETECT_QUIET);
+	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_DETECT_ACT);
+	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_POLL_ACTIVE);
+	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_POLL_COMPLIANCE);
+	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_POLL_CONFIG);
+	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_PRE_DETECT_QUIET);
+	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_DETECT_WAIT);
+	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_CFG_LINKWD_START);
+	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_CFG_LINKWD_ACEPT);
+	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_CFG_LANENUM_WAI);
+	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_CFG_LANENUM_ACEPT);
+	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_CFG_COMPLETE);
+	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_CFG_IDLE);
+	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_RCVRY_LOCK);
+	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_RCVRY_SPEED);
+	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_RCVRY_RCVRCFG);
+	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_RCVRY_IDLE);
+	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_L0);
+	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_L0S);
+	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_L123_SEND_EIDLE);
+	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_L1_IDLE);
+	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_L2_IDLE);
+	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_L2_WAKE);
+	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_DISABLED_ENTRY);
+	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_DISABLED_IDLE);
+	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_DISABLED);
+	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_LPBK_ENTRY);
+	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_LPBK_ACTIVE);
+	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_LPBK_EXIT);
+	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_LPBK_EXIT_TIMEOUT);
+	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_HOT_RESET_ENTRY);
+	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_HOT_RESET);
+	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_RCVRY_EQ0);
+	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_RCVRY_EQ1);
+	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_RCVRY_EQ2);
+	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_RCVRY_EQ3);
+	default:
+		str = "DW_PCIE_LTSSM_UNKNOWN";
+		break;
+	}
+
+	return str + strlen("DW_PCIE_LTSSM_");
+}
+
 int dw_pcie_host_init(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
@@ -524,7 +574,7 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 	if (ret)
 		goto err_remove_edma;
 
-	ret = dwc_pcie_rasdes_debugfs_init(pci);
+	ret = dwc_pcie_debugfs_init(pci);
 	if (ret)
 		goto err_remove_edma;
 
@@ -575,7 +625,7 @@ void dw_pcie_host_deinit(struct dw_pcie_rp *pp)
 
 	dw_pcie_stop_link(pci);
 
-	dwc_pcie_rasdes_debugfs_deinit(pci);
+	dwc_pcie_debugfs_deinit(pci);
 
 	dw_pcie_edma_remove(pci);
 
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 8d5dc22f06f7..a3c2d2b6284b 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -330,8 +330,40 @@ enum dw_pcie_ltssm {
 	/* Need to align with PCIE_PORT_DEBUG0 bits 0:5 */
 	DW_PCIE_LTSSM_DETECT_QUIET = 0x0,
 	DW_PCIE_LTSSM_DETECT_ACT = 0x1,
+	DW_PCIE_LTSSM_POLL_ACTIVE = 0x2,
+	DW_PCIE_LTSSM_POLL_COMPLIANCE = 0x3,
+	DW_PCIE_LTSSM_POLL_CONFIG = 0x4,
+	DW_PCIE_LTSSM_PRE_DETECT_QUIET = 0x5,
+	DW_PCIE_LTSSM_DETECT_WAIT = 0x6,
+	DW_PCIE_LTSSM_CFG_LINKWD_START = 0x7,
+	DW_PCIE_LTSSM_CFG_LINKWD_ACEPT = 0x8,
+	DW_PCIE_LTSSM_CFG_LANENUM_WAI = 0x9,
+	DW_PCIE_LTSSM_CFG_LANENUM_ACEPT = 0xa,
+	DW_PCIE_LTSSM_CFG_COMPLETE = 0xb,
+	DW_PCIE_LTSSM_CFG_IDLE = 0xc,
+	DW_PCIE_LTSSM_RCVRY_LOCK = 0xd,
+	DW_PCIE_LTSSM_RCVRY_SPEED = 0xe,
+	DW_PCIE_LTSSM_RCVRY_RCVRCFG = 0xf,
+	DW_PCIE_LTSSM_RCVRY_IDLE = 0x10,
 	DW_PCIE_LTSSM_L0 = 0x11,
+	DW_PCIE_LTSSM_L0S = 0x12,
+	DW_PCIE_LTSSM_L123_SEND_EIDLE = 0x13,
+	DW_PCIE_LTSSM_L1_IDLE = 0x14,
 	DW_PCIE_LTSSM_L2_IDLE = 0x15,
+	DW_PCIE_LTSSM_L2_WAKE = 0x16,
+	DW_PCIE_LTSSM_DISABLED_ENTRY = 0x17,
+	DW_PCIE_LTSSM_DISABLED_IDLE = 0x18,
+	DW_PCIE_LTSSM_DISABLED = 0x19,
+	DW_PCIE_LTSSM_LPBK_ENTRY = 0x1a,
+	DW_PCIE_LTSSM_LPBK_ACTIVE = 0x1b,
+	DW_PCIE_LTSSM_LPBK_EXIT = 0x1c,
+	DW_PCIE_LTSSM_LPBK_EXIT_TIMEOUT = 0x1d,
+	DW_PCIE_LTSSM_HOT_RESET_ENTRY = 0x1e,
+	DW_PCIE_LTSSM_HOT_RESET = 0x1f,
+	DW_PCIE_LTSSM_RCVRY_EQ0 = 0x20,
+	DW_PCIE_LTSSM_RCVRY_EQ1 = 0x21,
+	DW_PCIE_LTSSM_RCVRY_EQ2 = 0x22,
+	DW_PCIE_LTSSM_RCVRY_EQ3 = 0x23,
 
 	DW_PCIE_LTSSM_UNKNOWN = 0xFFFFFFFF,
 };
@@ -463,6 +495,7 @@ struct dw_pcie {
 	struct reset_control_bulk_data	core_rsts[DW_PCIE_NUM_CORE_RSTS];
 	struct gpio_desc		*pe_rst;
 	bool			suspended;
+	struct dentry		*debugfs;
 	void			*rasdes_info;
 };
 
@@ -679,6 +712,8 @@ static inline enum dw_pcie_ltssm dw_pcie_get_ltssm(struct dw_pcie *pci)
 	return (enum dw_pcie_ltssm)FIELD_GET(PORT_LOGIC_LTSSM_STATE_MASK, val);
 }
 
+char *dw_ltssm_sts_string(enum dw_pcie_ltssm ltssm);
+
 #ifdef CONFIG_PCIE_DW_HOST
 irqreturn_t dw_handle_msi_irq(struct dw_pcie_rp *pp);
 int dw_pcie_setup_rc(struct dw_pcie_rp *pp);
@@ -799,14 +834,14 @@ dw_pcie_ep_get_func_from_ep(struct dw_pcie_ep *ep, u8 func_no)
 #endif
 
 #ifdef CONFIG_PCIE_DW_DEBUGFS
-int dwc_pcie_rasdes_debugfs_init(struct dw_pcie *pci);
-void dwc_pcie_rasdes_debugfs_deinit(struct dw_pcie *pci);
+int dwc_pcie_debugfs_init(struct dw_pcie *pci);
+void dwc_pcie_debugfs_deinit(struct dw_pcie *pci);
 #else
-static inline int dwc_pcie_rasdes_debugfs_init(struct dw_pcie *pci)
+static inline int dwc_pcie_debugfs_init(struct dw_pcie *pci)
 {
 	return 0;
 }
-static inline void dwc_pcie_rasdes_debugfs_deinit(struct dw_pcie *pci)
+static inline void dwc_pcie_debugfs_deinit(struct dw_pcie *pci)
 {
 }
 #endif

base-commit: 7004a2e46d1693848370809aa3d9c340a209edbb
prerequisite-patch-id: 6e5987e85df22c4d3859d21765617055faca96a1
prerequisite-patch-id: 200b28aafcac3933da9feffce2381a2a9b4a6243
prerequisite-patch-id: faf05c564e8d6a7b78ea4aaac3a02abcad53fe27
prerequisite-patch-id: 8b199e3e1baa2eafa59ad45640db1f34992bcb32
-- 
2.25.1


