Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACBBF59FD9F
	for <lists+linux-pci@lfdr.de>; Wed, 24 Aug 2022 16:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236086AbiHXO5S (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Aug 2022 10:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232675AbiHXO5R (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Aug 2022 10:57:17 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 500AC8992F
        for <linux-pci@vger.kernel.org>; Wed, 24 Aug 2022 07:57:13 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id 67so8538950pfv.2
        for <linux-pci@vger.kernel.org>; Wed, 24 Aug 2022 07:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=gM8GDsnSJOMAUUVJW4tlaybgNtw+UEw7QquIVT86FWw=;
        b=v/UJZUPVd4nDpRPhfiY1BBHYgSiRAyUwSShdy2Y6czy8s8BTWdM7z146eCVCC2Rb2u
         sw6mK0mOFMAzD9JnVP2jDy3hjORVSb5/kmH5h0mndFSr9cTNXQysQ+KJym3TrD32PfK2
         +4x3uldeAdEN9rc5SovE7poXTcKV/8T4SnEWnLviqAfsINw/xbKDZ2yfDLO+l5Pzrh9G
         +VOML6Q04aY/JHoRuL7t5fMy8tKHe+tyBzmxL1G/fOHKyGq7eFkl/mrKCr3J2amnKMaZ
         gvFkhEHmaSStHUyKLL5q1ASztFgqtDb/cPK7VeCpuqjyKVsfdnSQcQq0XNb5wypnjugx
         G1fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=gM8GDsnSJOMAUUVJW4tlaybgNtw+UEw7QquIVT86FWw=;
        b=DysHopctGZNw83SbhMrnI0hU0yAE4DuHoOq1/dVMY0sgPlGtVstYE0la5y7RsVPKfX
         JZPvpk+ODanCaC6XOWWonSE1mrGaPkLbigQp2i1+vaOACcTloE9lBSZRonEWWh2fZYZ3
         ZU3du/skhy4s9oE2otrDcy8PxmfC4sFBP8n6wuuLnTVq93J55yRr8N/uU/vVRvj/NoWW
         4GEr2fjIzwWVKu5AOw2Wfi4/DcT9/TvbcMfzj1/nobBGph89uaU9PDx3V/4KaT4CSZVv
         e/+ewJhJjmg7XvbGbFqWZcuILSBJcvnmAJM5hOKW7TJZeWAn5QwC7kP1VYNnv7xngMkz
         o+Hw==
X-Gm-Message-State: ACgBeo2o4ZzTEEAL0ztptrKAIWfvCNd+Ypdz0pxSn5vKvzyl6JEz5xWq
        qPCsW0dY8Lor6TmnWgAfpCv6
X-Google-Smtp-Source: AA6agR7Ib04+xtPrgNHPwibV1BLIrGmMzfP42SM9GUxtmSCoMT+DDemE1rbAJPOmPKHjsfv+ijTy1g==
X-Received: by 2002:a63:e102:0:b0:41b:3901:990e with SMTP id z2-20020a63e102000000b0041b3901990emr24292701pgh.107.1661353032690;
        Wed, 24 Aug 2022 07:57:12 -0700 (PDT)
Received: from thinkpad ([117.207.24.28])
        by smtp.gmail.com with ESMTPSA id j13-20020a170902da8d00b0017284f4a10esm5588128plx.227.2022.08.24.07.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 07:57:12 -0700 (PDT)
Date:   Wed, 24 Aug 2022 20:27:02 +0530
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
Subject: Re: [PATCH v1 2/4] phy: qcom-qmp-pcie: support separate tables for
 EP mode
Message-ID: <20220824145702.GE4767@thinkpad>
References: <20220726203401.595934-1-dmitry.baryshkov@linaro.org>
 <20220726203401.595934-3-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220726203401.595934-3-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 26, 2022 at 11:33:59PM +0300, Dmitry Baryshkov wrote:
> The PCIe QMP PHY requires different programming sequences when being
> used for the RC (Root Complex) or for the EP (End Point) modes. Allow
> selecting the submode and thus selecting a set of PHY programming
> tables.
> 

I think you should mention why secondary table is used for differentiating
between RC and EP mode. Something like,

Since the RC and EP modes share common some common init sequence, the common
sequence is kept in the primary table and the different ones were in secondary.

> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 41 ++++++++++++++++--------
>  1 file changed, 28 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> index e6272bd3d735..af3577a5d7e4 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> @@ -1369,10 +1369,14 @@ struct qmp_phy_cfg {
>  	/* Init sequence for PHY blocks - serdes, tx, rx, pcs */
>  	struct qmp_phy_cfg_tables primary;
>  	/*
> -	 * Init sequence for PHY blocks, providing additional register
> -	 * programming. Unless required it can be left omitted.
> +	 * Init sequences for PHY blocks, providing additional register
> +	 * programming. They are used for providing separate sequences for the
> +	 * Root Complex and for the End Point usecases.
> +	 *
> +	 * If EP mode is not supported, both tables can be left empty.
>  	 */
> -	struct qmp_phy_cfg_tables secondary;
> +	struct qmp_phy_cfg_tables secondary_rc; /* for the RC only */
> +	struct qmp_phy_cfg_tables secondary_ep; /* for the EP only */
>  
>  	/* clock ids to be requested */
>  	const char * const *clk_list;
> @@ -1422,6 +1426,7 @@ struct qmp_phy_cfg {
>   * @index: lane index
>   * @qmp: QMP phy to which this lane belongs
>   * @mode: current PHY mode
> + * @secondary: currently selected PHY secondary init table set
>   */
>  struct qmp_phy {
>  	struct phy *phy;
> @@ -1434,6 +1439,7 @@ struct qmp_phy {
>  	void __iomem *rx2;
>  	void __iomem *pcs_misc;
>  	struct clk *pipe_clk;
> +	const struct qmp_phy_cfg_tables *secondary;
>  	unsigned int index;
>  	struct qcom_qmp *qmp;
>  	enum phy_mode mode;
> @@ -1687,7 +1693,7 @@ static const struct qmp_phy_cfg sm8250_qmp_gen3x1_pciephy_cfg = {
>  	.pcs_misc_tbl		= sm8250_qmp_pcie_pcs_misc_tbl,
>  	.pcs_misc_tbl_num	= ARRAY_SIZE(sm8250_qmp_pcie_pcs_misc_tbl),
>  	},
> -	.secondary = {
> +	.secondary_rc = {
>  	.serdes_tbl		= sm8250_qmp_gen3x1_pcie_serdes_tbl,
>  	.serdes_tbl_num		= ARRAY_SIZE(sm8250_qmp_gen3x1_pcie_serdes_tbl),
>  	.rx_tbl			= sm8250_qmp_gen3x1_pcie_rx_tbl,
> @@ -1730,7 +1736,7 @@ static const struct qmp_phy_cfg sm8250_qmp_gen3x2_pciephy_cfg = {
>  	.pcs_misc_tbl		= sm8250_qmp_pcie_pcs_misc_tbl,
>  	.pcs_misc_tbl_num	= ARRAY_SIZE(sm8250_qmp_pcie_pcs_misc_tbl),
>  	},
> -	.secondary = {
> +	.secondary_rc = {
>  	.tx_tbl			= sm8250_qmp_gen3x2_pcie_tx_tbl,
>  	.tx_tbl_num		= ARRAY_SIZE(sm8250_qmp_gen3x2_pcie_tx_tbl),
>  	.rx_tbl			= sm8250_qmp_gen3x2_pcie_rx_tbl,
> @@ -1955,7 +1961,7 @@ static int qcom_qmp_phy_pcie_serdes_init(struct qmp_phy *qphy)
>  	void __iomem *serdes = qphy->serdes;
>  
>  	qcom_qmp_phy_pcie_configure(serdes, cfg->regs, cfg->primary.serdes_tbl, cfg->primary.serdes_tbl_num);
> -	qcom_qmp_phy_pcie_configure(serdes, cfg->regs, cfg->secondary.serdes_tbl, cfg->secondary.serdes_tbl_num);
> +	qcom_qmp_phy_pcie_configure(serdes, cfg->regs, qphy->secondary->serdes_tbl, qphy->secondary->serdes_tbl_num);
>  
>  	return 0;
>  }
> @@ -2049,6 +2055,10 @@ static int qcom_qmp_phy_pcie_power_on(struct phy *phy)
>  	unsigned int mask, val, ready;
>  	int ret;
>  
> +	/* Default to RC mode if no mode was selected */

While the comment is fine, I think it'd be good if you mention that the mode was
not selected using set_mode() API.

Thanks,
Mani

-- 
மணிவண்ணன் சதாசிவம்
