Return-Path: <linux-pci+bounces-27990-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B67DABC167
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 16:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9239189C016
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 14:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C165283C98;
	Mon, 19 May 2025 14:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VejgUR+u"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43EC83F9D2;
	Mon, 19 May 2025 14:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747666599; cv=none; b=q075+ewzlHoM+jilVKVE/sq+Ja/AIzLoVdhVHmYdUSsPiV1h03R0/8lb/xFkgbm7KT7N1KguSzPunH8XAN58tIGEBFyqmVYE7LqKFyLp46WrjjixZ0lHWIwovZTEw1f8wOMvEg5CBhnCdvayYOBxRsEsNT3u+7Yiz/jrRKUfsnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747666599; c=relaxed/simple;
	bh=VqVcyBcLvJ3XKzYTUem4M4JK5wb/lLMvsSEEglbdi6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iXrVxCNGjq1R65WP18u+KkHzEK2gtpk7Q5qMLoiq46fW6U0ne9oRajBt5LxHHiIspjLr9XSHfroFBOUpga3C7XGNujoCFli8tLmfc75j15chK0mEFCeA9gzlT/UBVPZtOwTUBPte764LI4iTx/91hsDVCFn2LDslACEMbZb5iAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VejgUR+u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CEC3C4CEE4;
	Mon, 19 May 2025 14:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747666598;
	bh=VqVcyBcLvJ3XKzYTUem4M4JK5wb/lLMvsSEEglbdi6k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VejgUR+upstLQpSH2qQH+28Hmp4bnr7H2WWDypDXX/cPC47TPmkM3LsCEEm1CzN8q
	 CMPOfcTRmzK4cfb5nsVAPPZkzhPORcHp66tTL46LRqciVp0F13cWdc8UJp1Rw3zOT6
	 4vVRwjXaBTU5solG7YjWkVVZxNyBInDUISp4NBtmAmQrnLTu7InWvN1/hhTxRDJM/T
	 elPMYrD4cxeD56V21xqo/I34j0lIiJ8zEJptDM92a3da6Rkkv6/ueCKRNH/r5iQtp8
	 jv/LunreWt/TaZbVLVTSK2ytU8CGHV2o8x75t+boFCKbzIPECJjYirBGYJRdybDuwB
	 7tZOMkgAo+FDA==
Date: Mon, 19 May 2025 09:56:36 -0500
From: Rob Herring <robh@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Abraham I <kishon@kernel.org>,
	dlemoal@kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: PCI: pci-ep: Add ref-clk-mode
Message-ID: <20250519145636.GA2090206-robh@kernel.org>
References: <20250425092012.95418-2-cassel@kernel.org>
 <7xtp5i3jhntfev35uotcunur3qvcgq4vmcnkjde5eivajdbiqt@n2wsivrsr2dk>
 <aBHOaJFgZiOfTrrT@ryzen>
 <dxgs3wuekwjh6f22ftkmi7dcw7xpw3fa7lm74fwm5thvol42z3@wuovkynp3jey>
 <20250509181827.GA3879057-robh@kernel.org>
 <a7rfa6rlygbe7u3nbxrdc3doln7rk37ataxjrutb2lunctbpuo@72jnf6odl5xp>
 <aB8ysBuQysAR-Zcp@ryzen>
 <20250512135909.GA3177343-robh@kernel.org>
 <aCOAmQNWUWU55VKT@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCOAmQNWUWU55VKT@ryzen>

On Tue, May 13, 2025 at 07:25:45PM +0200, Niklas Cassel wrote:
> On Mon, May 12, 2025 at 08:59:09AM -0500, Rob Herring wrote:
> > > 
> > > This patch adds a refclk-mode property to an endpoint side DT binding.
> > 
> > If we are dealing with the same property of the link, it doesn't matter 
> > which side. What we don't need is 2 different solutions.
> 
> It is not really a property of the link though.
> 
> The RC could be running with a Separate Reference clock without spread
> spectrum clocking (SSC), while the EP could be running with a Separate
> Reference clock with SSC.
> 
> The link would still be classified as SRIS, even though only one end of
> the link is using SSC.

In the SSC cases, that's only relevant to the end you need to enable SSC 
or not, right? IOW, whether the RC is using SSC or not is irrelevant to 
the EP. And for the end with SSC, that's only if 

There's also this discussion[1] about common SSC handling. In general, 
it seems ON/OFF is not sufficient for configuring spread-spectrum.

> 
> So AFAICT there cannot be property "per link".

Fair enough.

I think we're mixing SSC and clock sources which are mostly independent 
things to describe. SSC is configuration on top of what the clocking 
topology looks like.

For clock sources, the clock can come from the slot or locally. For 
locally, that could be internal to the SoC or some source on the board. 
Does it make sense to describe this with the clock binding? 

Let's assume we define a 'clocks' entry to represent the PCIe clock. We 
could define no clock to mean 'using the slot clock'. Anything else is a 
local clock source which is where it gets interesting. There's probably 
all sorts of ways that can look between the PCIe controller, PHY, and 
board level components. Given the variability there, using the clock 
binding is probably the right thing to do. 

Then if we have a clock defined and figure out the common 
spread-spectrum handling for the clock binding, you would have 
everything you need.


> > > This property is needed such that the endpoint can configure the bits
> > > in its own PCIe Link Control Register before starting the link.
> > > 
> > > Perhaps the host side could also make use of a similar property, but I'm not
> > > sure, you don't know from the host side which endpoint will be plugged in.
> > > 
> > > >From the EP side, you do know if your SoC only supports common-clock or
> > > SRNS/SRIS, since that depends on if the board can source the clock from
> > > the PCIe slot or not (of all the DWC based drivers, only Qcom and Tegra
> > > can do so, rest uses SRNS/SRIS), so this property definitely makes sense
> > > in an EP side DT binding.
> > 
> > I don't understand why we need this in DT in the first place. Seems like 
> > needing to specify this breaks discoverability? Perhaps this information 
> > is only relevant after initial link is up and the host can read the EP 
> > registers?
> 
> If we take the RK3588 SoC as an example, per the TRM, the SoC supports both
> SRNS and Common Clock. However, on the Rock 5b board (which uses the RK3588
> SoC), the refclock when running is EP mode can only be sourced from the
> clock generator on the board itself (Separate Reference clock), it is not
> possible to source the refclock from the PCIe slot itself (Common Clock).
> 
> However, this is a design limitation of the board, not of the SoC.
> 
> E.g. Rockchip might have a development board that uses the RK3588 SoC,
> which allows you select where to source the clock from using a mux, either
> from the PCIe slot, or from the on board clock generator.
> 
> Some development boards I have seen have a DIP switch on the board that
> allows you to select if you want to source the clock from the PCIe slot or
> not. However, not all boards have this nice feature.
> 
> And even if you do have a DIP switch for that, and a GPIO which you can
> read the DIP switch value from, when running in Separate Reference clock
> mode, you can either run with or without SSC (i.e. SRNS mode or SRIS mode).
> 
> When running in SRIS mode, to enable SSC, we need to write registers both
> in the PHY and in the controller, before even starting link training.
> 
> I do realize that, for boards supporting more than a single mode (Common
> Clock/SRNS/SRIS), this device tree property is basically a configuration
> option. For boards only supporting a single mode, it is actually describing
> the hardware.

Okay, I understand now and agree it is needed. Even a DIP switch isn't 
too helpful. The meaning of each state is board specific and not 
discoverable, so we're not going to have that in the kernel. You'd need 
some board specific code in firmware to set some a common DT 
property (because requiring users to set a DT property based on some 
DIP switch isn't very user friendly), or the DIP switch has to be set 
one way and users have to read that bit of documentation.

> E.g. Rock 5b can run in both SRNS and SRIS mode (Common Clock is not
> supported), and since this has to be configured before starting the link,
> I cannot think of a better way to control this than a device tree property.
> 
> In my specific case, I will also need to add a SSC property to the PCIe PHY
> DT binding, to control if SSC should be enabled or not (needed when running
> in SRIS mode).
> 
> Sure, perhaps it could be possible to use phy_set_mode() from the PCIe
> controller driver or similar, that conveys this information to the PHY
> driver... But with all the possible PCI bifurcation DT properties that
> already exist in the PCIe PHY DT binding, I'm not sure if making use of
> phy_set_mode() is feasible, or if I will be forced to add a property to the
> PCIe PHY DT binding.

Don't let kernel implementation define the binding. As long as the 
information is in DT, the kernel can extract that and provide it to 
whatever components need it.

Rob

[1] https://github.com/devicetree-org/dt-schema/pull/154

