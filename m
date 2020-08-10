Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFA5F2403C8
	for <lists+linux-pci@lfdr.de>; Mon, 10 Aug 2020 11:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbgHJJC0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 Aug 2020 05:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbgHJJCZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 Aug 2020 05:02:25 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EFF4C061756
        for <linux-pci@vger.kernel.org>; Mon, 10 Aug 2020 02:02:25 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=localhost)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1k53hE-0000O3-4f; Mon, 10 Aug 2020 11:02:20 +0200
Message-ID: <c2f17d7360387bf6d93d2ac24e5b326a542a5861.camel@pengutronix.de>
Subject: Re: [PATCH] PCI: imx6: Do not output error message when
 devm_clk_get() failed with -EPROBE_DEFER
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Anson Huang <Anson.Huang@nxp.com>, hongxing.zhu@nxp.com,
        lorenzo.pieralisi@arm.com, robh@kernel.org, bhelgaas@google.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Date:   Mon, 10 Aug 2020 11:02:18 +0200
In-Reply-To: <1596519481-28072-1-git-send-email-Anson.Huang@nxp.com>
References: <1596519481-28072-1-git-send-email-Anson.Huang@nxp.com>
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

Am Dienstag, den 04.08.2020, 13:38 +0800 schrieb Anson Huang:
> When devm_clk_get() returns -EPROBE_DEFER, i.MX6 PCI driver should
> NOT print error message, just return -EPROBE_DEFER is enough.

The reasoning behind this change is fine, but I think we should use the
recently merged dev_err_probe() helper to achieve the same goal.

Regards,
Lucas

> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 30 ++++++++++++++++++++----------
>  1 file changed, 20 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 4e5c379..ee75d35 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -1076,20 +1076,26 @@ static int imx6_pcie_probe(struct platform_device *pdev)
>  	/* Fetch clocks */
>  	imx6_pcie->pcie_phy = devm_clk_get(dev, "pcie_phy");
>  	if (IS_ERR(imx6_pcie->pcie_phy)) {
> -		dev_err(dev, "pcie_phy clock source missing or invalid\n");
> -		return PTR_ERR(imx6_pcie->pcie_phy);
> +		ret = PTR_ERR(imx6_pcie->pcie_phy);
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(dev, "pcie_phy clock source missing or invalid\n");
> +		return ret;
>  	}
>  
>  	imx6_pcie->pcie_bus = devm_clk_get(dev, "pcie_bus");
>  	if (IS_ERR(imx6_pcie->pcie_bus)) {
> -		dev_err(dev, "pcie_bus clock source missing or invalid\n");
> -		return PTR_ERR(imx6_pcie->pcie_bus);
> +		ret = PTR_ERR(imx6_pcie->pcie_bus);
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(dev, "pcie_bus clock source missing or invalid\n");
> +		return ret;
>  	}
>  
>  	imx6_pcie->pcie = devm_clk_get(dev, "pcie");
>  	if (IS_ERR(imx6_pcie->pcie)) {
> -		dev_err(dev, "pcie clock source missing or invalid\n");
> -		return PTR_ERR(imx6_pcie->pcie);
> +		ret = PTR_ERR(imx6_pcie->pcie);
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(dev, "pcie clock source missing or invalid\n");
> +		return ret;
>  	}
>  
>  	switch (imx6_pcie->drvdata->variant) {
> @@ -1097,15 +1103,19 @@ static int imx6_pcie_probe(struct platform_device *pdev)
>  		imx6_pcie->pcie_inbound_axi = devm_clk_get(dev,
>  							   "pcie_inbound_axi");
>  		if (IS_ERR(imx6_pcie->pcie_inbound_axi)) {
> -			dev_err(dev, "pcie_inbound_axi clock missing or invalid\n");
> -			return PTR_ERR(imx6_pcie->pcie_inbound_axi);
> +			ret = PTR_ERR(imx6_pcie->pcie_inbound_axi);
> +			if (ret != -EPROBE_DEFER)
> +				dev_err(dev, "pcie_inbound_axi clock missing or invalid\n");
> +			return ret;
>  		}
>  		break;
>  	case IMX8MQ:
>  		imx6_pcie->pcie_aux = devm_clk_get(dev, "pcie_aux");
>  		if (IS_ERR(imx6_pcie->pcie_aux)) {
> -			dev_err(dev, "pcie_aux clock source missing or invalid\n");
> -			return PTR_ERR(imx6_pcie->pcie_aux);
> +			ret = PTR_ERR(imx6_pcie->pcie_aux);
> +			if (ret != -EPROBE_DEFER)
> +				dev_err(dev, "pcie_aux clock source missing or invalid\n");
> +			return ret;
>  		}
>  		/* fall through */
>  	case IMX7D:

