Return-Path: <linux-pci+bounces-4898-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E737987FFD1
	for <lists+linux-pci@lfdr.de>; Tue, 19 Mar 2024 15:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E0E72844CF
	for <lists+linux-pci@lfdr.de>; Tue, 19 Mar 2024 14:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5F524B33;
	Tue, 19 Mar 2024 14:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DlPpZgWZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764D72206E
	for <linux-pci@vger.kernel.org>; Tue, 19 Mar 2024 14:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710859393; cv=none; b=BtRy/yvIAhaDcJNjJJ6VwX5wL9Pso5N9QczVnxT12qSnE2JrOqQ+nU8piDS6bdwfBsGb2HQMR4co1V/B+25nsUY9NeCtSCzlItFHPKXx3uiBgb61/B4nn5Yb5AeiejwxAhQNlsuiikiRLJNr5qjP1uIw/RPeDdwfCftTJl0Kb1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710859393; c=relaxed/simple;
	bh=4+HZAncwpFKgQpdDvytYxZUXQuNnlUeDnWBWiFx3KJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cjPw7dJkcjJCrTOc4HYIbs1O1BuGZV6m7AT6lap6VqmH9DW8yic36Gqm7d8RtYCBsYASRqVdoykv1Bb0Kvs52X0TV0M2XzFGQHCtOymUMiT8hYtSJ22hedo+TiUhXZYSdSQcktRQcZD0D6QayM65SSEzTQRU2eDSNpJraLRHIBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DlPpZgWZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710859390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AYG2jnO2I6ZWsEBmX/17X56edUt3t9+JEnjbaIgvlxM=;
	b=DlPpZgWZkOAGfuNyiICOukoIBgEvIuRML+407KCkEPt17lEI4rwaq6LPj0RGAEXrvdAg6h
	hbfHwcpwr4pdhBw2c9aTRjfyGluKof0AbfcjuIF392acdwvGXuE5Be749FeBxr0Ek91U2C
	GvLLwkiozGNPIUSP9hwde7sv4HK8+EQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-pYKmZs74Ol-tf-UjKmQEjg-1; Tue, 19 Mar 2024 10:43:07 -0400
X-MC-Unique: pYKmZs74Ol-tf-UjKmQEjg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C465D180A1A3;
	Tue, 19 Mar 2024 14:43:06 +0000 (UTC)
Received: from localhost (unknown [10.72.116.12])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 8F24440C6DB7;
	Tue, 19 Mar 2024 14:43:04 +0000 (UTC)
Date: Tue, 19 Mar 2024 22:42:39 +0800
From: Baoquan He <bhe@redhat.com>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Changhui Zhong <czhong@redhat.com>, linux-pci@vger.kernel.org,
	kexec@lists.infradead.org, Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>, chenhuacai@kernel.org,
	x86@kernel.org
Subject: Re: [bug report] WARNING: CPU: 0 PID: 1 at kernel/resource.c:834
 __insert_resource+0x84/0x110
Message-ID: <ZfmkXw6pEBP73Txt@MiWiFi-R3L-srv>
References: <CAGVVp+U+s692sC8-ioGQ7aP2shhQ6qyGOThVk=L6P4_XovDo5Q@mail.gmail.com>
 <73a510c8-51a0-4a4a-1aa8-7bdcd4cdde22@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <73a510c8-51a0-4a4a-1aa8-7bdcd4cdde22@linux.intel.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

On 03/19/24 at 01:59pm, Ilpo Järvinen wrote:
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
> > [    0.137363] RAX: ffff9e147ffca640 RBX: 0000000000000000 RCX: 0000000026000000
> > [    0.138363] RDX: ffffffff86c45ee0 RSI: ffffffff86c45ee0 RDI: 0000000026000000
> > [    0.139363] RBP: ffffffff8684d120 R08: 0000000035ffffff R09: 0000000035ffffff
> > [    0.140363] R10: 000000002f31646f R11: 0000000059a7ffee R12: ffffffff86c45ee0
> > [    0.141363] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> > [    0.142363] FS:  0000000000000000(0000) GS:ffff9e1277800000(0000)
> > knlGS:0000000000000000
> > [    0.143363] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [    0.144363] CR2: ffff9e1333601000 CR3: 0000000332220001 CR4: 00000000007706f0
> > [    0.145363] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > [    0.146363] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
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

Too few info is provided. I guess this is happening on x86_64. Do you
have the kernel config, and what kernel you are testing? What operation
are you taking to trigger this?

Below commit could be suspect, but not sure if it's the real criminal.

commit 4a693ce65b186fddc1a73621bd6f941e6e3eca21
Author: Huacai Chen <chenhuacai@kernel.org>
Date:   Fri Dec 29 16:02:13 2023 +0800

    kdump: defer the insertion of crashkernel resources

Dave reported a similar one, he did kexec reboot firstly, then in 2nd
kernel crashkernel reservation will trigger the iomem inserting error.

[PATCH] x86/kexec: do not update E820 kexec table for setup_data
https://lore.kernel.org/all/ZeZ2Kos-OOZNSrmO@darkstar.users.ipa.redhat.com/T/#u

Can you try Dave's patch firstly? If it doesn't work, try reverting
above Huacai's patch? it may need manual editing.


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


