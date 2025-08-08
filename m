Return-Path: <linux-pci+bounces-33616-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE71B1E44B
	for <lists+linux-pci@lfdr.de>; Fri,  8 Aug 2025 10:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2208E7A5DC8
	for <lists+linux-pci@lfdr.de>; Fri,  8 Aug 2025 08:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9560259CBE;
	Fri,  8 Aug 2025 08:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ACYMXpLL"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3A74A11;
	Fri,  8 Aug 2025 08:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754641205; cv=none; b=GxAQZwg1RkjVReQAg2FhOEBeGKZjU4f8NinO7Ogk6TBAZctfZ4vGPWyG9RP3FGYdqTVR4H2ONDSzE8NazO5TBZf2LBEvRi8gD8yRUzPPGeTATaDkmM6YCRq218xNDYQl9jay0OtxvPJUwGmCS8dXlTYD4FFBxAJEv0yxTNEIg8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754641205; c=relaxed/simple;
	bh=c3NroZ1PK5QOerK5RtUeTbp8bGlTMhkWlahVSYgFCVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LxkUCuXeEqefVc7B1OSDr0wp6aAPOOpN43ZOONoDU2pFW/PFbYMm80sZwgvt8gSzsRQDAJY6LrulXMCw8LkrhxDqZisbdhotF6gOGV85ov1g5wjVIhv5Kuq8bcJxR608z2GwwSvnIewSnzUAJf4V0kToCiuS1qcDYebFjdXkExo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ACYMXpLL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C4E1C4CEED;
	Fri,  8 Aug 2025 08:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754641205;
	bh=c3NroZ1PK5QOerK5RtUeTbp8bGlTMhkWlahVSYgFCVQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ACYMXpLLU39k1efldn2qFTbPWCskR2n7eI7XSl9vjOlW0avJ+zwwzid20DikChGnv
	 4d+V64Msl8CWbDVUCakPQ9ffBnYzmlvkQ83TS2BWKgpIscASVx+FIQZKYJlZeEL3Nb
	 I8RMj5rF+jPhewbKF7TRxYwLqJsm0L2fAiNw4mm+OiBe97vvRV8ZBMwcJFIKZDOu69
	 QFih9I+gPBd5S/NXGYyMNGOWEkk6q8Lir1jntHBH/Haxqa4j05YJ/uq7H0eQ7uoqim
	 bYZIa0wdgXbq9ZPHfjQuq71uaVrT2eiKQFOh+o1yHZv9H3mSAo8mIblz5ggGD5MrAQ
	 beCJyGAXdFZRg==
Date: Fri, 8 Aug 2025 10:19:54 +0200
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Sascha Bischoff <sascha.bischoff@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Timothy Hayes <timothy.hayes@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Peter Maydell <peter.maydell@linaro.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v7 22/31] irqchip/gic-v5: Add GICv5 LPI/IPI support
Message-ID: <aJWzKqM9bHuKy+1m@lpieralisi>
References: <20250703-gicv5-host-v7-0-12e71f1b3528@kernel.org>
 <20250703-gicv5-host-v7-22-12e71f1b3528@kernel.org>
 <cc611dda-d1e4-4793-9bb2-0eaa47277584@huawei.com>
 <aJSvUWRqLEiARDIW@lpieralisi>
 <c8e3dc2c-617b-2988-10ff-88082370e787@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8e3dc2c-617b-2988-10ff-88082370e787@huawei.com>

On Fri, Aug 08, 2025 at 09:20:30AM +0800, Jinjie Ruan wrote:
> 
> 
> On 2025/8/7 21:51, Lorenzo Pieralisi wrote:
> > On Thu, Aug 07, 2025 at 07:52:58PM +0800, Jinjie Ruan wrote:
> >>
> >>
> >> On 2025/7/3 18:25, Lorenzo Pieralisi wrote:
> >>> An IRS supports Logical Peripheral Interrupts (LPIs) and implement
> >>> Linux IPIs on top of it.
> >>>
> 
> [...]
> 
> >>> +static int __init gicv5_irs_init_ist_linear(struct gicv5_irs_chip_data *irs_data,
> >>> +					    unsigned int lpi_id_bits,
> >>> +					    unsigned int istsz)
> >>> +{
> >>> +	size_t l2istsz;
> >>> +	u32 n, cfgr;
> >>> +	void *ist;
> >>> +	u64 baser;
> >>> +	int ret;
> >>> +
> >>> +	/* Taken from GICv5 specifications 10.2.1.13 IRS_IST_BASER */
> >>> +	n = max(5, lpi_id_bits + 1 + istsz);
> >>> +
> >>> +	l2istsz = BIT(n + 1);
> >>> +	/*
> >>> +	 * Check memory requirements. For a linear IST we cap the
> >>> +	 * number of ID bits to a value that should never exceed
> >>> +	 * kmalloc interface memory allocation limits, so this
> >>> +	 * check is really belt and braces.
> >>> +	 */
> >>> +	if (l2istsz > KMALLOC_MAX_SIZE) {
> >>> +		u8 lpi_id_cap = ilog2(KMALLOC_MAX_SIZE) - 2 + istsz;
> >>> +
> >>> +		pr_warn("Limiting LPI ID bits from %u to %u\n",
> >>> +			lpi_id_bits, lpi_id_cap);
> >>> +		lpi_id_bits = lpi_id_cap;
> >>> +		l2istsz = KMALLOC_MAX_SIZE;
> >>> +	}
> >>> +
> >>> +	ist = kzalloc(l2istsz, GFP_KERNEL);
> >>
> >>
> >> When kmemleak is on, There is a memory leak occurring as below:
> >>
> >>
> >> unreferenced object 0xffff00080039a000 (size 4096):
> >>   comm "swapper/0", pid 0, jiffies 4294892296
> >>   hex dump (first 32 bytes):
> >>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> >>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> >>   backtrace (crc 0):
> >>     kmemleak_alloc+0x34/0x40
> >>     __kmalloc_noprof+0x320/0x464
> >>     gicv5_irs_iste_alloc+0x1a4/0x484
> >>     gicv5_irq_lpi_domain_alloc+0xe4/0x194
> >>     irq_domain_alloc_irqs_parent+0x78/0xd8
> >>     gicv5_irq_ipi_domain_alloc+0x180/0x238
> >>     irq_domain_alloc_irqs_locked+0x238/0x7d4
> >>     __irq_domain_alloc_irqs+0x88/0x114
> >>     gicv5_of_init+0x284/0x37c
> >>     of_irq_init+0x3b8/0xb18
> >>     irqchip_init+0x18/0x40
> >>     init_IRQ+0x104/0x164
> >>     start_kernel+0x1a4/0x3d4
> >>     __primary_switched+0x8c/0x94
> > 
> > Thank you for reporting it.
> > 
> > It should be a false positive, we hand over the memory to the GIC but
> > never store the pointer anywhere (only its PA).
> > 
> > Patch below should "fix" it - well, it is obvious, we are telling
> > kmemleak to ignore the pointer value:
> 
> I also did not see any place in the code where these pointers are
> accessed, nor did I see in section "L2_ISTE, Level 2 interrupt state
> table entry" that L2_ISTE can be accessed by software. So, are these
> states of the LPI interrupt maintained by the GIC hardware itself?

The IST table is where interrupt state and configuration is kept -
it is managed by GIC IRS HW. SW controls interrupt configuration
through GIC instructions.

It is therefore a false positive, I will send the patch below for
inclusion.

Thanks,
Lorenzo

> > 
> > -- >8 --
> > diff --git a/drivers/irqchip/irq-gic-v5-irs.c b/drivers/irqchip/irq-gic-v5-irs.c
> > index ad1435a858a4..e8a576f66366 100644
> > --- a/drivers/irqchip/irq-gic-v5-irs.c
> > +++ b/drivers/irqchip/irq-gic-v5-irs.c
> > @@ -5,6 +5,7 @@
> >  
> >  #define pr_fmt(fmt)	"GICv5 IRS: " fmt
> >  
> > +#include <linux/kmemleak.h>
> >  #include <linux/log2.h>
> >  #include <linux/of.h>
> >  #include <linux/of_address.h>
> > @@ -117,6 +118,7 @@ static int __init gicv5_irs_init_ist_linear(struct gicv5_irs_chip_data *irs_data
> >  		kfree(ist);
> >  		return ret;
> >  	}
> > +	kmemleak_ignore(ist);
> >  
> >  	return 0;
> >  }
> > @@ -232,6 +234,7 @@ int gicv5_irs_iste_alloc(const u32 lpi)
> >  		kfree(l2ist);
> >  		return ret;
> >  	}
> > +	kmemleak_ignore(l2ist);
> >  
> >  	/*
> >  	 * Make sure we invalidate the cache line pulled before the IRS
> > 

