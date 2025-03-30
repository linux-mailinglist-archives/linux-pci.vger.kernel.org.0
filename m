Return-Path: <linux-pci+bounces-24979-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C49A75873
	for <lists+linux-pci@lfdr.de>; Sun, 30 Mar 2025 05:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11B79188D5BB
	for <lists+linux-pci@lfdr.de>; Sun, 30 Mar 2025 03:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E81BEEC8;
	Sun, 30 Mar 2025 03:20:34 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFAF6846C
	for <linux-pci@vger.kernel.org>; Sun, 30 Mar 2025 03:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743304834; cv=none; b=Lj+i5zevuXo7GIr1+0VXurQMZa3oD5YPBYb3HR7dTYOFl91wL9hfToItem65VJdudSRuRIqNcy8RwUE7U4tqXJ+4Ihn1tiY4IZSO7t9a8f0MQcibp7pslJ/G25fOZfdM8umg27i/k5Fmqz/m/GMdKaz6AQVfpPP7ymjh4KUGHho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743304834; c=relaxed/simple;
	bh=NUELN+vXwPSdRMSiBMYjLqA4DpTiYHKGcxPI9rOua0w=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=CRoE3HlpoXiGy86ML78QKbkXgNFNKRGc/yaXTPETir1qdlczcNYPxXjnZtUavESvN45uGqrDdv0uA262VKxYOLwP/pxsz0cqrDyF1VfUGPJr6WenhUY31nZhb9QCzXCDx3r+r1wV+SStMEXJU25N9tx9UDyN4K6YXsaYKGoakok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3d5b38276deso62428255ab.3
        for <linux-pci@vger.kernel.org>; Sat, 29 Mar 2025 20:20:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743304832; x=1743909632;
        h=content-transfer-encoding:to:from:subject:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rh27twaqixdY5U0tfoS2SVcqg226Y/goo21/F+KfXvQ=;
        b=v6o0/dzZI0b/ufYxFYQfleaZWDjoZZtrZKcqzZmpwhCS+sF9na1DyoXndrTxfITXlk
         KUsuDQNuFL7gEqJHWLRfZI8iMFLyHl5gA1bjqOPckckEMoQ/vc8XShfZnuJyJDMdgAbw
         iCxnEgyO+bYBZxGxJs69U62EmE4Hn0UV1HxUVOE5yVLMZa5PyYkHyy4nj7J/5Q0GPxsF
         wNyIHsAPbj4zeiaF6pqjpHREzRbbtVzbNo/VxQgct5vQrAWB27/wghvBO8T6S5j9Ek8k
         DZd4DL+KM13qY6FgEgFeccNLL5AsbIxeaUQ1HgLK/lUuKc7X06ANJYFBiPL+9vmKnpDD
         Ojuw==
X-Forwarded-Encrypted: i=1; AJvYcCXiYkPQsxdOSyj1gR2Zi8SSJYtvppk7oDzdiCtN3uYghVu8F13SFtJCbqRTiaDYCh+f4ES1kmNlvMs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4eABIHQfMA405lj2lIlVGG8yW02JCQA4DS6U+w77dpnJZcIOj
	U8DN9kHQQKJVKhCT1G30WqbKqpneRmJJ6TQ1xLoGRwVWG9tbDwhtZFnfsDJ8h8+5qD/P7rVUmxG
	kwtFuZ9kFI4qEwubIaVUu9lVU8zYdf+zJxJDiF18oRKIn0YXBSuuHar0=
X-Google-Smtp-Source: AGHT+IEbxfEUE5JoNFjGaYG0oC1oZGzxPQdJ1nGFJXPgwAfVMFlX+ycMFE3Dc13QSN0n3ZZ8B0rBq9E0wDBm7iQAZ97R9hljDWJm
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1809:b0:3d4:700f:67e7 with SMTP id
 e9e14a558f8ab-3d5e09d8e17mr38785765ab.17.1743304831902; Sat, 29 Mar 2025
 20:20:31 -0700 (PDT)
Date: Sat, 29 Mar 2025 20:20:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67e8b87f.050a0220.1547ec.0084.GAE@google.com>
Subject: [syzbot] [pci?] upstream test error: general protection fault in msix_capability_init
From: syzbot <syzbot+b6184128c9fa59212e62@syzkaller.appspotmail.com>
To: bhelgaas@google.com, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot found the following issue on:

HEAD commit:    f6e0150b2003 Merge tag 'mtd/for-6.15' of git://git.kernel..=
.
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=3D15ffd43f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D46a07195688b794=
b
dashboard link: https://syzkaller.appspot.com/bug?extid=3Db6184128c9fa59212=
e62
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debia=
n) 2.40

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f989fd9edbe9/disk-=
f6e0150b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8494075fac70/vmlinux-=
f6e0150b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/eef916e9c416/bzI=
mage-f6e0150b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit=
:
Reported-by: syzbot+b6184128c9fa59212e62@syzkaller.appspotmail.com

ntfs3: Enabled Linux POSIX ACLs support
ntfs3: Read-only LZX/Xpress compression included
efs: 1.0a - http://aeschi.ch.eu.org/efs/
jffs2: version 2.2. (NAND) (SUMMARY)  =C2=A9 2001-2006 Red Hat, Inc.
romfs: ROMFS MTD (C) 2007 Red Hat, Inc.
QNX4 filesystem 0.2.3 registered.
qnx6: QNX6 filesystem 1.0.0 registered.
fuse: init (API version 7.42)
orangefs_debugfs_init: called with debug mask: :none: :0:
orangefs_init: module version upstream loaded
JFS: nTxBlock =3D 8192, nTxLock =3D 65536
SGI XFS with ACLs, security attributes, realtime, quota, no debug enabled
9p: Installing v9fs 9p2000 file system support
NILFS version 2 loaded
befs: version: 0.9.3
ocfs2: Registered cluster interface o2cb
ocfs2: Registered cluster interface user
OCFS2 User DLM kernel interface loaded
gfs2: GFS2 installed
ceph: loaded (mds proto 32)
NET: Registered PF_ALG protocol family
xor: automatically using best checksumming function   avx      =20
async_tx: api initialized (async)
Key type asymmetric registered
Asymmetric key parser 'x509' registered
Asymmetric key parser 'pkcs8' registered
Key type pkcs7_test registered
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 238)
io scheduler mq-deadline registered
io scheduler kyber registered
io scheduler bfq registered
input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
ACPI: button: Power Button [PWRF]
input: Sleep Button as /devices/LNXSYSTM:00/LNXSLPBN:00/input/input1
ACPI: button: Sleep Button [SLPF]
ioatdma: Intel(R) QuickData Technology Driver 5.00
ACPI: \_SB_.LNKC: Enabled at IRQ 11
virtio-pci 0000:00:03.0: virtio_pci: leaving for legacy driver
ACPI: \_SB_.LNKD: Enabled at IRQ 10
virtio-pci 0000:00:04.0: virtio_pci: leaving for legacy driver
ACPI: \_SB_.LNKB: Enabled at IRQ 10
virtio-pci 0000:00:06.0: virtio_pci: leaving for legacy driver
virtio-pci 0000:00:07.0: virtio_pci: leaving for legacy driver
N_HDLC line discipline registered with maxframe=3D4096
Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
00:03: ttyS0 at I/O 0x3f8 (irq =3D 4, base_baud =3D 115200) is a 16550A
00:04: ttyS1 at I/O 0x2f8 (irq =3D 3, base_baud =3D 115200) is a 16550A
00:05: ttyS2 at I/O 0x3e8 (irq =3D 6, base_baud =3D 115200) is a 16550A
00:06: ttyS3 at I/O 0x2e8 (irq =3D 7, base_baud =3D 115200) is a 16550A
Non-volatile memory driver v1.3
Oops: general protection fault, probably for non-canonical address 0xdffffc=
0000000000: 0000 [#1] SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 1 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.14.0-syzkaller-03565-gf6=
e0150b2003 #0 PREEMPT(full)=20
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Goo=
gle 02/12/2025
RIP: 0010:msix_prepare_msi_desc drivers/pci/msi/msi.c:615 [inline]
RIP: 0010:msix_setup_msi_descs drivers/pci/msi/msi.c:639 [inline]
RIP: 0010:__msix_setup_interrupts drivers/pci/msi/msi.c:672 [inline]
RIP: 0010:msix_setup_interrupts drivers/pci/msi/msi.c:701 [inline]
RIP: 0010:msix_capability_init+0x7a0/0x1550 drivers/pci/msi/msi.c:743
Code: 10 00 74 0f e8 81 aa e7 fc 48 ba 00 00 00 00 00 fc ff df 48 89 9c 24 =
d8 00 00 00 48 89 9c 24 a0 01 00 00 4c 89 f0 48 c1 e8 03 <0f> b6 04 10 84 c=
0 0f 85 75 02 00 00 41 8b 1e be 00 00 40 00 21 de
RSP: 0000:ffffc90000066ee0 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffffc9000008e008 RCX: ffff88801cac8000
RDX: dffffc0000000000 RSI: 0000000000000000 RDI: ffffc90000067080
RBP: ffffc90000067138 R08: ffffffff8543f82f R09: 0000000000000000
R10: ffffc90000067020 R11: fffff5200000ce11 R12: 0000000000000000
R13: 0000000000000101 R14: 0000000000000000 R15: 1ffff9200000ce0e
FS:  0000000000000000(0000) GS:ffff888125324000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000000e938000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __pci_enable_msix_range+0x5c7/0x710 drivers/pci/msi/msi.c:851
 pci_alloc_irq_vectors_affinity+0x10e/0x2b0 drivers/pci/msi/api.c:268
 vp_request_msix_vectors drivers/virtio/virtio_pci_common.c:160 [inline]
 vp_find_vqs_msix+0x5da/0xeb0 drivers/virtio/virtio_pci_common.c:417
 vp_find_vqs+0xa0/0x7e0 drivers/virtio/virtio_pci_common.c:525
 virtio_find_vqs include/linux/virtio_config.h:226 [inline]
 virtio_find_single_vq include/linux/virtio_config.h:237 [inline]
 probe_common+0x37b/0x6b0 drivers/char/hw_random/virtio-rng.c:155
 virtio_dev_probe+0x931/0xc80 drivers/virtio/virtio.c:341
 really_probe+0x2b9/0xad0 drivers/base/dd.c:658
 __driver_probe_device+0x1a2/0x390 drivers/base/dd.c:800
 driver_probe_device+0x50/0x430 drivers/base/dd.c:830
 __driver_attach+0x45f/0x710 drivers/base/dd.c:1216
 bus_for_each_dev+0x23e/0x2b0 drivers/base/bus.c:370
 bus_add_driver+0x346/0x670 drivers/base/bus.c:678
 driver_register+0x23a/0x320 drivers/base/driver.c:249
 do_one_initcall+0x24a/0x940 init/main.c:1257
 do_initcall_level+0x157/0x210 init/main.c:1319
 do_initcalls+0x71/0xd0 init/main.c:1335
 kernel_init_freeable+0x432/0x5d0 init/main.c:1567
 kernel_init+0x1d/0x2b0 init/main.c:1457
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:msix_prepare_msi_desc drivers/pci/msi/msi.c:615 [inline]
RIP: 0010:msix_setup_msi_descs drivers/pci/msi/msi.c:639 [inline]
RIP: 0010:__msix_setup_interrupts drivers/pci/msi/msi.c:672 [inline]
RIP: 0010:msix_setup_interrupts drivers/pci/msi/msi.c:701 [inline]
RIP: 0010:msix_capability_init+0x7a0/0x1550 drivers/pci/msi/msi.c:743
Code: 10 00 74 0f e8 81 aa e7 fc 48 ba 00 00 00 00 00 fc ff df 48 89 9c 24 =
d8 00 00 00 48 89 9c 24 a0 01 00 00 4c 89 f0 48 c1 e8 03 <0f> b6 04 10 84 c=
0 0f 85 75 02 00 00 41 8b 1e be 00 00 40 00 21 de
RSP: 0000:ffffc90000066ee0 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffffc9000008e008 RCX: ffff88801cac8000
RDX: dffffc0000000000 RSI: 0000000000000000 RDI: ffffc90000067080
RBP: ffffc90000067138 R08: ffffffff8543f82f R09: 0000000000000000
R10: ffffc90000067020 R11: fffff5200000ce11 R12: 0000000000000000
R13: 0000000000000101 R14: 0000000000000000 R15: 1ffff9200000ce0e
FS:  0000000000000000(0000) GS:ffff888125324000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000000e938000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	10 00                	adc    %al,(%rax)
   2:	74 0f                	je     0x13
   4:	e8 81 aa e7 fc       	call   0xfce7aa8a
   9:	48 ba 00 00 00 00 00 	movabs $0xdffffc0000000000,%rdx
  10:	fc ff df
  13:	48 89 9c 24 d8 00 00 	mov    %rbx,0xd8(%rsp)
  1a:	00
  1b:	48 89 9c 24 a0 01 00 	mov    %rbx,0x1a0(%rsp)
  22:	00
  23:	4c 89 f0             	mov    %r14,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	0f b6 04 10          	movzbl (%rax,%rdx,1),%eax <-- trapping instruct=
ion
  2e:	84 c0                	test   %al,%al
  30:	0f 85 75 02 00 00    	jne    0x2ab
  36:	41 8b 1e             	mov    (%r14),%ebx
  39:	be 00 00 40 00       	mov    $0x400000,%esi
  3e:	21 de                	and    %ebx,%esi


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

