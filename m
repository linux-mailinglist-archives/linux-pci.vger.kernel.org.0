Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65E7C1A1D9A
	for <lists+linux-pci@lfdr.de>; Wed,  8 Apr 2020 10:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbgDHIvG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Apr 2020 04:51:06 -0400
Received: from ns.mm-sol.com ([37.157.136.199]:45651 "EHLO extserv.mm-sol.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725932AbgDHIvG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 8 Apr 2020 04:51:06 -0400
Received: from [192.168.1.4] (212-5-158-69.ip.btc-net.bg [212.5.158.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by extserv.mm-sol.com (Postfix) with ESMTPSA id 078BDCFB8;
        Wed,  8 Apr 2020 11:50:52 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mm-sol.com; s=201706;
        t=1586335864; bh=VsRNvYY2aCX7GlVZfB9vp15tXVfvLLyJwZKlanf72FU=;
        h=From:Subject:To:Cc:Date:From;
        b=SEEreytGGNLKm2VerkE5dEZMxsabpBhgvByd/Qlztg+oqXN5uEUSsO78WMPYr0rNn
         M4F/ut9YDHtc4aQymGDE92zJaBTuS9J3McV5e5mWsbzu0xT3MP1bldDPf+ikxcdcEE
         sCB07IehTgoc8ka43ugHz1vn6TkKZEKVa5bTsmvmTypPxup+g+sVAzM3yy6oCpEVGv
         JM8XOqcpztU1GD2kzv2j/FFlh7R1NRPjuII+nXdNPX4pDk3w0QXK3Z0ecjKzPz2Qrq
         LOmBFAqcYCCCspuVpdUZ7quE9A/IIua483RwbU7inFJVu9PuOVxC/j4UaEbN1GLvry
         d7WW4Pqueda2g==
From:   Stanimir Varbanov <svarbanov@mm-sol.com>
Subject: Re: [PATCH v2 07/10] PCIe: qcom: fix init problem with missing PARF
 programming
To:     Ansuel Smith <ansuelsmth@gmail.com>, Andy Gross <agross@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200402121148.1767-1-ansuelsmth@gmail.com>
 <20200402121148.1767-8-ansuelsmth@gmail.com>
Message-ID: <fea9cfd1-2bc7-0141-444e-9c781877ad02@mm-sol.com>
Date:   Wed, 8 Apr 2020 11:50:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200402121148.1767-8-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Ansuel,

Please fix the patch subject for all patches in the series per Bjorn H.
request.

PCI: qcom: Fix init problem with missing PARF programming

Also the patch subject is misleading to me. Actually you change few phy
parameters: Tx De-Emphasis, Tx Swing and Rx equalization. On the other
side I guess those parameters are board specific and I'm not sure how
this change will reflect on apq8064 boards.

On 4/2/20 3:11 PM, Ansuel Smith wrote:
> PARF programming was missing and this cause initilizzation problem on
> some ipq806x based device (Netgear R7800 for example). This cause a
> total lock of the system on kernel load.
> 
> Fixes: 82a82383 PCI: qcom: Add Qualcomm PCIe controller driver
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 48 +++++++++++++++++++++-----
>  1 file changed, 39 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 211a1aa7d0f1..77b1ab7e23a3 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -46,6 +46,9 @@
>  
>  #define PCIE20_PARF_PHY_CTRL			0x40
>  #define PCIE20_PARF_PHY_REFCLK			0x4C
> +#define REF_SSP_EN				BIT(16)
> +#define REF_USE_PAD				BIT(12)

Could you rename this to:

PHY_REFCLK_SSP_EN
PHY_REFCLK_USE_PAD

> +
>  #define PCIE20_PARF_DBI_BASE_ADDR		0x168
>  #define PCIE20_PARF_SLV_ADDR_SPACE_SIZE		0x16C
>  #define PCIE20_PARF_MHI_CLOCK_RESET_CTRL	0x174
> @@ -77,6 +80,18 @@
>  #define DBI_RO_WR_EN				1
>  
>  #define PERST_DELAY_US				1000
> +/* PARF registers */
> +#define PCIE20_PARF_PCS_DEEMPH			0x34
> +#define PCS_DEEMPH_TX_DEEMPH_GEN1(x)		(x << 16)
> +#define PCS_DEEMPH_TX_DEEMPH_GEN2_3_5DB(x)	(x << 8)
> +#define PCS_DEEMPH_TX_DEEMPH_GEN2_6DB(x)	(x << 0)
> +
> +#define PCIE20_PARF_PCS_SWING			0x38
> +#define PCS_SWING_TX_SWING_FULL(x)		(x << 8)
> +#define PCS_SWING_TX_SWING_LOW(x)		(x << 0)
> +
> +#define PCIE20_PARF_CONFIG_BITS		0x50
> +#define PHY_RX0_EQ(x)				(x << 24)
>  
>  #define PCIE20_v3_PARF_SLV_ADDR_SPACE_SIZE	0x358
>  #define SLV_ADDR_SPACE_SZ			0x10000000
> @@ -184,6 +199,16 @@ struct qcom_pcie {
>  
>  #define to_qcom_pcie(x)		dev_get_drvdata((x)->dev)
>  
> +static inline void qcom_clear_and_set_dword(void __iomem *addr,

drop 'inline' the compiler is smart enough to decide.

> +				 u32 clear_mask, u32 set_mask)
> +{
> +	u32 val = readl(addr);
> +
> +	val &= ~clear_mask;
> +	val |= set_mask;
> +	writel(val, addr);
> +}
> +

If you add such function you should introduce it in a separate patch and
use it in the whole driver where it is applicable. After that we can see
what is the benefit of it.

>  static void qcom_ep_reset_assert(struct qcom_pcie *pcie)
>  {
>  	gpiod_set_value_cansleep(pcie->reset, 1);
> @@ -304,7 +329,6 @@ static int qcom_pcie_init_2_1_0(struct qcom_pcie *pcie)
>  	struct qcom_pcie_resources_2_1_0 *res = &pcie->res.v2_1_0;
>  	struct dw_pcie *pci = pcie->pci;
>  	struct device *dev = pci->dev;
> -	u32 val;
>  	int ret;
>  
>  	ret = regulator_bulk_enable(ARRAY_SIZE(res->supplies), res->supplies);
> @@ -355,15 +379,21 @@ static int qcom_pcie_init_2_1_0(struct qcom_pcie *pcie)
>  		goto err_deassert_ahb;
>  	}
>  
> -	/* enable PCIe clocks and resets */
> -	val = readl(pcie->parf + PCIE20_PARF_PHY_CTRL);
> -	val &= ~BIT(0);
> -	writel(val, pcie->parf + PCIE20_PARF_PHY_CTRL);
> +	qcom_clear_and_set_dword(pcie->parf + PCIE20_PARF_PHY_CTRL, BIT(0), 0);

please keep the comment.

> +
> +	/* PARF programming */

pointless comment, please drop it.

> +	writel(PCS_DEEMPH_TX_DEEMPH_GEN1(0x18) |
> +	       PCS_DEEMPH_TX_DEEMPH_GEN2_3_5DB(0x18) |
> +	       PCS_DEEMPH_TX_DEEMPH_GEN2_6DB(0x22),
> +	       pcie->parf + PCIE20_PARF_PCS_DEEMPH);
> +	writel(PCS_SWING_TX_SWING_FULL(0x78) |
> +	       PCS_SWING_TX_SWING_LOW(0x78),
> +	       pcie->parf + PCIE20_PARF_PCS_SWING);
> +	writel(PHY_RX0_EQ(0x4), pcie->parf + PCIE20_PARF_CONFIG_BITS);
>  
> -	/* enable external reference clock */
> -	val = readl(pcie->parf + PCIE20_PARF_PHY_REFCLK);
> -	val |= BIT(16);
> -	writel(val, pcie->parf + PCIE20_PARF_PHY_REFCLK);
> +	/* enable reference clock */

Why you dropped 'external' ?

> +	qcom_clear_and_set_dword(pcie->parf + PCIE20_PARF_PHY_REFCLK,
> +		      REF_USE_PAD, REF_SSP_EN);
>  
>  	ret = reset_control_deassert(res->phy_reset);
>  	if (ret) {
> 

-- 
regards,
Stan
