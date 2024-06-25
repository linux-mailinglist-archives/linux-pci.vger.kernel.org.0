Return-Path: <linux-pci+bounces-9252-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA27C917138
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jun 2024 21:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD0D41C22506
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jun 2024 19:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6CF146A93;
	Tue, 25 Jun 2024 19:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tEhSIAiT"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C0671750;
	Tue, 25 Jun 2024 19:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719344776; cv=none; b=AwodFMKWKh/gILHL2izBwKW5gaBADzeR59CnudyOXHJlK8mzF0Cn+5Ly4pKYnsw5EdF9FV3GROSDqAq9L+y7qOUQ5BVbUpbDxmu3lVejMLrzdlGaMpoXBt7olu7W5zchkHYYNIjoo9PXYfNm7opHMl5gKHsaI9sh6OsFwDoSCII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719344776; c=relaxed/simple;
	bh=1ycjCg0/j3hmb5tsZ6Wa+p05u6moZZySGUMCKxo8Jwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EQQy3+DU1MTsH5P9nw5FcwVXumsCw2Ggwtf1rLvuF7LenFzv7Rllg77Sr2mCtK7pJet8Y0ceb8/F8wqzkHfJ2zJLvid0IA4dugWhMb3Cu+7vp5Oi8xi7oJ+2ffuZ7XNSzZggPmR1NbKEneCmiFsFamRtJNNwCiZkmn9Nvjgx4d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tEhSIAiT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEE61C32781;
	Tue, 25 Jun 2024 19:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719344776;
	bh=1ycjCg0/j3hmb5tsZ6Wa+p05u6moZZySGUMCKxo8Jwk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tEhSIAiTM54DiZ+5V4HxaV0h4l6Bm2invotfjU1uBgfevRZjD+PrIHTVQJmszi9W+
	 IKz2PPIPZmymqyiqyIUxjxXriL8hcAh5jB4X1bcZ3ugE4AjtY8zx07Wo5xlmhP35Yh
	 xbe2nrdMdfO/8HVtqMWf1Q/3m0qVDJa8YnL9Q/MKT9TtXHhQzsBXrZS16t6q+6r2Uv
	 sVEGIgJvXDcDFIfvjxQKWTMyLj6Lzp46L+z1I9flw3kb+SKtk9S0CDTSRTyBfopO/R
	 2W5rCDHmqoeNPi/OSj7ApTSWqHU0ggOnlC8kU/nXTf2n9AiRPBQUIc1caGkzK9dbs5
	 gRpu8F43bt/ZA==
Date: Tue, 25 Jun 2024 13:46:14 -0600
From: Rob Herring <robh@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	maz@kernel.org, anna-maria@linutronix.de, shawnguo@kernel.org,
	s.hauer@pengutronix.de, festevam@gmail.com, bhelgaas@google.com,
	rdunlap@infradead.org, vidyas@nvidia.com,
	ilpo.jarvinen@linux.intel.com, apatel@ventanamicro.com,
	kevin.tian@intel.com, nipun.gupta@amd.com, den@valinux.co.jp,
	andrew@lunn.ch, gregory.clement@bootlin.com,
	sebastian.hesselbarth@gmail.com, gregkh@linuxfoundation.org,
	rafael@kernel.org, alex.williamson@redhat.com, will@kernel.org,
	lorenzo.pieralisi@arm.com, jgg@mellanox.com,
	ammarfaizi2@gnuweeb.org, robin.murphy@arm.com,
	lpieralisi@kernel.org, nm@ti.com, kristo@kernel.org,
	vkoul@kernel.org, okaya@kernel.org, agross@kernel.org,
	andersson@kernel.org, mark.rutland@arm.com,
	shameerali.kolothum.thodi@huawei.com, yuzenghui@huawei.com,
	shivamurthy.shastri@linutronix.de
Subject: Re: [patch V4 00/21] genirq, irqchip: Convert ARM MSI handling to
 per device MSI domains
Message-ID: <20240625194614.GA4013374-robh@kernel.org>
References: <20240623142137.448898081@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240623142137.448898081@linutronix.de>

On Sun, Jun 23, 2024 at 05:18:31PM +0200, Thomas Gleixner wrote:
> This is version 4 of the series to convert ARM MSI handling over to
> per device MSI domains. Version 3 can be found here:
> 
>   https://lore.kernel.org/lkml/20240614102403.13610-1-shivamurthy.shastri@linutronix.de
> 
> The conversion aims to replace the existing platform MSI mechanism and
> enables ARM to support the future PCI/IMS mechanism.
> 
> The infrastructure to replace the platform MSI mechanism is already
> upstream and in use by RISC-V and has been tested on various ARM platforms
> during the V2 development.
> 
> Changes vs. V3:
> 
>     - Fix the conversion of the GIC V3 MBI driver - Marc
> 
>     - Dropped a few stray MSI_FLAG_PCI_MSI_MASK_PARENT flags
> 
>     - Dropped the trivial cleanup patches as they have been merged
> 
>     - Picked up tags
> 
> The series is only lightly tested due to lack of hardware, so we rely on
> the people who have access to affected machines to help with testing.
> 
> If there are no major objections raised or testing fallout reported, I'm
> aiming this series for the next merge window.
> 
> The series is also available from git:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git devmsi-arm-v4

Running this thru kernelCI has some failures on x86 QEMU boots[1]. 
Here's the backtrace:

<1>[    2.199948] BUG: kernel NULL pointer dereference, address: 0000000000000000
<1>[    2.199948] #PF: supervisor instruction fetch in kernel mode
<1>[    2.199948] #PF: error_code(0x0010) - not-present page
<6>[    2.199948] PGD 0 P4D 0 
<4>[    2.199948] Oops: Oops: 0010 [#1] PREEMPT SMP NOPTI
<4>[    2.199948] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.10.0-rc3 #1
<4>[    2.199948] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01/2014
<4>[    2.199948] RIP: 0010:0x0
<4>[    2.199948] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
<4>[    2.199948] RSP: 0018:ffffa7ac80013a90 EFLAGS: 00000002
<4>[    2.199948] RAX: 0000000000000000 RBX: ffffa4050333d600 RCX: 0000000000000000
<4>[    2.199948] RDX: ffffa4050333d430 RSI: 0000000000000001 RDI: ffffa40502ff3100
<4>[    2.199948] RBP: ffffa4050333d600 R08: ffffa405032f1c00 R09: 0000000000000000
<4>[    2.199948] R10: 0000000000000246 R11: ffffa405032f1d80 R12: ffffa405032f1d80
<4>[    2.199948] R13: 0000000000000001 R14: 0000000000000000 R15: ffffa4050333d760
<4>[    2.199948] FS:  0000000000000000(0000) GS:ffffa4053e400000(0000) knlGS:0000000000000000
<4>[    2.199948] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
<4>[    2.199948] CR2: ffffffffffffffd6 CR3: 000000002a22e000 CR4: 00000000000006f0
<4>[    2.199948] Call Trace:
<4>[    2.199948]  <TASK>
<4>[    2.199948]  ? __die+0x1f/0x70
<4>[    2.199948]  ? page_fault_oops+0x155/0x440
<4>[    2.199948]  ? ondemand_readahead+0x2c0/0x370
<4>[    2.199948]  ? bitmap_find_next_zero_area_off+0x7b/0x90
<4>[    2.199948]  ? exc_page_fault+0x69/0x150
<4>[    2.199948]  ? asm_exc_page_fault+0x26/0x30
<4>[    2.199948]  pci_irq_unmask_msix+0x53/0x60
<4>[    2.199948]  irq_enable+0x32/0x80
<4>[    2.199948]  __irq_startup+0x51/0x70
<4>[    2.199948]  irq_startup+0x62/0x120
<4>[    2.199948]  __setup_irq+0x326/0x730
<4>[    2.199948]  ? __pfx_vp_config_changed+0x10/0x10
<4>[    2.199948]  request_threaded_irq+0x10b/0x180
<4>[    2.199948]  vp_find_vqs_msix+0x16b/0x470
<4>[    2.199948]  vp_find_vqs+0x34/0x1a0
<4>[    2.199948]  vp_modern_find_vqs+0x16/0x60
<4>[    2.199948]  init_vqs+0x3ee/0x690
<4>[    2.199948]  virtnet_probe+0x50c/0xd10
<4>[    2.199948]  virtio_dev_probe+0x1dd/0x2b0
<4>[    2.199948]  really_probe+0xbc/0x2b0
<4>[    2.199948]  __driver_probe_device+0x6e/0x120
<4>[    2.199948]  driver_probe_device+0x19/0xe0
<4>[    2.199948]  __driver_attach+0x85/0x180
<4>[    2.199948]  ? __pfx___driver_attach+0x10/0x10
<4>[    2.199948]  bus_for_each_dev+0x76/0xd0
<4>[    2.199948]  bus_add_driver+0xe3/0x210
<4>[    2.199948]  driver_register+0x5b/0x110
<4>[    2.199948]  ? __pfx_virtio_net_driver_init+0x10/0x10
<4>[    2.199948]  virtio_net_driver_init+0x8b/0xb0
<4>[    2.199948]  ? __pfx_virtio_net_driver_init+0x10/0x10
<4>[    2.199948]  do_one_initcall+0x43/0x210
<4>[    2.199948]  kernel_init_freeable+0x19b/0x2d0
<4>[    2.199948]  ? __pfx_kernel_init+0x10/0x10
<4>[    2.199948]  kernel_init+0x15/0x1c0
<4>[    2.199948]  ret_from_fork+0x2f/0x50
<4>[    2.199948]  ? __pfx_kernel_init+0x10/0x10
<4>[    2.199948]  ret_from_fork_asm+0x1a/0x30
<4>[    2.199948]  </TASK>
<4>[    2.199948] Modules linked in:
<4>[    2.199948] CR2: 0000000000000000
<4>[    2.199948] ---[ end trace 0000000000000000 ]---


Rob

[1] https://linux.kernelci.org/test/job/robh/branch/for-kernelci/kernel/v6.10-rc3-21-gd27f9f4a2dd80/plan/baseline/

