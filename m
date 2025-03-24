Return-Path: <linux-pci+bounces-24600-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED3B1A6E75C
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 00:58:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A99B316134A
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 23:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087051F1303;
	Mon, 24 Mar 2025 23:58:34 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D3C199EA2
	for <linux-pci@vger.kernel.org>; Mon, 24 Mar 2025 23:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742860713; cv=none; b=NtMpZu4TVTTFxY6Z6AZO+NFnSpcKVn9ohRu7MlftCYEwSNbDaDj1Vq0fAmTUxZVwHqgW2FDoqAW6dqaKV6nz94k+kH/LKO6ynHV6ac24vfoqWUGDSBNj5QUNhZMj8VwCI0ukbwPVqTg02MBdUe4gemuq0x5qAaGOzucKkrLAABI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742860713; c=relaxed/simple;
	bh=3yJ448z3JGIAuadfwPRagw+WU0K+n0QcDLRFcGjMoHY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=YRhuO0LqYLa4TwOgp0L4of5HbgP7xebErzUZtrqXwtiq3WF07Rod1PV9vG2pQfErY0E8SH1oZYPAZJg8qpmB+u85BgRurDScUsbqcaM35h8ArqOnGwZMfc1ix6clGPQcZKhXh8+V6nd158otCeIIv4VvgQqEcaqdqs3umxcEmyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3d44dc8a9b4so47039165ab.3
        for <linux-pci@vger.kernel.org>; Mon, 24 Mar 2025 16:58:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742860711; x=1743465511;
        h=content-transfer-encoding:to:from:subject:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mpF9gzQ/SYKkbKjtJllNByBKYiRK+kwj/tJYgNpzlqg=;
        b=NXRWz4aNd9xcfN1al8zan4oBTB53EcwIkQASk/nFtPKDov1QxPWkiRMCnZGO44SKGZ
         KIXDvCIXrYFG7YNKG67Z5SmthH9AsH0InkzzU6DoE5W9Vq2jFtF7n4hKo/mRX9n43LQL
         P5uytOuqB40ANDZOmqS671FBlUgVg+vqo6ep4lUO8rlHDdaonlMoK9GgX1rAciF6zQdO
         DdFZFsnc8j4ZgGItnXMn6lheVUjgYvg/r6pWnMbirwmlFFBvD2hXpxhsxuU2CNdz9RzO
         aJXIwe/Kphv3FxlNJSultltbzkh/HVlekquUIamgy7vZ6nJqeE6TF3J57BH6NGhxHxgC
         GCJw==
X-Forwarded-Encrypted: i=1; AJvYcCVYncmd1pdbvCfXcB7xty3W9vh1DrS7wemuKoNhjbTWcpaXLtWqodFmtoR8L2XX2FbCU6KYgl6sXKo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVsLms40y0ZJdnd9ekfrHXvA+3ZvF8mzYqT6dLvt2xBYayV8Hx
	n8dPiWvmuJfI4BxV+COETLG1zuxSODE/ZCzVcZt60fysIKFQQahd4MFa+58w4A7bc5vWRbEQJg+
	cGycSyaGDJFYkHDA0rt/4FwGdRShmtRMJoE9HiALCW8P9wobHIGuAAvk=
X-Google-Smtp-Source: AGHT+IF0rPKg1aVrmMsgebqF6lhFExAlqbZ6W66CtGYEeA8dqz7U2tON6sS3Ea2wSrOgGXyK//1rha0y0mHCf0XLpL6AiM2QczkB
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cd85:0:b0:3d3:e29c:a1a5 with SMTP id
 e9e14a558f8ab-3d596175043mr141994725ab.18.1742860711193; Mon, 24 Mar 2025
 16:58:31 -0700 (PDT)
Date: Mon, 24 Mar 2025 16:58:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67e1f1a7.050a0220.a7ebc.0032.GAE@google.com>
Subject: [syzbot] [pci?] linux-next test error: general protection fault in msix_capability_init
From: syzbot <syzbot+d33642573545e529ab61@syzkaller.appspotmail.com>
To: bhelgaas@google.com, linux-kernel@vger.kernel.org, 
	linux-next@vger.kernel.org, linux-pci@vger.kernel.org, sfr@canb.auug.org.au, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot found the following issue on:

HEAD commit:    882a18c2c14f Add linux-next specific files for 20250324
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=3D17d24804580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D30e7faf61be4d27=
e
dashboard link: https://syzkaller.appspot.com/bug?extid=3Dd33642573545e529a=
b61
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debia=
n) 2.40

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ea720fb0d677/disk-=
882a18c2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/723a320ec217/vmlinux-=
882a18c2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4f23b2e1eb2c/bzI=
mage-882a18c2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit=
:
Reported-by: syzbot+d33642573545e529ab61@syzkaller.appspotmail.com

ntfs3: Enabled Linux POSIX ACLs support
ntfs3: Read-only LZX/Xpress compression included
efs: 1.0a - http://aeschi.ch.eu.org/efs/
jffs2: version 2.2. (NAND) (SUMMARY)  =C2=A9 2001-2006 Red Hat, Inc.
romfs: ROMFS MTD (C) 2007 Red Hat, Inc.
QNX4 filesystem 0.2.3 registered.
qnx6: QNX6 filesystem 1.0.0 registered.
fuse: init (API version 7.43)
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
CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.14.0-rc7-next-20250324-s=
yzkaller #0 PREEMPT(full)=20
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Goo=
gle 02/12/2025
RIP: 0010:msix_prepare_msi_desc drivers/pci/msi/msi.c:616 [inline]
RIP: 0010:msix_setup_msi_descs drivers/pci/msi/msi.c:640 [inline]
RIP: 0010:msix_setup_interrupts drivers/pci/msi/msi.c:680 [inline]
RIP: 0010:msix_capability_init+0x7a9/0x1550 drivers/pci/msi/msi.c:743
Code: 10 00 74 0f e8 28 9f de fc 48 ba 00 00 00 00 00 fc ff df 48 89 9c 24 =
d0 00 00 00 48 89 9c 24 98 01 00 00 4c 89 f0 48 c1 e8 03 <0f> b6 04 10 84 c=
0 0f 85 86 02 00 00 41 8b 1e be 00 00 40 00 21 de
RSP: 0000:ffffc90000066ee0 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffffc9000009e008 RCX: ffff8881412b8000
RDX: dffffc0000000000 RSI: 0000000000000000 RDI: ffffc90000067078
RBP: ffffc90000067138 R08: ffffffff854ea585 R09: 0000000000000000
R10: ffffc90000067020 R11: fffff5200000ce10 R12: 0000000000000000
R13: 0000000000000101 R14: 0000000000000000 R15: 1ffff9200000ce0d
FS:  0000000000000000(0000) GS:ffff888124fc0000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff88823ffff000 CR3: 000000000eb38000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __pci_enable_msix_range+0x5c7/0x710 drivers/pci/msi/msi.c:851
 pci_alloc_irq_vectors_affinity+0x10e/0x2b0 drivers/pci/msi/api.c:270
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
RIP: 0010:msix_prepare_msi_desc drivers/pci/msi/msi.c:616 [inline]
RIP: 0010:msix_setup_msi_descs drivers/pci/msi/msi.c:640 [inline]
RIP: 0010:msix_setup_interrupts drivers/pci/msi/msi.c:680 [inline]
RIP: 0010:msix_capability_init+0x7a9/0x1550 drivers/pci/msi/msi.c:743
Code: 10 00 74 0f e8 28 9f de fc 48 ba 00 00 00 00 00 fc ff df 48 89 9c 24 =
d0 00 00 00 48 89 9c 24 98 01 00 00 4c 89 f0 48 c1 e8 03 <0f> b6 04 10 84 c=
0 0f 85 86 02 00 00 41 8b 1e be 00 00 40 00 21 de
RSP: 0000:ffffc90000066ee0 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffffc9000009e008 RCX: ffff8881412b8000
RDX: dffffc0000000000 RSI: 0000000000000000 RDI: ffffc90000067078
RBP: ffffc90000067138 R08: ffffffff854ea585 R09: 0000000000000000
R10: ffffc90000067020 R11: fffff5200000ce10 R12: 0000000000000000
R13: 0000000000000101 R14: 0000000000000000 R15: 1ffff9200000ce0d
FS:  0000000000000000(0000) GS:ffff8881250c0000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000000eb38000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	10 00                	adc    %al,(%rax)
   2:	74 0f                	je     0x13
   4:	e8 28 9f de fc       	call   0xfcde9f31
   9:	48 ba 00 00 00 00 00 	movabs $0xdffffc0000000000,%rdx
  10:	fc ff df
  13:	48 89 9c 24 d0 00 00 	mov    %rbx,0xd0(%rsp)
  1a:	00
  1b:	48 89 9c 24 98 01 00 	mov    %rbx,0x198(%rsp)
  22:	00
  23:	4c 89 f0             	mov    %r14,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	0f b6 04 10          	movzbl (%rax,%rdx,1),%eax <-- trapping instruct=
ion
  2e:	84 c0                	test   %al,%al
  30:	0f 85 86 02 00 00    	jne    0x2bc
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

