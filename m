Return-Path: <linux-pci+bounces-4528-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53FCD872350
	for <lists+linux-pci@lfdr.de>; Tue,  5 Mar 2024 16:57:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B3E82831AA
	for <lists+linux-pci@lfdr.de>; Tue,  5 Mar 2024 15:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F2E128826;
	Tue,  5 Mar 2024 15:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E9iaecWr"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47538664C;
	Tue,  5 Mar 2024 15:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709654183; cv=none; b=K7QoJ2Q3USUHIGLITG6pisNt8jmvFESii1TcKBTYA0ZI2e8lWCvOIV7S+UqRY4vS+Mb7K9Qfd3yJ2ZREsXJdjjvOBO6eBCnfTIdduCgkpmfD8uAG7MQ6edCR+IFdHt850vkLBPyLF/au1Kexks9OEY+cdJdrCJxhVkmjjz9Xi5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709654183; c=relaxed/simple;
	bh=TClW89l6zuf+ZEEfzpNJwf1HXErewjgkilp5hBFVwlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MzWIhXow5EqxYDNyzCSQ/fxf0dxgSKssTQhMHh5qQ4fFvWwVpOiFLmf5rV6ad8283c9bOQNVQ3hXFKK2pD9iARzAsnoyuTq0ZEObytI78iEWCmiaH17noCDeuN/YS0f0hL7KhKCNwNr1oqWGwZKZQAiivlRNAnMUA7hBxe+lS5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E9iaecWr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99030C43390;
	Tue,  5 Mar 2024 15:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709654183;
	bh=TClW89l6zuf+ZEEfzpNJwf1HXErewjgkilp5hBFVwlQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E9iaecWrG8888Xa6QliXWQjI4gzxwVPpEAUnQhxTiv+xeOcytlVxOSoajWtyZWipD
	 QbxgXwkV7craMvxf7+XJ5kdd3G8qTiQJuSrQ3Z52Dd7e2SfqUSHXtTB3WF+fmBVx4R
	 wyfK+8EWGYtI5ap1nhnQRkw35qjSeeuHSKgIW6SQPr9UOeB2bhmYCrIFOYOkyVBtv/
	 UkHYOBPIm7ICY0r2lI7wiCbM+CW1qM6NLEz2QAs8f2CS+WlhvOcLhP4UxWRJZ0wznh
	 +hTkEcKJFF+QdrfQmFNYNWX0+ZV1067JuFO0ERu82mVm/GyaCIpwUaeouHownGR4B3
	 SSvo60hm6yllQ==
Date: Tue, 5 Mar 2024 16:56:15 +0100
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: minda.chen@starfivetech.com, Conor Dooley <conor@kernel.org>,
	kw@linux.com, robh+dt@kernel.org, bhelgaas@google.com,
	tglx@linutronix.de, daire.mcnamara@microchip.com,
	emil.renner.berthing@canonical.com,
	krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-pci@vger.kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
	aou@eecs.berkeley.edu, p.zabel@pengutronix.de,
	mason.huo@starfivetech.com, leyfoon.tan@starfivetech.com,
	kevin.xie@starfivetech.com
Subject: Re: [PATCH v15,RESEND 22/23] PCI: starfive: Offload the NVMe timeout
 workaround to host drivers.
Message-ID: <ZedAn8IC+Mpm4Sqz@lpieralisi>
References: <ZeCd+xqE6x2ZFtJN@lpieralisi>
 <mhng-87e7ef5a-d60b-4057-960d-41bc901b6c7f@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-87e7ef5a-d60b-4057-960d-41bc901b6c7f@palmer-ri-x1c9>

On Mon, Mar 04, 2024 at 10:08:06AM -0800, Palmer Dabbelt wrote:
> On Thu, 29 Feb 2024 07:08:43 PST (-0800), lpieralisi@kernel.org wrote:
> > On Tue, Feb 27, 2024 at 06:35:21PM +0800, Minda Chen wrote:
> > > From: Kevin Xie <kevin.xie@starfivetech.com>
> > > 
> > > As the Starfive JH7110 hardware can't keep two inbound post write in
> > > order all the time, such as MSI messages and NVMe completions. If the
> > > NVMe completion update later than the MSI, an NVMe IRQ handle will miss.
> > 
> > Please explain what the problem is and what "NVMe completions" means
> > given that you are talking about posted writes.
> > 
> > If you have a link to an erratum write-up it would certainly help.
> 
> I think we really need to see that errata document.  Our formal memory model
> doesn't account for device interactions so it's possible there's just some
> arch fence we can make stronger in order to get things ordered again --
> we've had similar problems with some other RISC-V chips, and while it ends
> up being slow at least it's correct.
> 
> > This looks completely broken to me, if the controller can't guarantee
> > PCIe transactions ordering it is toast, there is not even a point
> > considering mainline merging.
> 
> I wouldn't be at all surprised if that's the case.  Without some concrete
> ISA mechanisms here we're sort of just stuck hoping the SOC vendors do the
> right thing, which is always terrifying.
> 
> I'm not really a PCIe person so this is all a bit vague, but IIRC we had a
> bunch of possible PCIe ordering violations in the SiFive memory system back
> when I was there and we never really got a scheme for making sure things
> were correct.
> 
> So I think we really do need to see that errata document to know what's
> possible here.  Folks have been able to come up with clever solutions to
> these problems before, maybe we'll get lucky again.
> 
> > > As a workaround, we will wait a while before going to the generic
> > > handle here.
> > > 
> > > Verified with NVMe SSD, USB SSD, R8169 NIC.
> > > The performance are stable and even higher after this patch.
> > 
> > I assume this is a joke even though it does not make me laugh.
> 
> So you're new to RISC-V, then?  It gets way worse than this ;)

To me this is just a PCI controller driver, arch does not matter.

What annoyed me is that we really can't state that this patch improves
performance, sorry, the patch itself is not acceptable, let's try
not to rub it in :)

Please post an erratum write-up and we shall see what can be done.

Thanks,
Lorenzo

> > Thanks,
> > Lorenzo
> > 
> > > 
> > > Signed-off-by: Kevin Xie <kevin.xie@starfivetech.com>
> > > Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> > > ---
> > >  drivers/pci/controller/plda/pcie-plda-host.c | 12 ++++++++++++
> > >  drivers/pci/controller/plda/pcie-plda.h      |  1 +
> > >  drivers/pci/controller/plda/pcie-starfive.c  |  1 +
> > >  3 files changed, 14 insertions(+)
> > > 
> > > diff --git a/drivers/pci/controller/plda/pcie-plda-host.c b/drivers/pci/controller/plda/pcie-plda-host.c
> > > index a18923d7cea6..9e077ddf45c0 100644
> > > --- a/drivers/pci/controller/plda/pcie-plda-host.c
> > > +++ b/drivers/pci/controller/plda/pcie-plda-host.c
> > > @@ -13,6 +13,7 @@
> > >  #include <linux/msi.h>
> > >  #include <linux/pci_regs.h>
> > >  #include <linux/pci-ecam.h>
> > > +#include <linux/delay.h>
> > > 
> > >  #include "pcie-plda.h"
> > > 
> > > @@ -44,6 +45,17 @@ static void plda_handle_msi(struct irq_desc *desc)
> > >  			       bridge_base_addr + ISTATUS_LOCAL);
> > >  		status = readl_relaxed(bridge_base_addr + ISTATUS_MSI);
> > >  		for_each_set_bit(bit, &status, msi->num_vectors) {
> > > +			/*
> > > +			 * As the Starfive JH7110 hardware can't keep two
> > > +			 * inbound post write in order all the time, such as
> > > +			 * MSI messages and NVMe completions.
> > > +			 * If the NVMe completion update later than the MSI,
> > > +			 * an NVMe IRQ handle will miss.
> > > +			 * As a workaround, we will wait a while before
> > > +			 * going to the generic handle here.
> > > +			 */
> > > +			if (port->msi_quirk_delay_us)
> > > +				udelay(port->msi_quirk_delay_us);
> > >  			ret = generic_handle_domain_irq(msi->dev_domain, bit);
> > >  			if (ret)
> > >  				dev_err_ratelimited(dev, "bad MSI IRQ %d\n",
> > > diff --git a/drivers/pci/controller/plda/pcie-plda.h b/drivers/pci/controller/plda/pcie-plda.h
> > > index 04e385758a2f..feccf285dfe8 100644
> > > --- a/drivers/pci/controller/plda/pcie-plda.h
> > > +++ b/drivers/pci/controller/plda/pcie-plda.h
> > > @@ -186,6 +186,7 @@ struct plda_pcie_rp {
> > >  	int msi_irq;
> > >  	int intx_irq;
> > >  	int num_events;
> > > +	u16 msi_quirk_delay_us;
> > >  };
> > > 
> > >  struct plda_event {
> > > diff --git a/drivers/pci/controller/plda/pcie-starfive.c b/drivers/pci/controller/plda/pcie-starfive.c
> > > index 9bb9f0e29565..5cfc30572b7f 100644
> > > --- a/drivers/pci/controller/plda/pcie-starfive.c
> > > +++ b/drivers/pci/controller/plda/pcie-starfive.c
> > > @@ -391,6 +391,7 @@ static int starfive_pcie_probe(struct platform_device *pdev)
> > > 
> > >  	plda->host_ops = &sf_host_ops;
> > >  	plda->num_events = PLDA_MAX_EVENT_NUM;
> > > +	plda->msi_quirk_delay_us = 1;
> > >  	/* mask doorbell event */
> > >  	plda->events_bitmap = GENMASK(PLDA_INT_EVENT_NUM - 1, 0)
> > >  			     & ~BIT(PLDA_AXI_DOORBELL)
> > > --
> > > 2.17.1
> > > 
> > > 
> > > _______________________________________________
> > > linux-riscv mailing list
> > > linux-riscv@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-riscv

