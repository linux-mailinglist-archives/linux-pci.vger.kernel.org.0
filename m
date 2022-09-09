Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B596C5B335E
	for <lists+linux-pci@lfdr.de>; Fri,  9 Sep 2022 11:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232093AbiIIJOr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Sep 2022 05:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232108AbiIIJOn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Sep 2022 05:14:43 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D7FC201B5
        for <linux-pci@vger.kernel.org>; Fri,  9 Sep 2022 02:14:39 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id bq23so1635689lfb.7
        for <linux-pci@vger.kernel.org>; Fri, 09 Sep 2022 02:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=w6ZT7oN64RxCPepl3F3R5dXubkjqX2GKW/j1lRNrax4=;
        b=OxmvCp/PDUA77DX9Rl0FoydIumAXq8+aI18hGMu/tLxizgmr2ancYZPQWtvDWZ5OfU
         qfDxgi3myKHekPZaCG3Evg8os4fSSdGuYqSdyEcGZaeesJofQKzDGZcXyh+nYVFvZ5UK
         uJVuoHBwkoUc2QtzW0NmQqmuaYnrJDzu7KzAnT6hAbWqk+IWmAsnjtj7EAHL+3feVxGN
         P4bpuSjmX+DpfU7g+wh2dcUgJVurdrCwGLIG8RKDWfzgHhIwkUthiNHuVhLjR620G/AX
         WCXPGikFwjmJeIwXwxhGwUHEMEGCkUHnpchXy5q5jwWODvOkfTBF4dVUhA7FaEi40fcn
         a0gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=w6ZT7oN64RxCPepl3F3R5dXubkjqX2GKW/j1lRNrax4=;
        b=GaRr0HJyOXy2NM1V9Y0AEiLti9o8cJ2yy3OZIYYhb6lTjmGj5LU9/+E0ySHGXpI22u
         NLdlCsvhyuaF50tt9Egcy0OWxbFPfUJkzoFLio2FXYTP2YWwUH9NEboqCcXbmGIcEblI
         PcGAkVw7rVj8AUAk6TV6iZhVTYQ0IZ9Dyqi09RXNZM95xJ52NtWdG1IFPvfmOGSyn88X
         eKFqpN9NGu+mp4amrFqiu0o5HqhOkxLY4ht1mrFTysRvUzyyrRztx8sCMmK89iR5Icup
         ffYKnKa1hizZsbkCZMPZkiWIDR2YyipN3kVrBGksaVVcnqUeiEy+CHaICaee+4R9hHv/
         2Njw==
X-Gm-Message-State: ACgBeo2APcfaPPm/W3t7k05H6mVuzQR9EP4K/tPJmTRd3IMtc0ni/DOM
        lJv7cqBvd1Wj/9FS8rPO+Cu8+Q==
X-Google-Smtp-Source: AA6agR5JS8DgcNX6EyjwB+TZeCMVT5gNOxkkBoCWEFXINqWXQ0tjdiAfrxUXG4u78Ke45nEZX1RSdw==
X-Received: by 2002:a05:6512:3503:b0:496:55d:a186 with SMTP id h3-20020a056512350300b00496055da186mr3866038lfs.340.1662714877702;
        Fri, 09 Sep 2022 02:14:37 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id z26-20020a2e4c1a000000b0026acbb6ed1asm201615lja.66.2022.09.09.02.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 02:14:37 -0700 (PDT)
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
Subject: [PATCH v3 3/9] phy: qcom-qmp-pcie: split register tables into main and secondary parts
Date:   Fri,  9 Sep 2022 12:14:27 +0300
Message-Id: <20220909091433.3715981-4-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220909091433.3715981-1-dmitry.baryshkov@linaro.org>
References: <20220909091433.3715981-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 141 +++++++++++++----------
 1 file changed, 83 insertions(+), 58 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
index 536a6ac835c1..ca8dffaf1081 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
@@ -1346,34 +1346,33 @@ static const struct qmp_phy_init_tbl sm8450_qmp_gen4x2_pcie_pcs_misc_tbl[] = {
 
 struct qmp_phy;
 
-/* struct qmp_phy_cfg - per-PHY initialization config */
-struct qmp_phy_cfg {
-	/* phy-type - PCIE/UFS/USB */
-	unsigned int type;
-	/* number of lanes provided by phy */
-	int nlanes;
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
+	/* phy-type - PCIE/UFS/USB */
+	unsigned int type;
+	/* number of lanes provided by phy */
+	int nlanes;
+
+	/* Main init sequence for PHY blocks - serdes, tx, rx, pcs */
+	struct qmp_phy_cfg_tables main;
+	/*
+	 * Additional init sequence for PHY blocks, providing additional
+	 * register programming. Unless required it can be left omitted.
+	 */
+	struct qmp_phy_cfg_tables secondary;
 
 	/* clock ids to be requested */
 	const char * const *clk_list;
@@ -1517,6 +1516,7 @@ static const struct qmp_phy_cfg ipq8074_pciephy_cfg = {
 	.type			= PHY_TYPE_PCIE,
 	.nlanes			= 1,
 
+	.main = {
 	.serdes_tbl		= ipq8074_pcie_serdes_tbl,
 	.serdes_tbl_num		= ARRAY_SIZE(ipq8074_pcie_serdes_tbl),
 	.tx_tbl			= ipq8074_pcie_tx_tbl,
@@ -1525,6 +1525,7 @@ static const struct qmp_phy_cfg ipq8074_pciephy_cfg = {
 	.rx_tbl_num		= ARRAY_SIZE(ipq8074_pcie_rx_tbl),
 	.pcs_tbl		= ipq8074_pcie_pcs_tbl,
 	.pcs_tbl_num		= ARRAY_SIZE(ipq8074_pcie_pcs_tbl),
+	},
 	.clk_list		= ipq8074_pciephy_clk_l,
 	.num_clks		= ARRAY_SIZE(ipq8074_pciephy_clk_l),
 	.reset_list		= ipq8074_pciephy_reset_l,
@@ -1546,6 +1547,7 @@ static const struct qmp_phy_cfg ipq8074_pciephy_gen3_cfg = {
 	.type			= PHY_TYPE_PCIE,
 	.nlanes			= 1,
 
+	.main = {
 	.serdes_tbl		= ipq8074_pcie_gen3_serdes_tbl,
 	.serdes_tbl_num		= ARRAY_SIZE(ipq8074_pcie_gen3_serdes_tbl),
 	.tx_tbl			= ipq8074_pcie_gen3_tx_tbl,
@@ -1554,6 +1556,7 @@ static const struct qmp_phy_cfg ipq8074_pciephy_gen3_cfg = {
 	.rx_tbl_num		= ARRAY_SIZE(ipq8074_pcie_gen3_rx_tbl),
 	.pcs_tbl		= ipq8074_pcie_gen3_pcs_tbl,
 	.pcs_tbl_num		= ARRAY_SIZE(ipq8074_pcie_gen3_pcs_tbl),
+	},
 	.clk_list		= ipq8074_pciephy_clk_l,
 	.num_clks		= ARRAY_SIZE(ipq8074_pciephy_clk_l),
 	.reset_list		= ipq8074_pciephy_reset_l,
@@ -1576,6 +1579,7 @@ static const struct qmp_phy_cfg ipq6018_pciephy_cfg = {
 	.type			= PHY_TYPE_PCIE,
 	.nlanes			= 1,
 
+	.main = {
 	.serdes_tbl		= ipq6018_pcie_serdes_tbl,
 	.serdes_tbl_num		= ARRAY_SIZE(ipq6018_pcie_serdes_tbl),
 	.tx_tbl			= ipq6018_pcie_tx_tbl,
@@ -1586,6 +1590,7 @@ static const struct qmp_phy_cfg ipq6018_pciephy_cfg = {
 	.pcs_tbl_num		= ARRAY_SIZE(ipq6018_pcie_pcs_tbl),
 	.pcs_misc_tbl		= ipq6018_pcie_pcs_misc_tbl,
 	.pcs_misc_tbl_num	= ARRAY_SIZE(ipq6018_pcie_pcs_misc_tbl),
+	},
 	.clk_list		= ipq8074_pciephy_clk_l,
 	.num_clks		= ARRAY_SIZE(ipq8074_pciephy_clk_l),
 	.reset_list		= ipq8074_pciephy_reset_l,
@@ -1606,6 +1611,7 @@ static const struct qmp_phy_cfg sdm845_qmp_pciephy_cfg = {
 	.type = PHY_TYPE_PCIE,
 	.nlanes = 1,
 
+	.main = {
 	.serdes_tbl		= sdm845_qmp_pcie_serdes_tbl,
 	.serdes_tbl_num		= ARRAY_SIZE(sdm845_qmp_pcie_serdes_tbl),
 	.tx_tbl			= sdm845_qmp_pcie_tx_tbl,
@@ -1616,6 +1622,7 @@ static const struct qmp_phy_cfg sdm845_qmp_pciephy_cfg = {
 	.pcs_tbl_num		= ARRAY_SIZE(sdm845_qmp_pcie_pcs_tbl),
 	.pcs_misc_tbl		= sdm845_qmp_pcie_pcs_misc_tbl,
 	.pcs_misc_tbl_num	= ARRAY_SIZE(sdm845_qmp_pcie_pcs_misc_tbl),
+	},
 	.clk_list		= sdm845_pciephy_clk_l,
 	.num_clks		= ARRAY_SIZE(sdm845_pciephy_clk_l),
 	.reset_list		= sdm845_pciephy_reset_l,
@@ -1637,6 +1644,7 @@ static const struct qmp_phy_cfg sdm845_qhp_pciephy_cfg = {
 	.type = PHY_TYPE_PCIE,
 	.nlanes = 1,
 
+	.main = {
 	.serdes_tbl		= sdm845_qhp_pcie_serdes_tbl,
 	.serdes_tbl_num		= ARRAY_SIZE(sdm845_qhp_pcie_serdes_tbl),
 	.tx_tbl			= sdm845_qhp_pcie_tx_tbl,
@@ -1645,6 +1653,7 @@ static const struct qmp_phy_cfg sdm845_qhp_pciephy_cfg = {
 	.rx_tbl_num		= ARRAY_SIZE(sdm845_qhp_pcie_rx_tbl),
 	.pcs_tbl		= sdm845_qhp_pcie_pcs_tbl,
 	.pcs_tbl_num		= ARRAY_SIZE(sdm845_qhp_pcie_pcs_tbl),
+	},
 	.clk_list		= sdm845_pciephy_clk_l,
 	.num_clks		= ARRAY_SIZE(sdm845_pciephy_clk_l),
 	.reset_list		= sdm845_pciephy_reset_l,
@@ -1666,24 +1675,28 @@ static const struct qmp_phy_cfg sm8250_qmp_gen3x1_pciephy_cfg = {
 	.type = PHY_TYPE_PCIE,
 	.nlanes = 1,
 
+	.main = {
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
+	.secondary = {
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
@@ -1705,24 +1718,28 @@ static const struct qmp_phy_cfg sm8250_qmp_gen3x2_pciephy_cfg = {
 	.type = PHY_TYPE_PCIE,
 	.nlanes = 2,
 
+	.main = {
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
+	.secondary = {
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
@@ -1745,6 +1762,7 @@ static const struct qmp_phy_cfg msm8998_pciephy_cfg = {
 	.type			= PHY_TYPE_PCIE,
 	.nlanes			= 1,
 
+	.main = {
 	.serdes_tbl		= msm8998_pcie_serdes_tbl,
 	.serdes_tbl_num		= ARRAY_SIZE(msm8998_pcie_serdes_tbl),
 	.tx_tbl			= msm8998_pcie_tx_tbl,
@@ -1753,6 +1771,7 @@ static const struct qmp_phy_cfg msm8998_pciephy_cfg = {
 	.rx_tbl_num		= ARRAY_SIZE(msm8998_pcie_rx_tbl),
 	.pcs_tbl		= msm8998_pcie_pcs_tbl,
 	.pcs_tbl_num		= ARRAY_SIZE(msm8998_pcie_pcs_tbl),
+	},
 	.clk_list		= msm8996_phy_clk_l,
 	.num_clks		= ARRAY_SIZE(msm8996_phy_clk_l),
 	.reset_list		= ipq8074_pciephy_reset_l,
@@ -1770,6 +1789,7 @@ static const struct qmp_phy_cfg sc8180x_pciephy_cfg = {
 	.type = PHY_TYPE_PCIE,
 	.nlanes = 1,
 
+	.main = {
 	.serdes_tbl		= sc8180x_qmp_pcie_serdes_tbl,
 	.serdes_tbl_num		= ARRAY_SIZE(sc8180x_qmp_pcie_serdes_tbl),
 	.tx_tbl			= sc8180x_qmp_pcie_tx_tbl,
@@ -1780,6 +1800,7 @@ static const struct qmp_phy_cfg sc8180x_pciephy_cfg = {
 	.pcs_tbl_num		= ARRAY_SIZE(sc8180x_qmp_pcie_pcs_tbl),
 	.pcs_misc_tbl		= sc8180x_qmp_pcie_pcs_misc_tbl,
 	.pcs_misc_tbl_num	= ARRAY_SIZE(sc8180x_qmp_pcie_pcs_misc_tbl),
+	},
 	.clk_list		= sdm845_pciephy_clk_l,
 	.num_clks		= ARRAY_SIZE(sdm845_pciephy_clk_l),
 	.reset_list		= sdm845_pciephy_reset_l,
@@ -1800,6 +1821,7 @@ static const struct qmp_phy_cfg sdx55_qmp_pciephy_cfg = {
 	.type = PHY_TYPE_PCIE,
 	.nlanes = 2,
 
+	.main = {
 	.serdes_tbl		= sdx55_qmp_pcie_serdes_tbl,
 	.serdes_tbl_num		= ARRAY_SIZE(sdx55_qmp_pcie_serdes_tbl),
 	.tx_tbl			= sdx55_qmp_pcie_tx_tbl,
@@ -1810,6 +1832,7 @@ static const struct qmp_phy_cfg sdx55_qmp_pciephy_cfg = {
 	.pcs_tbl_num		= ARRAY_SIZE(sdx55_qmp_pcie_pcs_tbl),
 	.pcs_misc_tbl		= sdx55_qmp_pcie_pcs_misc_tbl,
 	.pcs_misc_tbl_num	= ARRAY_SIZE(sdx55_qmp_pcie_pcs_misc_tbl),
+	},
 	.clk_list		= sdm845_pciephy_clk_l,
 	.num_clks		= ARRAY_SIZE(sdm845_pciephy_clk_l),
 	.reset_list		= sdm845_pciephy_reset_l,
@@ -1832,6 +1855,7 @@ static const struct qmp_phy_cfg sm8450_qmp_gen3x1_pciephy_cfg = {
 	.type = PHY_TYPE_PCIE,
 	.nlanes = 1,
 
+	.main = {
 	.serdes_tbl		= sm8450_qmp_gen3x1_pcie_serdes_tbl,
 	.serdes_tbl_num		= ARRAY_SIZE(sm8450_qmp_gen3x1_pcie_serdes_tbl),
 	.tx_tbl			= sm8450_qmp_gen3x1_pcie_tx_tbl,
@@ -1842,6 +1866,7 @@ static const struct qmp_phy_cfg sm8450_qmp_gen3x1_pciephy_cfg = {
 	.pcs_tbl_num		= ARRAY_SIZE(sm8450_qmp_gen3x1_pcie_pcs_tbl),
 	.pcs_misc_tbl		= sm8450_qmp_gen3x1_pcie_pcs_misc_tbl,
 	.pcs_misc_tbl_num	= ARRAY_SIZE(sm8450_qmp_gen3x1_pcie_pcs_misc_tbl),
+	},
 	.clk_list		= sdm845_pciephy_clk_l,
 	.num_clks		= ARRAY_SIZE(sdm845_pciephy_clk_l),
 	.reset_list		= sdm845_pciephy_reset_l,
@@ -1863,6 +1888,7 @@ static const struct qmp_phy_cfg sm8450_qmp_gen4x2_pciephy_cfg = {
 	.type = PHY_TYPE_PCIE,
 	.nlanes = 2,
 
+	.main = {
 	.serdes_tbl		= sm8450_qmp_gen4x2_pcie_serdes_tbl,
 	.serdes_tbl_num		= ARRAY_SIZE(sm8450_qmp_gen4x2_pcie_serdes_tbl),
 	.tx_tbl			= sm8450_qmp_gen4x2_pcie_tx_tbl,
@@ -1873,6 +1899,7 @@ static const struct qmp_phy_cfg sm8450_qmp_gen4x2_pciephy_cfg = {
 	.pcs_tbl_num		= ARRAY_SIZE(sm8450_qmp_gen4x2_pcie_pcs_tbl),
 	.pcs_misc_tbl		= sm8450_qmp_gen4x2_pcie_pcs_misc_tbl,
 	.pcs_misc_tbl_num	= ARRAY_SIZE(sm8450_qmp_gen4x2_pcie_pcs_misc_tbl),
+	},
 	.clk_list		= sdm845_pciephy_clk_l,
 	.num_clks		= ARRAY_SIZE(sdm845_pciephy_clk_l),
 	.reset_list		= sdm845_pciephy_reset_l,
@@ -1926,12 +1953,9 @@ static int qcom_qmp_phy_pcie_serdes_init(struct qmp_phy *qphy)
 {
 	const struct qmp_phy_cfg *cfg = qphy->cfg;
 	void __iomem *serdes = qphy->serdes;
-	const struct qmp_phy_init_tbl *serdes_tbl = cfg->serdes_tbl;
-	int serdes_tbl_num = cfg->serdes_tbl_num;
 
-	qcom_qmp_phy_pcie_configure(serdes, cfg->regs, serdes_tbl, serdes_tbl_num);
-	qcom_qmp_phy_pcie_configure(serdes, cfg->regs, cfg->serdes_tbl_sec,
-				       cfg->serdes_tbl_num_sec);
+	qcom_qmp_phy_pcie_configure(serdes, cfg->regs, cfg->main.serdes_tbl, cfg->main.serdes_tbl_num);
+	qcom_qmp_phy_pcie_configure(serdes, cfg->regs, cfg->secondary.serdes_tbl, cfg->secondary.serdes_tbl_num);
 
 	return 0;
 }
@@ -2035,40 +2059,41 @@ static int qcom_qmp_phy_pcie_power_on(struct phy *phy)
 
 	/* Tx, Rx, and PCS configurations */
 	qcom_qmp_phy_pcie_configure_lane(tx, cfg->regs,
-				    cfg->tx_tbl, cfg->tx_tbl_num, 1);
-	qcom_qmp_phy_pcie_configure_lane(tx, cfg->regs, cfg->tx_tbl_sec,
-					    cfg->tx_tbl_num_sec, 1);
+					 cfg->main.tx_tbl, cfg->main.tx_tbl_num, 1);
+	qcom_qmp_phy_pcie_configure_lane(tx, cfg->regs,
+					 cfg->secondary.tx_tbl, cfg->secondary.tx_tbl_num, 1);
 
 	/* Configuration for other LANE for USB-DP combo PHY */
 	if (cfg->is_dual_lane_phy) {
 		qcom_qmp_phy_pcie_configure_lane(qphy->tx2, cfg->regs,
-					    cfg->tx_tbl, cfg->tx_tbl_num, 2);
+						 cfg->main.tx_tbl, cfg->main.tx_tbl_num, 2);
 		qcom_qmp_phy_pcie_configure_lane(qphy->tx2, cfg->regs,
-						    cfg->tx_tbl_sec,
-						    cfg->tx_tbl_num_sec, 2);
+						 cfg->secondary.tx_tbl, cfg->secondary.tx_tbl_num, 2);
 	}
 
 	qcom_qmp_phy_pcie_configure_lane(rx, cfg->regs,
-				    cfg->rx_tbl, cfg->rx_tbl_num, 1);
+					 cfg->main.rx_tbl, cfg->main.rx_tbl_num, 1);
 	qcom_qmp_phy_pcie_configure_lane(rx, cfg->regs,
-					    cfg->rx_tbl_sec, cfg->rx_tbl_num_sec, 1);
+					 cfg->secondary.rx_tbl, cfg->secondary.rx_tbl_num, 1);
 
 	if (cfg->is_dual_lane_phy) {
 		qcom_qmp_phy_pcie_configure_lane(qphy->rx2, cfg->regs,
-					    cfg->rx_tbl, cfg->rx_tbl_num, 2);
+						 cfg->main.rx_tbl, cfg->main.rx_tbl_num, 2);
 		qcom_qmp_phy_pcie_configure_lane(qphy->rx2, cfg->regs,
-						    cfg->rx_tbl_sec,
-						    cfg->rx_tbl_num_sec, 2);
+						 cfg->secondary.rx_tbl, cfg->secondary.rx_tbl_num, 2);
 	}
 
-	qcom_qmp_phy_pcie_configure(pcs, cfg->regs, cfg->pcs_tbl, cfg->pcs_tbl_num);
-	qcom_qmp_phy_pcie_configure(pcs, cfg->regs, cfg->pcs_tbl_sec,
-				       cfg->pcs_tbl_num_sec);
-
-	qcom_qmp_phy_pcie_configure(pcs_misc, cfg->regs, cfg->pcs_misc_tbl,
-			       cfg->pcs_misc_tbl_num);
-	qcom_qmp_phy_pcie_configure(pcs_misc, cfg->regs, cfg->pcs_misc_tbl_sec,
-				       cfg->pcs_misc_tbl_num_sec);
+	qcom_qmp_phy_pcie_configure(pcs, cfg->regs,
+				    cfg->main.pcs_tbl, cfg->main.pcs_tbl_num);
+	qcom_qmp_phy_pcie_configure(pcs, cfg->regs,
+				    cfg->secondary.pcs_tbl, cfg->secondary.pcs_tbl_num);
+
+	qcom_qmp_phy_pcie_configure(pcs_misc, cfg->regs,
+				    cfg->main.pcs_misc_tbl,
+				    cfg->main.pcs_misc_tbl_num);
+	qcom_qmp_phy_pcie_configure(pcs_misc, cfg->regs,
+				    cfg->secondary.pcs_misc_tbl,
+				    cfg->secondary.pcs_misc_tbl_num);
 
 	/*
 	 * Pull out PHY from POWER DOWN state.
-- 
2.35.1

