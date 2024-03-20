Return-Path: <linux-pci+bounces-4961-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1559F881229
	for <lists+linux-pci@lfdr.de>; Wed, 20 Mar 2024 14:16:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C13C3281681
	for <lists+linux-pci@lfdr.de>; Wed, 20 Mar 2024 13:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028743FE4F;
	Wed, 20 Mar 2024 13:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jqk6MmjZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D903CF6A
	for <linux-pci@vger.kernel.org>; Wed, 20 Mar 2024 13:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710940573; cv=none; b=dqHdsPiTdkeQI3+xoO7yXADcNTwWic432J/rNv4sXIibncw9UO8yi8cscW5TgVd7K465/4rorTH6YEgQMQfwZTsp58FynXrToRlXKMjdImHlJQUCfUHboVJF3frMFIZGZgWMMpE8o4FOFk5/NWRhvlGrTIUGyc4UIa7NqyMla/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710940573; c=relaxed/simple;
	bh=+nab052MHvcSkcHGTFAnCgSKo9mmHqP4opJuMku2lHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KvzO1fVEOyhhMS7Lgig/2NQogHKwZx6Dw1ewI3ut4h2GNIfUXrR02nlL9/QbGDb7tMxU6W2MSc2og4m7M8ywzOilw3EkStTz1IgDxpLWZOKG2fQwSOEYvfffqrUjmlcNwA+YxqZVXURj8wxhst0CwvONbsG7NFHflRsKy97fQlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jqk6MmjZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710940571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xedtlwQKGSj2FZUSBGp+gGQ1nyxBUFvCh/rAUoEHjUU=;
	b=Jqk6MmjZEzzHYw8HPh+NFFPQ6A+N32XbY/7YvtjKqamzv+1f15JhZZuOe29Favv91uJ0g1
	GH2TwnhPEOeq23B5m9oi7a9eAZH1i4SOGTzQmYVWVOYhAzdMWlJSylv2+jbeAkMrEko6Np
	Zp0Dq5bxYV9D59+ugJTBz/LMaSNPgxg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-633-55BhU2ZKPseUT4F3QBbX2A-1; Wed,
 20 Mar 2024 09:16:09 -0400
X-MC-Unique: 55BhU2ZKPseUT4F3QBbX2A-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 710C23815EE2;
	Wed, 20 Mar 2024 13:16:08 +0000 (UTC)
Received: from localhost (unknown [10.72.116.12])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id F02DB492BD4;
	Wed, 20 Mar 2024 13:16:06 +0000 (UTC)
Date: Wed, 20 Mar 2024 21:15:59 +0800
From: Baoquan He <bhe@redhat.com>
To: Changhui Zhong <czhong@redhat.com>
Cc: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-pci@vger.kernel.org, kexec@lists.infradead.org,
	Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
	chenhuacai@kernel.org, x86@kernel.org
Subject: Re: [bug report] WARNING: CPU: 0 PID: 1 at kernel/resource.c:834
 __insert_resource+0x84/0x110
Message-ID: <Zfrhj3rJpZKRSDWn@MiWiFi-R3L-srv>
References: <CAGVVp+U+s692sC8-ioGQ7aP2shhQ6qyGOThVk=L6P4_XovDo5Q@mail.gmail.com>
 <73a510c8-51a0-4a4a-1aa8-7bdcd4cdde22@linux.intel.com>
 <ZfmkXw6pEBP73Txt@MiWiFi-R3L-srv>
 <CAGVVp+W2eHM5znGhMFb6xWWWUF4FYJ9FrEGVqKm0jWW+YO1cjg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGVVp+W2eHM5znGhMFb6xWWWUF4FYJ9FrEGVqKm0jWW+YO1cjg@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

On 03/20/24 at 05:06pm, Changhui Zhong wrote:
> On Tue, Mar 19, 2024 at 10:43 PM Baoquan He <bhe@redhat.com> wrote:
> >
> > On 03/19/24 at 01:59pm, Ilpo Järvinen wrote:
> > > On Tue, 19 Mar 2024, Changhui Zhong wrote:
> > >
> > > > Hello,
> > > >
> > > > found a kernel warning issue at "kernel/resource.c:834
> > > > __insert_resource+0x84/0x110" ,please help check,
> > > >
> > > > repo:https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> > > > branch: master
> > > > commit HEAD:f6cef5f8c37f58a3bc95b3754c3ae98e086631ca
> > > >
> > > >  [    0.130164] ------------[ cut here ]------------
> > > > [    0.130370] WARNING: CPU: 0 PID: 1 at kernel/resource.c:834
> > > > __insert_resource+0x84/0x110
> > > > [    0.131364] Modules linked in:
> > > > [    0.132364] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.8.0+ #1
> > > > [    0.133365] Hardware name: Dell Inc. PowerEdge R640/06DKY5, BIOS
> > > > 2.15.1 06/15/2022
> > > > [    0.134364] RIP: 0010:__insert_resource+0x84/0x110
> > > > [    0.135364] Code: d0 4c 39 c1 76 b1 c3 cc cc cc cc 4c 8d 4a 30 48
> > > > 8b 52 30 48 85 d2 75 b7 48 89 56 30 49 89 31 48 89 46 28 31 c0 c3 cc
> > > > cc cc cc <0f> 0b 48 89 d0 c3 cc cc cc cc 49 89 d2 eb 1a 4d 39 42 08 77
> > > > 19 4d
> > > > [    0.136363] RSP: 0000:ffffb257400dfe08 EFLAGS: 00010246
> > > > [    0.137363] RAX: ffff9e147ffca640 RBX: 0000000000000000 RCX: 0000000026000000
> > > > [    0.138363] RDX: ffffffff86c45ee0 RSI: ffffffff86c45ee0 RDI: 0000000026000000
> > > > [    0.139363] RBP: ffffffff8684d120 R08: 0000000035ffffff R09: 0000000035ffffff
> > > > [    0.140363] R10: 000000002f31646f R11: 0000000059a7ffee R12: ffffffff86c45ee0
> > > > [    0.141363] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> > > > [    0.142363] FS:  0000000000000000(0000) GS:ffff9e1277800000(0000)
> > > > knlGS:0000000000000000
> > > > [    0.143363] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > [    0.144363] CR2: ffff9e1333601000 CR3: 0000000332220001 CR4: 00000000007706f0
> > > > [    0.145363] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > > [    0.146363] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > > [    0.147363] PKRU: 55555554
> > > > [    0.148363] Call Trace:
> > > > [    0.149364]  <TASK>
> > > > [    0.150365]  ? __warn+0x7f/0x130
> > > > [    0.151363]  ? __insert_resource+0x84/0x110
> > > > [    0.152364]  ? report_bug+0x18a/0x1a0
> > > > [    0.153364]  ? handle_bug+0x3c/0x70
> > > > [    0.154363]  ? exc_invalid_op+0x14/0x70
> > > > [    0.155363]  ? asm_exc_invalid_op+0x16/0x20
> > > > [    0.156364]  ? __insert_resource+0x84/0x110
> > > > [    0.157364]  ? add_device_randomness+0x75/0xa0
> > > > [    0.158363]  insert_resource+0x26/0x50
> > > > [    0.159364]  ? __pfx_insert_crashkernel_resources+0x10/0x10
> > > > [    0.160363]  insert_crashkernel_resources+0x62/0x70
> > >
> > > Hi,
> > >
> > > This seems related to crashkernel stuff, I added a few Ccs related to
> > > it.
> > >
> > > I don't know why you sent this only to linux-pci list as it seems likely
> > > to be entirely unrelated to PCI.
> >
> > Too few info is provided. I guess this is happening on x86_64. Do you
> > have the kernel config, and what kernel you are testing? What operation
> > are you taking to trigger this?
> 
> yes，my server is x86_64 platform，base OS is RHEL9.5，the default kernel
> is  5.14.0-428.el9.x86_64，
> and this issue is triggered after compile and installed the upstream
> kernel（6.8.0+）then reboot the machine.
> I don't have the kernel config file now, if needed I can reinstall and
> collect it，
> 
> >
> > Below commit could be suspect, but not sure if it's the real criminal.
> >
> > commit 4a693ce65b186fddc1a73621bd6f941e6e3eca21
> > Author: Huacai Chen <chenhuacai@kernel.org>
> > Date:   Fri Dec 29 16:02:13 2023 +0800
> >
> >     kdump: defer the insertion of crashkernel resources
> >
> > Dave reported a similar one, he did kexec reboot firstly, then in 2nd
> > kernel crashkernel reservation will trigger the iomem inserting error.
> >
> > [PATCH] x86/kexec: do not update E820 kexec table for setup_data
> > https://lore.kernel.org/all/ZeZ2Kos-OOZNSrmO@darkstar.users.ipa.redhat.com/T/#u
> >
> > Can you try Dave's patch firstly? If it doesn't work, try reverting
> > above Huacai's patch? it may need manual editing.
> >
> 
> I don't know how to revert Huacai's patch, I don't know much about it,
> so，I try to apply Dave‘s patch，but it failed：
> ```
> patching file arch/x86/kernel/e820.c
> Hunk #1 FAILED at 1015.
> Hunk #2 succeeded at 1038 (offset 2 lines).
> Hunk #3 succeeded at 1048 (offset 2 lines).
> 1 out of 3 hunks FAILED -- saving rejects to file arch/x86/kernel/e820.c.rej
> ```
> maybe Dave need to write a new version to fix it,

No, please go get your colleagues' help. There must be people around you
knowing how to handle this.


