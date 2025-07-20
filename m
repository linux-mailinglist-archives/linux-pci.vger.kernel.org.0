Return-Path: <linux-pci+bounces-32603-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F70B0B87D
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jul 2025 00:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1A4018983C5
	for <lists+linux-pci@lfdr.de>; Sun, 20 Jul 2025 22:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CADEF1EF397;
	Sun, 20 Jul 2025 22:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X4vBWyG5"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9650A1C32;
	Sun, 20 Jul 2025 22:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753050151; cv=none; b=jMAmEdRm1Ru385DY0ZY0nOnhSvbrgxZ+RPiWaYPF3ClbmwRu9y2KQM9sKUt1eDcpeOSKLNqGtK+H0zmNLsOubOLTjGuHAkkjICigL8udAEulmwH1hRclzwU3uBzBSjwvIswwFwoD00sbuoX20QTGaeQSdLHP12LfZc+BHHj3va8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753050151; c=relaxed/simple;
	bh=bM5zL7tOJogVkxC/dBJDYgKh+3nVk9kFwkbmG9c9IYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SNzkoRG8PHvLDkCZpzjz/6QCV+46cwLsBEd8HMYmdmzSXhrRgMQ7vBiivJVYttBbWXRIcfVhiqqqFfyYXf0qDg0iEtLtSuXkIgiTUBFoaaJVrZ3x2cZWId4YCD7imZlMeSSeeA+d+TwFy8Uk2EQimrS7j/MVGyBsWWXiU9zOty0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X4vBWyG5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49802C4CEE7;
	Sun, 20 Jul 2025 22:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753050151;
	bh=bM5zL7tOJogVkxC/dBJDYgKh+3nVk9kFwkbmG9c9IYc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X4vBWyG5vYZwDD4v2i65ZI4jQq15qc+dO83q2BtBhpT8khyJea2edi80gvwCjdceK
	 rVvzMuoo5dguYkK7l33e59cKcnmQnmwC3cLPs8NEx/EwhpPwlGjhlHU1f49uuSuaGw
	 Y9zyAoOUeZ4oruAML2zbIcz1nQwCmW530rt0I/Y7bZkT3y6/I8Q4Gw8Ax7SzTf2nRD
	 uoltJpkQZcGDywtPuKMPvKQZaryHCNXQNy1siQfPmiEypjDkTSFZna8idcQLfh64Wl
	 w7th2aSsgrAX6dzEtrww2rquC1AaugyP6S2V6tHsuk5SPMlPY1TBdVwom3UQ67WxNi
	 6p+5Yv/wbVEMA==
Date: Sun, 20 Jul 2025 17:22:30 -0500
From: Rob Herring <robh@kernel.org>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: "bhelgaas@google.com" <bhelgaas@google.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>,
	"mani@kernel.org" <mani@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"joel@jms.id.au" <joel@jms.id.au>,
	"andrew@codeconstruct.com.au" <andrew@codeconstruct.com.au>,
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>,
	"p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	BMC-SW <BMC-SW@aspeedtech.com>
Subject: Re: [PATCH v2 06/10] ARM: dts: aspeed-g6: Add PCIe RC node
Message-ID: <20250720222230.GA2842356-robh@kernel.org>
References: <20250715034320.2553837-1-jacky_chou@aspeedtech.com>
 <20250715034320.2553837-7-jacky_chou@aspeedtech.com>
 <CAL_JsqJ4yeYGAyCwHi=4CBurxGOc5oAqTQqun+5+Ps4hxwDU9Q@mail.gmail.com>
 <SEYPR06MB5134EB5D018F8518E88495FF9D56A@SEYPR06MB5134.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SEYPR06MB5134EB5D018F8518E88495FF9D56A@SEYPR06MB5134.apcprd06.prod.outlook.com>

On Wed, Jul 16, 2025 at 03:51:11AM +0000, Jacky Chou wrote:
> Hi Rob,
> 
> Thank you for your reply.
> 
> > >                                 quality = <100>;
> > >                         };
> > >
> > > +                       pcie_phy1: syscon@1e6ed200 {
> > > +                               compatible = "aspeed,pcie-phy",
> > "syscon";
> > > +                               reg = <0x1e6ed200 0x100>;
> > 
> > This looks like part of something else? It should be a child of that.
> > 
> > If this is the controls for the PCIe PHY, then use the PHY binding instead of your
> > own custom phandle property.
> > 
> 
> Our PCIe design has multiple functions. And the series of patches are submitted for
> PCIe RC. The other PCIe functions also use this phy node.
> I traced the PHY driver interface, it cannot meet our usage.

Why not?

There is also no requirement that using the DT PHY binding means you 
have to use the Linux PHY subsystem.

> Therefore, the RC driver uses the phandle property to configure.
> And this syscon also is used by the other PCIe functions.

Like what?

> > > +                       };
> > > +
> > > +                       pcie_cfg: syscon@1e770000 {
> > > +                               compatible = "aspeed,pcie-cfg",
> > "syscon";
> > > +                               reg = <0x1e770000 0x80>;
> > 
> > Looks like this is really part of the PCIe block as a h/w block isn't going to start
> > at offset 0xc0.
> > 
> > 
> 
> Actually.
> There are two PCIe bus in AST2600
> We use the other one PCIe to EP mode, here I call PCIe A.
> I call the pcie0 node as PCIe B.
> We do not provide PCIe A to RC mode for usage, just EP mode.
> But, when PCIe A is used as RC, it reg mapping is starting from 0x1e770080.
> I list there mapping.
> 
> 0x1e77_0000 ~ 0x1e77_007f : common usage
> 0x1e77_0080 ~ 0x1e77_00bf : PCIE A
> 0x1e77_00C0 ~ 0x1e77_00ff : PCIE B
> 
> So, it is why we create one node to describe common usage for PCIe A and B.
> And, why the pcie0 reg mapping is starting from 0x1e77_00c0.

In that case, maybe you need a common parent node with 2 child nodes for 
each bus.

Rob

> 
> > > +                       };
> > > +
> > > +                       pcie0: pcie@1e7700c0 {
> > > +                               compatible = "aspeed,ast2600-pcie";
> > > +                               device_type = "pci";
> > > +                               reg = <0x1e7700c0 0x40>;
> > > +                               linux,pci-domain = <0>;
> > 
> > No need for this. You only have 1 PCI host.
> > 
> 
> Agreed.
> We only provide one RC.
> 
> > > +                               #address-cells = <3>;
> > > +                               #size-cells = <2>;
> > > +                               interrupts = <GIC_SPI 168
> > IRQ_TYPE_LEVEL_HIGH>;
> > > +                               bus-range = <0x80 0xff>;
> > 
> > Does this h/w not support bus 0-0x7f for some reason?
> > 
> 
> List:
> PCIE A: 0-0x7f
> PCIE B: 0x80-0xff
> 
> It is our design on PCIe B to use bus-range 0x80-0xff.

That's a policy or h/w limitation?

Rob

