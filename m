Return-Path: <linux-pci+bounces-34798-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09150B374EA
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 00:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6C84205FAD
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 22:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1C4289805;
	Tue, 26 Aug 2025 22:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="daHaZqHF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBBA1F956;
	Tue, 26 Aug 2025 22:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756247691; cv=none; b=mCL47/AiF6x9Ow1sx5Gjsl3gyNlbtVgOHT11CZaWZ52pyL/3tzAy6DzyZehnaUNPMdy/tInjJRnu2pYHuANazYz3iO6+ktNdtVEjrrXeqdgyAgr1b6nzV4ToKJ2QC1QUTOOTBEg7aw9QaStbcuGiy1sLsC9KWku7eGpnXOOexEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756247691; c=relaxed/simple;
	bh=EEkJaAafcOKFyB4lTny68tiYrsafHivmnU/TOutPJ5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KCWkaEDbn3qRfhDzEW06sK+jD23yHHlBqnuUZT6rmJZHeYWQO63hvS3Ilqf+HQwN/tepHXjKpjJKxue2mouoN1Hq6HhDY7w0HSxEt73RI4V2OuAOiqWZ1/Jb0LSsC78DkyVUlhDYbHyEG3XLDGpEnnpaL6Azl40YlIWQKyFPj1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=daHaZqHF; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-770d7dafacdso3201742b3a.0;
        Tue, 26 Aug 2025 15:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756247689; x=1756852489; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MlcTGMUgifx2RiHCp6Ej2dJ6SNZ+6djc1Qx2bk17n0s=;
        b=daHaZqHF9ifHDrFLtPbDMOkNfXZ4wT2miaQnAc3eBVpto/mR2uYu1aM2YNTW0c2PHd
         NxbYYJkvmrNdL1K6DAEqnM2HvMQsUN87IY1Qo9+o/4SzXo61k9y9RWVruabaNkoV5AIE
         uXLhPmQQm5Exv0ikuw6brUfTx5bkIrOaNxpy8GTpnNXqxD720weSqQD0i6B7M2vGIppq
         SO//jwTGHjH3QhNHWusul03ehZ17frgCvnElQt06Qx+xotGojgHEKfJGANty0YqgJmto
         I005DCYH2JsaL8deDviOSb+ZFqtkje/fgthBIdecKtuh2XCZeYhNmGnn5g1zhsc7PmbL
         BLDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756247689; x=1756852489;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MlcTGMUgifx2RiHCp6Ej2dJ6SNZ+6djc1Qx2bk17n0s=;
        b=VCygKiTQA7PrfDoaGNiK+/ruK9kh4PXYqSv2m6kwTcN1KBDUbQU2yC6UF19JL0FmBd
         CrsGyk3ebjvHKA/hsT/hInaW97p7q2u9X/GIhhBzAkQlNbzLKrH0EOJiRGdYGchaK7Ak
         QLM2Nxa2cKqstVPXWCkSHWELsG226ce3ZbO+K1xyb2849TBPy2RNp5H5IX4c2oNgMXti
         1wqYYSuCYUio/e8M81d/mRYdvSld5At3rp8FZUifAA7sNOhQ+cOUzFcbhV7FjnnZLXTz
         U1Wl0KVPdgS+SwnV7K6vvv1wlMktsNZJBL1+AXVLZQ2LC+EuTip7wweuYajMMoZh1wT6
         F4Kg==
X-Forwarded-Encrypted: i=1; AJvYcCUOMByClRuSyZHjIgnp84t0bYYLNY3eyRZHtQ7l1YBPU3p2bGGSxrE50WikA+ThUITXO88rX5YIY6Ss2w==@vger.kernel.org, AJvYcCVM9NpgdI9+yJMqP6AH1MU59ZuKiD8TqC3mvf/WwN+TEbZ5SHA8ULgY7+JoC+MzTtxw5zSSf3VR/Ru9@vger.kernel.org, AJvYcCVruFXoiV+HBad3KSq07utiySALQmH8vVmCJZ50EYy6IgcypyXCfm3CFfC7iMN9kVLn9mFrOyJtfYoTDj8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzujo6/xZnbmivHgN9d91BVwp/c/1OaxATHOHlQln2PTFhkASrr
	KwPE0VVrv3rpypW8U53VyrpSsxec796BNnpu6WlJyYZP+/D7PNJcxnKwOEiJjvwGYEc=
X-Gm-Gg: ASbGnctzWXW9Yuz/tCrqLSM36dniHAhX9jeWUStbdnsI6t3q8l/nUo6h3dNYj3yCbop
	DM1wpuaTTBKkk44CvJX0xTif4Kjl+vka/nOMs+jQUcD7X13h+wc7GKdNtjA34fpaQSbPPsOBD60
	ZdGN1+y2BRSvjVSlnocgvVk5Zw8b5KwHYIt6crx0yQE5vwY0IjxKMx1b1D124014ld0EO76td7s
	XDZhGYnOxsJb8l4/zUKggNtWKbTFZFRTxpNCAyY07JzmgW8QxVJR06WPFHxLRQhvz2oJXUSQeQ7
	JWdc9ZTWhMrGS17sBRQjy0r9S8bDBWArCJG/ITOT6FtyTevJUiISQ33N1sfHD0oEqB+JQTZOOgU
	lDk4+NNm6uqOeWqOR9n/rOw==
X-Google-Smtp-Source: AGHT+IGfPCTEG8tOKAPJA3d1mdxq78PjG+UtrfIta7Lka4CvtlAMw+MvEMkZiwuGdL1KIgPUDoDSww==
X-Received: by 2002:a05:6a20:734f:b0:240:dc9:71cf with SMTP id adf61e73a8af0-24340d15950mr26206331637.38.1756247689031;
        Tue, 26 Aug 2025 15:34:49 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b49cb8accbasm10005917a12.13.2025.08.26.15.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 15:34:48 -0700 (PDT)
Date: Wed, 27 Aug 2025 06:33:44 +0800
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
Message-ID: <db2pkcmc7tmaozjjihca6qtixkeiy7hlrg325g3pqkuurkvr6u@oyz62hcymvhi>
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

Is there a link for me to get the command line args for qemu? So I can
reproduce it locally.

Regards,
Inochi

