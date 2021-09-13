Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91F94408B26
	for <lists+linux-pci@lfdr.de>; Mon, 13 Sep 2021 14:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236117AbhIMMkv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Sep 2021 08:40:51 -0400
Received: from foss.arm.com ([217.140.110.172]:57388 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235269AbhIMMkv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 13 Sep 2021 08:40:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 429F531B;
        Mon, 13 Sep 2021 05:39:35 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0CA3B3F59C;
        Mon, 13 Sep 2021 05:39:33 -0700 (PDT)
Date:   Mon, 13 Sep 2021 13:39:27 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     marek.vasut@gmail.com, bhelgaas@google.com,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-pci@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa@the-dreams.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] PCI: rcar: Add missing COMMON_CLK dependency
Message-ID: <20210913123927.GA6013@lpieralisi>
References: <20210907144512.5238-1-marek.vasut@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210907144512.5238-1-marek.vasut@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 07, 2021 at 04:45:12PM +0200, marek.vasut@gmail.com wrote:
> From: Marek Vasut <marek.vasut+renesas@gmail.com>
> 
> Add COMMON_CLK dependency, otherwise the following build error occurs:
>   arm-linux-gnueabi-ld: drivers/pci/controller/pcie-rcar-host.o: in function `rcar_pcie_aarch32_abort_handler':
>   pcie-rcar-host.c:(.text+0xdd0): undefined reference to `__clk_is_enabled'
> This should be OK, since all platforms shipping this controller also
> need COMMON_CLK enabled for their clock driver.
> 
> Fixes: a115b1bd3af0 ("PCI: rcar: Add L1 link state fix into data abort hook")
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Cc: linux-renesas-soc@vger.kernel.org
> ---
> +CC Stephen, please double-check whether this is the right approach or
>     whether there is some better option

Hi Stephen,

can you please have a look into this please to see if there is a better
way of fixing this breakage ? We should aim for one of the upcoming rcX,
thank you very much.

Lorenzo

> ---
>  drivers/pci/controller/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
> index 326f7d13024f..ee6f5e525d3a 100644
> --- a/drivers/pci/controller/Kconfig
> +++ b/drivers/pci/controller/Kconfig
> @@ -66,6 +66,7 @@ config PCI_RCAR_GEN2
>  config PCIE_RCAR_HOST
>  	bool "Renesas R-Car PCIe host controller"
>  	depends on ARCH_RENESAS || COMPILE_TEST
> +	depends on COMMON_CLK
>  	depends on PCI_MSI_IRQ_DOMAIN
>  	help
>  	  Say Y here if you want PCIe controller support on R-Car SoCs in host
> @@ -74,6 +75,7 @@ config PCIE_RCAR_HOST
>  config PCIE_RCAR_EP
>  	bool "Renesas R-Car PCIe endpoint controller"
>  	depends on ARCH_RENESAS || COMPILE_TEST
> +	depends on COMMON_CLK
>  	depends on PCI_ENDPOINT
>  	help
>  	  Say Y here if you want PCIe controller support on R-Car SoCs in
> -- 
> 2.33.0
> 
