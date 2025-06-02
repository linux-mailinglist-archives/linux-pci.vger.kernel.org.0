Return-Path: <linux-pci+bounces-28818-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C8FACBA11
	for <lists+linux-pci@lfdr.de>; Mon,  2 Jun 2025 19:12:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84F47169F2A
	for <lists+linux-pci@lfdr.de>; Mon,  2 Jun 2025 17:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03994221FDD;
	Mon,  2 Jun 2025 17:12:26 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C241155C87
	for <linux-pci@vger.kernel.org>; Mon,  2 Jun 2025 17:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748884345; cv=none; b=qW5s1ar6LJ0FHYXM+06hzQKHiHlZpzqqeAWekxkWdw3z9L+IAmCcd1i6DoN+54Vk240NrurlE7kguBPnlX8mWjvA6Ay7LiIg6m1KjjrPBHqWjNBNz+zgfVDYcmIMccGnnaMAidb67LWRZJCJWIJ98W4bzUful2x1oHqphS3Km9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748884345; c=relaxed/simple;
	bh=/Jq2Au0s6fmBmRE16l0X+42zzlVoPRij/zoKI3mlRZs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=eIirhWEhaQjqPP9yAV0WuhBjevaaxfz0K7qmyzGxnERxjN7waWlNyak1j9vo+HHpgHMOrFqFGIc4SxiCwX1ljBsqKjKo5AfIHSxW8SVk3G+dUFjvSYTPKqsSiTKlUksjFvHx2hfjla8pNammtwB4O7pUaKuq7DPAHxU4v0Dxiwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3ddafe52d04so22933475ab.1
        for <linux-pci@vger.kernel.org>; Mon, 02 Jun 2025 10:12:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748884343; x=1749489143;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kHzhGuS7OmKWz0RpyD6VrrayG8eHyU4NQV9hRrNlOmA=;
        b=b41LOfc3qyodb3YsUEuHwl9wLuSflTYWqQiEW1kfG1Lc6UWx3tA61RzUc/d5pR4BgX
         oWP9Zg+69fCJZRl+xkH0AC1xlMHhL+7ew7AO9+njKZWi2MOPfmYEd1/gAVctr6ikdREl
         /pwul4fYH7kL+s2KgpkDZ4jbEDEDUw4c27oBgDbp6ovlu3IVGs9FbvZDPz+U5TXKaiF+
         K0r4VWDjuFISkrNC6PHxB8gqCoXeJDsihaFH2tzGmFsPVELkbQIMnpid6ilWwFu1RzKL
         OwZcpQY1mnf3w0f4BECVYrlSomR+zrXB1AcgGargirH9IIClJ8FpS5c2mcOQuiqwd1cY
         maTA==
X-Forwarded-Encrypted: i=1; AJvYcCWtWwIa+btxvVCKfjBtrgvnLHRdWAQE4Sew76G/O5fINbh7FNBcchmcvDJsyJZkxPaO1zExkrpdH1E=@vger.kernel.org
X-Gm-Message-State: AOJu0YydTDbRVVAbaqU0Ook/K0Mm5NRuuRz7KpG4rTcgbaZfudOro5RR
	vSIKNa3Or8AkWmNprW1+Bw1AGkQNwXdndEuUEuD+5pn3scCMZlbxTxgPKz6xRNvbeqYmiUW+xpJ
	Gj8fImQKG9aIea3zwRvME10K9e9NRhdl9M4/z5PpVKKWcjroUd1yxcHKR1Ms=
X-Google-Smtp-Source: AGHT+IFe750uJ1jt4MmrE/oZGvz4+q+a2QNMcu/itzZhjuaY5EIRfkPeXtgrIYtg89ZkSVJ6WNSc63iLorEb60LyNyCtfKfORbhL
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b0f:b0:3db:6fb2:4b95 with SMTP id
 e9e14a558f8ab-3dd9cbd60dfmr143242855ab.18.1748884343382; Mon, 02 Jun 2025
 10:12:23 -0700 (PDT)
Date: Mon, 02 Jun 2025 10:12:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <683ddb77.050a0220.55ceb.0001.GAE@google.com>
Subject: [syzbot] [pci?] WARNING in pci_scan_single_device
From: syzbot <syzbot+3385a151582cae2a4b39@syzkaller.appspotmail.com>
To: bhelgaas@google.com, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    90b83efa6701 Merge tag 'bpf-next-6.16' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=152307f4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fbd871027e10b130
dashboard link: https://syzkaller.appspot.com/bug?extid=3385a151582cae2a4b39
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7b23158542c6/disk-90b83efa.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/fe77cd0d7150/vmlinux-90b83efa.xz
kernel image: https://storage.googleapis.com/syzbot-assets/fdddbd2ed303/bzImage-90b83efa.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3385a151582cae2a4b39@syzkaller.appspotmail.com

R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fbab67b5fa0 R15: 00007fff54b11b18
 </TASK>
------------[ cut here ]------------
WARNING: CPU: 1 PID: 15983 at drivers/pci/probe.c:2716 pci_device_add+0xf53/0x1390 drivers/pci/probe.c:2716
Modules linked in:
CPU: 1 UID: 0 PID: 15983 Comm: syz.5.1707 Not tainted 6.15.0-syzkaller-07774-g90b83efa6701 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
RIP: 0010:pci_device_add+0xf53/0x1390 drivers/pci/probe.c:2716
Code: 84 c0 74 06 0f 8e ae 03 00 00 0f b6 83 c0 00 00 00 c1 e5 02 83 e0 e3 09 e8 88 83 c0 00 00 00 e9 de f3 ff ff e8 0e 96 aa fc 90 <0f> 0b 90 e9 81 f8 ff ff e8 00 96 aa fc 90 0f 0b 90 90 0f 0b 90 e9
RSP: 0018:ffffc9001058f918 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 00000000fffffff4 RCX: ffffffff85104754
RDX: ffff88805524da00 RSI: ffffffff85104ed2 RDI: 0000000000000005
RBP: ffff88801b483400 R08: 0000000000000005 R09: 0000000000000000
R10: 00000000fffffff4 R11: ffffffff81000130 R12: ffff888143aa3028
R13: ffff888143aa3000 R14: 0000000000000001 R15: ffff888143abc000
FS:  00007fbab74736c0(0000) GS:ffff888124a82000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f67143b1d58 CR3: 0000000035620000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 pci_scan_single_device drivers/pci/probe.c:2737 [inline]
 pci_scan_single_device+0x325/0x470 drivers/pci/probe.c:2723
 pci_scan_slot+0x1c0/0x790 drivers/pci/probe.c:2820
 pci_scan_child_bus_extend+0x66/0x730 drivers/pci/probe.c:3039
 pci_scan_child_bus drivers/pci/probe.c:3153 [inline]
 pci_rescan_bus+0x18/0x40 drivers/pci/probe.c:3444
 dev_rescan_store+0x11b/0x140 drivers/pci/pci-sysfs.c:479
 dev_attr_store+0x58/0x80 drivers/base/core.c:2440
 sysfs_kf_write+0xef/0x150 fs/sysfs/file.c:145
 kernfs_fop_write_iter+0x354/0x510 fs/kernfs/file.c:334
 new_sync_write fs/read_write.c:593 [inline]
 vfs_write+0x6c7/0x1150 fs/read_write.c:686
 ksys_write+0x12a/0x250 fs/read_write.c:738
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x490 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fbab658e969
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fbab7473038 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007fbab67b5fa0 RCX: 00007fbab658e969
RDX: 0000000000000004 RSI: 0000200000000440 RDI: 0000000000000005
RBP: 00007fbab6610ab1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fbab67b5fa0 R15: 00007fff54b11b18
 </TASK>


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

