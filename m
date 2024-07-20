Return-Path: <linux-pci+bounces-10562-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D707937F00
	for <lists+linux-pci@lfdr.de>; Sat, 20 Jul 2024 07:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D4291C20FF3
	for <lists+linux-pci@lfdr.de>; Sat, 20 Jul 2024 05:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1ADC157;
	Sat, 20 Jul 2024 05:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IXe8D3gI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F02B64A;
	Sat, 20 Jul 2024 05:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721452679; cv=none; b=mbGGx8l2hjCKWIoUufz6YGBOP/YbtOOc7mhW57fEMdeyCHdwoRnMg1heslO0C6fxHZ2gZujM2ZG3tMh9twVRjGz4Jg0clF74i8OGJ6pAt+BaunIzdzblAXx98RUoPBlAnna3gpVt9XkXuIrfnirvNCFNzMhEEyGzaZTeZhY0bek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721452679; c=relaxed/simple;
	bh=Co/fIU3+hK9yPLq9c9sahxECZ0uQvje2TgCbgIgsiK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lm1pO2S8iF0pHY04x5Q+2wVjK9NbNcqpqTMuur+D80lH+/8eu/MH2YUjDLPDWIz5QZaZqnwzJoXg+zO9UGbyjaxDCRc4TEeH9hFkgsmWwiM7Q3a1cyBTYpbrsyIj5wv3rvHTMBsDRE3BElI7O3MW8IoKeKIZcdNWSPQKeD+ODbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IXe8D3gI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D506C2BD10;
	Sat, 20 Jul 2024 05:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721452678;
	bh=Co/fIU3+hK9yPLq9c9sahxECZ0uQvje2TgCbgIgsiK4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IXe8D3gIjUhFYFC5tpcDA3CPQKf0rbvp5xi2H8AS5g11tK8esdN8u6ajwCY2pzyWN
	 QzCdmtOzxu09MM9b8rWhiVnznjQxHHCJzaUHv4LHJzkcD0Kb/MI1fCeCB2vHhuOJM/
	 FVLqBQLKnctiMw5pr2M29LTwFSRLqqY4x4tIl0vQ=
Date: Sat, 20 Jul 2024 07:17:55 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Keith Busch <kbusch@meta.com>
Cc: rafael@kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, bhelgaas@google.com, lukas@wunner.de,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] driver core: get kobject ref when accessing dev_attrs
Message-ID: <2024072058-dork-ferret-71d5@gregkh>
References: <20240719185513.3376321-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240719185513.3376321-1-kbusch@meta.com>

On Fri, Jul 19, 2024 at 11:55:13AM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Get a reference to the device's kobject while storing and showing device
> attributes so that the device is valid for the lifetime of the sysfs access.
> Without this, the device may be released and use-after-free will occur.
> 
> This is an easy problem to recreate with pci switches. Basic topology on a my
> qemu test machine:
> 
> -[0000:00]-+-00.0  Intel Corporation 82G33/G31/P35/P31 Express DRAM Controller
>            +-01.0-[01-04]----00.0-[02-04]--+-00.0-[03]--
>                                            \-01.0-[04]----00.0  Red Hat, Inc. Virtio block device
> 
> Simultaneously remove devices 04:00.0 and 01:00.0 and you'll hit it:
> 
>  # echo 1 > /sys/bus/pci/devices/0000\:04\:00.0/remove &
>  # echo 1 > /sys/bus/pci/devices/0000\:01\:00.0/remove

So you remove the parent before the child and also want to remove the
child at the same time?  You are going to have bad problems here :)

>  Oops: general protection fault, probably for non-canonical address 0x6b6b6b6b6b6b6b9b: 0000 [#1] PREEMPT SMP PTI
>  CPU: 9 PID: 359 Comm: bash Not tainted 6.10.0-rc1-00183-gea4516b2b250 #256
>  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.2-14-g1e1da7a96300-prebuilt.qemu.org 04/01/2014
>  RIP: 0010:pci_stop_bus_device+0x15/0x90
>  Code: 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 41 54 55 48 89 fd 53 4c 8b 67 18 4d 85 e4 74 2d <49> 8b 7c 24 30 49 83 c4 28 4c 39 e7 74 1f 48 8b 5f 08 e8 d4 ff ff
>  RSP: 0018:ffffc90000b67dd0 EFLAGS: 00010202
>  RAX: 0000000000000000 RBX: ffff88800768c0c8 RCX: 0000000000000000
>  RDX: 0000000000000000 RSI: ffffffff8365bc00 RDI: ffff88800768c000
>  RBP: ffff88800768c000 R08: 0000000000000000 R09: 0000000000000000
>  R10: ffffc90000b67df0 R11: 0000000000000003 R12: 6b6b6b6b6b6b6b6b
>  R13: ffffc90000b67e90 R14: ffff8880075bccc8 R15: ffff88801082a620
>  FS:  00007fe0c951e740(0000) GS:ffff88803ea80000(0000) knlGS:0000000000000000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 0000560aaac4b030 CR3: 00000000108ae004 CR4: 0000000000770ef0
>  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>  PKRU: 55555554
>  Call Trace:
>   <TASK>
>   ? die_addr+0x37/0x90
>   ? exc_general_protection+0x1e5/0x430
>   ? asm_exc_general_protection+0x26/0x30
>   ? pci_stop_bus_device+0x15/0x90
>   pci_stop_and_remove_bus_device_locked+0x1a/0x30
>   remove_store+0x7d/0x90
>   kernfs_fop_write_iter+0x13c/0x200
>   vfs_write+0x359/0x510
>   ksys_write+0x69/0xf0
>   do_syscall_64+0x68/0x140
>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  drivers/base/core.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 131d96c6090be..108f2aa6eaaa9 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -2433,12 +2433,15 @@ static ssize_t dev_attr_show(struct kobject *kobj, struct attribute *attr,
>  	struct device *dev = kobj_to_dev(kobj);
>  	ssize_t ret = -EIO;
>  
> +	if (!kobject_get_unless_zero(kobj))
> +		return -ENXIO;

We've been down this path before, and it doesn't end well from what I
recall.  Attributes that when written to remove themselves need to call
the correct function to do so (look at how scsi does it).  I think this
change will now break that functionality.  Look in the email archives a
long time ago for more details, I can't recall them at the moment,
sorry.

thanks,

greg k-h

