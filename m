Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA428609C4
	for <lists+linux-pci@lfdr.de>; Fri,  5 Jul 2019 17:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbfGEPvN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 5 Jul 2019 11:51:13 -0400
Received: from foss.arm.com ([217.140.110.172]:42870 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726555AbfGEPvN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 5 Jul 2019 11:51:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9C1FE28;
        Fri,  5 Jul 2019 08:51:12 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 624CE3F246;
        Fri,  5 Jul 2019 08:51:11 -0700 (PDT)
Date:   Fri, 5 Jul 2019 16:51:06 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Trent Piepho <tpiepho@impinj.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Stefan Agner <stefan@agner.ch>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI: imx6: Simplify Kconfig depends on
Message-ID: <20190705155106.GA7454@e121166-lin.cambridge.arm.com>
References: <e3fd8e88a22468be8bd8fce85dafcc14f2e6a618.1552330407.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3fd8e88a22468be8bd8fce85dafcc14f2e6a618.1552330407.git.leonard.crestez@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 11, 2019 at 06:59:28PM +0000, Leonard Crestez wrote:
> In theory this driver can be used on imx6sx without enabling support for
> imx6q or imx7d but the "depends on" condition doesn't allow that.
> 
> Instead of making the condition even longer just make it depend on
> "ARCH_MXC || COMPILE_TEST" instead.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> ---
>  drivers/pci/controller/dwc/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to pci/dwc for v5.3, thanks.

Lorenzo

> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> index 6ea74b1c0d94..21747fd0e799 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -88,11 +88,11 @@ config PCI_EXYNOS
>  	depends on PCI_MSI_IRQ_DOMAIN
>  	select PCIE_DW_HOST
>  
>  config PCI_IMX6
>  	bool "Freescale i.MX6/7/8 PCIe controller"
> -	depends on SOC_IMX6Q || SOC_IMX7D || (ARM64 && ARCH_MXC) || COMPILE_TEST
> +	depends on ARCH_MXC || COMPILE_TEST
>  	depends on PCI_MSI_IRQ_DOMAIN
>  	select PCIE_DW_HOST
>  
>  config PCIE_SPEAR13XX
>  	bool "STMicroelectronics SPEAr PCIe controller"
> -- 
> 2.17.1
> 
