Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD15F3794F6
	for <lists+linux-pci@lfdr.de>; Mon, 10 May 2021 19:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232091AbhEJRG0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 May 2021 13:06:26 -0400
Received: from mail-oo1-f48.google.com ([209.85.161.48]:44929 "EHLO
        mail-oo1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232128AbhEJRGT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 May 2021 13:06:19 -0400
Received: by mail-oo1-f48.google.com with SMTP id s24-20020a4aead80000b02901fec6deb28aso3606392ooh.11;
        Mon, 10 May 2021 10:05:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4vmuG3TVld/HqXLmDM7EiJT6pCpebq7PEW64VGifnmg=;
        b=jRXH3VDdnrudIMiuXmpAp4p8aIiAp/wKPb26gm0T1+dXTW5edbmmmp2fx9vUswbE/9
         5bjk93R0agr1PQRoicWHSoadqjxMgZU9RAgWueQuROesj3I9pcGr/bVS2ckHDa4ET/te
         1BVSYs3meGBxFqP6IruSgmRjze5KRgGS836+/LuyddCvbj5U0uykJUGOqxNxVwx0W+86
         wXY9Rap7vW0R4x2U1tMSbw8REpqrmgXVS6z2tm73AMpah15vKoQRhYG2JcveUMizFUHf
         MSAJUIAwN0CL36jd8WpjhyAGIkOx+kVD4NZq238LVz1CeUBKp+akWIROmRHYBJGPQAaA
         R/8A==
X-Gm-Message-State: AOAM5320feCFCZvpkdT/Mf/3H5XSDuVwN9Dk35aBpOjt0fVSCyVUADOO
        ZaKC8R4mdEoIxISoo19qIg==
X-Google-Smtp-Source: ABdhPJw/nT6sjSzKzwv88KMnQo/mWzaQwDDuSjMhRXlzZCCmwEMQzv++NmsjnZLeeuakNSfAV9yaog==
X-Received: by 2002:a4a:9c8c:: with SMTP id z12mr19809507ooj.3.1620666313343;
        Mon, 10 May 2021 10:05:13 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a14sm3222496otl.52.2021.05.10.10.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 10:05:12 -0700 (PDT)
Received: (nullmailer pid 287298 invoked by uid 1000);
        Mon, 10 May 2021 17:05:10 -0000
Date:   Mon, 10 May 2021 12:05:10 -0500
From:   Rob Herring <robh@kernel.org>
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        kernel@pengutronix.de, patchwork-lst@pengutronix.de
Subject: Re: [PATCH 3/7] PCI: imx6: Rework PHY search and mapping
Message-ID: <20210510170510.GA276768@robh.at.kernel.org>
References: <20210510141509.929120-1-l.stach@pengutronix.de>
 <20210510141509.929120-3-l.stach@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210510141509.929120-3-l.stach@pengutronix.de>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 10, 2021 at 04:15:05PM +0200, Lucas Stach wrote:
> We don't need to have a phandle of the PHY, as we know the compatible
> of the node we are looking for. This will make it easier to put add
> more PHY handling for new generations later on, where the
> "fsl,imx7d-pcie-phy" phandle would be a misnomer.
> 
> Also we can use a helper function to get the resource for us,
> simplifying out driver code a bit.

Better yes, but really all the phy handling should be split out to 
its own driver even in the older h/w with shared phy registers.

Soon as there's a chip with 2 PCI hosts, you're going to need the phy 
binding.

> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>  .../devicetree/bindings/pci/fsl,imx6q-pcie.txt  |  5 ++---
>  drivers/pci/controller/dwc/pci-imx6.c           | 17 +++++------------
>  2 files changed, 7 insertions(+), 15 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> index de4b2baf91e8..308540df99ef 100644
> --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> @@ -54,7 +54,6 @@ Additional required properties for imx7d-pcie and imx8mq-pcie:
>  	       - "pciephy"
>  	       - "apps"
>  	       - "turnoff"
> -- fsl,imx7d-pcie-phy: A phandle to an fsl,imx7d-pcie-phy node.
>  
>  Additional required properties for imx8mq-pcie:
>  - clock-names: Must include the following additional entries:
> @@ -88,8 +87,8 @@ Example:
>  
>  * Freescale i.MX7d PCIe PHY
>  
> -This is the PHY associated with the IMX7d PCIe controller.  It's used by the
> -PCI-e controller via the fsl,imx7d-pcie-phy phandle.
> +This is the PHY associated with the IMX7d PCIe controller.  It's looked up by
> +the PCI-e controller via the fsl,imx7d-pcie-phy compatible.
>  
>  Required properties:
>  - compatible:
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 922c14361cd3..5e13758222e8 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -555,7 +555,7 @@ static void imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
>  			writel(PCIE_PHY_CMN_REG26_ATT_MODE,
>  			       imx6_pcie->phy_base + PCIE_PHY_CMN_REG26);
>  		} else {
> -			dev_warn(dev, "Unable to apply ERR010728 workaround. DT missing fsl,imx7d-pcie-phy phandle ?\n");
> +			dev_warn(dev, "Unable to apply ERR010728 workaround. DT missing fsl,imx7d-pcie-phy node?\n");
>  		}
>  
>  		imx7d_pcie_wait_for_phy_pll_lock(imx6_pcie);
> @@ -970,7 +970,7 @@ static int imx6_pcie_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	struct dw_pcie *pci;
>  	struct imx6_pcie *imx6_pcie;
> -	struct device_node *np;
> +	struct device_node *np = NULL;
>  	struct resource *dbi_base;
>  	struct device_node *node = dev->of_node;
>  	int ret;
> @@ -991,17 +991,10 @@ static int imx6_pcie_probe(struct platform_device *pdev)
>  	imx6_pcie->pci = pci;
>  	imx6_pcie->drvdata = of_device_get_match_data(dev);
>  
> -	/* Find the PHY if one is defined, only imx7d uses it */
> -	np = of_parse_phandle(node, "fsl,imx7d-pcie-phy", 0);
> +	/* Find the PHY if one is present in DT, only imx7d uses it */
> +	np = of_find_compatible_node(NULL, NULL, "fsl,imx7d-pcie-phy");
>  	if (np) {
> -		struct resource res;
> -
> -		ret = of_address_to_resource(np, 0, &res);
> -		if (ret) {
> -			dev_err(dev, "Unable to map PCIe PHY\n");
> -			return ret;
> -		}
> -		imx6_pcie->phy_base = devm_ioremap_resource(dev, &res);
> +		imx6_pcie->phy_base = devm_of_iomap(dev, np, 0, NULL);
>  		if (IS_ERR(imx6_pcie->phy_base)) {
>  			dev_err(dev, "Unable to map PCIe PHY\n");
>  			return PTR_ERR(imx6_pcie->phy_base);
> -- 
> 2.29.2
> 
