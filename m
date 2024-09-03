Return-Path: <linux-pci+bounces-12680-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1711696A547
	for <lists+linux-pci@lfdr.de>; Tue,  3 Sep 2024 19:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A928B214F5
	for <lists+linux-pci@lfdr.de>; Tue,  3 Sep 2024 17:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB31E18890A;
	Tue,  3 Sep 2024 17:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MzyyugKc"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828C43C092;
	Tue,  3 Sep 2024 17:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725383866; cv=none; b=bXuq3UWr1W29P9hk7XTRl0XhcbpllFGrF1H4ndIV3zFsaUvVsMX1Qgz9NXpfokLkBiSfPTmVKLNuo07SvzTjA1hDLDGhBX/QxmYwPZS1rwi72GALHxTLC7s3tjT53DFSym6Ztl/rtd5h13SqCSxCZjCUyC4UvUHZxgO1GL/sTyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725383866; c=relaxed/simple;
	bh=MNR8RLx4Vsu7p3+DVMYZuUkv4rATd9Di0StxoIN+wDw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=dDszAKfCqchnJ53yDmvwZA3QawbC27KMuZmVwUtaYskEwl/al1FNJhl6ZFwOHG0XgMbw9l0Qt9Kxjqkm6+Ua+ksEBH/AVku9wWBaTLGrBj07BpbEYbaC2zxmH4cDcvjJW7Gi7wPyroD+oqPERWVa560wBsgBU0ZnzMR8A6dqrGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MzyyugKc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A29DEC4CEC4;
	Tue,  3 Sep 2024 17:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725383866;
	bh=MNR8RLx4Vsu7p3+DVMYZuUkv4rATd9Di0StxoIN+wDw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=MzyyugKcCRC/cUB3wB5lEFnNbZIBGyUAFdoCmpVJ/rklZK0FWwDpEmKPWEMmH/34B
	 ni/Jfuiq/+Nue1I9H7VKo1JxLz0MEUGsucqAd1WRyx07oGsOJYAWpR9T5ee7+W8Ml6
	 o1M2jtooI+P1a1iTsl+wHpdCeUdp59RuRiO6CPvL7ndAGRei0lNjIZirlJgEI11u0w
	 VE0JuQmftsvUn6ETFKCr9XjVqJN4CgtJxm6WVcSvg6fEDvaXCq2hX1mo28Ylv6NogB
	 rjmmKpFZf+pGkajon5ERiE3D6AfyNBWOV4xZ7o0rz5Q5Lq6fnxl452MQiircuPvcQ7
	 LE3qih4U1Zu/A==
Date: Tue, 3 Sep 2024 12:17:43 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc: Jim Quinlan <james.quinlan@broadcom.com>, linux-pci@vger.kernel.org,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Cyril Brulebois <kibi@debian.org>,
	Stanimir Varbanov <svarbanov@suse.de>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 05/13] PCI: brcmstb: Use bridge reset if available
Message-ID: <20240903171743.GA255170@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240903144613.GC1403301@rocinante>

On Tue, Sep 03, 2024 at 11:46:13PM +0900, Krzysztof Wilczyński wrote:
> Hello,
> 
> [...]
> > > >  static void brcm_pcie_bridge_sw_init_set_generic(struct brcm_pcie *pcie, u32 val)
> > > >  {
> > > > -     u32 tmp, mask =  RGR1_SW_INIT_1_INIT_GENERIC_MASK;
> > > > -     u32 shift = RGR1_SW_INIT_1_INIT_GENERIC_SHIFT;
> > > > +     if (val)
> > > > +             reset_control_assert(pcie->bridge_reset);
> > > > +     else
> > > > +             reset_control_deassert(pcie->bridge_reset);
> > > >
> > > > -     tmp = readl(pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
> > > > -     tmp = (tmp & ~mask) | ((val << shift) & mask);
> > > > -     writel(tmp, pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
> > > > +     if (!pcie->bridge_reset) {
> > > > +             u32 tmp, mask =  RGR1_SW_INIT_1_INIT_GENERIC_MASK;
> > > > +             u32 shift = RGR1_SW_INIT_1_INIT_GENERIC_SHIFT;
> > > > +
> > > > +             tmp = readl(pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
> > > > +             tmp = (tmp & ~mask) | ((val << shift) & mask);
> > > > +             writel(tmp, pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
> > > > +     }
> > >
> > > This pattern looks goofy:
> > >
> > >   reset_control_assert(pcie->bridge_reset);
> > >   if (!pcie->bridge_reset) {
> > >     ...
> > >
> > > If we're going to test pcie->bridge_reset at all, it should be first
> > > so it's obvious what's going on and the reader doesn't have to go
> > > verify that reset_control_assert() ignores and returns success for a
> > > NULL pointer:
> > >
> > >   if (pcie->bridge_reset) {
> > >     if (val)
> > >       reset_control_assert(pcie->bridge_reset);
> > >     else
> > >       reset_control_deassert(pcie->bridge_reset);
> > >
> > >     return;
> > >   }
> > >
> > >   u32 tmp, mask =  RGR1_SW_INIT_1_INIT_GENERIC_MASK;
> > >   ...
> > >
> > Will do.
> [...]
> 
> You will do what?  If you don't mind me asking.

Can you just do the rework on the branch, Krzysztof?  I think that
will be easier/quicker than having Jim repost the entire series.

Bjorn

