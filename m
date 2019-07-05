Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1361D60361
	for <lists+linux-pci@lfdr.de>; Fri,  5 Jul 2019 11:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727634AbfGEJuM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 5 Jul 2019 05:50:12 -0400
Received: from foss.arm.com ([217.140.110.172]:34394 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727225AbfGEJuM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 5 Jul 2019 05:50:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9DB222B;
        Fri,  5 Jul 2019 02:50:11 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 996D13F246;
        Fri,  5 Jul 2019 02:50:10 -0700 (PDT)
Date:   Fri, 5 Jul 2019 10:50:08 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: Re: [PATCH] PCI: tegra: Fix support for GPIO based PERST#
Message-ID: <20190705095008.GB17491@e121166-lin.cambridge.arm.com>
References: <20190705084850.30777-1-jonathanh@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190705084850.30777-1-jonathanh@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 05, 2019 at 09:48:50AM +0100, Jon Hunter wrote:
> Commit 5e5e9c23f82a ("PCI: tegra: Add support for GPIO based PERST#")
> calls the function devm_gpiod_get_from_of_node() to request a GPIO.
> Unfortunately, around the same time this was merged, commit 025bf37725f1
> ("gpio: Fix return value mismatch of function gpiod_get_from_of_node()")
> was also merged to fix the return value of the function
> devm_gpiod_get_from_of_node() that was incorrectly returning NULL
> instead of an error pointer encoded with -ENOENT if no GPIO was found.
> When this fix for the GPIO subsystem was merged, PCI support for Tegra
> devices that did not provide a GPIO for the PERST# (which is optional)
> broke because the Tegra PCI driver was expecting NULL to be returned if
> no GPIO was present and not -ENOENT.
> 
> Fix this by checking to see if -ENOENT is returned from the function
> devm_gpiod_get_from_of_node(), to indicate there is no GPIO for PERST#
> present, and if this is the case set the variable 'reset_gpio' to NULL.
> If the variable 'reset_gpio' is NULL then the Tegra PCI driver will
> fallback to using the AFI register to toggle the PERST#. Finally,
> correct the comment now that NULL is no longer returned from
> devm_gpiod_get_from_of_node().
> 
> Fixes: 5e5e9c23f82a ("PCI: tegra: Add support for GPIO based PERST#")
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>  drivers/pci/controller/pci-tegra.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)

Can I squash this in the original commit (ie Fixes: tag above) ? I do
not think there is any issue with that, if there is please do let me
know.

Thanks,
Lorenzo

> diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
> index 9cc03a2549c0..ff8a346f3e04 100644
> --- a/drivers/pci/controller/pci-tegra.c
> +++ b/drivers/pci/controller/pci-tegra.c
> @@ -2295,18 +2295,22 @@ static int tegra_pcie_parse_dt(struct tegra_pcie *pcie)
>  		}
>  
>  		/*
> -		 * Returns null if reset-gpios property is not populated and
> -		 * fall back to using AFI per port register to toggle PERST#
> -		 * SFIO line.
> +		 * Returns -ENOENT if reset-gpios property is not populated
> +		 * and in this case fall back to using AFI per port register
> +		 * to toggle PERST# SFIO line.
>  		 */
>  		rp->reset_gpio = devm_gpiod_get_from_of_node(dev, port,
>  							     "reset-gpios", 0,
>  							     GPIOD_OUT_LOW,
>  							     label);
>  		if (IS_ERR(rp->reset_gpio)) {
> -			err = PTR_ERR(rp->reset_gpio);
> -			dev_err(dev, "failed to get reset GPIO: %d\n", err);
> -			return err;
> +			if (PTR_ERR(rp->reset_gpio) == -ENOENT) {
> +				rp->reset_gpio = NULL;
> +			} else {
> +				dev_err(dev, "failed to get reset GPIO: %d\n",
> +					err);
> +				return PTR_ERR(rp->reset_gpio);
> +			}
>  		}
>  
>  		list_add_tail(&rp->list, &pcie->ports);
> -- 
> 2.17.1
> 
