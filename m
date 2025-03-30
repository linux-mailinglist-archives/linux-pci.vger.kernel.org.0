Return-Path: <linux-pci+bounces-24988-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 868CEA75B08
	for <lists+linux-pci@lfdr.de>; Sun, 30 Mar 2025 18:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C98D18860B3
	for <lists+linux-pci@lfdr.de>; Sun, 30 Mar 2025 16:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D563E1D63FF;
	Sun, 30 Mar 2025 16:49:25 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E54158DAC
	for <linux-pci@vger.kernel.org>; Sun, 30 Mar 2025 16:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743353365; cv=none; b=bZD6H8JA4MTRtoIr8rMwgSyOoR9lPFm6JzV7pQMKwtx/PGlQhVkkqjTKsebgJnv1IfMXN9J7p5PiiOo+xHhLRWPnCZJEIjHkWCryeydHPc2DfZmNjbOLMXWdwgJaDU4OUjXml8ve3e5dO7IO6VmqLLNvRq3vfByPeSef4Fid2hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743353365; c=relaxed/simple;
	bh=Rotij54UFFk4RIsTJUj0wQuIyrGwRDOa95FKRBCoGrM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=iNiKes/S8HX++RDVau9jUkQPuFV9fRXANxiqEWgFrl7NuhndCcf8gbXCJ1w/3Af0WS4Ov9nGIWERWwflsm6s4LkozNFdS6FGt60dr2EfjOLKE201982CHxNrHPyEpMhEIO6l44ycEz95Q6Azmjm+CvJANhI3onyNUt+4tVLwEYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-85b5a7981ccso302683039f.2
        for <linux-pci@vger.kernel.org>; Sun, 30 Mar 2025 09:49:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743353363; x=1743958163;
        h=content-transfer-encoding:to:from:subject:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LE20gacpJ7CUGQ399uU8cCpXQYPsgn0uU3toEwL1Qck=;
        b=ejEki7ZutdjB50GIyrBWdoko/ileG9bQ6VJpqbK//tEPHdBHU3O0LH2YwwxSqSzwe5
         BnzEV2Jfm9+cNJ32jtVMfvh3IFsdCKxLJKy4TgVZg71LQtPYKmOj+MEY7VqVoDMVbcuA
         wIuka+7GzuRWv1EB1Qf/cAykjuXZlpsCVglP+E0hQiENm70Voj8ZuwMJxUm+M9RjLl5r
         kBqPdTeG22Q1UiZZNM97Mlt6UyNw062u06qWgoHg6qV1Aa3uJxi0MF9RvLkiqIy4OZo4
         12rm2O9XmEB1qYCbL25CG/kQ965JYvh2gctl1BAlUMKi4bk+lcWQyBynuLTHek9jpqIB
         cJOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWx7eW9wvK2dgrL8f6+tMqrOAULco7bOrInhmO7aSTGOLZhjp8QqSPvWs8y2LK8o3JgIeKVZ6dsgvY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFJnFJExCl+/RS/5MCYzFezP/l1BnqrtUC0E/yp3LGr6QswCoM
	amJTiEFDe1HaN/s9/XhWsqMurpA9glQpg5FcPNXcyPwR+eDzqyGg/WLJvoI0ORq26xViwC1yILD
	0RiOSuCclUnnAPebJWlXKK1Trkjze9tuV8XGe12W4w4tMUx2ulQ+bhO8=
X-Google-Smtp-Source: AGHT+IF98JrOT+WucD8SHgmz52ipLkO8tB/5OD0+d7Zsfuv67sdA5n1iY8LHfzF0CGGJ1pkbBaQUSAEveum/jPzW1lMFxUYgN+0q
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1488:b0:3d3:e2a1:1f23 with SMTP id
 e9e14a558f8ab-3d5e0a0b15cmr52711205ab.20.1743353362924; Sun, 30 Mar 2025
 09:49:22 -0700 (PDT)
Date: Sun, 30 Mar 2025 09:49:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67e97612.050a0220.1547ec.00ba.GAE@google.com>
Subject: [syzbot] [pci?] upstream test error: BUG: unable to handle kernel
 NULL pointer dereference in msix_prepare_msi_desc
From: syzbot <syzbot+9c23146ed23f4a1be6d1@syzkaller.appspotmail.com>
To: bhelgaas@google.com, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot found the following issue on:

HEAD commit:    f6e0150b2003 Merge tag 'mtd/for-6.15' of git://git.kernel..=
.
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=3D161dd43f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D5484680e4cf4b35=
6
dashboard link: https://syzkaller.appspot.com/bug?extid=3D9c23146ed23f4a1be=
6d1
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Deb=
ian) 2.40

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b6dd1dc395cb/disk-=
f6e0150b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d374849a451e/vmlinux-=
f6e0150b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1cae448b43cd/bzI=
mage-f6e0150b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit=
:
Reported-by: syzbot+9c23146ed23f4a1be6d1@syzkaller.appspotmail.com

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
BUG: kernel NULL pointer dereference, address: 0000000000000000
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 0 P4D 0=20
Oops: Oops: 0000 [#1] SMP PTI
CPU: 1 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.14.0-syzkaller-03565-gf6=
e0150b2003 #0 PREEMPT(full)=20
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Goo=
gle 02/12/2025
RIP: 0010:msix_prepare_msi_desc+0x46/0xc0 drivers/pci/msi/msi.c:615
Code: 02 00 00 31 ff 48 8b 40 20 66 81 4b 54 01 01 c7 43 04 01 00 00 00 8b =
95 ac 03 00 00 89 53 58 4c 8b a5 a0 09 00 00 4c 89 63 60 <8b> 28 81 e5 00 0=
0 40 00 89 ee e8 1b 62 9f fe 85 ed 75 1c e8 c2 69
RSP: 0000:ffffc9000005b988 EFLAGS: 00010202
RAX: 0000000000000000 RBX: ffffc9000005b9d0 RCX: ffffffff82c27691
RDX: 000000000000000b RSI: ffffffff82c27508 RDI: 0000000000000000
RBP: ffff88814047a000 R08: 0000000000000004 R09: 0000000000000000
R10: 0000000000000002 R11: ffffffff83293622 R12: ffffc90000085008
R13: 0000000000000000 R14: ffffc9000005b9d0 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8881b26e8000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000006c62000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 msix_setup_msi_descs+0xf3/0x190 drivers/pci/msi/msi.c:639
 __msix_setup_interrupts drivers/pci/msi/msi.c:672 [inline]
 msix_setup_interrupts drivers/pci/msi/msi.c:701 [inline]
 msix_capability_init drivers/pci/msi/msi.c:743 [inline]
 __pci_enable_msix_range+0x55a/0x9b0 drivers/pci/msi/msi.c:851
 pci_alloc_irq_vectors_affinity+0x18b/0x1f0 drivers/pci/msi/api.c:268
 vp_request_msix_vectors drivers/virtio/virtio_pci_common.c:160 [inline]
 vp_find_vqs_msix+0x28e/0x710 drivers/virtio/virtio_pci_common.c:417
 vp_find_vqs+0x4a/0x3c0 drivers/virtio/virtio_pci_common.c:525
 virtio_find_vqs include/linux/virtio_config.h:226 [inline]
 virtio_find_single_vq include/linux/virtio_config.h:237 [inline]
 probe_common+0x12e/0x2b0 drivers/char/hw_random/virtio-rng.c:155
 virtio_dev_probe+0x305/0x430 drivers/virtio/virtio.c:341
 call_driver_probe drivers/base/dd.c:579 [inline]
 really_probe+0x12c/0x430 drivers/base/dd.c:658
 __driver_probe_device+0xc3/0x1a0 drivers/base/dd.c:800
 driver_probe_device+0x2a/0x120 drivers/base/dd.c:830
 __driver_attach drivers/base/dd.c:1216 [inline]
 __driver_attach+0x10e/0x200 drivers/base/dd.c:1156
 bus_for_each_dev+0xb2/0x110 drivers/base/bus.c:370
 bus_add_driver+0x122/0x2e0 drivers/base/bus.c:678
 driver_register+0x85/0x180 drivers/base/driver.c:249
 do_one_initcall+0x74/0x480 init/main.c:1257
 do_initcall_level init/main.c:1319 [inline]
 do_initcalls init/main.c:1335 [inline]
 do_basic_setup init/main.c:1354 [inline]
 kernel_init_freeable+0x251/0x450 init/main.c:1567
 kernel_init+0x1b/0x2a0 init/main.c:1457
 ret_from_fork+0x45/0x60 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Modules linked in:
CR2: 0000000000000000
---[ end trace 0000000000000000 ]---
RIP: 0010:msix_prepare_msi_desc+0x46/0xc0 drivers/pci/msi/msi.c:615
Code: 02 00 00 31 ff 48 8b 40 20 66 81 4b 54 01 01 c7 43 04 01 00 00 00 8b =
95 ac 03 00 00 89 53 58 4c 8b a5 a0 09 00 00 4c 89 63 60 <8b> 28 81 e5 00 0=
0 40 00 89 ee e8 1b 62 9f fe 85 ed 75 1c e8 c2 69
RSP: 0000:ffffc9000005b988 EFLAGS: 00010202
RAX: 0000000000000000 RBX: ffffc9000005b9d0 RCX: ffffffff82c27691
RDX: 000000000000000b RSI: ffffffff82c27508 RDI: 0000000000000000
RBP: ffff88814047a000 R08: 0000000000000004 R09: 0000000000000000
R10: 0000000000000002 R11: ffffffff83293622 R12: ffffc90000085008
R13: 0000000000000000 R14: ffffc9000005b9d0 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8881b26e8000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000006c62000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	02 00                	add    (%rax),%al
   2:	00 31                	add    %dh,(%rcx)
   4:	ff 48 8b             	decl   -0x75(%rax)
   7:	40 20 66 81          	and    %spl,-0x7f(%rsi)
   b:	4b 54                	rex.WXB push %r12
   d:	01 01                	add    %eax,(%rcx)
   f:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%rbx)
  16:	8b 95 ac 03 00 00    	mov    0x3ac(%rbp),%edx
  1c:	89 53 58             	mov    %edx,0x58(%rbx)
  1f:	4c 8b a5 a0 09 00 00 	mov    0x9a0(%rbp),%r12
  26:	4c 89 63 60          	mov    %r12,0x60(%rbx)
* 2a:	8b 28                	mov    (%rax),%ebp <-- trapping instruction
  2c:	81 e5 00 00 40 00    	and    $0x400000,%ebp
  32:	89 ee                	mov    %ebp,%esi
  34:	e8 1b 62 9f fe       	call   0xfe9f6254
  39:	85 ed                	test   %ebp,%ebp
  3b:	75 1c                	jne    0x59
  3d:	e8                   	.byte 0xe8
  3e:	c2                   	.byte 0xc2
  3f:	69                   	.byte 0x69


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

