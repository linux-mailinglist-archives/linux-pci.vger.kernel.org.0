Return-Path: <linux-pci+bounces-31265-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBFE9AF5948
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 15:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CE7B166BD9
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 13:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76697283FDC;
	Wed,  2 Jul 2025 13:26:35 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD7327A134;
	Wed,  2 Jul 2025 13:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751462795; cv=none; b=RfqbRN8w0CVbhwFEfu1UhEmIsWU4EgxwjBPBkughdHJfH6Wo6GAr8IK066bslrQ0y4SZ2pUtyehYQQjhUiCERPKOX88vBPWzob/tsouOtYFUdXatuvzBTAtGfl0/cZli6f7fMnPfcJH13/7x33ifcNR1jG7t3/hAzDgRQtGanR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751462795; c=relaxed/simple;
	bh=mjBmlz+e1pB0jSHMrgbD3aHEExNuYIYFTGz8QGrONvA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Un1eP2iy9k4F5lQZRTCIN6gv6rbvap+geN55IvRJhRNXjXZdhDUBiKdUUKXgUrmA0zNzcksZKiktQLzoTQtVEx5w3YdhFwpgh9ooJlsodyY9c/tWsdzIotmWKR4kDAtR9qATYrKxV1VigE/vohoXid05YTxippjeuekyU1qI1SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bXLHf04Klz6M5HF;
	Wed,  2 Jul 2025 21:25:34 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id A0CB114022E;
	Wed,  2 Jul 2025 21:26:29 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 2 Jul
 2025 15:26:28 +0200
Date: Wed, 2 Jul 2025 14:26:27 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
CC: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "Rob
 Herring" <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, "Sascha
 Bischoff" <sascha.bischoff@arm.com>, Timothy Hayes <timothy.hayes@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>, "Liam R. Howlett"
	<Liam.Howlett@oracle.com>, Peter Maydell <peter.maydell@linaro.org>, "Mark
 Rutland" <mark.rutland@arm.com>, Jiri Slaby <jirislaby@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v6 22/31] irqchip/gic-v5: Add GICv5 LPI/IPI support
Message-ID: <20250702142627.00001979@huawei.com>
In-Reply-To: <20250626-gicv5-host-v6-22-48e046af4642@kernel.org>
References: <20250626-gicv5-host-v6-0-48e046af4642@kernel.org>
	<20250626-gicv5-host-v6-22-48e046af4642@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 26 Jun 2025 12:26:13 +0200
Lorenzo Pieralisi <lpieralisi@kernel.org> wrote:

> An IRS supports Logical Peripheral Interrupts (LPIs) and implement
> Linux IPIs on top of it.
> 
> LPIs are used for interrupt signals that are translated by a
> GICv5 ITS (Interrupt Translation Service) but also for software
> generated IRQs - namely interrupts that are not driven by a HW
> signal, ie IPIs.
> 
> LPIs rely on memory storage for interrupt routing and state.
> 
> LPIs state and routing information is kept in the Interrupt
> State Table (IST).
> 
> IRSes provide support for 1- or 2-level IST tables configured
> to support a maximum number of interrupts that depend on the
> OS configuration and the HW capabilities.
> 
> On systems that provide 2-level IST support, always allow
> the maximum number of LPIs; On systems with only 1-level
> support, limit the number of LPIs to 2^12 to prevent
> wasting memory (presumably a system that supports a 1-level
> only IST is not expecting a large number of interrupts).
> 
> On a 2-level IST system, L2 entries are allocated on
> demand.
> 
> The IST table memory is allocated using the kmalloc() interface;
> the allocation required may be smaller than a page and must be
> made up of contiguous physical pages if larger than a page.
> 
> On systems where the IRS is not cache-coherent with the CPUs,
> cache mainteinance operations are executed to clean and
> invalidate the allocated memory to the point of coherency
> making it visible to the IRS components.
> 
> On GICv5 systems, IPIs are implemented using LPIs.
> 
> Add an LPI IRQ domain and implement an IPI-specific IRQ domain created
> as a child/subdomain of the LPI domain to allocate the required number
> of LPIs needed to implement the IPIs.
> 
> IPIs are backed by LPIs, add LPIs allocation/de-allocation
> functions.
> 
> The LPI INTID namespace is managed using an IDA to alloc/free LPI INTIDs.
> 
> Associate an IPI irqchip with IPI IRQ descriptors to provide
> core code with the irqchip.ipi_send_single() method required
> to raise an IPI.
> 
> Co-developed-by: Sascha Bischoff <sascha.bischoff@arm.com>
> Signed-off-by: Sascha Bischoff <sascha.bischoff@arm.com>
> Co-developed-by: Timothy Hayes <timothy.hayes@arm.com>
> Signed-off-by: Timothy Hayes <timothy.hayes@arm.com>
> Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Marc Zyngier <maz@kernel.org>

Hi Lorenzo,

The code in here looks fine to me, but one of the comments
doesn't seem to match with what the code is doing. Perhaps it's stale and needs
an update?

Jonathan

> diff --git a/drivers/irqchip/irq-gic-v5-irs.c b/drivers/irqchip/irq-gic-v5-irs.c
> index fba8efceb26e..e161acd05bf5 100644
> --- a/drivers/irqchip/irq-gic-v5-irs.c
> +++ b/drivers/irqchip/irq-gic-v5-irs.c



> +/*
> + * Try to match the L2 IST size to the pagesize, and if this is not possible
> + * pick the smallest supported L2 size in order to minimise the requirement for
> + * physically contiguous blocks of memory as page-sized allocations are
> + * guaranteed to be physically contiguous, and are by definition the easiest to
> + * find.

This comment is not matching up with the code.  Seems that if a page size match
is not possible it first tries to pick the largest L2 size below the page size.
If there are none of those it then falls back to trying steadily larger sizes.

> + *
> + * Fall back to the smallest supported size (in the event that the pagesize
> + * itself is not supported) again serves to make it easier to find physically
> + * contiguous blocks of memory.
> + */
> +static unsigned int gicv5_irs_l2_sz(u32 idr2)
> +{
> +	switch (PAGE_SIZE) {
> +	case SZ_64K:
> +		if (GICV5_IRS_IST_L2SZ_SUPPORT_64KB(idr2))
> +			return GICV5_IRS_IST_CFGR_L2SZ_64K;
> +		fallthrough;
> +	case SZ_16K:
> +		if (GICV5_IRS_IST_L2SZ_SUPPORT_16KB(idr2))
> +			return GICV5_IRS_IST_CFGR_L2SZ_16K;
> +		fallthrough;
> +	case SZ_4K:
> +		if (GICV5_IRS_IST_L2SZ_SUPPORT_4KB(idr2))
> +			return GICV5_IRS_IST_CFGR_L2SZ_4K;
> +		break;
> +	}
> +
> +	if (GICV5_IRS_IST_L2SZ_SUPPORT_16KB(idr2))
> +		return GICV5_IRS_IST_CFGR_L2SZ_16K;
> +
> +	return GICV5_IRS_IST_CFGR_L2SZ_64K;
> +}



