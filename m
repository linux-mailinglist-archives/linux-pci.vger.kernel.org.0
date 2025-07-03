Return-Path: <linux-pci+bounces-31435-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 241C6AF7D96
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 18:18:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89D6A1CA1D85
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 16:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE6502EE27C;
	Thu,  3 Jul 2025 16:07:45 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2551AF0C1;
	Thu,  3 Jul 2025 16:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751558865; cv=none; b=E+a0jpo3Z1TXdZAlAfc7QoleQvDQD+/P47pGlpuVQy/U97Pxf5FG4H8ZbxD5H0GiM4xe1DDsEajdvmGmxE/fpICaFDxpA4thWHezjExNZP4FvQ74u/MPUGSeYflIK2LIfy+O5USZubLpphcsnnb+qJeZ0/DiFbMA3e8i69MiFNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751558865; c=relaxed/simple;
	bh=EHpaFvifCpxJBJC6Rjc9AigqAHUZd25WOGT5s2c+rqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UnB+RJLD9cPthoKKw0abfGHNovnrJMEX5Xujb7SGY9TdP5VuUnFxnsrdrXtsWze8ZhF4xi8PEKi/LDBhXeM4Ti9OzqDQiN+QVJkSR2HbtWAzoBzGFDBgffttyl78AX6oNt2RzabmmkEonldfVa19e0wYYZhsHpP6TS71KdYn9Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECBACC4CEE3;
	Thu,  3 Jul 2025 16:07:41 +0000 (UTC)
Date: Thu, 3 Jul 2025 17:07:39 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Will Deacon <will@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
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
Message-ID: <aGaqyx6BIk2-oSdm@arm.com>
References: <20250703-gicv5-host-v7-0-12e71f1b3528@kernel.org>
 <20250703-gicv5-host-v7-22-12e71f1b3528@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703-gicv5-host-v7-22-12e71f1b3528@kernel.org>

On Thu, Jul 03, 2025 at 12:25:12PM +0200, Lorenzo Pieralisi wrote:
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
> Reviewed-by: Marc Zyngier <maz@kernel.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Marc Zyngier <maz@kernel.org>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

