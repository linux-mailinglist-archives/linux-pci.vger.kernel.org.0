Return-Path: <linux-pci+bounces-4610-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 862D0875599
	for <lists+linux-pci@lfdr.de>; Thu,  7 Mar 2024 18:54:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 153611F21A79
	for <lists+linux-pci@lfdr.de>; Thu,  7 Mar 2024 17:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B580130E55;
	Thu,  7 Mar 2024 17:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M0uLbL19"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991371DA27;
	Thu,  7 Mar 2024 17:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709834089; cv=none; b=OqIiX2WReDQEUH4wibnrZO8cEdm6hTvZMGF5LSpuXb3knf1poaCmXm+L9cQ+Ib+QrWPth51yfk2XKTSlDW45BYHceBaSoQAJebz0BNdxS1qshbvTSKHc4tmPzTbGQmkXfiNJ37Oz0e5r/hZSmyFyis98bqjpZI9eQnLR/HMmui4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709834089; c=relaxed/simple;
	bh=PmmyfrRXWqMh6byie9X2x5dypq+poBafm1g1/7niQbI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pOS4ZfX5x48uAr56cej3W/CVk6KnjbGXDjRjuSiRTXpKsa0FjIZj7HHKQ8Ft7Pn5/nGYl8OzWdC0CS/RkfGaz2ZWKIOY5zdWL/o72d3IvF3GutzmvABP2J5iYoJBBSiIPAaLZjT0WFec9LDujkW/NXQlmH4MuO3e5enmh7IOhKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M0uLbL19; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-33e6f9ce76aso404476f8f.3;
        Thu, 07 Mar 2024 09:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709834086; x=1710438886; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TSuZ9uOkD/FjUsG2E5ZOB/LbYzDe67kxmR+IjAVxz7E=;
        b=M0uLbL19YJ2axnz0JKJBRdGWWpz8io8P97aWlSZe5jY8csfbgJBIRbMn0XEGMUmiym
         4YV5GhG75cXN5oQye64ewjIJNzEwjIgbwKIID06kzPh4rjFA6WkC03oa84ZQ4MX60oGV
         qxaT9UREbLa2ZE3usLHulpRgdXoqgqfYlJz1cH1JAgO2lt2aFsgdDeCY1/Whss2sEEhS
         oNZxVRttUxepsse4jVEs0PhhVNir6xdQcem0da0fKBddyrscuZM/dCFp4Xs4+kgKv6nx
         iAshaIVajCq6EECPNRwGhJ+glOu7IBIsnxE965S0Tga3A+d/hboO6b9DQO8axtJIiB8o
         6gJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709834086; x=1710438886;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TSuZ9uOkD/FjUsG2E5ZOB/LbYzDe67kxmR+IjAVxz7E=;
        b=TKq+23AcFhEyQX+DGIRg4/H0krHJL56N9cAYXjTyu2nDK6NyyT1kgGV4YWrjUITC5t
         kvbtBLaOr2FrWJetTGjbzurCzQ1GHl6Lg1OQDVCFkPujPnS+COZOB5doJujHx+y73DLW
         Lv+tM4W8FmVunOsOKVxfe3u7l5ONjHr3VJkU88BZVjSw5LBeMjLg58im7hLKbuIiscmt
         I7OactThN7LLIRHajNNQDXQg7sPThEwl32UcYruoIf2iALvq2O8OGe+cuixzYAg6JQs5
         XEcDCRgozMUIFFl6cThq9HK33nBDp4eLljsz3B4L3eq9yd6diVoHQYOtNOMBRPX//Ga5
         NAxA==
X-Forwarded-Encrypted: i=1; AJvYcCWrk/JaCxNN2clNMO6Y/zqUqy/NkJBspvZPHOng88zT4X1YdSaHVc7lkRTB/WscQRDqGgEYB1E8vGuLQGDgQ3kRrvH9P2usw7DHo4ub4tj9hpisrZKOV/euSk7BubyF
X-Gm-Message-State: AOJu0YxdYRIXFaJdYPCg7SrmLumZ0jAgPblpiXC7hn6rE3mpfZ6l2UdV
	nWeJgUd6Jv2xeATdKaGN6YfSDdLYoAUpIEy42JIJy4YLGbpgok7H4C8A8/W0Kfdc9Bao8QyI05r
	GDcSLe4Hg5bgb+jI8oukVUjDMYow=
X-Google-Smtp-Source: AGHT+IELlMA7naIHOj4mLfsx+ssUuH58XPaMrNk3VD5C9cctlsAHYBGSGF3DhK3x1Niz0nBeuLiZC1m8+pzBcPe19cA=
X-Received: by 2002:adf:cf0e:0:b0:33d:6301:91c5 with SMTP id
 o14-20020adfcf0e000000b0033d630191c5mr13604502wrj.3.1709834085521; Thu, 07
 Mar 2024 09:54:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANiq72ka4rir+RTN2FQoT=Vvprp_Ao-CvoYEkSNqtSY+RZj+AA@mail.gmail.com>
In-Reply-To: <CANiq72ka4rir+RTN2FQoT=Vvprp_Ao-CvoYEkSNqtSY+RZj+AA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 7 Mar 2024 09:54:34 -0800
Message-ID: <CAADnVQL1Zt5dwFv9HPDKDuPEKa6V7gb5j-D-LPWv47hC6mtwgw@mail.gmail.com>
Subject: Re: vm_area at addr ffffffffc0800000 is not marked as VM_IOREMAP
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Christoph Hellwig <hch@infradead.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, linux-mm <linux-mm@kvack.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 7, 2024 at 9:42=E2=80=AFAM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> Hi arm64/bpf/pci,
>
> In today's next-20240307 with a defconfig LLVM=3D1 I am seeing [1] under
> QEMU virt, i.e. from
> https://lore.kernel.org/all/20240305030516.41519-2-alexei.starovoitov@gma=
il.com/
> applied to the bpf-next tree.
>
> Cheers,
> Miguel
>
> [1]
>
> [    0.425177] pci-host-generic 4010000000.pcie: host bridge
> /pcie@10000000 ranges:
> [    0.425886] pci-host-generic 4010000000.pcie:       IO
> 0x003eff0000..0x003effffff -> 0x0000000000
> [    0.426534] pci-host-generic 4010000000.pcie:      MEM
> 0x0010000000..0x003efeffff -> 0x0010000000
> [    0.426764] pci-host-generic 4010000000.pcie:      MEM
> 0x8000000000..0xffffffffff -> 0x8000000000
> [    0.427324] ------------[ cut here ]------------
> [    0.427456] vm_area at addr ffffffffc0800000 is not marked as VM_IOREM=
AP
> [    0.427944] WARNING: CPU: 0 PID: 1 at mm/vmalloc.c:315
> ioremap_page_range+0x25c/0x2bc

Great. Thanks for flagging.
Looks like this check found some misuse of ioremap_page_range.

Note that without marking the address range as VM_IOREMAP
the vread_iter() will be bulk reading over IO and might
cause hard hangs and what not.
pci drivers need to mark their range as VM_IOREMAP.
That was the reason for the warning.

I'll try to figure out which piece of code missed passing
VM_IOREMAP into vm_area.
I'm not familiar with pci, so help is greatly appreciated.

> [    0.429236] CPU: 0 PID: 1 Comm: swapper/0 Not tainted
> 6.8.0-rc7-next-20240307 #1
> [    0.429513] Hardware name: linux,dummy-virt (DT)
> [    0.429751] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYP=
E=3D--)
> [    0.429946] pc : ioremap_page_range+0x25c/0x2bc
> [    0.430063] lr : ioremap_page_range+0x258/0x2bc
> [    0.432220] Call trace:
> [    0.432462]  ioremap_page_range+0x25c/0x2bc
> [    0.432703]  pci_remap_iospace+0x78/0x84
> [    0.432854]  devm_pci_remap_iospace+0x54/0x98
> [    0.432979]  devm_of_pci_bridge_init+0x2e0/0x48c
> [    0.433114]  devm_pci_alloc_host_bridge+0xa4/0xbc
> [    0.433254]  pci_host_common_probe+0x48/0x1a4
> [    0.433363]  platform_probe+0xa8/0xd0
> [    0.433456]  really_probe+0x130/0x2e4
> [    0.433545]  __driver_probe_device+0xa0/0x128
> [    0.433647]  driver_probe_device+0x3c/0x1f8
> [    0.433742]  __driver_attach+0xdc/0x1a4
> [    0.433834]  bus_for_each_dev+0xe8/0x140
> [    0.433925]  driver_attach+0x24/0x30
> [    0.434011]  bus_add_driver+0x154/0x240
> [    0.434104]  driver_register+0x68/0x100
> [    0.434196]  __platform_driver_register+0x24/0x30
> [    0.434306]  gen_pci_driver_init+0x1c/0x28
> [    0.434407]  do_one_initcall+0xbc/0x248
> [    0.434533]  do_initcall_level+0x94/0xb4
> [    0.434632]  do_initcalls+0x54/0x94
> [    0.434721]  do_basic_setup+0x50/0x60
> [    0.434810]  kernel_init_freeable+0x10c/0x178
> [    0.434912]  kernel_init+0x20/0x1a0
> [    0.435003]  ret_from_fork+0x10/0x20
> [    0.435227] ---[ end trace 0000000000000000 ]---

