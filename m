Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A82757C81F
	for <lists+linux-pci@lfdr.de>; Thu, 21 Jul 2022 11:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbiGUJvt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Jul 2022 05:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbiGUJvs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Jul 2022 05:51:48 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48B4281B0C
        for <linux-pci@vger.kernel.org>; Thu, 21 Jul 2022 02:51:47 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id b7-20020a17090a12c700b001f20eb82a08so4710528pjg.3
        for <linux-pci@vger.kernel.org>; Thu, 21 Jul 2022 02:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=pYsFxEwlYxynVfVxm5SBHihSt1BpFABNIazF2FM2xIs=;
        b=YMPOHee40dc8Hl4yCgMwTKkXjz/59/tafF7A6+tgkIrPM7ACbrnKbahKY7PtUrgprH
         eU0hZvRCT812tpVASUTVdFWqIfFPSU0vQ8xZygngKcnCkAu20XBHlvPZVA9IfcUAbdfr
         fhw0E7Ld3koNhjxGdZclGpzNX50rq4VO4RHcP3iZDo1WLhphU7KqsFaHvrmiVvtuz5jW
         q51v4AVVvsn+tqu4Cs/2BShiVj4GwLig5/MjM10CbfXFEKinvCg5Jvq1GBw8dbaVeOmm
         ieieOeFu9dpXH9Zf1GDkKY9KPuD0Y23Fz4wBdW0foS97ZyjbveNZcuZCCoZ1UZ7u7XoU
         RxLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=pYsFxEwlYxynVfVxm5SBHihSt1BpFABNIazF2FM2xIs=;
        b=08CQT5cKOCVQP5t/IdrGG9w+/haQkUNTD0eNw8GspJqAZYmbkq7KQKd6o6HdUXsOtf
         72G4Qpu56Blb5z+tpVs9RrLHNd/hrTw4/jWZBkPbJW2ShwhaqYw/BVFQTCNqvN3xkWCV
         qMc0P+ElLKc1ZT8usrgzSbsuOFcRqXBP10ADQ8PS5aIjWhaLhkomZp6Nvp70MdMGrrnu
         yD/zckfAr+4lc3XR4H/VlXbZT9h6zjEIbM0jt9XLb0jTR64MFuhjoqn34GSrnWHd4tNB
         V4c4+nCRufkbmR17lV00DkU9vhACqglnoQazi6kBqbx0rPvjPhoqQr/WsblgpN1jBfT+
         ECeg==
X-Gm-Message-State: AJIora+6GS/EpC1BhmiQcI10ajWDVpE8CGK+jYoCRX28GWthjv9E/nGm
        d9ajAQ+J7ylwbIV5xJBIfIqI
X-Google-Smtp-Source: AGRyM1vViNABPBg5mX7xAFZnzBQOkN1zCORJe+nEeGcE7OsHUgo1rzzH0pqbYyHZ9b+y+bRkSUJ6Xg==
X-Received: by 2002:a17:902:f68c:b0:16c:4eb6:913c with SMTP id l12-20020a170902f68c00b0016c4eb6913cmr42386524plg.2.1658397106639;
        Thu, 21 Jul 2022 02:51:46 -0700 (PDT)
Received: from thinkpad ([117.217.186.184])
        by smtp.gmail.com with ESMTPSA id t18-20020a170902d15200b0016c304612a0sm1161876plt.292.2022.07.21.02.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 02:51:46 -0700 (PDT)
Date:   Thu, 21 Jul 2022 15:21:40 +0530
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
Subject: Re: [RFC PATCH 1/4] phy: qcom-qmp-pcie: split register tables into
 primary and secondary part
Message-ID: <20220721095140.GA39125@thinkpad>
References: <20220719200626.976084-1-dmitry.baryshkov@linaro.org>
 <20220719200626.976084-2-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220719200626.976084-2-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 19, 2022 at 11:06:23PM +0300, Dmitry Baryshkov wrote:
> Split register tables list into primary and secondary parts. While we
> are at it, drop unused if (table) conditions, since the function
> qcom_qmp_phy_pcie_configure_lane() has this check anyway.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 144 ++++++++++++-----------
>  1 file changed, 77 insertions(+), 67 deletions(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> index 2d65e1f56bfc..23ca5848c4a8 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> @@ -1346,34 +1346,29 @@ static const struct qmp_phy_init_tbl sm8450_qmp_gen4x2_pcie_pcs_misc_tbl[] = {
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
> +	struct qmp_phy_cfg_tables pri;

s/pri/primary/g

> +	struct qmp_phy_cfg_tables sec;

s/sec/secondary/g

I think it'd be good to add a comment on what the secondary table represents.
This will help folks trying to port the downstream drivers.

Rest LGTM!

Thanks,
Mani

>  
>  	/* clock ids to be requested */
>  	const char * const *clk_list;
> @@ -1517,6 +1512,7 @@ static const struct qmp_phy_cfg ipq8074_pciephy_cfg = {
>  	.type			= PHY_TYPE_PCIE,
>  	.nlanes			= 1,
>  
> +	.pri = {
>  	.serdes_tbl		= ipq8074_pcie_serdes_tbl,
>  	.serdes_tbl_num		= ARRAY_SIZE(ipq8074_pcie_serdes_tbl),
>  	.tx_tbl			= ipq8074_pcie_tx_tbl,
> @@ -1525,6 +1521,7 @@ static const struct qmp_phy_cfg ipq8074_pciephy_cfg = {
>  	.rx_tbl_num		= ARRAY_SIZE(ipq8074_pcie_rx_tbl),
>  	.pcs_tbl		= ipq8074_pcie_pcs_tbl,
>  	.pcs_tbl_num		= ARRAY_SIZE(ipq8074_pcie_pcs_tbl),
> +	},
>  	.clk_list		= ipq8074_pciephy_clk_l,
>  	.num_clks		= ARRAY_SIZE(ipq8074_pciephy_clk_l),
>  	.reset_list		= ipq8074_pciephy_reset_l,
> @@ -1546,6 +1543,7 @@ static const struct qmp_phy_cfg ipq8074_pciephy_gen3_cfg = {
>  	.type			= PHY_TYPE_PCIE,
>  	.nlanes			= 1,
>  
> +	.pri = {
>  	.serdes_tbl		= ipq8074_pcie_gen3_serdes_tbl,
>  	.serdes_tbl_num		= ARRAY_SIZE(ipq8074_pcie_gen3_serdes_tbl),
>  	.tx_tbl			= ipq8074_pcie_gen3_tx_tbl,
> @@ -1554,6 +1552,7 @@ static const struct qmp_phy_cfg ipq8074_pciephy_gen3_cfg = {
>  	.rx_tbl_num		= ARRAY_SIZE(ipq8074_pcie_gen3_rx_tbl),
>  	.pcs_tbl		= ipq8074_pcie_gen3_pcs_tbl,
>  	.pcs_tbl_num		= ARRAY_SIZE(ipq8074_pcie_gen3_pcs_tbl),
> +	},
>  	.clk_list		= ipq8074_pciephy_clk_l,
>  	.num_clks		= ARRAY_SIZE(ipq8074_pciephy_clk_l),
>  	.reset_list		= ipq8074_pciephy_reset_l,
> @@ -1576,6 +1575,7 @@ static const struct qmp_phy_cfg ipq6018_pciephy_cfg = {
>  	.type			= PHY_TYPE_PCIE,
>  	.nlanes			= 1,
>  
> +	.pri = {
>  	.serdes_tbl		= ipq6018_pcie_serdes_tbl,
>  	.serdes_tbl_num		= ARRAY_SIZE(ipq6018_pcie_serdes_tbl),
>  	.tx_tbl			= ipq6018_pcie_tx_tbl,
> @@ -1586,6 +1586,7 @@ static const struct qmp_phy_cfg ipq6018_pciephy_cfg = {
>  	.pcs_tbl_num		= ARRAY_SIZE(ipq6018_pcie_pcs_tbl),
>  	.pcs_misc_tbl		= ipq6018_pcie_pcs_misc_tbl,
>  	.pcs_misc_tbl_num	= ARRAY_SIZE(ipq6018_pcie_pcs_misc_tbl),
> +	},
>  	.clk_list		= ipq8074_pciephy_clk_l,
>  	.num_clks		= ARRAY_SIZE(ipq8074_pciephy_clk_l),
>  	.reset_list		= ipq8074_pciephy_reset_l,
> @@ -1606,6 +1607,7 @@ static const struct qmp_phy_cfg sdm845_qmp_pciephy_cfg = {
>  	.type = PHY_TYPE_PCIE,
>  	.nlanes = 1,
>  
> +	.pri = {
>  	.serdes_tbl		= sdm845_qmp_pcie_serdes_tbl,
>  	.serdes_tbl_num		= ARRAY_SIZE(sdm845_qmp_pcie_serdes_tbl),
>  	.tx_tbl			= sdm845_qmp_pcie_tx_tbl,
> @@ -1616,6 +1618,7 @@ static const struct qmp_phy_cfg sdm845_qmp_pciephy_cfg = {
>  	.pcs_tbl_num		= ARRAY_SIZE(sdm845_qmp_pcie_pcs_tbl),
>  	.pcs_misc_tbl		= sdm845_qmp_pcie_pcs_misc_tbl,
>  	.pcs_misc_tbl_num	= ARRAY_SIZE(sdm845_qmp_pcie_pcs_misc_tbl),
> +	},
>  	.clk_list		= sdm845_pciephy_clk_l,
>  	.num_clks		= ARRAY_SIZE(sdm845_pciephy_clk_l),
>  	.reset_list		= sdm845_pciephy_reset_l,
> @@ -1637,6 +1640,7 @@ static const struct qmp_phy_cfg sdm845_qhp_pciephy_cfg = {
>  	.type = PHY_TYPE_PCIE,
>  	.nlanes = 1,
>  
> +	.pri = {
>  	.serdes_tbl		= sdm845_qhp_pcie_serdes_tbl,
>  	.serdes_tbl_num		= ARRAY_SIZE(sdm845_qhp_pcie_serdes_tbl),
>  	.tx_tbl			= sdm845_qhp_pcie_tx_tbl,
> @@ -1645,6 +1649,7 @@ static const struct qmp_phy_cfg sdm845_qhp_pciephy_cfg = {
>  	.rx_tbl_num		= ARRAY_SIZE(sdm845_qhp_pcie_rx_tbl),
>  	.pcs_tbl		= sdm845_qhp_pcie_pcs_tbl,
>  	.pcs_tbl_num		= ARRAY_SIZE(sdm845_qhp_pcie_pcs_tbl),
> +	},
>  	.clk_list		= sdm845_pciephy_clk_l,
>  	.num_clks		= ARRAY_SIZE(sdm845_pciephy_clk_l),
>  	.reset_list		= sdm845_pciephy_reset_l,
> @@ -1666,24 +1671,28 @@ static const struct qmp_phy_cfg sm8250_qmp_gen3x1_pciephy_cfg = {
>  	.type = PHY_TYPE_PCIE,
>  	.nlanes = 1,
>  
> +	.pri = {
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
> +	.sec = {
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
> @@ -1705,24 +1714,28 @@ static const struct qmp_phy_cfg sm8250_qmp_gen3x2_pciephy_cfg = {
>  	.type = PHY_TYPE_PCIE,
>  	.nlanes = 2,
>  
> +	.pri = {
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
> +	.sec = {
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
> @@ -1745,6 +1758,7 @@ static const struct qmp_phy_cfg msm8998_pciephy_cfg = {
>  	.type			= PHY_TYPE_PCIE,
>  	.nlanes			= 1,
>  
> +	.pri = {
>  	.serdes_tbl		= msm8998_pcie_serdes_tbl,
>  	.serdes_tbl_num		= ARRAY_SIZE(msm8998_pcie_serdes_tbl),
>  	.tx_tbl			= msm8998_pcie_tx_tbl,
> @@ -1753,6 +1767,7 @@ static const struct qmp_phy_cfg msm8998_pciephy_cfg = {
>  	.rx_tbl_num		= ARRAY_SIZE(msm8998_pcie_rx_tbl),
>  	.pcs_tbl		= msm8998_pcie_pcs_tbl,
>  	.pcs_tbl_num		= ARRAY_SIZE(msm8998_pcie_pcs_tbl),
> +	},
>  	.clk_list		= msm8996_phy_clk_l,
>  	.num_clks		= ARRAY_SIZE(msm8996_phy_clk_l),
>  	.reset_list		= ipq8074_pciephy_reset_l,
> @@ -1770,6 +1785,7 @@ static const struct qmp_phy_cfg sc8180x_pciephy_cfg = {
>  	.type = PHY_TYPE_PCIE,
>  	.nlanes = 1,
>  
> +	.pri = {
>  	.serdes_tbl		= sc8180x_qmp_pcie_serdes_tbl,
>  	.serdes_tbl_num		= ARRAY_SIZE(sc8180x_qmp_pcie_serdes_tbl),
>  	.tx_tbl			= sc8180x_qmp_pcie_tx_tbl,
> @@ -1780,6 +1796,7 @@ static const struct qmp_phy_cfg sc8180x_pciephy_cfg = {
>  	.pcs_tbl_num		= ARRAY_SIZE(sc8180x_qmp_pcie_pcs_tbl),
>  	.pcs_misc_tbl		= sc8180x_qmp_pcie_pcs_misc_tbl,
>  	.pcs_misc_tbl_num	= ARRAY_SIZE(sc8180x_qmp_pcie_pcs_misc_tbl),
> +	},
>  	.clk_list		= sdm845_pciephy_clk_l,
>  	.num_clks		= ARRAY_SIZE(sdm845_pciephy_clk_l),
>  	.reset_list		= sdm845_pciephy_reset_l,
> @@ -1800,6 +1817,7 @@ static const struct qmp_phy_cfg sdx55_qmp_pciephy_cfg = {
>  	.type = PHY_TYPE_PCIE,
>  	.nlanes = 2,
>  
> +	.pri = {
>  	.serdes_tbl		= sdx55_qmp_pcie_serdes_tbl,
>  	.serdes_tbl_num		= ARRAY_SIZE(sdx55_qmp_pcie_serdes_tbl),
>  	.tx_tbl			= sdx55_qmp_pcie_tx_tbl,
> @@ -1810,6 +1828,7 @@ static const struct qmp_phy_cfg sdx55_qmp_pciephy_cfg = {
>  	.pcs_tbl_num		= ARRAY_SIZE(sdx55_qmp_pcie_pcs_tbl),
>  	.pcs_misc_tbl		= sdx55_qmp_pcie_pcs_misc_tbl,
>  	.pcs_misc_tbl_num	= ARRAY_SIZE(sdx55_qmp_pcie_pcs_misc_tbl),
> +	},
>  	.clk_list		= sdm845_pciephy_clk_l,
>  	.num_clks		= ARRAY_SIZE(sdm845_pciephy_clk_l),
>  	.reset_list		= sdm845_pciephy_reset_l,
> @@ -1832,6 +1851,7 @@ static const struct qmp_phy_cfg sm8450_qmp_gen3x1_pciephy_cfg = {
>  	.type = PHY_TYPE_PCIE,
>  	.nlanes = 1,
>  
> +	.pri = {
>  	.serdes_tbl		= sm8450_qmp_gen3x1_pcie_serdes_tbl,
>  	.serdes_tbl_num		= ARRAY_SIZE(sm8450_qmp_gen3x1_pcie_serdes_tbl),
>  	.tx_tbl			= sm8450_qmp_gen3x1_pcie_tx_tbl,
> @@ -1842,6 +1862,7 @@ static const struct qmp_phy_cfg sm8450_qmp_gen3x1_pciephy_cfg = {
>  	.pcs_tbl_num		= ARRAY_SIZE(sm8450_qmp_gen3x1_pcie_pcs_tbl),
>  	.pcs_misc_tbl		= sm8450_qmp_gen3x1_pcie_pcs_misc_tbl,
>  	.pcs_misc_tbl_num	= ARRAY_SIZE(sm8450_qmp_gen3x1_pcie_pcs_misc_tbl),
> +	},
>  	.clk_list		= sdm845_pciephy_clk_l,
>  	.num_clks		= ARRAY_SIZE(sdm845_pciephy_clk_l),
>  	.reset_list		= sdm845_pciephy_reset_l,
> @@ -1863,6 +1884,7 @@ static const struct qmp_phy_cfg sm8450_qmp_gen4x2_pciephy_cfg = {
>  	.type = PHY_TYPE_PCIE,
>  	.nlanes = 2,
>  
> +	.pri = {
>  	.serdes_tbl		= sm8450_qmp_gen4x2_pcie_serdes_tbl,
>  	.serdes_tbl_num		= ARRAY_SIZE(sm8450_qmp_gen4x2_pcie_serdes_tbl),
>  	.tx_tbl			= sm8450_qmp_gen4x2_pcie_tx_tbl,
> @@ -1873,6 +1895,7 @@ static const struct qmp_phy_cfg sm8450_qmp_gen4x2_pciephy_cfg = {
>  	.pcs_tbl_num		= ARRAY_SIZE(sm8450_qmp_gen4x2_pcie_pcs_tbl),
>  	.pcs_misc_tbl		= sm8450_qmp_gen4x2_pcie_pcs_misc_tbl,
>  	.pcs_misc_tbl_num	= ARRAY_SIZE(sm8450_qmp_gen4x2_pcie_pcs_misc_tbl),
> +	},
>  	.clk_list		= sdm845_pciephy_clk_l,
>  	.num_clks		= ARRAY_SIZE(sdm845_pciephy_clk_l),
>  	.reset_list		= sdm845_pciephy_reset_l,
> @@ -1926,13 +1949,9 @@ static int qcom_qmp_phy_pcie_serdes_init(struct qmp_phy *qphy)
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
> +	qcom_qmp_phy_pcie_configure(serdes, cfg->regs, cfg->pri.serdes_tbl, cfg->pri.serdes_tbl_num);
> +	qcom_qmp_phy_pcie_configure(serdes, cfg->regs, cfg->sec.serdes_tbl, cfg->sec.serdes_tbl_num);
>  
>  	return 0;
>  }
> @@ -2036,46 +2055,37 @@ static int qcom_qmp_phy_pcie_power_on(struct phy *phy)
>  
>  	/* Tx, Rx, and PCS configurations */
>  	qcom_qmp_phy_pcie_configure_lane(tx, cfg->regs,
> -				    cfg->tx_tbl, cfg->tx_tbl_num, 1);
> -	if (cfg->tx_tbl_sec)
> -		qcom_qmp_phy_pcie_configure_lane(tx, cfg->regs, cfg->tx_tbl_sec,
> -					    cfg->tx_tbl_num_sec, 1);
> +					 cfg->pri.tx_tbl, cfg->pri.tx_tbl_num, 1);
> +	qcom_qmp_phy_pcie_configure_lane(tx, cfg->regs,
> +					 cfg->sec.tx_tbl, cfg->sec.tx_tbl_num, 1);
>  
>  	/* Configuration for other LANE for USB-DP combo PHY */
>  	if (cfg->is_dual_lane_phy) {
>  		qcom_qmp_phy_pcie_configure_lane(qphy->tx2, cfg->regs,
> -					    cfg->tx_tbl, cfg->tx_tbl_num, 2);
> -		if (cfg->tx_tbl_sec)
> -			qcom_qmp_phy_pcie_configure_lane(qphy->tx2, cfg->regs,
> -						    cfg->tx_tbl_sec,
> -						    cfg->tx_tbl_num_sec, 2);
> +						 cfg->pri.tx_tbl, cfg->pri.tx_tbl_num, 2);
> +		qcom_qmp_phy_pcie_configure_lane(qphy->tx2, cfg->regs,
> +						 cfg->sec.tx_tbl, cfg->sec.tx_tbl_num, 2);
>  	}
>  
>  	qcom_qmp_phy_pcie_configure_lane(rx, cfg->regs,
> -				    cfg->rx_tbl, cfg->rx_tbl_num, 1);
> -	if (cfg->rx_tbl_sec)
> -		qcom_qmp_phy_pcie_configure_lane(rx, cfg->regs,
> -					    cfg->rx_tbl_sec, cfg->rx_tbl_num_sec, 1);
> +					 cfg->pri.rx_tbl, cfg->pri.rx_tbl_num, 1);
> +	qcom_qmp_phy_pcie_configure_lane(rx, cfg->regs,
> +					 cfg->sec.rx_tbl, cfg->sec.rx_tbl_num, 1);
>  
>  	if (cfg->is_dual_lane_phy) {
>  		qcom_qmp_phy_pcie_configure_lane(qphy->rx2, cfg->regs,
> -					    cfg->rx_tbl, cfg->rx_tbl_num, 2);
> -		if (cfg->rx_tbl_sec)
> -			qcom_qmp_phy_pcie_configure_lane(qphy->rx2, cfg->regs,
> -						    cfg->rx_tbl_sec,
> -						    cfg->rx_tbl_num_sec, 2);
> +						 cfg->pri.rx_tbl, cfg->pri.rx_tbl_num, 2);
> +		qcom_qmp_phy_pcie_configure_lane(qphy->rx2, cfg->regs,
> +						 cfg->sec.rx_tbl, cfg->sec.rx_tbl_num, 2);
>  	}
>  
> -	qcom_qmp_phy_pcie_configure(pcs, cfg->regs, cfg->pcs_tbl, cfg->pcs_tbl_num);
> -	if (cfg->pcs_tbl_sec)
> -		qcom_qmp_phy_pcie_configure(pcs, cfg->regs, cfg->pcs_tbl_sec,
> -				       cfg->pcs_tbl_num_sec);
> +	qcom_qmp_phy_pcie_configure(pcs, cfg->regs, cfg->pri.pcs_tbl, cfg->pri.pcs_tbl_num);
> +	qcom_qmp_phy_pcie_configure(pcs, cfg->regs, cfg->sec.pcs_tbl, cfg->sec.pcs_tbl_num);
>  
> -	qcom_qmp_phy_pcie_configure(pcs_misc, cfg->regs, cfg->pcs_misc_tbl,
> -			       cfg->pcs_misc_tbl_num);
> -	if (cfg->pcs_misc_tbl_sec)
> -		qcom_qmp_phy_pcie_configure(pcs_misc, cfg->regs, cfg->pcs_misc_tbl_sec,
> -				       cfg->pcs_misc_tbl_num_sec);
> +	qcom_qmp_phy_pcie_configure(pcs_misc, cfg->regs, cfg->pri.pcs_misc_tbl,
> +			       cfg->pri.pcs_misc_tbl_num);
> +	qcom_qmp_phy_pcie_configure(pcs_misc, cfg->regs, cfg->sec.pcs_misc_tbl,
> +			       cfg->sec.pcs_misc_tbl_num);
>  
>  	/*
>  	 * Pull out PHY from POWER DOWN state.
> -- 
> 2.35.1
> 

-- 
மணிவண்ணன் சதாசிவம்
