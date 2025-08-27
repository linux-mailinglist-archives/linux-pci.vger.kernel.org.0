Return-Path: <linux-pci+bounces-34902-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F0AB37F21
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 11:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED3221BA0460
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 09:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A44219302;
	Wed, 27 Aug 2025 09:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jSxjNK2v"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0AB8F48;
	Wed, 27 Aug 2025 09:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756287931; cv=none; b=ah5AbQAfohCEmv+Tw51rsjrrpxDQ2YZu0XRHdZimZv7HwIhYkuA8cwu9S8z26498ICDfvk3B/tHE22/gg16Cz/R+iZB8SCq/PrgsYcnsJp/YfdVHFY8YIVAlDGumulyjhuW8YHVfp/kAJ81URK7iIRDKY4Dl6TI2TF/dfUaIV50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756287931; c=relaxed/simple;
	bh=R6h0C8QF6kFJPhSbdoTT06TREMj72FGcByDJ7m35uj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SZ+nq/6A8hRrSGnq3dBADPWywWnaq8ewSySpXxqp83f6E3IZYO0b1ay1pyXl4o2qRRZy4ecgUQAO1BcuB8xPCiGhDiCnXHQZnquQxKee1z7wqk9MBuGYnyZdAurvK23vr8zpuI161eHGN2chy72FPILAcAxoRQzkHT70oivVfzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jSxjNK2v; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-32326789e06so5301584a91.1;
        Wed, 27 Aug 2025 02:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756287929; x=1756892729; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q8ciAYaijUW2dV5+W66fBDEosTSZxoFX6wI5Kkuevz8=;
        b=jSxjNK2vgCqqVoWKIcccdtmKC0hUoexubG/1hl4nLaI8rnSvPTY4lIgLiogP0SVRSx
         uAU/JZe4x6HgyI2zLuyChp2KIxBUKjXQPp5dVnZ37Ddedjf/pgDk+Wa9kWc3pL8QF1ZK
         rOBocPzxRilXwQudRccHwXvBIA4aSVdlBXv/VxiHRdL3prflRurW40oXKQqEetWjJQbk
         TmwXcgQ9FER0NrfOHRCz0yIGOKHBJcZHdqUJm9dmQZy0xZoDWFJe/B0rTwVY+o4V1qd2
         4rkmNbcYC9nf0v0mE8hnwAbvgMyUG3DeYyUCnPiOD0g8O6ixUhGm+Rq07MHav5Mllt+D
         x9Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756287929; x=1756892729;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q8ciAYaijUW2dV5+W66fBDEosTSZxoFX6wI5Kkuevz8=;
        b=RHTC8BaQWMQWHJnepHzYu+MkZesjvYgvozn5XrIXQktGRcd8aUoVVtARNcoWdMUnWg
         GGPeEz3BIjEGPkoahxzaP+jisYZTKSvzdbrMRyrdy0RN9yWutu6xqvlp7K/SdSPq5P5e
         5+CXGiCAaOnyDdo5crMYarEYAZuDXhL1YMEggsA+IBtibXME8v1k70TyngKT4zeO5LBW
         wq/vBv3/2/WD+KC/D2y/P0NwpRNcFNKysEQFbmnCtvITKKv8aczmfNr8pM+9+kUkZwfa
         uXDlhdc+C03vBxJ9X8R3XzEPWRiAxORF+zhVEZ2XT4yidByjKT2s941ebiPeVZt9ipIL
         +CUA==
X-Forwarded-Encrypted: i=1; AJvYcCVpBqaEFvCADh0QUuXyd5JAoLmGAVioJzgQk6Odskkb6/gV3DDxTWtZoU5mstpzb+6w5ep2T5EhTTgJAQ==@vger.kernel.org, AJvYcCWuOEx5T4kHa3PG6cHf0roph805SQT5mdcpDqOc9rHXRUhOE/zM+3RboBHQBT198e8r8lBUuxyWpMmr@vger.kernel.org, AJvYcCXtR4gW+6G1KftP1AnfoL62uNYhErjs8P6jYu5ntAtZTUTdTfeK9u9+piiZcKYrtTFXdyyEaEIUhKnC5pc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr9pdEhuHpuTxd/jZgPc9yqma67CCtRTKxRPrE/IHllkm/gWsA
	WQusTQK+6Q97rVLqT80YcBZH/REYOBE66XsyYmWENknMZ9RiQYB9RJfH
X-Gm-Gg: ASbGncsBQI7DPkJhqPr2mEddZC+LeMTpH88iHGA+7n2Szr2sW2H7lGfWtYzkRkBawBC
	bhc7En/22zgFOo9IpOQy2+aVM6bpDwcNWSQEViyS8R5u1bTGMsaILmbL9irlVFR5OUG/1HJoqFc
	s3/g7OG9+Bj8C478LFPCRNql/zLLjPGJQiAhhrbs71O+8jDQ+MtwxHhilu/hNqbYAEQ8W4wWwTA
	J0FiwYqzOiA5NrSiT05TaTlG6Lniw58NF01NcAny6MsDTNwcyt8Jm9LdlGJfVF3QSAHv1pU16yq
	+j2p3XUKjswOBTcAa9wJ1L3W4G6uQlT2Ps2m1+hbMWQXwbUfPf2XzgE3GcqwJWKZBSgFW/UI4iB
	EYjz54MhzcjleMwWbcruMRtaji7NPdPaL
X-Google-Smtp-Source: AGHT+IG7BiXciOhftT0zwrL7uy6uZPq0abR96qO3gTIwFnSas8/UNM3c8OCqxk8XY09pWhYXxF+JYQ==
X-Received: by 2002:a17:90b:288e:b0:324:dfd8:3426 with SMTP id 98e67ed59e1d1-32518a8c604mr23986705a91.35.1756287929150;
        Wed, 27 Aug 2025 02:45:29 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3276f59fdf7sm1592558a91.5.2025.08.27.02.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 02:45:28 -0700 (PDT)
Date: Wed, 27 Aug 2025 17:44:22 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Anders Roxell <anders.roxell@linaro.org>, 
	Inochi Amaoto <inochiama@gmail.com>, regressions@lists.linux.dev, linux-next@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, 
	Bjorn Helgaas <bhelgaas@google.com>, Marc Zyngier <maz@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Shradha Gupta <shradhagupta@linux.microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Jonathan Cameron <Jonathan.Cameron@huwei.com>, 
	Juergen Gross <jgross@suse.com>, Nicolin Chen <nicolinc@nvidia.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Chen Wang <unicorn_wang@outlook.com>, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, Yixun Lan <dlan@gentoo.org>, 
	Longbin Li <looong.bin@gmail.com>, arnd@arndb.de, dan.carpenter@linaro.org, 
	naresh.kamboju@linaro.org, benjamin.copeland@linaro.org
Subject: Re: [PATCH v2 2/4] PCI/MSI: Add startup/shutdown for per device
 domains
Message-ID: <sn27guw2aho2fudqigsuaz4pmlwxuu53qj3raoytd4s3a7ky4n@lnocdajrtmsp>
References: <20250813232835.43458-1-inochiama@gmail.com>
 <20250813232835.43458-3-inochiama@gmail.com>
 <aK4O7Hl8NCVEMznB@monster>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aK4O7Hl8NCVEMznB@monster>

On Tue, Aug 26, 2025 at 09:45:48PM +0200, Anders Roxell wrote:
> On 2025-08-14 07:28, Inochi Amaoto wrote:
> > As the RISC-V PLIC can not apply affinity setting without calling
> > irq_enable(), it will make the interrupt unavailble when using as
> > an underlying IRQ chip for MSI controller.
> > 
> > Implement .irq_startup() and .irq_shutdown() for the PCI MSI and
> > MSI-X templates. For chips that specify MSI_FLAG_PCI_MSI_STARTUP_PARENT,
> > these startup and shutdown the parent as well, which allows the
> > irq on the parent chip to be enabled if the irq is not enabled
> > when allocating. This is necessary for the MSI controllers which
> > use PLIC as underlying IRQ chip.
> > 
> > Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> > Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> 
> Regressions found while booting the Linux next-20250826 on the
> qemu-arm64, qemu-armv7 due to following kernel log.
> 
> Bisection identified this commit as the cause of the regression.
> 
> Regression Analysis:
> - New regression? Yes
> - Reproducible? Yes
> 
> First seen on the next-20250826
> Good: next-20250825
> Bad: next-20250826
> 
> Test regression: next-20250826 gcc-13 boot failed on qemu-arm64 and
> qemu-armv7.
> 
> Expected behavior: System should boot normally and virtio block devices
> should be detected and initialized immediately.
> 
> Actual behavior: System hangs for ~30 seconds during virtio block device
> initialization before showing scheduler deadline replenish errors and
> failing to complete boot.
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> [...]
> <6>[    1.369038] virtio-pci 0000:00:01.0: enabling device (0000 ->
> 0003)
> <6>[    1.420097] Serial: 8250/16550 driver, 4 ports, IRQ sharing
> enabled
> <6>[    1.450858] msm_serial: driver initialized
> <6>[    1.454489] SuperH (H)SCI(F) driver initialized
> <6>[    1.456056] STM32 USART driver initialized
> <6>[    1.513325] loop: module loaded
> <6>[    1.515744] virtio_blk virtio0: 2/0/0 default/read/poll queues
> <5>[    1.527859] virtio_blk virtio0: [vda] 5397504 512-byte logical
> blocks (2.76 GB/2.57 GiB)
> <4>[   29.761219] sched: DL replenish lagged too much
> [here it hangs]
> 
> 
> Reverting this commit restores normal boot behavior.
> 
> 
> qemu-arm64
>  - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250826/testrun/29663822/suite/boot/test/gcc-13-lkftconfig/log
> 
> qemu-armv7
>  - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250826/testrun/29663615/suite/boot/test/gcc-13-lkftconfig/log
> 
> ## Source
> * Git tree:
> * https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git
> * Git sha: d0630b758e593506126e8eda6c3d56097d1847c5
> * Git describe: next-20250826
> * Project details: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250826
> * Architectures: arm64
> * Toolchains: gcc-13
> * Kconfigs: gcc-13-lkftconfig
> 
> 
> ## Build
> * Test history: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250826/testrun/29663822/suite/boot/test/gcc-13-lkftconfig/history/
> * Test link: https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/31oo1cMOi0uSNKYApi80iQahbLi
> * Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/31onzS5UmJVvvZucEhtB1veoJA1/
> * Kernel config: https://storage.tuxsuite.com/public/linaro/lkft/builds/31onzS5UmJVvvZucEhtB1veoJA1/config
> 
> --
> Linaro LKFT
> https://lkft.linaro.org

Fix patch is here:

https://lore.kernel.org/all/20250827062911.203106-1-inochiama@gmail.com/

Regards,
Inochi

