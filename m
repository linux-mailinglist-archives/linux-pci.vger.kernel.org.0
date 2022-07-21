Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 023AA57C884
	for <lists+linux-pci@lfdr.de>; Thu, 21 Jul 2022 12:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233028AbiGUKEJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Jul 2022 06:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233045AbiGUKED (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Jul 2022 06:04:03 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 642C027B0A
        for <linux-pci@vger.kernel.org>; Thu, 21 Jul 2022 03:04:02 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id p8so1323454plq.13
        for <linux-pci@vger.kernel.org>; Thu, 21 Jul 2022 03:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=k2cfPwM4F8MRG16OVbwN5qbYqMkFUntciq+TeBCrGDw=;
        b=xn1hFsp+rwVt8rSkdOTGbbWXiQRceoZzibnj/20NRMiIyicNBeZuHqd5BMXWw4Amwg
         qGeaB0+qOl8xhuPq+JGxDj16XbYYMeovfEMAtfN180AMBXOqTE6djezZ5mA7b6ZcgmVM
         jUlojxG84UW7A7dmaLA3Jr/LwZnZ8Vzc1sDr4ngmKdCHjXHM7qlbmfOGe1ev4k9sHDDj
         DSdlk7nxjZXiq5TLIxAZCo1jbWSaFmQltpYyfqnTLXYhdfR1jr7GHTLZWe66UMX0dkSX
         CoagdFmUK+J9WM/vg+Jc7rvFtK6PQ6MJrqrSAq0BJCK8PKof8NRK+ZXKJToB3BtqcA2+
         nQ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=k2cfPwM4F8MRG16OVbwN5qbYqMkFUntciq+TeBCrGDw=;
        b=wymiXdOKDMXBdRuujDv/7ji26x9//Nn/gdEdY1Bj6Z9SQIcpsvXIT2zCAo9RiLF6tr
         i3XVKGYmssk6sHwoqKSG3HavqzUnhW+p6CRiou8CPdWGcd9jJ73SiaWGLXtw8hh45KeB
         1K5+izJsONms4uag8DNKBWuQtND8Tg9+QVgNSfqOCiC/40H+lyq9EVUzOvHBZ5iRodea
         eCyn46Awrkc6hBY2C4rcKJB0S0E1ozbPJlyeLgDFa3YjcDtmGbXtVW3hsaXrGpdPtr5v
         HzsSQUayKl0NI40DSyJ2zlsEwYtub7WoSJxHNS8i0H9QZSgE2hI6TvQzhKkyP4oYEvWD
         xxbA==
X-Gm-Message-State: AJIora8JB4S8CDo0pjBuSXVIGY0+R3uBSlSuwCQgAqjyu3Br0/2xE9/X
        g2eVFqb+taE5K3J4P5n0HhDe
X-Google-Smtp-Source: AGRyM1sWdnzwXT+3f8ffMpQ35lw1gPgPdgjyWLnWiaWwz/hbcnb7Zjs075w009E5GTau5fJJAnrLpA==
X-Received: by 2002:a17:90a:7c05:b0:1ee:e40c:589b with SMTP id v5-20020a17090a7c0500b001eee40c589bmr10549539pjf.78.1658397841781;
        Thu, 21 Jul 2022 03:04:01 -0700 (PDT)
Received: from thinkpad ([117.217.186.184])
        by smtp.gmail.com with ESMTPSA id u124-20020a627982000000b0052b4f4c6a8fsm1295424pfc.209.2022.07.21.03.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 03:04:01 -0700 (PDT)
Date:   Thu, 21 Jul 2022 15:33:53 +0530
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
Subject: Re: [RFC PATCH 2/4] phy: qcom-qmp-pcie: suppor separate tables for
 EP mode
Message-ID: <20220721100353.GB39125@thinkpad>
References: <20220719200626.976084-1-dmitry.baryshkov@linaro.org>
 <20220719200626.976084-3-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220719200626.976084-3-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

s/suppor/support

On Tue, Jul 19, 2022 at 11:06:24PM +0300, Dmitry Baryshkov wrote:
> The PCIe QMP PHY requires different programming sequences when being
> used for the RC (Root Complex) or for the EP (End Point) modes. Allow
> selecting the submode and thus selecting a set of PHY programming
> tables.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 33 ++++++++++++++++--------
>  1 file changed, 22 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> index 23ca5848c4a8..898288c1cd7d 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> @@ -1368,7 +1368,8 @@ struct qmp_phy_cfg {
>  
>  	/* Init sequence for PHY blocks - serdes, tx, rx, pcs */
>  	struct qmp_phy_cfg_tables pri;
> -	struct qmp_phy_cfg_tables sec;
> +	struct qmp_phy_cfg_tables sec_rc; /* for the RC only */
> +	struct qmp_phy_cfg_tables sec_ep; /* for the EP only */

Again, a comment is needed for these members.

>  
>  	/* clock ids to be requested */
>  	const char * const *clk_list;
> @@ -1418,6 +1419,7 @@ struct qmp_phy_cfg {
>   * @index: lane index
>   * @qmp: QMP phy to which this lane belongs
>   * @mode: current PHY mode
> + * @sec: currently selected PHY init table set
>   */
>  struct qmp_phy {
>  	struct phy *phy;
> @@ -1433,6 +1435,7 @@ struct qmp_phy {
>  	unsigned int index;
>  	struct qcom_qmp *qmp;
>  	enum phy_mode mode;
> +	const struct qmp_phy_cfg_tables *sec;

Please move the pointer to the top to avoid holes. If possible organize the
members in a pattern:

ptr
struct
enum
u64
u32
u8

>  };
>  
>  /**
> @@ -1683,7 +1686,7 @@ static const struct qmp_phy_cfg sm8250_qmp_gen3x1_pciephy_cfg = {
>  	.pcs_misc_tbl		= sm8250_qmp_pcie_pcs_misc_tbl,
>  	.pcs_misc_tbl_num	= ARRAY_SIZE(sm8250_qmp_pcie_pcs_misc_tbl),
>  	},
> -	.sec = {
> +	.sec_rc = {
>  	.serdes_tbl		= sm8250_qmp_gen3x1_pcie_serdes_tbl,
>  	.serdes_tbl_num		= ARRAY_SIZE(sm8250_qmp_gen3x1_pcie_serdes_tbl),
>  	.rx_tbl			= sm8250_qmp_gen3x1_pcie_rx_tbl,
> @@ -1726,7 +1729,7 @@ static const struct qmp_phy_cfg sm8250_qmp_gen3x2_pciephy_cfg = {
>  	.pcs_misc_tbl		= sm8250_qmp_pcie_pcs_misc_tbl,
>  	.pcs_misc_tbl_num	= ARRAY_SIZE(sm8250_qmp_pcie_pcs_misc_tbl),
>  	},
> -	.sec = {
> +	.sec_rc = {
>  	.tx_tbl			= sm8250_qmp_gen3x2_pcie_tx_tbl,
>  	.tx_tbl_num		= ARRAY_SIZE(sm8250_qmp_gen3x2_pcie_tx_tbl),
>  	.rx_tbl			= sm8250_qmp_gen3x2_pcie_rx_tbl,
> @@ -1951,7 +1954,7 @@ static int qcom_qmp_phy_pcie_serdes_init(struct qmp_phy *qphy)
>  	void __iomem *serdes = qphy->serdes;
>  
>  	qcom_qmp_phy_pcie_configure(serdes, cfg->regs, cfg->pri.serdes_tbl, cfg->pri.serdes_tbl_num);
> -	qcom_qmp_phy_pcie_configure(serdes, cfg->regs, cfg->sec.serdes_tbl, cfg->sec.serdes_tbl_num);
> +	qcom_qmp_phy_pcie_configure(serdes, cfg->regs, qphy->sec->serdes_tbl, qphy->sec->serdes_tbl_num);
>  
>  	return 0;
>  }
> @@ -2045,6 +2048,9 @@ static int qcom_qmp_phy_pcie_power_on(struct phy *phy)
>  	unsigned int mask, val, ready;
>  	int ret;
>  

Here also, a comment would add a value.

Thanks,
Mani

> +	if (!qphy->sec)
> +		qphy->sec = &cfg->sec_rc;
> +
>  	qcom_qmp_phy_pcie_serdes_init(qphy);
>  
>  	ret = clk_prepare_enable(qphy->pipe_clk);
> @@ -2057,35 +2063,35 @@ static int qcom_qmp_phy_pcie_power_on(struct phy *phy)
>  	qcom_qmp_phy_pcie_configure_lane(tx, cfg->regs,
>  					 cfg->pri.tx_tbl, cfg->pri.tx_tbl_num, 1);
>  	qcom_qmp_phy_pcie_configure_lane(tx, cfg->regs,
> -					 cfg->sec.tx_tbl, cfg->sec.tx_tbl_num, 1);
> +					 qphy->sec->tx_tbl, qphy->sec->tx_tbl_num, 1);
>  
>  	/* Configuration for other LANE for USB-DP combo PHY */
>  	if (cfg->is_dual_lane_phy) {
>  		qcom_qmp_phy_pcie_configure_lane(qphy->tx2, cfg->regs,
>  						 cfg->pri.tx_tbl, cfg->pri.tx_tbl_num, 2);
>  		qcom_qmp_phy_pcie_configure_lane(qphy->tx2, cfg->regs,
> -						 cfg->sec.tx_tbl, cfg->sec.tx_tbl_num, 2);
> +						 qphy->sec->tx_tbl, qphy->sec->tx_tbl_num, 2);
>  	}
>  
>  	qcom_qmp_phy_pcie_configure_lane(rx, cfg->regs,
>  					 cfg->pri.rx_tbl, cfg->pri.rx_tbl_num, 1);
>  	qcom_qmp_phy_pcie_configure_lane(rx, cfg->regs,
> -					 cfg->sec.rx_tbl, cfg->sec.rx_tbl_num, 1);
> +					 qphy->sec->rx_tbl, qphy->sec->rx_tbl_num, 1);
>  
>  	if (cfg->is_dual_lane_phy) {
>  		qcom_qmp_phy_pcie_configure_lane(qphy->rx2, cfg->regs,
>  						 cfg->pri.rx_tbl, cfg->pri.rx_tbl_num, 2);
>  		qcom_qmp_phy_pcie_configure_lane(qphy->rx2, cfg->regs,
> -						 cfg->sec.rx_tbl, cfg->sec.rx_tbl_num, 2);
> +						 qphy->sec->rx_tbl, qphy->sec->rx_tbl_num, 2);
>  	}
>  
>  	qcom_qmp_phy_pcie_configure(pcs, cfg->regs, cfg->pri.pcs_tbl, cfg->pri.pcs_tbl_num);
> -	qcom_qmp_phy_pcie_configure(pcs, cfg->regs, cfg->sec.pcs_tbl, cfg->sec.pcs_tbl_num);
> +	qcom_qmp_phy_pcie_configure(pcs, cfg->regs, qphy->sec->pcs_tbl, qphy->sec->pcs_tbl_num);
>  
>  	qcom_qmp_phy_pcie_configure(pcs_misc, cfg->regs, cfg->pri.pcs_misc_tbl,
>  			       cfg->pri.pcs_misc_tbl_num);
> -	qcom_qmp_phy_pcie_configure(pcs_misc, cfg->regs, cfg->sec.pcs_misc_tbl,
> -			       cfg->sec.pcs_misc_tbl_num);
> +	qcom_qmp_phy_pcie_configure(pcs_misc, cfg->regs, qphy->sec->pcs_misc_tbl,
> +			       qphy->sec->pcs_misc_tbl_num);
>  
>  	/*
>  	 * Pull out PHY from POWER DOWN state.
> @@ -2187,6 +2193,11 @@ static int qcom_qmp_phy_pcie_set_mode(struct phy *phy,
>  
>  	qphy->mode = mode;
>  
> +	if (submode)
> +		qphy->sec = &qphy->cfg->sec_ep;
> +	else
> +		qphy->sec = &qphy->cfg->sec_rc;
> +
>  	return 0;
>  }
>  
> -- 
> 2.35.1
> 

-- 
மணிவண்ணன் சதாசிவம்
