Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6BB459FD85
	for <lists+linux-pci@lfdr.de>; Wed, 24 Aug 2022 16:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239216AbiHXOqz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Aug 2022 10:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239173AbiHXOqy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Aug 2022 10:46:54 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F547CB50
        for <linux-pci@vger.kernel.org>; Wed, 24 Aug 2022 07:46:52 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id o14-20020a17090a0a0e00b001fabfd3369cso1698680pjo.5
        for <linux-pci@vger.kernel.org>; Wed, 24 Aug 2022 07:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=M76dUuF60JXivzYoYfDdRbCtmWLeSf/n8h8YfhPxW6U=;
        b=l6qpu6k/cEmClEEtB0r0w1KHzJZTfxR089gY8gXLnTneTp9kaYiUuAsrGmaU6ZxRQ9
         uEldbGQm8M4Al6ItdM2fiTA3UsxOrTvU6NVLuIEcursNeqGbAwr4sPGBuwlhoT4Go2qQ
         8Zvh44uTPfDVggicDYaEg0NDcKjdABHTrIoH6/J5fxbU/4T9s9Md4M9dAFcBOZZVKgrO
         xBnWzsV88ulnX9qQhaUmyb3vuTMkHCyCf7eJkYjMIC2lYuhLLj6nG3CrJ+RsHltOLXGB
         yKZEuYh2PmAP/fgwVmXpOTNpwW1X0fgK1WSXx7oGdN+gRP3xFjnlQiJbxMgqMu/rUBnj
         FCMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=M76dUuF60JXivzYoYfDdRbCtmWLeSf/n8h8YfhPxW6U=;
        b=fec24tDKZvB25QlGjDNm0y2xVcYjaq8lL8p7nYXpZymho+7xtNU5ha4Fzpk3MEOvOQ
         ITaClZ/MFsIqMn6kKP/Hgv95/VWy8etHAkIGDT58VwyfJ87OHvv8nFAw9MR/3nKMj6sy
         OaVrCUnoTkVv0CZFCoLLvTFYpOssjPwfsEZCVIfYJNEoGrqqu96RBCkYbhn8FtizpMLS
         ewYwRUa/9r6uo7Go4m2J2RyraT8C+EeLusAJQqon2n3deniVHMxieq7IkaSC528dDQ3a
         zclCKjLO0VX6S4odKXTmyoR1YlJ0GoNslnjOZ+YMj3PuecHg3WrNVIkQfIAqf+GOucTi
         yNKA==
X-Gm-Message-State: ACgBeo3mcbfTtgvg+3HbswcZpbjH45a5q8lK4x5IMPAxmo/sm/zre0Bw
        7qsinNSno4FqDA+NCQFYChVD
X-Google-Smtp-Source: AA6agR75xAHp9Tr2QL0rPT83FrnUDdFIpA4HfH6Ze8O/6UVNwTTNd/JlA3YPB7G+obZ0j/BBCFWK6A==
X-Received: by 2002:a17:90a:64c1:b0:1fa:d891:adc0 with SMTP id i1-20020a17090a64c100b001fad891adc0mr8968260pjm.147.1661352411865;
        Wed, 24 Aug 2022 07:46:51 -0700 (PDT)
Received: from thinkpad ([117.207.24.28])
        by smtp.gmail.com with ESMTPSA id z17-20020a170902d55100b00172ea32fa9bsm6740449plf.287.2022.08.24.07.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 07:46:51 -0700 (PDT)
Date:   Wed, 24 Aug 2022 20:16:41 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
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
        Johan Hovold <johan@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-phy@lists.infradead.org
Subject: Re: [PATCH v1 1/4] phy: qcom-qmp-pcie: split register tables into
 primary and secondary part
Message-ID: <20220824144641.GD4767@thinkpad>
References: <20220726203401.595934-1-dmitry.baryshkov@linaro.org>
 <20220726203401.595934-2-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220726203401.595934-2-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 26, 2022 at 11:33:58PM +0300, Dmitry Baryshkov wrote:
> Split register tables list into primary and secondary parts.

It is good to provide some reasoning on why splitting the register tables is
required.

> While we
> are at it, drop unused if (table) conditions, since the function
> qcom_qmp_phy_pcie_configure_lane() has this check anyway.
> 

Please add a separate patch for the "while at it..." portion since that's a
separate issue and the patch should come before this patch.

> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 156 +++++++++++++----------
>  1 file changed, 87 insertions(+), 69 deletions(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> index 2d65e1f56bfc..e6272bd3d735 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> @@ -1346,34 +1346,33 @@ static const struct qmp_phy_init_tbl sm8450_qmp_gen4x2_pcie_pcs_misc_tbl[] = {
>  
>  struct qmp_phy;
>  
> -/* struct qmp_phy_cfg - per-PHY initialization config */
> -struct qmp_phy_cfg {
> -	/* phy-type - PCIE/UFS/USB */
> -	unsigned int type;
> -	/* number of lanes provided by phy */
> -	int nlanes;
> -
> -	/* Init sequence for PHY blocks - serdes, tx, rx, pcs */
> +struct qmp_phy_cfg_tables {
>  	const struct qmp_phy_init_tbl *serdes_tbl;
>  	int serdes_tbl_num;
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
> +	/* phy-type - PCIE/UFS/USB */
> +	unsigned int type;
> +	/* number of lanes provided by phy */
> +	int nlanes;
> +
> +	/* Init sequence for PHY blocks - serdes, tx, rx, pcs */
> +	struct qmp_phy_cfg_tables primary;
> +	/*
> +	 * Init sequence for PHY blocks, providing additional register
> +	 * programming. Unless required it can be left omitted.
> +	 */
> +	struct qmp_phy_cfg_tables secondary;
>  
>  	/* clock ids to be requested */
>  	const char * const *clk_list;
> @@ -1396,7 +1395,7 @@ struct qmp_phy_cfg {
>  
>  	/* true, if PHY needs delay after POWER_DOWN */
>  	bool has_pwrdn_delay;
> -	/* power_down delay in usec */
> +	/* power_down delay in usecondary */

usec is micro seconds, isn't it?

Rest look good.

Thanks,
Mani

>  	int pwrdn_delay_min;
>  	int pwrdn_delay_max;
>  
> @@ -1517,6 +1516,7 @@ static const struct qmp_phy_cfg ipq8074_pciephy_cfg = {
>  	.type			= PHY_TYPE_PCIE,
>  	.nlanes			= 1,
>  
> +	.primary = {
>  	.serdes_tbl		= ipq8074_pcie_serdes_tbl,
>  	.serdes_tbl_num		= ARRAY_SIZE(ipq8074_pcie_serdes_tbl),
>  	.tx_tbl			= ipq8074_pcie_tx_tbl,
> @@ -1525,6 +1525,7 @@ static const struct qmp_phy_cfg ipq8074_pciephy_cfg = {
>  	.rx_tbl_num		= ARRAY_SIZE(ipq8074_pcie_rx_tbl),
>  	.pcs_tbl		= ipq8074_pcie_pcs_tbl,
>  	.pcs_tbl_num		= ARRAY_SIZE(ipq8074_pcie_pcs_tbl),
> +	},
>  	.clk_list		= ipq8074_pciephy_clk_l,
>  	.num_clks		= ARRAY_SIZE(ipq8074_pciephy_clk_l),
>  	.reset_list		= ipq8074_pciephy_reset_l,
> @@ -1546,6 +1547,7 @@ static const struct qmp_phy_cfg ipq8074_pciephy_gen3_cfg = {
>  	.type			= PHY_TYPE_PCIE,
>  	.nlanes			= 1,
>  
> +	.primary = {
>  	.serdes_tbl		= ipq8074_pcie_gen3_serdes_tbl,
>  	.serdes_tbl_num		= ARRAY_SIZE(ipq8074_pcie_gen3_serdes_tbl),
>  	.tx_tbl			= ipq8074_pcie_gen3_tx_tbl,
> @@ -1554,6 +1556,7 @@ static const struct qmp_phy_cfg ipq8074_pciephy_gen3_cfg = {
>  	.rx_tbl_num		= ARRAY_SIZE(ipq8074_pcie_gen3_rx_tbl),
>  	.pcs_tbl		= ipq8074_pcie_gen3_pcs_tbl,
>  	.pcs_tbl_num		= ARRAY_SIZE(ipq8074_pcie_gen3_pcs_tbl),
> +	},
>  	.clk_list		= ipq8074_pciephy_clk_l,
>  	.num_clks		= ARRAY_SIZE(ipq8074_pciephy_clk_l),
>  	.reset_list		= ipq8074_pciephy_reset_l,
> @@ -1576,6 +1579,7 @@ static const struct qmp_phy_cfg ipq6018_pciephy_cfg = {
>  	.type			= PHY_TYPE_PCIE,
>  	.nlanes			= 1,
>  
> +	.primary = {
>  	.serdes_tbl		= ipq6018_pcie_serdes_tbl,
>  	.serdes_tbl_num		= ARRAY_SIZE(ipq6018_pcie_serdes_tbl),
>  	.tx_tbl			= ipq6018_pcie_tx_tbl,
> @@ -1586,6 +1590,7 @@ static const struct qmp_phy_cfg ipq6018_pciephy_cfg = {
>  	.pcs_tbl_num		= ARRAY_SIZE(ipq6018_pcie_pcs_tbl),
>  	.pcs_misc_tbl		= ipq6018_pcie_pcs_misc_tbl,
>  	.pcs_misc_tbl_num	= ARRAY_SIZE(ipq6018_pcie_pcs_misc_tbl),
> +	},
>  	.clk_list		= ipq8074_pciephy_clk_l,
>  	.num_clks		= ARRAY_SIZE(ipq8074_pciephy_clk_l),
>  	.reset_list		= ipq8074_pciephy_reset_l,
> @@ -1606,6 +1611,7 @@ static const struct qmp_phy_cfg sdm845_qmp_pciephy_cfg = {
>  	.type = PHY_TYPE_PCIE,
>  	.nlanes = 1,
>  
> +	.primary = {
>  	.serdes_tbl		= sdm845_qmp_pcie_serdes_tbl,
>  	.serdes_tbl_num		= ARRAY_SIZE(sdm845_qmp_pcie_serdes_tbl),
>  	.tx_tbl			= sdm845_qmp_pcie_tx_tbl,
> @@ -1616,6 +1622,7 @@ static const struct qmp_phy_cfg sdm845_qmp_pciephy_cfg = {
>  	.pcs_tbl_num		= ARRAY_SIZE(sdm845_qmp_pcie_pcs_tbl),
>  	.pcs_misc_tbl		= sdm845_qmp_pcie_pcs_misc_tbl,
>  	.pcs_misc_tbl_num	= ARRAY_SIZE(sdm845_qmp_pcie_pcs_misc_tbl),
> +	},
>  	.clk_list		= sdm845_pciephy_clk_l,
>  	.num_clks		= ARRAY_SIZE(sdm845_pciephy_clk_l),
>  	.reset_list		= sdm845_pciephy_reset_l,
> @@ -1637,6 +1644,7 @@ static const struct qmp_phy_cfg sdm845_qhp_pciephy_cfg = {
>  	.type = PHY_TYPE_PCIE,
>  	.nlanes = 1,
>  
> +	.primary = {
>  	.serdes_tbl		= sdm845_qhp_pcie_serdes_tbl,
>  	.serdes_tbl_num		= ARRAY_SIZE(sdm845_qhp_pcie_serdes_tbl),
>  	.tx_tbl			= sdm845_qhp_pcie_tx_tbl,
> @@ -1645,6 +1653,7 @@ static const struct qmp_phy_cfg sdm845_qhp_pciephy_cfg = {
>  	.rx_tbl_num		= ARRAY_SIZE(sdm845_qhp_pcie_rx_tbl),
>  	.pcs_tbl		= sdm845_qhp_pcie_pcs_tbl,
>  	.pcs_tbl_num		= ARRAY_SIZE(sdm845_qhp_pcie_pcs_tbl),
> +	},
>  	.clk_list		= sdm845_pciephy_clk_l,
>  	.num_clks		= ARRAY_SIZE(sdm845_pciephy_clk_l),
>  	.reset_list		= sdm845_pciephy_reset_l,
> @@ -1666,24 +1675,28 @@ static const struct qmp_phy_cfg sm8250_qmp_gen3x1_pciephy_cfg = {
>  	.type = PHY_TYPE_PCIE,
>  	.nlanes = 1,
>  
> +	.primary = {
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
> +	.secondary = {
> +	.serdes_tbl		= sm8250_qmp_gen3x1_pcie_serdes_tbl,
> +	.serdes_tbl_num		= ARRAY_SIZE(sm8250_qmp_gen3x1_pcie_serdes_tbl),
> +	.rx_tbl			= sm8250_qmp_gen3x1_pcie_rx_tbl,
> +	.rx_tbl_num		= ARRAY_SIZE(sm8250_qmp_gen3x1_pcie_rx_tbl),
> +	.pcs_tbl		= sm8250_qmp_gen3x1_pcie_pcs_tbl,
> +	.pcs_tbl_num		= ARRAY_SIZE(sm8250_qmp_gen3x1_pcie_pcs_tbl),
> +	.pcs_misc_tbl		= sm8250_qmp_gen3x1_pcie_pcs_misc_tbl,
> +	.pcs_misc_tbl_num	= ARRAY_SIZE(sm8250_qmp_gen3x1_pcie_pcs_misc_tbl),
> +	},
>  	.clk_list		= sdm845_pciephy_clk_l,
>  	.num_clks		= ARRAY_SIZE(sdm845_pciephy_clk_l),
>  	.reset_list		= sdm845_pciephy_reset_l,
> @@ -1705,24 +1718,28 @@ static const struct qmp_phy_cfg sm8250_qmp_gen3x2_pciephy_cfg = {
>  	.type = PHY_TYPE_PCIE,
>  	.nlanes = 2,
>  
> +	.primary = {
>  	.serdes_tbl		= sm8250_qmp_pcie_serdes_tbl,
>  	.serdes_tbl_num		= ARRAY_SIZE(sm8250_qmp_pcie_serdes_tbl),
>  	.tx_tbl			= sm8250_qmp_pcie_tx_tbl,
>  	.tx_tbl_num		= ARRAY_SIZE(sm8250_qmp_pcie_tx_tbl),
> -	.tx_tbl_sec		= sm8250_qmp_gen3x2_pcie_tx_tbl,
> -	.tx_tbl_num_sec		= ARRAY_SIZE(sm8250_qmp_gen3x2_pcie_tx_tbl),
>  	.rx_tbl			= sm8250_qmp_pcie_rx_tbl,
>  	.rx_tbl_num		= ARRAY_SIZE(sm8250_qmp_pcie_rx_tbl),
> -	.rx_tbl_sec		= sm8250_qmp_gen3x2_pcie_rx_tbl,
> -	.rx_tbl_num_sec		= ARRAY_SIZE(sm8250_qmp_gen3x2_pcie_rx_tbl),
>  	.pcs_tbl		= sm8250_qmp_pcie_pcs_tbl,
>  	.pcs_tbl_num		= ARRAY_SIZE(sm8250_qmp_pcie_pcs_tbl),
> -	.pcs_tbl_sec		= sm8250_qmp_gen3x2_pcie_pcs_tbl,
> -	.pcs_tbl_num_sec		= ARRAY_SIZE(sm8250_qmp_gen3x2_pcie_pcs_tbl),
>  	.pcs_misc_tbl		= sm8250_qmp_pcie_pcs_misc_tbl,
>  	.pcs_misc_tbl_num	= ARRAY_SIZE(sm8250_qmp_pcie_pcs_misc_tbl),
> -	.pcs_misc_tbl_sec		= sm8250_qmp_gen3x2_pcie_pcs_misc_tbl,
> -	.pcs_misc_tbl_num_sec	= ARRAY_SIZE(sm8250_qmp_gen3x2_pcie_pcs_misc_tbl),
> +	},
> +	.secondary = {
> +	.tx_tbl			= sm8250_qmp_gen3x2_pcie_tx_tbl,
> +	.tx_tbl_num		= ARRAY_SIZE(sm8250_qmp_gen3x2_pcie_tx_tbl),
> +	.rx_tbl			= sm8250_qmp_gen3x2_pcie_rx_tbl,
> +	.rx_tbl_num		= ARRAY_SIZE(sm8250_qmp_gen3x2_pcie_rx_tbl),
> +	.pcs_tbl		= sm8250_qmp_gen3x2_pcie_pcs_tbl,
> +	.pcs_tbl_num		= ARRAY_SIZE(sm8250_qmp_gen3x2_pcie_pcs_tbl),
> +	.pcs_misc_tbl		= sm8250_qmp_gen3x2_pcie_pcs_misc_tbl,
> +	.pcs_misc_tbl_num	= ARRAY_SIZE(sm8250_qmp_gen3x2_pcie_pcs_misc_tbl),
> +	},
>  	.clk_list		= sdm845_pciephy_clk_l,
>  	.num_clks		= ARRAY_SIZE(sdm845_pciephy_clk_l),
>  	.reset_list		= sdm845_pciephy_reset_l,
> @@ -1745,6 +1762,7 @@ static const struct qmp_phy_cfg msm8998_pciephy_cfg = {
>  	.type			= PHY_TYPE_PCIE,
>  	.nlanes			= 1,
>  
> +	.primary = {
>  	.serdes_tbl		= msm8998_pcie_serdes_tbl,
>  	.serdes_tbl_num		= ARRAY_SIZE(msm8998_pcie_serdes_tbl),
>  	.tx_tbl			= msm8998_pcie_tx_tbl,
> @@ -1753,6 +1771,7 @@ static const struct qmp_phy_cfg msm8998_pciephy_cfg = {
>  	.rx_tbl_num		= ARRAY_SIZE(msm8998_pcie_rx_tbl),
>  	.pcs_tbl		= msm8998_pcie_pcs_tbl,
>  	.pcs_tbl_num		= ARRAY_SIZE(msm8998_pcie_pcs_tbl),
> +	},
>  	.clk_list		= msm8996_phy_clk_l,
>  	.num_clks		= ARRAY_SIZE(msm8996_phy_clk_l),
>  	.reset_list		= ipq8074_pciephy_reset_l,
> @@ -1770,6 +1789,7 @@ static const struct qmp_phy_cfg sc8180x_pciephy_cfg = {
>  	.type = PHY_TYPE_PCIE,
>  	.nlanes = 1,
>  
> +	.primary = {
>  	.serdes_tbl		= sc8180x_qmp_pcie_serdes_tbl,
>  	.serdes_tbl_num		= ARRAY_SIZE(sc8180x_qmp_pcie_serdes_tbl),
>  	.tx_tbl			= sc8180x_qmp_pcie_tx_tbl,
> @@ -1780,6 +1800,7 @@ static const struct qmp_phy_cfg sc8180x_pciephy_cfg = {
>  	.pcs_tbl_num		= ARRAY_SIZE(sc8180x_qmp_pcie_pcs_tbl),
>  	.pcs_misc_tbl		= sc8180x_qmp_pcie_pcs_misc_tbl,
>  	.pcs_misc_tbl_num	= ARRAY_SIZE(sc8180x_qmp_pcie_pcs_misc_tbl),
> +	},
>  	.clk_list		= sdm845_pciephy_clk_l,
>  	.num_clks		= ARRAY_SIZE(sdm845_pciephy_clk_l),
>  	.reset_list		= sdm845_pciephy_reset_l,
> @@ -1800,6 +1821,7 @@ static const struct qmp_phy_cfg sdx55_qmp_pciephy_cfg = {
>  	.type = PHY_TYPE_PCIE,
>  	.nlanes = 2,
>  
> +	.primary = {
>  	.serdes_tbl		= sdx55_qmp_pcie_serdes_tbl,
>  	.serdes_tbl_num		= ARRAY_SIZE(sdx55_qmp_pcie_serdes_tbl),
>  	.tx_tbl			= sdx55_qmp_pcie_tx_tbl,
> @@ -1810,6 +1832,7 @@ static const struct qmp_phy_cfg sdx55_qmp_pciephy_cfg = {
>  	.pcs_tbl_num		= ARRAY_SIZE(sdx55_qmp_pcie_pcs_tbl),
>  	.pcs_misc_tbl		= sdx55_qmp_pcie_pcs_misc_tbl,
>  	.pcs_misc_tbl_num	= ARRAY_SIZE(sdx55_qmp_pcie_pcs_misc_tbl),
> +	},
>  	.clk_list		= sdm845_pciephy_clk_l,
>  	.num_clks		= ARRAY_SIZE(sdm845_pciephy_clk_l),
>  	.reset_list		= sdm845_pciephy_reset_l,
> @@ -1832,6 +1855,7 @@ static const struct qmp_phy_cfg sm8450_qmp_gen3x1_pciephy_cfg = {
>  	.type = PHY_TYPE_PCIE,
>  	.nlanes = 1,
>  
> +	.primary = {
>  	.serdes_tbl		= sm8450_qmp_gen3x1_pcie_serdes_tbl,
>  	.serdes_tbl_num		= ARRAY_SIZE(sm8450_qmp_gen3x1_pcie_serdes_tbl),
>  	.tx_tbl			= sm8450_qmp_gen3x1_pcie_tx_tbl,
> @@ -1842,6 +1866,7 @@ static const struct qmp_phy_cfg sm8450_qmp_gen3x1_pciephy_cfg = {
>  	.pcs_tbl_num		= ARRAY_SIZE(sm8450_qmp_gen3x1_pcie_pcs_tbl),
>  	.pcs_misc_tbl		= sm8450_qmp_gen3x1_pcie_pcs_misc_tbl,
>  	.pcs_misc_tbl_num	= ARRAY_SIZE(sm8450_qmp_gen3x1_pcie_pcs_misc_tbl),
> +	},
>  	.clk_list		= sdm845_pciephy_clk_l,
>  	.num_clks		= ARRAY_SIZE(sdm845_pciephy_clk_l),
>  	.reset_list		= sdm845_pciephy_reset_l,
> @@ -1863,6 +1888,7 @@ static const struct qmp_phy_cfg sm8450_qmp_gen4x2_pciephy_cfg = {
>  	.type = PHY_TYPE_PCIE,
>  	.nlanes = 2,
>  
> +	.primary = {
>  	.serdes_tbl		= sm8450_qmp_gen4x2_pcie_serdes_tbl,
>  	.serdes_tbl_num		= ARRAY_SIZE(sm8450_qmp_gen4x2_pcie_serdes_tbl),
>  	.tx_tbl			= sm8450_qmp_gen4x2_pcie_tx_tbl,
> @@ -1873,6 +1899,7 @@ static const struct qmp_phy_cfg sm8450_qmp_gen4x2_pciephy_cfg = {
>  	.pcs_tbl_num		= ARRAY_SIZE(sm8450_qmp_gen4x2_pcie_pcs_tbl),
>  	.pcs_misc_tbl		= sm8450_qmp_gen4x2_pcie_pcs_misc_tbl,
>  	.pcs_misc_tbl_num	= ARRAY_SIZE(sm8450_qmp_gen4x2_pcie_pcs_misc_tbl),
> +	},
>  	.clk_list		= sdm845_pciephy_clk_l,
>  	.num_clks		= ARRAY_SIZE(sdm845_pciephy_clk_l),
>  	.reset_list		= sdm845_pciephy_reset_l,
> @@ -1926,13 +1953,9 @@ static int qcom_qmp_phy_pcie_serdes_init(struct qmp_phy *qphy)
>  {
>  	const struct qmp_phy_cfg *cfg = qphy->cfg;
>  	void __iomem *serdes = qphy->serdes;
> -	const struct qmp_phy_init_tbl *serdes_tbl = cfg->serdes_tbl;
> -	int serdes_tbl_num = cfg->serdes_tbl_num;
>  
> -	qcom_qmp_phy_pcie_configure(serdes, cfg->regs, serdes_tbl, serdes_tbl_num);
> -	if (cfg->serdes_tbl_sec)
> -		qcom_qmp_phy_pcie_configure(serdes, cfg->regs, cfg->serdes_tbl_sec,
> -				       cfg->serdes_tbl_num_sec);
> +	qcom_qmp_phy_pcie_configure(serdes, cfg->regs, cfg->primary.serdes_tbl, cfg->primary.serdes_tbl_num);
> +	qcom_qmp_phy_pcie_configure(serdes, cfg->regs, cfg->secondary.serdes_tbl, cfg->secondary.serdes_tbl_num);
>  
>  	return 0;
>  }
> @@ -2036,46 +2059,41 @@ static int qcom_qmp_phy_pcie_power_on(struct phy *phy)
>  
>  	/* Tx, Rx, and PCS configurations */
>  	qcom_qmp_phy_pcie_configure_lane(tx, cfg->regs,
> -				    cfg->tx_tbl, cfg->tx_tbl_num, 1);
> -	if (cfg->tx_tbl_sec)
> -		qcom_qmp_phy_pcie_configure_lane(tx, cfg->regs, cfg->tx_tbl_sec,
> -					    cfg->tx_tbl_num_sec, 1);
> +					 cfg->primary.tx_tbl, cfg->primary.tx_tbl_num, 1);
> +	qcom_qmp_phy_pcie_configure_lane(tx, cfg->regs,
> +					 cfg->secondary.tx_tbl, cfg->secondary.tx_tbl_num, 1);
>  
>  	/* Configuration for other LANE for USB-DP combo PHY */
>  	if (cfg->is_dual_lane_phy) {
>  		qcom_qmp_phy_pcie_configure_lane(qphy->tx2, cfg->regs,
> -					    cfg->tx_tbl, cfg->tx_tbl_num, 2);
> -		if (cfg->tx_tbl_sec)
> -			qcom_qmp_phy_pcie_configure_lane(qphy->tx2, cfg->regs,
> -						    cfg->tx_tbl_sec,
> -						    cfg->tx_tbl_num_sec, 2);
> +						 cfg->primary.tx_tbl, cfg->primary.tx_tbl_num, 2);
> +		qcom_qmp_phy_pcie_configure_lane(qphy->tx2, cfg->regs,
> +						 cfg->secondary.tx_tbl, cfg->secondary.tx_tbl_num, 2);
>  	}
>  
>  	qcom_qmp_phy_pcie_configure_lane(rx, cfg->regs,
> -				    cfg->rx_tbl, cfg->rx_tbl_num, 1);
> -	if (cfg->rx_tbl_sec)
> -		qcom_qmp_phy_pcie_configure_lane(rx, cfg->regs,
> -					    cfg->rx_tbl_sec, cfg->rx_tbl_num_sec, 1);
> +					 cfg->primary.rx_tbl, cfg->primary.rx_tbl_num, 1);
> +	qcom_qmp_phy_pcie_configure_lane(rx, cfg->regs,
> +					 cfg->secondary.rx_tbl, cfg->secondary.rx_tbl_num, 1);
>  
>  	if (cfg->is_dual_lane_phy) {
>  		qcom_qmp_phy_pcie_configure_lane(qphy->rx2, cfg->regs,
> -					    cfg->rx_tbl, cfg->rx_tbl_num, 2);
> -		if (cfg->rx_tbl_sec)
> -			qcom_qmp_phy_pcie_configure_lane(qphy->rx2, cfg->regs,
> -						    cfg->rx_tbl_sec,
> -						    cfg->rx_tbl_num_sec, 2);
> +						 cfg->primary.rx_tbl, cfg->primary.rx_tbl_num, 2);
> +		qcom_qmp_phy_pcie_configure_lane(qphy->rx2, cfg->regs,
> +						 cfg->secondary.rx_tbl, cfg->secondary.rx_tbl_num, 2);
>  	}
>  
> -	qcom_qmp_phy_pcie_configure(pcs, cfg->regs, cfg->pcs_tbl, cfg->pcs_tbl_num);
> -	if (cfg->pcs_tbl_sec)
> -		qcom_qmp_phy_pcie_configure(pcs, cfg->regs, cfg->pcs_tbl_sec,
> -				       cfg->pcs_tbl_num_sec);
> -
> -	qcom_qmp_phy_pcie_configure(pcs_misc, cfg->regs, cfg->pcs_misc_tbl,
> -			       cfg->pcs_misc_tbl_num);
> -	if (cfg->pcs_misc_tbl_sec)
> -		qcom_qmp_phy_pcie_configure(pcs_misc, cfg->regs, cfg->pcs_misc_tbl_sec,
> -				       cfg->pcs_misc_tbl_num_sec);
> +	qcom_qmp_phy_pcie_configure(pcs, cfg->regs,
> +				    cfg->primary.pcs_tbl, cfg->primary.pcs_tbl_num);
> +	qcom_qmp_phy_pcie_configure(pcs, cfg->regs,
> +				    cfg->secondary.pcs_tbl, cfg->secondary.pcs_tbl_num);
> +
> +	qcom_qmp_phy_pcie_configure(pcs_misc, cfg->regs,
> +				    cfg->primary.pcs_misc_tbl,
> +				    cfg->primary.pcs_misc_tbl_num);
> +	qcom_qmp_phy_pcie_configure(pcs_misc, cfg->regs,
> +				    cfg->secondary.pcs_misc_tbl,
> +				    cfg->secondary.pcs_misc_tbl_num);
>  
>  	/*
>  	 * Pull out PHY from POWER DOWN state.
> -- 
> 2.35.1
> 

-- 
மணிவண்ணன் சதாசிவம்
