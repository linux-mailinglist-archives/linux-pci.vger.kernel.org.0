Return-Path: <linux-pci+bounces-44851-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF32D2121D
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 21:10:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1C6D2300A52F
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 20:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B4D352FBD;
	Wed, 14 Jan 2026 20:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DSHzUkJA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28C8352C24
	for <linux-pci@vger.kernel.org>; Wed, 14 Jan 2026 20:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768421425; cv=none; b=DIgu1R+XH7lE2zQHFeJJcqi4bbI0MPm6FLuyjEnpJcVQfH34aH0VFwqU4qKtW9mhBxN6hGqDRb8RgEoiIeoJLyZB87D64EgHn4YGZRFjJLB+pbGh6zZKhcavRwIXVCBaVMRy+2O/6xOZJApIENHARaqBgyfyii6YuBLar6LcYhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768421425; c=relaxed/simple;
	bh=rqdSaDxJvIhD868na2QQi1x9fDimCPeEnrYFmEOGcHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VqAyPO2Sjr3qlvVrd9/FdPhJdLZtUVac+/uOOksTWo76DhWeDHhyZ/KUFuHt2EIcPx0E4e/M2ytTkTewPDgW/DMNxO8lAG+5E3aXF9fWSdMR1ubtcKnvd+lAHeG/zd4ANLtb65Re0okCIEZz04w3qHaW1+BJ14Ew1FgYAmzga9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DSHzUkJA; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2ad70765db9so395676eec.1
        for <linux-pci@vger.kernel.org>; Wed, 14 Jan 2026 12:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1768421423; x=1769026223; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=V1V5FWY2m8ktrGGsFfOltSsRWcRmuumQc8l2vYL2t90=;
        b=DSHzUkJAXSZv2Sf7ohkgGdi5aCuDLFMqEkIJhqDs8Em59mkeCit2Hjclbv90NMotds
         VACcYDyRsnw0jHapcagNZRJpUea/u0julLg/nOkmq8sK4AaGKPJyEAaCzAze2RIOEHAJ
         hvvOH32Z7ogpyG04BJcMFEmQvVqGuE6NtCxMI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768421423; x=1769026223;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V1V5FWY2m8ktrGGsFfOltSsRWcRmuumQc8l2vYL2t90=;
        b=RpDwhIvT3xUJbcB0aLnb5ltGRkYPXyab+AhM9K7JjEzc0sSwCPWE/l15F+ECR10kpe
         urLgmHH2GfO/qOykImYr45RjYZHLGvTMBKqkwO5WXuXelRNO0HaXdWdBKtwzOCxcchvB
         ztpvlP7pewoXeVQU5/e9OugpVWhI7AZkuW4DfAtxsbOiMic4qWiv8ctzBLcWWFDAei8J
         tN07KxGCNU1pwwYdz3TiHHnpvNt4xtfodtu30qbrxHtiT8228l4zoDAYZf6N9Y+4IZ2O
         CKFdFUXUjb6ez65vIowzcGSUyDIAGpQAs1GpIz1LtWmGQM0cDR1I6dcdHPnbYzmTf4KU
         FlEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUW0zIsCvXRiAcSBiurhtK0MaHg15OBcuY+tv8A7zVVDpzwvH6sqpN6ogj+jG6IsnXmcarQpxm2+Pg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDhK9iqwNT8geKbyKd1sgYZcyqgjrcwTc0DVj69TpIvZQ6ipq1
	vYohV3EaiILs5tyiurXW2wP1hO++XsTXua4x/St0l/MffiDOiWi22we4pHXKqxJWNw==
X-Gm-Gg: AY/fxX5uZBnpQ230mPIPmTx6lSTcxq8VCZcf8hfvLc19CdK+wXSdtVVMbwTXYW15jrI
	FgtHh5TnrH9Hw1rItClbpysR0AOFIqlHqOsl3AdyF8y3npwm1ltetqdVlHVvaOQb3ukpy63YpZF
	gAXYVpy77845OgxYahHlQTxWaZ3vxqS1KsfAUo3ZSy5rKyx2h28MZ36gHXv2VUO1L32uHbb8UXS
	MGvjqXOWMCQQ7Nxl67QN83JU4lEYINu5NnGhu7ZC4b92fkUtWLUba0sCBx3fxDt0/OnawtQhtnL
	QSkeVBlDpbPkMmwQTDMyj4lmN+NldaDoTTnN8NI+l4rdZVtrTYKQC4UTskd3IYmlDQEAmc/Q7fW
	o3z7HcRqG3mcPqRbq9lp4wM/7kYoQ4tItvzjNANKw1nmxne91l++yzldrh2qT4a9uNQlzbGJP7r
	ObrUeylDLRxcnHC+axoU4oViopfSo/h0BHM6g/o5Suz5y6Fh1GUA==
X-Received: by 2002:a05:7301:1901:b0:2b0:4902:c0a3 with SMTP id 5a478bee46e88-2b4870bcd18mr4343716eec.20.1768421422436;
        Wed, 14 Jan 2026 12:10:22 -0800 (PST)
Received: from localhost ([2a00:79e0:2e7c:8:ae4d:1d26:39a5:d7ab])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-2b170673266sm21009848eec.1.2026.01.14.12.10.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jan 2026 12:10:21 -0800 (PST)
Date: Wed, 14 Jan 2026 12:10:19 -0800
From: Brian Norris <briannorris@chromium.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Lukas Wunner <lukas@wunner.de>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH v4] PCI/PM: Prevent runtime suspend before devices are
 fully initialized
Message-ID: <aWf4KyTSIocWTmXw@google.com>
References: <20260106222715.GA381397@bhelgaas>
 <CGME20260114094643eucas1p1a2fdc6c35dd27741c18831b34bbed0c8@eucas1p1.samsung.com>
 <0e35a4e1-894a-47c1-9528-fc5ffbafd9e2@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0e35a4e1-894a-47c1-9528-fc5ffbafd9e2@samsung.com>

Hi Marek,

On Wed, Jan 14, 2026 at 10:46:41AM +0100, Marek Szyprowski wrote:
> On 06.01.2026 23:27, Bjorn Helgaas wrote:
> > On Thu, Oct 23, 2025 at 02:09:01PM -0700, Brian Norris wrote:
> >> Today, it's possible for a PCI device to be created and
> >> runtime-suspended before it is fully initialized. When that happens, the
> >> device will remain in D0, but the suspend process may save an
> >> intermediate version of that device's state -- for example, without
> >> appropriate BAR configuration. When the device later resumes, we'll
> >> restore invalid PCI state and the device may not function.
> >>
> >> Prevent runtime suspend for PCI devices by deferring pm_runtime_enable()
> >> until we've fully initialized the device.
...

> This patch landed recently in linux-next as commit c796513dc54e 
> ("PCI/PM: Prevent runtime suspend until devices are fully initialized"). 
> In my tests I found that it sometimes causes the "pci 0000:01:00.0: 
> runtime PM trying to activate child device 0000:01:00.0 but parent 
> (0000:00:00.0) is not active" warning on Qualcomm Robotics RB5 board 
> (arch/arm64/boot/dts/qcom/qrb5165-rb5.dts). This in turn causes a 
> lockdep warning about console lock, but this is just a consequence of 
> the runtime pm warning. Reverting $subject patch on top of current 
> linux-next hides this warning.
> 
> Here is a kernel log:
> 
> pci 0000:01:00.0: [17cb:1101] type 00 class 0xff0000 PCIe Endpoint
> pci 0000:01:00.0: BAR 0 [mem 0x00000000-0x000fffff 64bit]
> pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
> pci 0000:01:00.0: 4.000 Gb/s available PCIe bandwidth, limited by 5.0 
> GT/s PCIe x1 link at 0000:00:00.0 (capable of 7.876 Gb/s with 8.0 GT/s 
> PCIe x1 link)
> pci 0000:01:00.0: Adding to iommu group 13
> pci 0000:01:00.0: ASPM: default states L0s L1
> pcieport 0000:00:00.0: bridge window [mem 0x60400000-0x604fffff]: assigned
> pci 0000:01:00.0: BAR 0 [mem 0x60400000-0x604fffff 64bit]: assigned
> pci 0000:01:00.0: runtime PM trying to activate child device 
> 0000:01:00.0 but parent (0000:00:00.0) is not active

Thanks for the report. I'll try to look at reproducing this, or at least
getting a better mental model of exactly why this might fail (or,
"warn") this way. But if you have the time and desire to try things out
for me, can you give v1 a try?

https://lore.kernel.org/all/20251016155335.1.I60a53c170a8596661883bd2b4ef475155c7aa72b@changeid/

I'm pretty sure it would not invoke the same problem. I also suspect v3
might not, but I'm less sure:

https://lore.kernel.org/all/20251022141434.v3.1.I60a53c170a8596661883bd2b4ef475155c7aa72b@changeid/

> ======================================================
> WARNING: possible circular locking dependency detected
> 6.19.0-rc1+ #16398 Not tainted
> ------------------------------------------------------
> kworker/3:0/33 is trying to acquire lock:
> ffffcd182ff1ae98 (console_owner){..-.}-{0:0}, at: 
> console_lock_spinning_enable+0x44/0x78
> 
> but task is already holding lock:
> ffff0000835c5238 (&dev->power.lock/1){....}-{3:3}, at: 
> __pm_runtime_set_status+0x240/0x384
> 
> which lock already depends on the new lock.

The lockdep warning is a bit messier, and I'd also have to take some
more time to be sure, but in principle, this sounds like a totally
orthogonal problem. It seems like simply performing printk() to a qcom
UART in the "wrong" context is enough to cause this. If so, that's
definitely a console/UART bug (or maybe a lockdep false positive) and
not a PCI/runtime-PM bug.

> the existing dependency chain (in reverse order) is:
> 
> -> #3 (&dev->power.lock/1){....}-{3:3}:
>         _raw_spin_lock_nested+0x44/0x5c
>         __pm_runtime_set_status+0x240/0x384
>         arm_smmu_device_probe+0xbe0/0xe5c
>         platform_probe+0x5c/0xac
>         really_probe+0xbc/0x298
>         __driver_probe_device+0x78/0x12c
>         driver_probe_device+0x40/0x164
>         __driver_attach+0x9c/0x1ac
>         bus_for_each_dev+0x74/0xd0
>         driver_attach+0x24/0x30
>         bus_add_driver+0xe4/0x208
>         driver_register+0x60/0x128
>         __platform_driver_register+0x24/0x30
>         arm_smmu_driver_init+0x20/0x2c
>         do_one_initcall+0x64/0x308
>         kernel_init_freeable+0x284/0x500
>         kernel_init+0x20/0x1d8
>         ret_from_fork+0x10/0x20
> 
> -> #2 (&dev->power.lock){-...}-{3:3}:
>         _raw_spin_lock_irqsave+0x60/0x88
>         __pm_runtime_resume+0x4c/0xbc
>         __uart_start+0x4c/0x114
>         uart_write+0x98/0x278
>         n_tty_write+0x1dc/0x4f0
>         file_tty_write.constprop.0+0x12c/0x2bc
>         redirected_tty_write+0xc0/0x108
>         do_iter_readv_writev+0xdc/0x1c0
>         vfs_writev+0xf0/0x280
>         do_writev+0x74/0x13c
>         __arm64_sys_writev+0x20/0x2c
>         invoke_syscall+0x48/0x10c
>         el0_svc_common.constprop.0+0x40/0xe8
>         do_el0_svc+0x20/0x2c
>         el0_svc+0x50/0x2e8
>         el0t_64_sync_handler+0xa0/0xe4
>         el0t_64_sync+0x198/0x19c
> 
> -> #1 (&port_lock_key){-.-.}-{3:3}:
>         _raw_spin_lock_irqsave+0x60/0x88
>         qcom_geni_serial_console_write+0x50/0x344
>         console_flush_one_record+0x33c/0x474
>         console_unlock+0x80/0x14c
>         vprintk_emit+0x258/0x3d0
>         vprintk_default+0x38/0x44
>         vprintk+0x28/0x34
>         _printk+0x5c/0x84
>         register_console+0x278/0x510
>         serial_core_register_port+0x6cc/0x79c
>         serial_ctrl_register_port+0x10/0x1c
>         uart_add_one_port+0x10/0x1c
>         qcom_geni_serial_probe+0x2c0/0x448
>         platform_probe+0x5c/0xac
>         really_probe+0xbc/0x298
>         __driver_probe_device+0x78/0x12c
>         driver_probe_device+0x40/0x164
>         __device_attach_driver+0xb8/0x138
>         bus_for_each_drv+0x80/0xdc
>         __device_attach+0xa8/0x1b0
>         device_initial_probe+0x50/0x54
>         bus_probe_device+0x38/0xa8
>         device_add+0x540/0x720
>         of_device_add+0x44/0x60
>         of_platform_device_create_pdata+0x90/0x11c
>         of_platform_bus_create+0x17c/0x394
>         of_platform_populate+0x58/0xf8
>         devm_of_platform_populate+0x58/0xbc
>         geni_se_probe+0xdc/0x164
>         platform_probe+0x5c/0xac
>         really_probe+0xbc/0x298
>         __driver_probe_device+0x78/0x12c
>         driver_probe_device+0x40/0x164
>         __device_attach_driver+0xb8/0x138
>         bus_for_each_drv+0x80/0xdc
>         __device_attach+0xa8/0x1b0
>         device_initial_probe+0x50/0x54
>         bus_probe_device+0x38/0xa8
>         deferred_probe_work_func+0x8c/0xc8
>         process_one_work+0x208/0x604
>         worker_thread+0x244/0x388
>         kthread+0x150/0x228
>         ret_from_fork+0x10/0x20
> 
> -> #0 (console_owner){..-.}-{0:0}:
>         __lock_acquire+0x1408/0x2254
>         lock_acquire+0x1c8/0x354
>         console_lock_spinning_enable+0x68/0x78
>         console_flush_one_record+0x300/0x474
>         console_unlock+0x80/0x14c
>         vprintk_emit+0x258/0x3d0
>         dev_vprintk_emit+0xd8/0x1a0
>         dev_printk_emit+0x58/0x80
>         __dev_printk+0x3c/0x88
>         _dev_err+0x60/0x88
>         __pm_runtime_set_status+0x28c/0x384
>         pci_bus_add_device+0xa4/0x18c
>         pci_bus_add_devices+0x3c/0x88
>         pci_bus_add_devices+0x68/0x88
>         pci_rescan_bus+0x30/0x44
>         rescan_work_func+0x28/0x3c
>         process_one_work+0x208/0x604
>         worker_thread+0x244/0x388
>         kthread+0x150/0x228
>         ret_from_fork+0x10/0x20
> 
> other info that might help us debug this:
> 
> Chain exists of:
>    console_owner --> &dev->power.lock --> &dev->power.lock/1
> 
>   Possible unsafe locking scenario:
> 
>         CPU0                    CPU1
>         ----                    ----
>    lock(&dev->power.lock/1);
>                                 lock(&dev->power.lock);
> lock(&dev->power.lock/1);
>    lock(console_owner);
> 
>   *** DEADLOCK ***
> 
> 7 locks held by kworker/3:0/33:
>   #0: ffff00008000d948 ((wq_completion)events){+.+.}-{0:0}, at: 
> process_one_work+0x18c/0x604
>   #1: ffff8000802a3de0 ((work_completion)(&pwrctrl->work)){+.+.}-{0:0}, 
> at: process_one_work+0x1b4/0x604
>   #2: ffffcd18301138e8 (pci_rescan_remove_lock){+.+.}-{4:4}, at: 
> pci_lock_rescan_remove+0x1c/0x28
>   #3: ffff00008ac8a238 (&dev->power.lock){-...}-{3:3}, at: 
> __pm_runtime_set_status+0x1d4/0x384
>   #4: ffff0000835c5238 (&dev->power.lock/1){....}-{3:3}, at: 
> __pm_runtime_set_status+0x240/0x384
>   #5: ffffcd182ff1ac78 (console_lock){+.+.}-{0:0}, at: 
> dev_vprintk_emit+0xd8/0x1a0
>   #6: ffffcd182ff1acd8 (console_srcu){....}-{0:0}, at: 
> console_flush_one_record+0x0/0x474
> 
> stack backtrace:
> CPU: 3 UID: 0 PID: 33 Comm: kworker/3:0 Not tainted 6.19.0-rc1+ #16398 
> PREEMPT
> Hardware name: Qualcomm Technologies, Inc. Robotics RB5 (DT)
> Workqueue: events rescan_work_func
> Call trace:
>   show_stack+0x18/0x24 (C)
>   dump_stack_lvl+0x90/0xd0
>   dump_stack+0x18/0x24
>   print_circular_bug+0x298/0x37c
>   check_noncircular+0x15c/0x170
>   __lock_acquire+0x1408/0x2254
>   lock_acquire+0x1c8/0x354
>   console_lock_spinning_enable+0x68/0x78
>   console_flush_one_record+0x300/0x474
>   console_unlock+0x80/0x14c
>   vprintk_emit+0x258/0x3d0
>   dev_vprintk_emit+0xd8/0x1a0
>   dev_printk_emit+0x58/0x80
>   __dev_printk+0x3c/0x88
>   _dev_err+0x60/0x88
>   __pm_runtime_set_status+0x28c/0x384
>   pci_bus_add_device+0xa4/0x18c
>   pci_bus_add_devices+0x3c/0x88
>   pci_bus_add_devices+0x68/0x88
>   pci_rescan_bus+0x30/0x44
>   rescan_work_func+0x28/0x3c
>   process_one_work+0x208/0x604
>   worker_thread+0x244/0x388
>   kthread+0x150/0x228
>   ret_from_fork+0x10/0x20
> 
> This looks a bit similar to the issue reported some time ago on a 
> different board:
> 
> https://lore.kernel.org/all/6d438995-4d6d-4a21-9ad2-8a0352482d44@samsung.com/

Huh, yeah, the lockdep warning is rather similar looking. So that bug
(whether real or false positive) may have been around a while.

And the "Enabling runtime PM for inactive device with active children"
log is similar, but it involves a different set of devices -- now we're
dealing with the PCIe port and child device, whereas that report was
about the host bridge/controller device.

Brian

> Let me know if I can somehow help debugging this.
> 
> Best regards
> -- 
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
> 

