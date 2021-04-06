Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0147E355785
	for <lists+linux-pci@lfdr.de>; Tue,  6 Apr 2021 17:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238445AbhDFPQT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Apr 2021 11:16:19 -0400
Received: from foss.arm.com ([217.140.110.172]:44524 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230424AbhDFPQT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 6 Apr 2021 11:16:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 274F41FB;
        Tue,  6 Apr 2021 08:16:11 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9373A3F792;
        Tue,  6 Apr 2021 08:16:09 -0700 (PDT)
Date:   Tue, 6 Apr 2021 16:16:04 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Jim Quinlan <jim2101024@gmail.com>, Jens Axboe <axboe@kernel.dk>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 1/2] ata: ahci_brcm: Fix use of BCM7216 reset
 controller
Message-ID: <20210406151604.GA25862@lpieralisi>
References: <20210312204556.5387-1-jim2101024@gmail.com>
 <20210312204556.5387-2-jim2101024@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210312204556.5387-2-jim2101024@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 12, 2021 at 03:45:54PM -0500, Jim Quinlan wrote:
> This driver may use one of two resets controllers.  Keep them in separate
> variables to keep things simple.  The reset controller "rescal" is shared
> between the AHCI driver and the PCIe driver for the BrcmSTB 7216 chip.  Use
> devm_reset_control_get_optional_shared() to handle this sharing.
> 
> Fixes: 272ecd60a636 ("ata: ahci_brcm: BCM7216 reset is self de-asserting")
> Fixes: c345ec6a50e9 ("ata: ahci_brcm: Support BCM7216 reset controller name")
> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> Acked-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  drivers/ata/ahci_brcm.c | 46 ++++++++++++++++++++---------------------
>  1 file changed, 23 insertions(+), 23 deletions(-)

Hi Jens,

I am happy to take this series via the PCI tree but I'd need your
ACK on this patch, please let me know if you are OK with it.

Thanks,
Lorenzo

> diff --git a/drivers/ata/ahci_brcm.c b/drivers/ata/ahci_brcm.c
> index 5b32df5d33ad..6e9c5ade4c2e 100644
> --- a/drivers/ata/ahci_brcm.c
> +++ b/drivers/ata/ahci_brcm.c
> @@ -86,7 +86,8 @@ struct brcm_ahci_priv {
>  	u32 port_mask;
>  	u32 quirks;
>  	enum brcm_ahci_version version;
> -	struct reset_control *rcdev;
> +	struct reset_control *rcdev_rescal;
> +	struct reset_control *rcdev_ahci;
>  };
>  
>  static inline u32 brcm_sata_readreg(void __iomem *addr)
> @@ -352,8 +353,8 @@ static int brcm_ahci_suspend(struct device *dev)
>  	else
>  		ret = 0;
>  
> -	if (priv->version != BRCM_SATA_BCM7216)
> -		reset_control_assert(priv->rcdev);
> +	reset_control_assert(priv->rcdev_ahci);
> +	reset_control_rearm(priv->rcdev_rescal);
>  
>  	return ret;
>  }
> @@ -365,10 +366,10 @@ static int __maybe_unused brcm_ahci_resume(struct device *dev)
>  	struct brcm_ahci_priv *priv = hpriv->plat_data;
>  	int ret = 0;
>  
> -	if (priv->version == BRCM_SATA_BCM7216)
> -		ret = reset_control_reset(priv->rcdev);
> -	else
> -		ret = reset_control_deassert(priv->rcdev);
> +	ret = reset_control_deassert(priv->rcdev_ahci);
> +	if (ret)
> +		return ret;
> +	ret = reset_control_reset(priv->rcdev_rescal);
>  	if (ret)
>  		return ret;
>  
> @@ -434,7 +435,6 @@ static int brcm_ahci_probe(struct platform_device *pdev)
>  {
>  	const struct of_device_id *of_id;
>  	struct device *dev = &pdev->dev;
> -	const char *reset_name = NULL;
>  	struct brcm_ahci_priv *priv;
>  	struct ahci_host_priv *hpriv;
>  	struct resource *res;
> @@ -456,15 +456,15 @@ static int brcm_ahci_probe(struct platform_device *pdev)
>  	if (IS_ERR(priv->top_ctrl))
>  		return PTR_ERR(priv->top_ctrl);
>  
> -	/* Reset is optional depending on platform and named differently */
> -	if (priv->version == BRCM_SATA_BCM7216)
> -		reset_name = "rescal";
> -	else
> -		reset_name = "ahci";
> -
> -	priv->rcdev = devm_reset_control_get_optional(&pdev->dev, reset_name);
> -	if (IS_ERR(priv->rcdev))
> -		return PTR_ERR(priv->rcdev);
> +	if (priv->version == BRCM_SATA_BCM7216) {
> +		priv->rcdev_rescal = devm_reset_control_get_optional_shared(
> +			&pdev->dev, "rescal");
> +		if (IS_ERR(priv->rcdev_rescal))
> +			return PTR_ERR(priv->rcdev_rescal);
> +	}
> +	priv->rcdev_ahci = devm_reset_control_get_optional(&pdev->dev, "ahci");
> +	if (IS_ERR(priv->rcdev_ahci))
> +		return PTR_ERR(priv->rcdev_ahci);
>  
>  	hpriv = ahci_platform_get_resources(pdev, 0);
>  	if (IS_ERR(hpriv))
> @@ -485,10 +485,10 @@ static int brcm_ahci_probe(struct platform_device *pdev)
>  		break;
>  	}
>  
> -	if (priv->version == BRCM_SATA_BCM7216)
> -		ret = reset_control_reset(priv->rcdev);
> -	else
> -		ret = reset_control_deassert(priv->rcdev);
> +	ret = reset_control_reset(priv->rcdev_rescal);
> +	if (ret)
> +		return ret;
> +	ret = reset_control_deassert(priv->rcdev_ahci);
>  	if (ret)
>  		return ret;
>  
> @@ -539,8 +539,8 @@ static int brcm_ahci_probe(struct platform_device *pdev)
>  out_disable_clks:
>  	ahci_platform_disable_clks(hpriv);
>  out_reset:
> -	if (priv->version != BRCM_SATA_BCM7216)
> -		reset_control_assert(priv->rcdev);
> +	reset_control_assert(priv->rcdev_ahci);
> +	reset_control_rearm(priv->rcdev_rescal);
>  	return ret;
>  }
>  
> -- 
> 2.17.1
> 
