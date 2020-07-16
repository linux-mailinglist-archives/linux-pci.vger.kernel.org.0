Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA435222E64
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jul 2020 00:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbgGPWGd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Jul 2020 18:06:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:53386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726007AbgGPWGc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 16 Jul 2020 18:06:32 -0400
Received: from localhost (mobile-166-175-191-139.mycingular.net [166.175.191.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A33CF207CB;
        Thu, 16 Jul 2020 22:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594937192;
        bh=5HCKWjFC8y6BxQfhehJHW/n1R4IoPDaMe/czVqxsK1o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=J8b6uiEa5Bnkr48S5nTo6/WA4aeskRqrZoig7lMkTV8a6qHT3hb1DuO6f+zv87XsT
         5a00U0ZVi5SoGx5fa/mKZWlJRr4kXz/fMTj0r0fDyBbMWwRTS8N5yahHq2B1MeRswZ
         MHYnHSUrWAuSU3LaMzYIouJFjSud8+nComAEHi1A=
Date:   Thu, 16 Jul 2020 17:06:29 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] PCI: imx6: Use fallthrough pseudo-keyword
Message-ID: <20200716220629.GA663054@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716211052.GA16893@embeddedor>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 16, 2020 at 04:10:52PM -0500, Gustavo A. R. Silva wrote:
> Replace the existing /* fall through */ comments and its variants with
> the new pseudo-keyword macro fallthrough[1]. Also, remove unnecessary
> fall-through markings when it is the case.
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html?highlight=fallthrough#implicit-switch-case-fall-through

Hi Gustavo,

I'm certainly fine with these patches, and thanks for doing them!

And thanks for providing a link to the rationale.  But the URL
contains "latest", so I think it may break if deprecated.rst or the
section is ever renamed.

I think I would prefer if we could reference the current text, e.g.,
via

  https://www.kernel.org/doc/html/v5.7-rc7/process/deprecated.html#implicit-switch-case-fall-through

(The v5.7 doc would be better but doesn't seem to be generated yet; I
pinged the helpdesk about that.)

Or we could refer to b9918bdcac1f ("Documentation/process: Add
fallthrough pseudo-keyword"), although it's not nearly as pretty as
the HTML.

> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 4e5c379ae418..1119ded593d0 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -439,7 +439,7 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
>  		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
>  				   IMX6SX_GPR12_PCIE_TEST_POWERDOWN, 0);
>  		break;
> -	case IMX6QP:		/* FALLTHROUGH */
> +	case IMX6QP:
>  	case IMX6Q:
>  		/* power up core phy and enable ref clock */
>  		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
> @@ -642,7 +642,7 @@ static void imx6_pcie_init_phy(struct imx6_pcie *imx6_pcie)
>  		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
>  				   IMX6SX_GPR12_PCIE_RX_EQ_MASK,
>  				   IMX6SX_GPR12_PCIE_RX_EQ_2);
> -		/* FALLTHROUGH */
> +		fallthrough;
>  	default:
>  		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
>  				   IMX6Q_GPR12_PCIE_CTL_2, 0 << 10);
> @@ -1107,7 +1107,7 @@ static int imx6_pcie_probe(struct platform_device *pdev)
>  			dev_err(dev, "pcie_aux clock source missing or invalid\n");
>  			return PTR_ERR(imx6_pcie->pcie_aux);
>  		}
> -		/* fall through */
> +		fallthrough;
>  	case IMX7D:
>  		if (dbi_base->start == IMX8MQ_PCIE2_BASE_ADDR)
>  			imx6_pcie->controller_id = 1;
> -- 
> 2.27.0
> 
