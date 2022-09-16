Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D05C45BAD5E
	for <lists+linux-pci@lfdr.de>; Fri, 16 Sep 2022 14:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbiIPM0C (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Sep 2022 08:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbiIPM0B (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Sep 2022 08:26:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA66B0B17;
        Fri, 16 Sep 2022 05:25:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 415DA62B5D;
        Fri, 16 Sep 2022 12:25:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B902BC433C1;
        Fri, 16 Sep 2022 12:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663331158;
        bh=lL37u85+QQk/jFNlYuH18esUwapDxv4FZ5701Rpshi4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XPDYWDgGwWhfSS2pDaCoNoEnSpUTS5DR0sm8q+7Icv7DuF5RMqbAqO+Hl18skXKXL
         EgonI+4BDX0BIITkT4UbaDDv80vrhl0FGBmd64frIUH285ZoUGpAcCS0ovg1mwzFj7
         xCH/s076/T7WFx1+j7pJBZCHVqzhy0SGroVHR7O8x8LFjPnO5Zuheg5O1PdVKotdRb
         NwukTdmKvi72JMJX3v/LSrfwQ4c6gbSmK8jb+BILT4WP1ExKuUp+dIsoxSQMjqFckT
         RRKzjW+FU6M8zG9wgSh+FP64WtE2oL/LmDXTeVl1LARqcSqxSNhCU7psMyPRXgwceA
         ZghJAwu/q7Ltg==
Date:   Fri, 16 Sep 2022 14:25:51 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
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
Message-ID: <YyRrT7/EQWGM7r4l@lpieralisi>
References: <20220718202843.6766-1-maukka@ext.kapsi.fi>
 <20220905192310.22786-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220905192310.22786-1-pali@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 05, 2022 at 09:23:03PM +0200, Pali Rohár wrote:
> Hello! This patch series add support for Orion PCIe controller into
> pci-mvebu.c driver. V3 version has completely rewritten pci-mvebu.c code
> to parse all physical addresses from device tree files according to
> mvebu-pci.txt documentation, allow access to all extended PCIe config
> space registers and use modern kernel API pci_remap_cfgspace() and
> mvebu_mbus_add_window_by_id() fir mapping PCIe config space.
> 
> Most of Marvell device tree code in pci-mvebu.c is giant magic, but it was
> there because this change and it is de-facto API between dts files and
> kernel used for a long time. Note that it is misused according to PCI
> device tree bindings, but we have to follow this Marvell bindings to do
> not introduce backward incompatibility issues for other non-Orion
> platforms.
> 
> Mauri tested these changes on DNS323 board with both DT and non-DT builds.
> PCIe AER is working too (one of the feature which proved that access to
> extended PCIe config registers is working fine).
> 
> After this patch is accepted we are planning to look at existing Orion
> arch specific code and covert it to use this new DT based pci-mvebu.c
> code. Later this would allow to kill arch specific Orion PCIe code,
> which is in arch/arm/plat-orion/pcie.c and parts also in file
> arch/arm/mach-orion5x/pci.c (shared with old-PCI bus code).
> 
> This patch series depends on another patches:
> https://lore.kernel.org/linux-pci/20220524122817.7199-1-pali@kernel.org/
> https://lore.kernel.org/linux-pci/20220817230036.817-3-pali@kernel.org/

Can I rebase it on top of v6.0-rc1 ? I will not be able to pull it till
-rc7 but I don't think there is a strict dependency so we should try to
upstream it this cycle.

Lorenzo

> 
> Mauri Sandberg (2):
>   bus: mvebu-mbus: add configuration space aperture
>   dt-bindings: PCI: mvebu: Add orion5x compatible
> 
> Pali Rohár (5):
>   ARM: orion: Move PCIe mbus window mapping from orion5x_setup_wins() to
>     pcie_setup()
>   PCI: mvebu: Remove unused busn member
>   PCI: mvebu: Cleanup error handling in mvebu_pcie_probe()
>   PCI: mvebu: Add support for Orion PCIe controller
>   ARM: dts: orion5x: Add PCIe node
> 
>  .../devicetree/bindings/pci/mvebu-pci.txt     |   4 +-
>  arch/arm/boot/dts/orion5x.dtsi                |  51 +++++
>  arch/arm/mach-orion5x/common.c                |  13 --
>  arch/arm/mach-orion5x/pci.c                   |  14 ++
>  drivers/bus/mvebu-mbus.c                      |  26 ++-
>  drivers/pci/controller/Kconfig                |   4 +-
>  drivers/pci/controller/pci-mvebu.c            | 202 ++++++++++++++----
>  include/linux/mbus.h                          |   1 +
>  8 files changed, 256 insertions(+), 59 deletions(-)
> 
> -- 
> 2.20.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
