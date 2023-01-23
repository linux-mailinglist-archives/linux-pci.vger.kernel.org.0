Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86AC6677EA0
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jan 2023 16:04:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbjAWPD6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 Jan 2023 10:03:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232186AbjAWPDz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 23 Jan 2023 10:03:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 878BD2887C;
        Mon, 23 Jan 2023 07:03:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1943D60F58;
        Mon, 23 Jan 2023 15:03:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 500E4C433D2;
        Mon, 23 Jan 2023 15:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674486231;
        bh=sO5ySKuSsq9MUqxlGYVWya0q9jimaA/5HNl8GVliyBQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bSCiKKkWfQZqRCSVgNT0tBqX+zT3VZk+LbCaYULG7G4qYGC4fVlwbGzLMk/r03ZlC
         BlmVNClUdStc2s1FrkhNA7qOUDtek7hWuWRNUrM6Aufw2B9ZuPYzttG8V2hZIZjznQ
         NvNRBBNaPUApQqUN5wwepVN9viHS5/urM+3oYAJqVIa2RwgoqwIRAsj2GQED/roYqZ
         B7L4QCM6W4Oxlu8V+gVoFKQqhKb3MOTT/+Yo1jcIbQ1UCS6cWTpEHGiQwC0c03zSZX
         tIK+RHrPHA1vdjnxVaLoH3FbM5ErRxSsknJIfBc+UbYkHlGXc9W1AkOuzGv9o32sai
         O3OECYLsYZr1w==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pJyMO-0000Io-VQ; Mon, 23 Jan 2023 16:03:49 +0100
Date:   Mon, 23 Jan 2023 16:03:48 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v4 08/12] phy: qcom-qmp-pcie: Add support for SM8550 g3x2
 and g4x2 PCIEs
Message-ID: <Y86h1FDuHFu3mImq@hovoldconsulting.com>
References: <20230119140453.3942340-1-abel.vesa@linaro.org>
 <20230119140453.3942340-9-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119140453.3942340-9-abel.vesa@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 19, 2023 at 04:04:49PM +0200, Abel Vesa wrote:
> Add the SM8550 both g4 and g3 configurations. In addition, there is a
> new "lane shared" table that needs to be configured for g4, along with
> the No-CSR list of resets.
> 
> Co-developed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
> 
> This patchset relies on the following patchset:
> https://lore.kernel.org/all/20230117224148.1914627-1-abel.vesa@linaro.org/
> 
> The v3 of this patchset is:
> https://lore.kernel.org/all/20230118005328.2378792-1-abel.vesa@linaro.org/
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
>  drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 365 +++++++++++++++++++++++
>  1 file changed, 365 insertions(+)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> index bffb9e138715..48d179d8d8d6 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> @@ -1506,6 +1506,234 @@ static const struct qmp_phy_init_tbl sm8450_qmp_gen4x2_pcie_ep_pcs_misc_tbl[] =
>  	QMP_PHY_INIT_CFG(QPHY_V5_20_PCS_PCIE_OSC_DTCT_MODE2_CONFIG5, 0x08),
>  };
>  
> +static const struct qmp_phy_init_tbl sm8550_qmp_gen4x2_pcie_serdes_ln_shrd_tbl[] = {

Perhaps you can drop the '_serdes' infix here as it is mostly redundant
and not included in the names of the other tables/resources.

> +	QMP_PHY_INIT_CFG(QSERDES_V6_LN_SHRD_RXCLK_DIV2_CTRL, 0x01),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_LN_SHRD_RX_Q_EN_RATES, 0xe),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_LN_SHRD_DFE_DAC_ENABLE1, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_LN_SHRD_TX_ADAPT_POST_THRESH1, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_LN_SHRD_TX_ADAPT_POST_THRESH2, 0x1f),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_LN_SHRD_RX_MODE_RATE_0_1_B0, 0x12),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_LN_SHRD_RX_MODE_RATE_0_1_B1, 0x12),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_LN_SHRD_RX_MODE_RATE_0_1_B2, 0xdb),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_LN_SHRD_RX_MODE_RATE_0_1_B3, 0x9a),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_LN_SHRD_RX_MODE_RATE_0_1_B4, 0x38),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_LN_SHRD_RX_MODE_RATE_0_1_B5, 0xb6),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_LN_SHRD_RX_MODE_RATE_0_1_B6, 0x64),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_LN_SHRD_RX_MARG_COARSE_THRESH1_RATE210, 0x1f),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_LN_SHRD_RX_MARG_COARSE_THRESH1_RATE3, 0x1f),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_LN_SHRD_RX_MARG_COARSE_THRESH2_RATE210, 0x1f),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_LN_SHRD_RX_MARG_COARSE_THRESH2_RATE3, 0x1f),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_LN_SHRD_RX_MARG_COARSE_THRESH3_RATE210, 0x1f),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_LN_SHRD_RX_MARG_COARSE_THRESH3_RATE3, 0x1f),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_LN_SHRD_RX_MARG_COARSE_THRESH4_RATE3, 0x1f),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_LN_SHRD_RX_MARG_COARSE_THRESH5_RATE3, 0x1f),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_LN_SHRD_RX_MARG_COARSE_THRESH6_RATE3, 0x1f),
> +};
> +
> +static const struct qmp_phy_init_tbl sm8550_qmp_gen4x2_pcie_tx_tbl[] = {
> +	QMP_PHY_INIT_CFG(QSERDES_V6_20_TX_RES_CODE_LANE_OFFSET_TX, 0x1d),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_20_TX_RES_CODE_LANE_OFFSET_RX, 0x03),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_20_TX_LANE_MODE_1, 0x01),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_20_TX_LANE_MODE_2, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_20_TX_LANE_MODE_3, 0x51),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_20_TX_TRAN_DRVR_EMP_EN, 0x34),
> +};

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
> +	const struct qmp_phy_init_tbl *ln_shrd_serdes;
> +	int ln_shrd_serdes_num;
>  	const struct qmp_phy_init_tbl *tx;
>  	int tx_num;
>  	const struct qmp_phy_init_tbl *rx;
> @@ -1556,6 +1787,9 @@ struct qmp_phy_cfg {
>  	/* resets to be requested */
>  	const char * const *reset_list;
>  	int num_resets;
> +	/* no CSR resets to be requested */

Add a hyphen between 'no' and 'CSR' to make it a bit more readable.

> +	const char * const *nocsr_reset_list;
> +	int num_nocsr_resets;
>  	/* regulators to be requested */
>  	const char * const *vreg_list;
>  	int num_vregs;
> @@ -1569,6 +1803,9 @@ struct qmp_phy_cfg {
>  
>  	bool skip_start_delay;
>  
> +	/* true, if PHY has lane shared serdes table */
> +	bool has_ln_shrd_serdes_tbl;
> +

Can't you just check the table pointer directly?

>  	/* QMP PHY pipe clock interface rate */
>  	unsigned long pipe_clock_rate;
>  };
> @@ -1580,6 +1817,7 @@ struct qmp_pcie {
>  	bool tcsr_4ln_config;
>  
>  	void __iomem *serdes;
> +	void __iomem *ln_shrd_serdes;

Drop '_serdes'.

>  	void __iomem *pcs;
>  	void __iomem *pcs_misc;
>  	void __iomem *tx;
> @@ -1594,6 +1832,7 @@ struct qmp_pcie {
>  	int num_pipe_clks;
>  
>  	struct reset_control_bulk_data *resets;
> +	struct reset_control_bulk_data *nocsr_resets;
>  	struct regulator_bulk_data *vregs;
>  
>  	struct phy *phy;
> @@ -1648,6 +1887,10 @@ static const char * const qmp_phy_vreg_l[] = {
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
> @@ -1657,6 +1900,10 @@ static const char * const sdm845_pciephy_reset_l[] = {
>  	"phy",
>  };
>  
> +static const char * const sm8550_pciephy_nocsr_reset_l[] = {
> +	"nocsr",
> +};
> +
>  static const struct qmp_pcie_offsets qmp_pcie_offsets_v5 = {
>  	.serdes		= 0,
>  	.pcs		= 0x0200,
> @@ -1667,6 +1914,17 @@ static const struct qmp_pcie_offsets qmp_pcie_offsets_v5 = {
>  	.rx2		= 0x1800,
>  };
>  
> +static const struct qmp_pcie_offsets qmp_pcie_offsets_v6_20 = {
> +	.tx		= 0x0,
> +	.rx		= 0x0200,
> +	.tx2		= 0x0800,
> +	.rx2		= 0x0a00,
> +	.ln_shrd	= 0x0e00,
> +	.serdes		= 0x1000,
> +	.pcs		= 0x1200,
> +	.pcs_misc	= 0x1400,
> +};

I did not notice before, but perhaps you should use the order from the
struct definition instead of sorting by offset. That should make it
easier to spot SoC differences, missing fields, etc.

> +
>  static const struct qmp_phy_cfg ipq8074_pciephy_cfg = {
>  	.lanes			= 1,
>  

> @@ -2262,6 +2583,7 @@ static void qmp_pcie_init_registers(struct qmp_pcie *qmp, const struct qmp_phy_c
>  {
>  	const struct qmp_phy_cfg *cfg = qmp->cfg;
>  	void __iomem *serdes = qmp->serdes;
> +	void __iomem *ln_shrd_serdes = qmp->ln_shrd_serdes;

ln_shrd should do.

>  	void __iomem *tx = qmp->tx;
>  	void __iomem *rx = qmp->rx;
>  	void __iomem *tx2 = qmp->tx2;
> @@ -2289,6 +2611,10 @@ static void qmp_pcie_init_registers(struct qmp_pcie *qmp, const struct qmp_phy_c
>  		qmp_pcie_configure(serdes, cfg->serdes_4ln_tbl, cfg->serdes_4ln_num);
>  		qmp_pcie_init_port_b(qmp, tbls);
>  	}
> +
> +	if (cfg->has_ln_shrd_serdes_tbl)

So you could check tbls->ln_shrd here, or just call unconditionally as
qmp_pcie_configure() already handles that.

> +		qmp_pcie_configure(ln_shrd_serdes, tbls->ln_shrd_serdes,
> +				       tbls->ln_shrd_serdes_num);
>  }
>  
>  static int qmp_pcie_init(struct phy *phy)
> @@ -2309,6 +2635,14 @@ static int qmp_pcie_init(struct phy *phy)
>  		goto err_disable_regulators;
>  	}
>  
> +	if (qmp->nocsr_resets) {
> +		ret = reset_control_bulk_assert(cfg->num_nocsr_resets, qmp->nocsr_resets);
> +		if (ret) {
> +			dev_err(qmp->dev, "no-csr reset assert failed\n");
> +			goto err_disable_regulators;
> +		}
> +	}
> +
>  	usleep_range(200, 300);
>  
>  	ret = reset_control_bulk_deassert(cfg->num_resets, qmp->resets);

Should you really leave the reset asserted on errors here and below?

> @@ -2370,6 +2704,14 @@ static int qmp_pcie_power_on(struct phy *phy)
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

Is this the documented reset sequence? To keep the nocsr reset asserted
from init() to power_on() and during programming of the PHY registers?

What if power_on() is never called, etc? (I know we always call
power_on() after init() currently, but that may change.)

Could you explain a bit how this reset is supposed work and be used?

> +
>  	/* Pull PHY out of reset state */
>  	qphy_clrbits(pcs, cfg->regs[QPHY_SW_RESET], SW_RESET);
>  
> @@ -2503,6 +2845,21 @@ static int qmp_pcie_reset_init(struct qmp_pcie *qmp)
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
> +			return dev_err_probe(dev, ret, "failed to get no CSR resets\n");

hyphen after 'no'

> +	}
> +
>  	return 0;
>  }
>  
> @@ -2713,6 +3070,8 @@ static int qmp_pcie_parse_dt(struct qmp_pcie *qmp)
>  	qmp->pcs_misc = base + offs->pcs_misc;
>  	qmp->tx = base + offs->tx;
>  	qmp->rx = base + offs->rx;
> +	if (cfg->has_ln_shrd_serdes_tbl)
> +		qmp->ln_shrd_serdes = base + offs->ln_shrd;

Odd placement here in between tx/rx and tx2/rx2.

Doesn't hurt setting the pointer whenever this block exists, so perhaps
just do

	if (offs->ln_shrd)
		qmp->ln_shrd = base + offs->ln_shrd;

and move this after the port_b initialisation (e.g. to follow the order
in the offset struct and programming sequence above)?

>  
>  	if (cfg->lanes >= 2) {
>  		qmp->tx2 = base + offs->tx2;

Johan
