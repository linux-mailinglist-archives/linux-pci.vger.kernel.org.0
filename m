Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ACD04112A2
	for <lists+linux-pci@lfdr.de>; Mon, 20 Sep 2021 12:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbhITKLH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Sep 2021 06:11:07 -0400
Received: from foss.arm.com ([217.140.110.172]:45336 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233090AbhITKLB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 20 Sep 2021 06:11:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2C2C431B;
        Mon, 20 Sep 2021 03:09:35 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CF0AC3F59C;
        Mon, 20 Sep 2021 03:09:33 -0700 (PDT)
Date:   Mon, 20 Sep 2021 11:09:27 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Arnd Bergmann <arnd@kernel.org>, bhelgaas@google.com,
        marek.vasut+renesas@gmail.com, sboyd@kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: rcar: add COMMON_CLK dependency
Message-ID: <20210920100927.GA9284@lpieralisi>
References: <20210920095730.1216692-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210920095730.1216692-1-arnd@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 20, 2021 at 11:57:10AM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The __clk_is_enabled() interface is only available when building for
> platforms using CONFIG_COMMON_CLK:
> 
> arm-linux-gnueabi-ld: drivers/pci/controller/pcie-rcar-host.o: in function `rcar_pcie_aarch32_abort_handler':
> pcie-rcar-host.c:(.text+0x8fc): undefined reference to `__clk_is_enabled'
> 
> Add the necessary dependency to the COMPILE_TEST path.
> 
> Fixes: a115b1bd3af0 ("PCI: rcar: Add L1 link state fix into data abort hook")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/pci/controller/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Marek already posted a fix for this:

https://lore.kernel.org/linux-pci/20210907144512.5238-1-marek.vasut@gmail.com

and was waiting for Stephen to have a look to determine if this
could be simplified (Arnd patch already does, btw).

We should merge a fix for this asap.

Lorenzo

> diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
> index 326f7d13024f..53e3648fe872 100644
> --- a/drivers/pci/controller/Kconfig
> +++ b/drivers/pci/controller/Kconfig
> @@ -65,7 +65,7 @@ config PCI_RCAR_GEN2
>  
>  config PCIE_RCAR_HOST
>  	bool "Renesas R-Car PCIe host controller"
> -	depends on ARCH_RENESAS || COMPILE_TEST
> +	depends on ARCH_RENESAS || (COMMON_CLK && COMPILE_TEST)
>  	depends on PCI_MSI_IRQ_DOMAIN
>  	help
>  	  Say Y here if you want PCIe controller support on R-Car SoCs in host
> -- 
> 2.29.2
> 
