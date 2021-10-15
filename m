Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2A6542FACC
	for <lists+linux-pci@lfdr.de>; Fri, 15 Oct 2021 20:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242081AbhJOSSZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Oct 2021 14:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237653AbhJOSSY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Oct 2021 14:18:24 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 065EDC061570
        for <linux-pci@vger.kernel.org>; Fri, 15 Oct 2021 11:16:18 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1mbRkc-0000pL-Fg; Fri, 15 Oct 2021 20:16:14 +0200
Message-ID: <6c2cd328dfd407002339d1c83ebd5b832d4f377d.camel@pengutronix.de>
Subject: Re: [RESEND v2 2/5] PCI: imx6: Add the error propagation from
 host_init
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Richard Zhu <hongxing.zhu@nxp.com>, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com
Cc:     linux-pci@vger.kernel.org, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Date:   Fri, 15 Oct 2021 20:16:13 +0200
In-Reply-To: <1634277941-6672-3-git-send-email-hongxing.zhu@nxp.com>
References: <1634277941-6672-1-git-send-email-hongxing.zhu@nxp.com>
         <1634277941-6672-3-git-send-email-hongxing.zhu@nxp.com>
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
> Since there is error return check of the host_init callback, add error
> check to imx6_pcie_deassert_core_reset() function, and change the
> function type accordingly.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 24 ++++++++++++++++--------
>  1 file changed, 16 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 1fa1dba6da81..3372775834a2 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -527,24 +527,24 @@ static void imx7d_pcie_wait_for_phy_pll_lock(struct imx6_pcie *imx6_pcie)
>  		dev_err(dev, "PCIe PLL lock timeout\n");
>  }
>  
> -static void imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
> +static int imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
>  {
>  	struct dw_pcie *pci = imx6_pcie->pci;
>  	struct device *dev = pci->dev;
> -	int ret;
> +	int ret, err;
>  
>  	if (imx6_pcie->vpcie && !regulator_is_enabled(imx6_pcie->vpcie)) {
>  		ret = regulator_enable(imx6_pcie->vpcie);
>  		if (ret) {
>  			dev_err(dev, "failed to enable vpcie regulator: %d\n",
>  				ret);
> -			return;
> +			return ret;
>  		}
>  	}
>  
> -	ret = imx6_pcie_clk_enable(imx6_pcie);
> -	if (ret) {
> -		dev_err(dev, "unable to enable pcie clocks\n");
> +	err = imx6_pcie_clk_enable(imx6_pcie);
> +	if (err) {
> +		dev_err(dev, "unable to enable pcie clocks: %d\n", err);
>  		goto err_clks;
>  	}
>  
> @@ -599,7 +599,7 @@ static void imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
>  		break;
>  	}
>  
> -	return;
> +	return 0;
>  
>  err_clks:
>  	if (imx6_pcie->vpcie && regulator_is_enabled(imx6_pcie->vpcie) > 0) {
> @@ -608,6 +608,7 @@ static void imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
>  			dev_err(dev, "failed to disable vpcie regulator: %d\n",
>  				ret);
>  	}
> +	return err;
>  }
>  
>  static void imx6_pcie_configure_type(struct imx6_pcie *imx6_pcie)
> @@ -858,11 +859,18 @@ static int imx6_pcie_start_link(struct dw_pcie *pci)
>  static int imx6_pcie_host_init(struct pcie_port *pp)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct device *dev = pci->dev;
>  	struct imx6_pcie *imx6_pcie = to_imx6_pcie(pci);
> +	int ret;
>  
>  	imx6_pcie_assert_core_reset(imx6_pcie);
>  	imx6_pcie_init_phy(imx6_pcie);
> -	imx6_pcie_deassert_core_reset(imx6_pcie);
> +	ret = imx6_pcie_deassert_core_reset(imx6_pcie);
> +	if (ret < 0) {
> +		dev_err(dev, "pcie host init failed: %d.\n", ret);
> +		return ret;
> +	}
> +
>  	imx6_setup_phy_mpll(imx6_pcie);
>  
>  	return 0;


