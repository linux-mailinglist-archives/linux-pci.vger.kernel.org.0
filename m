Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E807425FDCB
	for <lists+linux-pci@lfdr.de>; Mon,  7 Sep 2020 17:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730260AbgIGP6A (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Sep 2020 11:58:00 -0400
Received: from foss.arm.com ([217.140.110.172]:37630 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730002AbgIGOuH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 7 Sep 2020 10:50:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 94E4E31B;
        Mon,  7 Sep 2020 07:38:25 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E88153F73C;
        Mon,  7 Sep 2020 07:38:23 -0700 (PDT)
Date:   Mon, 7 Sep 2020 15:38:21 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     hongxing.zhu@nxp.com, l.stach@pengutronix.de, robh@kernel.org,
        bhelgaas@google.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH V2] PCI: imx6: Do not output error message when
 devm_clk_get() failed with -EPROBE_DEFER
Message-ID: <20200907143821.GD9474@e121166-lin.cambridge.arm.com>
References: <1597109364-4739-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1597109364-4739-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 11, 2020 at 09:29:24AM +0800, Anson Huang wrote:
> When devm_clk_get() returns -EPROBE_DEFER, i.MX6 PCI driver should
> NOT print error message, use dev_err_probe() to handle it.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 35 +++++++++++++++--------------------
>  1 file changed, 15 insertions(+), 20 deletions(-)

Applied to pci/imx6, thanks.

Lorenzo

> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 90df28c..e6d6116 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -1073,38 +1073,33 @@ static int imx6_pcie_probe(struct platform_device *pdev)
>  
>  	/* Fetch clocks */
>  	imx6_pcie->pcie_phy = devm_clk_get(dev, "pcie_phy");
> -	if (IS_ERR(imx6_pcie->pcie_phy)) {
> -		dev_err(dev, "pcie_phy clock source missing or invalid\n");
> -		return PTR_ERR(imx6_pcie->pcie_phy);
> -	}
> +	if (IS_ERR(imx6_pcie->pcie_phy))
> +		return dev_err_probe(dev, PTR_ERR(imx6_pcie->pcie_phy),
> +				     "pcie_phy clock source missing or invalid\n");
>  
>  	imx6_pcie->pcie_bus = devm_clk_get(dev, "pcie_bus");
> -	if (IS_ERR(imx6_pcie->pcie_bus)) {
> -		dev_err(dev, "pcie_bus clock source missing or invalid\n");
> -		return PTR_ERR(imx6_pcie->pcie_bus);
> -	}
> +	if (IS_ERR(imx6_pcie->pcie_bus))
> +		return dev_err_probe(dev, PTR_ERR(imx6_pcie->pcie_bus),
> +				     "pcie_bus clock source missing or invalid\n");
>  
>  	imx6_pcie->pcie = devm_clk_get(dev, "pcie");
> -	if (IS_ERR(imx6_pcie->pcie)) {
> -		dev_err(dev, "pcie clock source missing or invalid\n");
> -		return PTR_ERR(imx6_pcie->pcie);
> -	}
> +	if (IS_ERR(imx6_pcie->pcie))
> +		return dev_err_probe(dev, PTR_ERR(imx6_pcie->pcie),
> +				     "pcie clock source missing or invalid\n");
>  
>  	switch (imx6_pcie->drvdata->variant) {
>  	case IMX6SX:
>  		imx6_pcie->pcie_inbound_axi = devm_clk_get(dev,
>  							   "pcie_inbound_axi");
> -		if (IS_ERR(imx6_pcie->pcie_inbound_axi)) {
> -			dev_err(dev, "pcie_inbound_axi clock missing or invalid\n");
> -			return PTR_ERR(imx6_pcie->pcie_inbound_axi);
> -		}
> +		if (IS_ERR(imx6_pcie->pcie_inbound_axi))
> +			return dev_err_probe(dev, PTR_ERR(imx6_pcie->pcie_inbound_axi),
> +					     "pcie_inbound_axi clock missing or invalid\n");
>  		break;
>  	case IMX8MQ:
>  		imx6_pcie->pcie_aux = devm_clk_get(dev, "pcie_aux");
> -		if (IS_ERR(imx6_pcie->pcie_aux)) {
> -			dev_err(dev, "pcie_aux clock source missing or invalid\n");
> -			return PTR_ERR(imx6_pcie->pcie_aux);
> -		}
> +		if (IS_ERR(imx6_pcie->pcie_aux))
> +			return dev_err_probe(dev, PTR_ERR(imx6_pcie->pcie_aux),
> +					     "pcie_aux clock source missing or invalid\n");
>  		/* fall through */
>  	case IMX7D:
>  		if (dbi_base->start == IMX8MQ_PCIE2_BASE_ADDR)
> -- 
> 2.7.4
> 
