Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1E9617170
	for <lists+linux-pci@lfdr.de>; Thu,  3 Nov 2022 00:10:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbiKBXKr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Nov 2022 19:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbiKBXKn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Nov 2022 19:10:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E460103A;
        Wed,  2 Nov 2022 16:10:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A6F0FB82528;
        Wed,  2 Nov 2022 23:10:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20676C433D6;
        Wed,  2 Nov 2022 23:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667430639;
        bh=7z2vQGpx8aQdXx6lSmQcW2FtPxBrqDU9ClMERbgqoT8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=LzlSIBqRlMoZwqnBUQaox+KQrA6wW1lP+R4NKx62il+eYjhu8jk7Ru8bt3WgvjiQE
         N+ygvU74YQlOMYNN0P384TX12D+C91SkKdaDBUOBFXdqUiu44yF8ODAqdNsWXkg7mj
         7TUKHjdYGLTL3NPruUfXexd8LCDx4mGYrLykh/cUA4MQGdP9A87jrSLO0SIi1J95B0
         oK+L0vmElBStgyC0NEtP94jZJnIZunSlezOMNBN5t/B17RUO14VXdye2Jthtz2Ei5D
         TmbzENaRt4xPrABC8WCMlwhi4WC93GS2Vy/EQ7ph1AYG8gJsC5DYqU+KV20YqJduX5
         Utd0iMsjkKXpw==
Date:   Wed, 2 Nov 2022 18:10:37 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     l.stach@pengutronix.de, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-imx@nxp.com
Subject: Re: [PATCH v1] PCI: imx6: Set MSI enable bit of RC in resume
Message-ID: <20221102231037.GA6902@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1667289595-12440-1-git-send-email-hongxing.zhu@nxp.com>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 01, 2022 at 03:59:55PM +0800, Richard Zhu wrote:
> The MSI Enable bit controls delivery of MSI interrupts from components
> below the Root Port. This bit might lost during the suspend, should be
> re-configured during resume.

Just out of curiosity, why would this bit "get lost" during suspend?

Don't the normal save and restore in the suspend/resume paths take
care of this?  Are there other bits that might get lost?

> Encapsulate the MSI enable set into a standalone function, and invoke it
> in both probe and resume.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 24 +++++++++++++++++-------
>  1 file changed, 17 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 2616585ca5f8..dba15546075f 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -1041,6 +1041,21 @@ static void imx6_pcie_pm_turnoff(struct imx6_pcie *imx6_pcie)
>  	usleep_range(1000, 10000);
>  }
>  
> +static void pci_imx_set_msi_en(struct dw_pcie *pci)
> +{
> +	u8 offset;
> +	u16 val;
> +
> +	if (pci_msi_enabled()) {
> +		offset = dw_pcie_find_capability(pci, PCI_CAP_ID_MSI);
> +		dw_pcie_dbi_ro_wr_en(pci);
> +		val = dw_pcie_readw_dbi(pci, offset + PCI_MSI_FLAGS);
> +		val |= PCI_MSI_FLAGS_ENABLE;
> +		dw_pcie_writew_dbi(pci, offset + PCI_MSI_FLAGS, val);
> +		dw_pcie_dbi_ro_wr_dis(pci);
> +	}
> +}
> +
>  static int imx6_pcie_suspend_noirq(struct device *dev)
>  {
>  	struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);
> @@ -1073,6 +1088,7 @@ static int imx6_pcie_resume_noirq(struct device *dev)
>  	if (imx6_pcie->link_is_up)
>  		imx6_pcie_start_link(imx6_pcie->pci);
>  
> +	pci_imx_set_msi_en(imx6_pcie->pci);
>  	return 0;
>  }
>  
> @@ -1090,7 +1106,6 @@ static int imx6_pcie_probe(struct platform_device *pdev)
>  	struct resource *dbi_base;
>  	struct device_node *node = dev->of_node;
>  	int ret;
> -	u16 val;
>  
>  	imx6_pcie = devm_kzalloc(dev, sizeof(*imx6_pcie), GFP_KERNEL);
>  	if (!imx6_pcie)
> @@ -1282,12 +1297,7 @@ static int imx6_pcie_probe(struct platform_device *pdev)
>  	if (ret < 0)
>  		return ret;
>  
> -	if (pci_msi_enabled()) {
> -		u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_MSI);
> -		val = dw_pcie_readw_dbi(pci, offset + PCI_MSI_FLAGS);
> -		val |= PCI_MSI_FLAGS_ENABLE;
> -		dw_pcie_writew_dbi(pci, offset + PCI_MSI_FLAGS, val);
> -	}
> +	pci_imx_set_msi_en(pci);
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
