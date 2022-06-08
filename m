Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0777554296B
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jun 2022 10:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbiFHIYJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Jun 2022 04:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbiFHIWO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Jun 2022 04:22:14 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C8341285E2
        for <linux-pci@vger.kernel.org>; Wed,  8 Jun 2022 00:48:42 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1nyqQc-0003jp-L9; Wed, 08 Jun 2022 09:48:34 +0200
Message-ID: <6550645c8163bad0b36eebdfceeb244f57329e9e.camel@pengutronix.de>
Subject: Re: [PATCH v9 8/8] PCI: imx6: Add compliance tests mode support
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Richard Zhu <hongxing.zhu@nxp.com>, bhelgaas@google.com,
        robh+dt@kernel.org, broonie@kernel.org, lorenzo.pieralisi@arm.com,
        jingoohan1@gmail.com, festevam@gmail.com,
        francesco.dolcini@toradex.com
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com
Date:   Wed, 08 Jun 2022 09:48:33 +0200
In-Reply-To: <1651801629-30223-9-git-send-email-hongxing.zhu@nxp.com>
References: <1651801629-30223-1-git-send-email-hongxing.zhu@nxp.com>
         <1651801629-30223-9-git-send-email-hongxing.zhu@nxp.com>
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
> Refer to the Chapter 3.2 System Board Signal Quality of PCI Express
> Architecture PHY Test Specification Revision 2.0.
> 
> Signal quality tests (for example: jitter, differential eye opening and
> so on) can be executed with devices in the polling.compliance state.
> 
> To let the device support polling.compliance state, the clocks and powers
> shouldn't be turned off when the probe of device driver fails.
> 
> Based on CLB (Compliance Load Board) Test Fixture and so on test
> equipments, the PHY link would be down during the compliance tests.
> Refer to this scenario, add the i.MX PCIe compliance tests mode enable
> support, and keep the clocks and powers on, and finish the driver probe
> without error return.
> 
> Use the "pci_imx6.compliance=1" in kernel command line to enable the
> compliance tests mode.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 39 ++++++++++++++++++---------
>  1 file changed, 27 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index f0ffd9011975..f78b59822626 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -146,6 +146,10 @@ struct imx6_pcie {
>  #define PHY_RX_OVRD_IN_LO_RX_DATA_EN		BIT(5)
>  #define PHY_RX_OVRD_IN_LO_RX_PLL_EN		BIT(3)
>  
> +static bool imx6_pcie_cmp_mode;
> +module_param_named(compliance, imx6_pcie_cmp_mode, bool, 0644);
> +MODULE_PARM_DESC(compliance, "i.MX PCIe compliance test mode (1=compliance test mode enabled)");
> +
>  static int pcie_phy_poll_ack(struct imx6_pcie *imx6_pcie, bool exp_val)
>  {
>  	struct dw_pcie *pci = imx6_pcie->pci;
> @@ -826,10 +830,12 @@ static int imx6_pcie_start_link(struct dw_pcie *pci)
>  	 * started in Gen2 mode, there is a possibility the devices on the
>  	 * bus will not be detected at all.  This happens with PCIe switches.
>  	 */
> -	tmp = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCAP);
> -	tmp &= ~PCI_EXP_LNKCAP_SLS;
> -	tmp |= PCI_EXP_LNKCAP_SLS_2_5GB;
> -	dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCAP, tmp);
> +	if (!imx6_pcie_cmp_mode) {
> +		tmp = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCAP);
> +		tmp &= ~PCI_EXP_LNKCAP_SLS;
> +		tmp |= PCI_EXP_LNKCAP_SLS_2_5GB;
> +		dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCAP, tmp);
> +	}
>  
>  	/* Start LTSSM. */
>  	imx6_pcie_ltssm_enable(dev);
> @@ -887,14 +893,16 @@ static int imx6_pcie_start_link(struct dw_pcie *pci)
>  	dev_dbg(dev, "PHY DEBUG_R0=0x%08x DEBUG_R1=0x%08x\n",
>  		dw_pcie_readl_dbi(pci, PCIE_PORT_DEBUG0),
>  		dw_pcie_readl_dbi(pci, PCIE_PORT_DEBUG1));
> -	imx6_pcie_reset_phy(imx6_pcie);
> -	imx6_pcie_clk_disable(imx6_pcie);
> -	if (imx6_pcie->phy != NULL) {
> -		phy_power_off(imx6_pcie->phy);
> -		phy_exit(imx6_pcie->phy);
> +	if (!imx6_pcie_cmp_mode) {
> +		imx6_pcie_reset_phy(imx6_pcie);
> +		imx6_pcie_clk_disable(imx6_pcie);
> +		if (imx6_pcie->phy != NULL) {
> +			phy_power_off(imx6_pcie->phy);
> +			phy_exit(imx6_pcie->phy);
> +		}
> +		if (imx6_pcie->vpcie)
> +			regulator_disable(imx6_pcie->vpcie);
>  	}
> -	if (imx6_pcie->vpcie)
> -		regulator_disable(imx6_pcie->vpcie);
>  	return ret;
>  }
>  
> @@ -1289,8 +1297,15 @@ static int imx6_pcie_probe(struct platform_device *pdev)
>  		return ret;
>  
>  	ret = dw_pcie_host_init(&pci->pp);
> -	if (ret < 0)
> +	if (ret < 0) {
> +		if (imx6_pcie_cmp_mode) {
> +			dev_info(dev, "driver loaded with compliance test mode enabled\n");
> +			ret = 0;
> +		} else {
> +			dev_err(dev, "unable to add PCIe port\n");
> +		}
>  		return ret;
> +	}

If you drop the error return from imx6_pcie_start_link, like I
suggested in patch 6/8, you don't need this block as dw_pcie_host_init
will succeed even if the link is down or in compliance test mode.

Regards,
Lucas

>  
>  	if (pci_msi_enabled()) {
>  		u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_MSI);


