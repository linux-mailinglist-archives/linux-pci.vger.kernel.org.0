Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A627A5E8E48
	for <lists+linux-pci@lfdr.de>; Sat, 24 Sep 2022 18:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233871AbiIXQDN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 24 Sep 2022 12:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232545AbiIXQDK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 24 Sep 2022 12:03:10 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D67D339BAC
        for <linux-pci@vger.kernel.org>; Sat, 24 Sep 2022 09:03:06 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id a3so4621429lfk.9
        for <linux-pci@vger.kernel.org>; Sat, 24 Sep 2022 09:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=MCLPtDYghQLO9uirmv9KQz8fKpUMpCU5KMpSSoJXCbI=;
        b=hkVX/QDB9w8PsBWz9SlJHla6n9qJ3Rh2la1tckOVFfPVNv3aVvgLXjbdYXs2XV4WLw
         UIRMCEYX2p3hRHbakojwBV1IR2YPduV8OWPZB6babR8ze0Px+Fqm+mXJRP6LJy/KqKcG
         +gm5tafqIUshikQC5t4UwcoQIkHLrlMXuNGHWCEVC3E9gKG4BJ63OQDJ3RQ8Kh4ag+rI
         aWRX5Z62lz6eGOFJqLbEKzxcAWsntaZMoT2d/IVwBhFvS9zSCINVDZasOwyarqD55Lmo
         bttWnmcbEz/cbjYL6V2Jy5rvKGD+7OQHoLTtsDVxRMHBLzrKro4rE0fPYpc3zrYIR79S
         vDpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=MCLPtDYghQLO9uirmv9KQz8fKpUMpCU5KMpSSoJXCbI=;
        b=mHTfdQMCPZ61RlHlRzlSeDB0Dx6Ux8vxtkfv9MQGVo/No4aJljOpdmYekh1nL/qcm5
         f0VOj59gL5wtjQp8uFVowZ7dOV8yP8ndYMJNuO1jixdDHVV2ZCVHsfM4XvWaRLNfsQNM
         ZKUg5z8ymB/5izSgC7OWgoi9hWDkjO5s8eb/AEQiv+uUiXa8DGf9KW6uUUUbSaYnU9hi
         qG99mOd8y9L5ZEWkFZnszAoPi9JsjvLWARnur/ak+MKnNO2AWxkh0gW2unCntsD2oPam
         MC5ufwSSjx/oOlcxn+1rCPDDGT/OUYGhT8uJok4BENzj3fAQv2y12SLVod/QYHNGr7oX
         IfnA==
X-Gm-Message-State: ACrzQf0rPttRPP+j1yPKuhaj4gP8JCV8boSjnq4Q7qaOxsaz5LwbiMoK
        7cfmMVXzkO2UiovoT4zSF2CN6g==
X-Google-Smtp-Source: AMsMyM7NTx22iQK8nmVsWtGGF+9jlKq4+HGfNoqrIEd7ZDmJ78O6fjrjsfVlN2GWvhkUyDwFY0OUXQ==
X-Received: by 2002:a05:6512:3da2:b0:499:d70a:e6bc with SMTP id k34-20020a0565123da200b00499d70ae6bcmr5826291lfv.191.1664035384982;
        Sat, 24 Sep 2022 09:03:04 -0700 (PDT)
Received: from eriador.lumag.spb.ru ([95.161.222.31])
        by smtp.gmail.com with ESMTPSA id 9-20020ac25f09000000b00499f9ba6af0sm1928015lfq.207.2022.09.24.09.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Sep 2022 09:03:04 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Johan Hovold <johan@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-phy@lists.infradead.org
Subject: [PATCH v4 1/6] phy: qcom-qmp-pcie: split register tables into common and extra parts
Date:   Sat, 24 Sep 2022 19:02:57 +0300
Message-Id: <20220924160302.285875-2-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220924160302.285875-1-dmitry.baryshkov@linaro.org>
References: <20220924160302.285875-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SM8250 configuration tables are split into two parts: the common one and
the PHY-specific tables. Make this split more formal. Rather than having
a blind renamed copy of all QMP table fields, add separate struct
qmp_phy_cfg_tables and add two instances of this structure to the struct
qmp_phy_cfg. Later on this will be used to support different PHY modes
(RC vs EP).

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 129 ++++++++++++++---------
 1 file changed, 77 insertions(+), 52 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
index 7aff3f9940a5..30806816c8b0 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
@@ -1300,31 +1300,30 @@ static const struct qmp_phy_init_tbl sm8450_qmp_gen4x2_pcie_pcs_misc_tbl[] = {
 	QMP_PHY_INIT_CFG(QPHY_V5_20_PCS_PCIE_G4_PRE_GAIN, 0x2e),
 };
 
-/* struct qmp_phy_cfg - per-PHY initialization config */
-struct qmp_phy_cfg {
-	int lanes;
-
-	/* Init sequence for PHY blocks - serdes, tx, rx, pcs */
+struct qmp_phy_cfg_tables {
 	const struct qmp_phy_init_tbl *serdes_tbl;
 	int serdes_tbl_num;
-	const struct qmp_phy_init_tbl *serdes_tbl_sec;
-	int serdes_tbl_num_sec;
 	const struct qmp_phy_init_tbl *tx_tbl;
 	int tx_tbl_num;
-	const struct qmp_phy_init_tbl *tx_tbl_sec;
-	int tx_tbl_num_sec;
 	const struct qmp_phy_init_tbl *rx_tbl;
 	int rx_tbl_num;
-	const struct qmp_phy_init_tbl *rx_tbl_sec;
-	int rx_tbl_num_sec;
 	const struct qmp_phy_init_tbl *pcs_tbl;
 	int pcs_tbl_num;
-	const struct qmp_phy_init_tbl *pcs_tbl_sec;
-	int pcs_tbl_num_sec;
 	const struct qmp_phy_init_tbl *pcs_misc_tbl;
 	int pcs_misc_tbl_num;
-	const struct qmp_phy_init_tbl *pcs_misc_tbl_sec;
-	int pcs_misc_tbl_num_sec;
+};
+
+/* struct qmp_phy_cfg - per-PHY initialization config */
+struct qmp_phy_cfg {
+	int lanes;
+
+	/* Main init sequence for PHY blocks - serdes, tx, rx, pcs */
+	struct qmp_phy_cfg_tables common;
+	/*
+	 * Additional init sequence for PHY blocks, providing additional
+	 * register programming. Unless required it can be left omitted.
+	 */
+	struct qmp_phy_cfg_tables *extra;
 
 	/* clock ids to be requested */
 	const char * const *clk_list;
@@ -1459,6 +1458,7 @@ static const char * const sdm845_pciephy_reset_l[] = {
 static const struct qmp_phy_cfg ipq8074_pciephy_cfg = {
 	.lanes			= 1,
 
+	.common = {
 	.serdes_tbl		= ipq8074_pcie_serdes_tbl,
 	.serdes_tbl_num		= ARRAY_SIZE(ipq8074_pcie_serdes_tbl),
 	.tx_tbl			= ipq8074_pcie_tx_tbl,
@@ -1467,6 +1467,7 @@ static const struct qmp_phy_cfg ipq8074_pciephy_cfg = {
 	.rx_tbl_num		= ARRAY_SIZE(ipq8074_pcie_rx_tbl),
 	.pcs_tbl		= ipq8074_pcie_pcs_tbl,
 	.pcs_tbl_num		= ARRAY_SIZE(ipq8074_pcie_pcs_tbl),
+	},
 	.clk_list		= ipq8074_pciephy_clk_l,
 	.num_clks		= ARRAY_SIZE(ipq8074_pciephy_clk_l),
 	.reset_list		= ipq8074_pciephy_reset_l,
@@ -1487,6 +1488,7 @@ static const struct qmp_phy_cfg ipq8074_pciephy_cfg = {
 static const struct qmp_phy_cfg ipq8074_pciephy_gen3_cfg = {
 	.lanes			= 1,
 
+	.common = {
 	.serdes_tbl		= ipq8074_pcie_gen3_serdes_tbl,
 	.serdes_tbl_num		= ARRAY_SIZE(ipq8074_pcie_gen3_serdes_tbl),
 	.tx_tbl			= ipq8074_pcie_gen3_tx_tbl,
@@ -1495,6 +1497,7 @@ static const struct qmp_phy_cfg ipq8074_pciephy_gen3_cfg = {
 	.rx_tbl_num		= ARRAY_SIZE(ipq8074_pcie_gen3_rx_tbl),
 	.pcs_tbl		= ipq8074_pcie_gen3_pcs_tbl,
 	.pcs_tbl_num		= ARRAY_SIZE(ipq8074_pcie_gen3_pcs_tbl),
+	},
 	.clk_list		= ipq8074_pciephy_clk_l,
 	.num_clks		= ARRAY_SIZE(ipq8074_pciephy_clk_l),
 	.reset_list		= ipq8074_pciephy_reset_l,
@@ -1516,6 +1519,7 @@ static const struct qmp_phy_cfg ipq8074_pciephy_gen3_cfg = {
 static const struct qmp_phy_cfg ipq6018_pciephy_cfg = {
 	.lanes			= 1,
 
+	.common = {
 	.serdes_tbl		= ipq6018_pcie_serdes_tbl,
 	.serdes_tbl_num		= ARRAY_SIZE(ipq6018_pcie_serdes_tbl),
 	.tx_tbl			= ipq6018_pcie_tx_tbl,
@@ -1526,6 +1530,7 @@ static const struct qmp_phy_cfg ipq6018_pciephy_cfg = {
 	.pcs_tbl_num		= ARRAY_SIZE(ipq6018_pcie_pcs_tbl),
 	.pcs_misc_tbl		= ipq6018_pcie_pcs_misc_tbl,
 	.pcs_misc_tbl_num	= ARRAY_SIZE(ipq6018_pcie_pcs_misc_tbl),
+	},
 	.clk_list		= ipq8074_pciephy_clk_l,
 	.num_clks		= ARRAY_SIZE(ipq8074_pciephy_clk_l),
 	.reset_list		= ipq8074_pciephy_reset_l,
@@ -1545,6 +1550,7 @@ static const struct qmp_phy_cfg ipq6018_pciephy_cfg = {
 static const struct qmp_phy_cfg sdm845_qmp_pciephy_cfg = {
 	.lanes			= 1,
 
+	.common = {
 	.serdes_tbl		= sdm845_qmp_pcie_serdes_tbl,
 	.serdes_tbl_num		= ARRAY_SIZE(sdm845_qmp_pcie_serdes_tbl),
 	.tx_tbl			= sdm845_qmp_pcie_tx_tbl,
@@ -1555,6 +1561,7 @@ static const struct qmp_phy_cfg sdm845_qmp_pciephy_cfg = {
 	.pcs_tbl_num		= ARRAY_SIZE(sdm845_qmp_pcie_pcs_tbl),
 	.pcs_misc_tbl		= sdm845_qmp_pcie_pcs_misc_tbl,
 	.pcs_misc_tbl_num	= ARRAY_SIZE(sdm845_qmp_pcie_pcs_misc_tbl),
+	},
 	.clk_list		= sdm845_pciephy_clk_l,
 	.num_clks		= ARRAY_SIZE(sdm845_pciephy_clk_l),
 	.reset_list		= sdm845_pciephy_reset_l,
@@ -1575,6 +1582,7 @@ static const struct qmp_phy_cfg sdm845_qmp_pciephy_cfg = {
 static const struct qmp_phy_cfg sdm845_qhp_pciephy_cfg = {
 	.lanes			= 1,
 
+	.common = {
 	.serdes_tbl		= sdm845_qhp_pcie_serdes_tbl,
 	.serdes_tbl_num		= ARRAY_SIZE(sdm845_qhp_pcie_serdes_tbl),
 	.tx_tbl			= sdm845_qhp_pcie_tx_tbl,
@@ -1583,6 +1591,7 @@ static const struct qmp_phy_cfg sdm845_qhp_pciephy_cfg = {
 	.rx_tbl_num		= ARRAY_SIZE(sdm845_qhp_pcie_rx_tbl),
 	.pcs_tbl		= sdm845_qhp_pcie_pcs_tbl,
 	.pcs_tbl_num		= ARRAY_SIZE(sdm845_qhp_pcie_pcs_tbl),
+	},
 	.clk_list		= sdm845_pciephy_clk_l,
 	.num_clks		= ARRAY_SIZE(sdm845_pciephy_clk_l),
 	.reset_list		= sdm845_pciephy_reset_l,
@@ -1603,24 +1612,28 @@ static const struct qmp_phy_cfg sdm845_qhp_pciephy_cfg = {
 static const struct qmp_phy_cfg sm8250_qmp_gen3x1_pciephy_cfg = {
 	.lanes			= 1,
 
+	.common = {
 	.serdes_tbl		= sm8250_qmp_pcie_serdes_tbl,
 	.serdes_tbl_num		= ARRAY_SIZE(sm8250_qmp_pcie_serdes_tbl),
-	.serdes_tbl_sec		= sm8250_qmp_gen3x1_pcie_serdes_tbl,
-	.serdes_tbl_num_sec	= ARRAY_SIZE(sm8250_qmp_gen3x1_pcie_serdes_tbl),
 	.tx_tbl			= sm8250_qmp_pcie_tx_tbl,
 	.tx_tbl_num		= ARRAY_SIZE(sm8250_qmp_pcie_tx_tbl),
 	.rx_tbl			= sm8250_qmp_pcie_rx_tbl,
 	.rx_tbl_num		= ARRAY_SIZE(sm8250_qmp_pcie_rx_tbl),
-	.rx_tbl_sec		= sm8250_qmp_gen3x1_pcie_rx_tbl,
-	.rx_tbl_num_sec		= ARRAY_SIZE(sm8250_qmp_gen3x1_pcie_rx_tbl),
 	.pcs_tbl		= sm8250_qmp_pcie_pcs_tbl,
 	.pcs_tbl_num		= ARRAY_SIZE(sm8250_qmp_pcie_pcs_tbl),
-	.pcs_tbl_sec		= sm8250_qmp_gen3x1_pcie_pcs_tbl,
-	.pcs_tbl_num_sec		= ARRAY_SIZE(sm8250_qmp_gen3x1_pcie_pcs_tbl),
 	.pcs_misc_tbl		= sm8250_qmp_pcie_pcs_misc_tbl,
 	.pcs_misc_tbl_num	= ARRAY_SIZE(sm8250_qmp_pcie_pcs_misc_tbl),
-	.pcs_misc_tbl_sec		= sm8250_qmp_gen3x1_pcie_pcs_misc_tbl,
-	.pcs_misc_tbl_num_sec	= ARRAY_SIZE(sm8250_qmp_gen3x1_pcie_pcs_misc_tbl),
+	},
+	.extra = &(struct qmp_phy_cfg_tables) {
+	.serdes_tbl		= sm8250_qmp_gen3x1_pcie_serdes_tbl,
+	.serdes_tbl_num		= ARRAY_SIZE(sm8250_qmp_gen3x1_pcie_serdes_tbl),
+	.rx_tbl			= sm8250_qmp_gen3x1_pcie_rx_tbl,
+	.rx_tbl_num		= ARRAY_SIZE(sm8250_qmp_gen3x1_pcie_rx_tbl),
+	.pcs_tbl		= sm8250_qmp_gen3x1_pcie_pcs_tbl,
+	.pcs_tbl_num		= ARRAY_SIZE(sm8250_qmp_gen3x1_pcie_pcs_tbl),
+	.pcs_misc_tbl		= sm8250_qmp_gen3x1_pcie_pcs_misc_tbl,
+	.pcs_misc_tbl_num	= ARRAY_SIZE(sm8250_qmp_gen3x1_pcie_pcs_misc_tbl),
+	},
 	.clk_list		= sdm845_pciephy_clk_l,
 	.num_clks		= ARRAY_SIZE(sdm845_pciephy_clk_l),
 	.reset_list		= sdm845_pciephy_reset_l,
@@ -1641,24 +1654,28 @@ static const struct qmp_phy_cfg sm8250_qmp_gen3x1_pciephy_cfg = {
 static const struct qmp_phy_cfg sm8250_qmp_gen3x2_pciephy_cfg = {
 	.lanes			= 2,
 
+	.common = {
 	.serdes_tbl		= sm8250_qmp_pcie_serdes_tbl,
 	.serdes_tbl_num		= ARRAY_SIZE(sm8250_qmp_pcie_serdes_tbl),
 	.tx_tbl			= sm8250_qmp_pcie_tx_tbl,
 	.tx_tbl_num		= ARRAY_SIZE(sm8250_qmp_pcie_tx_tbl),
-	.tx_tbl_sec		= sm8250_qmp_gen3x2_pcie_tx_tbl,
-	.tx_tbl_num_sec		= ARRAY_SIZE(sm8250_qmp_gen3x2_pcie_tx_tbl),
 	.rx_tbl			= sm8250_qmp_pcie_rx_tbl,
 	.rx_tbl_num		= ARRAY_SIZE(sm8250_qmp_pcie_rx_tbl),
-	.rx_tbl_sec		= sm8250_qmp_gen3x2_pcie_rx_tbl,
-	.rx_tbl_num_sec		= ARRAY_SIZE(sm8250_qmp_gen3x2_pcie_rx_tbl),
 	.pcs_tbl		= sm8250_qmp_pcie_pcs_tbl,
 	.pcs_tbl_num		= ARRAY_SIZE(sm8250_qmp_pcie_pcs_tbl),
-	.pcs_tbl_sec		= sm8250_qmp_gen3x2_pcie_pcs_tbl,
-	.pcs_tbl_num_sec		= ARRAY_SIZE(sm8250_qmp_gen3x2_pcie_pcs_tbl),
 	.pcs_misc_tbl		= sm8250_qmp_pcie_pcs_misc_tbl,
 	.pcs_misc_tbl_num	= ARRAY_SIZE(sm8250_qmp_pcie_pcs_misc_tbl),
-	.pcs_misc_tbl_sec		= sm8250_qmp_gen3x2_pcie_pcs_misc_tbl,
-	.pcs_misc_tbl_num_sec	= ARRAY_SIZE(sm8250_qmp_gen3x2_pcie_pcs_misc_tbl),
+	},
+	.extra = &(struct qmp_phy_cfg_tables) {
+	.tx_tbl			= sm8250_qmp_gen3x2_pcie_tx_tbl,
+	.tx_tbl_num		= ARRAY_SIZE(sm8250_qmp_gen3x2_pcie_tx_tbl),
+	.rx_tbl			= sm8250_qmp_gen3x2_pcie_rx_tbl,
+	.rx_tbl_num		= ARRAY_SIZE(sm8250_qmp_gen3x2_pcie_rx_tbl),
+	.pcs_tbl		= sm8250_qmp_gen3x2_pcie_pcs_tbl,
+	.pcs_tbl_num		= ARRAY_SIZE(sm8250_qmp_gen3x2_pcie_pcs_tbl),
+	.pcs_misc_tbl		= sm8250_qmp_gen3x2_pcie_pcs_misc_tbl,
+	.pcs_misc_tbl_num	= ARRAY_SIZE(sm8250_qmp_gen3x2_pcie_pcs_misc_tbl),
+	},
 	.clk_list		= sdm845_pciephy_clk_l,
 	.num_clks		= ARRAY_SIZE(sdm845_pciephy_clk_l),
 	.reset_list		= sdm845_pciephy_reset_l,
@@ -1679,6 +1696,7 @@ static const struct qmp_phy_cfg sm8250_qmp_gen3x2_pciephy_cfg = {
 static const struct qmp_phy_cfg msm8998_pciephy_cfg = {
 	.lanes			= 1,
 
+	.common = {
 	.serdes_tbl		= msm8998_pcie_serdes_tbl,
 	.serdes_tbl_num		= ARRAY_SIZE(msm8998_pcie_serdes_tbl),
 	.tx_tbl			= msm8998_pcie_tx_tbl,
@@ -1687,6 +1705,7 @@ static const struct qmp_phy_cfg msm8998_pciephy_cfg = {
 	.rx_tbl_num		= ARRAY_SIZE(msm8998_pcie_rx_tbl),
 	.pcs_tbl		= msm8998_pcie_pcs_tbl,
 	.pcs_tbl_num		= ARRAY_SIZE(msm8998_pcie_pcs_tbl),
+	},
 	.clk_list		= msm8996_phy_clk_l,
 	.num_clks		= ARRAY_SIZE(msm8996_phy_clk_l),
 	.reset_list		= ipq8074_pciephy_reset_l,
@@ -1703,6 +1722,7 @@ static const struct qmp_phy_cfg msm8998_pciephy_cfg = {
 static const struct qmp_phy_cfg sc8180x_pciephy_cfg = {
 	.lanes			= 1,
 
+	.common = {
 	.serdes_tbl		= sc8180x_qmp_pcie_serdes_tbl,
 	.serdes_tbl_num		= ARRAY_SIZE(sc8180x_qmp_pcie_serdes_tbl),
 	.tx_tbl			= sc8180x_qmp_pcie_tx_tbl,
@@ -1713,6 +1733,7 @@ static const struct qmp_phy_cfg sc8180x_pciephy_cfg = {
 	.pcs_tbl_num		= ARRAY_SIZE(sc8180x_qmp_pcie_pcs_tbl),
 	.pcs_misc_tbl		= sc8180x_qmp_pcie_pcs_misc_tbl,
 	.pcs_misc_tbl_num	= ARRAY_SIZE(sc8180x_qmp_pcie_pcs_misc_tbl),
+	},
 	.clk_list		= sdm845_pciephy_clk_l,
 	.num_clks		= ARRAY_SIZE(sdm845_pciephy_clk_l),
 	.reset_list		= sdm845_pciephy_reset_l,
@@ -1732,6 +1753,7 @@ static const struct qmp_phy_cfg sc8180x_pciephy_cfg = {
 static const struct qmp_phy_cfg sdx55_qmp_pciephy_cfg = {
 	.lanes			= 2,
 
+	.common = {
 	.serdes_tbl		= sdx55_qmp_pcie_serdes_tbl,
 	.serdes_tbl_num		= ARRAY_SIZE(sdx55_qmp_pcie_serdes_tbl),
 	.tx_tbl			= sdx55_qmp_pcie_tx_tbl,
@@ -1742,6 +1764,7 @@ static const struct qmp_phy_cfg sdx55_qmp_pciephy_cfg = {
 	.pcs_tbl_num		= ARRAY_SIZE(sdx55_qmp_pcie_pcs_tbl),
 	.pcs_misc_tbl		= sdx55_qmp_pcie_pcs_misc_tbl,
 	.pcs_misc_tbl_num	= ARRAY_SIZE(sdx55_qmp_pcie_pcs_misc_tbl),
+	},
 	.clk_list		= sdm845_pciephy_clk_l,
 	.num_clks		= ARRAY_SIZE(sdm845_pciephy_clk_l),
 	.reset_list		= sdm845_pciephy_reset_l,
@@ -1762,6 +1785,7 @@ static const struct qmp_phy_cfg sdx55_qmp_pciephy_cfg = {
 static const struct qmp_phy_cfg sm8450_qmp_gen3x1_pciephy_cfg = {
 	.lanes			= 1,
 
+	.common = {
 	.serdes_tbl		= sm8450_qmp_gen3x1_pcie_serdes_tbl,
 	.serdes_tbl_num		= ARRAY_SIZE(sm8450_qmp_gen3x1_pcie_serdes_tbl),
 	.tx_tbl			= sm8450_qmp_gen3x1_pcie_tx_tbl,
@@ -1772,6 +1796,7 @@ static const struct qmp_phy_cfg sm8450_qmp_gen3x1_pciephy_cfg = {
 	.pcs_tbl_num		= ARRAY_SIZE(sm8450_qmp_gen3x1_pcie_pcs_tbl),
 	.pcs_misc_tbl		= sm8450_qmp_gen3x1_pcie_pcs_misc_tbl,
 	.pcs_misc_tbl_num	= ARRAY_SIZE(sm8450_qmp_gen3x1_pcie_pcs_misc_tbl),
+	},
 	.clk_list		= sdm845_pciephy_clk_l,
 	.num_clks		= ARRAY_SIZE(sdm845_pciephy_clk_l),
 	.reset_list		= sdm845_pciephy_reset_l,
@@ -1792,6 +1817,7 @@ static const struct qmp_phy_cfg sm8450_qmp_gen3x1_pciephy_cfg = {
 static const struct qmp_phy_cfg sm8450_qmp_gen4x2_pciephy_cfg = {
 	.lanes			= 2,
 
+	.common = {
 	.serdes_tbl		= sm8450_qmp_gen4x2_pcie_serdes_tbl,
 	.serdes_tbl_num		= ARRAY_SIZE(sm8450_qmp_gen4x2_pcie_serdes_tbl),
 	.tx_tbl			= sm8450_qmp_gen4x2_pcie_tx_tbl,
@@ -1802,6 +1828,7 @@ static const struct qmp_phy_cfg sm8450_qmp_gen4x2_pciephy_cfg = {
 	.pcs_tbl_num		= ARRAY_SIZE(sm8450_qmp_gen4x2_pcie_pcs_tbl),
 	.pcs_misc_tbl		= sm8450_qmp_gen4x2_pcie_pcs_misc_tbl,
 	.pcs_misc_tbl_num	= ARRAY_SIZE(sm8450_qmp_gen4x2_pcie_pcs_misc_tbl),
+	},
 	.clk_list		= sdm845_pciephy_clk_l,
 	.num_clks		= ARRAY_SIZE(sdm845_pciephy_clk_l),
 	.reset_list		= sdm845_pciephy_reset_l,
@@ -1854,11 +1881,9 @@ static int qmp_pcie_serdes_init(struct qmp_phy *qphy)
 {
 	const struct qmp_phy_cfg *cfg = qphy->cfg;
 	void __iomem *serdes = qphy->serdes;
-	const struct qmp_phy_init_tbl *serdes_tbl = cfg->serdes_tbl;
-	int serdes_tbl_num = cfg->serdes_tbl_num;
 
-	qmp_pcie_configure(serdes, cfg->regs, serdes_tbl, serdes_tbl_num);
-	qmp_pcie_configure(serdes, cfg->regs, cfg->serdes_tbl_sec, cfg->serdes_tbl_num_sec);
+	qmp_pcie_configure(serdes, cfg->regs, cfg->common.serdes_tbl, cfg->common.serdes_tbl_num);
+	qmp_pcie_configure(serdes, cfg->regs, cfg->extra->serdes_tbl, cfg->extra->serdes_tbl_num);
 
 	return 0;
 }
@@ -1949,31 +1974,31 @@ static int qmp_pcie_power_on(struct phy *phy)
 	}
 
 	/* Tx, Rx, and PCS configurations */
-	qmp_pcie_configure_lane(tx, cfg->regs, cfg->tx_tbl, cfg->tx_tbl_num, 1);
-	qmp_pcie_configure_lane(tx, cfg->regs, cfg->tx_tbl_sec, cfg->tx_tbl_num_sec, 1);
+	qmp_pcie_configure_lane(tx, cfg->regs, cfg->common.tx_tbl, cfg->common.tx_tbl_num, 1);
+	qmp_pcie_configure_lane(tx, cfg->regs, cfg->extra->tx_tbl, cfg->extra->tx_tbl_num, 1);
 
 	if (cfg->lanes >= 2) {
-		qmp_pcie_configure_lane(qphy->tx2, cfg->regs, cfg->tx_tbl,
-					cfg->tx_tbl_num, 2);
-		qmp_pcie_configure_lane(qphy->tx2, cfg->regs, cfg->tx_tbl_sec,
-					cfg->tx_tbl_num_sec, 2);
+		qmp_pcie_configure_lane(qphy->tx2, cfg->regs, cfg->common.tx_tbl,
+					cfg->common.tx_tbl_num, 2);
+		qmp_pcie_configure_lane(qphy->tx2, cfg->regs, cfg->extra->tx_tbl,
+					cfg->extra->tx_tbl_num, 2);
 	}
 
-	qmp_pcie_configure_lane(rx, cfg->regs, cfg->rx_tbl, cfg->rx_tbl_num, 1);
-	qmp_pcie_configure_lane(rx, cfg->regs, cfg->rx_tbl_sec, cfg->rx_tbl_num_sec, 1);
+	qmp_pcie_configure_lane(rx, cfg->regs, cfg->common.rx_tbl, cfg->common.rx_tbl_num, 1);
+	qmp_pcie_configure_lane(rx, cfg->regs, cfg->extra->rx_tbl, cfg->extra->rx_tbl_num, 1);
 
 	if (cfg->lanes >= 2) {
-		qmp_pcie_configure_lane(qphy->rx2, cfg->regs, cfg->rx_tbl,
-					cfg->rx_tbl_num, 2);
-		qmp_pcie_configure_lane(qphy->rx2, cfg->regs, cfg->rx_tbl_sec,
-					cfg->rx_tbl_num_sec, 2);
+		qmp_pcie_configure_lane(qphy->rx2, cfg->regs, cfg->common.rx_tbl,
+					cfg->common.rx_tbl_num, 2);
+		qmp_pcie_configure_lane(qphy->rx2, cfg->regs, cfg->extra->rx_tbl,
+					cfg->extra->rx_tbl_num, 2);
 	}
 
-	qmp_pcie_configure(pcs, cfg->regs, cfg->pcs_tbl, cfg->pcs_tbl_num);
-	qmp_pcie_configure(pcs, cfg->regs, cfg->pcs_tbl_sec, cfg->pcs_tbl_num_sec);
+	qmp_pcie_configure(pcs, cfg->regs, cfg->common.pcs_tbl, cfg->common.pcs_tbl_num);
+	qmp_pcie_configure(pcs, cfg->regs, cfg->extra->pcs_tbl, cfg->extra->pcs_tbl_num);
 
-	qmp_pcie_configure(pcs_misc, cfg->regs, cfg->pcs_misc_tbl, cfg->pcs_misc_tbl_num);
-	qmp_pcie_configure(pcs_misc, cfg->regs, cfg->pcs_misc_tbl_sec, cfg->pcs_misc_tbl_num_sec);
+	qmp_pcie_configure(pcs_misc, cfg->regs, cfg->common.pcs_misc_tbl, cfg->common.pcs_misc_tbl_num);
+	qmp_pcie_configure(pcs_misc, cfg->regs, cfg->extra->pcs_misc_tbl, cfg->extra->pcs_misc_tbl_num);
 
 	/*
 	 * Pull out PHY from POWER DOWN state.
@@ -2237,7 +2262,7 @@ static int qmp_pcie_create(struct device *dev, struct device_node *np, int id,
 		qphy->pcs_misc = qphy->pcs + 0x400;
 
 	if (IS_ERR(qphy->pcs_misc)) {
-		if (cfg->pcs_misc_tbl || cfg->pcs_misc_tbl_sec)
+		if (cfg->common.pcs_misc_tbl || cfg->extra->pcs_misc_tbl)
 			return PTR_ERR(qphy->pcs_misc);
 	}
 
-- 
2.35.1

