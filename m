Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 148E95376D4
	for <lists+linux-pci@lfdr.de>; Mon, 30 May 2022 10:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232889AbiE3IcN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 May 2022 04:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231432AbiE3IcM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 May 2022 04:32:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A20FD3A5F4
        for <linux-pci@vger.kernel.org>; Mon, 30 May 2022 01:32:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E66B60F2C
        for <linux-pci@vger.kernel.org>; Mon, 30 May 2022 08:32:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 348C2C385B8;
        Mon, 30 May 2022 08:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653899529;
        bh=du3wR4Z3ZceJSJpHUwtnR1HTIqt5nZ0dVhHfLo4pElg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AuPskjvjH4L6Dx23A0k5Px0Lb5Gm2zbbBO9IJ2ldW9+v36okVn4ARGtq72VYgiGp5
         f/8L92svLhkQMg08zM6nzKkUZ+Vm7zkCNNF+rpCQKA3O5vTo08W4V3BU1bE6cAW5bp
         DAid4uOqVkVXW8y6VJwS98RM+e/0qnqdVsYo8BQLHSZOXT2o/y5TSYb0g4fsmrX5lc
         usDrY81k70Dfdjr7LEbekiR/FBdQEX1wC+18j4nZ7cEjvIuyyHwT6IGvvWI4Ca7ppZ
         RqoYrDWE6FF6Fa2bTL5NhyqVDjfu2ZMPwrn3BYm0cf4qtoLwp1EbgVAcQcL+QeFe81
         5Cmkm1FGP6DFQ==
Received: by pali.im (Postfix)
        id 483BD731; Mon, 30 May 2022 10:32:06 +0200 (CEST)
Date:   Mon, 30 May 2022 10:32:06 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Stefan Roese <sr@denx.de>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH v4 1/2] PCI/portdrv: Add option to setup IRQs for
 platform-specific Service Errors
Message-ID: <20220530083206.nlsokp2hjivu53z5@pali>
References: <20220528000943.GA518055@bhelgaas>
 <f15c1c2c-0987-7b26-3fe4-38d449a35531@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f15c1c2c-0987-7b26-3fe4-38d449a35531@denx.de>
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

On Monday 30 May 2022 10:18:41 Stefan Roese wrote:
> On 28.05.22 02:09, Bjorn Helgaas wrote:
> > In subject line, I assume you mean "System Errors" instead of "Service
> > Errors"?
> 
> Background: I took over submitting this patchset from Bharat. Here his
> last revision:
> https://www.spinics.net/lists/kernel/msg2960164.html
> 
> Just to explain, that I didn't choose the naming.
> 
> To answer your question I personally think too, that "System Errors" is
> more appropriate than "Service Errors". But still this patchset replaces
> or better enhances the already present pcie_init_service_irqs() by a
> platform-specific version. I can only suspect, that this is the
> reasoning for this "Service" naming.

Hello! Based on the below text "Here the quote from Bharat's original
cover letter:" I think that the better naming should be: "Service
interrupts". Because it adds support for interrupts from PCIe services
like AER, PME or HP. Only AER are errors, other IRQs are just services.

> > On Fri, Jan 14, 2022 at 08:58:33AM +0100, Stefan Roese wrote:
> > > From: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> > > 
> > > As per section 6.2.4.1.2, 6.2.6 in PCIe r4.0 (and later versions),
> > > platform-specific System Errors like AER can be delivered via platform-
> > > specific interrupt lines.
> > 
> > IIUC, this refers to the top left branch in Figure 6-3 of PCIe r6.0,
> > sec 6.2.6, which shows "System Error (platform specific)" controlled
> > by "System Error Enables (one per error class) in the Root Control
> > register," i.e., the PCI_EXP_RTCTL_SECEE, PCI_EXP_RTCTL_SENFEE, and
> > PCI_EXP_RTCTL_SEFEE bits.
> > 
> > Where are those enable bits set?  The only references I see are to
> > them being cleared via SYSTEM_ERROR_INTR_ON_MESG_MASK in
> > aer_enable_rootport().
> 
> Interesting, thanks. Again, I didn't write the original commit text,
> so my comments are a bit "limited" here. Perhaps Bharat might have
> something add here?
> 
> > > This patch adds the init_platform_service_irqs() hook to struct
> > > pci_host_bridge, making it possible that platforms may implement this
> > > function to hook IRQs for these platform-specific System Errors, like
> > > AER.
> > > 
> > > If these platform-specific service IRQs have been successfully
> > > installed via pcie_init_platform_service_irqs(),
> > > pcie_init_service_irqs() is skipped.
> > > 
> > > Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> > > Signed-off-by: Stefan Roese <sr@denx.de>
> > > Cc: Bjorn Helgaas <helgaas@kernel.org>
> > > Cc: Pali Rohár <pali@kernel.org>
> > > Cc: Michal Simek <michal.simek@xilinx.com>
> > > ---
> > >   drivers/pci/pcie/portdrv_core.c | 39 ++++++++++++++++++++++++++++++++-
> > >   include/linux/pci.h             |  2 ++
> > >   2 files changed, 40 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
> > > index e7dcb1f23210..27b990cedb4c 100644
> > > --- a/drivers/pci/pcie/portdrv_core.c
> > > +++ b/drivers/pci/pcie/portdrv_core.c
> > > @@ -190,6 +190,31 @@ static int pcie_init_service_irqs(struct pci_dev *dev, int *irqs, int mask)
> > >   	return 0;
> > >   }
> > > +/**
> > > + * pcie_init_platform_service_irqs - initialize platform service irqs for
> > > + * platform-specific System Errors
> > > + * @dev: PCI Express port to handle
> > > + * @irqs: Array of irqs to populate
> > > + * @mask: Bitmask of capabilities
> > 
> > s/irqs/IRQs/ above (twice) for consistency.
> 
> Yes.
> 
> > > + * Return value: -ENODEV, in case no platform-specific IRQ is available
> > > + */
> > > +static int pcie_init_platform_service_irqs(struct pci_dev *dev,
> > > +					   int *irqs, int mask)
> > > +{
> > > +	struct pci_host_bridge *bridge;
> > > +
> > > +	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT) {
> > > +		bridge = pci_find_host_bridge(dev->bus);
> > > +		if (bridge && bridge->init_platform_service_irqs) {
> > > +			return bridge->init_platform_service_irqs(dev, irqs,
> > > +								  mask);
> > > +		}
> > > +	}
> > > +
> > > +	return -ENODEV;
> > > +}
> > > +
> > >   /**
> > >    * get_port_device_capability - discover capabilities of a PCI Express port
> > >    * @dev: PCI Express port to examine
> > > @@ -335,7 +360,19 @@ int pcie_port_device_register(struct pci_dev *dev)
> > >   		irq_services |= PCIE_PORT_SERVICE_DPC;
> > >   	irq_services &= capabilities;
> > > -	if (irq_services) {
> > > +	/*
> > > +	 * Some platforms have dedicated interrupts from root complex to
> > > +	 * interrupt controller for PCIe platform-specific System Errors
> > > +	 * like AER/PME etc., check if the platform registered with any such
> > > +	 * IRQ.
> > 
> > I don't see "PME etc" mentioned in the spec sections you cite.
> > 6.2.4.1.2 and 6.2.6 only cover interrupts in response to error
> > Messages.  Are there other sections that cover PME and whatever other
> > interrupts you have in mind?
> 
> Bharat?
> 
> > 6.7.3.4 ("Software Notification of Hot-Plug Events") talks about PME
> > and Hot-Plug Event interrupts, but these aren't errors, and I only see
> > signaling via INTx, MSI, or MSI-X.  Is there provision for a different
> > method?
> 
> Here the quote from Bharat's original cover letter:
> "Some platforms have dedicated IRQ lines for PCIe services like AER/PME
> etc. The root complex on these platform will use these seperate IRQ
> lines to report AER/PME etc., interrupts and will not generate MSI/
> MSI-X/INTx interrupts for these services.

This is the best explanation of this change.

> These patches will add new method for these kind of platforms to
> register the platform IRQ number with respective PCIe services."
> 
> To sum it up, on our Xilinx ZynqMP platform this patch series is needed
> to deliver AER related interrupts. As this SoC needs this platform
> specific IRQ line for signalling of these events.
> 
> > > +	 */
> > > +	status = pcie_init_platform_service_irqs(dev, irqs, capabilities);
> > > +
> > > +	/*
> > > +	 * Only install service irqs, when the platform-specific hook was
> > > +	 * unsuccessful
> > 
> > s/irqs/IRQs/ again.
> 
> Yes.
> 
> Thanks,
> Stefan
> 
> > > +	 */
> > > +	if (irq_services && status) {
> > >   		/*
> > >   		 * Initialize service IRQs. Don't use service devices that
> > >   		 * require interrupts if there is no way to generate them.
> > > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > > index 18a75c8e615c..fb8aad3cb460 100644
> > > --- a/include/linux/pci.h
> > > +++ b/include/linux/pci.h
> > > @@ -554,6 +554,8 @@ struct pci_host_bridge {
> > >   	u8 (*swizzle_irq)(struct pci_dev *, u8 *); /* Platform IRQ swizzler */
> > >   	int (*map_irq)(const struct pci_dev *, u8, u8);
> > >   	void (*release_fn)(struct pci_host_bridge *);
> > > +	int (*init_platform_service_irqs)(struct pci_dev *dev, int *irqs,
> > > +					  int plat_mask);
> > >   	void		*release_data;
> > >   	unsigned int	ignore_reset_delay:1;	/* For entire hierarchy */
> > >   	unsigned int	no_ext_tags:1;		/* No Extended Tags */
> > > -- 
> > > 2.34.1
> > > 
