Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25C2F25FF64
	for <lists+linux-pci@lfdr.de>; Mon,  7 Sep 2020 18:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729884AbgIGQbT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Sep 2020 12:31:19 -0400
Received: from foss.arm.com ([217.140.110.172]:37068 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729831AbgIGOYS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 7 Sep 2020 10:24:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B64751045;
        Mon,  7 Sep 2020 07:24:17 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F00903F73C;
        Mon,  7 Sep 2020 07:24:15 -0700 (PDT)
Date:   Mon, 7 Sep 2020 15:24:13 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH v2][next] PCI: imx6: Use fallthrough pseudo-keyword
Message-ID: <20200907142413.GB9474@e121166-lin.cambridge.arm.com>
References: <20200722031903.GA3711@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200722031903.GA3711@embeddedor>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 21, 2020 at 10:19:03PM -0500, Gustavo A. R. Silva wrote:
> Replace the existing /* fall through */ comments and its variants with
> the new pseudo-keyword macro fallthrough[1]. Also, remove unnecessary
> fall-through markings when it is the case.
> 
> [1] https://www.kernel.org/doc/html/v5.7/process/deprecated.html?highlight=fallthrough#implicit-switch-case-fall-through
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
> Changes in v2:
>  - Update URL. Use proper URL to Linux v5.7 documentation.
> 
>  drivers/pci/controller/dwc/pci-imx6.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Applied to pci/imx6, thanks.

Lorenzo

> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 8f08ae53f53e..6c78903b49be 100644
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
