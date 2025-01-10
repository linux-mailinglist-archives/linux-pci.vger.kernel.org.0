Return-Path: <linux-pci+bounces-19634-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A445DA094A0
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jan 2025 16:04:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E6C1188DB5E
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jan 2025 15:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE2620DD79;
	Fri, 10 Jan 2025 15:04:27 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A59B20551A
	for <linux-pci@vger.kernel.org>; Fri, 10 Jan 2025 15:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736521467; cv=none; b=Zl1I6yaC47hxFqDHXEIlf66yF7Nl7ZKjo/gghVGVzVfgW381Mc1CMdBggB9pmnxEiIkzZgSw6MPWfhNlWplV4KTLjtRwTmnBO8c7H3VmBytAjB/adBZOGcMzEcg6ZH0vXVVOHfb77IRIlANbzGXSA7BBLwjis4mUNNmqt3cRK3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736521467; c=relaxed/simple;
	bh=cZNoZyzQipnDLfLyvupbWpNsGByiZ0QB+EvyB2q1xFc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=MeSZ/rsfPZmWrdvfLjJ92Adc7tW+BDSClTQDW07JTSeJtRPC755VLwNSVkbiRkX95fYHgizn/f9k4o1xfzwm+8JNDLqWYn97A/AnO4fXn54vrcGSK15gkRvqie+YWnGoDbURpXhIn0A17v6ElmVojDwUEMHEViYOpj+EY/UbjLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3a819a4e83dso21095725ab.1
        for <linux-pci@vger.kernel.org>; Fri, 10 Jan 2025 07:04:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736521464; x=1737126264;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qUQpPs0FcZM7FnINVbur4ebsmx4AO4ji16mjkxHBtU0=;
        b=sydUtTSkzJ1B+zvnLqNKIhSwbyDRNjsBPgRumPR49qYKW+lECbaEUo4rVmgQ3CO6ie
         1Rto+/Jv5CORx8P02F9vMoep8I27gunCRcTMxUyIisYKDr0kmhxQ5FQFhPH7CwzMOWfg
         Yo9VvbgfWHNpoiAsiM8qhjq4tGLuIPGLwuYmBXwBHb7n67XDxPXMyI18LlKcOQCGNsvG
         NLrFoYfIRDhKXrmiE2Ygz89TeOB6iZ696BXFpifkrWtQ+Uy63h40o5c2Fduas04fsUlg
         hGjNYjnKwwcYn5rQIc1mZQYEZQNNXPd9CbHqs1LKoWZVATDpPnlNedAL/nQ7Ar5bUiOP
         YbTg==
X-Forwarded-Encrypted: i=1; AJvYcCVx7fJMYBxDXhLYKtCwcCAW2OKPz/PcgSrRM8TI2Yf4vHS/JKuBQytTYiBGgQG4X6WKmCiuKG62gTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzehM8Y7vFBOUzF8PxZJGiumnAYjlEIlPrZS255oy3etF15KVkh
	k3Tq9VbIzW/JE96d9mecj72ROFnKn7BKw152m4xLtf+Fjhc8Wlt6cNqTyC/eIl6eLEvkWvyfbeC
	c8xVTeBdzOicGzJL40lca64goAF1ZdImgT2lyZaUpnRto+Nx6oB7qsAE=
X-Google-Smtp-Source: AGHT+IFxKsndZNjMMYvGkFtZDpe3/ZM1i2fsaN86NSLcTYILqVrHceO7dhD2dvlo7M0C2RLLTW6k3NRhLx/rsfwwKz1zJGGL6nUH
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cdab:0:b0:3a7:c5b1:a55c with SMTP id
 e9e14a558f8ab-3ce3a8936efmr79923075ab.0.1736521463064; Fri, 10 Jan 2025
 07:04:23 -0800 (PST)
Date: Fri, 10 Jan 2025 07:04:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <678136f7.050a0220.216c54.0015.GAE@google.com>
Subject: [syzbot] [pci?] KCSAN: data-race in vga_arb_write / vga_arb_write (4)
From: syzbot <syzbot+2699c160471dfeee2644@syzkaller.appspotmail.com>
To: bhelgaas@google.com, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    9b2ffa6148b1 Merge tag 'mtd/fixes-for-6.13-rc5' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12aac0b0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=87d3cfca6847d1fa
dashboard link: https://syzkaller.appspot.com/bug?extid=2699c160471dfeee2644
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8f3f5cceed80/disk-9b2ffa61.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1ba00b70d91e/vmlinux-9b2ffa61.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b99c1bb4d63f/bzImage-9b2ffa61.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2699c160471dfeee2644@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in vga_arb_write / vga_arb_write

read-write to 0xffff88814f612424 of 4 bytes by task 17707 on cpu 0:
 vga_arb_write+0x11fa/0x1410 drivers/pci/vgaarb.c:1204
 vfs_write+0x281/0x920 fs/read_write.c:677
 ksys_write+0xe8/0x1b0 fs/read_write.c:731
 __do_sys_write fs/read_write.c:742 [inline]
 __se_sys_write fs/read_write.c:739 [inline]
 __x64_sys_write+0x42/0x50 fs/read_write.c:739
 x64_sys_call+0x287e/0x2dc0 arch/x86/include/generated/asm/syscalls_64.h:2
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

read-write to 0xffff88814f612424 of 4 bytes by task 17708 on cpu 1:
 vga_arb_write+0xf45/0x1410 drivers/pci/vgaarb.c:1263
 vfs_write+0x281/0x920 fs/read_write.c:677
 ksys_write+0xe8/0x1b0 fs/read_write.c:731
 __do_sys_write fs/read_write.c:742 [inline]
 __se_sys_write fs/read_write.c:739 [inline]
 __x64_sys_write+0x42/0x50 fs/read_write.c:739
 x64_sys_call+0x287e/0x2dc0 arch/x86/include/generated/asm/syscalls_64.h:2
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

value changed: 0x00000001 -> 0x00000007

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 UID: 0 PID: 17708 Comm: syz.4.3325 Not tainted 6.13.0-rc4-syzkaller-00012-g9b2ffa6148b1 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
==================================================================


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

