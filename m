Return-Path: <linux-pci+bounces-31431-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53EE6AF7D8F
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 18:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B79E41CA6E66
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 16:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1422E2EE978;
	Thu,  3 Jul 2025 16:04:33 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80BF70823;
	Thu,  3 Jul 2025 16:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751558673; cv=none; b=eTT8F8KdIHhKFj1Ijh8ID23snptvyRFTu12Q/oieXqS1WFwY0NRD5C5cp3IHn/EAN3yz3ZyW12g1JfkcuQrgQPkcY8Uxiz0xlpBuo5z9A3fJCnNwg9cDxgkMG0K4wjFVfEMvytx+X6I08Jo+2JvxE9/cQyAtRFg4bbA7vRm7GnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751558673; c=relaxed/simple;
	bh=58aM0K/86rOEBlpZHaNUBM3QI7pc8TJva4aXr53+6X0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tr0TLXNAHcf4mXTqKb8zs+OaKU/g13uoMPG7Uwyna2701JdrTSy7920NxwVilzuC07E7z7LcJtXqz0h+nO/xXuHuz5s87nUkNERvNdLpeT/JiHHh+FyF2+Hf1qWZovV8AJ+UcaI1g/WsVh4vTh+sEM96XfoJeln16XteGPAK8Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17A1BC4CEEE;
	Thu,  3 Jul 2025 16:04:28 +0000 (UTC)
Date: Thu, 3 Jul 2025 17:04:26 +0100
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
Subject: Re: [PATCH v7 18/31] arm64: smp: Support non-SGIs for IPIs
Message-ID: <aGaqCofcXUxAdVAZ@arm.com>
References: <20250703-gicv5-host-v7-0-12e71f1b3528@kernel.org>
 <20250703-gicv5-host-v7-18-12e71f1b3528@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703-gicv5-host-v7-18-12e71f1b3528@kernel.org>

On Thu, Jul 03, 2025 at 12:25:08PM +0200, Lorenzo Pieralisi wrote:
> From: Marc Zyngier <maz@kernel.org>
> 
> The arm64 arch has relied so far on GIC architectural software
> generated interrupt (SGIs) to handle IPIs. Those are per-cpu
> software generated interrupts.
> 
> arm64 architecture code that allocates the IPIs virtual IRQs and
> IRQ descriptors was written accordingly.
> 
> On GICv5 systems, IPIs are implemented using LPIs that are not
> per-cpu interrupts - they are just normal routable IRQs.
> 
> Add arch code to set-up IPIs on systems where they are handled
> using normal routable IRQs.
> 
> For those systems, force the IRQ affinity (and make it immutable)
> to the cpu a given IRQ was assigned to.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> [timothy.hayes@arm.com: fixed ipi/irq conversion, irq flags]
> Signed-off-by: Timothy Hayes <timothy.hayes@arm.com>
> [lpieralisi: changed affinity set-up, log]
> Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

