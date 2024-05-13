Return-Path: <linux-pci+bounces-7425-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D088C4395
	for <lists+linux-pci@lfdr.de>; Mon, 13 May 2024 16:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FCD7B23113
	for <lists+linux-pci@lfdr.de>; Mon, 13 May 2024 14:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 961414C79;
	Mon, 13 May 2024 14:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HtullCni";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="S9bZBtlY"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055A24A32;
	Mon, 13 May 2024 14:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715612243; cv=none; b=DGonhNNnAUjArukUOIkucdetC1AZop2dOVru9zlxkC4Pnsue87FbEkuNOYlr0qvABQFy4BH872CsCcfMefF/OVui0s2RzCP75n1/0Xp5jYy0z1AGG9vDX6HU4C0bIcgvLlT3nwKMD+MVn0FUqiyDDdhGxz/nQMhgNyCvEQEidmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715612243; c=relaxed/simple;
	bh=CYlNkVHIRsr52u7bN4H+E4oBcbIvmmh2GgRSV20DBm0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cI7Ys22F9xA6BIo1eZac0qzv7pexY3xodLmyfwG3BASF8+WWXuCnfv4ErdzCjqIpRZSmQjJeoix6qQ+tJu7wCjNghrJqfoeTSdmKDMdFtKZ3nk3BYtzBxDdcvq4oVtIakrtMBTW+9/I4v7GvZ7S5PFwoA+RhrIUssSFS11XXJBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HtullCni; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=S9bZBtlY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715612240;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X4knFADxIOkDEn739FHeOZMTRRcDGiLM3OkU+m+AGQc=;
	b=HtullCniNLu6y0N4cORD+7rmoDRhDtU9JEMWfB9C/+7XXNhWzsZtxk67UbcqUJP/8y7xRq
	/Jrc1b7ANMnbds1d+djA2zDfA9fr5Z9oBJZCopX0hOcTpCS+M3hn91TWbl5ycrhUjIzJt0
	AiyDOLGUPwOXyfkU7y+fXJogO0BoCV6NZ5awqAJC6U5oQXL0inIjl5ZmMusdDEMD/cpdpK
	gbmlKADf2bC4LxmDeEUNogSrPCE5zi9iNkydXDt2rfbdisG+XDMiINqbZApNS/Z5+z+pKE
	xBfBKzhTdWXZN45CVtjrevuRZtPIdMurs2k00WdmWAw6MeNSszkbNGTRCza20A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715612240;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X4knFADxIOkDEn739FHeOZMTRRcDGiLM3OkU+m+AGQc=;
	b=S9bZBtlY6f665ZvDMpBCMLJunZOj4wQHWuFDBNEisIqSx+Ddxh6Pi9vYojFh86rL2l9WDu
	qJCtVoIuXBkYiKAg==
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
Subject: [PATCH v3 1/2] PCI: shpchp: Abort hot-plug if pci_hp_add_bridge() fails
Date: Mon, 13 May 2024 16:56:46 +0200
Message-Id: <fdd7e1c44ab4bfc54271f89e258eea6851dd42dd.1715609848.git.namcao@linutronix.de>
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
v3: revert back to the solution in v1 (calling
pci_stop_and_remove_bus_device() and returning negative error code)

v2:
  - add more information to commit description
  - return 0 instead of -EINVAL

 drivers/pci/hotplug/shpchp_pci.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/hotplug/shpchp_pci.c b/drivers/pci/hotplug/shpchp_pci.c
index 36db0c3c4ea6..2ac98bdc83d9 100644
--- a/drivers/pci/hotplug/shpchp_pci.c
+++ b/drivers/pci/hotplug/shpchp_pci.c
@@ -48,8 +48,13 @@ int shpchp_configure_device(struct slot *p_slot)
 	}
 
 	for_each_pci_bridge(dev, parent) {
-		if (PCI_SLOT(dev->devfn) == p_slot->device)
-			pci_hp_add_bridge(dev);
+		if (PCI_SLOT(dev->devfn) == p_slot->device) {
+			if (pci_hp_add_bridge(dev)) {
+				pci_stop_and_remove_bus_device(dev);
+				ret = -EINVAL;
+				goto out;
+			}
+		}
 	}
 
 	pci_assign_unassigned_bridge_resources(bridge);
-- 
2.39.2


