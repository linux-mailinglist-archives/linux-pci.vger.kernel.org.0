Return-Path: <linux-pci+bounces-11017-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 707CA940F50
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jul 2024 12:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B38BB26D93
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jul 2024 10:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88078197A89;
	Tue, 30 Jul 2024 10:27:00 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [83.223.78.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE3A1993A4;
	Tue, 30 Jul 2024 10:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722335220; cv=none; b=emu5si1RqQx8KQkgBWXlrnXNd8xNJvfKP97IX9pbHQjRe3/eCF5jqrFsfox1HszJVtBnDvVABsRUAakYWHh0Hb6QW6HBlIolLiT04iXOBxzmjRPbYqPRroxPqbggPdoXD+6rg3UamvpBEHTRRnOmy/0G8sAHPPmSXpyq0mzeTJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722335220; c=relaxed/simple;
	bh=SeMhm/249KMHkoxDrL9fdexhBto+hEl1x7aVk0yhivc=;
	h=Message-ID:From:Date:Subject:MIME-Version:Content-Type:To:Cc; b=Hs5VAEl4mY3kTLIcNaOdPOm9Qbu8keYwihzvVMwZ1NLAcF4dNsj3fIkGzC8N0uhzyqfkDeyPzPGa1UWrrJnrKAauKSzrV+sBMB+Ltq2D4scPuuMarHGDvwR7eWHw+I9EseQDXER55Q61xPkQVbkfsXUh0jD4dwdKzjyTInUf+Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.78.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by mailout2.hostsharing.net (Postfix) with ESMTPS id BC76110189E0F;
	Tue, 30 Jul 2024 12:26:55 +0200 (CEST)
Received: from localhost (unknown [89.246.108.87])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by h08.hostsharing.net (Postfix) with ESMTPSA id 8E4A460FA4AF;
	Tue, 30 Jul 2024 12:26:55 +0200 (CEST)
X-Mailbox-Line: From 4d4ac43578f9aad9d7eee85a51833ae5e4b7cdb3 Mon Sep 17 00:00:00 2001
Message-ID: <4d4ac43578f9aad9d7eee85a51833ae5e4b7cdb3.1722335040.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Tue, 30 Jul 2024 12:26:55 +0200
Subject: [PATCH 5.10-stable] PCI/DPC: Fix use-after-free on concurrent DPC and
 hot-removal
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, linux-pci@vger.kernel.org, Keith Busch <kbusch@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Bjorn Helgaas <helgaas@kernel.org>, Krzysztof Wilczynski <kwilczynski@kernel.org>

commit 11a1f4bc47362700fcbde717292158873fb847ed upstream.

Keith reports a use-after-free when a DPC event occurs concurrently to
hot-removal of the same portion of the hierarchy:

The dpc_handler() awaits readiness of the secondary bus below the
Downstream Port where the DPC event occurred.  To do so, it polls the
config space of the first child device on the secondary bus.  If that
child device is concurrently removed, accesses to its struct pci_dev
cause the kernel to oops.

That's because pci_bridge_wait_for_secondary_bus() neglects to hold a
reference on the child device.  Before v6.3, the function was only
called on resume from system sleep or on runtime resume.  Holding a
reference wasn't necessary back then because the pciehp IRQ thread
could never run concurrently.  (On resume from system sleep, IRQs are
not enabled until after the resume_noirq phase.  And runtime resume is
always awaited before a PCI device is removed.)

However starting with v6.3, pci_bridge_wait_for_secondary_bus() is also
called on a DPC event.  Commit 53b54ad074de ("PCI/DPC: Await readiness
of secondary bus after reset"), which introduced that, failed to
appreciate that pci_bridge_wait_for_secondary_bus() now needs to hold a
reference on the child device because dpc_handler() and pciehp may
indeed run concurrently.  The commit was backported to v5.10+ stable
kernels, so that's the oldest one affected.

Add the missing reference acquisition.

Abridged stack trace:

  BUG: unable to handle page fault for address: 00000000091400c0
  CPU: 15 PID: 2464 Comm: irq/53-pcie-dpc 6.9.0
  RIP: pci_bus_read_config_dword+0x17/0x50
  pci_dev_wait()
  pci_bridge_wait_for_secondary_bus()
  dpc_reset_link()
  pcie_do_recovery()
  dpc_handler()

Fixes: 53b54ad074de ("PCI/DPC: Await readiness of secondary bus after reset")
Closes: https://lore.kernel.org/r/20240612181625.3604512-3-kbusch@meta.com/
Link: https://lore.kernel.org/linux-pci/8e4bcd4116fd94f592f2bf2749f168099c480ddf.1718707743.git.lukas@wunner.de
Reported-by: Keith Busch <kbusch@kernel.org>
Tested-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: stable@vger.kernel.org # v5.10+
---
 drivers/pci/pci.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 530ced8f7abd..09d5fa637b98 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4817,7 +4817,7 @@ int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type,
 				      int timeout)
 {
 	struct pci_dev *child;
-	int delay;
+	int delay, ret = 0;
 
 	if (pci_dev_is_disconnected(dev))
 		return 0;
@@ -4845,8 +4845,8 @@ int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type,
 		return 0;
 	}
 
-	child = list_first_entry(&dev->subordinate->devices, struct pci_dev,
-				 bus_list);
+	child = pci_dev_get(list_first_entry(&dev->subordinate->devices,
+					     struct pci_dev, bus_list));
 	up_read(&pci_bus_sem);
 
 	/*
@@ -4856,7 +4856,7 @@ int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type,
 	if (!pci_is_pcie(dev)) {
 		pci_dbg(dev, "waiting %d ms for secondary bus\n", 1000 + delay);
 		msleep(1000 + delay);
-		return 0;
+		goto put_child;
 	}
 
 	/*
@@ -4877,7 +4877,7 @@ int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type,
 	 * until the timeout expires.
 	 */
 	if (!pcie_downstream_port(dev))
-		return 0;
+		goto put_child;
 
 	if (pcie_get_speed_cap(dev) <= PCIE_SPEED_5_0GT) {
 		pci_dbg(dev, "waiting %d ms for downstream link\n", delay);
@@ -4888,11 +4888,16 @@ int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type,
 		if (!pcie_wait_for_link_delay(dev, true, delay)) {
 			/* Did not train, no need to wait any further */
 			pci_info(dev, "Data Link Layer Link Active not set in 1000 msec\n");
-			return -ENOTTY;
+			ret = -ENOTTY;
+			goto put_child;
 		}
 	}
 
-	return pci_dev_wait(child, reset_type, timeout - delay);
+	ret = pci_dev_wait(child, reset_type, timeout - delay);
+
+put_child:
+	pci_dev_put(child);
+	return ret;
 }
 
 void pci_reset_secondary_bus(struct pci_dev *dev)
-- 
2.43.0


