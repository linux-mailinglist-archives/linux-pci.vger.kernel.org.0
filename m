Return-Path: <linux-pci+bounces-25632-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C102A84809
	for <lists+linux-pci@lfdr.de>; Thu, 10 Apr 2025 17:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F3B93BC913
	for <lists+linux-pci@lfdr.de>; Thu, 10 Apr 2025 15:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D931E98FF;
	Thu, 10 Apr 2025 15:32:48 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91AEB1E9B0F;
	Thu, 10 Apr 2025 15:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744299168; cv=none; b=Pozg+FPIjTPHca0K3LlB+Ff93B0ikpSUWSeXzn+RR9c7gxn4TZSQVAfAruw9q6ABpBXMLSULnuG1MOQPRIKo+GKRQTNI1LdALo7bIZUO8W0LgG8x8vAQS0TbzaGTtzT0WO3h0MM31STSb5B2rY8TVp5EbwYZQ92aL209TYnvZGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744299168; c=relaxed/simple;
	bh=nIFuohKrlS+r8g32APz0MYw3eiuwlmjY3j2efFh2Sa0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:To:Cc; b=SWtGMbKZYioZksor/zhY10sdr03l5Vy4o5ZG1GA5rQOHumOH0RuvCIM7xYIXOXfzi+sqhzB6drm4g2xNx8ZJgF1GP4WfvFOn6AZFOnBPUowifv+LiVD7wan0F43U9/LWnrxbAEE7USm90qEIkYWo8uFkqoMyXcorw67yCp/0s8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id BF5CE2C4C0F5;
	Thu, 10 Apr 2025 17:32:08 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id CBF363F290; Thu, 10 Apr 2025 17:32:36 +0200 (CEST)
Message-Id: <fa264ff71952915c4e35a53c89eb0cde8455a5c5.1744298239.git.lukas@wunner.de>
In-Reply-To: <cover.1744298239.git.lukas@wunner.de>
References: <cover.1744298239.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Thu, 10 Apr 2025 17:27:11 +0200
Subject: [PATCH 1/2] PCI: pciehp: Ignore Presence Detect Changed caused by DPC
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, Keith Busch <kbusch@kernel.org>, Yicong Yang <yangyicong@hisilicon.com>, linux-pci@vger.kernel.org, Stuart Hayes <stuart.w.hayes@gmail.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>, "Joel Mathew Thomas" <proxy0@tutamail.com>, Russ Weight <russ.weight@linux.dev>, Matthew Gerlach <matthew.gerlach@altera.com>, Yilun Xu <yilun.xu@intel.com>, linux-fpga@vger.kernel.org, Moshe Shemesh <moshe@nvidia.com>, Shay Drory <shayd@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, Alex Williamson <alex.williamson@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Commit a97396c6eb13 ("PCI: pciehp: Ignore Link Down/Up caused by DPC")
amended PCIe hotplug to not bring down the slot upon Data Link Layer State
Changed events caused by Downstream Port Containment.

However Keith reports off-list that if the slot uses in-band presence
detect (i.e. Presence Detect State is derived from Data Link Layer Link
Active), DPC also causes a spurious Presence Detect Changed event.

This needs to be ignored as well.

Unfortunately there's no register indicating that in-band presence detect
is used.  PCIe r5.0 sec 7.5.3.10 introduced the In-Band PD Disable bit in
the Slot Control Register.  The PCIe hotplug driver sets this bit on
ports supporting it.  But older ports may still use in-band presence
detect.

If in-band presence detect can be disabled, Presence Detect Changed events
occurring during DPC must not be ignored because they signal device
replacement.  On all other ports, device replacement cannot be detected
reliably because the Presence Detect Changed event could be a side effect
of DPC.  On those (older) ports, perform a best-effort device replacement
check by comparing the Vendor ID, Device ID and other data in Config Space
with the values cached in struct pci_dev.  Use the existing helper
pciehp_device_replaced() to accomplish this.  It is currently #ifdef'ed to
CONFIG_PM_SLEEP in pciehp_core.c, so move it to pciehp_hpc.c where most
other functions accessing config space reside.

Reported-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/pci/hotplug/pciehp.h      |  1 +
 drivers/pci/hotplug/pciehp_core.c | 29 -----------------------
 drivers/pci/hotplug/pciehp_hpc.c  | 49 +++++++++++++++++++++++++++++++++------
 3 files changed, 43 insertions(+), 36 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index 273dd8c..debc79b0 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -187,6 +187,7 @@ struct controller {
 int pciehp_card_present_or_link_active(struct controller *ctrl);
 int pciehp_check_link_status(struct controller *ctrl);
 int pciehp_check_link_active(struct controller *ctrl);
+bool pciehp_device_replaced(struct controller *ctrl);
 void pciehp_release_ctrl(struct controller *ctrl);
 
 int pciehp_sysfs_enable_slot(struct hotplug_slot *hotplug_slot);
diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
index 997841c..f59baa9 100644
--- a/drivers/pci/hotplug/pciehp_core.c
+++ b/drivers/pci/hotplug/pciehp_core.c
@@ -284,35 +284,6 @@ static int pciehp_suspend(struct pcie_device *dev)
 	return 0;
 }
 
-static bool pciehp_device_replaced(struct controller *ctrl)
-{
-	struct pci_dev *pdev __free(pci_dev_put) = NULL;
-	u32 reg;
-
-	if (pci_dev_is_disconnected(ctrl->pcie->port))
-		return false;
-
-	pdev = pci_get_slot(ctrl->pcie->port->subordinate, PCI_DEVFN(0, 0));
-	if (!pdev)
-		return true;
-
-	if (pci_read_config_dword(pdev, PCI_VENDOR_ID, &reg) ||
-	    reg != (pdev->vendor | (pdev->device << 16)) ||
-	    pci_read_config_dword(pdev, PCI_CLASS_REVISION, &reg) ||
-	    reg != (pdev->revision | (pdev->class << 8)))
-		return true;
-
-	if (pdev->hdr_type == PCI_HEADER_TYPE_NORMAL &&
-	    (pci_read_config_dword(pdev, PCI_SUBSYSTEM_VENDOR_ID, &reg) ||
-	     reg != (pdev->subsystem_vendor | (pdev->subsystem_device << 16))))
-		return true;
-
-	if (pci_get_dsn(pdev) != ctrl->dsn)
-		return true;
-
-	return false;
-}
-
 static int pciehp_resume_noirq(struct pcie_device *dev)
 {
 	struct controller *ctrl = get_service_data(dev);
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 8a09fb6..388fbed 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -563,18 +563,48 @@ void pciehp_power_off_slot(struct controller *ctrl)
 		 PCI_EXP_SLTCTL_PWR_OFF);
 }
 
+bool pciehp_device_replaced(struct controller *ctrl)
+{
+	struct pci_dev *pdev __free(pci_dev_put) = NULL;
+	u32 reg;
+
+	if (pci_dev_is_disconnected(ctrl->pcie->port))
+		return false;
+
+	pdev = pci_get_slot(ctrl->pcie->port->subordinate, PCI_DEVFN(0, 0));
+	if (!pdev)
+		return true;
+
+	if (pci_read_config_dword(pdev, PCI_VENDOR_ID, &reg) ||
+	    reg != (pdev->vendor | (pdev->device << 16)) ||
+	    pci_read_config_dword(pdev, PCI_CLASS_REVISION, &reg) ||
+	    reg != (pdev->revision | (pdev->class << 8)))
+		return true;
+
+	if (pdev->hdr_type == PCI_HEADER_TYPE_NORMAL &&
+	    (pci_read_config_dword(pdev, PCI_SUBSYSTEM_VENDOR_ID, &reg) ||
+	     reg != (pdev->subsystem_vendor | (pdev->subsystem_device << 16))))
+		return true;
+
+	if (pci_get_dsn(pdev) != ctrl->dsn)
+		return true;
+
+	return false;
+}
+
 static void pciehp_ignore_dpc_link_change(struct controller *ctrl,
-					  struct pci_dev *pdev, int irq)
+					  struct pci_dev *pdev, int irq,
+					  u16 ignored_events)
 {
 	/*
 	 * Ignore link changes which occurred while waiting for DPC recovery.
 	 * Could be several if DPC triggered multiple times consecutively.
 	 */
 	synchronize_hardirq(irq);
-	atomic_and(~PCI_EXP_SLTSTA_DLLSC, &ctrl->pending_events);
+	atomic_and(~ignored_events, &ctrl->pending_events);
 	if (pciehp_poll_mode)
 		pcie_capability_write_word(pdev, PCI_EXP_SLTSTA,
-					   PCI_EXP_SLTSTA_DLLSC);
+					   ignored_events);
 	ctrl_info(ctrl, "Slot(%s): Link Down/Up ignored (recovered by DPC)\n",
 		  slot_name(ctrl));
 
@@ -584,8 +614,8 @@ static void pciehp_ignore_dpc_link_change(struct controller *ctrl,
 	 * Synthesize it to ensure that it is acted on.
 	 */
 	down_read_nested(&ctrl->reset_lock, ctrl->depth);
-	if (!pciehp_check_link_active(ctrl))
-		pciehp_request(ctrl, PCI_EXP_SLTSTA_DLLSC);
+	if (!pciehp_check_link_active(ctrl) || pciehp_device_replaced(ctrl))
+		pciehp_request(ctrl, ignored_events);
 	up_read(&ctrl->reset_lock);
 }
 
@@ -736,8 +766,13 @@ static irqreturn_t pciehp_ist(int irq, void *dev_id)
 	 */
 	if ((events & PCI_EXP_SLTSTA_DLLSC) && pci_dpc_recovered(pdev) &&
 	    ctrl->state == ON_STATE) {
-		events &= ~PCI_EXP_SLTSTA_DLLSC;
-		pciehp_ignore_dpc_link_change(ctrl, pdev, irq);
+		u16 ignored_events = PCI_EXP_SLTSTA_DLLSC;
+
+		if (!ctrl->inband_presence_disabled)
+			ignored_events |= events & PCI_EXP_SLTSTA_PDC;
+
+		events &= ~ignored_events;
+		pciehp_ignore_dpc_link_change(ctrl, pdev, irq, ignored_events);
 	}
 
 	/*
-- 
2.43.0


