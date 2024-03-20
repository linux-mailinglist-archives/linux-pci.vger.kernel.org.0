Return-Path: <linux-pci+bounces-4943-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F01CC880E46
	for <lists+linux-pci@lfdr.de>; Wed, 20 Mar 2024 10:07:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ACE1283189
	for <lists+linux-pci@lfdr.de>; Wed, 20 Mar 2024 09:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7EC538DF1;
	Wed, 20 Mar 2024 09:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CzSAVwbi"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3613B78B
	for <linux-pci@vger.kernel.org>; Wed, 20 Mar 2024 09:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710925623; cv=none; b=a5n3yNgncmo2d1QUPJKCRyvddD3gtvjV7t9CDQ5i7ilhJlDVoEsAgthAdns3UJCV9fCZVPsOnzxS+5mvpXsMyvB1gkWHygf0+sLQBwJ0Nl6znak7Uj6Gqz+TKmAt6073HYZxQARXE/tAl0wz5fy0A6MEvPrLAQCfjnotT1yvkjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710925623; c=relaxed/simple;
	bh=FWXFO7/wS53yYa9Fy+ULB64gn+3u96bjtgKeOTY5lJQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KpNxDLeBq5g2EkF5TQjr/S0px+TPOPs/OhkeT1JYCzV4bhMvJT6+2qS2s86UIwNZqvnJ60gRFHEuLaih28hLmveUDE/BtmV1Yd6vXjAVDH76rcyR12milyn1YypC0mLJP9fOUv748+/z+VvgTxhVdJIiVSyZigDysmdknHmE6Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CzSAVwbi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710925620;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vvyZY9d5V8ZsKy/ls//fNaM+qioeXtlJCNTY18ukJjE=;
	b=CzSAVwbim7OXipLgXQcYKG+ocUJvDLs2sqWXr1sFjs2+ItOXDPL8mEPHX3NpSMC3r8dFI1
	eyfbESSM/thlORylV0d6qpggTLJ+5VrMc0pF2bK01urLDTobOF2WFr7D0yBMaEkb8XllgE
	mZSQIo/bJ685bTgPdQyii7APAOpwCuM=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-lCc1Twd3N1KJIbjwbtI7_A-1; Wed, 20 Mar 2024 05:06:58 -0400
X-MC-Unique: lCc1Twd3N1KJIbjwbtI7_A-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-5dc4ffda13fso496998a12.0
        for <linux-pci@vger.kernel.org>; Wed, 20 Mar 2024 02:06:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710925618; x=1711530418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vvyZY9d5V8ZsKy/ls//fNaM+qioeXtlJCNTY18ukJjE=;
        b=FUptuDxZRa2/ZASZB9x9KC6hG59wuONF/CJZmV0g7M+/TMKeccqRPGWQShvo8UqBi2
         fNYtEU+wLRjJ95VPZ8CRrJgoV2Ymkn5GtaRohh5EqY+r8nfYpLcbhjHhR1gHQwSGaG94
         36s76GpZhbrJciXVfhRehLZwKop26KryvbGDKTKKGREjhJzZZU0MBq2xMKntF3lzSknZ
         ARh4yM+iVJFiWMuz0KPl7e1KA2RJluyHZJyEiN9x/rRgnm4BwbKBf6nOSugmo04edmZw
         MrgnlNycpXKsvhMF8P1D1lAmc6iNSOGi9iF8ZyiBW3OKTb3sHk/3oq5CYPQxBGlGaFSm
         IQSw==
X-Forwarded-Encrypted: i=1; AJvYcCWNPmsuqxF1MbpgggvNjuDGzWWrSD6XR5PSHQhvbNRLf8uSlNpIifCFd+gJKcp7RPeb8x75NT8zVG38yiD+JibQF2Dbm8J+9JXt
X-Gm-Message-State: AOJu0YxORO9ICFF1/AZ7XqqwjcOzsl5B61uRZjZ7LWtl9+RjLR4sd3KD
	LiQ0jCk9z3MjDKnRL8tTqpwUwyBz8ACS2GwWXw/5KNh0RjdvTO/HRZ2+7oS1TIxQmpUVAq5FPEU
	yhhU437TSUZ/d6hSGd1G7NoLr26eoVbbWNGEfYTKzw5ms3PQVP1ASPMygRAbxlXIC84w3x6sgnU
	iS9t/eH6c30MpiehqMTrAJsdEWZvuC3zN4
X-Received: by 2002:a17:90b:3d0f:b0:29b:af80:7395 with SMTP id pt15-20020a17090b3d0f00b0029baf807395mr2572881pjb.4.1710925617719;
        Wed, 20 Mar 2024 02:06:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDTQV3guyGFQdvFa9MBBMMBqbczimXHCzsrX4mVkxjAgaMaF+JPWIUwRdCZRnXPN+4R1cI0P1kfFEkjG3wfzM=
X-Received: by 2002:a17:90b:3d0f:b0:29b:af80:7395 with SMTP id
 pt15-20020a17090b3d0f00b0029baf807395mr2572866pjb.4.1710925617370; Wed, 20
 Mar 2024 02:06:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGVVp+U+s692sC8-ioGQ7aP2shhQ6qyGOThVk=L6P4_XovDo5Q@mail.gmail.com>
 <73a510c8-51a0-4a4a-1aa8-7bdcd4cdde22@linux.intel.com> <ZfmkXw6pEBP73Txt@MiWiFi-R3L-srv>
In-Reply-To: <ZfmkXw6pEBP73Txt@MiWiFi-R3L-srv>
From: Changhui Zhong <czhong@redhat.com>
Date: Wed, 20 Mar 2024 17:06:46 +0800
Message-ID: <CAGVVp+W2eHM5znGhMFb6xWWWUF4FYJ9FrEGVqKm0jWW+YO1cjg@mail.gmail.com>
Subject: Re: [bug report] WARNING: CPU: 0 PID: 1 at kernel/resource.c:834 __insert_resource+0x84/0x110
To: Baoquan He <bhe@redhat.com>
Cc: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	linux-pci@vger.kernel.org, kexec@lists.infradead.org, 
	Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>, chenhuacai@kernel.org, 
	x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 10:43=E2=80=AFPM Baoquan He <bhe@redhat.com> wrote:
>
> On 03/19/24 at 01:59pm, Ilpo J=C3=A4rvinen wrote:
> > On Tue, 19 Mar 2024, Changhui Zhong wrote:
> >
> > > Hello,
> > >
> > > found a kernel warning issue at "kernel/resource.c:834
> > > __insert_resource+0x84/0x110" ,please help check,
> > >
> > > repo:https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.g=
it
> > > branch: master
> > > commit HEAD:f6cef5f8c37f58a3bc95b3754c3ae98e086631ca
> > >
> > >  [    0.130164] ------------[ cut here ]------------
> > > [    0.130370] WARNING: CPU: 0 PID: 1 at kernel/resource.c:834
> > > __insert_resource+0x84/0x110
> > > [    0.131364] Modules linked in:
> > > [    0.132364] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.8.0+ #1
> > > [    0.133365] Hardware name: Dell Inc. PowerEdge R640/06DKY5, BIOS
> > > 2.15.1 06/15/2022
> > > [    0.134364] RIP: 0010:__insert_resource+0x84/0x110
> > > [    0.135364] Code: d0 4c 39 c1 76 b1 c3 cc cc cc cc 4c 8d 4a 30 48
> > > 8b 52 30 48 85 d2 75 b7 48 89 56 30 49 89 31 48 89 46 28 31 c0 c3 cc
> > > cc cc cc <0f> 0b 48 89 d0 c3 cc cc cc cc 49 89 d2 eb 1a 4d 39 42 08 7=
7
> > > 19 4d
> > > [    0.136363] RSP: 0000:ffffb257400dfe08 EFLAGS: 00010246
> > > [    0.137363] RAX: ffff9e147ffca640 RBX: 0000000000000000 RCX: 00000=
00026000000
> > > [    0.138363] RDX: ffffffff86c45ee0 RSI: ffffffff86c45ee0 RDI: 00000=
00026000000
> > > [    0.139363] RBP: ffffffff8684d120 R08: 0000000035ffffff R09: 00000=
00035ffffff
> > > [    0.140363] R10: 000000002f31646f R11: 0000000059a7ffee R12: fffff=
fff86c45ee0
> > > [    0.141363] R13: 0000000000000000 R14: 0000000000000000 R15: 00000=
00000000000
> > > [    0.142363] FS:  0000000000000000(0000) GS:ffff9e1277800000(0000)
> > > knlGS:0000000000000000
> > > [    0.143363] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > [    0.144363] CR2: ffff9e1333601000 CR3: 0000000332220001 CR4: 00000=
000007706f0
> > > [    0.145363] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000=
00000000000
> > > [    0.146363] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000=
00000000400
> > > [    0.147363] PKRU: 55555554
> > > [    0.148363] Call Trace:
> > > [    0.149364]  <TASK>
> > > [    0.150365]  ? __warn+0x7f/0x130
> > > [    0.151363]  ? __insert_resource+0x84/0x110
> > > [    0.152364]  ? report_bug+0x18a/0x1a0
> > > [    0.153364]  ? handle_bug+0x3c/0x70
> > > [    0.154363]  ? exc_invalid_op+0x14/0x70
> > > [    0.155363]  ? asm_exc_invalid_op+0x16/0x20
> > > [    0.156364]  ? __insert_resource+0x84/0x110
> > > [    0.157364]  ? add_device_randomness+0x75/0xa0
> > > [    0.158363]  insert_resource+0x26/0x50
> > > [    0.159364]  ? __pfx_insert_crashkernel_resources+0x10/0x10
> > > [    0.160363]  insert_crashkernel_resources+0x62/0x70
> >
> > Hi,
> >
> > This seems related to crashkernel stuff, I added a few Ccs related to
> > it.
> >
> > I don't know why you sent this only to linux-pci list as it seems likel=
y
> > to be entirely unrelated to PCI.
>
> Too few info is provided. I guess this is happening on x86_64. Do you
> have the kernel config, and what kernel you are testing? What operation
> are you taking to trigger this?

yes=EF=BC=8Cmy server is x86_64 platform=EF=BC=8Cbase OS is RHEL9.5=EF=BC=
=8Cthe default kernel
is  5.14.0-428.el9.x86_64=EF=BC=8C
and this issue is triggered after compile and installed the upstream
kernel=EF=BC=886.8.0+=EF=BC=89then reboot the machine.
I don't have the kernel config file now, if needed I can reinstall and
collect it=EF=BC=8C

>
> Below commit could be suspect, but not sure if it's the real criminal.
>
> commit 4a693ce65b186fddc1a73621bd6f941e6e3eca21
> Author: Huacai Chen <chenhuacai@kernel.org>
> Date:   Fri Dec 29 16:02:13 2023 +0800
>
>     kdump: defer the insertion of crashkernel resources
>
> Dave reported a similar one, he did kexec reboot firstly, then in 2nd
> kernel crashkernel reservation will trigger the iomem inserting error.
>
> [PATCH] x86/kexec: do not update E820 kexec table for setup_data
> https://lore.kernel.org/all/ZeZ2Kos-OOZNSrmO@darkstar.users.ipa.redhat.co=
m/T/#u
>
> Can you try Dave's patch firstly? If it doesn't work, try reverting
> above Huacai's patch? it may need manual editing.
>

I don't know how to revert Huacai's patch, I don't know much about it,
so=EF=BC=8CI try to apply Dave=E2=80=98s patch=EF=BC=8Cbut it failed=EF=BC=
=9A
```
patching file arch/x86/kernel/e820.c
Hunk #1 FAILED at 1015.
Hunk #2 succeeded at 1038 (offset 2 lines).
Hunk #3 succeeded at 1048 (offset 2 lines).
1 out of 3 hunks FAILED -- saving rejects to file arch/x86/kernel/e820.c.re=
j
```
maybe Dave need to write a new version to fix it,


