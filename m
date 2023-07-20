Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D329875B26F
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jul 2023 17:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232071AbjGTPYG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Jul 2023 11:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232515AbjGTPYF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Jul 2023 11:24:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1F813E;
        Thu, 20 Jul 2023 08:24:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 99EEF61B4C;
        Thu, 20 Jul 2023 15:24:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D009DC433C8;
        Thu, 20 Jul 2023 15:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689866643;
        bh=A9ffLkHP3EeJtWxJ/R0wqfZkmpfeCi3q5f4HAbNpLUs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=E5ix1vEBK3ECDKaX/NVb7PYydIW8QhdbkjT2ocNoka284gQjrgp9wFUORUSOpkpio
         +O6I2kp27YgvAXhnFY/8V9WroAuxs7K6DkFG3ysWeYrypld4juqa2nzOnOd2KTCMWo
         1c78ge0WkNgCXuXO/jUXrqs+54T0AgB80q9FfxObW7Uj8MwG/KTXCQ/xyggnxTpJ2y
         NYZ2RuwecYUMz3uRBY1S4c36lj9/Gt+EdGnVfsQvJPJ50PyReqbxqyxBuChtbqHwUP
         5hIlVX1ctzu0yC5YvE1yOvMd3LHoZ2XrWWlV9jxc1jsbfEvUGHQ5vlNw/n2MVepr68
         57COOMXu1/tfQ==
Date:   Thu, 20 Jul 2023 10:24:01 -0500
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
Message-ID: <20230720152401.GA523764@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN7PR12MB7201A03526C04788709167A48B3EA@SN7PR12MB7201.namprd12.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Thomas in case he wants to comment on chained interrupts]

On Thu, Jul 20, 2023 at 06:37:03AM +0000, Havalige, Thippeswamy wrote:
> > From: Bjorn Helgaas <helgaas@kernel.org>
> > ...
> > On Wed, Jun 28, 2023 at 02:58:12PM +0530, Thippeswamy Havalige wrote:
> > > Add support for Xilinx XDMA Soft IP core as Root Port.
> > > ...

> > > + * struct pl_dma_pcie - PCIe port information
> > > + * @intx_domain: Legacy IRQ domain pointer
> > > + * @pldma_domain: PL DMA IRQ domain pointer
> > > + * @irq_misc: Legacy and error interrupt number
> > > + * @intx_irq: legacy interrupt number

> > "Legacy and error interrupt number" and "legacy interrupt number"
> > sound like they overlap -- "legacy interrupt number" is part of both.
> > Is that an error?
>
> - Agreed, I'll modify this comment to legacy interrupt number. (This
> irq line is for both legacy interrupts and error interrupt bits)

Does "legacy" mean "INTx" in this context?  If so, I'd use "INTx"
because it's much more specific.  "Legacy" really doesn't contain any
information other than "this is something retained for some kind of
backward compatibility."

If you have more detail about the "error interrupt," that would be
useful as well.  Does this refer to an AER interrupt, a "System
Error", something else?  I'm looking at the diagram in PCIe r6.0,
Figure 6-3, wondering if this is related to anything there.  I suppose
likely it's some Xilinx-specific thing?

> > > +	/* Plug the INTx chained handler */
> > > +	irq_set_chained_handler_and_data(port->intx_irq,
> > > +					 xilinx_pl_dma_pcie_intx_flow, port);
> > > +
> > > +	/* Plug the main event chained handler */
> > > +	irq_set_chained_handler_and_data(port->irq,
> > > +					 xilinx_pl_dma_pcie_event_flow,
> > port);
> > 
> > What's the reason for using chained IRQs?  Can this be done
> > without them?  I don't claim to understand all the issues here,
> > but it seems better to avoid chained IRQ handlers when possible:
> > https://lore.kernel.org/all/877csohcll.ffs@tglx/

> - As per the comments in this
> https://lkml.kernel.org/lkml/alpine.DEB.2.20.1705232307330.2409@nanos/T/
> "It is fine to have chained interrupts when bootloader, device tree
> and kernel under control. Only if BIOS/UEFI comes into play the user
> is helpless against interrupt storm which will cause system to
> hangs."
> 
> We are using ARM embedded platform with Bootloader, Devicetree flow.

I read Thomas' comments as "in general it's better to use regular
interrupts, but we can live with chained interrupts if we have control
of bootloader, device tree, and kernel."

I guess my questions are more like:

  - Could this be done with either chained interrupts or regular
    interrupts?

  - If so, what is the advantage to using chained interrupts?

Across the entire kernel, irq_set_chained_handler_and_data() is
relatively unusual, which makes me think it may be better to use the
more common path if it's possible.

Bjorn
