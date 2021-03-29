Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D96634D48D
	for <lists+linux-pci@lfdr.de>; Mon, 29 Mar 2021 18:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbhC2QLH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Mar 2021 12:11:07 -0400
Received: from foss.arm.com ([217.140.110.172]:56482 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229709AbhC2QKo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 29 Mar 2021 12:10:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 25516142F;
        Mon, 29 Mar 2021 09:10:44 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5D3B63F719;
        Mon, 29 Mar 2021 09:10:42 -0700 (PDT)
Date:   Mon, 29 Mar 2021 17:10:40 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Jim Quinlan <jim2101024@gmail.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jim Quinlan <jquinlan@broadcom.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 2/2] PCI: brcmstb: Use reset/rearm instead of
 deassert/assert
Message-ID: <20210329161040.GB9677@lpieralisi>
References: <20210312204556.5387-1-jim2101024@gmail.com>
 <20210312204556.5387-3-jim2101024@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210312204556.5387-3-jim2101024@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 12, 2021 at 03:45:55PM -0500, Jim Quinlan wrote:
> The Broadcom STB PCIe RC uses a reset control "rescal" for certain chips.
> The "rescal" implements a "pulse reset" so using assert/deassert is wrong
> for this device.  Instead, we use reset/rearm.  We need to use rearm so
> that we can reset it after a suspend/resume cycle; w/o using "rearm", the
> "rescal" device will only ever fire once.
> 
> Of course for suspend/resume to work we also need to put the reset/rearm
> calls in the suspend and resume routines.

Actually - I am sorry but it looks like you will have to split the patch
in two since this is two logical changes.

Thanks,
Lorenzo

> Fixes: 740d6c3708a9 ("PCI: brcmstb: Add control of rescal reset")
> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> Acked-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  drivers/pci/controller/pcie-brcmstb.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index e330e6811f0b..3b35d629035e 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -1148,6 +1148,7 @@ static int brcm_pcie_suspend(struct device *dev)
>  
>  	brcm_pcie_turn_off(pcie);
>  	ret = brcm_phy_stop(pcie);
> +	reset_control_rearm(pcie->rescal);
>  	clk_disable_unprepare(pcie->clk);
>  
>  	return ret;
> @@ -1163,9 +1164,13 @@ static int brcm_pcie_resume(struct device *dev)
>  	base = pcie->base;
>  	clk_prepare_enable(pcie->clk);
>  
> +	ret = reset_control_reset(pcie->rescal);
> +	if (ret)
> +		goto err_disable_clk;
> +
>  	ret = brcm_phy_start(pcie);
>  	if (ret)
> -		goto err;
> +		goto err_reset;
>  
>  	/* Take bridge out of reset so we can access the SERDES reg */
>  	pcie->bridge_sw_init_set(pcie, 0);
> @@ -1180,14 +1185,16 @@ static int brcm_pcie_resume(struct device *dev)
>  
>  	ret = brcm_pcie_setup(pcie);
>  	if (ret)
> -		goto err;
> +		goto err_reset;
>  
>  	if (pcie->msi)
>  		brcm_msi_set_regs(pcie->msi);
>  
>  	return 0;
>  
> -err:
> +err_reset:
> +	reset_control_rearm(pcie->rescal);
> +err_disable_clk:
>  	clk_disable_unprepare(pcie->clk);
>  	return ret;
>  }
> @@ -1197,7 +1204,7 @@ static void __brcm_pcie_remove(struct brcm_pcie *pcie)
>  	brcm_msi_remove(pcie);
>  	brcm_pcie_turn_off(pcie);
>  	brcm_phy_stop(pcie);
> -	reset_control_assert(pcie->rescal);
> +	reset_control_rearm(pcie->rescal);
>  	clk_disable_unprepare(pcie->clk);
>  }
>  
> @@ -1278,13 +1285,13 @@ static int brcm_pcie_probe(struct platform_device *pdev)
>  		return PTR_ERR(pcie->perst_reset);
>  	}
>  
> -	ret = reset_control_deassert(pcie->rescal);
> +	ret = reset_control_reset(pcie->rescal);
>  	if (ret)
>  		dev_err(&pdev->dev, "failed to deassert 'rescal'\n");
>  
>  	ret = brcm_phy_start(pcie);
>  	if (ret) {
> -		reset_control_assert(pcie->rescal);
> +		reset_control_rearm(pcie->rescal);
>  		clk_disable_unprepare(pcie->clk);
>  		return ret;
>  	}
> -- 
> 2.17.1
> 
