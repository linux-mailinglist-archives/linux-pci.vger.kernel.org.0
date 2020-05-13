Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D68001D1185
	for <lists+linux-pci@lfdr.de>; Wed, 13 May 2020 13:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730945AbgEMLhy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 May 2020 07:37:54 -0400
Received: from ns.mm-sol.com ([37.157.136.199]:32816 "EHLO extserv.mm-sol.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726743AbgEMLhy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 13 May 2020 07:37:54 -0400
Received: from [192.168.1.2] (212-5-158-106.ip.btc-net.bg [212.5.158.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by extserv.mm-sol.com (Postfix) with ESMTPSA id 19027CF91;
        Wed, 13 May 2020 14:37:50 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mm-sol.com; s=201706;
        t=1589369870; bh=vfFd3tN8fY41qxqKZE3PIorbD8ml40L+TC5l6z6T08A=;
        h=Subject:To:Cc:From:Date:From;
        b=X+Pnoou2SLbu2sfzGWfpORVx0ejVJcRL1Ccdkk79uMY5aj/8dH0+xpNxZwWHre9F9
         GvJEOwmVeD+TdA47tdvGLLbRGXmJb22sP8QqJzZnw/285r6mOUkOfAt7AOndp5rIVZ
         t9z3RnKA5ivk1zCTrdaImt/d3X0EE8p/PDkI5NJevcj6zxGOuZi79rn2l72YtFRxMK
         SB3t0avid9xpTMUvzCiROGDUvZ+Vq8iTgmKlNsom7hT3ZIg2CdfbItn9nZCNVS8E/o
         JI8NiyIoXxg9HSG8dicAALSACDSx+hKGbkUaA0LzzlMhvjQHZ3o19+WMtCoLQVjxIG
         l7qXpZJvEYf5w==
Subject: Re: [PATCH v3 09/11] PCI: qcom: add ipq8064 rev2 variant and set tx
 term offset
To:     Ansuel Smith <ansuelsmth@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Sham Muthayyan <smuthayy@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200430220619.3169-1-ansuelsmth@gmail.com>
 <20200430220619.3169-10-ansuelsmth@gmail.com>
From:   Stanimir Varbanov <svarbanov@mm-sol.com>
Message-ID: <3dc89ec6-d550-9402-1a4a-ca0c6f1e1fb9@mm-sol.com>
Date:   Wed, 13 May 2020 14:37:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200430220619.3169-10-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Ansuel,

On 5/1/20 1:06 AM, Ansuel Smith wrote:
> From: Sham Muthayyan <smuthayy@codeaurora.org>
> 
> Add tx term offset support to pcie qcom driver need in some revision of
> the ipq806x SoC.
> Ipq8064 have tx term offset set to 7.
> Ipq8064-v2 revision and ipq8065 have the tx term offset set to 0.
> 
> Signed-off-by: Sham Muthayyan <smuthayy@codeaurora.org>
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index da8058fd1925..372d2c8508b5 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -45,6 +45,9 @@
>  #define PCIE_CAP_CPL_TIMEOUT_DISABLE		0x10
>  
>  #define PCIE20_PARF_PHY_CTRL			0x40
> +#define PHY_CTRL_PHY_TX0_TERM_OFFSET_MASK	GENMASK(12, 16)

The mask definition is not correct. Should be GENMASK(20, 16)

> +#define PHY_CTRL_PHY_TX0_TERM_OFFSET(x)		((x) << 16)
> +
>  #define PCIE20_PARF_PHY_REFCLK			0x4C
>  #define PHY_REFCLK_SSP_EN			BIT(16)
>  #define PHY_REFCLK_USE_PAD			BIT(12)
> @@ -118,6 +121,7 @@ struct qcom_pcie_resources_2_1_0 {
>  	u32 tx_swing_full;
>  	u32 tx_swing_low;
>  	u32 rx0_eq;
> +	u8 phy_tx0_term_offset;
>  };
>  
>  struct qcom_pcie_resources_1_0_0 {
> @@ -318,6 +322,11 @@ static int qcom_pcie_get_resources_2_1_0(struct qcom_pcie *pcie)
>  	if (IS_ERR(res->ext_reset))
>  		return PTR_ERR(res->ext_reset);
>  
> +	if (of_device_is_compatible(dev->of_node, "qcom,pcie-ipq8064"))
> +		res->phy_tx0_term_offset = 7;

Before your change the phy_tx0_term_offser was 0 for apq8064, but here
you change it to 7, why?

> +	else
> +		res->phy_tx0_term_offset = 0;
> +
>  	res->phy_reset = devm_reset_control_get_exclusive(dev, "phy");
>  	return PTR_ERR_OR_ZERO(res->phy_reset);
>  }
> @@ -402,6 +411,11 @@ static int qcom_pcie_init_2_1_0(struct qcom_pcie *pcie)
>  	/* enable PCIe clocks and resets */
>  	qcom_clear_and_set_dword(pcie->parf + PCIE20_PARF_PHY_CTRL, BIT(0), 0);
>  
> +	/* set TX termination offset */
> +	qcom_clear_and_set_dword(pcie->parf + PCIE20_PARF_PHY_CTRL,
> +			PHY_CTRL_PHY_TX0_TERM_OFFSET_MASK,

As the mask definition is incorrect you actually clear 12 to 16 bit in
the register where is another PHY parameter. Is that was intentional?

> +			PHY_CTRL_PHY_TX0_TERM_OFFSET(res->phy_tx0_term_offset));
> +
>  	writel(PCS_DEEMPH_TX_DEEMPH_GEN1(res->tx_deemph_gen1) |
>  	       PCS_DEEMPH_TX_DEEMPH_GEN2_3_5DB(res->tx_deemph_gen2_3p5db) |
>  	       PCS_DEEMPH_TX_DEEMPH_GEN2_6DB(res->tx_deemph_gen2_6db),
> @@ -1485,6 +1499,7 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>  static const struct of_device_id qcom_pcie_match[] = {
>  	{ .compatible = "qcom,pcie-apq8084", .data = &ops_1_0_0 },
>  	{ .compatible = "qcom,pcie-ipq8064", .data = &ops_2_1_0 },
> +	{ .compatible = "qcom,pcie-ipq8064-v2", .data = &ops_2_1_0 },
>  	{ .compatible = "qcom,pcie-apq8064", .data = &ops_2_1_0 },
>  	{ .compatible = "qcom,pcie-msm8996", .data = &ops_2_3_2 },
>  	{ .compatible = "qcom,pcie-ipq8074", .data = &ops_2_3_3 },
> 

-- 
regards,
Stan
