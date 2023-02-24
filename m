Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 249D86A17F7
	for <lists+linux-pci@lfdr.de>; Fri, 24 Feb 2023 09:29:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjBXI33 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Feb 2023 03:29:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjBXI31 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Feb 2023 03:29:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37D605AB76;
        Fri, 24 Feb 2023 00:29:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F9C66185C;
        Fri, 24 Feb 2023 08:29:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8A25C433EF;
        Fri, 24 Feb 2023 08:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677227362;
        bh=q8kTU+LfofL0VHWZwEZg9bxoWDAM8VoYajRpLoyyFAE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R7BXd7H9QkK2fASkmAEjg6BTSCiLVI3c/ARkcvfuNla6hNl8oD0zM8UdhJ/3/jDJM
         Y9UhZ76trIiRAHoyzF1ZxSmC0mX78NaVyb4vi6i8zTcVd1G/3vKWkkJcuARI66PKrw
         mm2R3cP+lngucrWO7cbK6Fk49BggGbyu5bZ1RywkReMTaPAK88wkYiXWuus2YA6Ry1
         bNFn3sXgyHr678ySzhYV2SO9cX32iC5z9dH/V/yTG+5M7HOqldLdSknjCOeMahUh6/
         GpbSjac982CnaA2cC6t+YSgYJ0b/7tgo2kmIKgK0C5b9Zz3384hDz2Y0RNVv9AuT8y
         sfN3xf4Ql7zEg==
Date:   Fri, 24 Feb 2023 13:59:04 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Devi Priya <quic_devipriy@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, krzysztof.kozlowski+dt@linaro.org,
        vkoul@kernel.org, kishon@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, p.zabel@pengutronix.de, svarbanov@mm-sol.com,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-clk@vger.kernel.org,
        quic_srichara@quicinc.com, quic_gokulsri@quicinc.com,
        quic_sjaganat@quicinc.com, quic_kathirav@quicinc.com,
        quic_arajkuma@quicinc.com, quic_anusha@quicinc.com
Subject: Re: [PATCH 2/7] PCI: qcom: Add IPQ9574 PCIe support
Message-ID: <20230224082904.GB5443@thinkpad>
References: <20230214164135.17039-1-quic_devipriy@quicinc.com>
 <20230214164135.17039-3-quic_devipriy@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230214164135.17039-3-quic_devipriy@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 14, 2023 at 10:11:30PM +0530, Devi Priya wrote:
> Adding PCIe support for IPQ9574 SoC
> 

Please add some information about the PCIe IP in the commit message.
Like, the Synopsys IP version, Gen speed etc... and how the support
is added (using existing config or a new one).

As others have mentioned, you could reuse the existing config. In that
case, add the info in commit message as I suggested above.

And the PCI patch should come last in the series after bindings and dts
patches.

Thanks,
Mani

> Co-developed-by: Anusha Rao <quic_anusha@quicinc.com>
> Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 119 +++++++++++++++++++++++++
>  1 file changed, 119 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index a232b04af048..57606c113d45 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -193,6 +193,12 @@ struct qcom_pcie_resources_2_9_0 {
>  	struct reset_control *rst;
>  };
>  
> +struct qcom_pcie_resources_1_27_0 {
> +	struct clk_bulk_data *clks;
> +	struct reset_control *rst;
> +	int num_clks;
> +};
> +
>  union qcom_pcie_resources {
>  	struct qcom_pcie_resources_1_0_0 v1_0_0;
>  	struct qcom_pcie_resources_2_1_0 v2_1_0;
> @@ -201,6 +207,7 @@ union qcom_pcie_resources {
>  	struct qcom_pcie_resources_2_4_0 v2_4_0;
>  	struct qcom_pcie_resources_2_7_0 v2_7_0;
>  	struct qcom_pcie_resources_2_9_0 v2_9_0;
> +	struct qcom_pcie_resources_1_27_0 v1_27_0;
>  };
>  
>  struct qcom_pcie;
> @@ -1409,6 +1416,104 @@ static int qcom_pcie_post_init_2_9_0(struct qcom_pcie *pcie)
>  	return 0;
>  }
>  
> +static int qcom_pcie_get_resources_1_27_0(struct qcom_pcie *pcie)
> +{
> +	struct qcom_pcie_resources_1_27_0 *res = &pcie->res.v1_27_0;
> +	struct dw_pcie *pci = pcie->pci;
> +	struct device *dev = pci->dev;
> +
> +	res->num_clks = devm_clk_bulk_get_all(dev, &res->clks);
> +	if (res->clks < 0)
> +		return res->num_clks;
> +
> +	res->rst = devm_reset_control_array_get_exclusive(dev);
> +	if (IS_ERR(res->rst))
> +		return PTR_ERR(res->rst);
> +
> +	return 0;
> +}
> +
> +static void qcom_pcie_deinit_1_27_0(struct qcom_pcie *pcie)
> +{
> +	struct qcom_pcie_resources_1_27_0 *res = &pcie->res.v1_27_0;
> +
> +	clk_bulk_disable_unprepare(res->num_clks, res->clks);
> +}
> +
> +static int qcom_pcie_init_1_27_0(struct qcom_pcie *pcie)
> +{
> +	struct qcom_pcie_resources_1_27_0 *res = &pcie->res.v1_27_0;
> +	struct device *dev = pcie->pci->dev;
> +	int ret;
> +
> +	ret = reset_control_assert(res->rst);
> +	if (ret) {
> +		dev_err(dev, "reset assert failed (%d)\n", ret);
> +		return ret;
> +	}
> +
> +	/*
> +	 * Delay periods before and after reset deassert are working values
> +	 * from downstream Codeaurora kernel
> +	 */
> +	usleep_range(2000, 2500);
> +
> +	ret = reset_control_deassert(res->rst);
> +	if (ret) {
> +		dev_err(dev, "reset deassert failed (%d)\n", ret);
> +		return ret;
> +	}
> +
> +	usleep_range(2000, 2500);
> +
> +	return clk_bulk_prepare_enable(res->num_clks, res->clks);
> +}
> +
> +static int qcom_pcie_post_init_1_27_0(struct qcom_pcie *pcie)
> +{
> +	struct dw_pcie *pci = pcie->pci;
> +	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> +	u32 val;
> +	int i;
> +
> +	writel(0x8000000, pcie->parf + PCIE20_v3_PARF_SLV_ADDR_SPACE_SIZE);
> +
> +	val = readl(pcie->parf + PCIE20_PARF_PHY_CTRL);
> +	val &= ~BIT(0);
> +	writel(val, pcie->parf + PCIE20_PARF_PHY_CTRL);
> +
> +	writel(0, pcie->parf + PCIE20_PARF_DBI_BASE_ADDR);
> +
> +	writel(DEVICE_TYPE_RC, pcie->parf + PCIE20_PARF_DEVICE_TYPE);
> +	writel(BYPASS | MSTR_AXI_CLK_EN | AHB_CLK_EN,
> +	       pcie->parf + PCIE20_PARF_MHI_CLOCK_RESET_CTRL);
> +	writel(GEN3_RELATED_OFF_RXEQ_RGRDLESS_RXTS |
> +	       GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL,
> +	       pci->dbi_base + GEN3_RELATED_OFF);
> +
> +	writel(MST_WAKEUP_EN | SLV_WAKEUP_EN | MSTR_ACLK_CGC_DIS |
> +	       SLV_ACLK_CGC_DIS | CORE_CLK_CGC_DIS |
> +	       AUX_PWR_DET | L23_CLK_RMV_DIS | L1_CLK_RMV_DIS,
> +	       pcie->parf + PCIE20_PARF_SYS_CTRL);
> +
> +	writel(0, pcie->parf + PCIE20_PARF_Q2A_FLUSH);
> +
> +	dw_pcie_dbi_ro_wr_en(pci);
> +	writel(PCIE_CAP_SLOT_VAL, pci->dbi_base + offset + PCI_EXP_SLTCAP);
> +
> +	val = readl(pci->dbi_base + offset + PCI_EXP_LNKCAP);
> +	val &= ~PCI_EXP_LNKCAP_ASPMS;
> +	writel(val, pci->dbi_base + offset + PCI_EXP_LNKCAP);
> +
> +	writel(PCI_EXP_DEVCTL2_COMP_TMOUT_DIS, pci->dbi_base + offset +
> +	       PCI_EXP_DEVCTL2);
> +
> +	for (i = 0; i < 256; i++)
> +		writel(0, pcie->parf + PCIE20_PARF_BDF_TO_SID_TABLE_N + (4 * i));
> +
> +	return 0;
> +}
> +
>  static int qcom_pcie_link_up(struct dw_pcie *pci)
>  {
>  	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> @@ -1620,6 +1725,15 @@ static const struct qcom_pcie_ops ops_2_9_0 = {
>  	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
>  };
>  
> +/* Qcom IP rev.: 1.27.0 Synopsys IP rev.: 5.80a */
> +static const struct qcom_pcie_ops ops_1_27_0 = {
> +	.get_resources = qcom_pcie_get_resources_1_27_0,
> +	.init = qcom_pcie_init_1_27_0,
> +	.post_init = qcom_pcie_post_init_1_27_0,
> +	.deinit = qcom_pcie_deinit_1_27_0,
> +	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
> +};
> +
>  static const struct qcom_pcie_cfg cfg_1_0_0 = {
>  	.ops = &ops_1_0_0,
>  };
> @@ -1652,6 +1766,10 @@ static const struct qcom_pcie_cfg cfg_2_9_0 = {
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
> @@ -1829,6 +1947,7 @@ static const struct of_device_id qcom_pcie_match[] = {
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
