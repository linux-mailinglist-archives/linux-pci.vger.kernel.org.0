Return-Path: <linux-pci+bounces-4895-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49EED87FEF4
	for <lists+linux-pci@lfdr.de>; Tue, 19 Mar 2024 14:39:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 921B1B248B6
	for <lists+linux-pci@lfdr.de>; Tue, 19 Mar 2024 13:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 335BE2B9A3;
	Tue, 19 Mar 2024 13:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VIBr/WCn"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8108F5A782
	for <linux-pci@vger.kernel.org>; Tue, 19 Mar 2024 13:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710855562; cv=none; b=Z4j5c4H9bEvjr0fvUSqh/QS6sPIFAEvle8YDpeuAbZiDgo0ovo0/xTreH3LaCvNIU65ATbN1ZMYU3IpnBZTBemcyrLMk9vyPpwBfFHLu58d4SfIe/LXfwMIMELdxTUSW5IIfoIPR0yM9j9PFDVug01rWmpQHx8nXudcBoczm0AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710855562; c=relaxed/simple;
	bh=Oqo/w+AYkwst9kXKDUnqV5VupnE/cvs1ZytTg165Zxs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZZlXk2M+GFFjAlqPqQbcGVomW5tUyjimLbaxWcVXWwu8O7VoFWYgY+pPgMx+G43voOH5brA8xvfeU0oXA3ZCCN182bU8NlHzkXe1mEb3TFodw0Vfa6yBMuqpz9pxP9RZ1Ci92KazvFHTD4FSFcL/cloEmhiYdFh/+pXSKZs+wT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VIBr/WCn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710855559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DOoHg4cHMBv0U+cGgq05M8kV7oKhTeBGztGMvwMOPk0=;
	b=VIBr/WCnBiUD5y4KyS9/ebWC4YEXNn7cMacriLHZ5dcO45oOYLklyq005Fa6zICwjap3Cu
	eqA42WAK421QFPzEP5X5ud4tFiN7GPIROdPnwavZWm2baq6lOktfIQnF6EaoOWt1FCcQdR
	HSynDFtFl2nrQtlFWMFi2zehkjpN9jg=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-kJx8fkG1N7a3GLV9xeltkA-1; Tue, 19 Mar 2024 09:39:18 -0400
X-MC-Unique: kJx8fkG1N7a3GLV9xeltkA-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-29d7e7c0c7cso4343473a91.3
        for <linux-pci@vger.kernel.org>; Tue, 19 Mar 2024 06:39:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710855557; x=1711460357;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DOoHg4cHMBv0U+cGgq05M8kV7oKhTeBGztGMvwMOPk0=;
        b=FLbyKRQfjZGMXFvCAj5tCXeek0bhHD2NAZbUM8EN/83J8XEeot8+bSq8EViSNbJPSW
         V+6o34f0iUbIUmMSG99xGeRMzQAg875P9FyFBw0ujetvn7aetvRQ4zgt4aLclkJl2rfF
         8rtlknOZMeNIiQIV/dRzUjVrRTCbKwy3KrjzBXdDPO8VORx1RwYqwzZ85zzlVGEt0FWZ
         8Y+hrwzewruAwnwue2CvnOK3JOuKzo/mwzEOq2K1e7I+yWsjMCkmfDKgDAWYsciRhTna
         /4eYskiLHjTcQYTSMP4KJ/Gqtj7gl/00tTsk91zd8lvTLVVvM2cb8ilnucjHKcbPmErk
         JZ/g==
X-Forwarded-Encrypted: i=1; AJvYcCXFAIjnka5RG20q4W/xI2pst37pypdfMDqZPl5OSpkM5Xdss7Xiyot8pSUMgGI8r1jAH7mEK9KIpr3nE++3lp9LuapCUqDgZDG+
X-Gm-Message-State: AOJu0YyLpI0dOoBoZxZxbFa2f8nklQ1gi48nnBkbbAFU78IGMim1WT8a
	RduAAmpEK/4YGPJjK9V2g3x6oXYhYHHOeOR4OMiGT/omKWyQHbqeJlu80WJhsZEAc4rK4WN0Xs5
	8GFtJNMeGC0VC8cpuGDldIs2zoHYuRPvsiLYxn9gJtcpAnDcTYVZtsFBdUzu5kYsM1hAVSxciFS
	c9kCAQ22IOu6HW00DnK8DXNPILGaI8x5MIWe05irDkjjSvOdlG
X-Received: by 2002:a17:90a:7785:b0:29e:2b58:ba55 with SMTP id v5-20020a17090a778500b0029e2b58ba55mr2380908pjk.20.1710855556896;
        Tue, 19 Mar 2024 06:39:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDwbo7UTYBpL5bbgUeLQDyqOLaaHTpVgDoMxZ1AHofxC5vKDoFZMRofr2v6GT8rff/1W4Q/ho/qJyLMFXvjSM=
X-Received: by 2002:a17:90a:7785:b0:29e:2b58:ba55 with SMTP id
 v5-20020a17090a778500b0029e2b58ba55mr2380892pjk.20.1710855556482; Tue, 19 Mar
 2024 06:39:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGVVp+U+s692sC8-ioGQ7aP2shhQ6qyGOThVk=L6P4_XovDo5Q@mail.gmail.com>
 <73a510c8-51a0-4a4a-1aa8-7bdcd4cdde22@linux.intel.com>
In-Reply-To: <73a510c8-51a0-4a4a-1aa8-7bdcd4cdde22@linux.intel.com>
From: Changhui Zhong <czhong@redhat.com>
Date: Tue, 19 Mar 2024 21:39:05 +0800
Message-ID: <CAGVVp+W_YYJJ_-+dmLEca=Lu=xfSC53O6Yu1qmLrWJ-qHchWfA@mail.gmail.com>
Subject: Re: [bug report] WARNING: CPU: 0 PID: 1 at kernel/resource.c:834 __insert_resource+0x84/0x110
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Baoquan He <bhe@redhat.com>, linux-pci@vger.kernel.org, kexec@lists.infradead.org, 
	Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi=EF=BC=8CIlpo

thanks for your reply,
I didn't know which mailing list I should report this issue to, and
then I searched and saw that there was a patch about kernel/resource.c
in the linux-pci mailing list, so I reported it here.

Thanks=EF=BC=8C

On Tue, Mar 19, 2024 at 8:00=E2=80=AFPM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> On Tue, 19 Mar 2024, Changhui Zhong wrote:
>
> > Hello,
> >
> > found a kernel warning issue at "kernel/resource.c:834
> > __insert_resource+0x84/0x110" ,please help check,
> >
> > repo:https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> > branch: master
> > commit HEAD:f6cef5f8c37f58a3bc95b3754c3ae98e086631ca
> >
> >  [    0.130164] ------------[ cut here ]------------
> > [    0.130370] WARNING: CPU: 0 PID: 1 at kernel/resource.c:834
> > __insert_resource+0x84/0x110
> > [    0.131364] Modules linked in:
> > [    0.132364] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.8.0+ #1
> > [    0.133365] Hardware name: Dell Inc. PowerEdge R640/06DKY5, BIOS
> > 2.15.1 06/15/2022
> > [    0.134364] RIP: 0010:__insert_resource+0x84/0x110
> > [    0.135364] Code: d0 4c 39 c1 76 b1 c3 cc cc cc cc 4c 8d 4a 30 48
> > 8b 52 30 48 85 d2 75 b7 48 89 56 30 49 89 31 48 89 46 28 31 c0 c3 cc
> > cc cc cc <0f> 0b 48 89 d0 c3 cc cc cc cc 49 89 d2 eb 1a 4d 39 42 08 77
> > 19 4d
> > [    0.136363] RSP: 0000:ffffb257400dfe08 EFLAGS: 00010246
> > [    0.137363] RAX: ffff9e147ffca640 RBX: 0000000000000000 RCX: 0000000=
026000000
> > [    0.138363] RDX: ffffffff86c45ee0 RSI: ffffffff86c45ee0 RDI: 0000000=
026000000
> > [    0.139363] RBP: ffffffff8684d120 R08: 0000000035ffffff R09: 0000000=
035ffffff
> > [    0.140363] R10: 000000002f31646f R11: 0000000059a7ffee R12: fffffff=
f86c45ee0
> > [    0.141363] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000=
000000000
> > [    0.142363] FS:  0000000000000000(0000) GS:ffff9e1277800000(0000)
> > knlGS:0000000000000000
> > [    0.143363] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [    0.144363] CR2: ffff9e1333601000 CR3: 0000000332220001 CR4: 0000000=
0007706f0
> > [    0.145363] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000=
000000000
> > [    0.146363] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000=
000000400
> > [    0.147363] PKRU: 55555554
> > [    0.148363] Call Trace:
> > [    0.149364]  <TASK>
> > [    0.150365]  ? __warn+0x7f/0x130
> > [    0.151363]  ? __insert_resource+0x84/0x110
> > [    0.152364]  ? report_bug+0x18a/0x1a0
> > [    0.153364]  ? handle_bug+0x3c/0x70
> > [    0.154363]  ? exc_invalid_op+0x14/0x70
> > [    0.155363]  ? asm_exc_invalid_op+0x16/0x20
> > [    0.156364]  ? __insert_resource+0x84/0x110
> > [    0.157364]  ? add_device_randomness+0x75/0xa0
> > [    0.158363]  insert_resource+0x26/0x50
> > [    0.159364]  ? __pfx_insert_crashkernel_resources+0x10/0x10
> > [    0.160363]  insert_crashkernel_resources+0x62/0x70
>
> Hi,
>
> This seems related to crashkernel stuff, I added a few Ccs related to
> it.
>
> I don't know why you sent this only to linux-pci list as it seems likely
> to be entirely unrelated to PCI.
>
> --
>  i.
>
> > [    0.161365]  do_one_initcall+0x41/0x300
> > [    0.162364]  kernel_init_freeable+0x21e/0x320
> > [    0.163365]  ? __pfx_kernel_init+0x10/0x10
> > [    0.164364]  kernel_init+0x16/0x1c0
> > [    0.165364]  ret_from_fork+0x2d/0x50
> > [    0.166364]  ? __pfx_kernel_init+0x10/0x10
> > [    0.167363]  ret_from_fork_asm+0x1a/0x30
> > [    0.168365]  </TASK>
> > [    0.169363] ---[ end trace 0000000000000000 ]---
> >
> > Thanks,
> >
> >
>


