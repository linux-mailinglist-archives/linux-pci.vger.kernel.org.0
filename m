Return-Path: <linux-pci+bounces-21465-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D70D7A360C4
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 15:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 296337A2B78
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 14:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619EA265CB2;
	Fri, 14 Feb 2025 14:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="IecSy9VT"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF862566D9;
	Fri, 14 Feb 2025 14:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739544423; cv=none; b=BiTt03wIHYZM7f1TEhjtdYilBoTS13ZBCYzL7BdOTfuIBg9thw1SnWQX7DpZ9zCw56U/UYrENhgvfqq5ehc6FkWGvA2KiEjGqEUUMmq8uMsrLo+0tUnOFgllhEIg4snYkjSqj1SFb+wCR4Uk8ePDZsEqBT5LhVt81ejlB3aKSl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739544423; c=relaxed/simple;
	bh=sRFXYxCPrL/gUklLy0Nyvle96HAqhbaZ87gZ8st7I7w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=C5ixSBQ4iB8t2zGgPitQjCegBW4P2t1nkLh3nc3WHqnAUU6Fg4Q+flqW9YO8Z3UFCh1zXVSo4M4zoYtCgG9uanddk6fwrUQ9sCS08p80i1Bzw0KQzQrpWlMUT3Zl0uZQE+Ia7wgpeHKlFZYSb9LqaCoiBXnLUN2YqTotfE5jp4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=IecSy9VT; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=AbCRB
	09p2imWWCnBx16qId8tHB9KPFCB54/9gp1uL3Y=; b=IecSy9VTQgESUXwbv3oa5
	7HPB1M8rHAyHaEOJTVJ9cbW4ZgexNBdKoV00UXZEZls0rTu+tf2wqsQB1Hsy6Hjt
	Iq2IqGZi5GfvPX7B+vj5/B/MNhw1q94aClULtwPM3AiJY7uhxRNpjG6fp+l9J8Ju
	J+O+CQHpk4NtmTYcSMtjZ0=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wC3Tlk+V69nlSWJMA--.20908S2;
	Fri, 14 Feb 2025 22:46:23 +0800 (CST)
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
Subject: [v3] PCI: dwc: Add the debugfs property to provide the LTSSM status of the PCIe link
Date: Fri, 14 Feb 2025 22:46:18 +0800
Message-Id: <20250214144618.176028-1-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wC3Tlk+V69nlSWJMA--.20908S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Gr18ZF4xGr4rCF1fAF1rXrb_yoWDJrWrpa
	yrAFWFyF42vw1ay3W3J3WkZF45tan3AF1q9wsrJ3yxXa4Iy3WDGr4rJw4jkr97Jr47Gr13
	Jw13AF1kGr18J3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zN9akUUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiDxrzo2evU8E0OgAAsR

Add the debugfs property to provide a view of the current link's LTSSM
status from the root port device.

  /sys/kernel/debug/dwc_pcie_<dev>/ltssm_status

Signed-off-by: Hans Zhang <18255117159@163.com>
---
Changes since v2:
https://lore.kernel.org/linux-pci/20250206151343.26779-1-18255117159@163.com/

- Git pulls the latest code and fixes conflicts.
- Do not place into sysfs node as recommended by maintainer. Shradha-based patch
  is put into debugfs.
- Submissions based on the following v6 patches:
https://patchwork.kernel.org/project/linux-pci/patch/20250214105007.97582-2-shradha.t@samsung.com/
https://patchwork.kernel.org/project/linux-pci/patch/20250214105007.97582-3-shradha.t@samsung.com/
https://patchwork.kernel.org/project/linux-pci/patch/20250214105007.97582-4-shradha.t@samsung.com/
https://patchwork.kernel.org/project/linux-pci/patch/20250214105007.97582-5-shradha.t@samsung.com/

Changes since v1:
https://lore.kernel.org/linux-pci/20250123071326.1810751-1-18255117159@163.com/

- Do not place into sysfs node as recommended by maintainer. Shradha-based patch
  is put into debugfs.
- Submissions based on the following v5 patches:
https://patchwork.kernel.org/project/linux-pci/patch/20250121111421.35437-2-shradha.t@samsung.com/
https://patchwork.kernel.org/project/linux-pci/patch/20250121111421.35437-3-shradha.t@samsung.com/
https://patchwork.kernel.org/project/linux-pci/patch/20250121111421.35437-4-shradha.t@samsung.com/
https://patchwork.kernel.org/project/linux-pci/patch/20250121111421.35437-5-shradha.t@samsung.com/
---
 Documentation/ABI/testing/debugfs-dwc-pcie    |  6 +++
 .../controller/dwc/pcie-designware-debugfs.c  | 29 +++++++++++
 .../pci/controller/dwc/pcie-designware-host.c | 50 +++++++++++++++++++
 drivers/pci/controller/dwc/pcie-designware.h  | 33 ++++++++++++
 4 files changed, 118 insertions(+)

diff --git a/Documentation/ABI/testing/debugfs-dwc-pcie b/Documentation/ABI/testing/debugfs-dwc-pcie
index 01aa9d3a00c6..d52e84413f59 100644
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
index 2087185a1968..581432c2b832 100644
--- a/drivers/pci/controller/dwc/pcie-designware-debugfs.c
+++ b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
@@ -561,6 +561,33 @@ static int dwc_pcie_rasdes_debugfs_init(struct dw_pcie *pci, struct dentry *dir)
 	return ret;
 }
 
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
 void dwc_pcie_debugfs_deinit(struct dw_pcie *pci)
 {
 	dwc_pcie_rasdes_debugfs_deinit(pci);
@@ -591,5 +618,7 @@ int dwc_pcie_debugfs_init(struct dw_pcie *pci)
 	if (ret)
 		dev_dbg(dev, "rasdes debugfs init failed\n");
 
+	dwc_pcie_ltssm_debugfs_init(pci, dir);
+
 	return 0;
 }
diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index fa30b745d4ae..3f23996b06da 100644
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
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 35342120d5a8..aa86483442c9 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -330,9 +330,40 @@ enum dw_pcie_ltssm {
 	/* Need to align with PCIE_PORT_DEBUG0 bits 0:5 */
 	DW_PCIE_LTSSM_DETECT_QUIET = 0x0,
 	DW_PCIE_LTSSM_DETECT_ACT = 0x1,
+	DW_PCIE_LTSSM_POLL_ACTIVE = 0x2,
+	DW_PCIE_LTSSM_POLL_COMPLIANCE = 0x3,
+	DW_PCIE_LTSSM_POLL_CONFIG = 0x4,
+	DW_PCIE_LTSSM_PRE_DETECT_QUIET = 0x5,
 	DW_PCIE_LTSSM_DETECT_WAIT = 0x6,
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
@@ -683,6 +714,8 @@ static inline enum dw_pcie_ltssm dw_pcie_get_ltssm(struct dw_pcie *pci)
 	return (enum dw_pcie_ltssm)FIELD_GET(PORT_LOGIC_LTSSM_STATE_MASK, val);
 }
 
+char *dw_ltssm_sts_string(enum dw_pcie_ltssm ltssm);
+
 #ifdef CONFIG_PCIE_DW_HOST
 int dw_pcie_suspend_noirq(struct dw_pcie *pci);
 int dw_pcie_resume_noirq(struct dw_pcie *pci);

base-commit: 128c8f96eb8638c060cd3532dc394d046ce64fe1
prerequisite-patch-id: 6e5987e85df22c4d3859d21765617055faca96a1
prerequisite-patch-id: 6f9e6fb15185f106699860f3cefca108556a9baa
prerequisite-patch-id: 55d4df789f48ddbddb11b05b6bb4251dc0001d3d
prerequisite-patch-id: 753a18e3a3d8499f99e735ecf3ed1fb2c3bc4a4a
-- 
2.25.1


