Return-Path: <linux-pci+bounces-24985-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 676B1A7597C
	for <lists+linux-pci@lfdr.de>; Sun, 30 Mar 2025 12:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA66D3ABC85
	for <lists+linux-pci@lfdr.de>; Sun, 30 Mar 2025 10:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6682E1AF4E9;
	Sun, 30 Mar 2025 10:15:31 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817791ACEDC
	for <linux-pci@vger.kernel.org>; Sun, 30 Mar 2025 10:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743329731; cv=none; b=jmvWe19e+8VOkMhy7jHDv85hgoTdHqcr5szu5/FSKRrn7GECh+BsEACRlYnUxXNoJw40DNfsfrA4tZgYFtpUHHWslJONZQ66hyga/+1oJhHdbJNijp8zlM5g1VsOLMrK3jPVEUA4/or1p644OivVY824VkcrQ+Umc+NSdjw9VpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743329731; c=relaxed/simple;
	bh=99wkWhy/lCj+tv6LO2+FpffBuhc7Ut3csLcyTV8mNB8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=syq+D1W4vuMnQOfZ+och/OdgYbEFkyYw8+RZyDGyQtIsAvzILxPJ6OS4oM6aZIz31Q1EaEofppVkNQXcd8CBrAxz/aNIuP4w0pV97JHYHgn7H8deQUUFiiFpnFKExzZoYJ08AO30Ga/+jp2B0sjFi0jv/suUJ6+QJeZv79bKP1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-851a991cf8bso388379239f.0
        for <linux-pci@vger.kernel.org>; Sun, 30 Mar 2025 03:15:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743329728; x=1743934528;
        h=content-transfer-encoding:to:from:subject:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aRIumUmVALlisx7HIVaILs9tTAYP+kvXPJggT6KTe0s=;
        b=mh7nLXF8dzNKF3mP3xr8l3eexZfzjfYXLaj9XXuycx6RUwsrvaEBKygkGKUpwDNYrf
         CRkxoSXtbhvHItGm+tMDH+/wBIcmnghsq3YdYuRhbuYWw0RLNgxTkqGwxHwwkmLE6P8Y
         Dp6fdvbplAg4CA+8JyZ55CuS9Cj5RQlx3yY477RyV/LmUik2+Gh1jog4gb3zDLFSvEpb
         FL55FzAwkhS7dsvXJtMdG/IMtr7rMdl2RygNGLrhD3Rr+lgU+PQ8y1emKuFerd+gLgof
         wwSc1WmJO50Whn5i6IkHrW7wQ58HwxKBZ7ch5iUF8f5igyEyTMUlBZkOEmgxplRemcSw
         OPjA==
X-Forwarded-Encrypted: i=1; AJvYcCUVu9Ns+8h5QZBj/O9OfqHDMEsv2cJ0gG7XyNznO7fBAEcxsnBzhTQhSisYnfTi3fEuTL47xbJ0A0U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/tPm8QNHVAORprH/94AWaLiIsvpNQEPPiobGnsaIG2AWUeD4f
	K8wg7DL9bJ+G4UN10IRkmolqtS6RugbXmTvH00CjB+QxBARtBhK6iAtArDuZH+9qZa5XYZtEs85
	Ulx/9MWh5kUkWb/DsxI0NxTq0mJhRVhHFvmZEh+6IehQzHP6tlGa3fF4=
X-Google-Smtp-Source: AGHT+IECRGMTHDljt+iYwo556tAb9d1HTBmp0TKRaLg8/NmttQiOqh9bw+A9IV5PX3xA+yuzvvLKt674te7Us9JR9Ls3QnAoZrmM
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:4401:20b0:3d5:890b:d9e1 with SMTP id
 e9e14a558f8ab-3d5e08bced1mr34573115ab.1.1743329728138; Sun, 30 Mar 2025
 03:15:28 -0700 (PDT)
Date: Sun, 30 Mar 2025 03:15:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67e919c0.050a0220.1547ec.00a1.GAE@google.com>
Subject: [syzbot] [pci?] upstream test error: general protection fault in msix_prepare_msi_desc
From: syzbot <syzbot+8423775fd52d4cc7e5c9@syzkaller.appspotmail.com>
To: bhelgaas@google.com, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot found the following issue on:

HEAD commit:    f6e0150b2003 Merge tag 'mtd/for-6.15' of git://git.kernel..=
.
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=3D12bf5804580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D4444a7da3861fcf=
5
dashboard link: https://syzkaller.appspot.com/bug?extid=3D8423775fd52d4cc7e=
5c9
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Deb=
ian) 2.40

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9113c1eac62e/disk-=
f6e0150b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f1dd0f2f5338/vmlinux-=
f6e0150b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b275479ad610/bzI=
mage-f6e0150b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit=
:
Reported-by: syzbot+8423775fd52d4cc7e5c9@syzkaller.appspotmail.com

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
CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.14.0-syzkaller-03565-gf6=
e0150b2003 #0 PREEMPT(full)=20
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Goo=
gle 02/12/2025
RIP: 0010:msix_prepare_msi_desc+0x18a/0x310 drivers/pci/msi/msi.c:615
Code: 00 fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 7f 01 00 00 4c 89 =
ea 4c 89 63 60 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <0f> b6 04 02 84 c=
0 74 08 3c 03 0f 8e fd 00 00 00 41 8b 6d 00 31 ff
RSP: 0000:ffffc900000674f8 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: ffffc90000067588 RCX: ffffffff8501ef7f
RDX: 0000000000000000 RSI: ffffffff8501eb05 RDI: ffffc900000675e8
RBP: ffff888021efe000 R08: 0000000000000004 R09: 0000000000000000
R10: 0000000000000002 R11: 0000000000002ba3 R12: ffffc9000008e008
R13: 0000000000000000 R14: 0000000000000002 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff888124e5a000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff88823ffff000 CR3: 000000000df82000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 msix_setup_msi_descs+0x19c/0x260 drivers/pci/msi/msi.c:639
 __msix_setup_interrupts drivers/pci/msi/msi.c:672 [inline]
 msix_setup_interrupts drivers/pci/msi/msi.c:701 [inline]
 msix_capability_init drivers/pci/msi/msi.c:743 [inline]
 __pci_enable_msix_range+0x90f/0x1150 drivers/pci/msi/msi.c:851
 pci_alloc_irq_vectors_affinity+0x238/0x2a0 drivers/pci/msi/api.c:268
 vp_request_msix_vectors drivers/virtio/virtio_pci_common.c:160 [inline]
 vp_find_vqs_msix+0x423/0xea0 drivers/virtio/virtio_pci_common.c:417
 vp_find_vqs+0x96/0x7a0 drivers/virtio/virtio_pci_common.c:525
 virtio_find_vqs include/linux/virtio_config.h:226 [inline]
 virtio_find_single_vq include/linux/virtio_config.h:237 [inline]
 probe_common+0x324/0x700 drivers/char/hw_random/virtio-rng.c:155
 virtio_dev_probe+0x586/0x8a0 drivers/virtio/virtio.c:341
 call_driver_probe drivers/base/dd.c:579 [inline]
 really_probe+0x23e/0xa90 drivers/base/dd.c:658
 __driver_probe_device+0x1de/0x440 drivers/base/dd.c:800
 driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:830
 __driver_attach+0x283/0x580 drivers/base/dd.c:1216
 bus_for_each_dev+0x13b/0x1d0 drivers/base/bus.c:370
 bus_add_driver+0x2e9/0x690 drivers/base/bus.c:678
 driver_register+0x15c/0x4b0 drivers/base/driver.c:249
 do_one_initcall+0x120/0x6e0 init/main.c:1257
 do_initcall_level init/main.c:1319 [inline]
 do_initcalls init/main.c:1335 [inline]
 do_basic_setup init/main.c:1354 [inline]
 kernel_init_freeable+0x5c2/0x900 init/main.c:1567
 kernel_init+0x1c/0x2b0 init/main.c:1457
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:msix_prepare_msi_desc+0x18a/0x310 drivers/pci/msi/msi.c:615
Code: 00 fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 7f 01 00 00 4c 89 =
ea 4c 89 63 60 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <0f> b6 04 02 84 c=
0 74 08 3c 03 0f 8e fd 00 00 00 41 8b 6d 00 31 ff
RSP: 0000:ffffc900000674f8 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: ffffc90000067588 RCX: ffffffff8501ef7f
RDX: 0000000000000000 RSI: ffffffff8501eb05 RDI: ffffc900000675e8
RBP: ffff888021efe000 R08: 0000000000000004 R09: 0000000000000000
R10: 0000000000000002 R11: 0000000000002ba3 R12: ffffc9000008e008
R13: 0000000000000000 R14: 0000000000000002 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff888124f5a000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000000df82000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess), 3 bytes skipped:
   0:	df 48 89             	fisttps -0x77(%rax)
   3:	fa                   	cli
   4:	48 c1 ea 03          	shr    $0x3,%rdx
   8:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
   c:	0f 85 7f 01 00 00    	jne    0x191
  12:	4c 89 ea             	mov    %r13,%rdx
  15:	4c 89 63 60          	mov    %r12,0x60(%rbx)
  19:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  20:	fc ff df
  23:	48 c1 ea 03          	shr    $0x3,%rdx
* 27:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax <-- trapping instruct=
ion
  2b:	84 c0                	test   %al,%al
  2d:	74 08                	je     0x37
  2f:	3c 03                	cmp    $0x3,%al
  31:	0f 8e fd 00 00 00    	jle    0x134
  37:	41 8b 6d 00          	mov    0x0(%r13),%ebp
  3b:	31 ff                	xor    %edi,%edi


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

