Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC27658DC18
	for <lists+linux-pci@lfdr.de>; Tue,  9 Aug 2022 18:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245007AbiHIQaI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Aug 2022 12:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245150AbiHIQ3x (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 Aug 2022 12:29:53 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B22020BC0;
        Tue,  9 Aug 2022 09:29:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id BB5EFCE17C1;
        Tue,  9 Aug 2022 16:29:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFC5BC433C1;
        Tue,  9 Aug 2022 16:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660062583;
        bh=VCOZhAhGtIH41Y+TrbUDBKBW83hAE9PrX8Mi0r6qX90=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Nx05a60ew3WgVyqdEi29MXBPVO079e8ZuK8gwLlxsCAViU+p5a/t+Wz/8n0RFGcnQ
         3ykJlIjNaAPjoVGkz9fXP6mGoj47zBe5WASA4wYw91yHQs/NwY4kelHsvKSzzgfRI8
         Z60Pwl0HQRjSkmJV1G9yKSZNa51DWDtjCb1A7UjhDDs3cH9zApaCWKuPWB9WgURa8U
         X5LMOtHMPTUsdmhm+f+WVkuRlE1/F+2NAFtnRmyCf0j7OgIj4ib/fsPuIOrnfTYRPi
         z0DKuPQIKvZ2eZYKFvqcfUKHXldeCsegHRq54rg5SIU7owngAGKQpqknlRTes1XYUI
         xuGIZdU1uwoZg==
Received: by pali.im (Postfix)
        id D57ACC1F; Tue,  9 Aug 2022 18:29:39 +0200 (CEST)
Date:   Tue, 9 Aug 2022 18:29:39 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mauri Sandberg <maukka@ext.kapsi.fi>,
        devicetree@vger.kernel.org, PCI <linux-pci@vger.kernel.org>
Subject: Re: How to correctly define memory range of PCIe config space
Message-ID: <20220809162939.vemxmk2qxjnmnagh@pali>
References: <20220710225108.bgedria6igtqpz5l@pali>
 <20220806110613.GB4516@thinkpad>
 <20220806111702.ezzknr76a4imej4u@pali>
 <CAL_JsqL9dNtEtAvfRBPBRqgatheoyrEF+wx_kQiTbASxOPAQTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqL9dNtEtAvfRBPBRqgatheoyrEF+wx_kQiTbASxOPAQTA@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello!

On Tuesday 09 August 2022 09:59:49 Rob Herring wrote:
> On Sat, Aug 6, 2022 at 5:17 AM Pali Rohár <pali@kernel.org> wrote:
> >
> > On Saturday 06 August 2022 16:36:13 Manivannan Sadhasivam wrote:
> > > Hi Pali,
> > >
> > > On Mon, Jul 11, 2022 at 12:51:08AM +0200, Pali Rohár wrote:
> > > > Hello!
> > > >
> > > > Together with Mauri we are working on extending pci-mvebu.c driver to
> > > > support Orion PCIe controllers as these controllers are same as mvebu
> > > > controller.
> > > >
> > > > There is just one big difference: Config space access on Orion is
> > > > different. mvebu uses classic Intel CFC/CF8 registers for indirect
> > > > config space access but Orion has direct memory mapped config space.
> > > > So Orion DTS files need to have this memory range for config space and
> > > > pci-mvebu.c driver have to read this range from DTS and properly map it.
> > > >
> > > > So my question is: How to properly define config space range in device
> > > > tree file? In which device tree property and in which format? Please
> > > > note that this memory range of config space is PCIe root port specific
> > > > and it requires its own MBUS_ID() like memory range of PCIe MEM and PCIe
> > > > IO mapping. Please look e.g. at armada-385.dtsi how are MBUS_ID() used:
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/armada-385.dtsi
> > > >
> > >
> > > On most of the platforms, the standard "reg" property is used to specify the
> > > config space together with other device specific memory regions. For instance,
> > > on the Qcom platforms based on Designware IP, we have below regions:
> > >
> > >       reg = <0xfc520000 0x2000>,
> > >             <0xff000000 0x1000>,
> > >             <0xff001000 0x1000>,
> > >             <0xff002000 0x2000>;
> > >       reg-names = "parf", "dbi", "elbi", "config";
> > >
> > > Where "parf" and "elbi" are Qcom controller specific regions, while "dbi" and
> > > "config" (config space) are common to all Designware IPs.
> > >
> > > These properties are documented in: Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> > >
> > > Hope this helps!
> >
> > Hello! I have already looked at this. But as I pointed in above
> > armada-385.dtsi file, mvebu is quite complicated. First it does not use
> > explicit address ranges, but rather macros MBUS_ID() which assign
> > addresses at kernel runtime by mbus driver. Second issue is that config
> > space range (like any other resources) are pcie root port specific. So
> > it cannot be in pcie controller node and in pcie devices is "reg"
> > property reserved for pci bdf address.
> >
> > In last few days, I spent some time on this issue and after reading lot
> > of pcie dts files, including bindings and other documents (including
> > open firmware pci2_1.pdf) and I'm proposing following definition:
> >
> > soc {
> >   pcie-mem-aperture = <0xe0000000 0x08000000>; /* 128 MiB memory space */
> >   pcie-cfg-aperture = <0xf0000000 0x01000000>; /*  16 MiB config space */
> >   pcie-io-aperture  = <0xf2000000 0x00100000>; /*   1 MiB I/O space */
> >
> >   pcie {
> >     ranges = <0x82000000 0 0x40000     MBUS_ID(0xf0, 0x01) 0x40000  0x0 0x2000>,    /* Port 0.0 Internal registers */
> >              <0x82000000 0 0xf0000000  MBUS_ID(0x04, 0x79) 0        0x0 0x1000000>, /* Port 0.0 Config space */
> 
> IMO, this should be 0 for first cell as this is config space. What is
> 0xf0000000 as that's supposed to be an address in PCI address space.

Which value should be 0? I did not catch it here.

0xf0000000 is just start offset for the child address range. I chose it
"randomly" to not conflict with 0x40000 offset for child address range
which describe internal PCIe controller registers.

> >              <0x82000000 1 0x0         MBUS_ID(0x04, 0x59) 0        0x1 0x0>,       /* Port 0.0 Mem */
> >              <0x81000000 1 0x0         MBUS_ID(0x04, 0x51) 0        0x1 0x0>,       /* Port 0.0 I/O */
> 
> I/O space at 4GB? It's only 32-bits. I guess this is already there
> from the mvebu binding, but it seems kind of broken...

You have not looked how it works. mvebu is 32-bit CPU and this describe
whole address range which could possibly used for IO or MEM for any
(unspecified) PCIe controller.

Every PCIe controller has its own PCIe MEM and PCIe IO address range
which are not shared with other PCIe controllers. (non-mvebu platforms
use for this different PCI domains; mvebu not)

These "shared" ranges are then dynamically split into PCIe controllers
like their drivers ask. So at the end all 10 PCIe controllers which are
on AXP ask for maximum (64 kB) of PCIe IO and allocator then choose 10
64kB non-interleaving ranges from this "big" master range. Same for PCIe
MEM.

So basically those two lines (one for MEM and one for IO) just says that
"unspecified" amount of PCIe MEM is mapped to MBUS_ID(0x04, 0x59) and
another "unspecified" amount of PCIe IO is mapped to MBUS_ID(0x04, 0x51)
mbus and pci-mvebu.c drivers than takes care for proper allocation of
required memory from dynamic pool defined in pcie-mem-aperture and
pcie-io-aperture properties.

Note that this is not something which I invented, this is used for a
long time by mvebu drivers and device tree files.

> >
> >     pcie@1,0 {
> >       reg = <0x0800 0 0 0 0>; /* BDF 0:1.0 */
> >       assigned-addresses =     <0x82000800 0 0x40000     0x0 0x2000>,     /* Port 0.0 Internal registers */
> >                                <0x82000800 0 0xf0000000  0x0 0x1000000>;  /* Port 0.0 Config space */
> 
> This says it is memory space, not config space.

"config space" for Orion (in from driver point of view) is just ordinary
"memory space".

"memory space" is accessed by load/store instructions. I/O space is
accessed by inb/outb (IO instructions or what architecture has) and
"config space" is accessed by kernel drivers by its own drivers.

So I think it is correct to declare this range of address space as
"memory".

> But the PCI binding
> says config space is not allowed in assigned-addresses.

Exactly. And this is because it does not make sense to assign "config
space" into "assigned-addresses" as described in:
https://www.devicetree.org/open-firmware/bindings/pci/pci2_1.pdf

My understanding of above document is that "reg" property in following
code describes "config space".

  pcie@1,0 {
    reg = <0x0800 0 0 0 0>; /* BDF 0:1.0 */
  }

And reason is that because above document use "config space" terminology
for describing specific PCI device on the bus.

Address part after the at-char (@1,0) in device tree should match "reg"
property and by all above definitions from pci2_1.pdf this pass because:

1) that document describes @1,0 format that is "config space" for PCI
   device with BDF X:1.0 where X is the parent bus

2) 0x0800 is really describes BDF X:1.0

And then the "config space is not allowed in assigned-addresses" makes
sense as there is absolutely no need to put "pointer" to PCI device
(with BDF address) into "assigned-addresses" property. In this property
should be some memory range and not reference to some PCI device.

> I think the parent ranges needs a config space entry with the BDF for
> each root port and then this entry should be dropped. It really looks
> to me like the mvebu binding created these fake PCI addresses to map
> root ports back to MBUS addresses when BDF could have been used
> instead.
> 
> Rob

The reason is that in mvebu there are X independent single-root-port
PCIe controllers (PCIe host bridges; PCI domains; ...) and device tree
binding was defined that all root ports (with their host bridges) would
be put into one "virtual" DT node which would act as one PCI domain.

And this leads to the fact that all controller specific settings must be
defined in pci root ports.

And obviously every PCIe controller has its own internal registers and
its own way how to access config space (all is independent).
