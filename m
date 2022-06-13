Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCBDE54A209
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jun 2022 00:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231981AbiFMWVX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jun 2022 18:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbiFMWVX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Jun 2022 18:21:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A11842DD58;
        Mon, 13 Jun 2022 15:21:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3B357614E1;
        Mon, 13 Jun 2022 22:21:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B347C34114;
        Mon, 13 Jun 2022 22:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655158881;
        bh=nlwQXs75cmtdhpBdJq2NMEj5gmKBm8iKQVRpWIQ9K8I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=KruTBi4WgF++vsI5D55FT3ww4QRsubCGiagi2uhIqOTED9DxwCtIyIwLBP+6g6foZ
         x0/beM3ci/OJa2cB2BKMQCD6KpZZ6EyVdNJbztIzvYNoQ6f94ibgiGohlngzODMy89
         WJDBoaViGjpqBOeRmSk+agruwWndko5q74DNpCG9jpOIJpkPf2c44Viy4ZF0RABh29
         JeweSZGX/sOK3tMVO+NXte/+stMmirExcmWdo3OsoiaAR+5ZqafWLzsRp2+s+/6Tu4
         HMj2maiy7ifbUZ+SOpVb/pMth7cKOYPfukqNj4DYOpexPtwNzO5+57hWdZk4tZUvwS
         WPYam8tCCJ5bw==
Date:   Mon, 13 Jun 2022 17:21:19 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     l.stach@pengutronix.de, bhelgaas@google.com, robh+dt@kernel.org,
        broonie@kernel.org, lorenzo.pieralisi@arm.com, festevam@gmail.com,
        francesco.dolcini@toradex.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-imx@nxp.com
Subject: Re: [PATCH v10 6/7] PCI: imx6: Mark the link down as none fatal error
Message-ID: <20220613222119.GA716475@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1655110538-10914-7-git-send-email-hongxing.zhu@nxp.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 13, 2022 at 04:55:37PM +0800, Richard Zhu wrote:
> let the driver probe successfully, return zero in imx6_pcie_start_link()
> when PCIe link is down.
> 
> Because i.MX PCIe doesn't support hot-plug feature.
> In this link down scenario, only start the PCIe link training in resume
> when the link is up before system suspend to avoid the long latency in
> the link training period.

This looks like two changes that should be separate patches:

  1) Make driver probe successful even if link is down.

  2) Reduce resume time by only starting the link if it was up before
     suspend.

> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index c02748393aac..ac6ec2d691a0 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -67,6 +67,7 @@ struct imx6_pcie {
>  	struct dw_pcie		*pci;
>  	int			reset_gpio;
>  	bool			gpio_active_high;
> +	bool			link_is_up;
>  	struct clk		*pcie_bus;
>  	struct clk		*pcie_phy;
>  	struct clk		*pcie_inbound_axi;
> @@ -845,7 +846,9 @@ static int imx6_pcie_start_link(struct dw_pcie *pci)
>  	/* Start LTSSM. */
>  	imx6_pcie_ltssm_enable(dev);
>  
> -	dw_pcie_wait_for_link(pci);
> +	ret = dw_pcie_wait_for_link(pci);
> +	if (ret)
> +		goto err_reset_phy;
>  
>  	if (pci->link_gen == 2) {
>  		/* Allow Gen2 mode after the link is up. */
> @@ -881,11 +884,14 @@ static int imx6_pcie_start_link(struct dw_pcie *pci)
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
>  
> +	imx6_pcie->link_is_up = true;
>  	tmp = dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKSTA);
>  	dev_info(dev, "Link up, Gen%i\n", tmp & PCI_EXP_LNKSTA_CLS);
>  	return 0;
> @@ -895,7 +901,7 @@ static int imx6_pcie_start_link(struct dw_pcie *pci)
>  		dw_pcie_readl_dbi(pci, PCIE_PORT_DEBUG0),
>  		dw_pcie_readl_dbi(pci, PCIE_PORT_DEBUG1));
>  	imx6_pcie_reset_phy(imx6_pcie);
> -	return ret;
> +	return 0;
>  }
>  
>  static int imx6_pcie_host_init(struct pcie_port *pp)
> @@ -1022,10 +1028,8 @@ static int imx6_pcie_resume_noirq(struct device *dev)
>  	imx6_pcie_init_phy(imx6_pcie);
>  	imx6_pcie_deassert_core_reset(imx6_pcie);
>  	dw_pcie_setup_rc(pp);
> -
> -	ret = imx6_pcie_start_link(imx6_pcie->pci);
> -	if (ret < 0)
> -		dev_info(dev, "pcie link is down after resume.\n");
> +	if (imx6_pcie->link_is_up)
> +		imx6_pcie_start_link(imx6_pcie->pci);
>  
>  	return 0;
>  }
> -- 
> 2.25.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
