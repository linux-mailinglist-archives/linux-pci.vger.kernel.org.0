Return-Path: <linux-pci+bounces-22139-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85726A4142E
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 04:45:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE384189445A
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 03:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32E51C5F11;
	Mon, 24 Feb 2025 03:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="sLqoVtAq"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17781AAA0D;
	Mon, 24 Feb 2025 03:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740368715; cv=none; b=n3f4lIzVBZA0lzh2Q69HvrXi4kRtCbdsmJmwn6pQTdldqOw3Jx5hEFxKmQZoU4HpJgjKqhamdpOpl8PlrIEBBCV75FCr5cmSirHsvWX0BpkxXv8bss93Jb+Y8+guZBhuTscrDg7BITe8EKERnKzFDQEPkuFJMLl+mvsyhNTOZpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740368715; c=relaxed/simple;
	bh=Z63BjGA1BVkMRgurztK/iK1uMx3eBg2BCSpAiKRwz+E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Hfe40SePLB2Ng6WH9DLS1k9yFxDKzhFiTTT0C/FicN5UT1JbVsIe/XKUuM8E69uqDLO4dFY0vE0I6xb7sZ4mktow0HnQzcq6BIzVjzpVTdHms5AtdGC5dWVdC963TzI749iqrXiP0FmKDVQdmUhSGH9/GKczujLIJLSL6l/yisY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=sLqoVtAq; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1740368704; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=V6qMCrYnpDuf4CL4/21Ay3Wnk4Z6RjxNTwozxvs3+uY=;
	b=sLqoVtAqYpYda84oDfO9dpcnUGUfaBmqNJuZGCP7Owb01P+VaJwUl7F29PjNIFVA7YSNXyGGoG9UjJMAylIGmJyg/1f9HR+D3uI06ZUVNVLK96PkDktQJsSg0lQPS31IZdGyhSteKZ6vnF2xmL4sUw1Z0xrpSsonbJ334KnoHWs=
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0WQ1rZfk_1740368702 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 24 Feb 2025 11:45:03 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Lukas Wunner <lukas@wunner.de>,
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Liguang Zhang <zhangliguang@linux.alibaba.com>,
	Guanghui Feng <guanghuifeng@linux.alibaba.com>,
	rafael@kernel.org
Cc: Markus Elfring <Markus.Elfring@web.de>,
	lkp@intel.com,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	ilpo.jarvinen@linux.intel.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Feng Tang <feng.tang@linux.alibaba.com>
Subject: [PATCH v3 1/4] PCI: portdrv: pciehp: Move PCIe hotplug command waiting logic to port driver
Date: Mon, 24 Feb 2025 11:44:57 +0800
Message-Id: <20250224034500.23024-2-feng.tang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250224034500.23024-1-feng.tang@linux.alibaba.com>
References: <20250224034500.23024-1-feng.tang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to PCIe spec, after sending a hotplug command, software should
wait some time for the command completion. Currently the waiting logic
is implemented in pciehp driver, as the same logic will be reused by
PCIe port driver, move it to port driver, which complies with the logic
of CONFIG_HOTPLUG_PCI_PCIE depending on CONFIG_PCIEPORTBUS.

Also convert the loop wait logic to helper read_poll_timeout() as
suggested by Sathyanarayanan Kuppuswamy.

Signed-off-by: Feng Tang <feng.tang@linux.alibaba.com>
---
 drivers/pci/hotplug/pciehp_hpc.c | 38 ++++++++------------------------
 drivers/pci/pci.h                |  5 +++++
 drivers/pci/pcie/portdrv.c       | 25 +++++++++++++++++++++
 3 files changed, 39 insertions(+), 29 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index bb5a8d9f03ad..24e346f558db 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -83,32 +83,6 @@ static inline void pciehp_free_irq(struct controller *ctrl)
 		free_irq(ctrl->pcie->irq, ctrl);
 }
 
-static int pcie_poll_cmd(struct controller *ctrl, int timeout)
-{
-	struct pci_dev *pdev = ctrl_dev(ctrl);
-	u16 slot_status;
-
-	do {
-		pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
-		if (PCI_POSSIBLE_ERROR(slot_status)) {
-			ctrl_info(ctrl, "%s: no response from device\n",
-				  __func__);
-			return 0;
-		}
-
-		if (slot_status & PCI_EXP_SLTSTA_CC) {
-			pcie_capability_write_word(pdev, PCI_EXP_SLTSTA,
-						   PCI_EXP_SLTSTA_CC);
-			ctrl->cmd_busy = 0;
-			smp_mb();
-			return 1;
-		}
-		msleep(10);
-		timeout -= 10;
-	} while (timeout >= 0);
-	return 0;	/* timeout */
-}
-
 static void pcie_wait_cmd(struct controller *ctrl)
 {
 	unsigned int msecs = pciehp_poll_mode ? 2500 : 1000;
@@ -138,10 +112,16 @@ static void pcie_wait_cmd(struct controller *ctrl)
 		timeout = cmd_timeout - now;
 
 	if (ctrl->slot_ctrl & PCI_EXP_SLTCTL_HPIE &&
-	    ctrl->slot_ctrl & PCI_EXP_SLTCTL_CCIE)
+	    ctrl->slot_ctrl & PCI_EXP_SLTCTL_CCIE) {
 		rc = wait_event_timeout(ctrl->queue, !ctrl->cmd_busy, timeout);
-	else
-		rc = pcie_poll_cmd(ctrl, jiffies_to_msecs(timeout));
+	} else {
+		rc = pcie_poll_sltctl_cmd(ctrl_dev(ctrl), jiffies_to_msecs(timeout));
+		if (!rc) {
+			ctrl->cmd_busy = 0;
+			smp_mb();
+			rc = 1;
+		}
+	}
 
 	if (!rc)
 		ctrl_info(ctrl, "Timeout on hotplug command %#06x (issued %u msec ago)\n",
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 01e51db8d285..4c94a589de4a 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -759,12 +759,17 @@ static inline void pcie_ecrc_get_policy(char *str) { }
 #ifdef CONFIG_PCIEPORTBUS
 void pcie_reset_lbms_count(struct pci_dev *port);
 int pcie_lbms_count(struct pci_dev *port, unsigned long *val);
+int pcie_poll_sltctl_cmd(struct pci_dev *dev, int timeout_ms);
 #else
 static inline void pcie_reset_lbms_count(struct pci_dev *port) {}
 static inline int pcie_lbms_count(struct pci_dev *port, unsigned long *val)
 {
 	return -EOPNOTSUPP;
 }
+static inline int pcie_poll_sltctl_cmd(struct pci_dev *dev, int timeout_ms)
+{
+	return 0;
+}
 #endif
 
 struct pci_dev_reset_methods {
diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
index 02e73099bad0..bb00ba45ee51 100644
--- a/drivers/pci/pcie/portdrv.c
+++ b/drivers/pci/pcie/portdrv.c
@@ -18,6 +18,7 @@
 #include <linux/string.h>
 #include <linux/slab.h>
 #include <linux/aer.h>
+#include <linux/iopoll.h>
 
 #include "../pci.h"
 #include "portdrv.h"
@@ -205,6 +206,30 @@ static int pcie_init_service_irqs(struct pci_dev *dev, int *irqs, int mask)
 	return 0;
 }
 
+/* Return 0 on command completed on time, otherwise return -ETIMEOUT */
+int pcie_poll_sltctl_cmd(struct pci_dev *dev, int timeout_ms)
+{
+	u16 slot_status = 0;
+	u32 slot_cap;
+	int ret = 0;
+	int __maybe_unused ret1;
+
+	/* Don't wait if the command complete event is not well supported */
+	pcie_capability_read_dword(dev, PCI_EXP_SLTCAP, &slot_cap);
+	if (!(slot_cap & PCI_EXP_SLTCAP_HPC) || slot_cap & PCI_EXP_SLTCAP_NCCS)
+		return ret;
+
+	ret = read_poll_timeout(pcie_capability_read_word, ret1,
+				(slot_status & PCI_EXP_SLTSTA_CC), 10000,
+				timeout_ms * 1000, true, dev, PCI_EXP_SLTSTA,
+				&slot_status);
+	if (!ret)
+		pcie_capability_write_word(dev, PCI_EXP_SLTSTA,
+						PCI_EXP_SLTSTA_CC);
+
+	return  ret;
+}
+
 /**
  * get_port_device_capability - discover capabilities of a PCI Express port
  * @dev: PCI Express port to examine
-- 
2.43.5


