Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4D576603E
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jul 2023 01:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbjG0X1o (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Jul 2023 19:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231875AbjG0X1n (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Jul 2023 19:27:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D2331737;
        Thu, 27 Jul 2023 16:27:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B97661F3E;
        Thu, 27 Jul 2023 23:27:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D778C433C8;
        Thu, 27 Jul 2023 23:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690500460;
        bh=goKHBWa/vS/pA7DJKDLo60FUtbLnq7dNm7Fkf6aAGcw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=WoROMJHlKcwYp9PX/dIOqyE2pPKmgq4MboO5cUDWkA0ekr2d8SuAWdV8wNyBD/ZWr
         7unfgNXm/z9u2DVlEyJ+pAzBxI8S14s0hgmFST1f1x5LLb36Hp6jTAJvzwKr20Yc86
         kT0ql+EifMTdDPZquB2MHa2ldCs+qkklJRx0wlSCQXdA7QgJ/DEt4+lS0jl/rIhhGc
         xkj6RnvR/nSnZYoV8vcWWjkQsEPb94LJ76L/l0gmIRxKPrrJ5oBPMFjbJZbD0dSrJU
         JAJmYDCsIe6riScLmKHtBIl4j3WG5zwSzrsjElylLgtksijhlfztig1mITrign5ame
         S9Ft7IVlXPJOQ==
Date:   Thu, 27 Jul 2023 18:27:38 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Havalige, Thippeswamy" <thippeswamy.havalige@amd.com>
Cc:     "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "Gogada, Bharat Kumar" <bharat.kumar.gogada@amd.com>,
        "Simek, Michal" <michal.simek@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH V5 3/3] PCI: xilinx-xdma: Add Xilinx XDMA Root Port driver
Message-ID: <20230727232738.GA786642@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN7PR12MB72010CF07797580B0B8732EC8B02A@SN7PR12MB7201.namprd12.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 24, 2023 at 06:40:58AM +0000, Havalige, Thippeswamy wrote:
> > From: Bjorn Helgaas <helgaas@kernel.org>
> > On Thu, Jul 20, 2023 at 06:37:03AM +0000, Havalige, Thippeswamy wrote:
> > > > From: Bjorn Helgaas <helgaas@kernel.org> ...
> > > > On Wed, Jun 28, 2023 at 02:58:12PM +0530, Thippeswamy Havalige wrote:
> > > > > Add support for Xilinx XDMA Soft IP core as Root Port.
> > > > > ...

> > If you have more detail about the "error interrupt," that would be
> > useful as well.  Does this refer to an AER interrupt, a "System
> > Error", something else?  I'm looking at the diagram in PCIe r6.0,
> > Figure 6-3, wondering if this is related to anything there.  I
> > suppose likely it's some Xilinx-specific thing?
> 
> - Agreed, ll modify Legacy to INTx, and regarding error interrupts
> these are Xilinx controller specific interrupts which are used to
> notify the user about errors such as cfg timeout, slave unsupported
> requests,Fatal and non fatal error.

This would be great material for comments and/or a revised commit log.

> > > > > +	/* Plug the INTx chained handler */
> > > > > +	irq_set_chained_handler_and_data(port->intx_irq,
> > > > > +					 xilinx_pl_dma_pcie_intx_flow, port);
> > > > > +
> > > > > +	/* Plug the main event chained handler */
> > > > > +	irq_set_chained_handler_and_data(port->irq,
> > > > > +					 xilinx_pl_dma_pcie_event_flow,
> > > > port);
> > > >
> > > > What's the reason for using chained IRQs?  Can this be done without
> > > > them?  I don't claim to understand all the issues here, but it seems
> > > > better to avoid chained IRQ handlers when possible:
> > > > https://lore.kernel.org/all/877csohcll.ffs@tglx/
> > 
> > > - As per the comments in this
> > > https://lkml.kernel.org/lkml/alpine.DEB.2.20.1705232307330.2409@nanos/
> > > T/ "It is fine to have chained interrupts when bootloader, device tree
> > > and kernel under control. Only if BIOS/UEFI comes into play the user
> > > is helpless against interrupt storm which will cause system to hangs."
> > >
> > > We are using ARM embedded platform with Bootloader, Devicetree flow.
> > 
> > I read Thomas' comments as "in general it's better to use regular
> > interrupts, but we can live with chained interrupts if we have
> > control of bootloader, device tree, and kernel."
> > 
> > I guess my questions are more like:
> > 
> >   - Could this be done with either chained interrupts or regular
> >     interrupts?
> >  - If so, what is the advantage to using chained interrupts?

> With regular interrupts, these interrupts are self-consumed
> interrupts (interrupt is handled within driver) but where as chained
> interrupts are not self consumed (interrupts are not handled within
> the driver, but forwarded to different driver for which the actual
> interrupt is raised) but these interrupts are demultiplexed and
> forwards interrupt to another subsystem by calling
> generic_handle_irq(). 
> 
> As, MSI generic handlers are consumed by Endpoints and end point
> drivers, chained handlers forward the interrupt to the specific EP
> driver (For example NVME subsystem or any other subsystem).

This doesn't really explain it for me, probably because of my IRQ
ignorance.

I compared xilinx_pl_dma (which uses chained interrupts) with
pci-aardvark.c (which does not).

  - xilinx_pl_dma_pcie_setup_irq() calls platform_get_irq(0) once and
    sets up xilinx_pl_dma_pcie_event_flow() as the handler.

  - advk_pcie_probe() calls platform_get_irq(0) once and sets up
    advk_pcie_irq_handler() as the handler.

  - xilinx_pl_dma_pcie_event_flow() reads XILINX_PCIE_DMA_REG_IDR to
    learn which interrupts are pending and calls
    generic_handle_domain_irq() for each.

  - advk_pcie_irq_handler() calls advk_pcie_handle_int(), which reads
    PCIE_ISR0_REG and PCIE_ISR1_REG to learn which interrupts are
    pending and calls generic_handle_domain_irq() for each.

It seems like both drivers do essentially the same thing, but
xilinx_pl_dma_pcie_event_flow() is a chained handler and
advk_pcie_irq_handler() is not.

Is there some underlying difference in the way the hardware works that
means xilinx_pl_dma needs a chained handler while aardvark does not?

Bjorn
