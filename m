Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 751481EBE4C
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jun 2020 16:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725958AbgFBOjP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Jun 2020 10:39:15 -0400
Received: from foss.arm.com ([217.140.110.172]:51734 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725919AbgFBOjO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 2 Jun 2020 10:39:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 57FED1FB;
        Tue,  2 Jun 2020 07:39:14 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5A2E73F305;
        Tue,  2 Jun 2020 07:39:13 -0700 (PDT)
Date:   Tue, 2 Jun 2020 15:38:12 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     robh@kernel.org, bhelgaas@google.com,
        hayashi.kunihiko@socionext.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] PCI: uniphier: Fix Kconfig warning
Message-ID: <20200602143812.GA26880@e121166-lin.cambridge.arm.com>
References: <20200602131033.41780-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200602131033.41780-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 02, 2020 at 09:10:33PM +0800, YueHaibing wrote:
> WARNING: unmet direct dependencies detected for PCIE_DW_EP
>   Depends on [n]: PCI [=y] && PCI_ENDPOINT [=n]
>   Selected by [y]:
>   - PCIE_UNIPHIER_EP [=y] && PCI [=y] && (ARCH_UNIPHIER || COMPILE_TEST [=y]) && OF [=y] && HAS_IOMEM [=y]
> 
> Add missing dependency to fix this.
> 
> Fixes: 006564dee825 ("PCI: uniphier: Add Socionext UniPhier Pro5 PCIe endpoint controller driver")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/pci/controller/dwc/Kconfig | 1 +
>  1 file changed, 1 insertion(+)

Squashed in the commit it is fixing, thanks !

Lorenzo

> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> index 43a29f7a4501..044a3761c44f 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -293,6 +293,7 @@ config PCIE_UNIPHIER_EP
>  	bool "Socionext UniPhier PCIe endpoint controllers"
>  	depends on ARCH_UNIPHIER || COMPILE_TEST
>  	depends on OF && HAS_IOMEM
> +	depends on PCI_ENDPOINT
>  	select PCIE_DW_EP
>  	help
>  	  Say Y here if you want PCIe endpoint controller support on
> -- 
> 2.17.1
> 
> 
