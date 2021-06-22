Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AFE23B019E
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jun 2021 12:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbhFVKot (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Jun 2021 06:44:49 -0400
Received: from foss.arm.com ([217.140.110.172]:46596 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229612AbhFVKot (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 22 Jun 2021 06:44:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3FC0C11D4;
        Tue, 22 Jun 2021 03:42:33 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DF26B3F694;
        Tue, 22 Jun 2021 03:42:31 -0700 (PDT)
Date:   Tue, 22 Jun 2021 11:42:10 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        thierry.reding@gmail.com
Cc:     robh@kernel.org, bhelgaas@google.com, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        vidyas@nvidia.com
Subject: Re: [PATCH 1/3] PCI: tegra: Fix OF node reference leak
Message-ID: <20210622104145.GA24565@lpieralisi>
References: <55b11e9a7fa2987fbc0869d68ae59888954d65e2.1620148539.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55b11e9a7fa2987fbc0869d68ae59888954d65e2.1620148539.git.christophe.jaillet@wanadoo.fr>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 04, 2021 at 07:17:42PM +0200, Christophe JAILLET wrote:
> Commit 9e38e690ace3 ("PCI: tegra: Fix OF node reference leak") has fixed
> some node reference leaks in this function but missed some of them.
> 
> In fact, having 'port' referenced in the 'rp' structure is not enough to
> prevent the leak, until 'rp' is actually added in the 'pcie->ports' list.
> 
> Add the missing 'goto err_node_put' accordingly.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/pci/controller/pci-tegra.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)

Thierry, Jon, Vidya,

please review this series when you have time, thanks.

Lorenzo

> diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
> index 8069bd9232d4..006bf0346dec 100644
> --- a/drivers/pci/controller/pci-tegra.c
> +++ b/drivers/pci/controller/pci-tegra.c
> @@ -2193,13 +2193,15 @@ static int tegra_pcie_parse_dt(struct tegra_pcie *pcie)
>  		rp->np = port;
>  
>  		rp->base = devm_pci_remap_cfg_resource(dev, &rp->regs);
> -		if (IS_ERR(rp->base))
> -			return PTR_ERR(rp->base);
> +		if (IS_ERR(rp->base)) {
> +			err = PTR_ERR(rp->base);
> +			goto err_node_put;
> +		}
>  
>  		label = devm_kasprintf(dev, GFP_KERNEL, "pex-reset-%u", index);
>  		if (!label) {
> -			dev_err(dev, "failed to create reset GPIO label\n");
> -			return -ENOMEM;
> +			err = -ENOMEM;
> +			goto err_node_put;
>  		}
>  
>  		/*
> @@ -2217,7 +2219,8 @@ static int tegra_pcie_parse_dt(struct tegra_pcie *pcie)
>  			} else {
>  				dev_err(dev, "failed to get reset GPIO: %ld\n",
>  					PTR_ERR(rp->reset_gpio));
> -				return PTR_ERR(rp->reset_gpio);
> +				err = PTR_ERR(rp->reset_gpio);
> +				goto err_node_put;
>  			}
>  		}
>  
> -- 
> 2.30.2
> 
