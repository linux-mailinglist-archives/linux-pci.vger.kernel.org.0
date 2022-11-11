Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0F6625FDB
	for <lists+linux-pci@lfdr.de>; Fri, 11 Nov 2022 17:54:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233114AbiKKQyL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Nov 2022 11:54:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232004AbiKKQyK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2022 11:54:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D142EAE45;
        Fri, 11 Nov 2022 08:54:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 27A7FB82671;
        Fri, 11 Nov 2022 16:54:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58E4BC433D6;
        Fri, 11 Nov 2022 16:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668185645;
        bh=3ZBAlgtON0ymrWeudCaliLCw3wN7/KDetEApQzKhBus=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mSIxpPGkRWTY21vxX4Q4efNcchfQ5g4HiQd8TW0fLjJmGLBCOBc6h2R1z5MYDZ4Dt
         vvyVb00bxE9atOze3gWSAZnBrB30/fAFvqLHrtimYkO+g7h78v/pw9wr+ZMU4JClJn
         +AR+0t4I17fN22rCNKJaHuEB3avhzDF9z1sDRDLsy5TutymMGum1ruI4Sw6RI+4MFt
         Vyl53hudwi4NIQu52b+sG/5GbBwIDKudTos7Q5qAZ8xxJh+d0O56t90s6XJ8VDIzId
         UNfgabgbxdp3rNEPrSZPBY3MEwGkROxQPRryBErB2SlenOma2HIHv/WW2+Tt96BxJz
         auEBwhvWpaC8A==
Received: by pali.im (Postfix)
        id 870C2818; Fri, 11 Nov 2022 17:54:02 +0100 (CET)
Date:   Fri, 11 Nov 2022 17:54:02 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Russell King <linux@armlinux.org.uk>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Mauri Sandberg <maukka@ext.kapsi.fi>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 0/7] PCI: mvebu: add support for orion soc
Message-ID: <20221111165402.42p5xmz5ibf63kvh@pali>
References: <20220718202843.6766-1-maukka@ext.kapsi.fi>
 <20220905192310.22786-1-pali@kernel.org>
 <Y1qRaBowB2EBS6Sg@lpieralisi>
 <20221106232824.du4uou6pf77rqu45@pali>
 <Y25E9e2JnKPWlrFT@lpieralisi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y25E9e2JnKPWlrFT@lpieralisi>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Friday 11 November 2022 13:49:57 Lorenzo Pieralisi wrote:
> On Mon, Nov 07, 2022 at 12:28:24AM +0100, Pali Rohár wrote:
> > On Thursday 27 October 2022 16:10:48 Lorenzo Pieralisi wrote:
> > > On Mon, Sep 05, 2022 at 09:23:03PM +0200, Pali Rohár wrote:
> > > > Hello! This patch series add support for Orion PCIe controller into
> > > > pci-mvebu.c driver. V3 version has completely rewritten pci-mvebu.c code
> > > > to parse all physical addresses from device tree files according to
> > > > mvebu-pci.txt documentation, allow access to all extended PCIe config
> > > > space registers and use modern kernel API pci_remap_cfgspace() and
> > > > mvebu_mbus_add_window_by_id() fir mapping PCIe config space.
> > > > 
> > > > Most of Marvell device tree code in pci-mvebu.c is giant magic, but it was
> > > > there because this change and it is de-facto API between dts files and
> > > > kernel used for a long time. Note that it is misused according to PCI
> > > > device tree bindings, but we have to follow this Marvell bindings to do
> > > > not introduce backward incompatibility issues for other non-Orion
> > > > platforms.
> > > > 
> > > > Mauri tested these changes on DNS323 board with both DT and non-DT builds.
> > > > PCIe AER is working too (one of the feature which proved that access to
> > > > extended PCIe config registers is working fine).
> > > > 
> > > > After this patch is accepted we are planning to look at existing Orion
> > > > arch specific code and covert it to use this new DT based pci-mvebu.c
> > > > code. Later this would allow to kill arch specific Orion PCIe code,
> > > > which is in arch/arm/plat-orion/pcie.c and parts also in file
> > > > arch/arm/mach-orion5x/pci.c (shared with old-PCI bus code).
> > > > 
> > > > This patch series depends on another patches:
> > > > https://lore.kernel.org/linux-pci/20220524122817.7199-1-pali@kernel.org/
> > > > https://lore.kernel.org/linux-pci/20220817230036.817-3-pali@kernel.org/
> > > 
> > > Can this series be rebased please on top of v6.1-rc1 so that we can merge it ?
> > 
> > IIRC above two dependent patches still applies on master branch and this
> > patch series applies on above two dependent patches.
> 
> Which I can't merge for reasons you are aware of already.
> 
> So, does this series _really_ depend on the two patches above ?
> 
> I don't think so but let me ask again.
> 
> Lorenzo

Yes, this patch series depends on above tow patches. Kirkwood and older
platforms (including the oldest one Orion) needs fixes for registering
and handling of shared interrupts.

> > > Thanks,
> > > Lorenzo
> > > 
> > > > Mauri Sandberg (2):
> > > >   bus: mvebu-mbus: add configuration space aperture
> > > >   dt-bindings: PCI: mvebu: Add orion5x compatible
> > > > 
> > > > Pali Rohár (5):
> > > >   ARM: orion: Move PCIe mbus window mapping from orion5x_setup_wins() to
> > > >     pcie_setup()
> > > >   PCI: mvebu: Remove unused busn member
> > > >   PCI: mvebu: Cleanup error handling in mvebu_pcie_probe()
> > > >   PCI: mvebu: Add support for Orion PCIe controller
> > > >   ARM: dts: orion5x: Add PCIe node
> > > > 
> > > >  .../devicetree/bindings/pci/mvebu-pci.txt     |   4 +-
> > > >  arch/arm/boot/dts/orion5x.dtsi                |  51 +++++
> > > >  arch/arm/mach-orion5x/common.c                |  13 --
> > > >  arch/arm/mach-orion5x/pci.c                   |  14 ++
> > > >  drivers/bus/mvebu-mbus.c                      |  26 ++-
> > > >  drivers/pci/controller/Kconfig                |   4 +-
> > > >  drivers/pci/controller/pci-mvebu.c            | 202 ++++++++++++++----
> > > >  include/linux/mbus.h                          |   1 +
> > > >  8 files changed, 256 insertions(+), 59 deletions(-)
> > > > 
> > > > -- 
> > > > 2.20.1
> > > > 
> > > > 
> > > > _______________________________________________
> > > > linux-arm-kernel mailing list
> > > > linux-arm-kernel@lists.infradead.org
> > > > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> > 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
