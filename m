Return-Path: <linux-pci+bounces-7206-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A078BF335
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2024 02:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5AE01C217D2
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2024 00:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB0A137920;
	Tue,  7 May 2024 23:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qYzlUkuP"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261D17E112;
	Tue,  7 May 2024 23:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715125869; cv=none; b=BbbZqYvUZEF6re2J1tlQVeu/jYwrm9aFGyR3OhaAZRk/1GaPi+7KbenL1i9UtRCiR0IzE9Mko78XB0nG7qp0zkVlj3GCkU/FSbc/z97j8066rJmeKSJohpYyIHFBacGel1G6hMMCKkae+BXwqhpH6wfIkx1DuXIfaNgUOG7pI5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715125869; c=relaxed/simple;
	bh=nBkak3DvBc1FaTh/QK5dcoo1obeQ+aUlzl90N+QxZ3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HaPUwjR2NopyP83CKy6b+CL+G0TVGJu41gYEoJ+eugOPyynxmQALkpW0NgQTsni6/PxVlZN8eoo9ymB1jbwfLiNDWFEoVuXZ7fU+WIG4eL2DHr1CX/IWH0ccLXwHpSnXKP6lbhj351FWy4w6V2lIvxxOZ6xU1HUB0VUE1Tydz/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qYzlUkuP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44E07C2BBFC;
	Tue,  7 May 2024 23:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715125869;
	bh=nBkak3DvBc1FaTh/QK5dcoo1obeQ+aUlzl90N+QxZ3U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qYzlUkuPTXD/MSt+31ZNZCHjvIWMkvXz4qF5M5kBUYJriZ9Q76IbXYcZqGUTvSCyF
	 Ve6WQOleRQ+1gdzwXUe6KOEEqqUtDS+2sCURg8l4Ei0VsKBK6gLX8Py9DqoD3DTl2L
	 K6CaHhRVUVkLxhKHoSfpL6gnkHOLpLrF8rUJQmRtViCFANPF9qp2vjopFw3fOcdqjf
	 7sC4N4lwbXy04W5b2XbbacsqXw8+SkL7k7XrDHfcQPm33dLbCX/UlHkm4TyoUPhVs8
	 KeTXo95TliZij7wGhTHEdfnzlLCkpi+WfV4qxcorM+Ccmi+I2CsxDqhPzrnYTA3VHh
	 Ud7IteUsYMujw==
Date: Wed, 8 May 2024 01:51:02 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
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
Subject: Re: [PATCH v2 13/14] arm64: dts: rockchip: Add PCIe endpoint mode
 support
Message-ID: <Zjq-Zto5KlOvm8Sj@ryzen.lan>
References: <20240430-rockchip-pcie-ep-v1-v2-0-a0f5ee2a77b6@kernel.org>
 <20240430-rockchip-pcie-ep-v1-v2-13-a0f5ee2a77b6@kernel.org>
 <20240504173420.GJ4315@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240504173420.GJ4315@thinkpad>

Hello Mani,

On Sat, May 04, 2024 at 11:04:20PM +0530, Manivannan Sadhasivam wrote:
> On Tue, Apr 30, 2024 at 02:01:10PM +0200, Niklas Cassel wrote:
> > Add a device tree node representing PCIe endpoint mode.
> > 
> > The controller can either be configured to run in Root Complex or Endpoint
> > node.
> > 
> > If a user wants to run the controller in endpoint mode, the user has to
> > disable the pcie3x4 node and enable the pcie3x4_ep node.
> > 
> > Signed-off-by: Niklas Cassel <cassel@kernel.org>
> > ---
> >  arch/arm64/boot/dts/rockchip/rk3588.dtsi | 35 ++++++++++++++++++++++++++++++++
> >  1 file changed, 35 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3588.dtsi b/arch/arm64/boot/dts/rockchip/rk3588.dtsi
> > index 5519c1430cb7..09a06e8c43b7 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3588.dtsi
> > +++ b/arch/arm64/boot/dts/rockchip/rk3588.dtsi
> > @@ -136,6 +136,41 @@ pcie3x4_intc: legacy-interrupt-controller {
> >  		};
> >  	};
> >  
> > +	pcie3x4_ep: pcie-ep@fe150000 {
> > +		compatible = "rockchip,rk3588-pcie-ep";
> > +		clocks = <&cru ACLK_PCIE_4L_MSTR>, <&cru ACLK_PCIE_4L_SLV>,
> > +			 <&cru ACLK_PCIE_4L_DBI>, <&cru PCLK_PCIE_4L>,
> > +			 <&cru CLK_PCIE_AUX0>, <&cru CLK_PCIE4L_PIPE>;
> > +		clock-names = "aclk_mst", "aclk_slv",
> > +			      "aclk_dbi", "pclk",
> > +			      "aux", "pipe";
> > +		interrupts = <GIC_SPI 263 IRQ_TYPE_LEVEL_HIGH 0>,
> > +			     <GIC_SPI 262 IRQ_TYPE_LEVEL_HIGH 0>,
> > +			     <GIC_SPI 261 IRQ_TYPE_LEVEL_HIGH 0>,
> > +			     <GIC_SPI 260 IRQ_TYPE_LEVEL_HIGH 0>,
> > +			     <GIC_SPI 259 IRQ_TYPE_LEVEL_HIGH 0>,
> > +			     <GIC_SPI 271 IRQ_TYPE_LEVEL_HIGH 0>,
> > +			     <GIC_SPI 272 IRQ_TYPE_LEVEL_HIGH 0>,
> > +			     <GIC_SPI 269 IRQ_TYPE_LEVEL_HIGH 0>,
> > +			     <GIC_SPI 270 IRQ_TYPE_LEVEL_HIGH 0>;
> > +		interrupt-names = "sys", "pmc", "msg", "legacy", "err",
> > +				  "dma0", "dma1", "dma2", "dma3";
> > +		max-link-speed = <3>;
> > +		num-lanes = <4>;
> > +		phys = <&pcie30phy>;
> > +		phy-names = "pcie-phy";
> > +		power-domains = <&power RK3588_PD_PCIE>;
> > +		reg = <0xa 0x40000000 0x0 0x00100000>,
> > +		      <0xa 0x40100000 0x0 0x00100000>,
> > +		      <0x0 0xfe150000 0x0 0x00010000>,
> > +		      <0x9 0x00000000 0x0 0x40000000>,
> > +		      <0xa 0x40300000 0x0 0x00100000>;
> > +		reg-names = "dbi", "dbi2", "apb", "addr_space", "atu";
> 
> Isn't it common to define 'reg' property just below 'compatible'?

Looking at the result from:

$ git grep -A 4 "compatible = \"" Documentation/devicetree/bindings/pci/

Common, yes, but far from all examples in
Documentation/devicetree/bindings/pci/ do it that way.

The example in the yaml for this binding passes "make dt_binding_check".
If the device tree maintainers had a strong opinion on this, I would have
expected "make dt_binding_check" to emit a warning or error for this.

Additionally, the "pcie3x4" (RC-node) in rk3588.dtsi already use this same
ordering. I do think there is some value in keeping the ordering in "pcie3x4"
and "pcie3x4_ep" the same, so I will keep the ordering unless the device tree
maintainers start screaming at me :)


Kind regards,
Niklas

