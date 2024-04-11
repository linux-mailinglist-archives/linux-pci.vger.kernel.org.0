Return-Path: <linux-pci+bounces-6130-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7768A1707
	for <lists+linux-pci@lfdr.de>; Thu, 11 Apr 2024 16:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AC0D1F22061
	for <lists+linux-pci@lfdr.de>; Thu, 11 Apr 2024 14:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CFA314F110;
	Thu, 11 Apr 2024 14:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FmnqtmXm"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2B914F100;
	Thu, 11 Apr 2024 14:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712845271; cv=none; b=K3mWneNr9+Hk5KLSLxdx22WsqBmDhzSqkvXa3NYvqqjz3bdiYzwrRDXParnKG/t6wJdkXy74SzBjg0oAEjll1IjhKvXhrerFU0YvdMFEB7W6aAZ3GQ78i1yM2G29QhxbXYWUMpzATxczrrIc/S6D5NrHgOzWcfLXM8XN/xMfi1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712845271; c=relaxed/simple;
	bh=RDt5jlNMS3ucSwKcH7tgpvFGKzTFvccMBgH0b+eayeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aVFa7a4W1PWrl+Pr4HGtwNMVimFU44ugZ6YMYZgLWhjD70EMPCOWCILrqPKlGqYcCoRTUUyDgHoeX2oiMTbXPPAEtIeZq0kWGYMGaSotvULdMLxzjiF3F/KuCWfbwJb8TJ6Ul1OqRxFhf6ucAS8IDYdN3CXekfuss9ThSpm+RVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FmnqtmXm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07DE0C2BD10;
	Thu, 11 Apr 2024 14:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712845270;
	bh=RDt5jlNMS3ucSwKcH7tgpvFGKzTFvccMBgH0b+eayeM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FmnqtmXmyodJdgHKHjF/o9qh0gQ3yPVudJEayUfxMetCRKixf7MadURZeFX5r6J9F
	 KZO4x26OQWLGTjpaYAKntJwCodgLP+aDt47OO2TKPR3PsJ4isKj268a8KfvYJVeiUA
	 xIhTuT3AZ/SJc2XgyX2Qg7zwimd9QfG4T/XfpBUGwOjo3qoholwNk1YikECUI0aeJ3
	 JKccakGSkbBD0N+gV6mcpbFZG4UhhKtCGsuBFNPpBXQ3yDfgtOIize3x3mLBOom0s0
	 clIRJHM0xExk3YKLWu8DH34d19gGTvnMgL6DQhTuO1wpS9k189rIpVZjfDsQEG42r9
	 nLPeassxXKhKg==
Date: Thu, 11 Apr 2024 09:21:07 -0500
From: Rob Herring <robh@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Sergio Paracuellos <sergio.paracuellos@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jim Quinlan <jim2101024@gmail.com>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Will Deacon <will@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Srikanth Thokala <srikanth.thokala@intel.com>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Heiko Stuebner <heiko@sntech.de>, Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bharat Kumar Gogada <bharat.kumar.gogada@amd.com>,
	Michal Simek <michal.simek@amd.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Mark Kettenis <kettenis@openbsd.org>,
	Tom Joseph <tjoseph@cadence.com>,
	Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2 2/4] dt-bindings: PCI: mediatek,mt7621: add missing
 child node reg
Message-ID: <20240411142107.GA3537062-robh@kernel.org>
References: <CAMhs-H82Ymc=isxu6AX4_s1QnNpSSNt74--ED1j7JxpzE=eCRg@mail.gmail.com>
 <20240411123917.GA2180141@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240411123917.GA2180141@bhelgaas>

On Thu, Apr 11, 2024 at 07:39:17AM -0500, Bjorn Helgaas wrote:
> On Thu, Apr 11, 2024 at 08:13:18AM +0200, Sergio Paracuellos wrote:
> > On Thu, Apr 11, 2024 at 8:01 AM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> > > On 10/04/2024 23:26, Bjorn Helgaas wrote:
> > > > On Wed, Apr 10, 2024 at 08:15:19PM +0200, Krzysztof Kozlowski wrote:
> > > >> MT7621 PCI host bridge has children which apparently are also PCI host
> > > >> bridges, at least that's what the binding suggest.
> > > >
> > > > What does it even mean for a PCI host bridge to have a child that is
> > > > also a PCI host bridge?

It should say 'root port' instead as the binding description correctly 
says.

> > > >
> > > > Does this mean a driver binds to the "parent" host bridge, enumerates
> > > > the PCI devices below it, and finds a "child" host bridge?
> > 
> > Yes, that is exactly what you can see on enumeration.
> > 
> > The following is a typical boot trace where all bridges has a device also below:
> > 
> > mt7621-pci 1e140000.pcie: host bridge /pcie@1e140000 ranges:
> > mt7621-pci 1e140000.pcie:   No bus range found for /pcie@1e140000, using [bus 00-ff]
> > mt7621-pci 1e140000.pcie:      MEM 0x0060000000..0x006fffffff -> 0x0060000000
> > mt7621-pci 1e140000.pcie:       IO 0x001e160000..0x001e16ffff -> 0x0000000000
> > mt7621-pci 1e140000.pcie: PCIE0 enabled
> > mt7621-pci 1e140000.pcie: PCIE1 enabled
> > mt7621-pci 1e140000.pcie: PCIE2 enabled
> > mt7621-pci 1e140000.pcie: PCI host bridge to bus 0000:00
> 
> 1e140000.pcie is a host bridge.  It has some CPU-specific bus on the
> upstream side, standard PCI (domain 0000, buses 00-ff) on the
> downstream side.
> 
> > pci 0000:00:00.0: [0e8d:0801] type 01 class 0x060400
> > pci 0000:00:01.0: [0e8d:0801] type 01 class 0x060400
> > pci 0000:00:02.0: [0e8d:0801] type 01 class 0x060400
> 
> > pci 0000:01:00.0: [1b21:0611] type 00 class 0x010185
> 
> > pci 0000:00:00.0: PCI bridge to [bus 01-ff]
> > pci 0000:00:00.0:   bridge window [io  0x0000-0x0fff]
> > pci 0000:00:00.0:   bridge window [mem 0x00000000-0x000fffff]
> > pci 0000:00:00.0:   bridge window [mem 0x00000000-0x000fffff pref]
> 
> 00:00.0 looks like a PCIe Root Port to bus 01.  This is not a host
> bridge; it's just a standard PCI-to-PCI bridge with PCI on both the
> upstream and downstream sides.
> 
> > pci 0000:02:00.0: [1b21:0611] type 00 class 0x010185
> 
> > pci 0000:00:01.0: PCI bridge to [bus 02-ff]
> > pci 0000:00:01.0:   bridge window [io  0x0000-0x0fff]
> > pci 0000:00:01.0:   bridge window [mem 0x00000000-0x000fffff]
> > pci 0000:00:01.0:   bridge window [mem 0x00000000-0x000fffff pref]
> 
> 00:01.0 is another Root Port to bus 02.
> 
> > pci 0000:03:00.0: [1b21:0611] type 00 class 0x010185
> 
> > pci 0000:00:02.0: PCI bridge to [bus 03-ff]
> > pci 0000:00:02.0:   bridge window [io  0x0000-0x0fff]
> > pci 0000:00:02.0:   bridge window [mem 0x00000000-0x000fffff]
> > pci 0000:00:02.0:   bridge window [mem 0x00000000-0x000fffff pref]
> > pci_bus 0000:03: busn_res: [bus 03-ff] end is updated to 03
> 
> And 00:02.0 is a third Root Port to bus 03.
> 
> > pci 0000:00:00.0: PCI bridge to [bus 01]
> > pci 0000:00:00.0:   bridge window [io  0x0000-0x0fff]
> > pci 0000:00:00.0:   bridge window [mem 0x60000000-0x600fffff]
> > pci 0000:00:00.0:   bridge window [mem 0x60100000-0x601fffff pref]
> > pci 0000:00:01.0: PCI bridge to [bus 02]
> > pci 0000:00:01.0:   bridge window [io  0x1000-0x1fff]
> > pci 0000:00:01.0:   bridge window [mem 0x60200000-0x602fffff]
> > pci 0000:00:01.0:   bridge window [mem 0x60300000-0x603fffff pref]
> > pci 0000:00:02.0: PCI bridge to [bus 03]
> > pci 0000:00:02.0:   bridge window [io  0x2000-0x2fff]
> > pci 0000:00:02.0:   bridge window [mem 0x60400000-0x604fffff]
> > 
> > > I think the question should be towards Mediatek folks. I don't know what
> > > this hardware is exactly, just looks like pci-pci-bridge. The driver
> > > calls the children host bridges as "ports".
> > 
> > You can see the topology here in my first driver submit cover letter
> > message [0].
> > 
> >  [0]: https://lore.kernel.org/all/CAMhs-H-BA+KzEwuDPzcmrDPdgJBFA2XdYTBvT4R4MEOUB=WQ1g@mail.gmail.com/t/
> 
> Nothing unusual here, this looks like the standard PCIe topology.
> 
> What *might* be unusual is describing the Root Ports in DT.  Since
> they are standard PCI devices, they shouldn't need DT description
> unless there's some unusual power/clock/reset control or something
> that is not discoverable via PCI enumeration.

It's only unusual because typically there's only 1 RP per host bridge 
and properties which really apply to the RP get stuck in the host bridge 
node because we don't have a RP node. An example is perst-gpios. That's 
not a property of the RP either, but the RP is the upstream side of a 
slot and we often don't have a node for the device either.

Rob

