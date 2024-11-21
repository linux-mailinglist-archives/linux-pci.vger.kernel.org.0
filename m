Return-Path: <linux-pci+bounces-17173-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2071C9D50F5
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2024 17:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6FBA1F231D7
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2024 16:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B901A42A5;
	Thu, 21 Nov 2024 16:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iC8HuUGy"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B731A08A3;
	Thu, 21 Nov 2024 16:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732207797; cv=none; b=SewSRdY+Q3q/Um9BBLQDRjnAwxpOSi1azpEnh+F4UE4tVff82/6U30VjOzneILRjsEaMapmNx8YYu2+QySKXCDV2Ak8adED+WN5eVi5NegKnn+37gi4E12KqHUwAohzLcYzpFmKOD4rhsONKBe/DnBUVnLHPurP03/9xkWr8gco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732207797; c=relaxed/simple;
	bh=cJJ52sojpaSaxkTBGKNoCKPWm4vXsAZgcjIjAZEfVkY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=gCp+nk1tOhGWF7oHqMYk666qiBX+RSAK2YZYSif4kpd4XehlQ/3rv4GeCOy6BOGH4oMrOs2Ij6BM5V/QZcdZjt4+/Gnuz1ofUpdqzJ93+IWHK2o0b4tBVRHM4zxTCQE+XQO3Zn+xnfkHdDm1rHrVxBt+hTnSkemz/So2mmrQfy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iC8HuUGy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 612C9C4CED0;
	Thu, 21 Nov 2024 16:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732207797;
	bh=cJJ52sojpaSaxkTBGKNoCKPWm4vXsAZgcjIjAZEfVkY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=iC8HuUGyTjQHTJh/puTCypw3YM2UhI9LvfOtWf8oByYPZ3kmAi70cEsNP8cSmTqPa
	 g4O55bwuj97PHUW7RQEYh/QkIbIvMnnVsV+IX0gemM0GOQAHiqTWkyJLtEZ5EN0chk
	 pUBKvw7K/gNHRLAP08f3d+VXNMO7ZUYmGQMWQnCgHSn1nDw+uB/Hna8tki+isNCxFn
	 MioE5w4kOWKEvxfgwKW/ZSEhEUz/ZM2293FKt8c56oGQrYzUJIxlauVWDwcXjctd9x
	 nio5bPtDjFD+tDGxPDULklDRUNWknSsWoWwcYtlYWcueqKFHTbEM6uwB8gaImBoOI6
	 iEzvkdOchw/5g==
Date: Thu, 21 Nov 2024 10:49:56 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: syzbot <syzbot+0058f72ff908dfa2dbf5@syzkaller.appspotmail.com>
Cc: bhelgaas@google.com, linux-kernel@vger.kernel.org,
	linux-next@vger.kernel.org, linux-pci@vger.kernel.org,
	sfr@canb.auug.org.au, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [pci?] linux-next test error: general protection fault
 in of_pci_supply_present
Message-ID: <20241121164956.GA2388306@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <673f39b0.050a0220.363a1b.0126.GAE@google.com>

On Thu, Nov 21, 2024 at 05:46:24AM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    decc701f41d0 Add linux-next specific files for 20241121
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=14bceb78580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=45719eec4c74e6ba
> dashboard link: https://syzkaller.appspot.com/bug?extid=0058f72ff908dfa2dbf5
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/a9775a56bebc/disk-decc701f.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/46688e4c6405/vmlinux-decc701f.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/0d11b152c43f/bzImage-decc701f.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+0058f72ff908dfa2dbf5@syzkaller.appspotmail.com
> 
> NET: Registered PF_QIPCRTR protocol family
> dca service started, version 1.12.1
> PCI: Using configuration type 1 for base access
> HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
> HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
> HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
> HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
> cryptd: max_cpu_qlen set to 1000
> raid6: skipped pq benchmark and selected avx2x4
> raid6: using avx2x2 recovery algorithm
> ACPI: Added _OSI(Module Device)
> ACPI: Added _OSI(Processor Device)
> ACPI: Added _OSI(3.0 _SCP Extensions)
> ACPI: Added _OSI(Processor Aggregator Device)
> ACPI: 2 ACPI AML tables successfully acquired and loaded
> ACPI: Interpreter enabled
> ACPI: PM: (supports S0 S3 S4 S5)
> ACPI: Using IOAPIC for interrupt routing
> PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
> PCI: Ignoring E820 reservations for host bridge windows
> ACPI: Enabled 16 GPEs in block 00 to 0F
> ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
> acpi PNP0A03:00: _OSC: OS supports [ASPM ClockPM Segments MSI HPX-Type3]
> acpi PNP0A03:00: _OSC: not requesting OS control; OS requires [ExtendedConfig ASPM ClockPM MSI]
> acpi PNP0A03:00: fail to add MMCONFIG information, can't access extended configuration space under this bridge
> PCI host bridge to bus 0000:00
> pci_bus 0000:00: Unknown NUMA node; performance will be reduced
> pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
> pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
> pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
> pci_bus 0000:00: root bus resource [mem 0xc0000000-0xfebfefff window]
> pci_bus 0000:00: root bus resource [bus 00-ff]
> pci 0000:00:00.0: [8086:1237] type 00 class 0x060000 conventional PCI endpoint
> pci 0000:00:01.0: [8086:7110] type 00 class 0x060100 conventional PCI endpoint
> pci 0000:00:01.3: [8086:7113] type 00 class 0x068000 conventional PCI endpoint
> pci 0000:00:01.3: quirk: [io  0xb000-0xb03f] claimed by PIIX4 ACPI
> pci 0000:00:03.0: [1af4:1004] type 00 class 0x000000 conventional PCI endpoint
> pci 0000:00:03.0: BAR 0 [io  0xc000-0xc03f]
> pci 0000:00:03.0: BAR 1 [mem 0xfe800000-0xfe80007f]
> pci 0000:00:04.0: [1af4:1000] type 00 class 0x020000 conventional PCI endpoint
> pci 0000:00:04.0: BAR 0 [io  0xc040-0xc07f]
> pci 0000:00:04.0: BAR 1 [mem 0xfe801000-0xfe80107f]
> pci 0000:00:05.0: [1ae0:a002] type 00 class 0x030000 conventional PCI endpoint
> pci 0000:00:05.0: BAR 0 [mem 0xfe000000-0xfe7fffff]
> pci 0000:00:05.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
> pci 0000:00:06.0: [1af4:1002] type 00 class 0x00ff00 conventional PCI endpoint
> pci 0000:00:06.0: BAR 0 [io  0xc080-0xc09f]
> pci 0000:00:07.0: [1af4:1005] type 00 class 0x00ff00 conventional PCI endpoint
> pci 0000:00:07.0: BAR 0 [io  0xc0a0-0xc0bf]
> pci 0000:00:07.0: BAR 1 [mem 0xfe802000-0xfe80203f]
> Oops: general protection fault, probably for non-canonical address 0xdffffc000000000b: 0000 [#1] PREEMPT SMP KASAN PTI
> KASAN: null-ptr-deref in range [0x0000000000000058-0x000000000000005f]
> CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.12.0-next-20241121-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
> RIP: 0010:of_pci_supply_present+0x25/0xe0
> Code: 90 90 90 90 90 66 0f 1f 00 55 41 56 53 48 89 fb 49 be 00 00 00 00 00 fc ff df e8 96 78 93 fc 48 83 c3 58 48 89 d8 48 c1 e8 03 <42> 80 3c 30 00 74 08 48 89 df e8 5c 69 fe fc 48 8b 1b 48 85 db 74
> RSP: 0000:ffffc90000066818 EFLAGS: 00010202
> RAX: 000000000000000b RBX: 0000000000000058 RCX: ffff88801bef0000
> RDX: 0000000000000000 RSI: 0000000000000008 RDI: 0000000000000000
> RBP: ffff8881446f4488 R08: ffffffff8bbde83d R09: 1ffff11003ad2311
> R10: dffffc0000000000 R11: ffffed1003ad2312 R12: ffff8881446f4000
> R13: dffffc0000000000 R14: dffffc0000000000 R15: 0000000000000000
> FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffff88823ffff000 CR3: 000000000e736000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  pci_bus_add_device+0x1a9/0x340 drivers/pci/bus.c:408
>  pci_bus_add_devices+0x94/0x1c0 drivers/pci/bus.c:439
>  acpi_pci_root_add+0x2112/0x30f0 drivers/acpi/pci_root.c:761
>  acpi_scan_attach_handler drivers/acpi/scan.c:2260 [inline]
>  acpi_bus_attach+0x7ab/0xcb0 drivers/acpi/scan.c:2309
>  device_for_each_child+0x118/0x1b0 drivers/base/core.c:3994
>  acpi_dev_for_each_child+0xd0/0x110 drivers/acpi/bus.c:1157
>  acpi_bus_attach+0x9f4/0xcb0 drivers/acpi/scan.c:2329
>  device_for_each_child+0x118/0x1b0 drivers/base/core.c:3994
>  acpi_dev_for_each_child+0xd0/0x110 drivers/acpi/bus.c:1157
>  acpi_bus_attach+0x9f4/0xcb0 drivers/acpi/scan.c:2329
>  acpi_bus_scan+0x12b/0x560 drivers/acpi/scan.c:2610
>  acpi_scan_init+0x267/0x730 drivers/acpi/scan.c:2747
>  acpi_init+0x159/0x240 drivers/acpi/bus.c:1466
>  do_one_initcall+0x248/0x880 init/main.c:1266
>  do_initcall_level+0x157/0x210 init/main.c:1328
>  do_initcalls+0x3f/0x80 init/main.c:1344
>  kernel_init_freeable+0x435/0x5d0 init/main.c:1577
>  kernel_init+0x1d/0x2b0 init/main.c:1466
>  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:of_pci_supply_present+0x25/0xe0
> Code: 90 90 90 90 90 66 0f 1f 00 55 41 56 53 48 89 fb 49 be 00 00 00 00 00 fc ff df e8 96 78 93 fc 48 83 c3 58 48 89 d8 48 c1 e8 03 <42> 80 3c 30 00 74 08 48 89 df e8 5c 69 fe fc 48 8b 1b 48 85 db 74
> RSP: 0000:ffffc90000066818 EFLAGS: 00010202
> RAX: 000000000000000b RBX: 0000000000000058 RCX: ffff88801bef0000
> RDX: 0000000000000000 RSI: 0000000000000008 RDI: 0000000000000000
> RBP: ffff8881446f4488 R08: ffffffff8bbde83d R09: 1ffff11003ad2311
> R10: dffffc0000000000 R11: ffffed1003ad2312 R12: ffff8881446f4000
> R13: dffffc0000000000 R14: dffffc0000000000 R15: 0000000000000000
> FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffff88823ffff000 CR3: 000000000e736000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> ----------------
> Code disassembly (best guess):
>    0:	90                   	nop
>    1:	90                   	nop
>    2:	90                   	nop
>    3:	90                   	nop
>    4:	90                   	nop
>    5:	66 0f 1f 00          	nopw   (%rax)
>    9:	55                   	push   %rbp
>    a:	41 56                	push   %r14
>    c:	53                   	push   %rbx
>    d:	48 89 fb             	mov    %rdi,%rbx
>   10:	49 be 00 00 00 00 00 	movabs $0xdffffc0000000000,%r14
>   17:	fc ff df
>   1a:	e8 96 78 93 fc       	call   0xfc9378b5
>   1f:	48 83 c3 58          	add    $0x58,%rbx
>   23:	48 89 d8             	mov    %rbx,%rax
>   26:	48 c1 e8 03          	shr    $0x3,%rax
> * 2a:	42 80 3c 30 00       	cmpb   $0x0,(%rax,%r14,1) <-- trapping instruction
>   2f:	74 08                	je     0x39
>   31:	48 89 df             	mov    %rbx,%rdi
>   34:	e8 5c 69 fe fc       	call   0xfcfe6995
>   39:	48 8b 1b             	mov    (%rbx),%rbx
>   3c:	48 85 db             	test   %rbx,%rbx
>   3f:	74                   	.byte 0x74
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title

#syz fix: 278dd091e95d ("PCI/pwrctl: Create pwrctl device only if at least one power supply is present")

https://git.kernel.org/cgit/linux/kernel/git/pci/pci.git/commit/?id=278dd091e95d
should fix this by adding back the "if (!np)" check in
of_pci_supply_present().

> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup

