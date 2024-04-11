Return-Path: <linux-pci+bounces-6138-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C07568A1C30
	for <lists+linux-pci@lfdr.de>; Thu, 11 Apr 2024 19:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C496285B3C
	for <lists+linux-pci@lfdr.de>; Thu, 11 Apr 2024 17:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCFFF15A4B1;
	Thu, 11 Apr 2024 16:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rvm0S2oJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6EC115A4AF;
	Thu, 11 Apr 2024 16:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712851870; cv=none; b=Nhsh5S1oKzDA7EsR7YOsKzxI9dRbsxTPPfn84iutEdMmKBoxD1eZod1O8VZhf7TYL6gL+upVRhTaq3neFdScsdKPgyCiiGDDP+Rwf1GEBL1s/4qTMgnzCE9iL9VmYVBxOZ3boatGms7aEDmVCVHZ4+SqOQ9NbZDbmkCFLJTHdGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712851870; c=relaxed/simple;
	bh=Co3kGhkNsPgacB/pabyCsenR+0gNcn0apDUzg988VHA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=q18mJbNr1XEByVMCT5shHMfoltp5jkb+eTD+yntIt286pUr9i8Q5ob0UPCd9qtDc46reH9KA02c4CLwOharuqaHIWRxf2kIaY/Ks4FqzXH/TMEKgQtJv4LwV6I2MQQH19xLo5TNS9MMzravLv21fa/xmUeiBnziQdxk58tEjGCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rvm0S2oJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 001FEC072AA;
	Thu, 11 Apr 2024 16:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712851870;
	bh=Co3kGhkNsPgacB/pabyCsenR+0gNcn0apDUzg988VHA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=rvm0S2oJrwiPhJs3eMOF4f2WjbhaHXPCHhoQzlhlvGzTckM5NUJlGvZE//UJTbZuk
	 7mUvnId3dLSEO383sQdQGizvtxlqOjpE6LHUGEUzOLcvm2FFMA5/b/WtwmbW9OxU3t
	 vraPDqamiI8esjKLmEPlXpKeb3GokCNr0IyDHPJwJEbgyjnyrMewIrl/lr5uw3SXYu
	 ufts0B5MaTMqZx4inTcApZhjiikn03+zpnbGKAZYEpPL3yc3b4UbwWwc/biOcTK9tx
	 O2EDKKXK1jYU6zNUiteXtEM8WNQ9P2BCMa9UpGqUhrAINiWUMdVs8dvmVCMdMSalCs
	 JbWrghBBIpbBg==
Date: Thu, 11 Apr 2024 11:11:08 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Rob Herring <robh@kernel.org>
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
Message-ID: <20240411161108.GA2184354@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240411142107.GA3537062-robh@kernel.org>

On Thu, Apr 11, 2024 at 09:21:07AM -0500, Rob Herring wrote:
> On Thu, Apr 11, 2024 at 07:39:17AM -0500, Bjorn Helgaas wrote:
> > On Thu, Apr 11, 2024 at 08:13:18AM +0200, Sergio Paracuellos wrote:
> > > On Thu, Apr 11, 2024 at 8:01 AM Krzysztof Kozlowski
> > > <krzysztof.kozlowski@linaro.org> wrote:
> > > > On 10/04/2024 23:26, Bjorn Helgaas wrote:
> > > > > On Wed, Apr 10, 2024 at 08:15:19PM +0200, Krzysztof Kozlowski wrote:
> > > > >> MT7621 PCI host bridge has children which apparently are also PCI host
> > > > >> bridges, at least that's what the binding suggest.
> > > > >
> > > > > What does it even mean for a PCI host bridge to have a child that is
> > > > > also a PCI host bridge?
> 
> It should say 'root port' instead as the binding description correctly 
> says.

OK, that makes a lot more sense, and we should fix the commit log.

> > > > I think the question should be towards Mediatek folks. I don't know what
> > > > this hardware is exactly, just looks like pci-pci-bridge. The driver
> > > > calls the children host bridges as "ports".
> > > 
> > > You can see the topology here in my first driver submit cover letter
> > > message [0].
> > > 
> > >  [0]: https://lore.kernel.org/all/CAMhs-H-BA+KzEwuDPzcmrDPdgJBFA2XdYTBvT4R4MEOUB=WQ1g@mail.gmail.com/t/
> > 
> > Nothing unusual here, this looks like the standard PCIe topology.
> > 
> > What *might* be unusual is describing the Root Ports in DT.  Since
> > they are standard PCI devices, they shouldn't need DT description
> > unless there's some unusual power/clock/reset control or something
> > that is not discoverable via PCI enumeration.
> 
> It's only unusual because typically there's only 1 RP per host bridge 
> and properties which really apply to the RP get stuck in the host bridge 
> node because we don't have a RP node. An example is perst-gpios. That's 
> not a property of the RP either, but the RP is the upstream side of a 
> slot and we often don't have a node for the device either.

Makes sense.

I'm still confused about one thing, maybe just because I don't really
know how to read these bindings.  The binding now looks like this:

  properties:
    compatible:
      const: mediatek,mt7621-pci

    reg:
      items:
        - description: host-pci bridge registers
        - description: pcie port 0 RC control registers       # A
        - description: pcie port 1 RC control registers       # A
        - description: pcie port 2 RC control registers       # A

  patternProperties:
    '^pcie@[0-2],0$':
      type: object
      $ref: /schemas/pci/pci-pci-bridge.yaml#

      properties:
        reg:                                                  # B
          maxItems: 1

It looks like the "A" items are separate things from the "B" items?

But I think the relevant code is here:

  mt7621_pcie_probe
    mt7621_pcie_parse_dt
      pcie->base = devm_platform_ioremap_resource(pdev, 0)             # 1
      for_each_available_child_of_node(node, child)
        mt7621_pcie_parse_port
          port->base = devm_platform_ioremap_resource(pdev, slot + 1)  # 2

where it looks like both "1" and "2" use the items in the "A" list,
i.e., resources 0, 1, 2, 3, all from the same platform device.  Is
there code that uses the "B" item that this patch adds?

Bjorn

