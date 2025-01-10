Return-Path: <linux-pci+bounces-19635-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 477CBA094DD
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jan 2025 16:18:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 602AD3A594B
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jan 2025 15:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE20020B80D;
	Fri, 10 Jan 2025 15:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wjLp7ZJN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01DFB674
	for <linux-pci@vger.kernel.org>; Fri, 10 Jan 2025 15:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736522305; cv=none; b=GGDs0wxJuvQQYwfLh1oVI1VDQtEBXngEj+BOjPB76jMjHMk9Gb/gnrsnR+3AtKzBx+S2eeaQgsVPBSsgATpXODcfquQKBPpxDxC+WUOU11s72M5MmjwCza/VUyf+1eTbNclK4EAyM/h4u7J/8dkye3Xrmz2hglMtRPe7TO33esY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736522305; c=relaxed/simple;
	bh=3k/6C4IOPkst9v6SI7hmSGk+CC05gKRYp5oOCEvjPvc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pf0Vc/9xKViwzg7ayWXCBM7zjDpPCH881zi4CFy1iEvXo/FbdFsyr5ei5GNxVVWGeL5C1xcrIBqxPI8fwL2mHfRkj4g3f75Gsnluw41L+6Vp433NutBgQhxbT2PTE8gshRM19PU4c17YSPasavrOCCjX6cBD+AsPfNvj9dtckyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wjLp7ZJN; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-30227ccf803so17485611fa.2
        for <linux-pci@vger.kernel.org>; Fri, 10 Jan 2025 07:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736522302; x=1737127102; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lvU2hdWd7beRebcISyx42mfoyChNjr0m1w4bF78Ijl0=;
        b=wjLp7ZJNKZICz9aW8++zVadb2RM4sin4qW3KFzZcHZJ1oEH1HfAr3wLTYX+GsLSi+o
         9ciilSpKApVEOZTzBji88q2O55mx3l43UgEkJrAQ9MDWq1HMRIVa/BJPT+qdo8EWZoLL
         JI6qNhGO98yOoxbAOMXaLqqa8gGusZ4l/a0R+9DLdLnXVKBzRHpkmiP21BJ3z7Ubsl59
         JJfdjDMXI3NNVm2sUIURtvvWnG5+5Re0fSunWQirwdw48oaPgroFAjIa4UefmWSjA/ih
         5xeHqXqNkVof0joV3mcXkYuGF/DJZgQL+auTY38bE5bxu6M8E3iITuex4ME7sq1FVZ50
         GgQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736522302; x=1737127102;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lvU2hdWd7beRebcISyx42mfoyChNjr0m1w4bF78Ijl0=;
        b=JQIP3MJ4WnD2I22TZsykOPViQ/M5hAgPO4JiU+hDfNngNuVRVG91i/G6QcBDXSTfHA
         KqGDoVUI6lon7dosiuv08riikyR+PboPquUJf/GJlzi+YjAF6XNr7twmm/vS31NLy/FI
         rmD2cNN4qGNaZfQcXfxeO06sa9uRaxQA1annVkxIIO8TuqTy1q4xujnXg5WPrCktE8cb
         6bsnfnWQVXKHChwoZMXREg6XaeAMcnRjT3lnNGnMMjDFSYuNZ7ef/fKyCNeJ2IvIRYNT
         ZccKrzHB0qNpZIVprhLze1K3Bzspk1k/bilhVUhG6edOyf9axP+SuqCMRhP9j5fEjKZp
         nszQ==
X-Forwarded-Encrypted: i=1; AJvYcCXl37LRKT1y0BXzWmcoxgJEWqyFQc1tuX4fodrNL/Zmc5AwCgwQFMeREDLr9l3koJ4AHZdzB3dqCwE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRkpROqbAqTwQHl9D0tkToSAK+9t0cazXEMtQYZvWOx6zM0lhQ
	ajHdamUAocv/R+Nh8T0uVxEXPTARyw24j1owtz2PCWMvxdcLyKiiktlMPHmA0H5QLhlJN4UTTle
	YLT4QRF1JsJMdtLiLSkbRppHYcQHnfF6VSeJc
X-Gm-Gg: ASbGncu8IRisLpfKqqIldXcQvvA6KnUMapj5Ml68GxcRWNbfr2hfEpN9/U3wBXN/Mi+
	Z6IkbykpJ2AnIls0xPv2gOtvQDOFBA9GVLHAilIGqhtrFXkcRxl0yurF0dGPARNE0aAF9d4c=
X-Google-Smtp-Source: AGHT+IEXsjxGiWp1Mz3PQuijSEFGZHLybs6WyDS+8gn6UJbniG3B7nHuPpSAGZ+kBjxdfk9eiNLDzIMu3c70xof3VJA=
X-Received: by 2002:a05:651c:2222:b0:300:38ff:f8e2 with SMTP id
 38308e7fff4ca-305f453f9d5mr34475281fa.10.1736522301917; Fri, 10 Jan 2025
 07:18:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <678136f7.050a0220.216c54.0015.GAE@google.com>
In-Reply-To: <678136f7.050a0220.216c54.0015.GAE@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Fri, 10 Jan 2025 16:18:10 +0100
X-Gm-Features: AbW1kvaSvDEGClZPZVPY1bseLlLUhY4gsiIRWgU0qUVBvyrmRQu-0-Vu4EjQ9y4
Message-ID: <CACT4Y+YAXoB+GeA2dQODzDz0u3Z2Dmh98bFHT4Y0Tdi7ZFUT9A@mail.gmail.com>
Subject: Re: [syzbot] [pci?] KCSAN: data-race in vga_arb_write / vga_arb_write (4)
To: syzbot <syzbot+2699c160471dfeee2644@syzkaller.appspotmail.com>
Cc: bhelgaas@google.com, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 10 Jan 2025 at 16:04, syzbot
<syzbot+2699c160471dfeee2644@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    9b2ffa6148b1 Merge tag 'mtd/fixes-for-6.13-rc5' of git://g..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=12aac0b0580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=87d3cfca6847d1fa
> dashboard link: https://syzkaller.appspot.com/bug?extid=2699c160471dfeee2644
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/8f3f5cceed80/disk-9b2ffa61.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/1ba00b70d91e/vmlinux-9b2ffa61.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/b99c1bb4d63f/bzImage-9b2ffa61.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+2699c160471dfeee2644@syzkaller.appspotmail.com

This is a race between io_cnt++ and io_cnt--.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/vgaarb.c?id=9b2ffa6148b1e4468d08f7e0e7e371c43cac9ffe#n1204
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/vgaarb.c?id=9b2ffa6148b1e4468d08f7e0e7e371c43cac9ffe#n1263

Later io_cnt is used to drop references:

while (uc->io_cnt--)
    vga_put(uc->pdev, VGA_RSRC_LEGACY_IO);

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/vgaarb.c?id=9b2ffa6148b1e4468d08f7e0e7e371c43cac9ffe#n1454

So this will corrupt memory.





> ==================================================================
> BUG: KCSAN: data-race in vga_arb_write / vga_arb_write
>
> read-write to 0xffff88814f612424 of 4 bytes by task 17707 on cpu 0:
>  vga_arb_write+0x11fa/0x1410 drivers/pci/vgaarb.c:1204
>  vfs_write+0x281/0x920 fs/read_write.c:677
>  ksys_write+0xe8/0x1b0 fs/read_write.c:731
>  __do_sys_write fs/read_write.c:742 [inline]
>  __se_sys_write fs/read_write.c:739 [inline]
>  __x64_sys_write+0x42/0x50 fs/read_write.c:739
>  x64_sys_call+0x287e/0x2dc0 arch/x86/include/generated/asm/syscalls_64.h:2
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> read-write to 0xffff88814f612424 of 4 bytes by task 17708 on cpu 1:
>  vga_arb_write+0xf45/0x1410 drivers/pci/vgaarb.c:1263
>  vfs_write+0x281/0x920 fs/read_write.c:677
>  ksys_write+0xe8/0x1b0 fs/read_write.c:731
>  __do_sys_write fs/read_write.c:742 [inline]
>  __se_sys_write fs/read_write.c:739 [inline]
>  __x64_sys_write+0x42/0x50 fs/read_write.c:739
>  x64_sys_call+0x287e/0x2dc0 arch/x86/include/generated/asm/syscalls_64.h:2
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> value changed: 0x00000001 -> 0x00000007
>
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 1 UID: 0 PID: 17708 Comm: syz.4.3325 Not tainted 6.13.0-rc4-syzkaller-00012-g9b2ffa6148b1 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
> ==================================================================
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
>
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion visit https://groups.google.com/d/msgid/syzkaller-bugs/678136f7.050a0220.216c54.0015.GAE%40google.com.

