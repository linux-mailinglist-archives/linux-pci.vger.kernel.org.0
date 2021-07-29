Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A49B3DAEDC
	for <lists+linux-pci@lfdr.de>; Fri, 30 Jul 2021 00:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232725AbhG2W32 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Jul 2021 18:29:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:54314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229944AbhG2W3X (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 29 Jul 2021 18:29:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1982360720;
        Thu, 29 Jul 2021 22:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627597759;
        bh=Z5vs1zoSqEBxxqhhSmMqcsfe2C7l5EM32gjPdmoyxEM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ow5YnxaXbEOrfH4JYT2y1RMAesCkN/7tbE/AmLKSds8GczI0Z2cjX8NvoAD0tI9zl
         5It9feOWMTsxvab3SeVe0xCOyamkWOKwr8fDgv21ShbrHrv/Z8LoEP03gHi2ZdyeSS
         iiUkZSHEMh/r+ZgR24Bd3OxC4SCNsIH8PfONyr8yPoUM9s6AOm28pumoOJDUkLuBAp
         8gxh3ZxZ6e8poQNmcPJLRm5B1L6YAuKA821nTVolYIdrBTwNGo8hCT/p6lz4KuN/3i
         iaFnBo60imEzrzTWVnOj2hkdx/3lV87l+H+Czbg6cuwMyDWojb9mCrlyYJ4FZIgh8Z
         P/U6AJk1KXKag==
Date:   Thu, 29 Jul 2021 17:29:17 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH 3/6] PCI: imx6: add IMX8MM support
Message-ID: <20210729222917.GA998237@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210723204958.7186-4-tharvey@gateworks.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Capitalize first letter of subject to match history:

  PCI: imx6: Add IMX8MM support

On Fri, Jul 23, 2021 at 01:49:55PM -0700, Tim Harvey wrote:
> Add IMX8MM support to the existing driver which shares most
> functionality with the IMX8MM.
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 103 +++++++++++++++++++++++++-
>  1 file changed, 102 insertions(+), 1 deletion(-)

> +	case IMX8MM:
> +		offset = imx6_pcie_grp_offset(imx6_pcie);
> +
> +		dev_info(imx6_pcie->pci->dev, "%s REF_CLK is used!.\n",
> +				imx6_pcie->ext_osc ? "EXT" : "PLL");
> +		if (imx6_pcie->ext_osc) {
> +			regmap_update_bits(imx6_pcie->iomuxc_gpr, offset,
> +					IMX8MQ_GPR_PCIE_REF_USE_PAD, 0);
> +			regmap_update_bits(imx6_pcie->iomuxc_gpr, offset,
> +					IMX8MM_GPR_PCIE_REF_CLK_SEL,
> +					IMX8MM_GPR_PCIE_REF_CLK_SEL);
> +			regmap_update_bits(imx6_pcie->iomuxc_gpr, offset,
> +					IMX8MM_GPR_PCIE_AUX_EN,
> +					IMX8MM_GPR_PCIE_AUX_EN);
> +			regmap_update_bits(imx6_pcie->iomuxc_gpr, offset,
> +					IMX8MM_GPR_PCIE_POWER_OFF, 0);
> +			regmap_update_bits(imx6_pcie->iomuxc_gpr, offset,
> +					IMX8MM_GPR_PCIE_SSC_EN, 0);
> +			regmap_update_bits(imx6_pcie->iomuxc_gpr, offset,
> +					IMX8MM_GPR_PCIE_REF_CLK_SEL,
> +					IMX8MM_GPR_PCIE_REF_CLK_EXT);
> +			udelay(100);
> +			/* Do the PHY common block reset */
> +			regmap_update_bits(imx6_pcie->iomuxc_gpr, offset,
> +					IMX8MM_GPR_PCIE_CMN_RST,
> +					IMX8MM_GPR_PCIE_CMN_RST);
> +			udelay(200);
> +		} else {
> +			/* Configure the internal PLL as REF clock */
> +			regmap_update_bits(imx6_pcie->iomuxc_gpr, offset,
> +					IMX8MQ_GPR_PCIE_REF_USE_PAD, 0);
> +			regmap_update_bits(imx6_pcie->iomuxc_gpr, offset,
> +					IMX8MM_GPR_PCIE_REF_CLK_SEL,
> +					IMX8MM_GPR_PCIE_REF_CLK_SEL);
> +			regmap_update_bits(imx6_pcie->iomuxc_gpr, offset,
> +					IMX8MM_GPR_PCIE_AUX_EN,
> +					IMX8MM_GPR_PCIE_AUX_EN);
> +			regmap_update_bits(imx6_pcie->iomuxc_gpr, offset,
> +					IMX8MM_GPR_PCIE_POWER_OFF, 0);
> +			regmap_update_bits(imx6_pcie->iomuxc_gpr, offset,
> +					IMX8MM_GPR_PCIE_SSC_EN, 0);

Seems like all the above is common to both cases?  If so, it's a shame
to repeat it because it makes it hard to see what's different.

> +			regmap_update_bits(imx6_pcie->iomuxc_gpr, offset,
> +					IMX8MM_GPR_PCIE_REF_CLK_SEL,
> +					IMX8MM_GPR_PCIE_REF_CLK_PLL);
> +			udelay(100);
> +			/* Configure the PHY */
> +			writel(PCIE_PHY_CMN_REG62_PLL_CLK_OUT,
> +					imx6_pcie->phy_base + PCIE_PHY_CMN_REG62);
> +			writel(PCIE_PHY_CMN_REG64_AUX_RX_TX_TERM,
> +					imx6_pcie->phy_base + PCIE_PHY_CMN_REG64);
> +			/* Do the PHY common block reset */
> +			regmap_update_bits(imx6_pcie->iomuxc_gpr, offset,
> +					IMX8MM_GPR_PCIE_CMN_RST,
> +					IMX8MM_GPR_PCIE_CMN_RST);
> +			udelay(200);
> +		}
> +		/*

> +		 * In order to pass the compliance tests.
> +		 * Configure the TRSV regiser of iMX8MM PCIe PHY.

The "In order to ..." line isn't quite a sentence.  Maybe it should be
joined with the second line?

s/regiser/register/ ?

> +		 */
> +		writel(PCIE_PHY_TRSV_REG5_GEN1_DEEMP,
> +				imx6_pcie->phy_base + PCIE_PHY_TRSV_REG5);

> +	/* check for EXT osc */

Since you have a comment here, it would be useful to spell out "osc"
for newbies like me.  I assume it's short for "oscillator"?

> +	imx6_pcie->ext_osc = of_property_read_bool(node, "fsl,ext-osc");
