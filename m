Return-Path: <linux-pci+bounces-8379-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 883DF8FDEAD
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jun 2024 08:26:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD1F41C223BE
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jun 2024 06:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F43745E1;
	Thu,  6 Jun 2024 06:25:57 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B877273537;
	Thu,  6 Jun 2024 06:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717655157; cv=none; b=Y/4K5PalMFAeif6NpRvL0jKPFXViPcLeVBGsahSk1iI+PzYaIFXxp0WUdzHgW+Xt/lh9/JuIhgZClA7FGw0ImRtlXg0Y6lKTrEHfIZh6YMup4G50v6bNPCqDvBt8d4b2czbZLPCAGa8IoilZ32uFfJa+J0frSW+OV8eCPyYSS6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717655157; c=relaxed/simple;
	bh=fUMpR2seN1mrKu7VsMhqq95JP3CQ+LxDFtWLQHh/jpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RcATTHj7hjH0Rq2GEsUJeXevLvP0xazXVmJFQUU5WHPzwNbMf3MIk81sbYla7RQVhDM6XQHxDsgKuumAfzEmlH4UACJ6zXtTY3M1sfw9Izguh59tgI+yieYi0bMNauKUmg1sOenKxazzWi8mbsWQwXWOgjtfSp+Oo8ka28lcklw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB9B8C3277B;
	Thu,  6 Jun 2024 06:25:50 +0000 (UTC)
Date: Thu, 6 Jun 2024 11:55:38 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Damien Le Moal <dlemoal@kernel.org>,
	Jon Lin <jon.lin@rock-chips.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Simon Xue <xxm@rock-chips.com>, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v4 03/13] dt-bindings: PCI: snps,dw-pcie-ep: Add
 tx_int{a,b,c,d} legacy irqs
Message-ID: <20240606062538.GA4441@thinkpad>
References: <20240529-rockchip-pcie-ep-v1-v4-0-3dc00fe21a78@kernel.org>
 <20240529-rockchip-pcie-ep-v1-v4-3-3dc00fe21a78@kernel.org>
 <20240605073402.GE5085@thinkpad>
 <ZmCQak-m7RWRxiix@ryzen.lan>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZmCQak-m7RWRxiix@ryzen.lan>

On Wed, Jun 05, 2024 at 06:20:58PM +0200, Niklas Cassel wrote:
> On Wed, Jun 05, 2024 at 01:04:02PM +0530, Manivannan Sadhasivam wrote:
> > On Wed, May 29, 2024 at 10:28:57AM +0200, Niklas Cassel wrote:
> > > The DWC core has four interrupt signals: tx_inta, tx_intb, tx_intc, tx_intd
> > > that are triggered when the PCIe controller (when running in Endpoint mode)
> > > has sent an Assert_INTA Message to the upstream device.
> > >
> > > Some DWC controllers have these interrupt in a combined interrupt signal.
> > >
> > > Add the description of these interrupts to the device tree binding.
> > >
> > > Signed-off-by: Niklas Cassel <cassel@kernel.org>
> >
> > Nit: We recently changed the driver instances of 'LEGACY' to 'INTX'. But the
> > binding it still using 'legacy'. Considering that the 'legacy' IRQ added to the
> > RC binding recently (ebce9f6623a7), should we rename it?
> >
> > This will force the driver to support both 'legacy' and 'intx' for backwards
> > compatibility.
> 
> I don't think this is true.
> 
> 
> Look at snps,dw-pcie.yaml in 6.10-rc2:
> 
> The individual interrupts are called:
>             Legacy A/B/C/D interrupt signal. Basically it's triggered by
>             receiving a Assert_INT{A,B,C,D}/Desassert_INT{A,B,C,D} message
>             from the downstream device.
>           pattern: "^int(a|b|c|d)$"
> 
> The combined interrupt is called:
>             Combined Legacy A/B/C/D interrupt signal. See "^int(a|b|c|d)$" for
>             details.
>           const: legacy
> 
> So you use 'inta', 'intb', 'intc', 'intd' if your SoC has a dedicated
> interrupt line for each of these irqs.
> 
> If the SoC simply has a single combined interrupt line for these irqs,
> then you use 'legacy'
> 
> 
> This patch simply adds:
> 'tx_inta', 'tx_intb', 'tx_intc', 'tx_intd' as individual interrupts
> and the combined interrupt 'legacy' to snps,dw-pcie-ep.yaml.
> 
> 
> Patch ebce9f6623a7 simply allowed the combined interrupt line 'legacy'
> to be used by the rockchip-dw-pcie.yaml binding.
> This is because the way that device tree is designed. You need to specify
> something both in the generic binding (which specifies everything),
> and in the glue driver binding, to specify the subset that is allowed by
> the glue driver.
> 
> 
> Since a controller cannot run in both EP and RC mode at the same time,
> I think that it is fine that this patch reuses the name 'legacy' for the
> combined interrupt.
> 
> And as you can see in patch 5 in this series, rk3588 actually uses a single
> combined IRQ (called legacy) for 'inta', 'intb', 'intc', 'intd', 'tx_inta',
> 'tx_intb', 'tx_intc', 'tx_intd'.
> 

I think you misunderstood what I was asking. I was just asking if we still want
to keep the term 'legacy' for INTx IRQs in DT binding or not, since we recently
got rid of that terminology in PCI drivers.

But if the rockchip TRM defines it as 'legacy' then it should be called as is in
the rockchip binding. But I don't think DWC Spec also defines it that way (I
haven't checked).

It is a question for Rob and Bjorn.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

