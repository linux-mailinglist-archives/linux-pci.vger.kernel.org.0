Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00E6F48C892
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jan 2022 17:36:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239650AbiALQgv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Jan 2022 11:36:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241648AbiALQgu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Jan 2022 11:36:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A7F0C06173F
        for <linux-pci@vger.kernel.org>; Wed, 12 Jan 2022 08:36:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 37EE361A25
        for <linux-pci@vger.kernel.org>; Wed, 12 Jan 2022 16:36:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 512F1C36AEC;
        Wed, 12 Jan 2022 16:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642005408;
        bh=z0NrgrDZxXQhxjF+KrOmjXY7tFJXiEbHhMQET5kiCHQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=tuih5OWwsIcgOszmOt+VRQvSnuGZ4VD6GK9Z5A36l/abDFRsJPJeYG4JnGYb92pJM
         asw80K6dTAewwyzBD0YsP0Rl9n5Wg5hVcQJ8HG+ezxWctrVF+l8+BEunAbaAL2QGzy
         5Dgmh/FdvDrM6O10//20L6uZjRBaFLYsfEuaqlgOwht1EBLkBV9JhD8GFNj+7YzNa9
         49MbOZ912SGRVGtr2QVuhwSSvkKgooPB0DGSUs09cxxI1osnXNM26OAryTslC8jcjt
         cvMgYTM9fWqrzTO3QkbgSUFAIFopaqYwHvFXmeR26bcAqBD/oJZa3ZJZTaBYqcJ5BF
         fTqds02lcDHtg==
Date:   Wed, 12 Jan 2022 10:36:46 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Stefan Roese <sr@denx.de>, linux-pci@vger.kernel.org,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>
Subject: Re: [RESEND PATCH v2 3/4] PCI/portdrv: Check platform supported
 service IRQ's
Message-ID: <20220112163646.GA263326@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220112103402.ldeqff3dlxi2azgn@pali>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 12, 2022 at 11:34:02AM +0100, Pali Rohár wrote:
> On Wednesday 12 January 2022 10:42:50 Stefan Roese wrote:
> > From: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> > 
> > Platforms may have dedicated IRQ lines for PCIe services like
> > AER/PME etc., check for such IRQ lines.
> > Check if platform has any dedicated IRQ lines for PCIe
> > services.

Use the terminology from the spec again ("platform-specific System
Errors").

> > Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> > Signed-off-by: Stefan Roese <sr@denx.de>
> > Tested-by: Stefan Roese <sr@denx.de>
> > Cc: Bjorn Helgaas <helgaas@kernel.org>
> > Cc: Pali Rohár <pali@kernel.org>
> > Cc: Michal Simek <michal.simek@xilinx.com>
> > ---
> >  drivers/pci/pcie/portdrv_core.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
> > index bda630889f95..70dd45671ed8 100644
> > --- a/drivers/pci/pcie/portdrv_core.c
> > +++ b/drivers/pci/pcie/portdrv_core.c
> > @@ -358,6 +358,14 @@ int pcie_port_device_register(struct pci_dev *dev)
> >  		}
> >  	}
> >  
> > +	/*
> > +	 * Some platforms have dedicated interrupt line from root complex to
> > +	 * interrupt controller for PCIe services like AER/PME etc., check
> > +	 * if platform registered with any such IRQ.
> > +	 */
> > +	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT)
> > +		pci_check_platform_service_irqs(dev, irqs, capabilities);
> > +
> 
> In my opinion calling this hook at this stage is too late. Few lines
> above is following code:
> 
> 	if (irq_services) {
> 		/*
> 		 * Initialize service IRQs. Don't use service devices that
> 		 * require interrupts if there is no way to generate them.
> 		 * However, some drivers may have a polling mode (e.g.
> 		 * pciehp_poll_mode) that can be used in the absence of IRQs.
> 		 * Allow them to determine if that is to be used.
> 		 */
> 		status = pcie_init_service_irqs(dev, irqs, irq_services);
> 		if (status) {
> 			irq_services &= PCIE_PORT_SERVICE_HP;
> 			if (!irq_services)
> 				goto error_disable;
> 		}
> 	}
> 
> Function pcie_init_service_irqs() fails if "dev" does not have any
> suitable interrupt. Which happens for devices / root ports without
> support for standard interrupts (INTx / MSI).
> 
> I think that this new hook should have preference over
> pcie_init_service_irqs() and after this new hook should be
> pcie_init_service_irqs() called only for irq_services which new hook has
> not filled. And if at least new hook or pcie_init_service_irqs() passes
> then "error_disable" path should not be called.

I tend to agree.  I expect that a host bridge will only use this new
mechanism if the standard INTx/MSI interrupts don't work.  

I guess it's possible a device could use platform-specific errors for
some services and standard INTx/MSI for others, but unless we have an
example of that, I'm not sure it's worth trying to support that.

For now, I think it will be simpler to skip pcie_init_service_irqs()
completely if the platform-specific hook is successful.

Bjorn
