Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A49234C1A36
	for <lists+linux-pci@lfdr.de>; Wed, 23 Feb 2022 18:50:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241513AbiBWRus (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Feb 2022 12:50:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237008AbiBWRus (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Feb 2022 12:50:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ACC35FF7;
        Wed, 23 Feb 2022 09:50:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EC1FD61470;
        Wed, 23 Feb 2022 17:50:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D6BBC340F0;
        Wed, 23 Feb 2022 17:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645638618;
        bh=tlGfAuQ/IMqnIqCvJXqfuyQ+e69E/QZS0Z5cZBeqpE8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=bh21cG5LASljj+iTvs99EC8JUuAQtfLwUEc0e+65NH1U3Uo4I/ED6ZvGFkYaZzu/K
         OHqcyfw8UzkHRfZPvXTYy0LPmIe6Tfv8XEHmpvCxrW/tNkZD4K1pG/1Mdixg6iQ5Ks
         MOrP7WgTgmC04jthUlXOCNtsoPlTnXkTq+dVkRTS/8fUSfTm5BtOEPJHRAaLgV/5cz
         6mrmtttvKn9ufUbIw1FNAF9+Y1weqJ9hg4898GTrxcnRxoXLBXRx1tp7BCw/6c/w/O
         7CKucBDo2o4ctGU1E/S2MXlrPzpIyxvpFtcNr82fro0rKZ3aLg5vRIGnOXN5dAM91w
         jyeOJoiq2FhXw==
Date:   Wed, 23 Feb 2022 11:50:16 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     l.stach@pengutronix.de, bhelgaas@google.com, broonie@kernel.org,
        lorenzo.pieralisi@arm.com, jingoohan1@gmail.com,
        festevam@gmail.com, francesco.dolcini@toradex.com,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com
Subject: Re: [PATCH v7 7/8] PCI: imx6: Disable enabled clocks and regulators
 after link is down
Message-ID: <20220223175016.GA140091@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1644992463-14467-8-git-send-email-hongxing.zhu@nxp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In subject,

s/Disable enabled clocks/Disable clocks/

On Wed, Feb 16, 2022 at 02:21:02PM +0800, Richard Zhu wrote:
> Since i.MX PCIe doesn't support the hot-plug, and to save power
> consumption as much as possible. Return error and disable the enabled
> clocks and regulators when link is down,.

Maybe:

  Since i.MX PCIe doesn't support hot-plug, reduce power consumption
  as much as possible by disabling clocks and regulators and returning
  error when the link is down.

> Add a new host_exit() callback for i.MX PCIe driver to disable the
> enabled clocks, regulators and so on in the error handling after
> host_init is finished.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 30 ++++++++++++++++++++++++---
>  1 file changed, 27 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 242d8ef73c1e..fe671e88ec93 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -848,7 +848,9 @@ static int imx6_pcie_start_link(struct dw_pcie *pci)
>  	/* Start LTSSM. */
>  	imx6_pcie_ltssm_enable(dev);
>  
> -	dw_pcie_wait_for_link(pci);
> +	ret = dw_pcie_wait_for_link(pci);
> +	if (ret)
> +		goto err_reset_phy;

These labels look wrong now, since you no longer reset the PHY at
err_reset_phy.

>  	if (pci->link_gen == 2) {
>  		/* Allow Gen2 mode after the link is up. */
> @@ -884,7 +886,9 @@ static int imx6_pcie_start_link(struct dw_pcie *pci)
>  		}
>  
>  		/* Make sure link training is finished as well! */
> -		dw_pcie_wait_for_link(pci);
> +		ret = dw_pcie_wait_for_link(pci);
> +		if (ret)
> +			goto err_reset_phy;
>  	} else {
>  		dev_info(dev, "Link: Gen2 disabled\n");
>  	}
> @@ -897,7 +901,6 @@ static int imx6_pcie_start_link(struct dw_pcie *pci)
>  	dev_dbg(dev, "PHY DEBUG_R0=0x%08x DEBUG_R1=0x%08x\n",
>  		dw_pcie_readl_dbi(pci, PCIE_PORT_DEBUG0),
>  		dw_pcie_readl_dbi(pci, PCIE_PORT_DEBUG1));
> -	imx6_pcie_reset_phy(imx6_pcie);
>  	return ret;
>  }
>  
> @@ -921,8 +924,29 @@ static int imx6_pcie_host_init(struct pcie_port *pp)
>  	return 0;
>  }
>  
> +static void imx6_pcie_host_exit(struct pcie_port *pp)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct device *dev = pci->dev;
> +	struct imx6_pcie *imx6_pcie = to_imx6_pcie(pci);
> +
> +	imx6_pcie_reset_phy(imx6_pcie);
> +	imx6_pcie_clk_disable(imx6_pcie);
> +	switch (imx6_pcie->drvdata->variant) {
> +	case IMX8MM:
> +		if (phy_power_off(imx6_pcie->phy))
> +			dev_err(dev, "unable to power off phy\n");
> +		break;
> +	default:
> +		break;
> +	}
> +	if (imx6_pcie->vpcie)
> +		regulator_disable(imx6_pcie->vpcie);
> +}
> +
>  static const struct dw_pcie_host_ops imx6_pcie_host_ops = {
>  	.host_init = imx6_pcie_host_init,
> +	.host_exit = imx6_pcie_host_exit,
>  };
>  
>  static const struct dw_pcie_ops dw_pcie_ops = {
> -- 
> 2.25.1
> 
