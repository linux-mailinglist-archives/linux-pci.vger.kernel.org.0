Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AED7403C53
	for <lists+linux-pci@lfdr.de>; Wed,  8 Sep 2021 17:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbhIHPNP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Sep 2021 11:13:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:41076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236245AbhIHPNN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 8 Sep 2021 11:13:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D8A0B60F6C;
        Wed,  8 Sep 2021 15:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631113925;
        bh=o7VuLdGrXHcrpl5bQDSmuUmn5f+AOer4ij4tdURLidU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=fCRgu1muZSxoXP4qDdmWGgZ3yFGW/Fe1VQDNg1QG0lHBBBhjRokT75BKgryysnXGb
         /sR2GGmyk/xvdU9k5SOL3dHcYvCtqbB8H563baPfZ4VWOnvxCfn9+f94Y6FvTHIWas
         d+8gF5zYn7A1jSsYdFnpxf20/YDvq5Di3YGpF5ZIu2YrrHOhJHTJuaSKoZexJsQAG2
         zk8nOasZHtRmsZws4d+k867NsT2sbbEyTbMS6TyroxHaIh1YvTS92unzSSlvpoZTC0
         5+zaOITlJRte2f6v5cIfD+EIUKATvni/ykEvk4SUoNFCRlYa3v363bQ3SMIZFZOWPO
         Iue3dZhB+LmQQ==
Date:   Wed, 8 Sep 2021 10:12:03 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     l.stach@pengutronix.de, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, linux-pci@vger.kernel.org,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH 1/3] PCI: imx: encapsulate the clock enable into one
 standalone function
Message-ID: <20210908151203.GA866207@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1631084366-24785-1-git-send-email-hongxing.zhu@nxp.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 08, 2021 at 02:59:24PM +0800, Richard Zhu wrote:
> No function changes, just encapsulate the i.MX PCIe clocks enable
> operations into one standalone function

When you update this,

  - it's helpful if you include a cover letter with a multi-patch
    series, with the patches being replies to the cover letter, and

  - please follow the sentence and formatting conventions for subject
    lines and commit logs (driver name should match, capitalize
    subject line, end sentences with periods, blank lines between
    paragraphs, remove useless information like timestamps from log
    messages, indent quoted material like logs by two spaces, etc).

> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 82 +++++++++++++++++----------
>  1 file changed, 51 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 80fc98acf097..0264432e4c4a 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -143,6 +143,8 @@ struct imx6_pcie {
>  #define PHY_RX_OVRD_IN_LO_RX_DATA_EN		BIT(5)
>  #define PHY_RX_OVRD_IN_LO_RX_PLL_EN		BIT(3)
>  
> +static int imx6_pcie_clk_enable(struct imx6_pcie *imx6_pcie);
> +
>  static int pcie_phy_poll_ack(struct imx6_pcie *imx6_pcie, bool exp_val)
>  {
>  	struct dw_pcie *pci = imx6_pcie->pci;
> @@ -498,33 +500,12 @@ static void imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
>  		}
>  	}
>  
> -	ret = clk_prepare_enable(imx6_pcie->pcie_phy);
> -	if (ret) {
> -		dev_err(dev, "unable to enable pcie_phy clock\n");
> -		goto err_pcie_phy;
> -	}
> -
> -	ret = clk_prepare_enable(imx6_pcie->pcie_bus);
> +	ret = imx6_pcie_clk_enable(imx6_pcie);
>  	if (ret) {
> -		dev_err(dev, "unable to enable pcie_bus clock\n");
> -		goto err_pcie_bus;
> +		dev_err(dev, "unable to enable pcie clocks\n");
> +		goto err_clks;
>  	}
>  
> -	ret = clk_prepare_enable(imx6_pcie->pcie);
> -	if (ret) {
> -		dev_err(dev, "unable to enable pcie clock\n");
> -		goto err_pcie;
> -	}
> -
> -	ret = imx6_pcie_enable_ref_clk(imx6_pcie);
> -	if (ret) {
> -		dev_err(dev, "unable to enable pcie ref clock\n");
> -		goto err_ref_clk;
> -	}
> -
> -	/* allow the clocks to stabilize */
> -	usleep_range(200, 500);
> -
>  	/* Some boards don't have PCIe reset GPIO. */
>  	if (gpio_is_valid(imx6_pcie->reset_gpio)) {
>  		gpio_set_value_cansleep(imx6_pcie->reset_gpio,
> @@ -578,13 +559,7 @@ static void imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
>  
>  	return;
>  
> -err_ref_clk:
> -	clk_disable_unprepare(imx6_pcie->pcie);
> -err_pcie:
> -	clk_disable_unprepare(imx6_pcie->pcie_bus);
> -err_pcie_bus:
> -	clk_disable_unprepare(imx6_pcie->pcie_phy);
> -err_pcie_phy:
> +err_clks:
>  	if (imx6_pcie->vpcie && regulator_is_enabled(imx6_pcie->vpcie) > 0) {
>  		ret = regulator_disable(imx6_pcie->vpcie);
>  		if (ret)
> @@ -914,6 +889,51 @@ static void imx6_pcie_pm_turnoff(struct imx6_pcie *imx6_pcie)
>  	usleep_range(1000, 10000);
>  }
>  
> +static int imx6_pcie_clk_enable(struct imx6_pcie *imx6_pcie)
> +{
> +	struct dw_pcie *pci = imx6_pcie->pci;
> +	struct device *dev = pci->dev;
> +	int ret;
> +
> +	ret = clk_prepare_enable(imx6_pcie->pcie_phy);
> +	if (ret) {
> +		dev_err(dev, "unable to enable pcie_phy clock\n");
> +		return ret;
> +	}
> +
> +	ret = clk_prepare_enable(imx6_pcie->pcie_bus);
> +	if (ret) {
> +		dev_err(dev, "unable to enable pcie_bus clock\n");
> +		goto err_pcie_bus;
> +	}
> +
> +	ret = clk_prepare_enable(imx6_pcie->pcie);
> +	if (ret) {
> +		dev_err(dev, "unable to enable pcie clock\n");
> +		goto err_pcie;
> +	}
> +
> +	ret = imx6_pcie_enable_ref_clk(imx6_pcie);
> +	if (ret) {
> +		dev_err(dev, "unable to enable pcie ref clock\n");
> +		goto err_ref_clk;
> +	}
> +
> +	/* allow the clocks to stabilize */
> +	usleep_range(200, 500);
> +	return 0;
> +
> +err_ref_clk:
> +	clk_disable_unprepare(imx6_pcie->pcie);
> +err_pcie:
> +	clk_disable_unprepare(imx6_pcie->pcie_bus);
> +err_pcie_bus:
> +	clk_disable_unprepare(imx6_pcie->pcie_phy);
> +
> +	return ret;
> +
> +}
> +
>  static void imx6_pcie_clk_disable(struct imx6_pcie *imx6_pcie)
>  {
>  	clk_disable_unprepare(imx6_pcie->pcie);
> -- 
> 2.25.1
> 
