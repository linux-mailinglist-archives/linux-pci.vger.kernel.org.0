Return-Path: <linux-pci+bounces-34808-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBA7DB37589
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 01:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CD3D188F5A8
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 23:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C038F306D3F;
	Tue, 26 Aug 2025 23:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A/s5dpVa"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A762F530E;
	Tue, 26 Aug 2025 23:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756250995; cv=none; b=D4+ljtPI/IkHNKrf5PGPu+9yNzCERgg/4RSnAlJuLYQtX4lN5Hd2rr7n2BRQpLegIWQa5eKZkBcOlpat0kKpUK3rOaaRzweik9tVlcdFT5UoHlihqKTXCh735Un4ytoAHGllvrqmSE0SIEHkM1F4m3/HE+96FQ74TnBjn9gs3XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756250995; c=relaxed/simple;
	bh=SH/6h91qpnpAFIHGeQcNbOGo+Nkn8rX6M7jXUcUBzOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kUpreB76UwbAkKL46CbxhhRxYSfjbeoVFdOGfsp9dB6bGgfBiUFB6s9xniNm98Y9NUX3wTPkqxC1C+5jAAlyO282ItIM9B1aXVLUr/6PxQsBFCDSmSB2wOhN03yrSe/JGPGg5m4AlwIZNaYP21bkhYLkOzm4rQ06gTrFjCqj8Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A/s5dpVa; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-771f90a45easo1307528b3a.1;
        Tue, 26 Aug 2025 16:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756250993; x=1756855793; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/MCskDU2VQoeJx9AHDkEILENvAHCcaaSEAim49BZauI=;
        b=A/s5dpVavCeqYN/AFKNqh4pZ+PBmazomMLKsldUjozVQQzjRxn8b4wqvTEu8FsySsr
         yzpIbYUy6Q8Km2ceIWM3QdRXBdgLHtYj9ugHY/1dpMUBhvgDcOACiU8SUi+hTXRlVuMt
         RjQiGL2ko9nSYCqIEdDZuoeLsExhnJy4gBHpwrPi9uhgu5osZ5RRVvw7u+umB0OBW/qo
         bZ1z/nklzX2AA4fSypPT3FVxaGhzRMQV1xiPU103CbMmsf+fI/9OzGgE5HxRbiFUN8aV
         IWQI8TbL2CU2hdxK/vAL8aD3ARhNp2S4uT2xcpCYFQoB3vTRBSumNSBl9prKnzdDEXyg
         XLuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756250993; x=1756855793;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/MCskDU2VQoeJx9AHDkEILENvAHCcaaSEAim49BZauI=;
        b=tnxf7ShOQYNOxnYMFJC0trpfu42KdvruBptXpU09S44fBRyJrHm9zyMjn31qknClAI
         D6n6R35vTIT6lPCgaqI2yKZ6RfogtUjqfVWJoCRZ097LHAwJDl+IWe1JMJIH3dO5GBey
         YK11Iz7LvqD7tmTA7BX9kp8h/gW5c3vg02yzW9EPus6T8DtSjSehnJGIG9qek8+YlSbQ
         XBe2T/6Hs+OE25r/egjf94/cprBIvCUpl3M2mfCPzx6/cAHhzpsnvgl1myc7/pXmgAf+
         374W+XmBUGGwHKfDF3pIjbiM8o8KTf1lvq4IaoG9xD5WP9zj2Jak+AmHrrwId7pggwpc
         k5RA==
X-Forwarded-Encrypted: i=1; AJvYcCU+FsIl223BWsptmgJtSKZc7Y3sL8n7Ykpfb64CQnn/XCYtc2ZR3/+ijuG1ku9tL7ATb46pDivTkCd2AQ==@vger.kernel.org, AJvYcCU9PWmviM5GAU2sdpzb6Gk8yT5WEJMaFr9BHGRa+AcghIXqES0UC8djwV3k5ltCV2CFYZE84USzRJL0WTk=@vger.kernel.org, AJvYcCWpgWiJzYhaXcPBy6PWLTHwlAl0QWSs/PI96C2BvTkkIzAEjuBJlpcB37/0L1hozezeUTc7cVCShO05@vger.kernel.org
X-Gm-Message-State: AOJu0YyrZ8rZhZ3oMXvUhBB1mMKvx/gcfZID+/fnsCmAKb05i1d3ow9g
	90z6XIiiJsh/qYkba3uI/K6ITY4CG7A29N61jKTZxOWOE7DmX1MmM7gh
X-Gm-Gg: ASbGnctEH+G7oCzSK4g0egCsGkaPvhpHiSq2/ziIcqNA7YJf450swp3LNuNCEvw1GOv
	iP9bA5jxszyXyF+bUi90MoWUaydNDi6d3infPfD1F1cLjCfGfDzKqQPmhrBRXUT8SovaLZXY4SA
	JMCHnKCGiF3Dy2KWdhFD1nh3pieEUc/7jTmuOhLT5t8PV1MHXSCBYOUlXLrdB+BvTz7WfkevjoP
	WDYcIUCmoif5LQmJ2oJA8jvL3DZGNov4CrrXgH4e5YToZP0S4BOhPQXdvcKuBkpOOKJvyWOM++z
	1kLNCBKR3zKeD4U1m2MdaUnUuibrfwlsq2hFi8fxbhtTKr2SCR58zXJqD2YvOczQ3xQmY/szfGF
	GyXeZEY6fAkL20gNGrAilRg==
X-Google-Smtp-Source: AGHT+IGRotCDv4SipyoV6AyFFZGFY8jLwdOPII+WjCv/MQRwakpFSSVcWidndMWW96nVbb4+8pncgQ==
X-Received: by 2002:a05:6a00:3e0a:b0:770:4c7a:304b with SMTP id d2e1a72fcca58-7704c7a3238mr14288097b3a.19.1756250992691;
        Tue, 26 Aug 2025 16:29:52 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-770401b01b2sm11322475b3a.64.2025.08.26.16.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 16:29:52 -0700 (PDT)
Date: Wed, 27 Aug 2025 07:28:46 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Anders Roxell <anders.roxell@linaro.org>, 
	Nathan Chancellor <nathan@kernel.org>, Inochi Amaoto <inochiama@gmail.com>, regressions@lists.linux.dev, 
	linux-next@vger.kernel.org
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
Message-ID: <qe23hkpdr6ui4mgjke2wp2pl3jmgcauzgrdxqq4olgrkbfy25d@avy6c6mg334s>
References: <20250813232835.43458-1-inochiama@gmail.com>
 <20250813232835.43458-3-inochiama@gmail.com>
 <aK4O7Hl8NCVEMznB@monster>
 <db2pkcmc7tmaozjjihca6qtixkeiy7hlrg325g3pqkuurkvr6u@oyz62hcymvhi>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db2pkcmc7tmaozjjihca6qtixkeiy7hlrg325g3pqkuurkvr6u@oyz62hcymvhi>

On Wed, Aug 27, 2025 at 06:33:44AM +0800, Inochi Amaoto wrote:
> On Tue, Aug 26, 2025 at 09:45:48PM +0200, Anders Roxell wrote:
> > On 2025-08-14 07:28, Inochi Amaoto wrote:
> > > As the RISC-V PLIC can not apply affinity setting without calling
> > > irq_enable(), it will make the interrupt unavailble when using as
> > > an underlying IRQ chip for MSI controller.
> > > 
> > > Implement .irq_startup() and .irq_shutdown() for the PCI MSI and
> > > MSI-X templates. For chips that specify MSI_FLAG_PCI_MSI_STARTUP_PARENT,
> > > these startup and shutdown the parent as well, which allows the
> > > irq on the parent chip to be enabled if the irq is not enabled
> > > when allocating. This is necessary for the MSI controllers which
> > > use PLIC as underlying IRQ chip.
> > > 
> > > Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> > > Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> > 
> > Regressions found while booting the Linux next-20250826 on the
> > qemu-arm64, qemu-armv7 due to following kernel log.
> > 
> > Bisection identified this commit as the cause of the regression.
> > 
> > Regression Analysis:
> > - New regression? Yes
> > - Reproducible? Yes
> > 
> > First seen on the next-20250826
> > Good: next-20250825
> > Bad: next-20250826
> > 
> > Test regression: next-20250826 gcc-13 boot failed on qemu-arm64 and
> > qemu-armv7.
> > 
> > Expected behavior: System should boot normally and virtio block devices
> > should be detected and initialized immediately.
> > 
> > Actual behavior: System hangs for ~30 seconds during virtio block device
> > initialization before showing scheduler deadline replenish errors and
> > failing to complete boot.
> > 
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > 
> > [...]
> > <6>[    1.369038] virtio-pci 0000:00:01.0: enabling device (0000 ->
> > 0003)
> > <6>[    1.420097] Serial: 8250/16550 driver, 4 ports, IRQ sharing
> > enabled
> > <6>[    1.450858] msm_serial: driver initialized
> > <6>[    1.454489] SuperH (H)SCI(F) driver initialized
> > <6>[    1.456056] STM32 USART driver initialized
> > <6>[    1.513325] loop: module loaded
> > <6>[    1.515744] virtio_blk virtio0: 2/0/0 default/read/poll queues
> > <5>[    1.527859] virtio_blk virtio0: [vda] 5397504 512-byte logical
> > blocks (2.76 GB/2.57 GiB)
> > <4>[   29.761219] sched: DL replenish lagged too much
> > [here it hangs]
> > 
> > 
> > Reverting this commit restores normal boot behavior.
> > 
> > 
> > qemu-arm64
> >  - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250826/testrun/29663822/suite/boot/test/gcc-13-lkftconfig/log
> > 
> > qemu-armv7
> >  - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250826/testrun/29663615/suite/boot/test/gcc-13-lkftconfig/log
> > 
> > ## Source
> > * Git tree:
> > * https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git
> > * Git sha: d0630b758e593506126e8eda6c3d56097d1847c5
> > * Git describe: next-20250826
> > * Project details: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250826
> > * Architectures: arm64
> > * Toolchains: gcc-13
> > * Kconfigs: gcc-13-lkftconfig
> > 
> > 
> > ## Build
> > * Test history: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250826/testrun/29663822/suite/boot/test/gcc-13-lkftconfig/history/
> > * Test link: https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/31oo1cMOi0uSNKYApi80iQahbLi
> > * Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/31onzS5UmJVvvZucEhtB1veoJA1/
> > * Kernel config: https://storage.tuxsuite.com/public/linaro/lkft/builds/31onzS5UmJVvvZucEhtB1veoJA1/config
> > 
> 
> Is there a link for me to get the command line args for qemu? So I can
> reproduce it locally.
> 

OK, I guess I know why: I have missed one condition for startup.

Could you test the following patch? If worked, I will send it as
a fix.

---
diff --git a/drivers/pci/msi/irqdomain.c b/drivers/pci/msi/irqdomain.c
index e0a800f918e8..b11b7f63f0d6 100644
--- a/drivers/pci/msi/irqdomain.c
+++ b/drivers/pci/msi/irqdomain.c
@@ -154,6 +154,8 @@ static void cond_shutdown_parent(struct irq_data *data)
 
 	if (unlikely(info->flags & MSI_FLAG_PCI_MSI_STARTUP_PARENT))
 		irq_chip_shutdown_parent(data);
+	else if (unlikely(info->flags & MSI_FLAG_PCI_MSI_MASK_PARENT))
+		irq_chip_mask_parent(data);
 }
 
 static unsigned int cond_startup_parent(struct irq_data *data)
@@ -162,6 +164,9 @@ static unsigned int cond_startup_parent(struct irq_data *data)
 
 	if (unlikely(info->flags & MSI_FLAG_PCI_MSI_STARTUP_PARENT))
 		return irq_chip_startup_parent(data);
+	else if (unlikely(info->flags & MSI_FLAG_PCI_MSI_MASK_PARENT))
+		irq_chip_unmask_parent(data);
+
 	return 0;
 }
 

