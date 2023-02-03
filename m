Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3816893D0
	for <lists+linux-pci@lfdr.de>; Fri,  3 Feb 2023 10:33:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232056AbjBCJcy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Feb 2023 04:32:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbjBCJcx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Feb 2023 04:32:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82E965BE;
        Fri,  3 Feb 2023 01:32:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 41EFDB829EC;
        Fri,  3 Feb 2023 09:32:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC471C433D2;
        Fri,  3 Feb 2023 09:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675416768;
        bh=TJ886d+j5g77Br8E6qz5+aZ/bL0aAzGYSSLDQbf/bUk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JpltFJdnZ+f3DAmtLdyb8ZoCDaN+ul0UMQtMP1GLBgOy5B5vXezKGzIsQ/NXapOL+
         E67xcnHNc7p6t8Ff/k2KAs0tOffaf/C9DxQSoefu3+c+eGlYxHBG9iLfej2cYtzwaG
         JWln+5N20m9QN1PPJ5ZcbAIyVXpat4RROGrMUuBOuFpWjHScPq/s36r4T/AgdL+oxh
         m1+uoOKpkWyqauh1jTGIwlXTc7IX2/N5Rg6wZazBnAzTAzU9QybL4MeGybeRCjKE5P
         A0JrPBXI6E8y/1fVBM7dU0OOAmD3UeGzYexLs03MkNR+5jN4SX+7qBMGYqupvIQ7Ad
         7uEPsz/Hjh3iA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pNsRW-0000jq-AE; Fri, 03 Feb 2023 10:33:15 +0100
Date:   Fri, 3 Feb 2023 10:33:14 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v7 08/12] phy: qcom-qmp-pcie: Add support for SM8550 g3x2
 and g4x2 PCIEs
Message-ID: <Y9zU2jBdSD72W28F@hovoldconsulting.com>
References: <20230203081807.2248625-1-abel.vesa@linaro.org>
 <20230203081807.2248625-9-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230203081807.2248625-9-abel.vesa@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Feb 03, 2023 at 10:18:03AM +0200, Abel Vesa wrote:
> Add the SM8550 both g4 and g3 configurations. In addition, there is a
> new "lane shared" table that needs to be configured for g4, along with
> the No-CSR list of resets.

Could you add a comment about the new nocsr reset and how it is used
here?
 
> Co-developed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
> 
> This patchset relies on the following patchset:
> https://lore.kernel.org/all/20230117224148.1914627-1-abel.vesa@linaro.org/
> 
> The v6 of this patch is:
> https://lore.kernel.org/all/20230202123902.3831491-9-abel.vesa@linaro.org/
> 
> Changes since v6:
>  * none
> 
> Changes since v5:
>  * renmaed the no-CSR reset to "phy_nocsr" as discussed off-list with
>    Bjorn and Johan
> 
> Changes since v4:
>  * dropped _serdes infix from ln_shrd table name and from every ln_shrd
>    variable name
>  * added hyphen between "no CSR" in both places
>  * dropped has_ln_shrd_serdes_tbl
>  * reordered qmp_pcie_offsets_v6_20 by struct members
>  * added rollback for no-CSR reset in qmp_pcie_init fail path
>  * moved ln_shrd offset calculation after port_b
> 
> Changes since v3:
>  * added Dmitry's R-b tag
> 
> Changes since v2:
>  * none
> 
> Changes since v1:
>  * split all the offsets into separate patches, like Vinod suggested
> 
> 
>  drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 367 ++++++++++++++++++++++-
>  1 file changed, 365 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> index 907f3f236f05..ff6c0b526fde 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> @@ -1506,6 +1506,234 @@ static const struct qmp_phy_init_tbl sm8450_qmp_gen4x2_pcie_ep_pcs_misc_tbl[] =
>  	QMP_PHY_INIT_CFG(QPHY_V5_20_PCS_PCIE_OSC_DTCT_MODE2_CONFIG5, 0x08),
>  };
>  
> +static const struct qmp_phy_init_tbl sm8550_qmp_gen3x2_pcie_serdes_tbl[] = {
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_SSC_EN_CENTER, 0x01),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_SSC_PER1, 0x62),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_SSC_PER2, 0x02),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_SSC_STEP_SIZE1_MODE0, 0xf8),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_SSC_STEP_SIZE2_MODE0, 0x01),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_SSC_STEP_SIZE1_MODE1, 0x93),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_SSC_STEP_SIZE2_MODE1, 0x01),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CLK_ENABLE1, 0x90),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_SYS_CLK_CTRL, 0x82),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_IVCO, 0x07),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CP_CTRL_MODE0, 0x02),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CP_CTRL_MODE1, 0x02),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_RCTRL_MODE0, 0x16),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_RCTRL_MODE1, 0x16),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_CCTRL_MODE0, 0x36),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_CCTRL_MODE1, 0x36),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_SYSCLK_EN_SEL, 0x08),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_BG_TIMER, 0x0a),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP_EN, 0x42),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP1_MODE0, 0x04),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP2_MODE0, 0x0d),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP1_MODE1, 0x0a),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP2_MODE1, 0x1a),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_DEC_START_MODE0, 0x41),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_DEC_START_MODE1, 0x34),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_DIV_FRAC_START1_MODE0, 0xab),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_DIV_FRAC_START2_MODE0, 0xaa),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_DIV_FRAC_START3_MODE0, 0x01),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_DIV_FRAC_START1_MODE1, 0x55),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_DIV_FRAC_START2_MODE1, 0x55),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_DIV_FRAC_START3_MODE1, 0x01),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_VCO_TUNE_MAP, 0x14),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CLK_SELECT, 0x34),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_HSCLK_SEL_1, 0x01),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CORECLK_DIV_MODE1, 0x04),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CMN_CONFIG_1, 0x16),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_ADDITIONAL_MISC_3, 0x0f),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CORE_CLK_EN, 0xa0),
> +};

[...]

>  struct qmp_pcie_offsets {
>  	u16 serdes;
>  	u16 pcs;
> @@ -1514,11 +1742,14 @@ struct qmp_pcie_offsets {
>  	u16 rx;
>  	u16 tx2;
>  	u16 rx2;
> +	u16 ln_shrd;
>  };
>  
>  struct qmp_phy_cfg_tbls {
>  	const struct qmp_phy_init_tbl *serdes;
>  	int serdes_num;
> +	const struct qmp_phy_init_tbl *ln_shrd;
> +	int ln_shrd_num;

Perhaps move after rx2 to reflect the 6.20 offsets.

>  	const struct qmp_phy_init_tbl *tx;
>  	int tx_num;
>  	const struct qmp_phy_init_tbl *rx;
> @@ -1556,6 +1787,9 @@ struct qmp_phy_cfg {
>  	/* resets to be requested */
>  	const char * const *reset_list;
>  	int num_resets;
> +	/* no-CSR resets to be requested */
> +	const char * const *nocsr_reset_list;
> +	int num_nocsr_resets;
>  	/* regulators to be requested */
>  	const char * const *vreg_list;
>  	int num_vregs;
> @@ -1580,6 +1814,7 @@ struct qmp_pcie {
>  	bool tcsr_4ln_config;
>  
>  	void __iomem *serdes;
> +	void __iomem *ln_shrd;

Perhaps move after rx2 to reflect the 6.20 offsets.

>  	void __iomem *pcs;
>  	void __iomem *pcs_misc;
>  	void __iomem *tx;
> @@ -1594,6 +1829,7 @@ struct qmp_pcie {
>  	int num_pipe_clks;
>  
>  	struct reset_control_bulk_data *resets;
> +	struct reset_control_bulk_data *nocsr_resets;
>  	struct regulator_bulk_data *vregs;
>  
>  	struct phy *phy;
> @@ -1648,6 +1884,10 @@ static const char * const qmp_phy_vreg_l[] = {
>  	"vdda-phy", "vdda-pll",
>  };
>  
> +static const char * const sm8550_qmp_phy_vreg_l[] = {
> +	"vdda-phy", "vdda-pll", "vdda-qref",
> +};
> +
>  /* list of resets */
>  static const char * const ipq8074_pciephy_reset_l[] = {
>  	"phy", "common",
> @@ -1657,6 +1897,10 @@ static const char * const sdm845_pciephy_reset_l[] = {
>  	"phy",
>  };
>  
> +static const char * const sm8550_pciephy_nocsr_reset_l[] = {
> +	"phy_nocsr",
> +};
> +
>  static const struct qmp_pcie_offsets qmp_pcie_offsets_v5 = {
>  	.serdes		= 0,
>  	.pcs		= 0x0200,
> @@ -1667,6 +1911,17 @@ static const struct qmp_pcie_offsets qmp_pcie_offsets_v5 = {
>  	.rx2		= 0x1800,
>  };
>  
> +static const struct qmp_pcie_offsets qmp_pcie_offsets_v6_20 = {
> +	.serdes		= 0x1000,
> +	.pcs		= 0x1200,
> +	.pcs_misc	= 0x1400,
> +	.tx		= 0x0,

nit: Maybe pad this one to four digits too now.

> +	.rx		= 0x0200,
> +	.tx2		= 0x0800,
> +	.rx2		= 0x0a00,
> +	.ln_shrd	= 0x0e00,
> +};
> +
>  static const struct qmp_phy_cfg ipq8074_pciephy_cfg = {
>  	.lanes			= 1,
>  
> @@ -2214,6 +2469,68 @@ static const struct qmp_phy_cfg sm8450_qmp_gen4x2_pciephy_cfg = {
>  	.phy_status		= PHYSTATUS_4_20,
>  };
>  
> +static const struct qmp_phy_cfg sm8550_qmp_gen3x2_pciephy_cfg = {
> +	.lanes = 2,
> +
> +	.offsets		= &qmp_pcie_offsets_v5,

Did you really intend to use the v5 offsets here? It seems you use v6.20
defines in the tables below. This may work but it looks a little strange
and does not match how we name and use these resources for the other
SoCs (e.g. reusing structures and defines from older IP revisions is
fine, but not necessarily the other way round).

I assume this means that the gen3 PHY is really is really v5 and using
a subset of the v6.20 defines happens to works as they are in fact
identical with respect to that subset?

As you have dedicated gen3x2 tables, perhaps those should use the v5
defines?

And at least add a comment about this in the commit message.

> +
> +	.tbls = {
> +		.serdes		= sm8550_qmp_gen3x2_pcie_serdes_tbl,
> +		.serdes_num	= ARRAY_SIZE(sm8550_qmp_gen3x2_pcie_serdes_tbl),
> +		.tx		= sm8550_qmp_gen3x2_pcie_tx_tbl,
> +		.tx_num		= ARRAY_SIZE(sm8550_qmp_gen3x2_pcie_tx_tbl),
> +		.rx		= sm8550_qmp_gen3x2_pcie_rx_tbl,
> +		.rx_num		= ARRAY_SIZE(sm8550_qmp_gen3x2_pcie_rx_tbl),
> +		.pcs		= sm8550_qmp_gen3x2_pcie_pcs_tbl,
> +		.pcs_num	= ARRAY_SIZE(sm8550_qmp_gen3x2_pcie_pcs_tbl),
> +		.pcs_misc	= sm8550_qmp_gen3x2_pcie_pcs_misc_tbl,
> +		.pcs_misc_num	= ARRAY_SIZE(sm8550_qmp_gen3x2_pcie_pcs_misc_tbl),
> +	},
> +	.clk_list		= sc8280xp_pciephy_clk_l,
> +	.num_clks		= ARRAY_SIZE(sc8280xp_pciephy_clk_l),
> +	.reset_list		= sdm845_pciephy_reset_l,
> +	.num_resets		= ARRAY_SIZE(sdm845_pciephy_reset_l),
> +	.vreg_list		= qmp_phy_vreg_l,
> +	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
> +	.regs			= pciephy_v5_regs_layout,
> +
> +	.pwrdn_ctrl		= SW_PWRDN | REFCLK_DRV_DSBL,
> +	.phy_status		= PHYSTATUS,
> +};
> +
> +static const struct qmp_phy_cfg sm8550_qmp_gen4x2_pciephy_cfg = {
> +	.lanes = 2,
> +
> +	.offsets		= &qmp_pcie_offsets_v6_20,
> +
> +	.tbls = {
> +		.serdes			= sm8550_qmp_gen4x2_pcie_serdes_tbl,
> +		.serdes_num		= ARRAY_SIZE(sm8550_qmp_gen4x2_pcie_serdes_tbl),
> +		.ln_shrd		= sm8550_qmp_gen4x2_pcie_ln_shrd_tbl,
> +		.ln_shrd_num		= ARRAY_SIZE(sm8550_qmp_gen4x2_pcie_ln_shrd_tbl),
> +		.tx			= sm8550_qmp_gen4x2_pcie_tx_tbl,
> +		.tx_num			= ARRAY_SIZE(sm8550_qmp_gen4x2_pcie_tx_tbl),
> +		.rx			= sm8550_qmp_gen4x2_pcie_rx_tbl,
> +		.rx_num			= ARRAY_SIZE(sm8550_qmp_gen4x2_pcie_rx_tbl),
> +		.pcs			= sm8550_qmp_gen4x2_pcie_pcs_tbl,
> +		.pcs_num		= ARRAY_SIZE(sm8550_qmp_gen4x2_pcie_pcs_tbl),
> +		.pcs_misc		= sm8550_qmp_gen4x2_pcie_pcs_misc_tbl,
> +		.pcs_misc_num		= ARRAY_SIZE(sm8550_qmp_gen4x2_pcie_pcs_misc_tbl),
> +	},
> +	.clk_list		= sc8280xp_pciephy_clk_l,
> +	.num_clks		= ARRAY_SIZE(sc8280xp_pciephy_clk_l),
> +	.reset_list		= sdm845_pciephy_reset_l,
> +	.num_resets		= ARRAY_SIZE(sdm845_pciephy_reset_l),
> +	.nocsr_reset_list	= sm8550_pciephy_nocsr_reset_l,
> +	.num_nocsr_resets	= ARRAY_SIZE(sm8550_pciephy_nocsr_reset_l),
> +	.vreg_list		= sm8550_qmp_phy_vreg_l,
> +	.num_vregs		= ARRAY_SIZE(sm8550_qmp_phy_vreg_l),
> +	.regs			= pciephy_v5_regs_layout,
> +
> +	.pwrdn_ctrl		= SW_PWRDN | REFCLK_DRV_DSBL,
> +	.phy_status		= PHYSTATUS_4_20,
> +};
> +
>  static void qmp_pcie_configure_lane(void __iomem *base,
>  					const struct qmp_phy_init_tbl tbl[],
>  					int num,
> @@ -2262,6 +2579,7 @@ static void qmp_pcie_init_registers(struct qmp_pcie *qmp, const struct qmp_phy_c
>  {
>  	const struct qmp_phy_cfg *cfg = qmp->cfg;
>  	void __iomem *serdes = qmp->serdes;
> +	void __iomem *ln_shrd = qmp->ln_shrd;

Move last here (after pcs_misc)?

>  	void __iomem *tx = qmp->tx;
>  	void __iomem *rx = qmp->rx;
>  	void __iomem *tx2 = qmp->tx2;
> @@ -2289,6 +2607,8 @@ static void qmp_pcie_init_registers(struct qmp_pcie *qmp, const struct qmp_phy_c
>  		qmp_pcie_configure(serdes, cfg->serdes_4ln_tbl, cfg->serdes_4ln_num);
>  		qmp_pcie_init_port_b(qmp, tbls);
>  	}
> +
> +	qmp_pcie_configure(ln_shrd, tbls->ln_shrd, tbls->ln_shrd_num);
>  }
>  
>  static int qmp_pcie_init(struct phy *phy)
> @@ -2309,20 +2629,31 @@ static int qmp_pcie_init(struct phy *phy)
>  		goto err_disable_regulators;
>  	}
>  
> +	if (qmp->nocsr_resets) {
> +		ret = reset_control_bulk_assert(cfg->num_nocsr_resets, qmp->nocsr_resets);
> +		if (ret) {
> +			dev_err(qmp->dev, "no-csr reset assert failed\n");
> +			goto err_assert_reset;
> +		}
> +	}
> +
>  	usleep_range(200, 300);
>  
>  	ret = reset_control_bulk_deassert(cfg->num_resets, qmp->resets);
>  	if (ret) {
>  		dev_err(qmp->dev, "reset deassert failed\n");
> -		goto err_disable_regulators;
> +		goto err_assert_nocsr_reset;
>  	}
>  
>  	ret = clk_bulk_prepare_enable(cfg->num_clks, qmp->clks);
>  	if (ret)
> -		goto err_assert_reset;
> +		goto err_assert_nocsr_reset;
>  
>  	return 0;
>  
> +err_assert_nocsr_reset:
> +	if (qmp->nocsr_resets)
> +		reset_control_bulk_assert(cfg->num_resets, qmp->resets);
>  err_assert_reset:
>  	reset_control_bulk_assert(cfg->num_resets, qmp->resets);
>  err_disable_regulators:
> @@ -2370,6 +2701,14 @@ static int qmp_pcie_power_on(struct phy *phy)
>  	if (ret)
>  		return ret;
>  
> +	if (qmp->nocsr_resets) {
> +		ret = reset_control_bulk_deassert(cfg->num_nocsr_resets, qmp->nocsr_resets);
> +		if (ret) {
> +			dev_err(qmp->dev, "no-csr reset deassert failed\n");
> +			goto err_disable_pipe_clk;
> +		}
> +	}
> +
>  	/* Pull PHY out of reset state */
>  	qphy_clrbits(pcs, cfg->regs[QPHY_SW_RESET], SW_RESET);
>  
> @@ -2503,6 +2842,21 @@ static int qmp_pcie_reset_init(struct qmp_pcie *qmp)
>  	if (ret)
>  		return dev_err_probe(dev, ret, "failed to get resets\n");
>  
> +	if (cfg->nocsr_reset_list) {
> +		qmp->nocsr_resets = devm_kcalloc(dev, cfg->num_nocsr_resets,
> +				   sizeof(*qmp->nocsr_resets), GFP_KERNEL);
> +		if (!qmp->nocsr_resets)
> +			return -ENOMEM;
> +
> +		for (i = 0; i < cfg->num_nocsr_resets; i++)
> +			qmp->nocsr_resets[i].id = cfg->nocsr_reset_list[i];
> +
> +		ret = devm_reset_control_bulk_get_exclusive(dev, cfg->num_nocsr_resets,
> +								qmp->nocsr_resets);
> +		if (ret)
> +			return dev_err_probe(dev, ret, "failed to get no-CSR resets\n");

nit: you now use lower case 'no-csr' everywhere else.

Using the bulk API for this when we don't currently expect there to ever
be more than one nocsr reset seems like overkill, and also as the
nocsr reset is special and is managed differently during the power on
sequence.

If so this could just be a flag in the gen4 PHY config and the
"phy_nocsr" name could be hard coded here.

On the other hand, the bulk API allows for treating resets as optional,
but you don't currently use that above (e.g. by calling bulk_assert
unconditionally).

> +	}
> +
>  	return 0;
>  }

Johan
