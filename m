Return-Path: <linux-pci+bounces-7945-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A99DB8D27F5
	for <lists+linux-pci@lfdr.de>; Wed, 29 May 2024 00:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F21A28C48E
	for <lists+linux-pci@lfdr.de>; Tue, 28 May 2024 22:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6699F13EFE0;
	Tue, 28 May 2024 22:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nnIdvj8H"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE5313E04F
	for <linux-pci@vger.kernel.org>; Tue, 28 May 2024 22:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716934906; cv=none; b=Ot6z8dZsPVq7DCygfq38imfkhlsBKLyVrngsjrVU0SO2QSo8SRBoWrqjNROGsXk9G3jviibgz0spANUo2pX0JixYBF3RTWHJW/CJ1U+rkPD5sLcdADVMJ5vRqtVRRvgZ5Q5/CkC3JmTHnK/GF165WwP8ABSSw4IpzLkRrYWk5Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716934906; c=relaxed/simple;
	bh=ex4n0FqnKxTX+bB8JVifcatTJjq8EbnHlY5ZjDrFf0w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=d6fv2F01khbiCSXf22043Vh/JOXBUdST7IPxNrZpmoiHibCQ1Ysa3OSfo26u6FIHr447PNYA6xmRs9yzLu/50nprRcV/l5OWoRAh0yXkgzR0MLaz08PTukU1ITj6a37N7YVqF+RCbqOM29UrChKYMPRMzGwGJZ7SEY97C3O/k/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nnIdvj8H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7923CC32781;
	Tue, 28 May 2024 22:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716934905;
	bh=ex4n0FqnKxTX+bB8JVifcatTJjq8EbnHlY5ZjDrFf0w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=nnIdvj8HtcztkmgfcLZk70wAy5F8DBMT7UDKcvE7mQ5P/yT9dj5Oj+dDtb2EHT6La
	 D/OAltv3uhBbLhw8GzjXcil0KKBbFfzdwBQV763BqobcQInkNadGnxl8pOQZd5YRfj
	 OQt3loMzrbor+6zfLgfR5wweHRjTHp6rizqgwh0VWhStikEruHiBjNDsopXV+R/8xx
	 p6pbru+FUqBDv3ni/Ez2nkL+sD0OpiI7/hfu6EyFunMNSSJ+06jzyNNnFxtHUdhMhC
	 HqCsibXlXY6b01vDaYgD1IkyHlYoDoEOeJCqeGC4HEpMUA23eHU/tLX3eO+QA8vEit
	 ClC++GgsNAm5g==
Date: Tue, 28 May 2024 17:21:43 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Subject: Re: PCI core lockdep warning with 6.10-rc1 on Dell XPS 13 plus 9320
Message-ID: <20240528222143.GA472908@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <314acaeb-1b83-49a9-b469-087365018d8e@redhat.com>

On Tue, May 28, 2024 at 09:02:05PM +0200, Hans de Goede wrote:
> Hi,
> 
> While testing 6.10-rc1 on a Dell XPS 13 plus 9320 I noticed the following PCI lockdep warnings:

Thanks for the report!  I think/hope this is the same as

  https://lore.kernel.org/r/171659995361.845588.6664390911348526329.stgit@dwillia2-xfh.jf.intel.com

which is queued on pci/for-linus.  Let me know if you still see it
with that patch.

> [    5.688969] vmd 0000:00:0e.0: PCI host bridge to bus 10000:e0
> [    5.688976] pci_bus 10000:e0: root bus resource [bus e0-ff]
> [    5.688978] pci_bus 10000:e0: root bus resource [mem 0x72000000-0x73ffffff]
> [    5.688980] pci_bus 10000:e0: root bus resource [mem 0x6040102000-0x60401fffff 64bit]
> [    5.689056] pci 10000:e0:06.0: [8086:a74d] type 01 class 0x060400 PCIe Root Port
> [    5.689074] pci 10000:e0:06.0: PCI bridge to [bus e1]
> [    5.689079] pci 10000:e0:06.0:   bridge window [io  0x0000-0x0fff]
> [    5.689081] pci 10000:e0:06.0:   bridge window [mem 0x72000000-0x720fffff]
> [    5.689141] pci 10000:e0:06.0: PME# supported from D0 D3hot D3cold
> [    5.689172] pci 10000:e0:06.0: PTM enabled (root), 4ns granularity
> [    5.690231] pci 10000:e0:06.0: Adding to iommu group 10
> [    5.690293] pci 10000:e0:06.0: Primary bus is hard wired to 0
> [    5.690379] pci 10000:e1:00.0: [15b7:5011] type 00 class 0x010802 PCIe Endpoint
> [    5.690396] pci 10000:e1:00.0: BAR 0 [mem 0x72000000-0x72003fff 64bit]
> [    5.690691] pci 10000:e1:00.0: Adding to iommu group 10
> [    5.690962] pci 10000:e0:06.0: PCI bridge to [bus e1]
> [    5.690971] pci 10000:e0:06.0: Primary bus is hard wired to 0
> [    5.793802] input: VEN_04F3:00 04F3:31D1 Mouse as /devices/pci0000:00/0000:00:15.1/i2c_designware.1/i2c-1/i2c-VEN_04F3:00/0018:04F3:31D1.0001/input/input5
> [    5.794265] input: VEN_04F3:00 04F3:31D1 Touchpad as /devices/pci0000:00/0000:00:15.1/i2c_designware.1/i2c-1/i2c-VEN_04F3:00/0018:04F3:31D1.0001/input/input6
> [    5.794529] input: VEN_04F3:00 04F3:31D1 as /devices/pci0000:00/0000:00:15.1/i2c_designware.1/i2c-1/i2c-VEN_04F3:00/0018:04F3:31D1.0001/input/input8
> [    5.795072] hid-generic 0018:04F3:31D1.0001: input,hidraw0: I2C HID v1.00 Mouse [VEN_04F3:00 04F3:31D1] on i2c-VEN_04F3:00
> [    5.831990] ------------[ cut here ]------------
> [    5.831999] WARNING: CPU: 7 PID: 539 at drivers/pci/pci.c:4886 pci_reset_bus+0x38d/0x3a0
> [    5.832005] Modules linked in: sha512_ssse3 sha256_ssse3 hid_multitouch(+) typec_ucsi sha1_ssse3 dw_dmac intel_ishtp cec vmd(+) typec i2c_hid_acpi i2c_hid wmi pinctrl_tigerlake serio_raw ip6_tables ip_tables fuse
> [    5.832021] CPU: 7 PID: 539 Comm: (udev-worker) Not tainted 6.10.0-rc1+ #21
> [    5.832023] Hardware name: Dell Inc. XPS 9320/01YN3R, BIOS 2.11.0 03/06/2024
> [    5.832025] RIP: 0010:pci_reset_bus+0x38d/0x3a0
> [    5.832027] Code: 29 34 ff ff 4c 89 e7 e8 51 06 7c 00 e9 29 fe ff ff 48 8d bb e0 09 00 00 be ff ff ff ff e8 0b fe 7a 00 85 c0 0f 85 3d fd ff ff <0f> 0b e9 36 fd ff ff 41 bc e7 ff ff ff e9 9f fc ff ff 90 90 90 90
> [    5.832028] RSP: 0018:ffffac8f839c7af8 EFLAGS: 00010246
> [    5.832031] RAX: 0000000000000000 RBX: ffff9d24c1fb3000 RCX: 0000000000000001
> [    5.832033] RDX: 0000000000000000 RSI: ffffffff9e9cc0d4 RDI: ffffffff9ea043bd
> [    5.832034] RBP: ffff9d24c1faf028 R08: 0000000000000001 R09: 0000000000000000
> [    5.832036] R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000020
> [    5.832037] R13: ffff9d24c1faf000 R14: 000000000000007f R15: 0000000000000630
> [    5.832039] FS:  00007f32c2adf980(0000) GS:ffff9d2c2f380000(0000) knlGS:0000000000000000
> [    5.832041] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    5.832042] CR2: 0000557a4c61a130 CR3: 000000010f6c0000 CR4: 0000000000750ef0
> [    5.832044] PKRU: 55555554
> [    5.832045] Call Trace:
> [    5.832046]  <TASK>
> [    5.832047]  ? __warn.cold+0xb1/0x13e
> [    5.832051]  ? pci_reset_bus+0x38d/0x3a0
> [    5.832052]  ? report_bug+0xe6/0x170
> [    5.832056]  ? handle_bug+0x3c/0x80
> [    5.832059]  ? exc_invalid_op+0x13/0x60
> [    5.832062]  ? asm_exc_invalid_op+0x16/0x20
> [    5.832070]  ? pci_reset_bus+0x38d/0x3a0
> [    5.832072]  ? pci_reset_bus+0x385/0x3a0
> [    5.832074]  vmd_probe+0x760/0xa30 [vmd]
> [    5.832081]  local_pci_probe+0x3e/0x80
> [    5.832084]  pci_device_probe+0xaf/0x250
> [    5.832087]  really_probe+0xdb/0x340
> [    5.832090]  ? pm_runtime_barrier+0x50/0x90
> [    5.832093]  ? __pfx___driver_attach+0x10/0x10
> [    5.832095]  __driver_probe_device+0x78/0x110
> [    5.832099]  driver_probe_device+0x1f/0xa0
> [    5.832103]  __driver_attach+0xba/0x1c0
> [    5.832106]  bus_for_each_dev+0x68/0xb0
> [    5.832110]  bus_add_driver+0x111/0x1f0
> [    5.832112]  driver_register+0x6e/0xc0
> [    5.832114]  ? __pfx_vmd_drv_init+0x10/0x10 [vmd]
> [    5.832117]  do_one_initcall+0x5b/0x3a0
> [    5.832120]  ? kmalloc_trace_noprof+0x25c/0x320
> [    5.832125]  do_init_module+0x60/0x220
> [    5.832128]  __do_sys_init_module+0x15f/0x190
> [    5.832134]  do_syscall_64+0x93/0x180
> [    5.832136]  ? do_syscall_64+0x9f/0x180
> [    5.832138]  ? lockdep_hardirqs_on+0x78/0x100
> [    5.832141]  ? do_syscall_64+0x9f/0x180
> [    5.832143]  ? do_syscall_64+0x9f/0x180
> [    5.832145]  ? do_user_addr_fault+0x392/0x710
> [    5.832147]  ? exc_page_fault+0x126/0x260
> [    5.832152]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [    5.832155] RIP: 0033:0x7f32c34af57e
> [    5.832159] Code: 48 8b 0d 9d 98 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 af 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 6a 98 0c 00 f7 d8 64 89 01 48
> [    5.832160] RSP: 002b:00007ffe33fbb568 EFLAGS: 00000246 ORIG_RAX: 00000000000000af
> [    5.832163] RAX: ffffffffffffffda RBX: 000055beacde5da0 RCX: 00007f32c34af57e
> [    5.832165] RDX: 00007f32c35c707d RSI: 000000000000a509 RDI: 000055beacdf1800
> [    5.832166] RBP: 00007ffe33fbb620 R08: 000055beacdb4010 R09: 0000000000000007
> [    5.832167] R10: 0000000000000002 R11: 0000000000000246 R12: 00007f32c35c707d
> [    5.832168] R13: 0000000000020000 R14: 000055beacde77a0 R15: 000055beacde5e90
> [    5.832173]  </TASK>
> [    5.832174] irq event stamp: 25575
> [    5.832175] hardirqs last  enabled at (25581): [<ffffffff9d1bdead>] console_unlock+0x10d/0x140
> [    5.832178] hardirqs last disabled at (25586): [<ffffffff9d1bde92>] console_unlock+0xf2/0x140
> [    5.832180] softirqs last  enabled at (24952): [<ffffffff9d1177bd>] __irq_exit_rcu+0x9d/0x100
> [    5.832182] softirqs last disabled at (24945): [<ffffffff9d1177bd>] __irq_exit_rcu+0x9d/0x100
> [    5.832184] ---[ end trace 0000000000000000 ]---
> [    5.847273] input: LXT2021:00 29BD:3303 as /devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-0/i2c-LXT2021:00/0018:29BD:3303.0002/input/input9
> [    5.859415] hid-multitouch 0018:29BD:3303.0002: input,hidraw1: I2C HID v1.00 Device [LXT2021:00 29BD:3303] on i2c-LXT2021:00
> [    5.875251] pxa2xx-spi pxa2xx-spi.3: no DMA channels available, using PIO
> [    5.890877] input: VEN_04F3:00 04F3:31D1 Mouse as /devices/pci0000:00/0000:00:15.1/i2c_designware.1/i2c-1/i2c-VEN_04F3:00/0018:04F3:31D1.0001/input/input11
> [    5.891185] input: VEN_04F3:00 04F3:31D1 Touchpad as /devices/pci0000:00/0000:00:15.1/i2c_designware.1/i2c-1/i2c-VEN_04F3:00/0018:04F3:31D1.0001/input/input12
> [    5.891354] input: VEN_04F3:00 04F3:31D1 UNKNOWN as /devices/pci0000:00/0000:00:15.1/i2c_designware.1/i2c-1/i2c-VEN_04F3:00/0018:04F3:31D1.0001/input/input14
> [    5.891535] hid-multitouch 0018:04F3:31D1.0001: input,hidraw0: I2C HID v1.00 Mouse [VEN_04F3:00 04F3:31D1] on i2c-VEN_04F3:00
> 
> [    5.998855] fbcon: Taking over console
> [    5.998863] =====================================
> [    5.998866] WARNING: bad unlock balance detected!
> [    5.998869] 6.10.0-rc1+ #21 Tainted: G        W         
> [    5.998873] -------------------------------------
> [    5.998876] (udev-worker)/539 is trying to release lock (10000:e1:00.0) at:
> [    5.998883] [<ffffffff9d964db8>] pci_cfg_access_unlock+0x58/0x70
> [    5.998892] but there are no more locks to release!
> [    5.998894] 
>                other info that might help us debug this:
> [    5.998898] 2 locks held by (udev-worker)/539:
> [    5.998901]  #0: ffff9d24c36ee1b0 (&dev->mutex){....}-{3:3}, at: __driver_attach+0xaf/0x1c0
> [    5.998911]  #1: ffff9d24c1fb11b0 (&dev->mutex){....}-{3:3}, at: pci_bus_trylock+0x2b/0x100
> [    5.998920] 
>                stack backtrace:
> [    5.998924] CPU: 12 PID: 539 Comm: (udev-worker) Tainted: G        W          6.10.0-rc1+ #21
> [    5.998930] Hardware name: Dell Inc. XPS 9320/01YN3R, BIOS 2.11.0 03/06/2024
> [    5.998934] Call Trace:
> [    5.998937]  <TASK>
> [    5.998940]  dump_stack_lvl+0x68/0x90
> [    5.998945]  ? pci_cfg_access_unlock+0x58/0x70
> [    5.998951]  lock_release.cold+0x21/0x2e
> [    5.998958]  pci_reset_bus+0x132/0x3a0
> [    5.998962]  vmd_probe+0x760/0xa30 [vmd]
> [    5.998971]  local_pci_probe+0x3e/0x80
> [    5.998975]  pci_device_probe+0xaf/0x250
> [    5.998981]  really_probe+0xdb/0x340
> [    5.998985]  ? pm_runtime_barrier+0x50/0x90
> [    5.998990]  ? __pfx___driver_attach+0x10/0x10
> [    5.998994]  __driver_probe_device+0x78/0x110
> [    5.998999]  driver_probe_device+0x1f/0xa0
> [    5.999004]  __driver_attach+0xba/0x1c0
> [    5.999008]  bus_for_each_dev+0x68/0xb0
> [    5.999014]  bus_add_driver+0x111/0x1f0
> [    5.999019]  driver_register+0x6e/0xc0
> [    5.999023]  ? __pfx_vmd_drv_init+0x10/0x10 [vmd]
> [    5.999029]  do_one_initcall+0x5b/0x3a0
> [    5.999034]  ? kmalloc_trace_noprof+0x25c/0x320
> [    5.999041]  do_init_module+0x60/0x220
> [    5.999047]  __do_sys_init_module+0x15f/0x190
> [    5.999054]  do_syscall_64+0x93/0x180
> [    5.999059]  ? do_syscall_64+0x9f/0x180
> [    5.999063]  ? lockdep_hardirqs_on+0x78/0x100
> [    5.999069]  ? do_syscall_64+0x9f/0x180
> [    5.999073]  ? do_syscall_64+0x9f/0x180
> [    5.999077]  ? do_user_addr_fault+0x392/0x710
> [    5.999081]  ? exc_page_fault+0x126/0x260
> [    5.999087]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [    5.999094] RIP: 0033:0x7f32c34af57e
> [    5.999099] Code: 48 8b 0d 9d 98 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 af 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 6a 98 0c 00 f7 d8 64 89 01 48
> [    5.999109] RSP: 002b:00007ffe33fbb568 EFLAGS: 00000246 ORIG_RAX: 00000000000000af
> [    5.999115] RAX: ffffffffffffffda RBX: 000055beacde5da0 RCX: 00007f32c34af57e
> [    5.999120] RDX: 00007f32c35c707d RSI: 000000000000a509 RDI: 000055beacdf1800
> [    5.999124] RBP: 00007ffe33fbb620 R08: 000055beacdb4010 R09: 0000000000000007
> [    5.999129] R10: 0000000000000002 R11: 0000000000000246 R12: 00007f32c35c707d
> [    5.999133] R13: 0000000000020000 R14: 000055beacde77a0 R15: 000055beacde5e90
> [    5.999140]  </TASK>
> [    5.999148] pci 10000:e0:06.0: bridge window [mem 0x72000000-0x720fffff]: assigned
> [    5.999155] pci 10000:e0:06.0: bridge window [io  size 0x1000]: can't assign; no space
> [    5.999161] pci 10000:e0:06.0: bridge window [io  size 0x1000]: failed to assign
> [    5.999167] pci 10000:e1:00.0: BAR 0 [mem 0x72000000-0x72003fff 64bit]: assigned
> [    5.999180] pci 10000:e0:06.0: PCI bridge to [bus e1]
> [    5.999187] pci 10000:e0:06.0:   bridge window [mem 0x72000000-0x720fffff]
> [    5.999211] pci 10000:e1:00.0: can't override BIOS ASPM; OS doesn't have ASPM control
> [    5.999238] pcieport 10000:e0:06.0: can't derive routing for PCI INT D
> [    5.999239] pcieport 10000:e0:06.0: PCI INT D: no GSI
> [    5.999749] pcieport 10000:e0:06.0: PME: Signaling with IRQ 161
> [    5.999847] vmd 0000:00:0e.0: Bound to PCI domain 10000
> 
> 
> Regards,
> 
> Hans
> 
> 
> 

