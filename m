Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AEDF42FB6B
	for <lists+linux-pci@lfdr.de>; Fri, 15 Oct 2021 20:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237973AbhJOSvw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Oct 2021 14:51:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:54956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241634AbhJOSvw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 15 Oct 2021 14:51:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 03C7761041;
        Fri, 15 Oct 2021 18:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634323785;
        bh=UaeeKWreQ9XHoXCUz87V9ZmiFfq/pWLzYxxosXs7xg4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=e0GAhgqd7hVJ9kNATLgfHaFFE01fIZcWK74zeJgx6las3UNSQ9cCatbepp6UTpxKX
         pfPvpXMw66J76b6NCPZ9YZLjBNaVJurVKMK2kPw4ZQmYYw63ozr9Ecj1+4HqG98zZm
         fz72oSvFZhd/NQSNqjoHwbtnocVifBNTrU+i1eU5SW8MRodts6v6NX0ZGFvjvFiC7Y
         OPmNLImKAdQhEkShzpdIqO8fetD+ci6j1g2Wtz1CMOvmZpIedDHL7KVhtHCR3kbOnc
         ijdJe7ZV9N0VlI51sn7lobB/Ce6VvvaCUiRWN+xDmvdsDRgo3gNEKkqV4XYF4NzaZP
         D3HQBMAeOgxaw==
Date:   Fri, 15 Oct 2021 13:49:43 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     l.stach@pengutronix.de, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, linux-pci@vger.kernel.org,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [RESEND v2 4/5] PCI: imx6: Fix the clock reference handling
 unbalance when link never came up
Message-ID: <20211015184943.GA2139079@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1634277941-6672-5-git-send-email-hongxing.zhu@nxp.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 15, 2021 at 02:05:40PM +0800, Richard Zhu wrote:
> When link never came up, driver probe would be failed with error -110.
> To keep usage counter balance of the clocks, disable the previous
> enabled clocks when link is down.
> Move definitions of the imx6_pcie_clk_disable() function to the proper
> place. Because it wouldn't be used in imx6_pcie_suspend_noirq() only.

Add blank line between paragraphs.

Can you please split this into two patches:

  1) the imx6_pcie_clk_disable() move
  2) the actual fix

It's hard to tell exactly where the fix is when things are mixed
together.

> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 47 ++++++++++++++-------------
>  1 file changed, 24 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index cc837f8bf6d4..d6a5d99ffa52 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -514,6 +514,29 @@ static int imx6_pcie_clk_enable(struct imx6_pcie *imx6_pcie)
>  	return ret;
>  }
>  
> +static void imx6_pcie_clk_disable(struct imx6_pcie *imx6_pcie)
> +{
> +	clk_disable_unprepare(imx6_pcie->pcie);
> +	clk_disable_unprepare(imx6_pcie->pcie_phy);
> +	clk_disable_unprepare(imx6_pcie->pcie_bus);
> +
> +	switch (imx6_pcie->drvdata->variant) {
> +	case IMX6SX:
> +		clk_disable_unprepare(imx6_pcie->pcie_inbound_axi);
> +		break;
> +	case IMX7D:
> +		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
> +				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL,
> +				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL);
> +		break;
> +	case IMX8MQ:
> +		clk_disable_unprepare(imx6_pcie->pcie_aux);
> +		break;
> +	default:
> +		break;
> +	}
> +}
> +
>  static void imx7d_pcie_wait_for_phy_pll_lock(struct imx6_pcie *imx6_pcie)
>  {
>  	u32 val;
> @@ -853,6 +876,7 @@ static int imx6_pcie_start_link(struct dw_pcie *pci)
>  		dw_pcie_readl_dbi(pci, PCIE_PORT_DEBUG0),
>  		dw_pcie_readl_dbi(pci, PCIE_PORT_DEBUG1));
>  	imx6_pcie_reset_phy(imx6_pcie);
> +	imx6_pcie_clk_disable(imx6_pcie);
>  	if (imx6_pcie->vpcie && regulator_is_enabled(imx6_pcie->vpcie) > 0)
>  		regulator_disable(imx6_pcie->vpcie);
>  	return ret;
> @@ -941,29 +965,6 @@ static void imx6_pcie_pm_turnoff(struct imx6_pcie *imx6_pcie)
>  	usleep_range(1000, 10000);
>  }
>  
> -static void imx6_pcie_clk_disable(struct imx6_pcie *imx6_pcie)
> -{
> -	clk_disable_unprepare(imx6_pcie->pcie);
> -	clk_disable_unprepare(imx6_pcie->pcie_phy);
> -	clk_disable_unprepare(imx6_pcie->pcie_bus);
> -
> -	switch (imx6_pcie->drvdata->variant) {
> -	case IMX6SX:
> -		clk_disable_unprepare(imx6_pcie->pcie_inbound_axi);
> -		break;
> -	case IMX7D:
> -		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
> -				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL,
> -				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL);
> -		break;
> -	case IMX8MQ:
> -		clk_disable_unprepare(imx6_pcie->pcie_aux);
> -		break;
> -	default:
> -		break;
> -	}
> -}
> -
>  static int imx6_pcie_suspend_noirq(struct device *dev)
>  {
>  	struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);
> -- 
> 2.25.1
> 
