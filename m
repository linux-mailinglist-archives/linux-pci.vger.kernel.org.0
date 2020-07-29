Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4133B2324DA
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jul 2020 20:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgG2SsN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jul 2020 14:48:13 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:43190 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgG2SsN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Jul 2020 14:48:13 -0400
Received: by mail-io1-f65.google.com with SMTP id k23so25594253iom.10;
        Wed, 29 Jul 2020 11:48:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=86wzVwARCnvB4VvS8GaiyYladnSK6F8nyeRAcDRPX1Q=;
        b=og/62zrsCsDLda5iC83XcWHIRL6iVafeRtT5n4yHpdd6iTaB4RbyrlxNXi3ZpWPGNy
         Cgag0nmUge7+Ty1XkLQIwURReyi+un4/mmIBzY/AsKyJOH59QQB4mGu77HkqBechORR8
         8sx4NJNd4Brk5wP6HHrU/yEXkvfD9IWmTXLjOsn/6gwRUj7O5EGnbcAKAruPmECH24D4
         r5xw7Bo7gF8E8mGQ6XS632kfDwOgikU3iLTOakJXnwH5cXRLHWlFD1XAoH+/NYBz3wpv
         GwmDRm2wid4nm2khJvvh4twMyMXmgw5p80+l7thHVsL+xxbfOeRs2Q4RtZ82UpwLZ0vR
         qFOQ==
X-Gm-Message-State: AOAM530I7Y8Yi7Jrc8xUwMgzaH3RKYfqArz4h08XlODxDsMq8n9KBXrt
        FMN8GdjFsS7MQ4GRYfIK9A==
X-Google-Smtp-Source: ABdhPJwgwuy0pDlaSXWmtP5I+Zqw0S9AQViNseOQQ+EU0oaswOCUFKUX7Cl1E1bYP4sF81QLx0+7rw==
X-Received: by 2002:a02:a389:: with SMTP id y9mr11786511jak.82.1596048492396;
        Wed, 29 Jul 2020 11:48:12 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id v87sm976014ilk.33.2020.07.29.11.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 11:48:11 -0700 (PDT)
Received: (nullmailer pid 582408 invoked by uid 1000);
        Wed, 29 Jul 2020 18:48:09 -0000
Date:   Wed, 29 Jul 2020 12:48:09 -0600
From:   Rob Herring <robh@kernel.org>
To:     Marek =?iso-8859-1?Q?Beh=FAn?= <marek.behun@nic.cz>
Cc:     linux-pci@vger.kernel.org, Tomasz Maciej Nowak <tmn505@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Xogium <contact@xogium.me>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Subject: Re: [PATCH 4/5] PCI: aardvark: Implement driver 'remove' function
 and allow to build it as module
Message-ID: <20200729184809.GA569408@bogus>
References: <20200715142557.17115-1-marek.behun@nic.cz>
 <20200715142557.17115-5-marek.behun@nic.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200715142557.17115-5-marek.behun@nic.cz>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 15, 2020 at 04:25:56PM +0200, Marek Behún wrote:
> From: Pali Rohár <pali@kernel.org>
> 
> Providing driver's 'remove' function allows kernel to bind and unbind devices
> from aardvark driver. It also allows to build aardvark driver as a module.
> 
> Compiling aardvark as a module simplifies development and debugging of
> this driver as it can be reloaded at runtime without the need to reboot
> to new kernel.
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>
> Reviewed-by: Marek Behún <marek.behun@nic.cz>
> ---
>  drivers/pci/controller/Kconfig        |  2 +-
>  drivers/pci/controller/pci-aardvark.c | 25 ++++++++++++++++++++++---
>  2 files changed, 23 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
> index adddf21fa381..f9da5ff2c517 100644
> --- a/drivers/pci/controller/Kconfig
> +++ b/drivers/pci/controller/Kconfig
> @@ -12,7 +12,7 @@ config PCI_MVEBU
>  	select PCI_BRIDGE_EMUL
>  
>  config PCI_AARDVARK
> -	bool "Aardvark PCIe controller"
> +	tristate "Aardvark PCIe controller"
>  	depends on (ARCH_MVEBU && ARM64) || COMPILE_TEST
>  	depends on OF
>  	depends on PCI_MSI_IRQ_DOMAIN
> diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
> index d5f58684d962..0a5aa6d77f5d 100644
> --- a/drivers/pci/controller/pci-aardvark.c
> +++ b/drivers/pci/controller/pci-aardvark.c
> @@ -14,6 +14,7 @@
>  #include <linux/irq.h>
>  #include <linux/irqdomain.h>
>  #include <linux/kernel.h>
> +#include <linux/module.h>
>  #include <linux/pci.h>
>  #include <linux/init.h>
>  #include <linux/phy/phy.h>
> @@ -1114,6 +1115,7 @@ static int advk_pcie_probe(struct platform_device *pdev)
>  
>  	pcie = pci_host_bridge_priv(bridge);
>  	pcie->pdev = pdev;
> +	platform_set_drvdata(pdev, pcie);
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	pcie->base = devm_ioremap_resource(dev, res);
> @@ -1204,18 +1206,35 @@ static int advk_pcie_probe(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +static int advk_pcie_remove(struct platform_device *pdev)
> +{
> +	struct advk_pcie *pcie = platform_get_drvdata(pdev);
> +	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(pcie);
> +
> +	pci_stop_root_bus(bridge->bus);
> +	pci_remove_root_bus(bridge->bus);

Based on pci_host_common_remove() implementation, doesn't this need a 
lock around it (pci_lock_rescan_remove)?

We should probably have a common function (say pci_bridge_remove) to 
implement this. You could use pci_host_common_remove(), but you'd have 
to adjust drvdata.

> +
> +	advk_pcie_remove_msi_irq_domain(pcie);
> +	advk_pcie_remove_irq_domain(pcie);
> +
> +	return 0;
> +}
> +
>  static const struct of_device_id advk_pcie_of_match_table[] = {
>  	{ .compatible = "marvell,armada-3700-pcie", },
>  	{},
>  };
> +MODULE_DEVICE_TABLE(of, advk_pcie_of_match_table);
>  
>  static struct platform_driver advk_pcie_driver = {
>  	.driver = {
>  		.name = "advk-pcie",
>  		.of_match_table = advk_pcie_of_match_table,
> -		/* Driver unloading/unbinding currently not supported */
> -		.suppress_bind_attrs = true,
>  	},
>  	.probe = advk_pcie_probe,
> +	.remove = advk_pcie_remove,
>  };
> -builtin_platform_driver(advk_pcie_driver);
> +module_platform_driver(advk_pcie_driver);
> +
> +MODULE_DESCRIPTION("Aardvark PCIe controller");
> +MODULE_LICENSE("GPL v2");
> -- 
> 2.26.2
> 
