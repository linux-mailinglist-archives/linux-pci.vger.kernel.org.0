Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32BDA6FAFCE
	for <lists+linux-pci@lfdr.de>; Mon,  8 May 2023 14:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234100AbjEHMV1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 May 2023 08:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234076AbjEHMVX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 May 2023 08:21:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 948D131565;
        Mon,  8 May 2023 05:21:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 201D563BFA;
        Mon,  8 May 2023 12:21:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55314C433D2;
        Mon,  8 May 2023 12:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683548481;
        bh=uq5dzUvZQoVw3C52vq/DdsRT8oi8aDqjHTKmyLpSfZo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r0SxYbcZN3jgbBBE4ta+Dzn8/3lyfGNX3BbuOqE8B84X1N1cIKwIzO4SYcQVgH9iH
         MeLYFhhvGzQSFVyn/1hCKtRerG1EFDNPyCKzUcebDRXTMur1z8zpAnRJwl0lw8Mogq
         sOC/3m5d9rmB3H2i+skm0YQ4clsnrWhOe552wdOL8Inj8vCFx/gEG6BEUgmZ2j5ZWd
         XGu5dLYnJ6dLJFJJGn/MyHLMp1rP4A7stireL7O6syT+xGhcl7AfHaaG6P3osBPkxJ
         V4BsPL7ppePFvF4cfTSD8UPiJXKmGbzY65wl/Kjr2m+jRw3p+7RxsUvyOAocS/MX3+
         Dg5171/dpRdFw==
Date:   Mon, 8 May 2023 17:51:09 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Devi Priya <quic_devipriy@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, mani@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-clk@vger.kernel.org, quic_srichara@quicinc.com,
        quic_sjaganat@quicinc.com, quic_kathirav@quicinc.com,
        quic_arajkuma@quicinc.com, quic_anusha@quicinc.com,
        quic_ipkumar@quicinc.com
Subject: Re: [PATCH V3 6/6] PCI: qcom: Add support for IPQ9574
Message-ID: <20230508122109.GC4190@thinkpad>
References: <20230421124938.21974-1-quic_devipriy@quicinc.com>
 <20230421124938.21974-7-quic_devipriy@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230421124938.21974-7-quic_devipriy@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 21, 2023 at 06:19:38PM +0530, Devi Priya wrote:
> The IPQ9574 platform has 4 Gen3 PCIe controllers: two single-lane
> and two dual-lane based on SNPS core 5.70a
> The Qcom IP rev is 1.27.0 and Synopsys IP rev is 5.80a
> Added a new compatible 'qcom,pcie-ipq9574' and 'ops_1_27_0'
> which reuses all the members of 'ops_2_9_0' except for the post_init
> as the SLV_ADDR_SPACE_SIZE configuration differs between 2_9_0
> and 1_27_0.
> Also, modified get_resources of 'ops 2_9_0' to get the clocks
> from the device tree and modelled the post init sequence as
> a common function to avoid code redundancy.
> 
> Co-developed-by: Anusha Rao <quic_anusha@quicinc.com>
> Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>

One comment below. With that fixed,

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

> ---
>  Changes in V3:
> 	- Rebased on top of linux-next/master
> 
>  drivers/pci/controller/dwc/pcie-qcom.c | 61 ++++++++++++++++++--------
>  1 file changed, 43 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 4ab30892f6ef..3682ecdead1f 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -107,6 +107,7 @@
>  
>  /* PARF_SLV_ADDR_SPACE_SIZE register value */
>  #define SLV_ADDR_SPACE_SZ			0x10000000
> +#define SLV_ADDR_SPACE_SZ_1_27_0		0x08000000
>  
>  /* PARF_MHI_CLOCK_RESET_CTRL register fields */
>  #define AHB_CLK_EN				BIT(0)
> @@ -202,10 +203,10 @@ struct qcom_pcie_resources_2_7_0 {
>  	struct reset_control *rst;
>  };
>  
> -#define QCOM_PCIE_2_9_0_MAX_CLOCKS		5
>  struct qcom_pcie_resources_2_9_0 {
> -	struct clk_bulk_data clks[QCOM_PCIE_2_9_0_MAX_CLOCKS];
> +	struct clk_bulk_data *clks;
>  	struct reset_control *rst;
> +	int num_clks;
>  };
>  
>  union qcom_pcie_resources {
> @@ -1050,17 +1051,10 @@ static int qcom_pcie_get_resources_2_9_0(struct qcom_pcie *pcie)
>  	struct qcom_pcie_resources_2_9_0 *res = &pcie->res.v2_9_0;
>  	struct dw_pcie *pci = pcie->pci;
>  	struct device *dev = pci->dev;
> -	int ret;
>  
> -	res->clks[0].id = "iface";
> -	res->clks[1].id = "axi_m";
> -	res->clks[2].id = "axi_s";
> -	res->clks[3].id = "axi_bridge";
> -	res->clks[4].id = "rchng";
> -
> -	ret = devm_clk_bulk_get(dev, ARRAY_SIZE(res->clks), res->clks);
> -	if (ret < 0)
> -		return ret;
> +	res->num_clks = devm_clk_bulk_get_all(dev, &res->clks);
> +	if (res->clks < 0)
> +		return res->num_clks;

Why not return proper error no?

>  
>  	res->rst = devm_reset_control_array_get_exclusive(dev);
>  	if (IS_ERR(res->rst))
> @@ -1073,7 +1067,7 @@ static void qcom_pcie_deinit_2_9_0(struct qcom_pcie *pcie)
>  {
>  	struct qcom_pcie_resources_2_9_0 *res = &pcie->res.v2_9_0;
>  
> -	clk_bulk_disable_unprepare(ARRAY_SIZE(res->clks), res->clks);
> +	clk_bulk_disable_unprepare(res->num_clks, res->clks);
>  }
>  
>  static int qcom_pcie_init_2_9_0(struct qcom_pcie *pcie)
> @@ -1102,19 +1096,16 @@ static int qcom_pcie_init_2_9_0(struct qcom_pcie *pcie)
>  
>  	usleep_range(2000, 2500);
>  
> -	return clk_bulk_prepare_enable(ARRAY_SIZE(res->clks), res->clks);
> +	return clk_bulk_prepare_enable(res->num_clks, res->clks);
>  }
>  
> -static int qcom_pcie_post_init_2_9_0(struct qcom_pcie *pcie)
> +static int qcom_pcie_post_init(struct qcom_pcie *pcie)
>  {
>  	struct dw_pcie *pci = pcie->pci;
>  	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
>  	u32 val;
>  	int i;
>  
> -	writel(SLV_ADDR_SPACE_SZ,
> -		pcie->parf + PARF_SLV_ADDR_SPACE_SIZE);
> -
>  	val = readl(pcie->parf + PARF_PHY_CTRL);
>  	val &= ~PHY_TEST_PWR_DOWN;
>  	writel(val, pcie->parf + PARF_PHY_CTRL);
> @@ -1151,6 +1142,26 @@ static int qcom_pcie_post_init_2_9_0(struct qcom_pcie *pcie)
>  	return 0;
>  }
>  
> +static int qcom_pcie_post_init_1_27_0(struct qcom_pcie *pcie)
> +{
> +	writel(SLV_ADDR_SPACE_SZ_1_27_0,
> +	       pcie->parf + PARF_SLV_ADDR_SPACE_SIZE);
> +
> +	qcom_pcie_post_init(pcie);
> +
> +	return 0;
> +}
> +
> +static int qcom_pcie_post_init_2_9_0(struct qcom_pcie *pcie)
> +{
> +	writel(SLV_ADDR_SPACE_SZ,
> +	       pcie->parf + PARF_SLV_ADDR_SPACE_SIZE);
> +
> +	qcom_pcie_post_init(pcie);
> +
> +	return 0;
> +}
> +
>  static int qcom_pcie_link_up(struct dw_pcie *pci)
>  {
>  	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> @@ -1291,6 +1302,15 @@ static const struct qcom_pcie_ops ops_2_9_0 = {
>  	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
>  };
>  
> +/* Qcom IP rev.: 1.27.0  Synopsys IP rev.: 5.80a */
> +static const struct qcom_pcie_ops ops_1_27_0 = {
> +	.get_resources = qcom_pcie_get_resources_2_9_0,
> +	.init = qcom_pcie_init_2_9_0,
> +	.post_init = qcom_pcie_post_init_1_27_0,
> +	.deinit = qcom_pcie_deinit_2_9_0,
> +	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
> +};
> +
>  static const struct qcom_pcie_cfg cfg_1_0_0 = {
>  	.ops = &ops_1_0_0,
>  };
> @@ -1323,6 +1343,10 @@ static const struct qcom_pcie_cfg cfg_2_9_0 = {
>  	.ops = &ops_2_9_0,
>  };
>  
> +static const struct qcom_pcie_cfg cfg_1_27_0 = {
> +	.ops = &ops_1_27_0,
> +};
> +
>  static const struct dw_pcie_ops dw_pcie_ops = {
>  	.link_up = qcom_pcie_link_up,
>  	.start_link = qcom_pcie_start_link,
> @@ -1607,6 +1631,7 @@ static const struct of_device_id qcom_pcie_match[] = {
>  	{ .compatible = "qcom,pcie-ipq8064-v2", .data = &cfg_2_1_0 },
>  	{ .compatible = "qcom,pcie-ipq8074", .data = &cfg_2_3_3 },
>  	{ .compatible = "qcom,pcie-ipq8074-gen3", .data = &cfg_2_9_0 },
> +	{ .compatible = "qcom,pcie-ipq9574", .data = &cfg_1_27_0 },
>  	{ .compatible = "qcom,pcie-msm8996", .data = &cfg_2_3_2 },
>  	{ .compatible = "qcom,pcie-qcs404", .data = &cfg_2_4_0 },
>  	{ .compatible = "qcom,pcie-sa8540p", .data = &cfg_1_9_0 },
> -- 
> 2.17.1
> 

-- 
மணிவண்ணன் சதாசிவம்
