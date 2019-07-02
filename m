Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6387F5D05F
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jul 2019 15:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726432AbfGBNS3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Jul 2019 09:18:29 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:45179 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbfGBNS3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Jul 2019 09:18:29 -0400
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1hiIg0-0005JW-6V; Tue, 02 Jul 2019 15:18:28 +0200
Message-ID: <1562073505.2321.3.camel@pengutronix.de>
Subject: Re: [PATCH] PCI: imx: Allow iMX PCIe driver on iMX6SX
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Marek Vasut <marex@denx.de>, linux-pci@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Sasha Levin <sashal@kernel.org>,
        Sven Van Asbroeck <TheSven73@googlemail.com>,
        Trent Piepho <tpiepho@impinj.com>
Date:   Tue, 02 Jul 2019 15:18:25 +0200
In-Reply-To: <20190630205307.27360-1-marex@denx.de>
References: <20190630205307.27360-1-marex@denx.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Marek,

Am Sonntag, den 30.06.2019, 22:53 +0200 schrieb Marek Vasut:
> The driver supports iMX6SX, align the Kconfig file with the driver.

The patch "PCI: Kconfig: Simplify PCI_IMX6 depends on", which will
hopefully hit mainline pretty soon now after it got lost in the cracks
of my inbox for far too long, is a more complete solution to the same
problem.

Regards,
Lucas

> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Richard Zhu <hongxing.zhu@nxp.com>
> Cc: Sasha Levin <sashal@kernel.org>
> Cc: Sven Van Asbroeck <TheSven73@googlemail.com>
> Cc: Trent Piepho <tpiepho@impinj.com>
> ---
>  drivers/pci/controller/dwc/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> index a6ce1ee51b4c..3051387bf4f3 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -90,7 +90,7 @@ config PCI_EXYNOS
>  
>  config PCI_IMX6
>  	bool "Freescale i.MX6/7/8 PCIe controller"
> -	depends on SOC_IMX6Q || SOC_IMX7D || (ARM64 && ARCH_MXC) || COMPILE_TEST
> +	depends on SOC_IMX6SX || SOC_IMX6Q || SOC_IMX7D || (ARM64 && ARCH_MXC) || COMPILE_TEST
>  	depends on PCI_MSI_IRQ_DOMAIN
>  	select PCIE_DW_HOST
>  
