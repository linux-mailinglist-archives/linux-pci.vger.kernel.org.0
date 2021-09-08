Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0961640362B
	for <lists+linux-pci@lfdr.de>; Wed,  8 Sep 2021 10:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348201AbhIHIfi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Sep 2021 04:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348153AbhIHIfh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Sep 2021 04:35:37 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C81C061575
        for <linux-pci@vger.kernel.org>; Wed,  8 Sep 2021 01:34:30 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1mNt2H-0005ij-8h; Wed, 08 Sep 2021 10:34:25 +0200
Message-ID: <bd4ead76c27afbb3d089bc355d8d3f62b4ad269e.camel@pengutronix.de>
Subject: Re: [PATCH 3/3] PCI: imx: add compliance tests mode to enable
 measure signal quality
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Richard Zhu <hongxing.zhu@nxp.com>, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com
Cc:     linux-pci@vger.kernel.org, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Date:   Wed, 08 Sep 2021 10:34:23 +0200
In-Reply-To: <1631084366-24785-3-git-send-email-hongxing.zhu@nxp.com>
References: <1631084366-24785-1-git-send-email-hongxing.zhu@nxp.com>
         <1631084366-24785-3-git-send-email-hongxing.zhu@nxp.com>
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

Hi Richard,

Am Mittwoch, dem 08.09.2021 um 14:59 +0800 schrieb Richard Zhu:
> Refer to the system board signal Quality of PCIe archiecture PHY test
> specification. Signal quality tests can be executed with devices in the
> polling.compliance state.
> 
> To let the device support polling.compliance stat, the clocks and
> powers shouldn't be turned off during the compliance tests although
> the PHY link might be down.
> Add the i.MX PCIe compliance tests mode enable option to keep the and
> powers on, and finish the driver probe without error return.
> 
> Use the "pcie_cmp_enabled=yes" in kernel command line to enable the
> compliance tests mode.

Adding "random" kernel command line options isn't going to fly. If at
all, this should be a module_param so it gets properly namespaced. Also
this needs a more descriptive name, right now this is abbreviating the
one thing that would tell a user what this is about: compliance
testing.

> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 41 +++++++++++++++++++++------
>  1 file changed, 33 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 129928e42f84..3aef0e86f1c2 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -143,6 +143,7 @@ struct imx6_pcie {
>  #define PHY_RX_OVRD_IN_LO_RX_DATA_EN		BIT(5)
>  #define PHY_RX_OVRD_IN_LO_RX_PLL_EN		BIT(3)
>  
> +static int imx6_pcie_cmp_enabled;
>  static int imx6_pcie_clk_enable(struct imx6_pcie *imx6_pcie);
>  static void imx6_pcie_clk_disable(struct imx6_pcie *imx6_pcie);
>  
> @@ -748,10 +749,12 @@ static int imx6_pcie_start_link(struct dw_pcie *pci)
>  	 * started in Gen2 mode, there is a possibility the devices on the
>  	 * bus will not be detected at all.  This happens with PCIe switches.
>  	 */
> -	tmp = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCAP);
> -	tmp &= ~PCI_EXP_LNKCAP_SLS;
> -	tmp |= PCI_EXP_LNKCAP_SLS_2_5GB;
> -	dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCAP, tmp);
> +	if (!imx6_pcie_cmp_enabled) {
> +		tmp = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCAP);
> +		tmp &= ~PCI_EXP_LNKCAP_SLS;
> +		tmp |= PCI_EXP_LNKCAP_SLS_2_5GB;
> +		dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCAP, tmp);
> +	}
>  
>  	/* Start LTSSM. */
>  	imx6_pcie_ltssm_enable(dev);
> @@ -812,9 +815,12 @@ static int imx6_pcie_start_link(struct dw_pcie *pci)
>  		dw_pcie_readl_dbi(pci, PCIE_PORT_DEBUG0),
>  		dw_pcie_readl_dbi(pci, PCIE_PORT_DEBUG1));
>  	imx6_pcie_reset_phy(imx6_pcie);
> -	imx6_pcie_clk_disable(imx6_pcie);
> -	if (imx6_pcie->vpcie && regulator_is_enabled(imx6_pcie->vpcie) > 0)
> -		regulator_disable(imx6_pcie->vpcie);
> +	if (!imx6_pcie_cmp_enabled) {
> +		imx6_pcie_clk_disable(imx6_pcie);
> +		if (imx6_pcie->vpcie
> +		    && regulator_is_enabled(imx6_pcie->vpcie) > 0)
> +			regulator_disable(imx6_pcie->vpcie);
> +	}
>  	return ret;
>  }
>  
> @@ -1010,6 +1016,17 @@ static const struct dev_pm_ops imx6_pcie_pm_ops = {
>  				      imx6_pcie_resume_noirq)
>  };
>  
> +static int __init imx6_pcie_compliance_test_enable(char *str)
> +{
> +	if (!strcmp(str, "yes")) {
> +		pr_info("Enable the i.MX PCIe TX/CLK compliance tests mode.\n");
> +		imx6_pcie_cmp_enabled = 1;
> +	}
> +	return 1;
> +}
> +
> +__setup("pcie_cmp_enabled=", imx6_pcie_compliance_test_enable);
> +
>  static int imx6_pcie_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -1187,8 +1204,16 @@ static int imx6_pcie_probe(struct platform_device *pdev)
>  		return ret;
>  
>  	ret = dw_pcie_host_init(&pci->pp);
> -	if (ret < 0)
> +	if (ret < 0) {
> +		if (imx6_pcie_cmp_enabled) {
> +			/* The PCIE clocks and powers wouldn't be turned off */
> +			dev_info(dev, "To do the compliance tests.\n");

This needs a better message, like "Driver loaded with compliance test
mode enabled" and the message needs to be shown unconditionally, not
only when the host init fails. We don't want to have the user track
down weird issues when the compliance test option was specified by
accident and the link is almost working due to this.

Regards,
Lucas
 
> +			ret = 0;
> +		} else {
> +			dev_err(dev, "Unable to add pcie port.\n");
> +		}
>  		return ret;
> +	}
>  
>  	if (pci_msi_enabled()) {
>  		u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_MSI);


