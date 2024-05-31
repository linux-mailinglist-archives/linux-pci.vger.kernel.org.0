Return-Path: <linux-pci+bounces-8115-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C178D604D
	for <lists+linux-pci@lfdr.de>; Fri, 31 May 2024 13:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 718CA282A5B
	for <lists+linux-pci@lfdr.de>; Fri, 31 May 2024 11:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F0115747C;
	Fri, 31 May 2024 11:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4ZZAJ6zD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sqxT0t4M"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D1615747A;
	Fri, 31 May 2024 11:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717153725; cv=none; b=CEZr2zSZkBHmgE4YV3HFdivmcCKSmaH8fayplBzG04DJZcssn/jqLAneHTQ5fW0NvcM+FBlrUyzEo7wbjJxLX9QQ6igR8jSZ78x4oiJVKuhlclXMlhfgACToGkvPetJvwXoGFHVBDCAastbdh1Lnd3fR11DVetl7OOSmFMpys6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717153725; c=relaxed/simple;
	bh=v8EdGYHGsaTVTumDZ9stM10D6B3vf1X6bWQ3ALutTB8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ayw+slr3sm1wO7Kofy0nQyj2G/wi1vqolbfSCP3JZQuXrYa+dRD+frz0Sl+QDq6mtgLXKY26qHf+ln/KiRoaTkztKohCHUfaR1tCaC95j1QQz47HDvF/lsPNgSeY+0M1nz+RGbNAnmlrtSyvATDXJK49RHVHAps8rnwMlf7Fu3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4ZZAJ6zD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sqxT0t4M; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717153721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VXsJccLpvrmqx5YxSwOp/LzJzocUhsfX7av87j9dTLk=;
	b=4ZZAJ6zDgX78teApoWDRVMHbIzzhhjaiKQhkxY9p07PkKD7Eq6ZibXi7rV3Ciac2UUQ0dj
	jkRunaR4yMiDiiud7qcyNWaa4rM4qQ3pMNilk27GlKP/ZUtP9aLs1IDpU0BtKfvPDPSEzF
	CkutIk5H+gGpgSSIOgaCuCBgMwh4jnbJ7ohfoiPo6a4E2biHMxouUroItziWt0GDk6uKAb
	M0mU8ZX0kDSlA/VsQRuzKRES9X/gP/qxxvMMaLJFFF/6J8AUurzcH/l93cQVS99ElkCXKN
	ztONsRa2gLvEbVr1ySEVAtyXhzpj/u6jFY6oQcyt7x2BPAZGVxO1KXK8Q7rMPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717153721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VXsJccLpvrmqx5YxSwOp/LzJzocUhsfX7av87j9dTLk=;
	b=sqxT0t4MQuCeM/63L7u71ZRxT+s/JnA27hFu9Lhw64ZbCTO4krOEC/7wyWT65ESJ2Oj6ht
	7iRb9PBWTcu8FgCQ==
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Lukas Wunner <lukas@wunner.de>,
	Nam Cao <namcao@linutronix.de>,
	stable@vger.kernel.org
Subject: [PATCH] PCI: hotplug: shpchp: Prevent NULL pointer dereference during probe
Date: Fri, 31 May 2024 13:08:35 +0200
Message-Id: <20240531110835.3800904-1-namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pci_dev->subordinate pointer can be NULL if we run out of bus number. The
driver deferences this pointer without checking, and the kernel crashes.

This crash can be reproduced by starting a QEMU instance:
    qemu-system-x86_64 -machine pc-q35-2.10 \
    -kernel bzImage \
    -drive "file=img,format=raw" \
    -m 2048 -smp 1 -enable-kvm \
    -append "console=ttyS0 root=/dev/sda debug" \
    -nographic \
    -device pcie-root-port,bus=pcie.0,slot=1,id=rp1 \
    -device pcie-pci-bridge,id=br1,bus=rp1

Then hot-add a bridge with the QEMU command:
    device_add pci-bridge,id=br2,bus=br1,chassis_nr=1,addr=1

Then the kernel crashes:
shpchp 0000:02:01.0: enabling device (0000 -> 0002)
shpchp 0000:02:01.0: enabling bus mastering
BUG: kernel NULL pointer dereference, address: 00000000000000da
    [snip]
Call Trace:
 <TASK>
 ? show_regs+0x63/0x70
 ? __die+0x23/0x70
 ? page_fault_oops+0x17a/0x480
 ? shpc_init+0x3fb/0x9d0
 ? search_module_extables+0x4e/0x80
 ? shpc_init+0x3fb/0x9d0
 ? kernelmode_fixup_or_oops+0x9b/0x120
 ? __bad_area_nosemaphore+0x16e/0x240
 ? bad_area_nosemaphore+0x11/0x20
 ? do_user_addr_fault+0x2a3/0x610
 ? exc_page_fault+0x6d/0x160
 ? asm_exc_page_fault+0x2b/0x30
 ? shpc_init+0x3fb/0x9d0
 shpc_probe+0x92/0x390

NULL check this pointer first before proceeding. If there is no
secondary bus number, there is no point in initializing this hot-plug
controller, so just bails out.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Cc: stable@vger.kernel.org # all
---
This one exists since beginning of git history. So I didn't bother
with a Fixes: tag.

This patch is almost a copy-paste from pciehp
---
 drivers/pci/hotplug/shpchp_core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/hotplug/shpchp_core.c b/drivers/pci/hotplug/shpchp_core.c
index 56c7795ed890..14cf9e894201 100644
--- a/drivers/pci/hotplug/shpchp_core.c
+++ b/drivers/pci/hotplug/shpchp_core.c
@@ -262,6 +262,12 @@ static int shpc_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (acpi_get_hp_hw_control_from_firmware(pdev))
 		return -ENODEV;
 
+	if (!pdev->subordinate) {
+		/* Can happen if we run out of bus numbers during probe */
+		pci_err(pdev, "Hotplug bridge without secondary bus, ignoring\n");
+		return -ENODEV;
+	}
+
 	ctrl = kzalloc(sizeof(*ctrl), GFP_KERNEL);
 	if (!ctrl)
 		goto err_out_none;
-- 
2.39.2


