Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2CCA57BD39
	for <lists+linux-pci@lfdr.de>; Wed, 20 Jul 2022 19:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232557AbiGTRxX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Jul 2022 13:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231420AbiGTRxX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Jul 2022 13:53:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24AD85A46D;
        Wed, 20 Jul 2022 10:53:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D2FC5B82182;
        Wed, 20 Jul 2022 17:53:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7D84C3411E;
        Wed, 20 Jul 2022 17:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658339599;
        bh=x0uoeCIE00jBCB0YsHFm8nmWmRbsfgR/8F8WDW1SzJA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QIcahOnx1TtfWCEC81bY7HUrMKo8wrqvOeTbRHIpSlaDgd1g7seudbmSlILukBcvA
         3s8xSQLvajbYZFtBz71kRejzIh9c4sHLUPMXC9w7WkZngHAID6pxqjYshoX8DWGSNj
         l8iLLGwAdD7QNcry+fBMvj/zmMqGApbLZib3MHF2+iX1iZeKkIDOsrv8XfQzWZVJRZ
         g/3a0eY4QQ/n9afC6ymDHHk8ht7QgsQEXwfgcUJL/dxyxEknFqCobqYl5lqaHa1L1U
         H+uzeAgBfYOt7RT69SlvARy+JwE2FJZM7+0+0z95SfxQ+D80vi9k/lVNU/So6RyMs/
         5WVD9V+DMJ7wg==
Received: by pali.im (Postfix)
        id ACA5E797; Wed, 20 Jul 2022 19:53:15 +0200 (CEST)
Date:   Wed, 20 Jul 2022 19:53:15 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Mauri Sandberg <maukka@ext.kapsi.fi>,
        linux-pci <linux-pci@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 2/2] PCI: mvebu: add support for orion5x
Message-ID: <20220720175315.paeo7n6kx2wzcdtc@pali>
References: <20220718202843.6766-1-maukka@ext.kapsi.fi>
 <20220718202843.6766-4-maukka@ext.kapsi.fi>
 <CAK8P3a042yoLR0eqt4Bm0KH4X9SJhUsjKDh1S9M+MF6mU1mPNw@mail.gmail.com>
 <20220719094649.pzyrqdvm3fm5fqh2@pali>
 <CAK8P3a1RpMQ5zdiH_jkydxDOCm6WyD7qqdN+5T+503tN4SnOqw@mail.gmail.com>
 <20220720161315.rr4ujakl7akm7pur@pali>
 <CAL_Jsq+H+nzacGEZ4TRgZ70jUHugpNj=jpA+XfaWjhuduH1GLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_Jsq+H+nzacGEZ4TRgZ70jUHugpNj=jpA+XfaWjhuduH1GLA@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wednesday 20 July 2022 11:40:40 Rob Herring wrote:
> On Wed, Jul 20, 2022 at 10:13 AM Pali Rohár <pali@kernel.org> wrote:
> >
> > On Tuesday 19 July 2022 12:16:34 Arnd Bergmann wrote:
> > > On Tue, Jul 19, 2022 at 11:46 AM Pali Rohár <pali@kernel.org> wrote:
> > > > On Tuesday 19 July 2022 10:05:28 Arnd Bergmann wrote:
> > > > > > +/* Relevant only for Orion-1/Orion-NAS */
> > > > > > +#define ORION5X_PCIE_WA_PHYS_BASE      0xf0000000
> > > > > > +#define ORION5X_PCIE_WA_VIRT_BASE      IOMEM(0xfd000000)
> > > > >
> > > > > You should not need to hardcode these here. The ORION5X_PCIE_WA_PHYS_BASE
> > > > > should already be part of the DT binding.
> > > >
> > > > Of course! But the issue is that we do not know how to do this DT
> > > > binding. I have already wrote email with asking for help in which
> > > > property and which format should be this config range defined, but no
> > > > answer yet: https://lore.kernel.org/linux-pci/20220710225108.bgedria6igtqpz5l@pali/
> > >
> > > Ah, I had not seen that email. Quoting from there:
> > >
> > > > So my question is: How to properly define config space range in device
> > > > tree file? In which device tree property and in which format? Please
> > > > note that this memory range of config space is PCIe root port specific
> > > > and it requires its own MBUS_ID() like memory range of PCIe MEM and PCIe
> > > > IO mapping. Please look e.g. at armada-385.dtsi how are MBUS_ID() used:
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/armada-385.dtsi
> > >
> > > This is probably a question for Rob as the mvebu driver is a rather special
> > > case. Normally this would just be a 'reg' property of the host bridge,
> > > but I think
> > > in your case the root device is imaginary, and the ports under it are the
> > > actual hardware devices
> >
> > yes
> >
> > > so you'll probably have to do the same thing as
> > > the armada-385, translating the mbus ranges for the config space in the
> > > "ranges" property of the parent
> >
> > Problem is that "ranges" in PCIe are used for specifying MEM and IO
> > mappings and kernel PCI code does not allow any other type.
> 
> The kernel does not, but the binding does (well, the original OF PCI
> bus supplement does, but the schema currently does not). If there's a
> real need to support config space in ranges, then we can relax the
> constraints.
> 
> Rob

Personally, I do not care where definition of address range for config
space would be defined. Just I need to know where to put it and in which
format, so it would be fine for schema checkers, kernel pci core, etc...
https://lore.kernel.org/linux-pci/20220710225108.bgedria6igtqpz5l@pali/
