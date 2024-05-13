Return-Path: <linux-pci+bounces-7427-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 634018C4398
	for <lists+linux-pci@lfdr.de>; Mon, 13 May 2024 16:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E7A52865C7
	for <lists+linux-pci@lfdr.de>; Mon, 13 May 2024 14:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584C81F614;
	Mon, 13 May 2024 14:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xgcu5dnP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UD5AjcQG"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055724A1C;
	Mon, 13 May 2024 14:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715612244; cv=none; b=pOlQRdldHq6SNS5mtyra5XYjCWPsTkimgGEdTQHalU1ALz5RDG3DgT3HoRl5xSngnrmxYY2QDjsH7xsUYNXDivLHI+k/YE8AQsVidCS/yNJkjBLBvUtYrc0rvlVc++lblBJEuIaO1Bm2HGFCwNMuBSioIXnpm39A1FOWQr7ffF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715612244; c=relaxed/simple;
	bh=XEREZ35Uhc3uIskZdwv721TDYFvOu/NDkvgClJxaqEc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UdBpov1NwwjkgCgTM+RFPMZODrFnbrTX/Ni83oz1EjPxH22strfUrsCNuNNoxi1CZWyNE5rynkoFTWYAneTQV3bk9z82m0YVIonppMiDwKAJE4ymftLxB/QhH7VGXPKtbIHOKpsN2qB4ezk2rxS3J91VgQQlWERw9jRNYkRxzC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xgcu5dnP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UD5AjcQG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715612240;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0RCGUSJnEEvoIoBGfG6eQzBHConnqHpnKZVi9tpii74=;
	b=xgcu5dnPKahlDVsyF+A2OgzJ5UzGHtiFjYTZVeBDJ8yLpwTkWIZv3m3hiDRwL5Zokypkns
	o/2B6qNJ+3iyUa5RzM6CWbgdOSIGxvIrFpHLDrWSd6IJKOKEVdLDHX/Xs8ssgiGYdO1c/d
	3+KVQZIxXI9+Dc4u3RC8P4ZDuVpjeSYp+x94bsnZw4BjHQ7oLuCVpxBNcrAggzfru21EvB
	GscSLZsfW9g0BC5U5rs+BZ7iFf0Rw0S64iHvYy3xqjCjKaCYsmrbshpelYaewvtUNrWmaH
	0SqIfxUKJM5b4TI+feliTy2fbBc1JGjXMw2fG32S5qfTT3E7gqHokJcjOnQHbg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715612240;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0RCGUSJnEEvoIoBGfG6eQzBHConnqHpnKZVi9tpii74=;
	b=UD5AjcQGNYDg8BjXkDP9lt6qC1ww4GQ78rAoyRuO0WUyNLW62PfbakKIj+ToHPtHTXbW55
	kO0kbUeJQwJ+OFAw==
To: Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>
Cc: Nam Cao <namcao@linutronix.de>,
	stable@vger.kernel.org
Subject: [PATCH v3 2/2] PCI: pciehp: Abort hot-plug if pci_hp_add_bridge() fails
Date: Mon, 13 May 2024 16:56:47 +0200
Message-Id: <adb9a81a2943502f105806f48b00e08e1a4e0da2.1715609848.git.namcao@linutronix.de>
In-Reply-To: <cover.1715609848.git.namcao@linutronix.de>
References: <cover.1715609848.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If a bridge is hot-added without any bus number available for its
downstream bus, pci_hp_add_bridge() will fail. However, the driver
proceeds regardless, and the kernel crashes.

This crash can be reproduced with the QEMU command:
    qemu-system-x86_64 -machine pc-q35-2.10 \
        -kernel bzImage \
        -drive "file=img,format=raw" \
        -m 2048 -smp 2 -enable-kvm \
        -append "console=ttyS0 root=/dev/sda" \
        -nographic \
        -device pcie-root-port,bus=pcie.0,id=rp1,slot=1,bus-reserve=0

then hot-plug a bridge at runtime with the QEMU command:
    device_add pcie-pci-bridge,id=br1,bus=rp1

and the kernel crashes:

pcieport 0000:00:03.0: pciehp: Slot(1): Button press: will power on in 5 sec
pcieport 0000:00:03.0: pciehp: Slot(1): Card present
pcieport 0000:00:03.0: pciehp: Slot(1): Link Up
pci 0000:01:00.0: [1b36:000e] type 01 class 0x060400 PCIe to PCI/PCI-X bridge
pci 0000:01:00.0: BAR 0 [mem 0x00000000-0x000000ff 64bit]
pci 0000:01:00.0: PCI bridge to [bus 00]
pci 0000:01:00.0:   bridge window [io  0x0000-0x0fff]
pci 0000:01:00.0:   bridge window [mem 0x00000000-0x000fffff]
pci 0000:01:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
pci 0000:01:00.0: No bus number available for hot-added bridge

	(note: kernel should abort hot-plugging right here)

pci 0000:01:00.0: BAR 0 [mem 0xfe800000-0xfe8000ff 64bit]: assigned
pcieport 0000:00:03.0: PCI bridge to [bus 01]
pcieport 0000:00:03.0:   bridge window [io  0x1000-0x1fff]
pcieport 0000:00:03.0:   bridge window [mem 0xfe800000-0xfe9fffff]
pcieport 0000:00:03.0:   bridge window [mem 0xfe000000-0xfe1fffff 64bit pref]
shpchp 0000:01:00.0: HPC vendor_id 1b36 device_id e ss_vid 0 ss_did 0
shpchp 0000:01:00.0: enabling device (0000 -> 0002)
BUG: kernel NULL pointer dereference, address: 00000000000000da
PGD 0 P4D 0
Oops: 0002 [#1] PREEMPT SMP NOPTI
CPU: 0 PID: 46 Comm: irq/24-pciehp Not tainted 6.9.0-rc1-00001-g2e0239d47d75 #33
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:shpc_init+0x3fb/0x9d0
[stack dump and register dump cut out]

Fix this by aborting the hot-plug if pci_hp_add_bridge() fails.

Fixes: 0eb3bcfd088e ("[PATCH] pciehp: allow bridged card hotplug")
Signed-off-by: Nam Cao <namcao@linutronix.de>
Cc: <stable@vger.kernel.org>
---
v3: revert back to the solution in v1 (calling
pci_stop_and_remove_bus_device() and returning negative error code)

v2:
  - remove "Cc: Rajesh Shah <rajesh.shah@intel.com>" (this address bounce)
  - add more information to commit message
  - return 0 instead of -EINVAL

 drivers/pci/hotplug/pciehp_pci.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/hotplug/pciehp_pci.c b/drivers/pci/hotplug/pciehp_pci.c
index ad12515a4a12..de783d7c8a16 100644
--- a/drivers/pci/hotplug/pciehp_pci.c
+++ b/drivers/pci/hotplug/pciehp_pci.c
@@ -59,7 +59,11 @@ int pciehp_configure_device(struct controller *ctrl)
 	}
 
 	for_each_pci_bridge(dev, parent)
-		pci_hp_add_bridge(dev);
+		if (pci_hp_add_bridge(dev)) {
+			pci_stop_and_remove_bus_device(dev);
+			ret = -EINVAL;
+			goto out;
+		}
 
 	pci_assign_unassigned_bridge_resources(bridge);
 	pcie_bus_configure_settings(parent);
-- 
2.39.2


