Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25A2C52262C
	for <lists+linux-pci@lfdr.de>; Tue, 10 May 2022 23:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232344AbiEJVPR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 May 2022 17:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbiEJVPQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 May 2022 17:15:16 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 171D42944BF;
        Tue, 10 May 2022 14:15:11 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1noXCC-0007Ms-0L; Tue, 10 May 2022 23:15:04 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Peter Geis <pgwipeout@gmail.com>
Cc:     Marc Zyngier <maz@kernel.org>, PCI <linux-pci@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 0/5] Enable rk356x PCIe controller
Date:   Tue, 10 May 2022 23:15:03 +0200
Message-ID: <2109328.Mh6RI2rZIc@diego>
In-Reply-To: <CAMdYzYrzq5C61T2NYmHr0g_P7Mm25TUfaDV3iz2LkV8-jpV4kA@mail.gmail.com>
References: <20220429123832.2376381-1-pgwipeout@gmail.com> <CAMdYzYrzq5C61T2NYmHr0g_P7Mm25TUfaDV3iz2LkV8-jpV4kA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am Dienstag, 10. Mai 2022, 23:11:18 CEST schrieb Peter Geis:
> On Fri, Apr 29, 2022 at 8:38 AM Peter Geis <pgwipeout@gmail.com> wrote:
> >
> > This series enables the DesignWare based PCIe controller on the rk356x
> > series of chips. We drop the fallback to the core driver due to
> > compatibility issues. We reset the PCIe controller at driver probe to
> > prevent issues in the future when firmware / kexec leaves the controller
> > in an unknown state. We add support for legacy interrupts for cards that
> > lack MSI support (which is partially broken currently). We then add the
> > device tree nodes to enable PCIe on the Quartz64 Model A.
> 
> Good Evening,
> 
> Just a gentle ping to see if there's anything outstanding here.

From my side it looks good. I'll take patches 4+5 once the binding-change
from patch1 has been applied to some tree.


Heiko


> >
> > Patch 1 drops the snps,dw,pcie fallback from the dt-binding
> > Patch 2 resets the PCIe controller to prevent configuration bugs
> > Patch 3 adds legacy interrupt support to the driver
> > Patch 4 adds the device tree binding to the rk356x.dtsi
> > Patch 5 enables the PCIe controller on the Quartz64-A
> >
> > Changelog:
> > v9:
> > - move reset_control_assert out of rockchip_pcie_resource_get
> > - fix various formatting mistakes
> > - fix a checkpatch warning
> >
> > v8:
> > - add core reset patch
> > - simplify IRQ enable/disable functions
> > - drop spinlock
> > - only enable/disable IRQ requested
> > - only pass the IRQ register bits used to irq functions
> >
> > v7:
> > - drop assigned-clocks
> >
> > v6:
> > - fix a ranges issue
> > - point to GIC instead of ITS
> >
> > v5:
> > - fix incorrect series (apologies for the v4 spam)
> >
> > v4:
> > - drop the ITS modification, poor compatibility is better than
> >   completely broken
> >
> > v3:
> > - drop select node from dt-binding
> > - convert to for_each_set_bit
> > - convert to generic_handle_domain_irq
> > - drop unncessary dev_err
> > - reorder irq_chip items
> > - change to level_irq
> > - install the handler after initializing the domain
> >
> > v2:
> > - Define PCIE_CLIENT_INTR_STATUS_LEGACY
> > - Fix PCIE_LEGACY_INT_ENABLE to only enable the RC interrupts
> > - Add legacy interrupt enable/disable support
> >
> >
> > Peter Geis (5):
> >   dt-bindings: PCI: Remove fallback from Rockchip DesignWare binding
> >   PCI: rockchip-dwc: Reset core at driver probe
> >   PCI: rockchip-dwc: Add legacy interrupt support
> >   arm64: dts: rockchip: Add rk3568 PCIe2x1 controller
> >   arm64: dts: rockchip: Enable PCIe controller on quartz64-a
> >
> >  .../bindings/pci/rockchip-dw-pcie.yaml        |  12 +-
> >  .../boot/dts/rockchip/rk3566-quartz64-a.dts   |  34 +++++
> >  arch/arm64/boot/dts/rockchip/rk356x.dtsi      |  52 ++++++++
> >  drivers/pci/controller/dwc/pcie-dw-rockchip.c | 119 +++++++++++++++---
> >  4 files changed, 191 insertions(+), 26 deletions(-)
> >
> > --
> > 2.25.1
> >
> 




