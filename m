Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B84261771B
	for <lists+linux-pci@lfdr.de>; Thu,  3 Nov 2022 08:05:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbiKCHFT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Nov 2022 03:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbiKCHFQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Nov 2022 03:05:16 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C630120AB
        for <linux-pci@vger.kernel.org>; Thu,  3 Nov 2022 00:05:11 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1oqUHi-0004a5-Ur; Thu, 03 Nov 2022 08:05:07 +0100
Message-ID: <ff2f43f9-b04e-a224-02c2-d446a68c5337@pengutronix.de>
Date:   Thu, 3 Nov 2022 08:05:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Subject: Re: [PATCH v1] PCI: imx6: Keep the GPIO regulator always on
To:     Richard Zhu <hongxing.zhu@nxp.com>, l.stach@pengutronix.de,
        bhelgaas@google.com, lorenzo.pieralisi@arm.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org
References: <1667455698-14578-1-git-send-email-hongxing.zhu@nxp.com>
Content-Language: en-US
In-Reply-To: <1667455698-14578-1-git-send-email-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Richard,

On 03.11.22 07:08, Richard Zhu wrote:
> Since vpcie regulator is one GPIO regulator, used to control the
> VPCIe_3V3 and power up remote PCIe EP device.

Regulator need not be a GPIO regulator. I'd drop this from the
title.

> Some WIFI modules load their firmware once in probe, and can't be
> powered off during suspend. Otherwise, these WIFI modules wouldn't be
> functional anymore after resume back.

The brcmfmac OTOH, reprobes when resuming from suspend. Before this patch,
AFAIU, it should've been possible for the EP to go into D3cold during suspend.
This may no longer be possible when we keep vpcie powered.

> So, keep this regulator always on in the probe.
> 
> Fixes: a4bb720eeb1e ("PCI: imx6: Turn off regulator when system is in suspend mode")

Prior to a4bb720eeb1e, vpcie was briefly toggled during PCIe core reset sequence,
so aforementioned WiFi modules that don't reprobe over resume should've been broken
by that too? If so, I don't see how it fixes that commit as everything that is broken
now was broken before that commit as well. After this patch however, modules that can
accept vpcie being toggled can't benefit from some of the power saving.

Why can't users with this issue use a regulator-always-on regulator instead?

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

Shouldn't the regulator enable be undone if the probe later fails?

Cheers,
Ahmad

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

