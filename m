Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41B46461BF6
	for <lists+linux-pci@lfdr.de>; Mon, 29 Nov 2021 17:42:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345226AbhK2QqI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Nov 2021 11:46:08 -0500
Received: from foss.arm.com ([217.140.110.172]:43402 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232009AbhK2QoH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 29 Nov 2021 11:44:07 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C06F61063;
        Mon, 29 Nov 2021 08:40:49 -0800 (PST)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 35A143F5A1;
        Mon, 29 Nov 2021 08:40:49 -0800 (PST)
Date:   Mon, 29 Nov 2021 16:40:43 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc:     linux-pci@vger.kernel.org, pali@kernel.org
Subject: Re: [PATCH 7/7] PCI: aardvark: Reset PCIe card and disable PHY at
 driver unbind
Message-ID: <20211129164043.GA26244@lpieralisi>
References: <20211031181233.9976-1-kabel@kernel.org>
 <20211031181233.9976-8-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211031181233.9976-8-kabel@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Oct 31, 2021 at 07:12:33PM +0100, Marek Behún wrote:
> From: Pali Rohár <pali@kernel.org>
> 
> When unbinding driver, assert PERST# signal which prepares PCIe card for
> power down. Then disable link training and PHY.

This reads as three actions. If we carry them out as a single patch we
have to explain why they are related and what problem they are solving
as a _single_ commit.

Otherwise we have to split this patch into three and explain each of
them as a separate fix.

I understand it is tempting to coalesce missing code in one single
change but every commit must implement a single logical change.

Thanks,
Lorenzo

> Fixes: 526a76991b7b ("PCI: aardvark: Implement driver 'remove' function and allow to build it as module")
> Signed-off-by: Pali Rohár <pali@kernel.org>
> Signed-off-by: Marek Behún <kabel@kernel.org>
> Cc: stable@vger.kernel.org
> ---
>  drivers/pci/controller/pci-aardvark.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
> index b3d89cb449b6..2a82c4652c28 100644
> --- a/drivers/pci/controller/pci-aardvark.c
> +++ b/drivers/pci/controller/pci-aardvark.c
> @@ -1737,10 +1737,22 @@ static int advk_pcie_remove(struct platform_device *pdev)
>  	/* Free config space for emulated root bridge */
>  	pci_bridge_emul_cleanup(&pcie->bridge);
>  
> +	/* Assert PERST# signal which prepares PCIe card for power down */
> +	if (pcie->reset_gpio)
> +		gpiod_set_value_cansleep(pcie->reset_gpio, 1);
> +
> +	/* Disable link training */
> +	val = advk_readl(pcie, PCIE_CORE_CTRL0_REG);
> +	val &= ~LINK_TRAINING_EN;
> +	advk_writel(pcie, val, PCIE_CORE_CTRL0_REG);
> +
>  	/* Disable outbound address windows mapping */
>  	for (i = 0; i < OB_WIN_COUNT; i++)
>  		advk_pcie_disable_ob_win(pcie, i);
>  
> +	/* Disable phy */
> +	advk_pcie_disable_phy(pcie);
> +
>  	return 0;
>  }
>  
> -- 
> 2.32.0
> 
