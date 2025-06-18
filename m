Return-Path: <linux-pci+bounces-30002-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4659ADE255
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 06:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45AC7165A9C
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 04:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A2E1D86FF;
	Wed, 18 Jun 2025 04:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=raptorengineering.com header.i=@raptorengineering.com header.b="XaKZNXR5"
X-Original-To: linux-pci@vger.kernel.org
Received: from raptorengineering.com (mail.raptorengineering.com [23.155.224.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFDB1E3DF2;
	Wed, 18 Jun 2025 04:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.155.224.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750220602; cv=none; b=W05neYIxYQPIRDjtiElziM5Q2oiUEFsXuDON+xIKJ+rH/R/k6x/g2C0mhoM6Ixueyux7pZ3zuRfvXnX3uOVHvlCLXX4bOBwR1iLMfCikENYz0OvJe4GLgsoRNYs3uP5iDVN6O6ci+ThsX2gYnTOWLnuBdjQF8m5Jc6WQSyNONhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750220602; c=relaxed/simple;
	bh=zh+5GLNSn5EOg2rQRRDFN3NJiulPYn/5lnF0ursDg9g=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:Content-Type; b=OAWt6itrM9PTVwSVGlPmzzo6/e1NO0oDLXTkUx+rG9z1AisaznaZdon14EuNAZ1urREidLWnOp6iI8jDhztO6zzfM0FMgobm2XOxE1QjftMoCYd/w1RJSVrrTCzRobxxD+NfdtAb5jygSENT4vW8Zm6rmymnOcCJoMfv+QTwko4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com; spf=pass smtp.mailfrom=raptorengineering.com; dkim=pass (1024-bit key) header.d=raptorengineering.com header.i=@raptorengineering.com header.b=XaKZNXR5; arc=none smtp.client-ip=23.155.224.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raptorengineering.com
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 2BEF782887A2;
	Tue, 17 Jun 2025 23:23:20 -0500 (CDT)
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id MA41jKSfWApN; Tue, 17 Jun 2025 23:23:19 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 1A573828884A;
	Tue, 17 Jun 2025 23:23:19 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rptsys.com 1A573828884A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=raptorengineering.com; s=B8E824E6-0BE2-11E6-931D-288C65937AAD;
	t=1750220599; bh=fCsTSff5vaGDaT2BMduCiomdUgfjVArRaBm+jjoQMZY=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=XaKZNXR5jjouqXxbWzi3lVVT4s81rIwrLM0zXlb8mDmoxDQYVtOeWtKC9QOKHt5Nr
	 8R+Z/nXkMrHkhKCPy3DIwB9XNI2gECoW4ZOSGb8I33f2reQblsZff4ZAG9jBI7PQy5
	 2UowpXCzA0479QKLpx4D2UcCbNjKFVxIw11pwrjc=
X-Virus-Scanned: amavisd-new at rptsys.com
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ZTP6rVgH_RJk; Tue, 17 Jun 2025 23:23:18 -0500 (CDT)
Received: from vali.starlink.edu (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id E84B782887A2;
	Tue, 17 Jun 2025 23:23:18 -0500 (CDT)
Date: Tue, 17 Jun 2025 23:23:18 -0500 (CDT)
From: Timothy Pearson <tpearson@raptorengineering.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-pci <linux-pci@vger.kernel.org>, 
	Timothy Pearson <tpearson@raptorengineering.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, 
	christophe leroy <christophe.leroy@csgroup.eu>, 
	Naveen N Rao <naveen@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, 
	Shawn Anastasio <sanastasio@raptorengineering.com>
Message-ID: <1601775800.1309772.1750220598846.JavaMail.zimbra@raptorengineeringinc.com>
Subject: [PATCH 5/6] pci/hotplug/pnv_php: Fix surprise plug detection and
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.5.0_GA_3042 (ZimbraWebClient - GC137 (Linux)/8.5.0_GA_3042)
Thread-Index: qHjNaiRKXINBkueoTfScThdzuWuQAw==
Thread-Topic: pci/hotplug/pnv_php: Fix surprise plug detection and

 recovery

The existing PowerNV hotplug code did not handle suprise plug events
correctly, leading to a complete failure of the hotplug system after
device removal and a required reboot to detect new devices.

This comes down to three issues:
1.) When a device is suprise removed, oftentimes the bridge upstream
    port will cause a PE freeze on the PHB.  If this freeze is not
    cleared, the MSI interrupts from the bridge hotplug notification
    logic will not be received by the kernel, stalling all plug events
    on all slots associated with the PE.
2.) When a device is removed from a slot, regardless of suprise or
    programmatic removal, the associated PHB/PE ls left frozen.
    If this freeze is not cleared via a fundamental reset, skiboot
    is unable to clear the freeze and cannot retrain / rescan the
    slot.  This also requires a reboot to clear the freeze and redetect
    the device in the slot.
3.) When interrupts are disabled on a slot, we incorrectly disable the
    upstream slot interrupt along with the child port interrupts, causing
    future hotplug events on the slot to be lost.

Issue the appropriate unfreeze and rescan commands on hotplug events,
keep the upstream slot interrupts enabled on slot deactivation, and
don't oops on hotplug if pci_bus_to_OF_node() returns NULL.

Signed-off-by: Timothy Pearson <tpearson@raptorengineering.com>
---
 arch/powerpc/kernel/pci-hotplug.c |  3 ++
 drivers/pci/hotplug/pnv_php.c     | 71 +++++++++++++++++++++++++++++--
 2 files changed, 70 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/pci-hotplug.c b/arch/powerpc/kernel/pci-hotplug.c
index 9ea74973d78d..6f444d0822d8 100644
--- a/arch/powerpc/kernel/pci-hotplug.c
+++ b/arch/powerpc/kernel/pci-hotplug.c
@@ -141,6 +141,9 @@ void pci_hp_add_devices(struct pci_bus *bus)
 	struct pci_controller *phb;
 	struct device_node *dn = pci_bus_to_OF_node(bus);
 
+	if (!dn)
+		return;
+
 	phb = pci_bus_to_host(bus);
 
 	mode = PCI_PROBE_NORMAL;
diff --git a/drivers/pci/hotplug/pnv_php.c b/drivers/pci/hotplug/pnv_php.c
index 1a734adb5b10..32f26f0d1ca6 100644
--- a/drivers/pci/hotplug/pnv_php.c
+++ b/drivers/pci/hotplug/pnv_php.c
@@ -9,6 +9,7 @@
 #include <linux/libfdt.h>
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/delay.h>
 #include <linux/pci_hotplug.h>
 #include <linux/of_fdt.h>
 
@@ -473,7 +474,7 @@ static int pnv_php_enable(struct pnv_php_slot *php_slot, bool rescan)
 	struct hotplug_slot *slot = &php_slot->slot;
 	uint8_t presence = OPAL_PCI_SLOT_EMPTY;
 	uint8_t power_status = OPAL_PCI_SLOT_POWER_ON;
-	int ret;
+	int ret, i;
 
 	/* Check if the slot has been configured */
 	if (php_slot->state != PNV_PHP_STATE_REGISTERED)
@@ -531,6 +532,27 @@ static int pnv_php_enable(struct pnv_php_slot *php_slot, bool rescan)
 
 	/* Power is off, turn it on and then scan the slot */
 	ret = pnv_php_set_slot_power_state(slot, OPAL_PCI_SLOT_POWER_ON);
+	if (ret) {
+		SLOT_WARN(php_slot, "PCI slot activation failed with error code %d, possible frozen PHB", ret);
+		SLOT_WARN(php_slot, "Attempting complete PHB reset before retrying slot activation\n");
+		for (i = 0; i < 3; i++) {
+			/* Slot activation failed, PHB may be fenced from a prior device failure
+			 * Use the OPAL fundamental reset call to both try a device reset and clear
+			 * any potentially active PHB fence / freeze
+			 */
+			SLOT_WARN(php_slot, "Try %d...\n", i + 1);
+			pci_set_pcie_reset_state(php_slot->pdev, pcie_warm_reset);
+			msleep(250);
+			pci_set_pcie_reset_state(php_slot->pdev, pcie_deassert_reset);
+
+			ret = pnv_php_set_slot_power_state(slot, OPAL_PCI_SLOT_POWER_ON);
+			if (!ret)
+				break;
+		}
+
+		if (i >= 3)
+			SLOT_WARN(php_slot, "Failed to bring slot online, aborting!\n");
+	}
 	if (ret)
 		return ret;
 
@@ -625,6 +647,21 @@ static int pnv_php_disable_all_irqs(struct pci_bus *bus)
 	return 0;
 }
 
+/**
+ * Disable any hotplug interrupts for all downstream slots on the provided bus in
+ * preparation for a hot unplug.
+ */
+static int pnv_php_disable_all_downstream_irqs(struct pci_bus *bus)
+{
+	struct pci_bus *child_bus;
+
+	/* Go down child busses, recursively deactivating their IRQs */
+	list_for_each_entry(child_bus, &bus->children, node)
+		pnv_php_disable_all_irqs(child_bus);
+
+	return 0;
+}
+
 static int pnv_php_disable_slot(struct hotplug_slot *slot)
 {
 	struct pnv_php_slot *php_slot = to_pnv_php_slot(slot);
@@ -639,9 +676,11 @@ static int pnv_php_disable_slot(struct hotplug_slot *slot)
 	    php_slot->state != PNV_PHP_STATE_REGISTERED)
 		return 0;
 
-
-	/* Free all irq resources from slot and all child slots before remove */
-	pnv_php_disable_all_irqs(php_slot->bus);
+	/* Free all IRQ resources from all child slots before remove.
+	 * Note that we do not disable the root slot IRQ here as that
+	 * would also deactivate the slot hot (re)plug interrupt!
+	 */
+	pnv_php_disable_all_downstream_irqs(php_slot->bus);
 
 	/* Remove all devices behind the slot */
 	pci_lock_rescan_remove();
@@ -823,12 +862,36 @@ static void pnv_php_event_handler(struct work_struct *work)
 	struct pnv_php_event *event =
 		container_of(work, struct pnv_php_event, work);
 	struct pnv_php_slot *php_slot = event->php_slot;
+	struct pci_dev *pdev = php_slot->pdev;
+	struct eeh_dev *edev;
+	struct eeh_pe *pe;
+	int i;
 
 	if (event->added)
 		pnv_php_enable_slot(&php_slot->slot);
 	else
 		pnv_php_disable_slot(&php_slot->slot);
 
+	if (!event->added) {
+		/* When a device is surprise removed from a downstream bridge slot, the upstream bridge port
+		 * can still end up frozen due to related EEH events, which will in turn block the MSI interrupts
+		 * for slot hotplug detection.  Detect and thaw any frozen upstream PE after slot deactivation...
+		 */
+		edev = pci_dev_to_eeh_dev(pdev);
+		pe = edev ? edev->pe : NULL;
+		eeh_ops->get_state(pe, NULL);
+		if (pe->state & EEH_PE_ISOLATED) {
+			SLOT_WARN(php_slot, "Upstream bridge PE %02x frozen, thawing...\n", pe->addr);
+			for (i = 0; i < 3; i++)
+				if (!eeh_unfreeze_pe(pe))
+					break;
+			if (i >= 3)
+				SLOT_WARN(php_slot, "Unable to thaw PE %02x, hotplug detect will fail!\n", pe->addr);
+			else
+				SLOT_WARN(php_slot, "PE %02x thawed successfully\n", pe->addr);
+		}
+	}
+
 	kfree(event);
 }
 
-- 
2.39.5

