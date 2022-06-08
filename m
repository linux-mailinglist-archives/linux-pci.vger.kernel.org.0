Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 076515428E4
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jun 2022 10:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbiFHIFu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Jun 2022 04:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231907AbiFHIFB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Jun 2022 04:05:01 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B74AF1F4D10
        for <linux-pci@vger.kernel.org>; Wed,  8 Jun 2022 00:35:22 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1nyqDj-0000W7-7k; Wed, 08 Jun 2022 09:35:15 +0200
Message-ID: <5be4f4322e00e33fa9417280b0d74ecb7aab913e.camel@pengutronix.de>
Subject: Re: [PATCH v9 6/8] PCI: imx6: Disable clocks and regulators after
 link is down
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Richard Zhu <hongxing.zhu@nxp.com>, bhelgaas@google.com,
        robh+dt@kernel.org, broonie@kernel.org, lorenzo.pieralisi@arm.com,
        jingoohan1@gmail.com, festevam@gmail.com,
        francesco.dolcini@toradex.com
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com
Date:   Wed, 08 Jun 2022 09:35:14 +0200
In-Reply-To: <1651801629-30223-7-git-send-email-hongxing.zhu@nxp.com>
References: <1651801629-30223-1-git-send-email-hongxing.zhu@nxp.com>
         <1651801629-30223-7-git-send-email-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am Freitag, dem 06.05.2022 um 09:47 +0800 schrieb Richard Zhu:
> Since i.MX PCIe doesn't support hot-plug, reduce power consumption
> as much as possible by disabling clocks and regulators and returning
> error when the link is down.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 3ce3993d5797..d122c12193a6 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -845,7 +845,9 @@ static int imx6_pcie_start_link(struct dw_pcie *pci)
>  	/* Start LTSSM. */
>  	imx6_pcie_ltssm_enable(dev);
>  
> -	dw_pcie_wait_for_link(pci);
> +	ret = dw_pcie_wait_for_link(pci);
> +	if (ret)
> +		goto err_out;

This adds back error handling that has been intentionally removed in
f81f095e8771 ("PCI: imx6: Allow to probe when dw_pcie_wait_for_link()
fails"). While I agree that disabling the clocks and regulators is the
right thing to do when we don't manage to get a link, we should still
allow the driver to probe, so please add a "ret = 0" to this newly
added non-fatal error paths.

>  
>  	if (pci->link_gen == 2) {
>  		/* Allow Gen2 mode after the link is up. */
> @@ -876,12 +878,14 @@ static int imx6_pcie_start_link(struct dw_pcie *pci)
>  			ret = imx6_pcie_wait_for_speed_change(imx6_pcie);
>  			if (ret) {
>  				dev_err(dev, "Failed to bring link up!\n");
> -				goto err_reset_phy;
> +				goto err_out;
>  			}
>  		}
>  
>  		/* Make sure link training is finished as well! */
> -		dw_pcie_wait_for_link(pci);
> +		ret = dw_pcie_wait_for_link(pci);
> +		if (ret)
> +			goto err_out;
>  	} else {
>  		dev_info(dev, "Link: Gen2 disabled\n");
>  	}
> @@ -890,11 +894,18 @@ static int imx6_pcie_start_link(struct dw_pcie *pci)
>  	dev_info(dev, "Link up, Gen%i\n", tmp & PCI_EXP_LNKSTA_CLS);
>  	return 0;
>  
> -err_reset_phy:
> +err_out:
>  	dev_dbg(dev, "PHY DEBUG_R0=0x%08x DEBUG_R1=0x%08x\n",
>  		dw_pcie_readl_dbi(pci, PCIE_PORT_DEBUG0),
>  		dw_pcie_readl_dbi(pci, PCIE_PORT_DEBUG1));
>  	imx6_pcie_reset_phy(imx6_pcie);
> +	imx6_pcie_clk_disable(imx6_pcie);
> +	if (imx6_pcie->phy != NULL) {

Please use the more common if (imx6_pcie->phy) here.

Regards,
Lucas

> +		phy_power_off(imx6_pcie->phy);
> +		phy_exit(imx6_pcie->phy);
> +	}
> +	if (imx6_pcie->vpcie)
> +		regulator_disable(imx6_pcie->vpcie);
>  	return ret;
>  }
>  


