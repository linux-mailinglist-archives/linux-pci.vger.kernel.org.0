Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 438A454D54D
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jun 2022 01:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348139AbiFOXa7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Jun 2022 19:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350013AbiFOXav (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Jun 2022 19:30:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C9917A8B;
        Wed, 15 Jun 2022 16:30:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3ADB0B821A6;
        Wed, 15 Jun 2022 23:30:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 896C9C3411A;
        Wed, 15 Jun 2022 23:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655335836;
        bh=NkGdwcHxieMFTnxcLUDpVG1NsmlVZE1ng59v2HePfHs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=fZ7NOe2wEdNeY2Sxi+NzxnePqsVz7AOn0lEgBd27kAkCQHO2AHr3vjNKWatx4cUkt
         zdDdDuuH0Vdx98KO07Ctd40jiedhbAT0EPsD9HDTkJUXz1TLf7ubc7aSghroYa8E/8
         g/ARZ+xDANnbeM0p3tjWpFW96jTqvv+CdtKUaFvN/qlMiUOSx0zkbh7k3Ff6N/57UY
         lbZAz6B/xhCZupXRGzNtFkCVEClabozaXN9iuKWPwwsBwqVqWSStWekLlsmKjN2DOB
         AeuOuZ1rPo4D6Xuw4BmTpMI8hwOccMoIcSyJ0K0Nz/Nr+K7u2VNf5Bn9WOLmJjj6qH
         MaunSnULKDWZQ==
Date:   Wed, 15 Jun 2022 18:30:34 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Fabio Estevam <festevam@gmail.com>,
        Francesco Dolcini <francesco.dolcini@toradex.com>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v12 09/13] PCI: imx6: Turn off regulator when system is
 in suspend mode
Message-ID: <20220615233034.GA1056086@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220615231551.1054753-10-helgaas@kernel.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 15, 2022 at 06:15:47PM -0500, Bjorn Helgaas wrote:
> From: Richard Zhu <hongxing.zhu@nxp.com>
> 
> The driver should undo any enables it did itself. The regulator disable
> shouldn't be basing decisions on regulator_is_enabled().
> 
> Move the regulator_disable to the suspend function, turn off regulator when
> the system is in suspend mode.
> 
> To keep the balance of the regulator usage counter, disable the regulator
> in shutdown.
> 
> Link: https://lore.kernel.org/r/1655189942-12678-6-git-send-email-hongxing.z
> hu@nxp.com
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 19 +++++++------------
>  1 file changed, 7 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 6eddd0b5f628..537b8a2e0e3b 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -670,8 +670,6 @@ static void imx6_pcie_clk_disable(struct imx6_pcie *imx6_pcie)
>  
>  static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
>  {
> -	struct device *dev = imx6_pcie->pci->dev;
> -
>  	switch (imx6_pcie->drvdata->variant) {
>  	case IMX7D:
>  	case IMX8MQ:
> @@ -702,14 +700,6 @@ static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
>  		break;
>  	}
>  
> -	if (imx6_pcie->vpcie && regulator_is_enabled(imx6_pcie->vpcie) > 0) {
> -		int ret = regulator_disable(imx6_pcie->vpcie);
> -
> -		if (ret)
> -			dev_err(dev, "failed to disable vpcie regulator: %d\n",
> -				ret);
> -	}
> -
>  	/* Some boards don't have PCIe reset GPIO. */
>  	if (gpio_is_valid(imx6_pcie->reset_gpio))
>  		gpio_set_value_cansleep(imx6_pcie->reset_gpio,
> @@ -722,7 +712,7 @@ static int imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
>  	struct device *dev = pci->dev;
>  	int ret, err;
>  
> -	if (imx6_pcie->vpcie && !regulator_is_enabled(imx6_pcie->vpcie)) {
> +	if (imx6_pcie->vpcie) {
>  		ret = regulator_enable(imx6_pcie->vpcie);
>  		if (ret) {
>  			dev_err(dev, "failed to enable vpcie regulator: %d\n",
> @@ -796,7 +786,7 @@ static int imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
>  	return 0;
>  
>  err_clks:
> -	if (imx6_pcie->vpcie && regulator_is_enabled(imx6_pcie->vpcie) > 0) {
> +	if (imx6_pcie->vpcie) {
>  		ret = regulator_disable(imx6_pcie->vpcie);
>  		if (ret)
>  			dev_err(dev, "failed to disable vpcie regulator: %d\n",
> @@ -1023,6 +1013,9 @@ static int imx6_pcie_suspend_noirq(struct device *dev)
>  		break;
>  	}
>  
> +	if (imx6_pcie->vpcie)
> +		regulator_disable(imx6_pcie->vpcie);

This is a little bit ugly because imx6_pcie_suspend_noirq() and
imx6_pcie_resume_noirq() are not symmetric.

We call regulator_disable() directly here in
imx6_pcie_suspend_noirq(), but the corresponding regulator_enable() is
buried in imx6_pcie_deassert_core_reset().

It would be nicer if the suspend and resume paths looked more similar,
as rockchip_pcie_suspend_noirq() and rockchip_pcie_resume_noirq() do,
for example.

>  	return 0;
>  }
>  
> @@ -1269,6 +1262,8 @@ static void imx6_pcie_shutdown(struct platform_device *pdev)
>  
>  	/* bring down link, so bootloader gets clean state in case of reboot */
>  	imx6_pcie_assert_core_reset(imx6_pcie);
> +	if (imx6_pcie->vpcie)
> +		regulator_disable(imx6_pcie->vpcie);
>  }
>  
>  static const struct imx6_pcie_drvdata drvdata[] = {
> -- 
> 2.25.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
