Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3B4D2FEF3
	for <lists+linux-pci@lfdr.de>; Thu, 30 May 2019 17:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbfE3PIp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 May 2019 11:08:45 -0400
Received: from foss.arm.com ([217.140.101.70]:38142 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725934AbfE3PIp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 30 May 2019 11:08:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3046F341;
        Thu, 30 May 2019 08:08:45 -0700 (PDT)
Received: from redmoon (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F1C093F59C;
        Thu, 30 May 2019 08:08:43 -0700 (PDT)
Date:   Thu, 30 May 2019 16:08:41 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Ley Foon Tan <ley.foon.tan@intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        lftan.linux@gmail.com
Subject: Re: [PATCH] PCI: altera-msi: Allow building as module
Message-ID: <20190530150841.GC13993@redmoon>
References: <1556081835-12921-1-git-send-email-ley.foon.tan@intel.com>
 <1556081835-12921-2-git-send-email-ley.foon.tan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556081835-12921-2-git-send-email-ley.foon.tan@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 24, 2019 at 12:57:15PM +0800, Ley Foon Tan wrote:
> Altera MSI IP is a soft IP and is only available after
> FPGA image is programmed.
> 
> Make driver modulable to support use case FPGA image is programmed
> after kernel is booted. User proram FPGA image in kernel then only load
> MSI driver module.
> 
> Signed-off-by: Ley Foon Tan <ley.foon.tan@intel.com>
> ---
>  drivers/pci/controller/Kconfig           |  2 +-
>  drivers/pci/controller/pcie-altera-msi.c | 10 ++++++++++
>  2 files changed, 11 insertions(+), 1 deletion(-)

Applied to pci/altera for v5.3, thanks.

Lorenzo

> diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
> index 4b550f9cdd56..920546cb84e2 100644
> --- a/drivers/pci/controller/Kconfig
> +++ b/drivers/pci/controller/Kconfig
> @@ -181,7 +181,7 @@ config PCIE_ALTERA
>  	  FPGA.
>  
>  config PCIE_ALTERA_MSI
> -	bool "Altera PCIe MSI feature"
> +	tristate "Altera PCIe MSI feature"
>  	depends on PCIE_ALTERA
>  	depends on PCI_MSI_IRQ_DOMAIN
>  	help
> diff --git a/drivers/pci/controller/pcie-altera-msi.c b/drivers/pci/controller/pcie-altera-msi.c
> index 025ef7d9a046..16d938920ca5 100644
> --- a/drivers/pci/controller/pcie-altera-msi.c
> +++ b/drivers/pci/controller/pcie-altera-msi.c
> @@ -10,6 +10,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/irqchip/chained_irq.h>
>  #include <linux/init.h>
> +#include <linux/module.h>
>  #include <linux/msi.h>
>  #include <linux/of_address.h>
>  #include <linux/of_irq.h>
> @@ -288,4 +289,13 @@ static int __init altera_msi_init(void)
>  {
>  	return platform_driver_register(&altera_msi_driver);
>  }
> +
> +static void __exit altera_msi_exit(void)
> +{
> +	platform_driver_unregister(&altera_msi_driver);
> +}
> +
>  subsys_initcall(altera_msi_init);
> +MODULE_DEVICE_TABLE(of, altera_msi_of_match);
> +module_exit(altera_msi_exit);
> +MODULE_LICENSE("GPL v2");
> -- 
> 2.19.0
> 
