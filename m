Return-Path: <linux-pci+bounces-31434-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1667AF7D50
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 18:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A1887BB523
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 16:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF2123C4FE;
	Thu,  3 Jul 2025 16:07:09 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3781AF0C1;
	Thu,  3 Jul 2025 16:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751558829; cv=none; b=J3ju2QVtKmm6LXOROTBDs+t832NMlDDOZYdwRzn/ZFvvFdTu3mchJNrvfdQ23OtR4B4hteAQb0ZwPnd8q4Rg693UtpFN4ysjGHnUocc5uqvhUHJYPhuKjQ6sSEJ9jmPxOGRdTBxOuDVMxYeItd5noFTZKahhGB8rty3B4Tdfwcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751558829; c=relaxed/simple;
	bh=ZSkjJVDS/3cGmMplY5tTT0xLsAOMYcsx64kCgAGuo7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=liYYdoXlbxAiE/TpL9U5/oeGx5l2x4d1Tm7+SK7jlq45WBqJid9oSvMtyneeMXO3jIFvFC2elmvNvVa/TUKlGox5eyG/nL8+HyOTw4HKNyNrOp1C0nyzHkImScJ2wvrkTacBEB4jVwen+vJuHcM4df0JxPMGX2lj/HS0IXmVx0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A8C3C4CEE3;
	Thu,  3 Jul 2025 16:07:05 +0000 (UTC)
Date: Thu, 3 Jul 2025 17:07:03 +0100
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
Subject: Re: [PATCH v7 21/31] irqchip/gic-v5: Add GICv5 IRS/SPI support
Message-ID: <aGaqp-iwOmC8odFF@arm.com>
References: <20250703-gicv5-host-v7-0-12e71f1b3528@kernel.org>
 <20250703-gicv5-host-v7-21-12e71f1b3528@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703-gicv5-host-v7-21-12e71f1b3528@kernel.org>

On Thu, Jul 03, 2025 at 12:25:11PM +0200, Lorenzo Pieralisi wrote:
> The GICv5 Interrupt Routing Service (IRS) component implements
> interrupt management and routing in the GICv5 architecture.
> 
> A GICv5 system comprises one or more IRSes, that together
> handle the interrupt routing and state for the system.
> 
> An IRS supports Shared Peripheral Interrupts (SPIs), that are
> interrupt sources directly connected to the IRS; they do not
> rely on memory for storage. The number of supported SPIs is
> fixed for a given implementation and can be probed through IRS
> IDR registers.
> 
> SPI interrupt state and routing are managed through GICv5
> instructions.
> 
> Each core (PE in GICv5 terms) in a GICv5 system is identified with
> an Interrupt AFFinity ID (IAFFID).
> 
> An IRS manages a set of cores that are connected to it.
> 
> Firmware provides a topology description that the driver uses
> to detect to which IRS a CPU (ie an IAFFID) is associated with.
> 
> Use probeable information and firmware description to initialize
> the IRSes and implement GICv5 IRS SPIs support through an
> SPI-specific IRQ domain.
> 
> The GICv5 IRS driver:
> 
> - Probes IRSes in the system to detect SPI ranges
> - Associates an IRS with a set of cores connected to it
> - Adds an IRQchip structure for SPI handling
> 
> SPIs priority is set to a value corresponding to the lowest
> permissible priority in the system (taking into account the
> implemented priority bits of the IRS and CPU interface).
> 
> Since all IRQs are set to the same priority value, the value
> itself does not matter as long as it is a valid one.
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

