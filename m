Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 676261EB6D5
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jun 2020 09:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726122AbgFBHx5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Jun 2020 03:53:57 -0400
Received: from ns.mm-sol.com ([37.157.136.199]:44999 "EHLO extserv.mm-sol.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725835AbgFBHx5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 2 Jun 2020 03:53:57 -0400
Received: from [192.168.1.3] (212-5-158-42.ip.btc-net.bg [212.5.158.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by extserv.mm-sol.com (Postfix) with ESMTPSA id 4D338CFE8;
        Tue,  2 Jun 2020 10:53:51 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mm-sol.com; s=201706;
        t=1591084432; bh=RH0hhqTq1DD2tdDYcXx1G756vuN0qC8RxBtuft0KnwY=;
        h=Subject:To:Cc:From:Date:From;
        b=e1DbqIRiUaDDhPkmnCuyziP0s5Wi6zNh6pwLPN+M+trFXXaRWUaOOG5S2zr2IAgN+
         +dk3X/8j8pZsc07I9/6Nrimd2623dIppZETZhKwUM8IiZAguIQ0KL0OOXAR1Uz3f3C
         cOR6D8ccti6hPOG65EaFECDHW4OZg9mo72BkYPEI+FQqCs5hChJT6NBk4LnsVmmwRk
         Cjws5XqrnXUscHwlV+0PkCHv7IhTUfkF4sqyuTDh1UvQpZ3T3VTVpS/USCMGDZ7HIs
         ukf0UdmXDyuRAynd4H6yG0cpCdcw19hZq7aOpqULeleN+/MnGHBuMbpaX6G+yV6DVP
         nY3AocR6ZoSaA==
Subject: Re: [PATCH v4 08/10] PCI: qcom: Add ipq8064 rev2 variant and set tx
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
References: <20200514200712.12232-1-ansuelsmth@gmail.com>
 <20200514200712.12232-9-ansuelsmth@gmail.com>
From:   Stanimir Varbanov <svarbanov@mm-sol.com>
Message-ID: <e672c516-29a4-e7d2-ee8b-3bce73bdf4e2@mm-sol.com>
Date:   Tue, 2 Jun 2020 10:53:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200514200712.12232-9-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 5/14/20 11:07 PM, Ansuel Smith wrote:
> Add tx term offset support to pcie qcom driver need in some revision of
> the ipq806x SoC. Ipq8064 have tx term offset set to 7. Ipq8064-v2 revision
> and ipq8065 have the tx term offset set to 0.
> 
> Signed-off-by: Sham Muthayyan <smuthayy@codeaurora.org>
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index f5398b0d270c..ab6f1bdd24c3 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -45,6 +45,9 @@
>  #define PCIE_CAP_CPL_TIMEOUT_DISABLE		0x10
>  
>  #define PCIE20_PARF_PHY_CTRL			0x40
> +#define PHY_CTRL_PHY_TX0_TERM_OFFSET_MASK	GENMASK(20, 16)

I see you changed the mask, did you found the issue in previous v3 mask
and shift?

> +#define PHY_CTRL_PHY_TX0_TERM_OFFSET(x)		((x) << 16)
> +
>  #define PCIE20_PARF_PHY_REFCLK			0x4C
>  #define PHY_REFCLK_SSP_EN			BIT(16)
>  #define PHY_REFCLK_USE_PAD			BIT(12)
> @@ -363,7 +366,8 @@ static int qcom_pcie_init_2_1_0(struct qcom_pcie *pcie)
>  	val &= ~BIT(0);
>  	writel(val, pcie->parf + PCIE20_PARF_PHY_CTRL);
>  
> -	if (of_device_is_compatible(node, "qcom,pcie-ipq8064")) {
> +	if (of_device_is_compatible(node, "qcom,pcie-ipq8064") |

this should be logical OR

> +	    of_device_is_compatible(node, "qcom,pcie-ipq8064-v2")) {
>  		writel(PCS_DEEMPH_TX_DEEMPH_GEN1(24) |
>  			       PCS_DEEMPH_TX_DEEMPH_GEN2_3_5DB(24) |
>  			       PCS_DEEMPH_TX_DEEMPH_GEN2_6DB(34),
> @@ -374,9 +378,18 @@ static int qcom_pcie_init_2_1_0(struct qcom_pcie *pcie)
>  		writel(PHY_RX0_EQ(4), pcie->parf + PCIE20_PARF_CONFIG_BITS);
>  	}
>  
> +	if (of_device_is_compatible(node, "qcom,pcie-ipq8064")) {
> +		/* set TX termination offset */
> +		val = readl(pcie->parf + PCIE20_PARF_PHY_CTRL);
> +		val &= ~PHY_CTRL_PHY_TX0_TERM_OFFSET_MASK;
> +		val |= PHY_CTRL_PHY_TX0_TERM_OFFSET(7);
> +		writel(val, pcie->parf + PCIE20_PARF_PHY_CTRL);
> +	}
> +
>  	/* enable external reference clock */
>  	val = readl(pcie->parf + PCIE20_PARF_PHY_REFCLK);
> -	val |= BIT(16);
> +	val &= ~PHY_REFCLK_USE_PAD;
> +	val |= PHY_REFCLK_SSP_EN;
>  	writel(val, pcie->parf + PCIE20_PARF_PHY_REFCLK);
>  
>  	/* wait for clock acquisition */
> @@ -1452,6 +1465,7 @@ static int qcom_pcie_probe(struct platform_device *pdev)
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
