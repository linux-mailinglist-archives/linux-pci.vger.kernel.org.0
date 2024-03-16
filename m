Return-Path: <linux-pci+bounces-4859-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7727E87D82A
	for <lists+linux-pci@lfdr.de>; Sat, 16 Mar 2024 04:26:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6B121C20CC4
	for <lists+linux-pci@lfdr.de>; Sat, 16 Mar 2024 03:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D43C1FDD;
	Sat, 16 Mar 2024 03:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bPYHNteT"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18D717C9;
	Sat, 16 Mar 2024 03:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710559574; cv=none; b=fhUsOM3xHMKamLdZc5nsAZms9V1hrwn5JTGCz+1/wKsOHI1NfA+ei5tneLX8NeXkqKmEyPG0oaAVaUFfEIAfXSlKF77kbiUM6oXpvrg1fiSdY5WQVDa+dsvQ06NIh5d3mYrN60nTxIU+W50y6T2tx8RJpXnibBQRJ8s5carDv7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710559574; c=relaxed/simple;
	bh=yggWWB2FFckeZ9LsbXn7b4qC+nV/UhSFgEqH0lp5mVU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=RhOTpSfm3Ddz525wEfNP5j7Jzxiw6qOuwpLDitM/ILZutt1QFlHdmmzUMZDJaVR244M8VTz7AeNS+8H8cLgTj6U9PfdNcYd73C+ITqi+qwYFRIfTjJyzR2a/c8LGKiI1maehkKGiN7P2587sb3Ghefd2ADnWoyzvrE6YB3bdoqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bPYHNteT; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a467d8efe78so217358066b.3;
        Fri, 15 Mar 2024 20:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710559571; x=1711164371; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EThNNwFkPtkhOcrw1zHFNehRoJvZ4OX47dJvR8Wysp0=;
        b=bPYHNteTdI0E48E8tu85RotxxcgNqzzdTlJtUcKTeqI+e8BTEvzJWLiqkKzAsk9xeN
         qxEyLv+UUAAB+cZ+XO9RpJrqb9cO3Z0gGkT9NLEQQu689wADCBBXIZpaF8hfSPThIgwF
         sV15xMwCAZu/kDUnFBXxkfP6lNaUMYtQ/193fbjy0inMhd9krvaXksmr3qoRdCCJpovK
         4x5eop1KU7egjJIb8tqKhmaSX+vhPAkWSmOUrO5InCyJjLC6D1+3chTaeUaS4MbOPOy4
         TTuRBPIjvAZ/HY8gGi5xR+yZBigpNtQCBi3lIVeZ4A+NsabiU4GsZYqxmu66wUGi8ztT
         YlVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710559571; x=1711164371;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EThNNwFkPtkhOcrw1zHFNehRoJvZ4OX47dJvR8Wysp0=;
        b=G2umGwUL/f0a+iA5D18ydigQvLgfKja6NsBYWA/x1Xi2tJFXm1oCQtBd2n6qQgDmeH
         qh3nfTYOMbk0UNTalqlU1Pr6WceUXoRlHkcYH5/lIvg7x6pfMfKJnvfehirzTCHxq7H3
         7n6wByJKvqToSl8s2Wd5N4sMTVJWWUCN2dhJPo6rzQ7mCPaDkHwCy/FUX445aC3G8SMl
         KIpDr+fm48NoTir4CRFl7fYw3GWHIFBdVpJKZLwiYUCJC+/iD7NSGMKyLb/G0gi39ix+
         LQhbb/oNvlt2YaWFBiUx2BantUdjQ1hHU04yvcLMVojlWIdXHD4hj5ZK+DXoWlaUr6t6
         Ba5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXMui3V8QYN8LPPYkqXqetORnSQH/4abbX0uhPS3E7tRxlp6vrqaQNLUa0veKRR9RksxP2xrEKYs/IGYl/DNd7IVeZXfCwtAaDtajJZ
X-Gm-Message-State: AOJu0Yz4CLbbjxNMT75y3z1w3pe5Qr9FTkTcKlHO3APCiyhx2lVXnNL/
	ZypS7TUKXBTzdvAKLPG8UWkuZWV6K7lXOy4Wt8CRsTao6FCMwcqboGD2SOLkpT0kg9H8pfxIuPH
	flkQR7wf0zI/5/s1RaxPuA75UoD8HPKRcE/tO7Q==
X-Google-Smtp-Source: AGHT+IHTaj9qVjGF75uKY6F8mSkwykINc99yuxL/6QsgogsI93fmoYBgxF8BcIfNjirEwhCeKxq6uYaxebbG29UF0EI=
X-Received: by 2002:a17:907:d386:b0:a46:1d0a:9f17 with SMTP id
 vh6-20020a170907d38600b00a461d0a9f17mr5315445ejc.11.1710559570962; Fri, 15
 Mar 2024 20:26:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: cheung wall <zzqq0103.hey@gmail.com>
Date: Sat, 16 Mar 2024 11:25:59 +0800
Message-ID: <CAKHoSAsYYg9BH5shWy78Gf9M5PskvdHcMunnfDD3yrOfuy+SpQ@mail.gmail.com>
Subject: INFO: rcu detected stall in corrupted
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,


when using Healer to fuzz the latest Linux Kernel, the following crash

was triggered on:


HEAD commit: 0dd3ee31125508cd67f7e7172247f05b7fd1753a  (tag: v6.7)

git tree: upstream

console output: https://pastebin.com/raw/1JtKSypv

kernel config: https://pastebin.com/raw/VecrLrRN

C reproducer: https://pastebin.com/raw/CUsatTHW

Syzlang reproducer: https://pastebin.com/raw/gJFKLvkN


If you fix this issue, please add the following tag to the commit:

Reported-by: Qiang Zhang <zzqq0103.hey@gmail.com>

----------------------------------------------------------

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 1-...0: (0 ticks this GP) idle=84e4/1/0x4000000000000000
softirq=698253/698254 fqs=4779
rcu: (detected by 3, t=21002 jiffies, g=1119041, q=13818 ncpus=8)
Sending NMI from CPU 3 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 510326 Comm: syz-executor.1 Not tainted 6.7.0 #2
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
RIP: 0010:vga_put+0x42/0x100 drivers/pci/vgaarb.c:547
Code: 85 e4 0f 84 aa 00 00 00 e8 8b 59 38 ff 48 c7 c7 00 31 71 b9 48
bb 00 00 00 00 00 fc ff df e8 75 c0 d0 01 48 8b 2d fe a1 f9 02 <49> 89
c6 48 81 fd 00 ba 1f b8 75 25 eb 59 e8 5b 59 38 ff 48 89 e8
RSP: 0018:ffff888117917e28 EFLAGS: 00000082
RAX: 0000000000000093 RBX: dffffc0000000000 RCX: ffffffffb6f6d916
RDX: ffff8881138ea200 RSI: 0000000000000004 RDI: ffff888117917dc8
RBP: ffff888100fd5000 R08: 0000000000000001 R09: ffffed1022f22fb9
R10: 0000000000000003 R11: 0000000000000000 R12: ffff888100ee8000
R13: 0000000000000001 R14: ffff888116747818 R15: dffffc0000000000
FS: 0000555556ccd480(0000) GS:ffff8881f7080000(0000) knlGS:0000000000000000
CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f7b9128aa4f CR3: 0000000114c00003 CR4: 0000000000770ef0
PKRU: 55555554
Call Trace:
<NMI>
</NMI>
<TASK>
vga_arb_release+0x19a/0x2e0 drivers/pci/vgaarb.c:1455
__fput+0x235/0xb20 fs/file_table.c:394
__fput_sync+0x35/0x40 fs/file_table.c:475
__do_sys_close fs/open.c:1587 [inline]
__se_sys_close fs/open.c:1572 [inline]
__x64_sys_close+0x87/0xf0 fs/open.c:1572
do_syscall_x64 arch/x86/entry/common.c:52 [inline]
do_syscall_64+0x46/0xf0 arch/x86/entry/common.c:83
entry_SYSCALL_64_after_hwframe+0x6f/0x77
RIP: 0033:0x7f7b91217f0b
Code: 03 00 00 00 0f 05 48 3d 00 f0 ff ff 77 41 c3 48 83 ec 18 89 7c
24 0c e8 f3 fb 02 00 8b 7c 24 0c 41 89 c0 b8 03 00 00 00 0f 05 <48> 3d
00 f0 ff ff 77 35 44 89 c7 89 44 24 0c e8 41 fc 02 00 8b 44
RSP: 002b:00007fffbef11d10 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007f7b91217f0b
RDX: 0000000000000000 RSI: ffffffffffffffff RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000000 R09: 00007f7b90d89bd8
R10: 00007fffbef11e10 R11: 0000000000000293 R12: 00007f7b90d89000
R13: 00007fffbef11e10 R14: 00007f7b90d89c80 R15: 00007f7b90d89c78
</TASK>

