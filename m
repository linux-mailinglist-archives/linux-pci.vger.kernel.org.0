Return-Path: <linux-pci+bounces-17164-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13BEE9D4E0D
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2024 14:46:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D6A01F2130A
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2024 13:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719D31D0405;
	Thu, 21 Nov 2024 13:46:27 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A851230983
	for <linux-pci@vger.kernel.org>; Thu, 21 Nov 2024 13:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732196787; cv=none; b=OUHG1ElkgvXtHN0JdTDZe9IzNsmM9ShX4SOSupz+jlLxMGumXp3qaLLsKW8u0goO3dtZxbtc04E2ZQs7WGHJ44hJ5mFENzOFC9X9ugKa3+Avs84QaBLG8dEbVXLLLXuEvnU/zegqZwwLyPmBhot3OEUv18VVI9wPwa1BdI5wa/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732196787; c=relaxed/simple;
	bh=XGTwLO/A7JGdGXM863bmWbSjL0u5sFOh+oyZwem/qOs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=N3WAXdIbLzd8mr5iNPzdymz0UkpwHv98jACp2DTmyVwCYhppVnjyPaeg73X+0XQHlDq3F37FqGqXzIRL+awq81UG1xXJSeXlaOadrmP28GY0EbR8IZE5AvO5pGCx/33PAYFtydgsANQEfBU8bN0hZxc6Lq7su0siQMGEiyr+WT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a77a2d9601so9998565ab.3
        for <linux-pci@vger.kernel.org>; Thu, 21 Nov 2024 05:46:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732196785; x=1732801585;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aeaUCVRvA2JA7iB9SOKNpFV0GIZ++rUQUyZ9/rH0aYI=;
        b=DASyQcfg5tp7oxELDvgcdc5zsvfm03xq2FRw3Jw1ZTO6o8++kS1NgFTjHYcG59XLwP
         VbyYAofz83mjaLf0iOlS2m/CHw52ynjN/AtZEmIruXbV8Bo8KN1TAaYzWIXxe3Pz70v4
         yv0A3dfNLGRORjjyszMUwX1xwG/uTn7OO1l8elMa6yqh3fLe9PCzrbiaDEeadKiMbkkj
         K1Dkk9OfLdvtuonuQnDLFScFM5JAytADWcUyPl2UpzWBHJnk1VVi8fa7IBJ5tanoZ+8N
         fPN04meuxIVlDt5aT/71avVD0rn2d5D2lQDvxqfEWVD7YfwlfJkb93xeiyEMOqzVO3B6
         jAOg==
X-Forwarded-Encrypted: i=1; AJvYcCUser05L9+Oc3yhuSS9Uy05uus8uOCg+3KhDUtwY3hXoZFleO0oCmnv4iEJDmtEmX57NL3UpQK44s8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTrSDCCzV+v59eo5+bT/0wqRacTiuhEbnLqvhesu0kM0hG/FDs
	P+5fr0yzPgC/U+0TIH2vwVzjb+jZZ1cLiDjw71IcYXm1O4c1G2fFO7aNT0zM354WM532UWGhVdi
	APuPIv3ngz6tYjgYP+NerEJSkSELsT9HoCOS3ZlGkS2UQb57/eBHrcRI=
X-Google-Smtp-Source: AGHT+IHJ3MvkRDjuaZSA7995ihtx+znw6D89Hb+9wchR4KB0Sh4omPbeGzBUxQ7oHXgcqM9Itprz+FjSNBk/KNDMXhiNTTTN6arK
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a67:b0:3a7:6636:eb48 with SMTP id
 e9e14a558f8ab-3a7865842b2mr66340925ab.18.1732196784796; Thu, 21 Nov 2024
 05:46:24 -0800 (PST)
Date: Thu, 21 Nov 2024 05:46:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <673f39b0.050a0220.363a1b.0126.GAE@google.com>
Subject: [syzbot] [pci?] linux-next test error: general protection fault in of_pci_supply_present
From: syzbot <syzbot+0058f72ff908dfa2dbf5@syzkaller.appspotmail.com>
To: bhelgaas@google.com, linux-kernel@vger.kernel.org, 
	linux-next@vger.kernel.org, linux-pci@vger.kernel.org, sfr@canb.auug.org.au, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    decc701f41d0 Add linux-next specific files for 20241121
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=14bceb78580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=45719eec4c74e6ba
dashboard link: https://syzkaller.appspot.com/bug?extid=0058f72ff908dfa2dbf5
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a9775a56bebc/disk-decc701f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/46688e4c6405/vmlinux-decc701f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0d11b152c43f/bzImage-decc701f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0058f72ff908dfa2dbf5@syzkaller.appspotmail.com

NET: Registered PF_QIPCRTR protocol family
dca service started, version 1.12.1
PCI: Using configuration type 1 for base access
HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
cryptd: max_cpu_qlen set to 1000
raid6: skipped pq benchmark and selected avx2x4
raid6: using avx2x2 recovery algorithm
ACPI: Added _OSI(Module Device)
ACPI: Added _OSI(Processor Device)
ACPI: Added _OSI(3.0 _SCP Extensions)
ACPI: Added _OSI(Processor Aggregator Device)
ACPI: 2 ACPI AML tables successfully acquired and loaded
ACPI: Interpreter enabled
ACPI: PM: (supports S0 S3 S4 S5)
ACPI: Using IOAPIC for interrupt routing
PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
PCI: Ignoring E820 reservations for host bridge windows
ACPI: Enabled 16 GPEs in block 00 to 0F
ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
acpi PNP0A03:00: _OSC: OS supports [ASPM ClockPM Segments MSI HPX-Type3]
acpi PNP0A03:00: _OSC: not requesting OS control; OS requires [ExtendedConfig ASPM ClockPM MSI]
acpi PNP0A03:00: fail to add MMCONFIG information, can't access extended configuration space under this bridge
PCI host bridge to bus 0000:00
pci_bus 0000:00: Unknown NUMA node; performance will be reduced
pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
pci_bus 0000:00: root bus resource [mem 0xc0000000-0xfebfefff window]
pci_bus 0000:00: root bus resource [bus 00-ff]
pci 0000:00:00.0: [8086:1237] type 00 class 0x060000 conventional PCI endpoint
pci 0000:00:01.0: [8086:7110] type 00 class 0x060100 conventional PCI endpoint
pci 0000:00:01.3: [8086:7113] type 00 class 0x068000 conventional PCI endpoint
pci 0000:00:01.3: quirk: [io  0xb000-0xb03f] claimed by PIIX4 ACPI
pci 0000:00:03.0: [1af4:1004] type 00 class 0x000000 conventional PCI endpoint
pci 0000:00:03.0: BAR 0 [io  0xc000-0xc03f]
pci 0000:00:03.0: BAR 1 [mem 0xfe800000-0xfe80007f]
pci 0000:00:04.0: [1af4:1000] type 00 class 0x020000 conventional PCI endpoint
pci 0000:00:04.0: BAR 0 [io  0xc040-0xc07f]
pci 0000:00:04.0: BAR 1 [mem 0xfe801000-0xfe80107f]
pci 0000:00:05.0: [1ae0:a002] type 00 class 0x030000 conventional PCI endpoint
pci 0000:00:05.0: BAR 0 [mem 0xfe000000-0xfe7fffff]
pci 0000:00:05.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
pci 0000:00:06.0: [1af4:1002] type 00 class 0x00ff00 conventional PCI endpoint
pci 0000:00:06.0: BAR 0 [io  0xc080-0xc09f]
pci 0000:00:07.0: [1af4:1005] type 00 class 0x00ff00 conventional PCI endpoint
pci 0000:00:07.0: BAR 0 [io  0xc0a0-0xc0bf]
pci 0000:00:07.0: BAR 1 [mem 0xfe802000-0xfe80203f]
Oops: general protection fault, probably for non-canonical address 0xdffffc000000000b: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000058-0x000000000000005f]
CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.12.0-next-20241121-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
RIP: 0010:of_pci_supply_present+0x25/0xe0
Code: 90 90 90 90 90 66 0f 1f 00 55 41 56 53 48 89 fb 49 be 00 00 00 00 00 fc ff df e8 96 78 93 fc 48 83 c3 58 48 89 d8 48 c1 e8 03 <42> 80 3c 30 00 74 08 48 89 df e8 5c 69 fe fc 48 8b 1b 48 85 db 74
RSP: 0000:ffffc90000066818 EFLAGS: 00010202
RAX: 000000000000000b RBX: 0000000000000058 RCX: ffff88801bef0000
RDX: 0000000000000000 RSI: 0000000000000008 RDI: 0000000000000000
RBP: ffff8881446f4488 R08: ffffffff8bbde83d R09: 1ffff11003ad2311
R10: dffffc0000000000 R11: ffffed1003ad2312 R12: ffff8881446f4000
R13: dffffc0000000000 R14: dffffc0000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff88823ffff000 CR3: 000000000e736000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 pci_bus_add_device+0x1a9/0x340 drivers/pci/bus.c:408
 pci_bus_add_devices+0x94/0x1c0 drivers/pci/bus.c:439
 acpi_pci_root_add+0x2112/0x30f0 drivers/acpi/pci_root.c:761
 acpi_scan_attach_handler drivers/acpi/scan.c:2260 [inline]
 acpi_bus_attach+0x7ab/0xcb0 drivers/acpi/scan.c:2309
 device_for_each_child+0x118/0x1b0 drivers/base/core.c:3994
 acpi_dev_for_each_child+0xd0/0x110 drivers/acpi/bus.c:1157
 acpi_bus_attach+0x9f4/0xcb0 drivers/acpi/scan.c:2329
 device_for_each_child+0x118/0x1b0 drivers/base/core.c:3994
 acpi_dev_for_each_child+0xd0/0x110 drivers/acpi/bus.c:1157
 acpi_bus_attach+0x9f4/0xcb0 drivers/acpi/scan.c:2329
 acpi_bus_scan+0x12b/0x560 drivers/acpi/scan.c:2610
 acpi_scan_init+0x267/0x730 drivers/acpi/scan.c:2747
 acpi_init+0x159/0x240 drivers/acpi/bus.c:1466
 do_one_initcall+0x248/0x880 init/main.c:1266
 do_initcall_level+0x157/0x210 init/main.c:1328
 do_initcalls+0x3f/0x80 init/main.c:1344
 kernel_init_freeable+0x435/0x5d0 init/main.c:1577
 kernel_init+0x1d/0x2b0 init/main.c:1466
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:of_pci_supply_present+0x25/0xe0
Code: 90 90 90 90 90 66 0f 1f 00 55 41 56 53 48 89 fb 49 be 00 00 00 00 00 fc ff df e8 96 78 93 fc 48 83 c3 58 48 89 d8 48 c1 e8 03 <42> 80 3c 30 00 74 08 48 89 df e8 5c 69 fe fc 48 8b 1b 48 85 db 74
RSP: 0000:ffffc90000066818 EFLAGS: 00010202
RAX: 000000000000000b RBX: 0000000000000058 RCX: ffff88801bef0000
RDX: 0000000000000000 RSI: 0000000000000008 RDI: 0000000000000000
RBP: ffff8881446f4488 R08: ffffffff8bbde83d R09: 1ffff11003ad2311
R10: dffffc0000000000 R11: ffffed1003ad2312 R12: ffff8881446f4000
R13: dffffc0000000000 R14: dffffc0000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff88823ffff000 CR3: 000000000e736000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	90                   	nop
   1:	90                   	nop
   2:	90                   	nop
   3:	90                   	nop
   4:	90                   	nop
   5:	66 0f 1f 00          	nopw   (%rax)
   9:	55                   	push   %rbp
   a:	41 56                	push   %r14
   c:	53                   	push   %rbx
   d:	48 89 fb             	mov    %rdi,%rbx
  10:	49 be 00 00 00 00 00 	movabs $0xdffffc0000000000,%r14
  17:	fc ff df
  1a:	e8 96 78 93 fc       	call   0xfc9378b5
  1f:	48 83 c3 58          	add    $0x58,%rbx
  23:	48 89 d8             	mov    %rbx,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 30 00       	cmpb   $0x0,(%rax,%r14,1) <-- trapping instruction
  2f:	74 08                	je     0x39
  31:	48 89 df             	mov    %rbx,%rdi
  34:	e8 5c 69 fe fc       	call   0xfcfe6995
  39:	48 8b 1b             	mov    (%rbx),%rbx
  3c:	48 85 db             	test   %rbx,%rbx
  3f:	74                   	.byte 0x74


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

