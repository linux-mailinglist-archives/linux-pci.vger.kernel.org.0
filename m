Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A83B60962
	for <lists+linux-pci@lfdr.de>; Fri,  5 Jul 2019 17:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbfGEPdT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 5 Jul 2019 11:33:19 -0400
Received: from foss.arm.com ([217.140.110.172]:42170 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725497AbfGEPdT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 5 Jul 2019 11:33:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5F03128;
        Fri,  5 Jul 2019 08:33:18 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 415953F246;
        Fri,  5 Jul 2019 08:33:17 -0700 (PDT)
Date:   Fri, 5 Jul 2019 16:33:14 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Marek Vasut <marex@denx.de>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Sasha Levin <sashal@kernel.org>,
        Sven Van Asbroeck <TheSven73@googlemail.com>,
        Trent Piepho <tpiepho@impinj.com>
Subject: Re: [PATCH] PCI: imx: Allow iMX PCIe driver on iMX6SX
Message-ID: <20190705153314.GB6284@e121166-lin.cambridge.arm.com>
References: <20190630205307.27360-1-marex@denx.de>
 <1562073505.2321.3.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1562073505.2321.3.camel@pengutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 02, 2019 at 03:18:25PM +0200, Lucas Stach wrote:
> Hi Marek,
> 
> Am Sonntag, den 30.06.2019, 22:53 +0200 schrieb Marek Vasut:
> > The driver supports iMX6SX, align the Kconfig file with the driver.
> 
> The patch "PCI: Kconfig: Simplify PCI_IMX6 depends on", which will
> hopefully hit mainline pretty soon now after it got lost in the cracks
> of my inbox for far too long, is a more complete solution to the same
> problem.

If so can you ACK it

https://patchwork.ozlabs.org/patch/1054789/

please ? At the same time, I will drop this patch from the PCI queue.

Thanks,
Lorenzo

> Regards,
> Lucas
> 
> > Signed-off-by: Marek Vasut <marex@denx.de>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Cc: Lucas Stach <l.stach@pengutronix.de>
> > Cc: Richard Zhu <hongxing.zhu@nxp.com>
> > Cc: Sasha Levin <sashal@kernel.org>
> > Cc: Sven Van Asbroeck <TheSven73@googlemail.com>
> > Cc: Trent Piepho <tpiepho@impinj.com>
> > ---
> >  drivers/pci/controller/dwc/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> > index a6ce1ee51b4c..3051387bf4f3 100644
> > --- a/drivers/pci/controller/dwc/Kconfig
> > +++ b/drivers/pci/controller/dwc/Kconfig
> > @@ -90,7 +90,7 @@ config PCI_EXYNOS
> >  
> >  config PCI_IMX6
> >  	bool "Freescale i.MX6/7/8 PCIe controller"
> > -	depends on SOC_IMX6Q || SOC_IMX7D || (ARM64 && ARCH_MXC) || COMPILE_TEST
> > +	depends on SOC_IMX6SX || SOC_IMX6Q || SOC_IMX7D || (ARM64 && ARCH_MXC) || COMPILE_TEST
> >  	depends on PCI_MSI_IRQ_DOMAIN
> >  	select PCIE_DW_HOST
> >  
