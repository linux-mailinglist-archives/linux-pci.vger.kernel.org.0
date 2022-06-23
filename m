Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8759558B2E
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jun 2022 00:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbiFWWTt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Jun 2022 18:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiFWWTs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Jun 2022 18:19:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36B2366BA;
        Thu, 23 Jun 2022 15:19:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A62761947;
        Thu, 23 Jun 2022 22:19:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19DD0C341C0;
        Thu, 23 Jun 2022 22:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656022786;
        bh=QAkJ/pcFV9yqibLp92B+VmLbcqZsNm4Yso6Az/wbnpE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=hdZKwMzG/HUQuKB2JpKSbsV1P/U/fmb1yFZJi5ycNayyitbPFMrc1/OCwO8LOnZAP
         vEhiyag4kpzawOkGBP2hb+NuSCEF2ntDugFO319cDBDo0S1sVkDguWARedIoBlkQkb
         iBnT2Lt89PiCZ9pnhHRg+Id1YH+g8xHlKhLhhGZBdvPMNd1ILrrhQFrgZGCxa/gr+I
         sPrhtcgvmISqfAuvEuzyS9e2s78Xu8rpNIKD+WljYBWbFlGszTMuENQA3HF++gWa+z
         3EEqBMutWiVl5+i/UYIHy9JQpuDPxjqM+SpqFMvnf53QmiSUEdsg3TKSUzMeOBGmj2
         MumwRAzI72hbQ==
Date:   Thu, 23 Jun 2022 17:19:44 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     l.stach@pengutronix.de, bhelgaas@google.com, robh+dt@kernel.org,
        broonie@kernel.org, lorenzo.pieralisi@arm.com, festevam@gmail.com,
        francesco.dolcini@toradex.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-imx@nxp.com
Subject: Re: [PATCH v13 10/15] PCI: imx6: Turn off regulator when system is
 in suspend mode
Message-ID: <20220623221944.GA1481121@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1655461874-16908-11-git-send-email-hongxing.zhu@nxp.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 17, 2022 at 06:31:09PM +0800, Richard Zhu wrote:
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
> index 2b42c37f1617..f72eb609769b 100644
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
>  	int ret;
>  
> -	if (imx6_pcie->vpcie && !regulator_is_enabled(imx6_pcie->vpcie)) {
> +	if (imx6_pcie->vpcie) {
>  		ret = regulator_enable(imx6_pcie->vpcie);
>  		if (ret) {
>  			dev_err(dev, "failed to enable vpcie regulator: %d\n",
> @@ -795,7 +785,7 @@ static int imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
>  	return 0;
>  
>  err_clks:
> -	if (imx6_pcie->vpcie && regulator_is_enabled(imx6_pcie->vpcie) > 0) {
> +	if (imx6_pcie->vpcie) {
>  		ret = regulator_disable(imx6_pcie->vpcie);
>  		if (ret)
>  			dev_err(dev, "failed to disable vpcie regulator: %d\n",
> @@ -1022,6 +1012,9 @@ static int imx6_pcie_suspend_noirq(struct device *dev)
>  		break;
>  	}
>  
> +	if (imx6_pcie->vpcie)
> +		regulator_disable(imx6_pcie->vpcie);
> +
>  	return 0;
>  }

The suspend and resume methods should be symmetric, and they should
*look* symmetric.

imx6_pcie_suspend_noirq() disables the regulator, so
imx6_pcie_resume_noirq() should enable it.

imx6_pcie_suspend_noirq() calls imx6_pcie_clk_disable() to disable
several clocks.  imx6_pcie_resume_noirq() should call
imx6_pcie_clk_enable() to enable them.

imx6_pcie_clk_enable() *is* called in the resume path, but it's buried
inside imx6_pcie_host_init() and imx6_pcie_deassert_core_reset().
That makes it hard to analyze.

We should be able to look at imx6_pcie_suspend_noirq() and
imx6_pcie_resume_noirq() and easily see that the resume path resumes
everything that was suspended in the suspend path.

Bjorn
