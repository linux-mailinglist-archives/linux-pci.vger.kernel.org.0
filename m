Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9627D331C51
	for <lists+linux-pci@lfdr.de>; Tue,  9 Mar 2021 02:36:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbhCIBfP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 Mar 2021 20:35:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:34270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229520AbhCIBet (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 8 Mar 2021 20:34:49 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B6A33650CB;
        Tue,  9 Mar 2021 01:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615253689;
        bh=N9DEEHqSHBgZ7+31sSiczhaBg08b9xHQZ6OF+C2d/W8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=EYhPzqZaIgbsLCun9w6l6lU+tPHQ6B3/XXZD49glBvlioU7kg6/K69MAifpl4pFdB
         VM8TS7AAHL+JYi/LqYfIRx/JJMK+d4f1yi+dgC4O1UV+/3xugywBbeZ1MyDju4gCKR
         o8xH0eOOA8CAs1YjBv0MyO2igOrbHNjrG3DRZZH2S2O38PnXANwmdFdtghPLjLoflu
         rsPjXM65dpEhQZe0AvWRNLhXXp1FIB38JsoNFguXq7Pe58p3DUsvG0s1Dy1v7oQaXW
         k3RGk567HK8E+Z2yx1F9iJ8GnqSG5C/dNHAsCW9ZlzKB03eim7xtiBn1rG1FptKiib
         sFB2n6/QoNaKw==
Date:   Mon, 8 Mar 2021 19:34:47 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jim Quinlan <jim2101024@gmail.com>
Cc:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
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
Subject: Re: [PATCH v4 2/2] nPCI: brcmstb: Use reset/rearm instead of
 deassert/assert
Message-ID: <20210309013447.GA1831980@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210308195037.1503-3-jim2101024@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

If you update this, please fix the s/nPCI: /PCI: / in the subject

On Mon, Mar 08, 2021 at 02:50:37PM -0500, Jim Quinlan wrote:
> The Brcmstb PCIe RC uses a reset control "rescal" for certain chips.  This
> reset implements a "pulse reset" so it matches more the reset/rearm
> calls instead of the deassert/assert calls.

You say "also" below, but the paragraph above doesn't tell us the
*first* thing this patch does.  It just tells us that some chips use
"rescal" and that "rescal" implements a "pulse reset".

I guess you're replacing reset_control_deassert() with
reset_control_reset(), and reset_control_assert() with
reset_control_rearm().

It's not obvious to me that those are equivalent or why it's safe to
do this for all chips, including those that don't use the "rescal"
(since it sounds like only certain chips have that).

> Also, add reset_control calls in suspend/resume functions.
> 
> Fixes: 740d6c3708a9 ("PCI: brcmstb: Add control of rescal reset")
> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> Acked-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  drivers/pci/controller/pcie-brcmstb.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index e330e6811f0b..18f23cba7e3a 100644
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
> +		goto err0;
> +
>  	ret = brcm_phy_start(pcie);
>  	if (ret)
> -		goto err;
> +		goto err1;
>  
>  	/* Take bridge out of reset so we can access the SERDES reg */
>  	pcie->bridge_sw_init_set(pcie, 0);
> @@ -1180,14 +1185,16 @@ static int brcm_pcie_resume(struct device *dev)
>  
>  	ret = brcm_pcie_setup(pcie);
>  	if (ret)
> -		goto err;
> +		goto err1;
>  
>  	if (pcie->msi)
>  		brcm_msi_set_regs(pcie->msi);
>  
>  	return 0;
>  
> -err:
> +err1:
> +	reset_control_rearm(pcie->rescal);
> +err0:
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
