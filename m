Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADDAC57BB27
	for <lists+linux-pci@lfdr.de>; Wed, 20 Jul 2022 18:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234514AbiGTQNW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Jul 2022 12:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiGTQNV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Jul 2022 12:13:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F8A952FCF;
        Wed, 20 Jul 2022 09:13:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 05C1161D3F;
        Wed, 20 Jul 2022 16:13:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1155AC3411E;
        Wed, 20 Jul 2022 16:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658333599;
        bh=azV4rh1tEUOtwWZ2k2aBfyGO80U70CDuAQhKmnY7ZKk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EeYPcSugudjlBWfAxIxhS/y+sDO1CCygJN/OTX4NYpdkO48bFcLdvojgNscHQtdmO
         KIGkv7FqwfAXkiElizH3BulePE15ai1LQkaJ57QKace1gYbv3URSk4hXk5mQpP5xuA
         NyW50165+EVAxLaMbxviS7xK6t23lI17H2vGPHV0h5w3omqUPqsl6mWWd4i+bMKxjh
         Lvfl2QitS6R6rVZFkC5KjyqUOgeukl15ePHNOaKUbpQmOjEWZ/7byJkg5AnkZ1K6+8
         M3DDpv38cQiqO+h1kdj3sGhphMwlWpPemE83Y3oFVZ7oFXVhTtxozaHUyyMj7Gq0jJ
         Fsp2oyO1xweXA==
Received: by pali.im (Postfix)
        id E1729797; Wed, 20 Jul 2022 18:13:15 +0200 (CEST)
Date:   Wed, 20 Jul 2022 18:13:15 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Mauri Sandberg <maukka@ext.kapsi.fi>,
        linux-pci <linux-pci@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 2/2] PCI: mvebu: add support for orion5x
Message-ID: <20220720161315.rr4ujakl7akm7pur@pali>
References: <20220718202843.6766-1-maukka@ext.kapsi.fi>
 <20220718202843.6766-4-maukka@ext.kapsi.fi>
 <CAK8P3a042yoLR0eqt4Bm0KH4X9SJhUsjKDh1S9M+MF6mU1mPNw@mail.gmail.com>
 <20220719094649.pzyrqdvm3fm5fqh2@pali>
 <CAK8P3a1RpMQ5zdiH_jkydxDOCm6WyD7qqdN+5T+503tN4SnOqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK8P3a1RpMQ5zdiH_jkydxDOCm6WyD7qqdN+5T+503tN4SnOqw@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tuesday 19 July 2022 12:16:34 Arnd Bergmann wrote:
> On Tue, Jul 19, 2022 at 11:46 AM Pali Rohár <pali@kernel.org> wrote:
> > On Tuesday 19 July 2022 10:05:28 Arnd Bergmann wrote:
> > > > +/* Relevant only for Orion-1/Orion-NAS */
> > > > +#define ORION5X_PCIE_WA_PHYS_BASE      0xf0000000
> > > > +#define ORION5X_PCIE_WA_VIRT_BASE      IOMEM(0xfd000000)
> > >
> > > You should not need to hardcode these here. The ORION5X_PCIE_WA_PHYS_BASE
> > > should already be part of the DT binding.
> >
> > Of course! But the issue is that we do not know how to do this DT
> > binding. I have already wrote email with asking for help in which
> > property and which format should be this config range defined, but no
> > answer yet: https://lore.kernel.org/linux-pci/20220710225108.bgedria6igtqpz5l@pali/
> 
> Ah, I had not seen that email. Quoting from there:
> 
> > So my question is: How to properly define config space range in device
> > tree file? In which device tree property and in which format? Please
> > note that this memory range of config space is PCIe root port specific
> > and it requires its own MBUS_ID() like memory range of PCIe MEM and PCIe
> > IO mapping. Please look e.g. at armada-385.dtsi how are MBUS_ID() used:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/armada-385.dtsi
> 
> This is probably a question for Rob as the mvebu driver is a rather special
> case. Normally this would just be a 'reg' property of the host bridge,
> but I think
> in your case the root device is imaginary, and the ports under it are the
> actual hardware devices

yes

> so you'll probably have to do the same thing as
> the armada-385, translating the mbus ranges for the config space in the
> "ranges" property of the parent

Problem is that "ranges" in PCIe are used for specifying MEM and IO
mappings and kernel PCI code does not allow any other type.

> and then referring to them by PCI
> MMIO addresses using the assigned-addresses property to pass the
> config-space registers as a second set of registers in addition to the
> first set.

It is more complicated. PCIe MEM and IO memory ranges are defined in
"soc" node in "pcie-mem-aperture" and "pcie-io-aperture" properties.
These ranges are shared across all PCIe controllers and assigning slices
of these ranges to specific devices is done later by dynamic allocation.
"soc" node is bind to mbus driver (which parse these properties) and
provides API for other kernel drivers for dynamic allocation of memory
from pcie aperture. In pcie node is just indirect reference to PCIe MEM
and IO via MBUS_ID() macro and it is pci-mvebu.c driver who ask mbus
driver for PCIe MEM and IO dynamic allocation.

So because PCIe config space is not of type PCIe MEM nor PCIe IO
(obviously) it cannot use "ranges" property. Because DT pcie nodes use
"reg" property for specifying BDF address, we cannot use neither "reg"
property for specifying memory range of PCIe config space.

And here I'm lost.

My guess is that proper way is to define "pcie-cfg-aperture" in "soc"
node where would be defined physical address range without any binding
to controller, then extend mbus driver to export API also for PCIe CFG
and add code which dynamically assign slice of this range to some
controller. And then use this new API by pci-mvebu.c to access config
space. But pci-mvebu.c needs to know MBUS_ID() attributes which needs to
be defined somewhere in pcie DT node...

> > > There is little practical difference
> > > here, but I see no value in taking the shortcut here either.
> > >
> > > For the ORION5X_PCIE_WA_VIRT_BASE, you rely on this to match the
> > > definition in arch/arm/mach-orion5x/common.c, and this is rather fragile.
> > >
> > > Instead, please use ioremap() to create a mapping at runtime. The ioremap()
> > > implementation on ARM is smart enough to reuse the address from the static
> > > mapping in common.c, but will also keep working if that should go away.
> >
> > I'm planning to work with Mauri on this, but current blocker is DT.
> 
> Ok. It should not be hard to do this first, as you just need to pass the
> same physical address that you pass in the mbus setup, but I agree
> it's easier to do this afterwards to avoid having to rewrite it again.
> 
> > > This is probably good enough here, though I think you could also use
> > > the trick from drivers/pci/ecam.c and map each bus at a time.
> > >
> > Yes, there are also helper functions like map bus and etc. which could
> > simplify this code. I'm planning to do cleanups once we have fully
> > working driver for Orion.
> 
> Ok. This is probably not worth the effort if the old driver doesn't already
> do provide access to the high registers.
> 
>       Arnd

If we have free 256MB in physical address space, then we can implement
it easily. It is just changing _size_ argument. I'm not sure how much
DDR RAM has Orion, but if only 2GB then we should be fine (remaining 2GB
should be enough for all peripherals + 256MB for PCIe config space).

Main issue is that there is no Orion documentation which would describe
how direct mapping of PCIe config space is working.
(see also https://lore.kernel.org/linux-doc/20220719080807.16729-1-pali@kernel.org/)

So we can only set "size" of the physical config space mapping and if we
choose smaller size then we cannot access upper registers. I do not see
any option how to specify "offset" for physical config space to allow
mapping just one PCI bus.

What we have under full control is virtual address space mapping, so we
can just map only one PCI bus to virtual address space from large 256MB
physical config address space.
