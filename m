Return-Path: <linux-pci+bounces-7079-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 500558BBD03
	for <lists+linux-pci@lfdr.de>; Sat,  4 May 2024 18:15:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E9DF1C20D9E
	for <lists+linux-pci@lfdr.de>; Sat,  4 May 2024 16:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FBD253398;
	Sat,  4 May 2024 16:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NqEOoucQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WFhAGns1"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F46850278;
	Sat,  4 May 2024 16:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714839331; cv=none; b=jvUeULy9YAGwN8lcXBSdOBK/Q7RXxrYwqKslxOBwsFC7Xkzv3VfqqPsAlpzrN6t6GIgQ13SvGQgA0wBsBdDdnY0GI6zAQ66cir7aG6zXh2TP5bXnd4wXtr05WDJauvnRSqXcICpcgOCJZsukJOp77woVbYaxuZLKuUKjjR59Eps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714839331; c=relaxed/simple;
	bh=ynKA0TbW/eeVOkfMLprMu6U1Y4Vg1QU1Wvm+5C8t2PI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uqh/dOwwcv1otnOu+k8c0epScMbHuECekzW0GkgOx3/OK6/iCGEGKaKbErwCBpQqBG+AYpYRNOM940ESOqNq+iyrHSVz6ycqs5d8j4TRe9aatUfJjJgotfCo54gI2cS6StsskkU7NURTde7qPEH5Js7J9dVl7OHJA+hYlVvJEtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NqEOoucQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WFhAGns1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714839326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T0/jNdGlbHp27Mj8XQFTHCx4HfIAIuVjRvaOghR15c0=;
	b=NqEOoucQvg1OVNh28/NFxOnevnW3I249GJhQLlREoorGQoGlSa27ZVIQ5akLzSerjTiFAC
	lnRW47JqtFrxrhx6uEvstSOy5NAI/u4bao3gu7REBKO9syOAYQQ7S6TIaXpDRP5DhwfmAY
	VoFvOvpwZiX1ZhzvOoiA9s2dtq1++GQ3/L6sl9wcbfTpKksptozQz6BtKvtGfbLNjM5W5b
	PysPoKrPbY9637+heEYzNEpbYMHlEa1/pj+JRnEECR1hxxSDMTbmxly9Wh/ZQAN3K7BvwL
	K/rTioh1ZJ1xuHsVmM77fFxIzUeD8ZD8zYQQnzq0jPgksenX0gRujcjIGL357w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714839326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T0/jNdGlbHp27Mj8XQFTHCx4HfIAIuVjRvaOghR15c0=;
	b=WFhAGns1CfSKCaR/YzYQZLgwXiCbQtZUjgdPif1UDFzlxli0wiDrOlcinPVVzwD5nAhBTl
	jcCibPVyBakIuyCA==
To: Lukas Wunner <lukas@wunner.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] PCI: shpchp: Abort hot-plug if pci_hp_add_bridge() fails
Date: Sat,  4 May 2024 18:15:21 +0200
Message-Id: <e1968c2a5c0dc5eff3a757770d7a9cd81f7c7267.1714838173.git.namcao@linutronix.de>
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
        -device pcie-root-port,bus=pcie.0,id=rp1,slot=1,bus-reserve=0 \
        -device pcie-pci-bridge,id=br1,bus=rp1

then hot-plug a bridge at runtime with the QEMU command:
    device_add pci-bridge,id=br2,bus=br1,chassis_nr=1,addr=1

and the kernel crashes:

shpchp 0000:01:00.0: Latch close on Slot(1-1)
shpchp 0000:01:00.0: Button pressed on Slot(1-1)
shpchp 0000:01:00.0: Card present on Slot(1-1)
shpchp 0000:01:00.0: PCI slot #1-1 - powering on due to button press
pci 0000:02:01.0: [1b36:0001] type 01 class 0x060400 conventional PCI bridge
pci 0000:02:01.0: BAR 0 [mem 0x00000000-0x000000ff 64bit]
pci 0000:02:01.0: PCI bridge to [bus 00]
pci 0000:02:01.0:   bridge window [io  0x0000-0x0fff]
pci 0000:02:01.0:   bridge window [mem 0x00000000-0x000fffff]
pci 0000:02:01.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
pci 0000:02:01.0: No bus number available for hot-added bridge

	(note: kernel should abort hot-plugging right here)

pci 0000:02:01.0: BAR 0 [mem 0xfe600000-0xfe6000ff 64bit]: assigned
shpchp 0000:01:00.0: PCI bridge to [bus 02]
shpchp 0000:01:00.0:   bridge window [io  0xc000-0xcfff]
shpchp 0000:01:00.0:   bridge window [mem 0xfe600000-0xfe7fffff]
shpchp 0000:01:00.0:   bridge window [mem 0xfe000000-0xfe1fffff 64bit pref]
shpchp 0000:02:01.0: HPC vendor_id 1b36 device_id 1 ss_vid 0 ss_did 0
shpchp 0000:02:01.0: enabling device (0000 -> 0002)
ACPI: \_SB_.GSIE: Enabled at IRQ 20
BUG: kernel NULL pointer dereference, address: 00000000000000da
PGD 0 P4D 0
Oops: 0002 [#1] PREEMPT SMP NOPTI
CPU: 1 PID: 66 Comm: kworker/1:2 Not tainted 6.9.0-rc1-00001-g2e0239d47d75 #33
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Workqueue: shpchp-1 shpchp_pushbutton_thread
RIP: 0010:shpc_init+0x3fb/0x9d0
[stack dump and register dump cut out]

Fix this by aborting the hot-plug if pci_hp_add_bridge() fails.

Fixes: 7d01f70ac6f4 ("PCI: shpchp: use generic pci_hp_add_bridge()")
Signed-off-by: Nam Cao <namcao@linutronix.de>
Cc: Yinghai Lu <yinghai@kernel.org>
Cc: <stable@vger.kernel.org>
---
v2:
  - add more information to commit description
  - return 0 instead of -EINVAL
  - remove pci_stop_and_remove_bus_device()

 drivers/pci/hotplug/shpchp_pci.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/hotplug/shpchp_pci.c b/drivers/pci/hotplug/shpchp_pci.c
index 36db0c3c4ea6..ca105aed7eee 100644
--- a/drivers/pci/hotplug/shpchp_pci.c
+++ b/drivers/pci/hotplug/shpchp_pci.c
@@ -48,8 +48,10 @@ int shpchp_configure_device(struct slot *p_slot)
 	}
 
 	for_each_pci_bridge(dev, parent) {
-		if (PCI_SLOT(dev->devfn) == p_slot->device)
-			pci_hp_add_bridge(dev);
+		if (PCI_SLOT(dev->devfn) == p_slot->device) {
+			if (pci_hp_add_bridge(dev))
+				goto out;
+		}
 	}
 
 	pci_assign_unassigned_bridge_resources(bridge);
-- 
2.39.2


