Return-Path: <linux-pci+bounces-29937-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0541ADD12C
	for <lists+linux-pci@lfdr.de>; Tue, 17 Jun 2025 17:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 968B63A4526
	for <lists+linux-pci@lfdr.de>; Tue, 17 Jun 2025 15:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483BE2EAD1C;
	Tue, 17 Jun 2025 15:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=raptorengineering.com header.i=@raptorengineering.com header.b="jFsy2LHi"
X-Original-To: linux-pci@vger.kernel.org
Received: from raptorengineering.com (mail.raptorengineering.com [23.155.224.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772E22EB5A7
	for <linux-pci@vger.kernel.org>; Tue, 17 Jun 2025 15:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.155.224.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750173430; cv=none; b=qTUbCusV7wNBMrJkpwkMNWbvPaqgih4ckGGD5nJCy2e+gJdw5lelzLxR63nzOPctl7A4KJzxgosgW9DVdoalWHGuVH5M6wBu/mUZC8m6jvLpph2TU1in/GOp6H3M2zUWWt5Og3UVVe/ziMpqsTa5rUJ56zKA6Y1Ztg3YhJI//B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750173430; c=relaxed/simple;
	bh=YvRC/TY2fP/E3Tu3EYZzYlsplelpdDq7+9uJXbUTGIQ=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:Content-Type; b=sw6AfcW7dfhiSE8Xl04Frccuf9n9rK78+F9quT62Zdg1UDdOAFKOW/FmJyOaWOkjvC7FUUNADQcTPEoq/JIkOOPND+kjb3ZEfEOghU0MWBOxMIAH40OftletwI7HofWyDPu4vLiVYtKPtn97r24z9DLY2egYiMoapOwNe2V5kus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com; spf=pass smtp.mailfrom=raptorengineering.com; dkim=pass (1024-bit key) header.d=raptorengineering.com header.i=@raptorengineering.com header.b=jFsy2LHi; arc=none smtp.client-ip=23.155.224.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raptorengineering.com
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id BF7848288525;
	Tue, 17 Jun 2025 10:17:07 -0500 (CDT)
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id Os47lUzo8jdr; Tue, 17 Jun 2025 10:17:06 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 680B5828867F;
	Tue, 17 Jun 2025 10:17:06 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rptsys.com 680B5828867F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=raptorengineering.com; s=B8E824E6-0BE2-11E6-931D-288C65937AAD;
	t=1750173426; bh=Kcv94WL+u3XA4B8JQaEdCbtVJnvdHB4fiMitEhxHrko=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=jFsy2LHif592xmZx32cehMHbcsrK7pDrOUCP3SxnYwNBDWQYnadIHs/SQOlyKTieY
	 9cn89gmMD1w8DQ5nUsE0/Bvoiq9c6jWuKgjq+Bh6dCYNtyzqgs+YCwUuRAgERBhjvB
	 Kkmm1cIsThurO+2suF8yoyxcieX+hsEsYyYytggo=
X-Virus-Scanned: amavisd-new at rptsys.com
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id dLXWLLnaTZRy; Tue, 17 Jun 2025 10:17:06 -0500 (CDT)
Received: from vali.starlink.edu (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 400138288525;
	Tue, 17 Jun 2025 10:17:06 -0500 (CDT)
Date: Tue, 17 Jun 2025 10:17:06 -0500 (CDT)
From: Timothy Pearson <tpearson@raptorengineering.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci <linux-pci@vger.kernel.org>, mahesh <mahesh@linux.ibm.com>, 
	Oliver <oohall@gmail.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, 
	Lukas Wunner <lukas@wunner.de>
Message-ID: <308441448.1308106.1750173426169.JavaMail.zimbra@raptorengineeringinc.com>
Subject: [PATCH v8] PCI: Add pcie_link_is_active() function
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.5.0_GA_3042 (ZimbraWebClient - GC137 (Linux)/8.5.0_GA_3042)
Thread-Index: bRchl5cQV1XGiSEvnp7ITUHd/LUyIw==
Thread-Topic: Add pcie_link_is_active() function

Add pcie_link_is_active() function to check if the physical PCIe link is
active, replacing duplicate code in multiple locations.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Signed-off-by: Shawn Anastasio <sanastasio@raptorengineering.com>
Signed-off-by: Timothy Pearson <tpearson@raptorengineering.com>
---
 arch/powerpc/kernel/eeh_driver.c  |  8 +++++++-
 drivers/pci/hotplug/pciehp.h      |  1 -
 drivers/pci/hotplug/pciehp_ctrl.c |  2 +-
 drivers/pci/hotplug/pciehp_hpc.c  | 33 +++----------------------------
 drivers/pci/pci.c                 | 30 +++++++++++++++++++++++++---
 drivers/pci/pci.h                 |  1 +
 include/linux/pci.h               |  1 +
 7 files changed, 40 insertions(+), 36 deletions(-)

diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
index 7efe04c68f0f..a9c467fa415b 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -1095,8 +1095,14 @@ void eeh_handle_normal_event(struct eeh_pe *pe)
 		eeh_pe_dev_mode_mark(pe, EEH_DEV_REMOVED);
 
 		pci_lock_rescan_remove();
-		pci_hp_remove_devices(bus);
+		bus = eeh_pe_bus_get(pe);
+		if (bus)
+			pci_hp_remove_devices(bus);
+		else
+			pr_err("%s: PCI bus for PHB#%x-PE#%x disappeared\n",
+				__func__, pe->phb->global_number, pe->addr);
 		pci_unlock_rescan_remove();
+
 		/* The passed PE should no longer be used */
 		return;
 	}
diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index debc79b0adfb..79df49cc9946 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -186,7 +186,6 @@ int pciehp_query_power_fault(struct controller *ctrl);
 int pciehp_card_present(struct controller *ctrl);
 int pciehp_card_present_or_link_active(struct controller *ctrl);
 int pciehp_check_link_status(struct controller *ctrl);
-int pciehp_check_link_active(struct controller *ctrl);
 bool pciehp_device_replaced(struct controller *ctrl);
 void pciehp_release_ctrl(struct controller *ctrl);
 
diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
index bcc938d4420f..6cc1b27b3b11 100644
--- a/drivers/pci/hotplug/pciehp_ctrl.c
+++ b/drivers/pci/hotplug/pciehp_ctrl.c
@@ -260,7 +260,7 @@ void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
 	/* Turn the slot on if it's occupied or link is up */
 	mutex_lock(&ctrl->state_lock);
 	present = pciehp_card_present(ctrl);
-	link_active = pciehp_check_link_active(ctrl);
+	link_active = pcie_link_is_active(ctrl->pcie->port);
 	if (present <= 0 && link_active <= 0) {
 		if (ctrl->state == BLINKINGON_STATE) {
 			ctrl->state = OFF_STATE;
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index ebd342bda235..d29ce3715a44 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -221,33 +221,6 @@ static void pcie_write_cmd_nowait(struct controller *ctrl, u16 cmd, u16 mask)
 	pcie_do_write_cmd(ctrl, cmd, mask, false);
 }
 
-/**
- * pciehp_check_link_active() - Is the link active
- * @ctrl: PCIe hotplug controller
- *
- * Check whether the downstream link is currently active. Note it is
- * possible that the card is removed immediately after this so the
- * caller may need to take it into account.
- *
- * If the hotplug controller itself is not available anymore returns
- * %-ENODEV.
- */
-int pciehp_check_link_active(struct controller *ctrl)
-{
-	struct pci_dev *pdev = ctrl_dev(ctrl);
-	u16 lnk_status;
-	int ret;
-
-	ret = pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_status);
-	if (ret == PCIBIOS_DEVICE_NOT_FOUND || PCI_POSSIBLE_ERROR(lnk_status))
-		return -ENODEV;
-
-	ret = !!(lnk_status & PCI_EXP_LNKSTA_DLLLA);
-	ctrl_dbg(ctrl, "%s: lnk_status = %x\n", __func__, lnk_status);
-
-	return ret;
-}
-
 static bool pci_bus_check_dev(struct pci_bus *bus, int devfn)
 {
 	u32 l;
@@ -467,7 +440,7 @@ int pciehp_card_present_or_link_active(struct controller *ctrl)
 	if (ret)
 		return ret;
 
-	return pciehp_check_link_active(ctrl);
+	return pcie_link_is_active(ctrl_dev(ctrl));
 }
 
 int pciehp_query_power_fault(struct controller *ctrl)
@@ -614,7 +587,7 @@ static void pciehp_ignore_link_change(struct controller *ctrl,
 	 * Synthesize it to ensure that it is acted on.
 	 */
 	down_read_nested(&ctrl->reset_lock, ctrl->depth);
-	if (!pciehp_check_link_active(ctrl) || pciehp_device_replaced(ctrl))
+	if (!pcie_link_is_active(ctrl_dev(ctrl)) || pciehp_device_replaced(ctrl))
 		pciehp_request(ctrl, ignored_events);
 	up_read(&ctrl->reset_lock);
 }
@@ -921,7 +894,7 @@ int pciehp_slot_reset(struct pcie_device *dev)
 	pcie_capability_write_word(dev->port, PCI_EXP_SLTSTA,
 				   PCI_EXP_SLTSTA_DLLSC);
 
-	if (!pciehp_check_link_active(ctrl))
+	if (!pcie_link_is_active(ctrl_dev(ctrl)))
 		pciehp_request(ctrl, PCI_EXP_SLTSTA_DLLSC);
 
 	return 0;
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e9448d55113b..f1a690afd6da 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4908,7 +4908,6 @@ int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type)
 		return 0;
 
 	if (pcie_get_speed_cap(dev) <= PCIE_SPEED_5_0GT) {
-		u16 status;
 
 		pci_dbg(dev, "waiting %d ms for downstream link\n", delay);
 		msleep(delay);
@@ -4924,8 +4923,7 @@ int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type)
 		if (!dev->link_active_reporting)
 			return -ENOTTY;
 
-		pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &status);
-		if (!(status & PCI_EXP_LNKSTA_DLLLA))
+		if (pcie_link_is_active(dev) <= 0)
 			return -ENOTTY;
 
 		return pci_dev_wait(child, reset_type,
@@ -6230,6 +6228,32 @@ void pcie_print_link_status(struct pci_dev *dev)
 }
 EXPORT_SYMBOL(pcie_print_link_status);
 
+/**
+ * pcie_link_is_active() - Checks if the link is active or not
+ * @pdev: PCI device to query
+ *
+ * Check whether the physical link is active or not. Note it is
+ * possible that the card is removed immediately after this so the
+ * caller may need to take it into account.
+ *
+ * If the PCI device itself is not available anymore returns
+ * %-ENODEV.
+ *
+ * Return: link state, or -ENODEV if the config read failes.
+ */
+int pcie_link_is_active(struct pci_dev *pdev)
+{
+	u16 lnk_status;
+	int ret;
+
+	ret = pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_status);
+	if (ret == PCIBIOS_DEVICE_NOT_FOUND || PCI_POSSIBLE_ERROR(lnk_status))
+		return -ENODEV;
+
+	pci_dbg(pdev, "lnk_status = %#06x\n", lnk_status);
+	return !!(lnk_status & PCI_EXP_LNKSTA_DLLLA);
+}
+
 /**
  * pci_select_bars - Make BAR mask from the type of resource
  * @dev: the PCI device for which BAR mask is made
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 12215ee72afb..cf1afb718f8a 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -231,6 +231,7 @@ static inline int pci_proc_detach_bus(struct pci_bus *bus) { return 0; }
 /* Functions for PCI Hotplug drivers to use */
 int pci_hp_add_bridge(struct pci_dev *dev);
 bool pci_hp_spurious_link_change(struct pci_dev *pdev);
+int pcie_link_is_active(struct pci_dev *dev);
 
 #if defined(CONFIG_SYSFS) && defined(HAVE_PCI_LEGACY)
 void pci_create_legacy_files(struct pci_bus *bus);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 05e68f35f392..1133b35696e4 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2141,6 +2141,7 @@ pci_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
 {
 	return -ENOSPC;
 }
+
 #endif /* CONFIG_PCI */
 
 /* Include architecture-dependent settings and functions */
-- 
2.39.5

