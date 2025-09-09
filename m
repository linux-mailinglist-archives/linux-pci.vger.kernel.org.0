Return-Path: <linux-pci+bounces-35749-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCA1CB50297
	for <lists+linux-pci@lfdr.de>; Tue,  9 Sep 2025 18:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D323189A3CE
	for <lists+linux-pci@lfdr.de>; Tue,  9 Sep 2025 16:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2468353341;
	Tue,  9 Sep 2025 16:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ZWNvoLZe";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="HoIMFsee"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C87352FD0;
	Tue,  9 Sep 2025 16:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757435255; cv=none; b=N3uh58opH3vJz8uUPz+OWjySToo0V5+V9Ai0yFUhdvfenZNC/jmuxtUdAsNU3SQe+DUsD0uJ/WLYkJO4p77pGvZvpwrJViA2cjQJPmeV39XtO3gHBDH0IqldTP1ptTgDHnwfFWYm+UXqVAWg7dutOJ0viZOHStg9c8JjDahUBS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757435255; c=relaxed/simple;
	bh=DYvgbpVeZXZ6/fOkKGUKsS/zmQa+67z9PePns+8rPmU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lI5seBcczQsdL2BzsMhSSzveq22adWiQJ64mOd/9wwzLG8XZIv5NN0sDFfkOzpAjUkF8d9ZB5k//pNdehRIcQTL4/gnxexggB/dCIEawjQzm9Ed80DyQOv81iTPACQ7kfZOdvi70zOe9BY3U9G4IXCkgLBE7qXfSeI2Q6QEiBko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=ZWNvoLZe; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=HoIMFsee; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4cLq3l2QBzz9tDp;
	Tue,  9 Sep 2025 18:27:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1757435251;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qrJY0CwQrGpokThx28B+z72uq+klbWOH2rdh4qGj/g0=;
	b=ZWNvoLZeADqrvefVJbHkxohM4x/15tdwpTrqywcPpUp8WXqavwsLX5+5HR317ILcyhgekC
	38LzZIfv4s6MGw1JwL2czO5EuW1ZbPKLTNfrxydFcGPyelOL/LqhseKoVfL/7hI9Uz0EJ0
	suaxFyvkopAlSNvQlu3JwAuZDI7LrcEbAAg2qecW4Cu9xxhQ64528MalbybfVyzSjd7sT9
	XpIIBzm37z2gcfDUiWlyRFZGN5I6vE8Qnh4zpQZYjlo1+tMEHZR4B4sdAxxeJ+9oZNd7Xg
	sjitxptKHzbdVQxRR+4cJOoO+ctmOOE3vDYUrKj9qoY70sEFDvNgSZk6Sby+XA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1757435249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qrJY0CwQrGpokThx28B+z72uq+klbWOH2rdh4qGj/g0=;
	b=HoIMFseefYSxp/WGXQX+IbuknMg9nzBWBtSxYn0xRKcEkHBYcgvooCpOosguIGC+5pKm5l
	vgCYxDvl4lvMWcZttJT5XSwODwOrNVg2haSvYg+4ivuDeE8gvU2x1bnEvepy71IypTlCa0
	MHgcDCuVSwjEw8OQk3x03xYAICr3R6iIRIg3AZZkWM64aPJdFxY0MPli3l9N5oVVdNtRIA
	hN12xjZef40SGzB78PpQlQOWLyIU12NzSXHpnr8dCUIztOlzu5P3kTRvmaWxt0QTRpZnXK
	uoiBDsNLVuRPviQGBkTzzCqh+V0x4/vBid0Od4T9lffPkqsH2/MqFd9eH9KnJA==
To: linux-pci@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Duy Nguyen <duy.nguyen.rh@renesas.com>,
	Thuan Nguyen <thuan.nguyen-hong@banvien.com.vn>,
	stable@vger.kernel.org,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH 2/2] PCI: rcar-host: Convert struct rcar_msi mask_lock into raw spinlock
Date: Tue,  9 Sep 2025 18:26:25 +0200
Message-ID: <20250909162707.13927-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250909162707.13927-1-marek.vasut+renesas@mailbox.org>
References: <20250909162707.13927-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 9c6651d71222ac77325
X-MBO-RS-META: kumgsuncs79ex4qu1e1tabzt3wazn3i9

The rcar_msi_irq_unmask() function may be called from a PCI driver
request_threaded_irq() function. This triggers kernel/irq/manage.c
__setup_irq() which locks raw spinlock &desc->lock descriptor lock
and with that descriptor lock held, calls rcar_msi_irq_unmask().

Since the &desc->lock descriptor lock is a raw spinlock , and the
rcar_msi .mask_lock is not a raw spinlock, this setup triggers
'BUG: Invalid wait context' with CONFIG_PROVE_RAW_LOCK_NESTING=y .

Use scoped_guard() to simplify the locking.

Fixes: 83ed8d4fa656 ("PCI: rcar: Convert to MSI domains")
Reported-by: Duy Nguyen <duy.nguyen.rh@renesas.com>
Reported-by: Thuan Nguyen <thuan.nguyen-hong@banvien.com.vn>
Cc: stable@vger.kernel.org
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
=============================
[ BUG: Invalid wait context ]
6.17.0-rc4-next-20250905-00049-g13b74d3367a3-dirty #1117 Not tainted
-----------------------------
swapper/0/1 is trying to lock:
ffffff84c1974e58 (&msi->mask_lock){....}-{3:3}, at: rcar_msi_irq_unmask+0x28/0x70
other info that might help us debug this:
context-{5:5}
6 locks held by swapper/0/1:
 #0: ffffff84c0e0d0f8 (&dev->mutex){....}-{4:4}, at: device_lock+0x14/0x1c
 #1: ffffffc0817675b0 (pci_rescan_remove_lock){+.+.}-{4:4}, at: pci_lock_rescan_remove+0x18/0x20
 #2: ffffff84c2a691b0 (&dev->mutex){....}-{4:4}, at: device_lock+0x14/0x1c
 #3: ffffff84c1976108 (&dev->mutex){....}-{4:4}, at: device_lock+0x14/0x1c
 #4: ffffff84c2a71640 (&desc->request_mutex){+.+.}-{4:4}, at: __setup_irq+0xa4/0x5bc
 #5: ffffff84c2a714c8 (&irq_desc_lock_class){....}-{2:2}, at: __setup_irq+0x230/0x5bc
stack backtrace:
CPU: 1 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.17.0-rc4-next-20250905-00049-g13b74d3367a3-dirty #1117 PREEMPT
Hardware name: Renesas Salvator-X 2nd version board based on r8a77951 (DT)
Call trace:
 dump_backtrace+0x6c/0x7c (C)
 show_stack+0x14/0x1c
 dump_stack_lvl+0x68/0x8c
 dump_stack+0x14/0x1c
 __lock_acquire+0x3e8/0x1064
 lock_acquire+0x17c/0x2ac
 _raw_spin_lock_irqsave+0x54/0x70
 rcar_msi_irq_unmask+0x28/0x70
 irq_chip_unmask_parent+0x18/0x20
 cond_startup_parent+0x40/0x44
 pci_irq_startup_msi+0x20/0x58
 __irq_startup+0x34/0x84
 irq_startup+0x64/0x114
 __setup_irq+0x3f8/0x5bc
 request_threaded_irq+0x11c/0x148
 pcie_pme_probe+0xec/0x190
 pcie_port_probe_service+0x34/0x5c
 really_probe+0x190/0x350
 __driver_probe_device+0x120/0x138
 driver_probe_device+0x38/0xec
 __device_attach_driver+0x100/0x114
 bus_for_each_drv+0xa8/0xd0
 __device_attach+0xdc/0x15c
 device_initial_probe+0x10/0x18
 bus_probe_device+0x38/0xa0
 device_add+0x554/0x68c
 device_register+0x1c/0x28
 pcie_portdrv_probe+0x480/0x518
 pci_device_probe+0xcc/0x13c
 really_probe+0x190/0x350
 __driver_probe_device+0x120/0x138
 driver_probe_device+0x38/0xec
 __device_attach_driver+0x100/0x114
 bus_for_each_drv+0xa8/0xd0
 __device_attach+0xdc/0x15c
 device_initial_probe+0x10/0x18
 pci_bus_add_device+0xb8/0x130
 pci_bus_add_devices+0x50/0x74
 pci_host_probe+0x90/0xc4
 rcar_pcie_probe+0x5e8/0x650
 platform_probe+0x58/0x88
 really_probe+0x190/0x350
 __driver_probe_device+0x120/0x138
 driver_probe_device+0x38/0xec
 __driver_attach+0x158/0x168
 bus_for_each_dev+0x7c/0xd0
 driver_attach+0x20/0x28
 bus_add_driver+0xe0/0x1d8
 driver_register+0xac/0xe8
 __platform_driver_register+0x1c/0x24
 rcar_pcie_driver_init+0x18/0x20
 do_one_initcall+0xd4/0x220
 kernel_init_freeable+0x308/0x30c
 kernel_init+0x20/0x11c
 ret_from_fork+0x10/0x20
---
Cc: "Krzysztof Wilczyński" <kwilczynski@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: linux-pci@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org
---
 drivers/pci/controller/pcie-rcar-host.c | 27 ++++++++++++-------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/controller/pcie-rcar-host.c b/drivers/pci/controller/pcie-rcar-host.c
index 625a00f3b2230..213028052aa58 100644
--- a/drivers/pci/controller/pcie-rcar-host.c
+++ b/drivers/pci/controller/pcie-rcar-host.c
@@ -12,6 +12,7 @@
  */
 
 #include <linux/bitops.h>
+#include <linux/cleanup.h>
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/delay.h>
@@ -38,7 +39,7 @@ struct rcar_msi {
 	DECLARE_BITMAP(used, INT_PCI_MSI_NR);
 	struct irq_domain *domain;
 	struct mutex map_lock;
-	spinlock_t mask_lock;
+	raw_spinlock_t mask_lock;
 	int irq1;
 	int irq2;
 };
@@ -602,28 +603,26 @@ static void rcar_msi_irq_mask(struct irq_data *d)
 {
 	struct rcar_msi *msi = irq_data_get_irq_chip_data(d);
 	struct rcar_pcie *pcie = &msi_to_host(msi)->pcie;
-	unsigned long flags;
 	u32 value;
 
-	spin_lock_irqsave(&msi->mask_lock, flags);
-	value = rcar_pci_read_reg(pcie, PCIEMSIIER);
-	value &= ~BIT(d->hwirq);
-	rcar_pci_write_reg(pcie, value, PCIEMSIIER);
-	spin_unlock_irqrestore(&msi->mask_lock, flags);
+	scoped_guard(raw_spinlock_irqsave, &msi->mask_lock) {
+		value = rcar_pci_read_reg(pcie, PCIEMSIIER);
+		value &= ~BIT(d->hwirq);
+		rcar_pci_write_reg(pcie, value, PCIEMSIIER);
+	}
 }
 
 static void rcar_msi_irq_unmask(struct irq_data *d)
 {
 	struct rcar_msi *msi = irq_data_get_irq_chip_data(d);
 	struct rcar_pcie *pcie = &msi_to_host(msi)->pcie;
-	unsigned long flags;
 	u32 value;
 
-	spin_lock_irqsave(&msi->mask_lock, flags);
-	value = rcar_pci_read_reg(pcie, PCIEMSIIER);
-	value |= BIT(d->hwirq);
-	rcar_pci_write_reg(pcie, value, PCIEMSIIER);
-	spin_unlock_irqrestore(&msi->mask_lock, flags);
+	scoped_guard(raw_spinlock_irqsave, &msi->mask_lock) {
+		value = rcar_pci_read_reg(pcie, PCIEMSIIER);
+		value |= BIT(d->hwirq);
+		rcar_pci_write_reg(pcie, value, PCIEMSIIER);
+	}
 }
 
 static void rcar_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
@@ -736,7 +735,7 @@ static int rcar_pcie_enable_msi(struct rcar_pcie_host *host)
 	int err;
 
 	mutex_init(&msi->map_lock);
-	spin_lock_init(&msi->mask_lock);
+	raw_spin_lock_init(&msi->mask_lock);
 
 	err = of_address_to_resource(dev->of_node, 0, &res);
 	if (err)
-- 
2.51.0


