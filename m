Return-Path: <linux-pci+bounces-7053-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 030698BB3E9
	for <lists+linux-pci@lfdr.de>; Fri,  3 May 2024 21:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27E3DB24519
	for <lists+linux-pci@lfdr.de>; Fri,  3 May 2024 19:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88800158D61;
	Fri,  3 May 2024 19:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fK+StLPD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DnS9my0a"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A76C1586F7;
	Fri,  3 May 2024 19:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714764210; cv=none; b=t3XhJkBppT3I0HmecuLQ+Az8QI9GjKpDam7uIeDOzJJUV+7i853ltizR/xqlAfBRjWPF+IzAaTBqOmiU08gFmLFD8tgO1ocU8k1OQsiHaOaeyYebyoFzcgHrhcJnPv7yBWvvRw8BbU1wcF5A/g4P/jBg6/8j30mVPKbtWYTd1ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714764210; c=relaxed/simple;
	bh=1V/MotchWk35zXsV7U1Vi8QKX2SI4vbd5m8Vdy5GnJ4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hU7iTNT73ydzM2FJJPXO6GqwDVwRSU0MoaIc9jR+LfI5HS6KfCwOXNxAVl5OUlW3xOUhwo+pU3ZSjw7YFQxcv7Q+e3ghdDyAuWKfPIhx19mwzyVbAossj8JpSmbBv298WTeDWHYTKxJTwS0PuNKx7WzMnMlpwtFLLe8B5JNu91I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fK+StLPD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DnS9my0a; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714764207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=aYyOaZwluZwRNuouIcl7evq0yF/520EbmGmyac8IVYQ=;
	b=fK+StLPDNnlLxz3enIRjJvT1e9qjUcgp7fGo79DRpdAbdiADHnkGFoUk8c2KObfh1wfMup
	d8QZCjizuIGbVtWgpcmmIZFfXxE8mRjPuoLge2jJGYX1DJhFRfT9Wwr5aqCa64FA2ciyCl
	IByODFroQQG6rmJSKF9fokcpnTpJ17vrBp8cMzZRQy/LUxspMxPoHqYMnXl3WSBFpOmv0+
	SGTD4Q+WUvC7TnZTLxA4lyIYS+bYq5wAn6DcxLmO03LoezrwhW1f4wF4AgRVHTy7AI+dtQ
	5Z/XntX/s1iyPJR8FsXoLhtbYoNA9Dy/NwOVEES0GSI8XCRW4vpWDhCu5DO7cw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714764207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=aYyOaZwluZwRNuouIcl7evq0yF/520EbmGmyac8IVYQ=;
	b=DnS9my0avVHw8Ru0JyqxKLGBXuiVBpQqV9/+rvgGFWICmZzXsGNCbcE+glAW3k0nDRUJZW
	on6h5lwcc2jFZPAg==
To: Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rajesh Shah <rajesh.shah@intel.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH 0/4] check returned value of pci_hp_add_bridge()
Date: Fri,  3 May 2024 21:23:18 +0200
Message-Id: <cover.1714762038.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

When I hot-plug a bridge, but there is no bus number available for its
downstreambus, the kernel crashes.

This can be reproduced with something like:

	qemu-system-x86_64 -machine pc-q35-2.10 \
	 -kernel ../build-pci/arch/x86/boot/bzImage \
	 -drive "file=img,format=raw" \
	 -m 2048 -smp 2 -enable-kvm \
	 -append "console=ttyS0 root=/dev/sda" \
	 -nographic \
	 -device pcie-root-port,bus=pcie.0,id=rp1,slot=1,bus-reserve=0

Note the "bus-reserve=0": no bus number is reserved for hot-plugging a
bridge.

After booting is completed, a PCI bridge can be hot-added with the QEMU
command:
	device_add pcie-pci-bridge,id=br1,bus=rp1

After this command, the kernel crashes (crash log below).

The reason is that, hot-plugging a bridge is done with pci_hp_add_bridge()
and this can fail. However, its returned value is not checked, and the
kernel proceeds despite the bridge was not added correctly. This results
in the crash.

Patch 1 and patch 2 fix the problem for shpchp and pciehp. The other
hotplug drivers have the same problem as well, but I cannot test them. So
this issue is noted in the TODO file in patch 3.

Patch 4 is an unrelated cleanup I noticed while working on this.

Best regards,
Nam

[   77.763860] pcieport 0000:00:03.0: pciehp: Slot(1): Button press: will power on in 5 sec
[   77.765343] pcieport 0000:00:03.0: pciehp: Slot(1): Card present
[   77.766385] pcieport 0000:00:03.0: pciehp: Slot(1): Link Up
[   78.881224] pci 0000:01:00.0: [1b36:000e] type 01 class 0x060400 PCIe to PCI/PCI-X bridge
[   78.883650] pci 0000:01:00.0: BAR 0 [mem 0x00000000-0x000000ff 64bit]
[   78.884849] pci 0000:01:00.0: PCI bridge to [bus 00]
[   78.886433] pci 0000:01:00.0:   bridge window [io  0x0000-0x0fff]
[   78.887541] pci 0000:01:00.0:   bridge window [mem 0x00000000-0x000fffff]
[   78.889479] pci 0000:01:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[   78.892464] pci 0000:01:00.0: No bus number available for hot-added bridge
[   78.893717] pci 0000:01:00.0: BAR 0 [mem 0xfe800000-0xfe8000ff 64bit]: assigned
[   78.895703] pcieport 0000:00:03.0: PCI bridge to [bus 01]
[   78.896708] pcieport 0000:00:03.0:   bridge window [io  0x1000-0x1fff]
[   78.898878] pcieport 0000:00:03.0:   bridge window [mem 0xfe800000-0xfe9fffff]
[   78.900829] pcieport 0000:00:03.0:   bridge window [mem 0xfe000000-0xfe1fffff 64bit pref]
[   78.905378] shpchp 0000:01:00.0: HPC vendor_id 1b36 device_id e ss_vid 0 ss_did 0
[   78.906729] shpchp 0000:01:00.0: enabling device (0000 -> 0002)
[   78.910290] BUG: kernel NULL pointer dereference, address: 00000000000000da
[   78.911539] #PF: supervisor write access in kernel mode
[   78.912484] #PF: error_code(0x0002) - not-present page
[   78.913407] PGD 0 P4D 0
[   78.913871] Oops: 0002 [#1] PREEMPT SMP NOPTI
[   78.914652] CPU: 0 PID: 45 Comm: irq/24-pciehp Not tainted 6.8.6 #31
[   78.915774] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[   78.917395] RIP: 0010:shpc_init+0x3fb/0x9d0
[   78.918162] Code: 8b 48 08 40 80 ff 02 0f 84 15 04 00 00 f7 c2 00 00 00 1f 0f 84 44 02 00 00 b8 04 00 00 00 b9 04 00 0f
[   78.921407] RSP: 0018:ffffc9000018fad8 EFLAGS: 00010246
[   78.922330] RAX: 0000000000000000 RBX: ffff88800459ab00 RCX: 0000000000000000
[   78.923591] RDX: 00000000000000ff RSI: 0000000000000000 RDI: ffffffff83015701
[   78.924845] RBP: ffffc9000018fb20 R08: ffff888003658280 R09: 0000000000000000
[   78.926093] R10: 0000000000000000 R11: ffff888006888780 R12: ffff8880042ff000
[   78.927358] R13: 0000000000000000 R14: 000000007f000d0f R15: 000000000000001f
[   78.928622] FS:  0000000000000000(0000) GS:ffff88807dc00000(0000) knlGS:0000000000000000
[   78.930040] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   78.931056] CR2: 00000000000000da CR3: 000000000471a000 CR4: 00000000000006f0
[   78.932321] Call Trace:
[   78.932770]  <TASK>
[   78.933175]  ? show_regs+0x64/0x70
[   78.933793]  ? __die+0x23/0x70
[   78.934351]  ? page_fault_oops+0x17b/0x460
[   78.935087]  ? search_module_extables+0x18/0x60
[   78.935907]  ? shpc_init+0x3fb/0x9d0
[   78.936548]  ? kernelmode_fixup_or_oops+0x9d/0x120
[   78.937420]  ? __bad_area_nosemaphore+0x16b/0x220
[   78.938272]  ? bad_area_nosemaphore+0x11/0x20
[   78.939068]  ? do_user_addr_fault+0x28c/0x610
[   78.939858]  ? exc_page_fault+0x6e/0x160
[   78.940566]  ? asm_exc_page_fault+0x2b/0x30
[   78.941332]  ? shpc_init+0x3fb/0x9d0
[   78.941976]  ? shpc_init+0x569/0x9d0
[   78.942618]  shpc_probe+0x92/0x390
[   78.943232]  local_pci_probe+0x46/0xa0
[   78.943922]  pci_device_probe+0xb0/0x190
[   78.944491]  really_probe+0xc2/0x2d0
[   78.944996]  ? __pfx___device_attach_driver+0x10/0x10
[   78.945693]  __driver_probe_device+0x73/0x120
[   78.946300]  driver_probe_device+0x1f/0xf0
[   78.946869]  __device_attach_driver+0x8d/0x120
[   78.947489]  bus_for_each_drv+0x96/0xf0
[   78.948031]  __device_attach+0xae/0x1a0
[   78.948571]  device_attach+0xf/0x20
[   78.949062]  pci_bus_add_device+0x58/0x90
[   78.949628]  pci_bus_add_devices+0x30/0x70
[   78.950201]  pciehp_configure_device+0xa8/0x150
[   78.950840]  pciehp_handle_presence_or_link_change+0x161/0x4a0
[   78.951655]  pciehp_ist+0x20f/0x240
[   78.952144]  ? __pfx_irq_thread_fn+0x10/0x10
[   78.952744]  irq_thread_fn+0x23/0x60
[   78.953245]  irq_thread+0xfa/0x1c0
[   78.953726]  ? __pfx_irq_thread_dtor+0x10/0x10
[   78.954346]  ? __pfx_irq_thread+0x10/0x10
[   78.955175]  kthread+0xe0/0x110
[   78.955631]  ? __pfx_kthread+0x10/0x10
[   78.956160]  ret_from_fork+0x3c/0x60
[   78.956661]  ? __pfx_kthread+0x10/0x10
[   78.957207]  ret_from_fork_asm+0x1b/0x30
[   78.957754]  </TASK>
[   78.958070] Modules linked in:
[   78.958501] CR2: 00000000000000da
[   78.958970] ---[ end trace 0000000000000000 ]---
[   78.959615] RIP: 0010:shpc_init+0x3fb/0x9d0
[   78.960201] Code: 8b 48 08 40 80 ff 02 0f 84 15 04 00 00 f7 c2 00 00 00 1f 0f 84 44 02 00 00 b8 04 00 00 00 b9 04 00 0f
[   78.962745] RSP: 0018:ffffc9000018fad8 EFLAGS: 00010246
[   78.963462] RAX: 0000000000000000 RBX: ffff88800459ab00 RCX: 0000000000000000
[   78.964441] RDX: 00000000000000ff RSI: 0000000000000000 RDI: ffffffff83015701
[   78.965469] RBP: ffffc9000018fb20 R08: ffff888003658280 R09: 0000000000000000
[   78.966537] R10: 0000000000000000 R11: ffff888006888780 R12: ffff8880042ff000
[   78.967531] R13: 0000000000000000 R14: 000000007f000d0f R15: 000000000000001f
[   78.968539] FS:  0000000000000000(0000) GS:ffff88807dc00000(0000) knlGS:0000000000000000
[   78.969662] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   78.970472] CR2: 00000000000000da CR3: 000000000471a000 CR4: 00000000000006f0
[   78.971449] note: irq/24-pciehp[45] exited with irqs disabled
[   78.972281] BUG: kernel NULL pointer dereference, address: 0000000000000000
[   78.973232] #PF: supervisor instruction fetch in kernel mode
[   78.974012] #PF: error_code(0x0010) - not-present page
[   78.974717] PGD 0 P4D 0
[   78.975075] Oops: 0010 [#2] PREEMPT SMP NOPTI
[   78.975686] CPU: 0 PID: 45 Comm: irq/24-pciehp Tainted: G      D            6.8.6 #31
[   78.976751] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[   78.978011] RIP: 0010:0x0
[   78.978383] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
[   78.979274] RSP: 0018:ffffc9000018fe98 EFLAGS: 00010286
[   78.979996] RAX: 0000000000000000 RBX: ffff888003d2c740 RCX: 00000000000001c0
[   78.980973] RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffffc9000018fea0
[   78.981949] RBP: ffffc9000018feb8 R08: 0000000000009ffb R09: 00000000ffffdfff
[   78.982924] R10: 0000000000000001 R11: ffffffff82a58aa0 R12: ffff888003d2c740
[   78.983901] R13: ffff888003d2cf54 R14: ffff888003e78001 R15: 0000000000000000
[   78.984884] FS:  0000000000000000(0000) GS:ffff88807dc00000(0000) knlGS:0000000000000000
[   78.985992] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   78.986786] CR2: ffffffffffffffd6 CR3: 000000000471a000 CR4: 00000000000006f0
[   78.987793] Call Trace:
[   78.988143]  <TASK>
[   78.988443]  ? show_regs+0x64/0x70
[   78.988924]  ? __die+0x23/0x70
[   78.989355]  ? page_fault_oops+0x17b/0x460
[   78.989925]  ? do_user_addr_fault+0x2d1/0x610
[   78.990539]  ? _prb_read_valid+0x2e6/0x370
[   78.991132]  ? exc_page_fault+0x6e/0x160
[   78.991688]  ? asm_exc_page_fault+0x2b/0x30
[   78.992318]  task_work_run+0x60/0x90
[   78.992798]  do_exit+0x355/0xb00
[   78.993234]  make_task_dead+0x7e/0x160
[   78.993708]  rewind_stack_and_make_dead+0x17/0x20
[   78.994303]  </TASK>
[   78.994589] Modules linked in:
[   78.994984] CR2: 0000000000000000
[   78.995408] ---[ end trace 0000000000000000 ]---
[   78.995984] RIP: 0010:shpc_init+0x3fb/0x9d0
[   78.996503] Code: 8b 48 08 40 80 ff 02 0f 84 15 04 00 00 f7 c2 00 00 00 1f 0f 84 44 02 00 00 b8 04 00 00 00 b9 04 00 0f
[   78.998828] RSP: 0018:ffffc9000018fad8 EFLAGS: 00010246
[   78.999500] RAX: 0000000000000000 RBX: ffff88800459ab00 RCX: 0000000000000000
[   79.000406] RDX: 00000000000000ff RSI: 0000000000000000 RDI: ffffffff83015701
[   79.001282] RBP: ffffc9000018fb20 R08: ffff888003658280 R09: 0000000000000000
[   79.002159] R10: 0000000000000000 R11: ffff888006888780 R12: ffff8880042ff000
[   79.003036] R13: 0000000000000000 R14: 000000007f000d0f R15: 000000000000001f
[   79.003926] FS:  0000000000000000(0000) GS:ffff88807dc00000(0000) knlGS:0000000000000000
[   79.004921] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   79.005637] CR2: ffffffffffffffd6 CR3: 000000000471a000 CR4: 00000000000006f0
[   79.006523] note: irq/24-pciehp[45] exited with irqs disabled
[   79.007261] Fixing recursive fault but reboot is needed!
[   79.007942] BUG: scheduling while atomic: irq/24-pciehp/45/0x00000000
[   79.008740] Modules linked in:
[   79.009151] CPU: 0 PID: 45 Comm: irq/24-pciehp Tainted: G      D            6.8.6 #31
[   79.010117] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[   79.011255] Call Trace:
[   79.011573]  <TASK>
[   79.011845]  dump_stack_lvl+0x5f/0x80
[   79.012310]  dump_stack+0x14/0x20
[   79.012730]  __schedule_bug+0x51/0x70
[   79.013195]  __schedule+0x79c/0x890
[   79.013634]  ? vprintk+0x31/0x40
[   79.014044]  ? _printk+0x5f/0x80
[   79.014456]  do_task_dead+0x43/0x50
[   79.014897]  make_task_dead+0x142/0x160
[   79.015378]  rewind_stack_and_make_dead+0x17/0x20
[   79.015971]  </TASK>

Nam Cao (4):
  PCI: shpchp: bail out if pci_hp_add_bridge() fails
  PCI: pciehp: bail out if pci_hp_add_bridge() fails
  PCI: hotplug: document unchecked return value of pci_hp_add_bridge()
  PCI: hotplug: remove TODO notes for sgi_hotplug

 drivers/pci/hotplug/TODO         | 12 +++++-------
 drivers/pci/hotplug/pciehp_pci.c |  9 +++++++--
 drivers/pci/hotplug/shpchp_pci.c |  9 +++++++--
 3 files changed, 19 insertions(+), 11 deletions(-)

-- 
2.39.2


