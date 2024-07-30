Return-Path: <linux-pci+bounces-11012-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B851940DC8
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jul 2024 11:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C3031C24712
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jul 2024 09:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A32188CC7;
	Tue, 30 Jul 2024 09:33:50 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [83.223.95.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD45194C74;
	Tue, 30 Jul 2024 09:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722332030; cv=none; b=nn/eWwovTGTfQiexXxuO208LDrhRnu/uON36kCIEjgoIXfcDcCunWHfC+UoZDzEUL2a81fF2THe28/0bRYPyYOUa4m/rXigdywHGGDYWU0LlbTUzZQfQkYDoeu02TYvXO//fYiZuOxAOy0rBO2Yvrcz3njHg2O/YN4yqUzPir14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722332030; c=relaxed/simple;
	bh=Py7kgMu5Vo6OlyeDe9hGpIVQRpTxlU/M7Nq4TrnOK84=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=VAIHhrpJXYBEdN9ptBlAtD4Wsh8BLLnRdYNHRMmi9tTSizGfyhuhQZCPI564/GcwTG4E6HmRnO1eDFE52rHltEV13UNQ0Tm8McaS/tdy3rYAEASdDGRFnmeOtRgXaG1sGCjCHoTo1Rp8HlqER0Re/fYt0ziv+n5pRrX8C+FiODM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.95.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by mailout1.hostsharing.net (Postfix) with ESMTPS id 17E7A101917AC;
	Tue, 30 Jul 2024 11:33:46 +0200 (CEST)
Received: from localhost (unknown [89.246.108.87])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by h08.hostsharing.net (Postfix) with ESMTPSA id EC957603B5E6;
	Tue, 30 Jul 2024 11:33:45 +0200 (CEST)
X-Mailbox-Line: From 80238397248048b05cd7f738a74f3fe97ff84f69 Mon Sep 17 00:00:00 2001
Message-ID: <80238397248048b05cd7f738a74f3fe97ff84f69.1722331565.git.lukas@wunner.de>
In-Reply-To: <3c1751533b20c5ece6ff2296c1d79ac7580200a0.1722331565.git.lukas@wunner.de>
References: <3c1751533b20c5ece6ff2296c1d79ac7580200a0.1722331565.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Tue, 30 Jul 2024 11:30:53 +0200
Subject: [PATCH 5.10-stable 3/3] PCI/DPC: Fix use-after-free on concurrent DPC
 and hot-removal
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, linux-pci@vger.kernel.org, Keith Busch <kbusch@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Bjorn Helgaas <helgaas@kernel.org>, Krzysztof Wilczynski <kwilczynski@kernel.org>, Ira Weiny <ira.weiny@intel.com>, Peter Zijlstra <peterz@infradead.org>

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
 drivers/pci/pci.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 530ced8f7abd..5fa626589b90 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4816,7 +4816,7 @@ static int pci_bus_max_d3cold_delay(const struct pci_bus *bus)
 int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type,
 				      int timeout)
 {
-	struct pci_dev *child;
+	struct pci_dev *child __free(pci_dev_put) = NULL;
 	int delay;
 
 	if (pci_dev_is_disconnected(dev))
@@ -4845,8 +4845,8 @@ int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type,
 		return 0;
 	}
 
-	child = list_first_entry(&dev->subordinate->devices, struct pci_dev,
-				 bus_list);
+	child = pci_dev_get(list_first_entry(&dev->subordinate->devices,
+					     struct pci_dev, bus_list));
 	up_read(&pci_bus_sem);
 
 	/*
-- 
2.43.0


