Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 267CE2417C6
	for <lists+linux-pci@lfdr.de>; Tue, 11 Aug 2020 10:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbgHKIBE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Aug 2020 04:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbgHKIBD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Aug 2020 04:01:03 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DBB7C06174A
        for <linux-pci@vger.kernel.org>; Tue, 11 Aug 2020 01:01:03 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=localhost)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1k5PDN-0002fu-7q; Tue, 11 Aug 2020 10:00:57 +0200
Message-ID: <7148c7a4cad0a7a998f322b71d57669e4658dbf4.camel@pengutronix.de>
Subject: Re: [PATCH V2] PCI: imx6: Do not output error message when
 devm_clk_get() failed with -EPROBE_DEFER
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Anson Huang <Anson.Huang@nxp.com>, hongxing.zhu@nxp.com,
        lorenzo.pieralisi@arm.com, robh@kernel.org, bhelgaas@google.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Date:   Tue, 11 Aug 2020 10:00:55 +0200
In-Reply-To: <1597109364-4739-1-git-send-email-Anson.Huang@nxp.com>
References: <1597109364-4739-1-git-send-email-Anson.Huang@nxp.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am Dienstag, den 11.08.2020, 09:29 +0800 schrieb Anson Huang:
> When devm_clk_get() returns -EPROBE_DEFER, i.MX6 PCI driver should
> NOT print error message, use dev_err_probe() to handle it.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 35 +++++++++++++++--------------------
>  1 file changed, 15 insertions(+), 20 deletions(-)
> 
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

