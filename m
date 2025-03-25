Return-Path: <linux-pci+bounces-24670-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61328A70323
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 15:05:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4B7316C627
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 13:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A532586C5;
	Tue, 25 Mar 2025 13:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cs2tLvqF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0BA2586C4
	for <linux-pci@vger.kernel.org>; Tue, 25 Mar 2025 13:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742910999; cv=none; b=E/VZoq0fExPCBSOOL8K3dFGg+1MnH3Hq55fmYWqRvs0ufn/FscsEXTB6xd42i2lEukoVp0f8y0Bd4D3KH8jWgwJDMy+5ujkZUXju+W3IJet/KSN3sq3n2WHeHNKKMNn9GKE+f3OQHklny0JyHQ1jLE+VMoseA4/ycWPbd2PDBuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742910999; c=relaxed/simple;
	bh=fM18Y2UDoYBSYtZGWqXQbd5up5uRuayQ7l/F3XctdF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XbNk4N8s7Jz8wTcgGgCLOfUOJ48WdUNlI8Hidil4r3GQUCO73Pe5rztgAjGfzpudJtTa/Y5VpGmzoSvhYfoy10JisQKXZwbvFACSzJIJjENKekmNBxZwxgmgtCTl40kWoNhndCuahqX7ytUzD34y2m4WhNG5cX9KrkWOyEiwZjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Cs2tLvqF; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43cfdc2c8c9so34160495e9.2
        for <linux-pci@vger.kernel.org>; Tue, 25 Mar 2025 06:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742910996; x=1743515796; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TCDJmpGf3Eg15VbX5Sp8vwTJcSjhepylteCEjoFRn4k=;
        b=Cs2tLvqFGCjYeGVnhMtq+SuRQfuM1RjfAJWyJPtPhNwKdeY/xcxJTlgW5o6XPfv218
         JI/tmt/vUnvuzF7Qoib/9zs/wJBHjoJoWzvooFEu8yfJNzDlYxSEA/xKpAETbbHi4cH9
         erpns84yCRJsd3+EJBeOh1V5Q6mrOhwd94WS1GH8KghOUCjd1L5PkV1NPn1Lxkx3WlwZ
         YtSUg5lS54JqZbnSQ1IMi11Jh740bVpC9FNcvSyWMQJvhKY/bLCK0ERnN567AbICykuq
         1tUS4TC9cm/talnY+gDkqUw2hfpf7OtFlWNTxdU0pSvS8Yy920nOwUBu9IRmu0l0cB/k
         A9Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742910996; x=1743515796;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TCDJmpGf3Eg15VbX5Sp8vwTJcSjhepylteCEjoFRn4k=;
        b=SpXmr6ghbJ3B8w3lVtpo6O44Ve/GrCdX8kfxgtmQXL0x0O12tyi6DkEISCZ7S/Evl0
         bfrotuJQFXOSFn29w44VGJXniylTL2RK9L+PMUb/frOIMAtldQWqrIy85ldaFZ8mlDsE
         LJ6Ok9jZS+ASVLQF6XeNBTN1By3WpRdVibBCyn1p7Z9vRNjLdMs7T4SF37SzxAE94qoA
         vpxPSpvSzfTIh7r3qAVJMRPE7p65hw7XLTKnxShVTQFePiMCiyLHvU0ELqZiSaXwO6Jq
         bwENbeorhPR5wd9yF5YcFC+ytl3jR9/NbgDOeKuJQgRNRt3RY9ircj403Qxz7waIvtS+
         9FwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwfIqXQI88B8BHK/B5R7RbyHKVwe0sS6jRgfVslp2i2Yg/fvYB8Am1of0g/DWdjYQ+wFFPx3R0k5I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsjCZKSwKUeLkJw0QPUP7HC/mXw2xOcYddxbdVuXbq+TEwWVxp
	xkspMEjPcki0SqmjDDZ4guRd2Luez6aeSgN6Rh90G+D/tijodRUNov9QMPj+DRM=
X-Gm-Gg: ASbGncudtLtscFlTFX0GRRlxiQuD7htVkSe3yEref88cxtfxMV/klnR9iaTFYzlcbzO
	ftshKFNF5oGcd2FIaWM8GnBoQQM22oBqB7p/WjChGbebTn1sQIqM2FwEPk3QxboegI9rMyzCetw
	XDL3QpwI96nd/GoYOVTJjNH7ktM1a8DbahavLE3lCtNFk+G8Ibh2IdHKS8P0v+uBJYg5kvd6Ysh
	1Cf7zpJrGZT0bVteGdtEizvH4W4kJNQfL+M/N+B93ECH93QEz050dz9zylez1DrF9YH3q2KzTdQ
	R0bXkLolHKRZibzrBFD8tN00AdDRsXLTWB4XIMdBuEUkgaQVwg==
X-Google-Smtp-Source: AGHT+IEXygql+ba4dLAEprcqbbBUZm9vu5V/1aZTrj16kuq0a0ccf1f7yorovN1W6gxa7/NXqYYLjQ==
X-Received: by 2002:a5d:6da1:0:b0:391:10c5:d1c6 with SMTP id ffacd0b85a97d-3997f8ed9c9mr14586179f8f.2.1742910995979;
        Tue, 25 Mar 2025 06:56:35 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43d440ed4d9sm203483275e9.33.2025.03.25.06.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 06:56:35 -0700 (PDT)
Date: Tue, 25 Mar 2025 16:56:33 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Roger Pau Monne <roger.pau@citrix.com>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>,
	PCI <linux-pci@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	lkft-triage@lists.linaro.org,
	Linux Regressions <regressions@lists.linux.dev>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	shivamurthy.shastri@linutronix.de,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Anders Roxell <anders.roxell@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: next-20250324: x86_64: BUG: kernel NULL pointer dereference
 __pci_enable_msi_range
Message-ID: <b6df035d-74b5-4113-84c3-1a0a18a61e78@stanley.mountain>
References: <CA+G9fYs4-4y=edxddERXQ_fMsW_nUJU+V0bSMHFDL3St7NiLxQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYs4-4y=edxddERXQ_fMsW_nUJU+V0bSMHFDL3St7NiLxQ@mail.gmail.com>

If I had to guess, I'd say that it was related to Fixes: d9f2164238d8
("PCI/MSI: Convert pci_msi_ignore_mask to per MSI domain flag").  I
suspect d->host_data can be NULL.  I could be wrong, but let's add Roger
to the CC list just in case.

regards,
dan carpenter

On Tue, Mar 25, 2025 at 05:11:20PM +0530, Naresh Kamboju wrote:
> Regressions on x86_64 boot failed with Linux next-20250324 tag kernel
> 6.14.0-rc7-next-20250324
> 
> First seen on the next-20250324
>  Good: next-20250321
>  Bad:  next-20250324 ..next-20250325
> 
> Regressions found on x86_84:
>  - boot
> 
> Regression Analysis:
>  - New regression? Yes
>  - Reproducible? Yes
> 
> Boot regression: x86 boot fail kernel panic __pci_enable_msi_range
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> ## Boot log
> <1>[    1.525485] BUG: kernel NULL pointer dereference, address:
> 0000000000000002
> <1>[    1.525573] #PF: supervisor read access in kernel mode
> <1>[    1.525573] #PF: error_code(0x0000) - not-present page
> <6>[    1.525573] PGD 0 P4D 0
> <4>[    1.525573] Oops: Oops: 0000 [#1] SMP PTI
> <4>[    1.525573] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted
> 6.14.0-rc7-next-20250324 #1 PREEMPT(voluntary)
> <4>[    1.525573] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
> BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> <4>[    1.525573] RIP: 0010:__pci_enable_msi_range+0x306/0x6b0
> <4>[    1.525573] Code: ff ff ff e8 1c 05 fe ff f6 83 21 08 00 00 10
> 0f b7 85 6e ff ff ff 74 0c 0d 00 01 00 00 66 89 85 6e ff ff ff 8b 8d
> 68 ff ff ff <41> f6 44 24 02 40 74 0c 25 ff fe 00 00 66 89 85 6e ff ff
> ff 89 8d
> <4>[    1.525573] RSP: 0000:ffffa83b00013740 EFLAGS: 00010246
> <4>[    1.525573] RAX: 0000000000000080 RBX: ffffa11c8023e000 RCX:
> 0000000000000001
> <4>[    1.525573] RDX: 0000000000000000 RSI: ffffffff9e60c683 RDI:
> ffffffff9e6519a8
> <4>[    1.525573] RBP: ffffa83b00013810 R08: 0000000000000002 R09:
> ffffa83b0001370c
> <4>[    1.525573] R10: 0000000000000001 R11: ffffffff9e60c5b0 R12:
> 0000000000000000
> <4>[    1.525573] R13: 0000000000000000 R14: 0000000000000001 R15:
> ffffa11c8023e000
> <4>[    1.525573] FS:  0000000000000000(0000)
> GS:ffffa11d5c339000(0000) knlGS:0000000000000000
> <4>[    1.525573] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> <4>[    1.525573] CR2: 0000000000000002 CR3: 000000007d844000 CR4:
> 00000000000006f0
> <4>[    1.525573] Call Trace:
> <4>[    1.525573]  <TASK>
> <4>[    1.525573]  ? __die_body+0xb4/0xc0
> <4>[    1.525573]  ? __die+0x2e/0x40
> <4>[    1.525573]  ? page_fault_oops+0x3ae/0x410
> <4>[    1.525573]  ? kernelmode_fixup_or_oops+0x54/0x70
> <4>[    1.525573]  ? __bad_area_nosemaphore+0x52/0x240
> <4>[    1.525573]  ? bad_area_nosemaphore+0x16/0x20
> <4>[    1.525573]  ? do_user_addr_fault+0x738/0x7a0
> <4>[    1.525573]  ? irqentry_enter+0x2d/0x50
> <4>[    1.525573]  ? exc_page_fault+0x4d/0x120
> <4>[    1.525573]  ? exc_page_fault+0x70/0x120
> <4>[    1.525573]  ? asm_exc_page_fault+0x2b/0x30
> <4>[    1.525573]  ? __pfx_pci_conf1_read+0x10/0x10
> <4>[    1.525573]  ? pci_conf1_read+0xd3/0xf0
> <4>[    1.525573]  ? _raw_spin_unlock_irqrestore+0x28/0x50
> <4>[    1.525573]  ? __pci_enable_msi_range+0x306/0x6b0
> <4>[    1.525573]  ? _raw_spin_unlock_irqrestore+0x28/0x50
> <4>[    1.525573]  pci_alloc_irq_vectors_affinity+0xbf/0x140
> <4>[    1.525573]  pci_alloc_irq_vectors+0x15/0x20
> <4>[    1.525573]  ahci_init_irq+0x90/0xc0
> <4>[    1.525573]  ahci_init_one+0x82c/0xd10
> <4>[    1.525573]  pci_device_probe+0x198/0x230
> <4>[    1.525573]  really_probe+0x146/0x450
> <4>[    1.525573]  __driver_probe_device+0x7a/0xf0
> <4>[    1.525573]  driver_probe_device+0x24/0x190
> <4>[    1.525573]  __driver_attach+0x104/0x250
> <4>[    1.525573]  ? __pfx___driver_attach+0x10/0x10
> <4>[    1.525573]  bus_for_each_dev+0x10e/0x160
> <4>[    1.525573]  driver_attach+0x22/0x30
> <4>[    1.525573]  bus_add_driver+0x175/0x2c0
> <4>[    1.525573]  driver_register+0x65/0xf0
> <4>[    1.525573]  ? __pfx_ahci_pci_driver_init+0x10/0x10
> <4>[    1.525573]  __pci_register_driver+0x68/0x70
> <4>[    1.525573]  ahci_pci_driver_init+0x22/0x30
> <4>[    1.525573]  do_one_initcall+0x121/0x330
> <4>[    1.525573]  ? alloc_pages_mpol+0x170/0x1c0
> <4>[    1.525573]  ? alloc_pages_mpol+0x170/0x1c0
> <4>[    1.525573]  ? trace_preempt_on+0x12/0x80
> <4>[    1.525573]  ? alloc_pages_mpol+0x170/0x1c0
> <4>[    1.525573]  ? preempt_count_sub+0x63/0x80
> <4>[    1.525573]  ? alloc_pages_mpol+0x170/0x1c0
> <4>[    1.525573]  ? trace_hardirqs_on+0x29/0xa0
> <4>[    1.525573]  ? irqentry_exit+0x57/0x60
> <4>[    1.525573]  ? sysvec_apic_timer_interrupt+0x52/0x90
> <4>[    1.525573]  ? next_arg+0xcd/0x150
> <4>[    1.525573]  ? next_arg+0x138/0x150
> <4>[    1.525573]  ? parse_args+0x16e/0x440
> <4>[    1.525573]  do_initcall_level+0x80/0xf0
> <4>[    1.525573]  do_initcalls+0x48/0x80
> <4>[    1.525573]  do_basic_setup+0x1d/0x30
> <4>[    1.525573]  kernel_init_freeable+0x10c/0x180
> <4>[    1.525573]  ? __pfx_kernel_init+0x10/0x10
> <4>[    1.525573]  kernel_init+0x1e/0x130
> <4>[    1.525573]  ret_from_fork+0x45/0x50
> <4>[    1.525573]  ? __pfx_kernel_init+0x10/0x10
> <4>[    1.525573]  ret_from_fork_asm+0x1a/0x30
> <4>[    1.525573]  </TASK>
> <4>[    1.525573] Modules linked in:
> <4>[    1.525573] CR2: 0000000000000002
> <4>[    1.525573] ---[ end trace 0000000000000000 ]---
> <4>[    1.525573] RIP: 0010:__pci_enable_msi_range+0x306/0x6b0
> <4>[    1.525573] Code: ff ff ff e8 1c 05 fe ff f6 83 21 08 00 00 10
> 0f b7 85 6e ff ff ff 74 0c 0d 00 01 00 00 66 89 85 6e ff ff ff 8b 8d
> 68 ff ff ff <41> f6 44 24 02 40 74 0c 25 ff fe 00 00 66 89 85 6e ff ff
> ff 89 8d
> <4>[    1.525573] RSP: 0000:ffffa83b00013740 EFLAGS: 00010246
> <4>[    1.525573] RAX: 0000000000000080 RBX: ffffa11c8023e000 RCX:
> 0000000000000001
> <4>[    1.525573] RDX: 0000000000000000 RSI: ffffffff9e60c683 RDI:
> ffffffff9e6519a8
> <4>[    1.525573] RBP: ffffa83b00013810 R08: 0000000000000002 R09:
> ffffa83b0001370c
> <4>[    1.525573] R10: 0000000000000001 R11: ffffffff9e60c5b0 R12:
> 0000000000000000
> <4>[    1.525573] R13: 0000000000000000 R14: 0000000000000001 R15:
> ffffa11c8023e000
> <4>[    1.525573] FS:  0000000000000000(0000)
> GS:ffffa11d5c339000(0000) knlGS:0000000000000000
> <4>[    1.525573] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> <4>[    1.525573] CR2: 0000000000000002 CR3: 000000007d844000 CR4:
> 00000000000006f0
> <6>[    1.525573] note: swapper/0[1] exited with irqs disabled
> <0>[    1.553459] Kernel panic - not syncing: Attempted to kill init!
> exitcode=0x00000009
> <0>[    1.553844] Kernel Offset: 0x1c000000 from 0xffffffff81000000
> (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> <0>[    1.553844] ---[ end Kernel panic - not syncing: Attempted to
> kill init! exitcode=0x00000009 ]---
> 
> 
> ## Source
> * Kernel version: 6.14.0-rc7-next-20250324
> * Git tree: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> * Git sha: 882a18c2c14fc79adb30fe57a9758283aa20efaa
> * Git describe: next-20250324
> * Project details:
> https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250324/
> 
> ## Test
> * Test log: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250324/testrun/27735988/suite/boot/test/clang-20-lkftconfig/log
> * Test history:
> https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250324/testrun/27735988/suite/boot/test/clang-20-lkftconfig/history/
> * Test details:
> https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250324/testrun/27735936/suite/boot/test/clang-20-lkftconfig/
> * Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/2ulLSNJUAxmyv6UZdUMeoptIZNn/
> * Kernel config:
> https://storage.tuxsuite.com/public/linaro/lkft/builds/2ulLSNJUAxmyv6UZdUMeoptIZNn/config
> 
> 
> --
> Linaro LKFT
> https://lkft.linaro.org

