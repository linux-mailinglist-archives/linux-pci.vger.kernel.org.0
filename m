Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2278A42FAFB
	for <lists+linux-pci@lfdr.de>; Fri, 15 Oct 2021 20:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242618AbhJOSa5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Oct 2021 14:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237667AbhJOSa5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Oct 2021 14:30:57 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A8C5C061570
        for <linux-pci@vger.kernel.org>; Fri, 15 Oct 2021 11:28:50 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1mbRwk-0001z6-T2; Fri, 15 Oct 2021 20:28:46 +0200
Message-ID: <52a13aa3b7798d0cb77d45b20993f5494c91f014.camel@pengutronix.de>
Subject: Re: [RESEND v2 5/5] PCI: imx6: Add the compliance tests mode support
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Richard Zhu <hongxing.zhu@nxp.com>, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com
Cc:     linux-pci@vger.kernel.org, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Date:   Fri, 15 Oct 2021 20:28:45 +0200
In-Reply-To: <1634277941-6672-6-git-send-email-hongxing.zhu@nxp.com>
References: <1634277941-6672-1-git-send-email-hongxing.zhu@nxp.com>
         <1634277941-6672-6-git-send-email-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am Freitag, dem 15.10.2021 um 14:05 +0800 schrieb Richard Zhu:
> Refer to the system board signal Quality of PCIe archiecture PHY test
> specification. Signal quality tests(for example: jitters,  differential
> eye opening and so on ) can be executed with devices in the
> polling.compliance state.
> 
> To let the device support polling.compliance stat, the clocks and powers
> shouldn't be turned off when the probe of device driver is failed.
> 
> Based on CLB(Compliance Load Board) Test Fixture and so on test
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
>  drivers/pci/controller/dwc/pci-imx6.c | 32 ++++++++++++++++++++-------
>  1 file changed, 24 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index d6a5d99ffa52..e861a516d517 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -143,6 +143,10 @@ struct imx6_pcie {
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
> @@ -812,10 +816,12 @@ static int imx6_pcie_start_link(struct dw_pcie *pci)
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
> @@ -876,9 +882,12 @@ static int imx6_pcie_start_link(struct dw_pcie *pci)
>  		dw_pcie_readl_dbi(pci, PCIE_PORT_DEBUG0),
>  		dw_pcie_readl_dbi(pci, PCIE_PORT_DEBUG1));
>  	imx6_pcie_reset_phy(imx6_pcie);

Is it correct to reset the PHY here when in compliance test mode?

> -	imx6_pcie_clk_disable(imx6_pcie);
> -	if (imx6_pcie->vpcie && regulator_is_enabled(imx6_pcie->vpcie) > 0)
> -		regulator_disable(imx6_pcie->vpcie);
> +	if (!imx6_pcie_cmp_mode) {
> +		imx6_pcie_clk_disable(imx6_pcie);
> +		if (imx6_pcie->vpcie
> +		    && regulator_is_enabled(imx6_pcie->vpcie) > 0)
> +			regulator_disable(imx6_pcie->vpcie);
> +	}
>  	return ret;
>  }
>  
> @@ -1183,8 +1192,15 @@ static int imx6_pcie_probe(struct platform_device *pdev)
>  		return ret;
>  
>  	ret = dw_pcie_host_init(&pci->pp);
> -	if (ret < 0)
> +	if (ret < 0) {
> +		if (imx6_pcie_cmp_mode) {
> +			dev_info(dev, "Driver loaded with compliance test mode enabled.\n");
> +			ret = 0;
> +		} else {
> +			dev_err(dev, "Unable to add pcie port.\n");
> +		}
>  		return ret; 
> +	}
>  
>  	if (pci_msi_enabled()) {
>  		u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_MSI);


