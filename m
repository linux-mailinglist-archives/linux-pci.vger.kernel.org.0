Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F218F2D649D
	for <lists+linux-pci@lfdr.de>; Thu, 10 Dec 2020 19:14:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390276AbgLJSNi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Dec 2020 13:13:38 -0500
Received: from foss.arm.com ([217.140.110.172]:57106 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390778AbgLJSMb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 10 Dec 2020 13:12:31 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AC5F130E;
        Thu, 10 Dec 2020 10:11:40 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 90F8C3F718;
        Thu, 10 Dec 2020 10:11:39 -0800 (PST)
Date:   Thu, 10 Dec 2020 18:11:33 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     marek.vasut@gmail.com
Cc:     linux-pci@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa@the-dreams.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] PCI: rcar: Always allocate MSI addresses in 32bit space
Message-ID: <20201210181133.GA3766@e121166-lin.cambridge.arm.com>
References: <20201016120431.7062-1-marek.vasut@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201016120431.7062-1-marek.vasut@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 16, 2020 at 02:04:31PM +0200, marek.vasut@gmail.com wrote:
> From: Marek Vasut <marek.vasut+renesas@gmail.com>
> 
> This fixes MSI operation on legacy PCI cards, which cannot issue 64bit MSIs.
> The R-Car controller only has one MSI trigger address instead of two, one
> for 64bit and one for 32bit MSI, set the address to 32bit PCIe space so that
> legacy PCI cards can also trigger MSIs.
> 
> Fixes: 290c1fb35860 ("PCI: rcar: Add MSI support for PCIe")
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Cc: linux-renesas-soc@vger.kernel.org
> ---
>  drivers/pci/controller/pcie-rcar-host.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pcie-rcar-host.c b/drivers/pci/controller/pcie-rcar-host.c
> index 1194d5f3341b..ac5c7d7573a6 100644
> --- a/drivers/pci/controller/pcie-rcar-host.c
> +++ b/drivers/pci/controller/pcie-rcar-host.c
> @@ -753,7 +753,7 @@ static int rcar_pcie_enable_msi(struct rcar_pcie_host *host)
>  	}
>  
>  	/* setup MSI data target */
> -	msi->pages = __get_free_pages(GFP_KERNEL, 0);
> +	msi->pages = __get_free_pages(GFP_KERNEL | GFP_DMA32, 0);

This does not do what you want on !CONFIG_ZONE_DMA32 (ie arm LPAE).

Can't you just pick up a non-DMA-able address < 4GB (ie outside the host
controller inbound window range) and use it as doorbell address instead ?

Thanks,
Lorenzo

>  	rcar_pcie_hw_enable_msi(host);
>  
>  	return 0;
> -- 
> 2.28.0
> 
