Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6996617972
	for <lists+linux-pci@lfdr.de>; Thu,  3 Nov 2022 10:12:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbiKCJLm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Nov 2022 05:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbiKCJLj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Nov 2022 05:11:39 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F85CDE85
        for <linux-pci@vger.kernel.org>; Thu,  3 Nov 2022 02:11:38 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1oqWG6-0004Sh-Fm; Thu, 03 Nov 2022 10:11:34 +0100
Message-ID: <8561d5ac952d39bf3d1923ca9e3fa651ab1bb531.camel@pengutronix.de>
Subject: Re: [PATCH v1] PCI: imx6: Keep the GPIO regulator always on
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Richard Zhu <hongxing.zhu@nxp.com>, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com
Date:   Thu, 03 Nov 2022 10:11:33 +0100
In-Reply-To: <1667455698-14578-1-git-send-email-hongxing.zhu@nxp.com>
References: <1667455698-14578-1-git-send-email-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am Donnerstag, dem 03.11.2022 um 14:08 +0800 schrieb Richard Zhu:
> Since vpcie regulator is one GPIO regulator, used to control the
> VPCIe_3V3 and power up remote PCIe EP device.
> 
> Some WIFI modules load their firmware once in probe, and can't be
> powered off during suspend. Otherwise, these WIFI modules wouldn't be
> functional anymore after resume back.

I would call this a bug in the WiFi driver.

I think we need to walk down the PCIe hierarchy to see if it is safe to
disable the PCIe regulator. When all devices in the hierarchy are in
D3hot state, we can safely put the whole hierarchy into D3cold by
removing power. When any of the devices connected to the  RC are in a
state other than D3hot, we need to keep the regulator enabled, as those
devices may need power in suspend to implement wakeups or other
functionality that should be available during suspend.

Regards,
Lucas

> 
> So, keep this regulator always on in the probe.
> 
> Fixes: a4bb720eeb1e ("PCI: imx6: Turn off regulator when system is in suspend mode")
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 24 ++++++++----------------
>  1 file changed, 8 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 2616585ca5f8..94a89bbf381d 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -926,22 +926,13 @@ static int imx6_pcie_host_init(struct dw_pcie_rp *pp)
>  	struct imx6_pcie *imx6_pcie = to_imx6_pcie(pci);
>  	int ret;
>  
> -	if (imx6_pcie->vpcie) {
> -		ret = regulator_enable(imx6_pcie->vpcie);
> -		if (ret) {
> -			dev_err(dev, "failed to enable vpcie regulator: %d\n",
> -				ret);
> -			return ret;
> -		}
> -	}
> -
>  	imx6_pcie_assert_core_reset(imx6_pcie);
>  	imx6_pcie_init_phy(imx6_pcie);
>  
>  	ret = imx6_pcie_clk_enable(imx6_pcie);
>  	if (ret) {
>  		dev_err(dev, "unable to enable pcie clocks: %d\n", ret);
> -		goto err_reg_disable;
> +		return ret;
>  	}
>  
>  	if (imx6_pcie->phy) {
> @@ -974,9 +965,6 @@ static int imx6_pcie_host_init(struct dw_pcie_rp *pp)
>  		phy_exit(imx6_pcie->phy);
>  err_clk_disable:
>  	imx6_pcie_clk_disable(imx6_pcie);
> -err_reg_disable:
> -	if (imx6_pcie->vpcie)
> -		regulator_disable(imx6_pcie->vpcie);
>  	return ret;
>  }
>  
> @@ -991,9 +979,6 @@ static void imx6_pcie_host_exit(struct dw_pcie_rp *pp)
>  		phy_exit(imx6_pcie->phy);
>  	}
>  	imx6_pcie_clk_disable(imx6_pcie);
> -
> -	if (imx6_pcie->vpcie)
> -		regulator_disable(imx6_pcie->vpcie);
>  }
>  
>  static const struct dw_pcie_host_ops imx6_pcie_host_ops = {
> @@ -1263,6 +1248,13 @@ static int imx6_pcie_probe(struct platform_device *pdev)
>  		if (PTR_ERR(imx6_pcie->vpcie) != -ENODEV)
>  			return PTR_ERR(imx6_pcie->vpcie);
>  		imx6_pcie->vpcie = NULL;
> +	} else {
> +		ret = regulator_enable(imx6_pcie->vpcie);
> +		if (ret) {
> +			dev_err(dev, "failed to enable vpcie regulator: %d\n",
> +				ret);
> +			return ret;
> +		}
>  	}
>  
>  	imx6_pcie->vph = devm_regulator_get_optional(&pdev->dev, "vph");


