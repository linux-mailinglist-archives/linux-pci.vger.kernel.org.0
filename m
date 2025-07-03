Return-Path: <linux-pci+bounces-31433-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 142F4AF7D60
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 18:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CE056E20F1
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 16:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C768723BCFF;
	Thu,  3 Jul 2025 16:05:52 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A6519DF4A;
	Thu,  3 Jul 2025 16:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751558752; cv=none; b=Fei3I0czqZTy8dXdsCvcpsepKw2MPdp44sdQrEq2WN5KtQ47JU80fWas+po1t5GXBh6XGh59e0Jy7SNtGmKqCCFAsz0AJ3O0+GD3IGYZyW2fPfr+hpXiVKwb99lWcI5fqHrZA1WRFrtPgv+lLKgx9CDeRtwo2H5tgM1YfxxlbJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751558752; c=relaxed/simple;
	bh=gq13bkVgEDHQaL4AfK3ngM9wIiVgm6BrireYJS0Gp5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mE9IOqC7D8LO+NT+1byLKBANuQX9voebUNAqiAiQvQhOzKS4/AiPQABaqN0ZZVEGRtPcDESckC81U17J33u9LWU4/Mp/VQooxbezniRdMFESBDbLHI4P5OHY6trP0SvchIMh5fMrv0DsAjyUfeTua7rtE3mMbtH5xSGXy3a+/QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02BF1C4CEE3;
	Thu,  3 Jul 2025 16:05:48 +0000 (UTC)
Date: Thu, 3 Jul 2025 17:05:46 +0100
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
Subject: Re: [PATCH v7 20/31] irqchip/gic-v5: Add GICv5 PPI support
Message-ID: <aGaqWooC6Q_HYbDL@arm.com>
References: <20250703-gicv5-host-v7-0-12e71f1b3528@kernel.org>
 <20250703-gicv5-host-v7-20-12e71f1b3528@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703-gicv5-host-v7-20-12e71f1b3528@kernel.org>

On Thu, Jul 03, 2025 at 12:25:10PM +0200, Lorenzo Pieralisi wrote:
> The GICv5 CPU interface implements support for PE-Private Peripheral
> Interrupts (PPI), that are handled (enabled/prioritized/delivered)
> entirely within the CPU interface hardware.
> 
> To enable PPI interrupts, implement the baseline GICv5 host kernel
> driver infrastructure required to handle interrupts on a GICv5 system.
> 
> Add the exception handling code path and definitions for GICv5
> instructions.
> 
> Add GICv5 PPI handling code as a specific IRQ domain to:
> 
> - Set-up PPI priority
> - Manage PPI configuration and state
> - Manage IRQ flow handler
> - IRQs allocation/free
> - Hook-up a PPI specific IRQchip to provide the relevant methods
> 
> PPI IRQ priority is chosen as the minimum allowed priority by the
> system design (after probing the number of priority bits implemented
> by the CPU interface).
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

