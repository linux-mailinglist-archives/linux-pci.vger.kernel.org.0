Return-Path: <linux-pci+bounces-19186-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24420A00086
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jan 2025 22:21:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFFA516119F
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jan 2025 21:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB251B85D2;
	Thu,  2 Jan 2025 21:21:17 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179B91B86F7
	for <linux-pci@vger.kernel.org>; Thu,  2 Jan 2025 21:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735852877; cv=none; b=Sc5M38pAxTFVFTfz+aQcduMbJRVOLvX758oqDz0sXU7C4/z63/QWg4WfvgPeeCThBaAGXJv0xuKJ+7jkAK7y3DbK7hBOaOs/SOXUJRUfGqirD4LKUd+r5qQ09jX/FsV303PxClmdHlaj1x4DqBT5UMeQER6L5vWRLmaFrSuQvlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735852877; c=relaxed/simple;
	bh=iqbmDks2m7yzyu3MDFjlWRR+3NLVbyGZOiGGyMFPAgE=;
	h=Message-Id:From:Date:Subject:To:Cc; b=k6S7miTZseFi0CzAGUH/Mwb3QY3dmoa+GKGvVdg4Q7kFjYXnhSgDVuZ7xc9vbCLE/9rLVP//Bf6prry1qpM4wl/lCso+xKRwvUvCHPZkzNftUE4x5fI3CV0ggheMQcFN1UHsp2xOBNmrFHz0wtbykRaGG7Dg5x+kzU3vAPoJqqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 6DDE7101EE842;
	Thu,  2 Jan 2025 22:21:05 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 52C6D4E03ED; Thu,  2 Jan 2025 22:21:05 +0100 (CET)
Message-Id: <0ee5faf5395cad8d29fb66e1ec444c8d882a4201.1735852688.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Thu, 2 Jan 2025 22:20:35 +0100
Subject: [PATCH for-linus] PCI/bwctrl: Fix NULL pointer deref on unbind and
 bind
To: Bjorn Helgaas <helgaas@kernel.org>, Krzysztof Wilczynski <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org, Niklas Schnelle <niks@kernel.org>, Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, "Maciej W. Rozycki" <macro@orcam.me.uk>, Mario Limonciello <mario.limonciello@amd.com>, Evert Vorster <evorster@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

The interrupt handler for bandwidth notifications, pcie_bwnotif_irq(),
dereferences a "data" pointer.

On unbind, that pointer is set to NULL by pcie_bwnotif_remove().  However
the interrupt handler may still be invoked afterwards and will dereference
that NULL pointer.

That's because the interrupt is requested using a devm_*() helper and the
driver core releases devm_*() resources *after* calling ->remove().

pcie_bwnotif_remove() does clear the Link Bandwidth Management Interrupt
Enable and Link Autonomous Bandwidth Interrupt Enable bits in the Link
Control Register, but that won't prevent execution of pcie_bwnotif_irq():
The interrupt for bandwidth notifications may be shared with AER, DPC,
PME, and hotplug.  So pcie_bwnotif_irq() may be executed as long as the
interrupt is requested.

There's a similar race on bind:  pcie_bwnotif_probe() requests the
interrupt when the "data" pointer still points to NULL.  A NULL pointer
deref may thus likewise occur if AER, DPC, PME or hotplug raise an
interrupt in-between the bandwidth controller's call to devm_request_irq()
and assignment of the "data" pointer.

Drop the devm_*() usage and reorder requesting of the interrupt to fix the
issue.

While at it, drop a stray but harmless no_free_ptr() invocation when
assigning the "data" pointer in pcie_bwnotif_probe().

Evert reports a hang on shutdown of an ASUS ROG Strix SCAR 17 G733PYV.
The issue is no longer reproducible with the present commit.

Evert found that attaching a USB-C monitor prevented the hang.  The
machine contains an ASMedia USB 3.2 controller below a hotplug-capable
Root Port.  So one possible explanation is that the controller gets
hot-removed on shutdown unless something is connected.  And the ensuing
hotplug interrupt occurs exactly when the bandwidth controller is
unregistering.  The precise cause could not be determined because the
screen had already turned black when the hang occurred.

Fixes: 665745f27487 ("PCI/bwctrl: Re-add BW notification portdrv as PCIe BW controller")
Reported-by: Evert Vorster <evorster@gmail.com>
Tested-by: Evert Vorster <evorster@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219629
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/pci/pcie/bwctrl.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/pcie/bwctrl.c b/drivers/pci/pcie/bwctrl.c
index b59cacc..7cd8211 100644
--- a/drivers/pci/pcie/bwctrl.c
+++ b/drivers/pci/pcie/bwctrl.c
@@ -303,17 +303,18 @@ static int pcie_bwnotif_probe(struct pcie_device *srv)
 	if (ret)
 		return ret;
 
-	ret = devm_request_irq(&srv->device, srv->irq, pcie_bwnotif_irq,
-			       IRQF_SHARED, "PCIe bwctrl", srv);
+	scoped_guard(rwsem_write, &pcie_bwctrl_setspeed_rwsem)
+		scoped_guard(rwsem_write, &pcie_bwctrl_lbms_rwsem)
+			port->link_bwctrl = data;
+
+	ret = request_irq(srv->irq, pcie_bwnotif_irq, IRQF_SHARED,
+			  "PCIe bwctrl", srv);
 	if (ret)
-		return ret;
+		goto err_reset_data;
 
-	scoped_guard(rwsem_write, &pcie_bwctrl_setspeed_rwsem) {
-		scoped_guard(rwsem_write, &pcie_bwctrl_lbms_rwsem) {
-			port->link_bwctrl = no_free_ptr(data);
+	scoped_guard(rwsem_write, &pcie_bwctrl_setspeed_rwsem)
+		scoped_guard(rwsem_write, &pcie_bwctrl_lbms_rwsem)
 			pcie_bwnotif_enable(srv);
-		}
-	}
 
 	pci_dbg(port, "enabled with IRQ %d\n", srv->irq);
 
@@ -323,6 +324,12 @@ static int pcie_bwnotif_probe(struct pcie_device *srv)
 		port->link_bwctrl->cdev = NULL;
 
 	return 0;
+
+err_reset_data:
+	scoped_guard(rwsem_write, &pcie_bwctrl_setspeed_rwsem)
+		scoped_guard(rwsem_write, &pcie_bwctrl_lbms_rwsem)
+			port->link_bwctrl = NULL;
+	return ret;
 }
 
 static void pcie_bwnotif_remove(struct pcie_device *srv)
@@ -333,6 +340,8 @@ static void pcie_bwnotif_remove(struct pcie_device *srv)
 
 	pcie_bwnotif_disable(srv->port);
 
+	free_irq(srv->irq, srv);
+
 	scoped_guard(rwsem_write, &pcie_bwctrl_setspeed_rwsem)
 		scoped_guard(rwsem_write, &pcie_bwctrl_lbms_rwsem)
 			srv->port->link_bwctrl = NULL;
-- 
2.43.0


