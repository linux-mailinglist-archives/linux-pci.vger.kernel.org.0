Return-Path: <linux-pci+bounces-8339-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D208FD2D2
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2024 18:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F3AA281670
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2024 16:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBFC3154BEF;
	Wed,  5 Jun 2024 16:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nHle5QaI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A8E1527B5;
	Wed,  5 Jun 2024 16:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717604465; cv=none; b=hUH/uezYXHkhcA7rkC1JDWxI7VIIUCpLCpTEBGXDUQr+acLEYTLUg6OlnUflobT/Jz2lyGBk4A/G+uk27FEyYCM4THcunMBymlKl7PraWtk+I0bU+NJXqblzifLium1bdLDi0VU0rgPWjw1EfLrPkvoFonuVjud5drfY8FXuN0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717604465; c=relaxed/simple;
	bh=zwJLTD2CKFW1aLoNhdS/VADNNg91H/7mXSDG6BYpASc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L8Y5rIAXULzlCh6Ir4tVvmq49p30KSMw+Cgtkfo+Gw2blrgX2PHUxF8ZND82nM48+6vK9WNQ8NbR2hdxsD6Ev7NoXpg6/g5uVFO78tjYkOwV2f3nsOy6HHvrIo0SoOZDINUJF8Wq5D0SmrHoXSZTu7fY+DXchlXCvxUJdumGzdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nHle5QaI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 097BEC2BD11;
	Wed,  5 Jun 2024 16:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717604465;
	bh=zwJLTD2CKFW1aLoNhdS/VADNNg91H/7mXSDG6BYpASc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nHle5QaIojs18EAkRzbzPcpPdxDMyMsptm3kn7DPZshaQd5LiM98xXr37vclVhzT1
	 HhUDJCM+LOS0kzUVm1516MB8mmM0Wz+29V4sqdUP8RsyDJiGIa+oQ+P+W+PxyQMCwx
	 Di8iGQNHbQSq0KonbpDpJGdqWwDGfy/SZx8BKgKyAlEb0DuM27+UprXzSQ0VflT4gv
	 SuVBgwSnAmA3u/9v5+AhT5HMaqB/rn0gsZ/bU0kNh8YrXA0TdDaA/RS7LPZQ3JjwSv
	 euEHxEPH8Uwcp3cIrjZtoUyUTMD9Q6X5dHKvM36nKJVDXWJlbQjxcd/8DZUGQK0RJ7
	 K+lxFtUvAUxmQ==
Date: Wed, 5 Jun 2024 18:20:58 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
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
Message-ID: <ZmCQak-m7RWRxiix@ryzen.lan>
References: <20240529-rockchip-pcie-ep-v1-v4-0-3dc00fe21a78@kernel.org>
 <20240529-rockchip-pcie-ep-v1-v4-3-3dc00fe21a78@kernel.org>
 <20240605073402.GE5085@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240605073402.GE5085@thinkpad>

On Wed, Jun 05, 2024 at 01:04:02PM +0530, Manivannan Sadhasivam wrote:
> On Wed, May 29, 2024 at 10:28:57AM +0200, Niklas Cassel wrote:
> > The DWC core has four interrupt signals: tx_inta, tx_intb, tx_intc, tx_intd
> > that are triggered when the PCIe controller (when running in Endpoint mode)
> > has sent an Assert_INTA Message to the upstream device.
> >
> > Some DWC controllers have these interrupt in a combined interrupt signal.
> >
> > Add the description of these interrupts to the device tree binding.
> >
> > Signed-off-by: Niklas Cassel <cassel@kernel.org>
>
> Nit: We recently changed the driver instances of 'LEGACY' to 'INTX'. But the
> binding it still using 'legacy'. Considering that the 'legacy' IRQ added to the
> RC binding recently (ebce9f6623a7), should we rename it?
>
> This will force the driver to support both 'legacy' and 'intx' for backwards
> compatibility.

I don't think this is true.


Look at snps,dw-pcie.yaml in 6.10-rc2:

The individual interrupts are called:
            Legacy A/B/C/D interrupt signal. Basically it's triggered by
            receiving a Assert_INT{A,B,C,D}/Desassert_INT{A,B,C,D} message
            from the downstream device.
          pattern: "^int(a|b|c|d)$"

The combined interrupt is called:
            Combined Legacy A/B/C/D interrupt signal. See "^int(a|b|c|d)$" for
            details.
          const: legacy

So you use 'inta', 'intb', 'intc', 'intd' if your SoC has a dedicated
interrupt line for each of these irqs.

If the SoC simply has a single combined interrupt line for these irqs,
then you use 'legacy'


This patch simply adds:
'tx_inta', 'tx_intb', 'tx_intc', 'tx_intd' as individual interrupts
and the combined interrupt 'legacy' to snps,dw-pcie-ep.yaml.


Patch ebce9f6623a7 simply allowed the combined interrupt line 'legacy'
to be used by the rockchip-dw-pcie.yaml binding.
This is because the way that device tree is designed. You need to specify
something both in the generic binding (which specifies everything),
and in the glue driver binding, to specify the subset that is allowed by
the glue driver.


Since a controller cannot run in both EP and RC mode at the same time,
I think that it is fine that this patch reuses the name 'legacy' for the
combined interrupt.

And as you can see in patch 5 in this series, rk3588 actually uses a single
combined IRQ (called legacy) for 'inta', 'intb', 'intc', 'intd', 'tx_inta',
'tx_intb', 'tx_intc', 'tx_intd'.


Kind regards,
Niklas


>
> But irrespective of that,
>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>
> - Mani
>
> > Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> > ---
> >  Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
> > index f5f12cbc2cb3..f474b9e3fc7e 100644
> > --- a/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
> > +++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
> > @@ -151,6 +151,15 @@ properties:
> >              Application-specific IRQ raised depending on the vendor-specific
> >              events basis.
> >            const: app
> > +        - description:
> > +            Interrupts triggered when the controller itself (in Endpoint mode)
> > +            has sent an Assert_INT{A,B,C,D}/Desassert_INT{A,B,C,D} message to
> > +            the upstream device.
> > +          pattern: "^tx_int(a|b|c|d)$"
> > +        - description:
> > +            Combined interrupt signal raised when the controller has sent an
> > +            Assert_INT{A,B,C,D} message. See "^tx_int(a|b|c|d)$" for details.
> > +          const: legacy
> >          - description:
> >              Vendor-specific IRQ names. Consider using the generic names above
> >              for new bindings.
> >
> > --
> > 2.45.1
> >
>
> --
> மணிவண்ணன் சதாசிவம்

