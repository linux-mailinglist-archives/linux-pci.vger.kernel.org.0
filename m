Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 096235E9A69
	for <lists+linux-pci@lfdr.de>; Mon, 26 Sep 2022 09:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233382AbiIZH1r (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Sep 2022 03:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233689AbiIZH1o (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Sep 2022 03:27:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 831CD1FCDE;
        Mon, 26 Sep 2022 00:27:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2D14CB81908;
        Mon, 26 Sep 2022 07:27:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1346C433D6;
        Mon, 26 Sep 2022 07:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664177260;
        bh=uKUJcllYmPoP/vIfOP2ZgzDh4254OwkmQ/RtbmidGx0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ufCrhhk6zLwJRX9Y9In+Wq8dug6AkKOtOrpbWSNvzWTYmA2ULKAxWw/ciIWTKMg9i
         4ukH4lDf5QEYlqLvm8/+Nm4eW7Fu9XyTEfxKAQi0dQy8/s60I3YopYOIVxIxbi8ztF
         pS3uqKOKb5rzS0S3Gsf1P6GZm4xP3O560g+jJTUJg4B/K0dwwtOp1QysHyRUBiibFO
         CiL5QekxIIzkL+PKSBleNeo78lB33KMJuZ0Gqp0BIqTmufTWfPDiOtEI1fMggHAEax
         pBiXzerYipSH2GWtl8BiqdK9e3sV9mFlhiLgOP4kWyPT2/DGmSOorVrGI0TP1FRhDd
         1h52MuivTRzpQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1ociWn-0003ga-Hn; Mon, 26 Sep 2022 09:27:46 +0200
Date:   Mon, 26 Sep 2022 09:27:45 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org
Subject: Re: [PATCH v4 1/6] phy: qcom-qmp-pcie: split register tables into
 common and extra parts
Message-ID: <YzFUcWSHkdSlIbHU@hovoldconsulting.com>
References: <20220924160302.285875-1-dmitry.baryshkov@linaro.org>
 <20220924160302.285875-2-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220924160302.285875-2-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Sep 24, 2022 at 07:02:57PM +0300, Dmitry Baryshkov wrote:
> SM8250 configuration tables are split into two parts: the common one and
> the PHY-specific tables. Make this split more formal. Rather than having
> a blind renamed copy of all QMP table fields, add separate struct
> qmp_phy_cfg_tables and add two instances of this structure to the struct
> qmp_phy_cfg. Later on this will be used to support different PHY modes
> (RC vs EP).
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 129 ++++++++++++++---------
>  1 file changed, 77 insertions(+), 52 deletions(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> index 7aff3f9940a5..30806816c8b0 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> @@ -1300,31 +1300,30 @@ static const struct qmp_phy_init_tbl sm8450_qmp_gen4x2_pcie_pcs_misc_tbl[] = {
>  	QMP_PHY_INIT_CFG(QPHY_V5_20_PCS_PCIE_G4_PRE_GAIN, 0x2e),
>  };
>  
> -/* struct qmp_phy_cfg - per-PHY initialization config */
> -struct qmp_phy_cfg {
> -	int lanes;
> -
> -	/* Init sequence for PHY blocks - serdes, tx, rx, pcs */
> +struct qmp_phy_cfg_tables {
>  	const struct qmp_phy_init_tbl *serdes_tbl;
>  	int serdes_tbl_num;

So I still think you should drop the now redundant "tbl" suffix and
infix.

> -	const struct qmp_phy_init_tbl *serdes_tbl_sec;
> -	int serdes_tbl_num_sec;
>  	const struct qmp_phy_init_tbl *tx_tbl;
>  	int tx_tbl_num;
> -	const struct qmp_phy_init_tbl *tx_tbl_sec;
> -	int tx_tbl_num_sec;
>  	const struct qmp_phy_init_tbl *rx_tbl;
>  	int rx_tbl_num;
> -	const struct qmp_phy_init_tbl *rx_tbl_sec;
> -	int rx_tbl_num_sec;
>  	const struct qmp_phy_init_tbl *pcs_tbl;
>  	int pcs_tbl_num;
> -	const struct qmp_phy_init_tbl *pcs_tbl_sec;
> -	int pcs_tbl_num_sec;
>  	const struct qmp_phy_init_tbl *pcs_misc_tbl;
>  	int pcs_misc_tbl_num;
> -	const struct qmp_phy_init_tbl *pcs_misc_tbl_sec;
> -	int pcs_misc_tbl_num_sec;
> +};
> +
> +/* struct qmp_phy_cfg - per-PHY initialization config */
> +struct qmp_phy_cfg {
> +	int lanes;
> +
> +	/* Main init sequence for PHY blocks - serdes, tx, rx, pcs */
> +	struct qmp_phy_cfg_tables common;

And this could be "tbls_common".

> +	/*
> +	 * Additional init sequence for PHY blocks, providing additional
> +	 * register programming. Unless required it can be left omitted.
> +	 */
> +	struct qmp_phy_cfg_tables *extra;

And "tbls_extra".

I guess this table should be const as well.

>  
>  	/* clock ids to be requested */
>  	const char * const *clk_list;
> @@ -1459,6 +1458,7 @@ static const char * const sdm845_pciephy_reset_l[] = {
>  static const struct qmp_phy_cfg ipq8074_pciephy_cfg = {
>  	.lanes			= 1,
>  
> +	.common = {
>  	.serdes_tbl		= ipq8074_pcie_serdes_tbl,
>  	.serdes_tbl_num		= ARRAY_SIZE(ipq8074_pcie_serdes_tbl),
>  	.tx_tbl			= ipq8074_pcie_tx_tbl,
> @@ -1467,6 +1467,7 @@ static const struct qmp_phy_cfg ipq8074_pciephy_cfg = {
>  	.rx_tbl_num		= ARRAY_SIZE(ipq8074_pcie_rx_tbl),
>  	.pcs_tbl		= ipq8074_pcie_pcs_tbl,
>  	.pcs_tbl_num		= ARRAY_SIZE(ipq8074_pcie_pcs_tbl),
> +	},

Shouldn't you indent the members now? The above looks unnecessarily hard
to read.

>  	.clk_list		= ipq8074_pciephy_clk_l,
>  	.num_clks		= ARRAY_SIZE(ipq8074_pciephy_clk_l),
>  	.reset_list		= ipq8074_pciephy_reset_l,

 @@ -1603,24 +1612,28 @@ static const struct qmp_phy_cfg sdm845_qhp_pciephy_cfg = {
>  static const struct qmp_phy_cfg sm8250_qmp_gen3x1_pciephy_cfg = {
>  	.lanes			= 1,
>  
> +	.common = {
>  	.serdes_tbl		= sm8250_qmp_pcie_serdes_tbl,
>  	.serdes_tbl_num		= ARRAY_SIZE(sm8250_qmp_pcie_serdes_tbl),
> -	.serdes_tbl_sec		= sm8250_qmp_gen3x1_pcie_serdes_tbl,
> -	.serdes_tbl_num_sec	= ARRAY_SIZE(sm8250_qmp_gen3x1_pcie_serdes_tbl),
>  	.tx_tbl			= sm8250_qmp_pcie_tx_tbl,
>  	.tx_tbl_num		= ARRAY_SIZE(sm8250_qmp_pcie_tx_tbl),
>  	.rx_tbl			= sm8250_qmp_pcie_rx_tbl,
>  	.rx_tbl_num		= ARRAY_SIZE(sm8250_qmp_pcie_rx_tbl),
> -	.rx_tbl_sec		= sm8250_qmp_gen3x1_pcie_rx_tbl,
> -	.rx_tbl_num_sec		= ARRAY_SIZE(sm8250_qmp_gen3x1_pcie_rx_tbl),
>  	.pcs_tbl		= sm8250_qmp_pcie_pcs_tbl,
>  	.pcs_tbl_num		= ARRAY_SIZE(sm8250_qmp_pcie_pcs_tbl),
> -	.pcs_tbl_sec		= sm8250_qmp_gen3x1_pcie_pcs_tbl,
> -	.pcs_tbl_num_sec		= ARRAY_SIZE(sm8250_qmp_gen3x1_pcie_pcs_tbl),
>  	.pcs_misc_tbl		= sm8250_qmp_pcie_pcs_misc_tbl,
>  	.pcs_misc_tbl_num	= ARRAY_SIZE(sm8250_qmp_pcie_pcs_misc_tbl),
> -	.pcs_misc_tbl_sec		= sm8250_qmp_gen3x1_pcie_pcs_misc_tbl,
> -	.pcs_misc_tbl_num_sec	= ARRAY_SIZE(sm8250_qmp_gen3x1_pcie_pcs_misc_tbl),
> +	},
> +	.extra = &(struct qmp_phy_cfg_tables) {

const structure?

> +	.serdes_tbl		= sm8250_qmp_gen3x1_pcie_serdes_tbl,
> +	.serdes_tbl_num		= ARRAY_SIZE(sm8250_qmp_gen3x1_pcie_serdes_tbl),
> +	.rx_tbl			= sm8250_qmp_gen3x1_pcie_rx_tbl,
> +	.rx_tbl_num		= ARRAY_SIZE(sm8250_qmp_gen3x1_pcie_rx_tbl),
> +	.pcs_tbl		= sm8250_qmp_gen3x1_pcie_pcs_tbl,
> +	.pcs_tbl_num		= ARRAY_SIZE(sm8250_qmp_gen3x1_pcie_pcs_tbl),
> +	.pcs_misc_tbl		= sm8250_qmp_gen3x1_pcie_pcs_misc_tbl,
> +	.pcs_misc_tbl_num	= ARRAY_SIZE(sm8250_qmp_gen3x1_pcie_pcs_misc_tbl),

Indentation.

> +	},
>  	.clk_list		= sdm845_pciephy_clk_l,
>  	.num_clks		= ARRAY_SIZE(sdm845_pciephy_clk_l),
>  	.reset_list		= sdm845_pciephy_reset_l,

> @@ -1854,11 +1881,9 @@ static int qmp_pcie_serdes_init(struct qmp_phy *qphy)
>  {
>  	const struct qmp_phy_cfg *cfg = qphy->cfg;
>  	void __iomem *serdes = qphy->serdes;
> -	const struct qmp_phy_init_tbl *serdes_tbl = cfg->serdes_tbl;
> -	int serdes_tbl_num = cfg->serdes_tbl_num;
>  
> -	qmp_pcie_configure(serdes, cfg->regs, serdes_tbl, serdes_tbl_num);
> -	qmp_pcie_configure(serdes, cfg->regs, cfg->serdes_tbl_sec, cfg->serdes_tbl_num_sec);
> +	qmp_pcie_configure(serdes, cfg->regs, cfg->common.serdes_tbl, cfg->common.serdes_tbl_num);
> +	qmp_pcie_configure(serdes, cfg->regs, cfg->extra->serdes_tbl, cfg->extra->serdes_tbl_num);

I already mentioned the NULL-derefs as cfg->extra can be NULL.

>  
>  	return 0;
>  }
 
>  	if (IS_ERR(qphy->pcs_misc)) {
> -		if (cfg->pcs_misc_tbl || cfg->pcs_misc_tbl_sec)
> +		if (cfg->common.pcs_misc_tbl || cfg->extra->pcs_misc_tbl)

Here too.

>  			return PTR_ERR(qphy->pcs_misc);
>  	}

Johan
