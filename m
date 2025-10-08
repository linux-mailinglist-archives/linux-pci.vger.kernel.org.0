Return-Path: <linux-pci+bounces-37713-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E091DBC5712
	for <lists+linux-pci@lfdr.de>; Wed, 08 Oct 2025 16:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 800CC4E1958
	for <lists+linux-pci@lfdr.de>; Wed,  8 Oct 2025 14:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A1A2EB862;
	Wed,  8 Oct 2025 14:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="rg4PB8O8"
X-Original-To: linux-pci@vger.kernel.org
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBAF2EB850;
	Wed,  8 Oct 2025 14:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759934234; cv=none; b=FIDCshq7lc1dVgqqM7ajUdZBlkNZbtsiE00P3t4gjLab+Y39NB89j+HQ27MmGEFGDp6AykhXJ9tN7ZDBMGieDR9NrSGDcpHm84SYD1IJ0ArtYr1oKptU3ASAAt0pycrnocihz+QXEH46gSm2RACDJrbIXSOenHXjUPh4lwVHUvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759934234; c=relaxed/simple;
	bh=ZW9QQUjjN0ZLzY5BDKEkZogHQwIL0iyxvQ5wxus9cYo=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=YA+JDC8m+6r63d7qrVEPLDsWWJhPnI8lJ7EFMyz3B9YQkwLI/QaToBf67Dm87MuGrTBLEpJpNu8iKS5ovos/PdAlM0Z7+arJw3e0M+DzQ3dcaRU/70FKxSfUNRwHYZnh94tELCkLjV5P5kSCYVhkxdRC/MMGBXEIEWliEMzfkso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=pass smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=rg4PB8O8; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1759934216; bh=sHeb4E4ko68oDP01u3HcpitJ2mhLx4BL5G8W9TtjWak=;
	h=From:To:Cc:Subject:Date;
	b=rg4PB8O8wmczybxJO6TAJHhEEY/88OJ5sOGXHdG35PkZmxw7dZvj0QQ3BrFYYo4vH
	 2L6b+Xm5GoFriMY+PwC61JiDXlBjoDkUSMHUUX+qK6R6oOc+/xE6ZywMQD0SnhuTcJ
	 SIlhQ3x7+x+q4ramnWO8DCiSDtX8iqg1+I7ZEfz0=
Received: from cyy-pc.lan ([240e:379:226d:ef00:9cd3:cdf3:d108:a8])
	by newxmesmtplogicsvrsza56-0.qq.com (NewEsmtp) with SMTP
	id 9359D2E1; Wed, 08 Oct 2025 22:36:53 +0800
X-QQ-mid: xmsmtpt1759934213t1a9cmn3v
Message-ID: <tencent_8C54420E1B0FF8D804C1B4651DF970716309@qq.com>
X-QQ-XMAILINFO: M+5cKLn0wXDtWiNjSf0UwqTjryWl6Zjv248UM60FrvLnZJxBAv0lybXKnlAoua
	 7OBl4U4xc2twPOycnLoIFYqJgOKM/4Ac3npv967gq30Phw0w33iGgcJ6i4r5IyfvCAebrccxH28H
	 N1B/8wwP7gI4ZNBsaWy/xbGGnOTVcJ5Ws/Tc8dUydwy8yeMapf5h+aIiYZwYrzK3HJFlINqnxSKV
	 eyleUstcnM2guIKD4nzGX8HAiH8fQMde/7gy1BbLpo6NprP3JGl09ZS4T8tG02VlHUn0xjSY1sNL
	 gmeE4dYB2b92PA+iue+fKMDeWCVckrxu3NBjWhVZz4ayb/l7pD62rNWedukTzLQSumv5bTBB20K4
	 l8ipx16vfzkWuvyfelDDo1j7sOTPPTcE9/jXxpV3kFPKyIdvapVlalv7lFw9Vbn/NswthBVk6mG1
	 5O7LsNGXxEdBuqRB618Hp2BD01wxDxeifhUBW9TrpB1CZMO4mTYmL6UOKgQ3AobkbJQAfl4I/QoS
	 M9t+EwfY7Wjo8dtEkXUPBmmFOJ8HIUQKGB7tB7z2zwmAd+Np+yMX0eDWJpI3UJ4eG/xTn4xY0dQR
	 PzC6UJ7DQyzAvMH5IswKtUiPEDgyGZ+fzGQrkpMT9FKCPMXQ9TPzKZwYiyvlGjgq6eoUOr/7GDlm
	 HKa1JFlyDXZvSr75VHy5pLhZo00KMz2H1EgdDF5HcEypmYDT+VpmfCSDGTKzX/nDEenLQ35Xka5o
	 XrBEm+75sxZa+ekrvppT8vEjgb0Qq8j0O0xKcfz70clAZ9ImwE6FMqoI6Nz3YkAbIF0IYnS3oO0p
	 w/yFHKLOxB/Tx8v9irmAoXAP8xLoIPJwF4rDnzKUYcLgyC3i13hqw/khJQaoCi3mf4VLckQA8AY9
	 FAoti2OhnhyJkG4ilc0BGx/KGqbfCHQ46IHeWCIncQg1/sbolecEdUN8qULCm4yD3a/Qc3VepcXD
	 j0EQ+IPR+PAu8xTgt/Cqmm3iF+m08g6+6iczfXIZAArJh5HUyDZtRsJL8t71CGgU1/mukkgkji0T
	 w6Abbx3mRY6/BDskqk6ajCBi9w2m/h96ppeBY7Qg==
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Yangyu Chen <cyy@cyyself.name>
To: linux-pci@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-kernel@vger.kernel.org,
	Yangyu Chen <cyy@cyyself.name>
Subject: [PATCH -fixes] PCI: Fix regression in pci_bus_distribute_available_resources
Date: Wed,  8 Oct 2025 22:36:52 +0800
X-OQ-MSGID: <20251008143652.1501772-1-cyy@cyyself.name>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The refactoring in upstream commit 4292a1e45fd4 ("PCI: Refactor
distributing available memory to use loops") switched
pci_bus_distribute_available_resources to operate on an array of bridge
windows. That rewrite accidentally looked up bus resources via
pci_bus_resource_n and then passed those pointers to helper routines
that expect the resource to belong to the device. As soon as we
execute that code, pci_resource_num warned because the resource
wasn't in the bridge's resource array.

This happens on my AMD Strix Halo machine with Thunderbolt device, the
error message is shown below:

[    4.212389] ------------[ cut here ]------------
[    4.212391] WARNING: CPU: 6 PID: 272 at drivers/pci/pci.h:471 pci_bus_distribute_available_resources+0x6ad/0x6d0
[    4.212400] Modules linked in: raid6_pq(+) hid_generic uas usb_storage scsi_mod usbhid hid scsi_common amdgpu amdxcp drm_panel_backlight_quirks gpu_sched drm_buddy drm_ttm_helper ttm drm_exec i2c_algo_bit drm_suballoc_helper drm_display_helper cec rc_core drm_client_lib drm_kms_helper sdhci_pci sdhci_uhs2 xhci_pci sp5100_tco xhci_hcd r8169 drm nvme sdhci watchdog realtek usbcore thunderbolt cqhci atlantic nvme_core mdio_devres psmouse libphy mmc_core nvme_keyring video i2c_piix4 macsec nvme_auth serio_raw mdio_bus i2c_smbus usb_common crc16 hkdf wmi
[    4.212443] CPU: 6 UID: 0 PID: 272 Comm: irq/33-pciehp Not tainted 6.17.0+ #1 PREEMPT(voluntary)
[    4.212447] Hardware name: PELADN YO Series/YO1, BIOS 1.04 05/15/2025
[    4.212449] RIP: 0010:pci_bus_distribute_available_resources+0x6ad/0x6d0
[    4.212453] Code: ff e9 a2 48 c7 c7 b8 b7 83 a3 4c 89 4c 24 18 e8 a9 2a fb ff 4c 8b 4c 24 18 e9 ca fd ff ff 48 8b 05 60 53 47 01 e9 94 fe ff ff <0f> 0b e9 5d fe ff ff 48 8b 05 55 53 47 01 e9 81 fe ff ff e8 4b 87
[    4.212455] RSP: 0018:ffffaffcc0d4f9a8 EFLAGS: 00010206
[    4.212458] RAX: 00000000000000cd RBX: ffff9721a687f800 RCX: ffff9721a687c828
[    4.212459] RDX: 0000000000000000 RSI: 00000000000000cd RDI: ffff97218bc8a3c0
[    4.212461] RBP: ffff9721a687c828 R08: ffffaffcc0d4f9f8 R09: 0000000000000001
[    4.212462] R10: ffff97218bc8d700 R11: 0000000000000000 R12: ffffaffcc0d4f9f8
[    4.212462] R13: ffffaffcc0d4f9f8 R14: 0000000000000000 R15: ffff97218bc8a000
[    4.212464] FS:  0000000000000000(0000) GS:ffff973ee1ad9000(0000) knlGS:0000000000000000
[    4.212465] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    4.212467] CR2: 00005640b0f29360 CR3: 0000000ccb224000 CR4: 0000000000f50ef0
[    4.212469] PKRU: 55555554
[    4.212470] Call Trace:
[    4.212473]  <TASK>
[    4.212478]  pci_bus_distribute_available_resources+0x590/0x6d0
[    4.212483]  pci_bridge_distribute_available_resources+0x62/0xb0
[    4.212487]  pci_assign_unassigned_bridge_resources+0x65/0x1b0
[    4.212490]  pciehp_configure_device+0x92/0x160
[    4.212495]  pciehp_handle_presence_or_link_change+0x1b5/0x350
[    4.212498]  pciehp_ist+0x147/0x1c0
[    4.212502]  irq_thread_fn+0x20/0x60
[    4.212508]  irq_thread+0x1cc/0x360
[    4.212511]  ? __pfx_irq_thread_fn+0x10/0x10
[    4.212515]  ? __pfx_irq_thread_dtor+0x10/0x10
[    4.212518]  ? __pfx_irq_thread+0x10/0x10
[    4.212521]  kthread+0xf9/0x240
[    4.212525]  ? __pfx_kthread+0x10/0x10
[    4.212528]  ret_from_fork+0x195/0x1d0
[    4.212533]  ? __pfx_kthread+0x10/0x10
[    4.212536]  ret_from_fork_asm+0x1a/0x30
[    4.212540]  </TASK>
[    4.212541] ---[ end trace 0000000000000000 ]---

Fix the regression by always fetching the resource directly from the
bridge: use pci_resource_n(bridge, PCI_BRIDGE_RESOURCES + i). This
restores the original behaviour while keeping the refactored structure.
And then we can successfully assign resources to the Thunderbolt device.

Fixes: 4292a1e45fd4 ("PCI: Refactor distributing available memory to use loops")

Signed-off-by: Yangyu Chen <cyy@cyyself.name>
---
 drivers/pci/setup-bus.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 362ad108794d..4a8735b275e4 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -2085,7 +2085,8 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
 	int i;
 
 	for (i = 0; i < PCI_P2P_BRIDGE_RESOURCE_NUM; i++) {
-		struct resource *res = pci_bus_resource_n(bus, i);
+		struct resource *res =
+			pci_resource_n(bridge, PCI_BRIDGE_RESOURCES + i);
 
 		available[i] = available_in[i];
 
@@ -2158,7 +2159,7 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
 			continue;
 
 		for (i = 0; i < PCI_P2P_BRIDGE_RESOURCE_NUM; i++) {
-			res = pci_bus_resource_n(bus, i);
+			res = pci_resource_n(dev, PCI_BRIDGE_RESOURCES + i);
 
 			/*
 			 * Make sure the split resource space is properly
-- 
2.51.0


