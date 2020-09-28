Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05DEF27B1F3
	for <lists+linux-pci@lfdr.de>; Mon, 28 Sep 2020 18:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbgI1Qer (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Sep 2020 12:34:47 -0400
Received: from foss.arm.com ([217.140.110.172]:54528 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726466AbgI1Qer (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 28 Sep 2020 12:34:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 89EA631B;
        Mon, 28 Sep 2020 09:34:46 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A45063F6CF;
        Mon, 28 Sep 2020 09:34:45 -0700 (PDT)
Date:   Mon, 28 Sep 2020 17:34:40 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     linux-pci@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yue Wang <yue.wang@amlogic.com>
Subject: Re: [PATCH] pci: meson: build as module by default
Message-ID: <20200928163440.GA16986@e121166-lin.cambridge.arm.com>
References: <20200918181251.32423-1-khilman@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200918181251.32423-1-khilman@baylibre.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 18, 2020 at 11:12:51AM -0700, Kevin Hilman wrote:
> Enable pci-meson to build as a module whenever ARCH_MESON is enabled.
> 
> Cc: Yue Wang <yue.wang@amlogic.com>
> Signed-off-by: Kevin Hilman <khilman@baylibre.com>
> ---
> Tested on Khadas VIM3 and Khadas VIM3 using NVMe SSD devices.
> 
>  drivers/pci/controller/dwc/Kconfig     | 3 ++-
>  drivers/pci/controller/dwc/pci-meson.c | 8 +++++++-
>  2 files changed, 9 insertions(+), 2 deletions(-)

Applied to pci/meson, thanks.

Lorenzo

> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> index 044a3761c44f..bc049865f8e0 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -237,8 +237,9 @@ config PCIE_HISI_STB
>  	  Say Y here if you want PCIe controller support on HiSilicon STB SoCs
>  
>  config PCI_MESON
> -	bool "MESON PCIe controller"
> +	tristate "MESON PCIe controller"
>  	depends on PCI_MSI_IRQ_DOMAIN
> +	default m if ARCH_MESON
>  	select PCIE_DW_HOST
>  	help
>  	  Say Y here if you want to enable PCI controller support on Amlogic
> diff --git a/drivers/pci/controller/dwc/pci-meson.c b/drivers/pci/controller/dwc/pci-meson.c
> index 4f183b96afbb..7a1fb55ee44a 100644
> --- a/drivers/pci/controller/dwc/pci-meson.c
> +++ b/drivers/pci/controller/dwc/pci-meson.c
> @@ -17,6 +17,7 @@
>  #include <linux/resource.h>
>  #include <linux/types.h>
>  #include <linux/phy/phy.h>
> +#include <linux/module.h>
>  
>  #include "pcie-designware.h"
>  
> @@ -589,6 +590,7 @@ static const struct of_device_id meson_pcie_of_match[] = {
>  	},
>  	{},
>  };
> +MODULE_DEVICE_TABLE(of, meson_pcie_of_match);
>  
>  static struct platform_driver meson_pcie_driver = {
>  	.probe = meson_pcie_probe,
> @@ -598,4 +600,8 @@ static struct platform_driver meson_pcie_driver = {
>  	},
>  };
>  
> -builtin_platform_driver(meson_pcie_driver);
> +module_platform_driver(meson_pcie_driver);
> +
> +MODULE_AUTHOR("Yue Wang <yue.wang@amlogic.com>");
> +MODULE_DESCRIPTION("Amlogic PCIe Controller driver");
> +MODULE_LICENSE("Dual BSD/GPL");
> -- 
> 2.28.0
> 
