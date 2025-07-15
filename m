Return-Path: <linux-pci+bounces-32194-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF66B068A0
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 23:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 637F81AA648D
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 21:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 482C32C08A0;
	Tue, 15 Jul 2025 21:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=raptorengineering.com header.i=@raptorengineering.com header.b="cpAhd5YB"
X-Original-To: linux-pci@vger.kernel.org
Received: from raptorengineering.com (mail.raptorengineering.com [23.155.224.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1399924DCEC;
	Tue, 15 Jul 2025 21:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.155.224.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752615373; cv=none; b=TgtWhvDkQyg39OVS7+J1Fj/SAhHKw7bTvLeuQ+fyxMNx1kGZFqaq2zv490ZBF1pfDGHkoUXbbcuPtpopOKFY8hfTzUZHyPazBz7EfF0/OJYuP9CNMpsN504CO8Vw6OKGMgjJlpipInM+LNkgXBrMyGdN08PXKXkz7lWmLJdgGrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752615373; c=relaxed/simple;
	bh=cooPlAxjCzZeTlVy0Pk0w5jF9nmdibY3JwXPQ8KXd30=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=Nr7WQm4z1wPKH16Rugq+In2OFZXPsMJCtiNUh3pDotAVpdCga764EnSHAEfUPMkrCIBP/Hr+xXWNdJTJnnWYtd0Rsi96oPqm6KpQghgCwj6kSb5QPbScuz8uHfbMH75C1cWeJkuOPtJCLcmNdFXPureIQkrbBtiPeUuQYyX4rjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com; spf=pass smtp.mailfrom=raptorengineering.com; dkim=pass (1024-bit key) header.d=raptorengineering.com header.i=@raptorengineering.com header.b=cpAhd5YB; arc=none smtp.client-ip=23.155.224.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raptorengineering.com
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 1F6A8828832E;
	Tue, 15 Jul 2025 16:36:10 -0500 (CDT)
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id A1hSnC2-OLw1; Tue, 15 Jul 2025 16:36:08 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 39FCD8288591;
	Tue, 15 Jul 2025 16:36:08 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rptsys.com 39FCD8288591
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=raptorengineering.com; s=B8E824E6-0BE2-11E6-931D-288C65937AAD;
	t=1752615368; bh=fkGDCdBQx8jgAUOYnnBb2gotGMbzdN6Ov873STtMQvs=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=cpAhd5YBB01yCpsWaZdCkhcsVPE1PAhHGANTJ4adXp4AyGK9JWDYkZmbNiZrKYswb
	 G/wMZghOhryG1xlygGR9RzeCID8vyKTKuSYwRobbufezIqE4P3saEtG16Xg7HY+b4r
	 v4LIbhNikk5xUp0TwRMxDcIxecWFw97DZ2QQ6dcM=
X-Virus-Scanned: amavisd-new at rptsys.com
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id xX_LOiZ2uwh4; Tue, 15 Jul 2025 16:36:08 -0500 (CDT)
Received: from vali.starlink.edu (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id ECC71828832E;
	Tue, 15 Jul 2025 16:36:07 -0500 (CDT)
Date: Tue, 15 Jul 2025 16:36:07 -0500 (CDT)
From: Timothy Pearson <tpearson@raptorengineering.com>
To: Timothy Pearson <tpearson@raptorengineering.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-pci <linux-pci@vger.kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, 
	christophe leroy <christophe.leroy@csgroup.eu>, 
	Naveen N Rao <naveen@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, 
	Shawn Anastasio <sanastasio@raptorengineering.com>
Message-ID: <2013845045.1359852.1752615367790.JavaMail.zimbra@raptorengineeringinc.com>
In-Reply-To: <1268570622.1359844.1752615109932.JavaMail.zimbra@raptorengineeringinc.com>
References: <1268570622.1359844.1752615109932.JavaMail.zimbra@raptorengineeringinc.com>
Subject: [PATCH v3 1/6] PCI: pnv_php: Properly clean up allocated IRQs on
 unplug
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.5.0_GA_3042 (ZimbraWebClient - GC138 (Linux)/8.5.0_GA_3042)
Thread-Topic: pnv_php: Properly clean up allocated IRQs on unplug
Thread-Index: XyF2OaMn/3q+H+nwsGaxXLVF4U4PF4ckTqwo

In cases where the root of a nested PCIe bridge configuration is
unplugged, the pnv_php driver would leak the allocated IRQ resources for
the child bridges' hotplug event notifications, resulting in a panic.
Fix this by walking all child buses and deallocating all it's IRQ
resources before calling pci_hp_remove_devices.

Also modify the lifetime of the workqueue at struct pnv_php_slot::wq so
that it is only destroyed in pnv_php_free_slot, instead of
pnv_php_disable_irq. This is required since pnv_php_disable_irq will now
be called by workers triggered by hot unplug interrupts, so the
workqueue needs to stay allocated.

The abridged kernel panic that occurs without this patch is as follows:

  WARNING: CPU: 0 PID: 687 at kernel/irq/msi.c:292 msi_device_data_release+0x6c/0x9c
  CPU: 0 UID: 0 PID: 687 Comm: bash Not tainted 6.14.0-rc5+ #2
  Call Trace:
   msi_device_data_release+0x34/0x9c (unreliable)
   release_nodes+0x64/0x13c
   devres_release_all+0xc0/0x140
   device_del+0x2d4/0x46c
   pci_destroy_dev+0x5c/0x194
   pci_hp_remove_devices+0x90/0x128
   pci_hp_remove_devices+0x44/0x128
   pnv_php_disable_slot+0x54/0xd4
   power_write_file+0xf8/0x18c
   pci_slot_attr_store+0x40/0x5c
   sysfs_kf_write+0x64/0x78
   kernfs_fop_write_iter+0x1b0/0x290
   vfs_write+0x3bc/0x50c
   ksys_write+0x84/0x140
   system_call_exception+0x124/0x230
   system_call_vectored_common+0x15c/0x2ec

Signed-off-by: Shawn Anastasio <sanastasio@raptorengineering.com>
Signed-off-by: Timothy Pearson <tpearson@raptorengineering.com>
---
 drivers/pci/hotplug/pnv_php.c | 94 ++++++++++++++++++++++++++++-------
 1 file changed, 75 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/hotplug/pnv_php.c b/drivers/pci/hotplug/pnv_php.c
index 573a41869c15..aec0a6d594ac 100644
--- a/drivers/pci/hotplug/pnv_php.c
+++ b/drivers/pci/hotplug/pnv_php.c
@@ -3,6 +3,7 @@
  * PCI Hotplug Driver for PowerPC PowerNV platform.
  *
  * Copyright Gavin Shan, IBM Corporation 2016.
+ * Copyright (C) 2025 Raptor Engineering, LLC
  */
 
 #include <linux/bitfield.h>
@@ -36,8 +37,10 @@ static void pnv_php_register(struct device_node *dn);
 static void pnv_php_unregister_one(struct device_node *dn);
 static void pnv_php_unregister(struct device_node *dn);
 
+static void pnv_php_enable_irq(struct pnv_php_slot *php_slot);
+
 static void pnv_php_disable_irq(struct pnv_php_slot *php_slot,
-				bool disable_device)
+				bool disable_device, bool disable_msi)
 {
 	struct pci_dev *pdev = php_slot->pdev;
 	u16 ctrl;
@@ -53,19 +56,15 @@ static void pnv_php_disable_irq(struct pnv_php_slot *php_slot,
 		php_slot->irq = 0;
 	}
 
-	if (php_slot->wq) {
-		destroy_workqueue(php_slot->wq);
-		php_slot->wq = NULL;
-	}
-
-	if (disable_device) {
+	if (disable_device || disable_msi) {
 		if (pdev->msix_enabled)
 			pci_disable_msix(pdev);
 		else if (pdev->msi_enabled)
 			pci_disable_msi(pdev);
+	}
 
+	if (disable_device)
 		pci_disable_device(pdev);
-	}
 }
 
 static void pnv_php_free_slot(struct kref *kref)
@@ -74,7 +73,8 @@ static void pnv_php_free_slot(struct kref *kref)
 					struct pnv_php_slot, kref);
 
 	WARN_ON(!list_empty(&php_slot->children));
-	pnv_php_disable_irq(php_slot, false);
+	pnv_php_disable_irq(php_slot, false, false);
+	destroy_workqueue(php_slot->wq);
 	kfree(php_slot->name);
 	kfree(php_slot);
 }
@@ -561,8 +561,57 @@ static int pnv_php_reset_slot(struct hotplug_slot *slot, bool probe)
 static int pnv_php_enable_slot(struct hotplug_slot *slot)
 {
 	struct pnv_php_slot *php_slot = to_pnv_php_slot(slot);
+	u32 prop32;
+	int ret;
+
+	ret = pnv_php_enable(php_slot, true);
+	if (ret)
+		return ret;
+
+	/* (Re-)enable interrupt if the slot supports surprise hotplug */
+	ret = of_property_read_u32(php_slot->dn, "ibm,slot-surprise-pluggable", &prop32);
+	if (!ret && prop32)
+		pnv_php_enable_irq(php_slot);
+
+	return 0;
+}
+
+/**
+ * Disable any hotplug interrupts for all slots on the provided bus, as well as
+ * all downstream slots in preparation for a hot unplug.
+ */
+static int pnv_php_disable_all_irqs(struct pci_bus *bus)
+{
+	struct pci_bus *child_bus;
+	struct pci_slot *cur_slot;
+
+	/* First go down child busses */
+	list_for_each_entry(child_bus, &bus->children, node)
+		pnv_php_disable_all_irqs(child_bus);
+
+	/* Disable IRQs for all pnv_php slots on this bus */
+	list_for_each_entry(cur_slot, &bus->slots, list) {
+		struct pnv_php_slot *php_slot = to_pnv_php_slot(cur_slot->hotplug);
+
+		pnv_php_disable_irq(php_slot, false, true);
+	}
 
-	return pnv_php_enable(php_slot, true);
+	return 0;
+}
+
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
 }
 
 static int pnv_php_disable_slot(struct hotplug_slot *slot)
@@ -579,6 +628,12 @@ static int pnv_php_disable_slot(struct hotplug_slot *slot)
 	    php_slot->state != PNV_PHP_STATE_REGISTERED)
 		return 0;
 
+	/* Free all IRQ resources from all child slots before remove.
+	 * Note that we do not disable the root slot IRQ here as that
+	 * would also deactivate the slot hot (re)plug interrupt!
+	 */
+	pnv_php_disable_all_downstream_irqs(php_slot->bus);
+
 	/* Remove all devices behind the slot */
 	pci_lock_rescan_remove();
 	pci_hp_remove_devices(php_slot->bus);
@@ -647,6 +702,15 @@ static struct pnv_php_slot *pnv_php_alloc_slot(struct device_node *dn)
 		return NULL;
 	}
 
+	/* Allocate workqueue for this slot's interrupt handling */
+	php_slot->wq = alloc_workqueue("pciehp-%s", 0, 0, php_slot->name);
+	if (!php_slot->wq) {
+		SLOT_WARN(php_slot, "Cannot alloc workqueue\n");
+		kfree(php_slot->name);
+		kfree(php_slot);
+		return NULL;
+	}
+
 	if (dn->child && PCI_DN(dn->child))
 		php_slot->slot_no = PCI_SLOT(PCI_DN(dn->child)->devfn);
 	else
@@ -843,14 +907,6 @@ static void pnv_php_init_irq(struct pnv_php_slot *php_slot, int irq)
 	u16 sts, ctrl;
 	int ret;
 
-	/* Allocate workqueue */
-	php_slot->wq = alloc_workqueue("pciehp-%s", 0, 0, php_slot->name);
-	if (!php_slot->wq) {
-		SLOT_WARN(php_slot, "Cannot alloc workqueue\n");
-		pnv_php_disable_irq(php_slot, true);
-		return;
-	}
-
 	/* Check PDC (Presence Detection Change) is broken or not */
 	ret = of_property_read_u32(php_slot->dn, "ibm,slot-broken-pdc",
 				   &broken_pdc);
@@ -869,7 +925,7 @@ static void pnv_php_init_irq(struct pnv_php_slot *php_slot, int irq)
 	ret = request_irq(irq, pnv_php_interrupt, IRQF_SHARED,
 			  php_slot->name, php_slot);
 	if (ret) {
-		pnv_php_disable_irq(php_slot, true);
+		pnv_php_disable_irq(php_slot, true, true);
 		SLOT_WARN(php_slot, "Error %d enabling IRQ %d\n", ret, irq);
 		return;
 	}
-- 
2.39.5


