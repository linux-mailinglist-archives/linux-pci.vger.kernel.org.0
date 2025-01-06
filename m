Return-Path: <linux-pci+bounces-19329-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10EFBA02444
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jan 2025 12:27:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 885E9188562D
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jan 2025 11:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E7BF1D7E47;
	Mon,  6 Jan 2025 11:27:12 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [176.9.242.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62A21DA61E
	for <linux-pci@vger.kernel.org>; Mon,  6 Jan 2025 11:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736162832; cv=none; b=OmhbkefTxQ6/g1PyDBwglOkCixZhYV1JrUXZUj5AI8II3FRLHryl9qK4WBXoP2alVIyCqL3miapqzD457tS16vIQOWTrsiGdL5rEeXR96/pn2cZ1r0Pmg2T7+YA+HxS10nxB00joeWUE1Bk6WLoPjyc8Ak27yRT7C/b0/OjpPDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736162832; c=relaxed/simple;
	bh=0C5vOD/Zr9tmUplI+1nQcVPQnB7az+agtz0GhJDt0yQ=;
	h=Message-ID:From:Date:Subject:To:Cc; b=ewlKjlibWLtS6v7DQjv7caQYqwrFLEMnjnA1mNV3DDKUHcoISmmrQEGe6q8EBtsifYNT2wb+jNozpq37OOrfZywFaZ9kMyWRUsbXLuyxkDdYr00Op1jeH6X/YeqZgT0ZCbn+iztEh+wEgwc9q9hsPmFyWdgYXyYo1znQEX+jXM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=176.9.242.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by mailout3.hostsharing.net (Postfix) with ESMTPS id DB53A100B02DF;
	Mon,  6 Jan 2025 12:26:58 +0100 (CET)
Received: from localhost (unknown [89.246.108.87])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by h08.hostsharing.net (Postfix) with ESMTPSA id 91B336016F12;
	Mon,  6 Jan 2025 12:26:58 +0100 (CET)
X-Mailbox-Line: From ae2b02c9cfbefff475b6e132b0aa962aaccbd7b2 Mon Sep 17 00:00:00 2001
Message-ID: <ae2b02c9cfbefff475b6e132b0aa962aaccbd7b2.1736162539.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Mon, 6 Jan 2025 12:26:35 +0100
Subject: [PATCH for-linus v2] PCI/bwctrl: Fix NULL pointer deref on unbind and
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

Ilpo points out that the locking on unbind and bind needs to be symmetric,
so move the call to pcie_bwnotif_disable() inside the critical section
protected by pcie_bwctrl_setspeed_rwsem and pcie_bwctrl_lbms_rwsem.

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
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219629
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Tested-by: Evert Vorster <evorster@gmail.com>
---
Changes v1 -> v2 (in response to Ilpo's review):
 Move request_irq() inside critical section on bind.
 Move free_irq() + pcie_bwnotif_disable() inside critical section on unbind.
 Amend commit message with a paragraph explaining these changes.

 drivers/pci/pcie/bwctrl.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/pcie/bwctrl.c b/drivers/pci/pcie/bwctrl.c
index b59cacc740fa..0a5e7efbce2c 100644
--- a/drivers/pci/pcie/bwctrl.c
+++ b/drivers/pci/pcie/bwctrl.c
@@ -303,14 +303,17 @@ static int pcie_bwnotif_probe(struct pcie_device *srv)
 	if (ret)
 		return ret;
 
-	ret = devm_request_irq(&srv->device, srv->irq, pcie_bwnotif_irq,
-			       IRQF_SHARED, "PCIe bwctrl", srv);
-	if (ret)
-		return ret;
-
 	scoped_guard(rwsem_write, &pcie_bwctrl_setspeed_rwsem) {
 		scoped_guard(rwsem_write, &pcie_bwctrl_lbms_rwsem) {
-			port->link_bwctrl = no_free_ptr(data);
+			port->link_bwctrl = data;
+
+			ret = request_irq(srv->irq, pcie_bwnotif_irq,
+					  IRQF_SHARED, "PCIe bwctrl", srv);
+			if (ret) {
+				port->link_bwctrl = NULL;
+				return ret;
+			}
+
 			pcie_bwnotif_enable(srv);
 		}
 	}
@@ -331,11 +334,15 @@ static void pcie_bwnotif_remove(struct pcie_device *srv)
 
 	pcie_cooling_device_unregister(data->cdev);
 
-	pcie_bwnotif_disable(srv->port);
+	scoped_guard(rwsem_write, &pcie_bwctrl_setspeed_rwsem) {
+		scoped_guard(rwsem_write, &pcie_bwctrl_lbms_rwsem) {
+			pcie_bwnotif_disable(srv->port);
+
+			free_irq(srv->irq, srv);
 
-	scoped_guard(rwsem_write, &pcie_bwctrl_setspeed_rwsem)
-		scoped_guard(rwsem_write, &pcie_bwctrl_lbms_rwsem)
 			srv->port->link_bwctrl = NULL;
+		}
+	}
 }
 
 static int pcie_bwnotif_suspend(struct pcie_device *srv)
-- 
2.43.0


