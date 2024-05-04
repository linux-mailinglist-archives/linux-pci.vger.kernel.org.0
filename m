Return-Path: <linux-pci+bounces-7078-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC9748BBD04
	for <lists+linux-pci@lfdr.de>; Sat,  4 May 2024 18:15:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56503B2144C
	for <lists+linux-pci@lfdr.de>; Sat,  4 May 2024 16:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 203FB51C2B;
	Sat,  4 May 2024 16:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SXhdCXlX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eZP2f9RP"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8C34E1C9;
	Sat,  4 May 2024 16:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714839331; cv=none; b=ixWa3b9jKflx5Icq3ytddw4y3BIVlgD5TvouxOP/mV7tEmA/j9GobkqxUfSJIQjwJI7+ZyXUEHKTk8A9/cmoEpMbWeRpKLCgUW+U/7luhMbTpLz98UwBcPYThCXzvGIgcVm5+JcAgTmLD4lV4BGoVhMG2q8UcGm5G6HUVLGgF10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714839331; c=relaxed/simple;
	bh=tgkjvLqHOy+A4+1Yd+vwUUa/JG2yWZoJhR7eB3UzLc4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ckYyWYqe4Vo71YALXhHas53DU7ijYjfjAp2c1DSBu4KfnSBOg8agCDW420fe0XE/FimJ5rhyXz/Yxu9ZkvDqY+i+MgbcGFAo1wBTO9DOlkXyd32v3Qg1Vd0NmvXlmwD4xVeGFCAAxelcJXZZPf2Do2xW6aYyRJhs5bOOVadwflk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SXhdCXlX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eZP2f9RP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714839326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fOSfH9/nnC1Iy/NuUJ45BTaE3oHZ9hmim1+dwQeqhyw=;
	b=SXhdCXlX42rvyWb6EFoyj673ozs/YpddV9Vbup6QSyE0/QETgmv6EOXJo5u++5KwCz3nV8
	TW81k6SwF5Ki7rbFAHTRYz4NbsCYFKakfPqLFtFqObBcB/oAM4nUgLrnSDOS3ZP+0bcqOM
	f1T3leTuQHB07QNbweKL5Z7KByqi0ilueVqfJUP6X8Rvg+y8eHo1ohuxmEjuSHk2jceS5Q
	eYk9P3Na2MqB09zwB8+eULOzviAl4/0tsRkootbH61EALKbZFDBFkxW9q5fvw71BqrbmP5
	UWGCCbYbBbaAp/cdQyhrK9XACZAXQQD4iWW53frmB+hZxrs7rd+wtzyqNYckIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714839326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fOSfH9/nnC1Iy/NuUJ45BTaE3oHZ9hmim1+dwQeqhyw=;
	b=eZP2f9RP9NxcIJHvOriFyr5G+/4VoDUtZorTM+TqUT/P0Sa1Bk1ClR4j3uf0VvrKWzqjcS
	dO9pg+xpT7f1cXBA==
To: Lukas Wunner <lukas@wunner.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	stable@vger.kernel.org
Subject: [PATCH v2 2/2] PCI: pciehp: Abort hot-plug if pci_hp_add_bridge() fails
Date: Sat,  4 May 2024 18:15:22 +0200
Message-Id: <f3db713f4a737756782be6e94fcea3eda352e39f.1714838173.git.namcao@linutronix.de>
In-Reply-To: <cover.1714838173.git.namcao@linutronix.de>
References: <cover.1714838173.git.namcao@linutronix.de>
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
v2:
  - remove "Cc: Rajesh Shah <rajesh.shah@intel.com>" (this address bounce)
  - add more information to commit message
  - return 0 instead of -EINVAL
  - remove pci_stop_and_remove_bus_device()

 drivers/pci/hotplug/pciehp_pci.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_pci.c b/drivers/pci/hotplug/pciehp_pci.c
index ad12515a4a12..200a7f4a12e0 100644
--- a/drivers/pci/hotplug/pciehp_pci.c
+++ b/drivers/pci/hotplug/pciehp_pci.c
@@ -58,8 +58,10 @@ int pciehp_configure_device(struct controller *ctrl)
 		goto out;
 	}
 
-	for_each_pci_bridge(dev, parent)
-		pci_hp_add_bridge(dev);
+	for_each_pci_bridge(dev, parent) {
+		if (pci_hp_add_bridge(dev))
+			goto out;
+	}
 
 	pci_assign_unassigned_bridge_resources(bridge);
 	pcie_bus_configure_settings(parent);
-- 
2.39.2


