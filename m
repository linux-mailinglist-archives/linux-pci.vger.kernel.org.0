Return-Path: <linux-pci+bounces-34788-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C81B0B3735F
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 21:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71C011B276BC
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 19:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7344D2F0C7A;
	Tue, 26 Aug 2025 19:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vhg0VABN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639D7238C0A
	for <linux-pci@vger.kernel.org>; Tue, 26 Aug 2025 19:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756237556; cv=none; b=IPsh1iNNUkjeU9L527vPe4Q6yP030vCiyIruij7H9fzo4yQhX20Of37QA/jICh0p6ixZx1GTueEm6UV7AB8Ehga4NJAvEQ1OzMmRPi8j+HdHY+zh3RkhH4zpj2i5YyFSwu4AERUiBZu+DVKG7KdH5fiBvflSlKF7kS3fnI1Hpok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756237556; c=relaxed/simple;
	bh=JzdvJ3D4cIox4VnfVjxmXcW2+yE9RmgV3r9R+q8PdFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cQhW53EJx1/Qo/I4EJNJni9ZiOwRMQwd1OI+AR0IwocdVuiWIzELh6q3/fajsZ721VZ3CYunStEqGDzWsjrgjZaY5nG+ITBurEXS5/WlSiuNT6gxLqPT0WuyurqlHqdHIM/pz4AxYxCLkILlWEBLIhUIu8/HRXyTReJqeobYKcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vhg0VABN; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-55f52dd2bf9so33356e87.2
        for <linux-pci@vger.kernel.org>; Tue, 26 Aug 2025 12:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756237551; x=1756842351; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IXuip4G3eXQRlL52moPjD1+7Xz7J18hYMMxbx4Ti2y4=;
        b=vhg0VABNQQGRadMHSQ7SycAyvpbFv6QjliAP2sBrbz9c0EGrQa08QSsxEq7Ra+Ux2+
         xLKfn2qGAk7yTAIx/yo7WxcufYS+goiO24UFJ7jj5gxEvDDjo7WEBlyjgChgEWq7j8HE
         LpjzNOS2E/oOFosMwFZ83IQvu2T0/8w8YwnBL8ZoBzcB7c3lJaqZ9dLJunPhZYQSf1gZ
         UjvEqASB9+PLDffxwz3ngX7YpYiSg9EpvYHzpFiDeoG6esaRA5ri7SjZv075I+4p2x0f
         3v+zToMokKXYe0Hh2hlS3lM/oaGfa/5rAhE8QbojpJp1dqtMNYgxLNnxB0YTyT1C9kgf
         3L/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756237551; x=1756842351;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IXuip4G3eXQRlL52moPjD1+7Xz7J18hYMMxbx4Ti2y4=;
        b=JThMXxAKmZzhi5wkI9iEoxR8NVKwQYkmvgTZYfuNXYG46VVk4CMmNu91IWQM3xDsbk
         P30Pc8Ap86gIa2BjEBFSnDNhlvki7TGD2+eq3g1Vs8RfsdNzgj19bWb1Ur0D4u9xK4/Y
         xj06byL7cEk2EbRaoHUqf2+xHXYyRY+8rG+UohZyaWqXc1MpuyakLoEJQzJ2D+Qbey+f
         uhT1u814xExc/hBDv/aBrEHPohvTe5ybAXSTrYepYi34lR1F/rywzyu+RTYQe28RDfu9
         VO1EOF/XUPU6biQuq5SJDUHCMO9lwRhVsjdlWXg1kCotTWpE1Vs8U1VL/SfwAuGLPZ1O
         ihaQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+LQmJx8jOY2B7omedo5qUzI3cn1cFbUg1IzcZpVUBmxzFd6N4Czp6RO5cMyN7SmRaL/rRerx/GJY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxrepzf+6gH+xY6sIBqx8dxhIPhCn53ahlQGCbuuCu/QxRKnqBZ
	mrwe9M338kxqsEC63YlNn69tDnqJYqiwV9Lvd8RQ2WZnukfGZl28sLthvlKYssYKdF0=
X-Gm-Gg: ASbGncvL7xQrFIh5hE0SKvPeiBvq9tPGOX5+2ZkQpuXT3vMA/MTpDccwEs8BZ5RVnup
	G1SKZXBp1kmfpYYauOUaRKGV99KwgS6a34h639q/3Kc5eF2xp1jxCrUS1ut9C3co1lqMiYDH+5l
	fRxRYigdEEM1/D/kyF7hz9rR7egiwzWu9BPnmoL8jzNXZ4TjZT7QDcGZXqvixHd3voGJVGoIyIN
	T/tjfu2l9C4mgshyWxpDh+Sj8hUkWsBMUA1/gjWTyYGH66gzJaJgUdWtraXnDIPQJm9dVsEcmrV
	821d1qmqc6c8/Pk93Az1KGIHC/k9UsLItL7bvOWfa1m0G4a1g9kpvNkAOZnlEgcQP/rqBZNKmEL
	39X7TrHz1FQ5u4rzDLKG25SVn4c+XrH4knSUAPRtzgBMGPkV7pj2kcqqvnTIhY2+03vbiwfeHcG
	EXUqzS9q0sccA=
X-Google-Smtp-Source: AGHT+IEt8Nv0C9k6B51P0Bu6omHX78GtGUI5akzFwO0EsKKpWO1hUm2te9ZXs4y0v64KaGbBkwbGtQ==
X-Received: by 2002:a05:651c:20cd:20b0:334:1db:486d with SMTP id 38308e7fff4ca-33650e22e7dmr16358621fa.2.1756237551336;
        Tue, 26 Aug 2025 12:45:51 -0700 (PDT)
Received: from monster (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3365e20cc9csm23313081fa.10.2025.08.26.12.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 12:45:50 -0700 (PDT)
Date: Tue, 26 Aug 2025 21:45:48 +0200
From: Anders Roxell <anders.roxell@linaro.org>
To: Inochi Amaoto <inochiama@gmail.com>, regressions@lists.linux.dev,
	linux-next@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>, Marc Zyngier <maz@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Shradha Gupta <shradhagupta@linux.microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Jonathan Cameron <Jonathan.Cameron@huwei.com>,
	Juergen Gross <jgross@suse.com>, Nicolin Chen <nicolinc@nvidia.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Chen Wang <unicorn_wang@outlook.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>, arnd@arndb.de,
	dan.carpenter@linaro.org, naresh.kamboju@linaro.org,
	benjamin.copeland@linaro.org
Subject: Re: [PATCH v2 2/4] PCI/MSI: Add startup/shutdown for per device
 domains
Message-ID: <aK4O7Hl8NCVEMznB@monster>
References: <20250813232835.43458-1-inochiama@gmail.com>
 <20250813232835.43458-3-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250813232835.43458-3-inochiama@gmail.com>

On 2025-08-14 07:28, Inochi Amaoto wrote:
> As the RISC-V PLIC can not apply affinity setting without calling
> irq_enable(), it will make the interrupt unavailble when using as
> an underlying IRQ chip for MSI controller.
> 
> Implement .irq_startup() and .irq_shutdown() for the PCI MSI and
> MSI-X templates. For chips that specify MSI_FLAG_PCI_MSI_STARTUP_PARENT,
> these startup and shutdown the parent as well, which allows the
> irq on the parent chip to be enabled if the irq is not enabled
> when allocating. This is necessary for the MSI controllers which
> use PLIC as underlying IRQ chip.
> 
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>

Regressions found while booting the Linux next-20250826 on the
qemu-arm64, qemu-armv7 due to following kernel log.

Bisection identified this commit as the cause of the regression.

Regression Analysis:
- New regression? Yes
- Reproducible? Yes

First seen on the next-20250826
Good: next-20250825
Bad: next-20250826

Test regression: next-20250826 gcc-13 boot failed on qemu-arm64 and
qemu-armv7.

Expected behavior: System should boot normally and virtio block devices
should be detected and initialized immediately.

Actual behavior: System hangs for ~30 seconds during virtio block device
initialization before showing scheduler deadline replenish errors and
failing to complete boot.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

[...]
<6>[    1.369038] virtio-pci 0000:00:01.0: enabling device (0000 ->
0003)
<6>[    1.420097] Serial: 8250/16550 driver, 4 ports, IRQ sharing
enabled
<6>[    1.450858] msm_serial: driver initialized
<6>[    1.454489] SuperH (H)SCI(F) driver initialized
<6>[    1.456056] STM32 USART driver initialized
<6>[    1.513325] loop: module loaded
<6>[    1.515744] virtio_blk virtio0: 2/0/0 default/read/poll queues
<5>[    1.527859] virtio_blk virtio0: [vda] 5397504 512-byte logical
blocks (2.76 GB/2.57 GiB)
<4>[   29.761219] sched: DL replenish lagged too much
[here it hangs]


Reverting this commit restores normal boot behavior.


qemu-arm64
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250826/testrun/29663822/suite/boot/test/gcc-13-lkftconfig/log

qemu-armv7
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250826/testrun/29663615/suite/boot/test/gcc-13-lkftconfig/log

## Source
* Git tree:
* https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git
* Git sha: d0630b758e593506126e8eda6c3d56097d1847c5
* Git describe: next-20250826
* Project details: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250826
* Architectures: arm64
* Toolchains: gcc-13
* Kconfigs: gcc-13-lkftconfig


## Build
* Test history: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250826/testrun/29663822/suite/boot/test/gcc-13-lkftconfig/history/
* Test link: https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/31oo1cMOi0uSNKYApi80iQahbLi
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/31onzS5UmJVvvZucEhtB1veoJA1/
* Kernel config: https://storage.tuxsuite.com/public/linaro/lkft/builds/31onzS5UmJVvvZucEhtB1veoJA1/config

--
Linaro LKFT
https://lkft.linaro.org

