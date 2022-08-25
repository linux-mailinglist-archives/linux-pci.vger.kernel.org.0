Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C702B5A0E74
	for <lists+linux-pci@lfdr.de>; Thu, 25 Aug 2022 12:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239604AbiHYKuy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Aug 2022 06:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241306AbiHYKux (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 Aug 2022 06:50:53 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E231CAB072
        for <linux-pci@vger.kernel.org>; Thu, 25 Aug 2022 03:50:50 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id d23so23329302lfl.13
        for <linux-pci@vger.kernel.org>; Thu, 25 Aug 2022 03:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=j7dxAbYIMGIryeEHrKbdXz+Lp/GRCM12S1PekH5BM78=;
        b=J4Mhe4KHxcdaXI/zB3VGRJie3Q7h/7HOxzxbJh37jhtS1PJVM8p5KTC0KxNz+tEBDf
         dn3JCnvzYROU/LEfRvUAr8HPSnHrwZlRU1jqnwbwXyHKy7QA+yYqSqu41Ofz6d9HKWiB
         P6o0iHs+At2GK76xmewzVGGPOazlcuwn0FBIsRfFksAgdk4PJMJx++u0zFd/2uBith2f
         HKnWu/hE9vEjfyc81sZ/qoA/FwLoWKS5gaYHnjlVh+kxbBLf5EekEUVs0rM3gjDO0JHu
         Ooc/z2xoJkbBBjqruSjG3qvWuDWH1OvtkWh9dStgoBTybSHRBYQH43D8G6oiN1tAI5Nd
         +ovw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=j7dxAbYIMGIryeEHrKbdXz+Lp/GRCM12S1PekH5BM78=;
        b=w6FuBg0JuIV3AdLJkig3aC4SSs2PdgEUk8Gog2NJX0plF5Ybmg4Pz95vODffJZ8Xl8
         jTtTGrJvo8flKQsnhT8baVsHmUxizwOPeH7MubAYGuAI+nOpTFR+FOVJ8uSp7B2s9LBp
         zqeJeH/XMQzpz5H7W35UlS9+1krCl1eiUiA5CKQ42Jj5F8A2WnAS6o/NuFctb/A9DbIW
         pW6/hqv1HtOo2ThF2C+7KvFFiH2SNziDnscZa8Qq78vA/m4mde6aH9EhCYC6r6/62w0S
         +HOyy9m/Dg3sh2+2LfP4ANnkfElNepg2iAl5yAmJrdxoi0g1pTHwBTXNyE7VMSnpFYM+
         rkog==
X-Gm-Message-State: ACgBeo3vrndwvWuP9KuiTmEPrMdCuXMy7d3XP7PrJkUD3MVKkznprfLM
        GhzSdBETjKsiTo33kXk1YlkyLw==
X-Google-Smtp-Source: AA6agR7HGe16ii4v20JBmU8GSM2IHxu1jxvU6p6sphSg419cxlyYrBud3HYfA1vvyQLpdsrtznIBOA==
X-Received: by 2002:a05:6512:3409:b0:48a:ef20:dda with SMTP id i9-20020a056512340900b0048aef200ddamr1091458lfr.649.1661424649026;
        Thu, 25 Aug 2022 03:50:49 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id u14-20020ac258ce000000b00492f49037dfsm429609lfo.152.2022.08.25.03.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 03:50:48 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>, Bjorn Andersson <bjorn@kryo.se>,
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
Subject: [PATCH v2 3/6] phy: qcom-qmp-pcie: support separate tables for EP mode
Date:   Thu, 25 Aug 2022 13:50:41 +0300
Message-Id: <20220825105044.636209-4-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220825105044.636209-1-dmitry.baryshkov@linaro.org>
References: <20220825105044.636209-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The PCIe QMP PHY requires different programming sequences when being
used for the RC (Root Complex) or for the EP (End Point) modes. Allow
selecting the submode and thus selecting a set of PHY programming
tables.

Since the RC and EP modes share common some common init sequence, the
common sequence is kept in the primary table and the different ones were
in secondary.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 57 ++++++++++++++++++------
 1 file changed, 44 insertions(+), 13 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
index 60cbd2eae346..9a5356d69c70 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
@@ -1369,10 +1369,14 @@ struct qmp_phy_cfg {
 	/* Init sequence for PHY blocks - serdes, tx, rx, pcs */
 	struct qmp_phy_cfg_tables primary;
 	/*
-	 * Init sequence for PHY blocks, providing additional register
-	 * programming. Unless required it can be left omitted.
+	 * Init sequences for PHY blocks, providing additional register
+	 * programming. They are used for providing separate sequences for the
+	 * Root Complex and for the End Point usecases.
+	 *
+	 * If EP mode is not supported, both tables can be left empty.
 	 */
-	struct qmp_phy_cfg_tables secondary;
+	struct qmp_phy_cfg_tables secondary_rc; /* for the RC only */
+	struct qmp_phy_cfg_tables secondary_ep; /* for the EP only */
 
 	/* clock ids to be requested */
 	const char * const *clk_list;
@@ -1422,6 +1426,7 @@ struct qmp_phy_cfg {
  * @index: lane index
  * @qmp: QMP phy to which this lane belongs
  * @mode: current PHY mode
+ * @secondary: currently selected PHY secondary init table set
  */
 struct qmp_phy {
 	struct phy *phy;
@@ -1434,6 +1439,7 @@ struct qmp_phy {
 	void __iomem *rx2;
 	void __iomem *pcs_misc;
 	struct clk *pipe_clk;
+	const struct qmp_phy_cfg_tables *secondary;
 	unsigned int index;
 	struct qcom_qmp *qmp;
 	enum phy_mode mode;
@@ -1687,7 +1693,15 @@ static const struct qmp_phy_cfg sm8250_qmp_gen3x1_pciephy_cfg = {
 	.pcs_misc_tbl		= sm8250_qmp_pcie_pcs_misc_tbl,
 	.pcs_misc_tbl_num	= ARRAY_SIZE(sm8250_qmp_pcie_pcs_misc_tbl),
 	},
-	.secondary = {
+	/*
+	 * For sm8250 the split between the primary and secondary_rc tables is
+	 * historical, it reflects the programming sequence common to all PCIe
+	 * PHYs on this platform and a sequence required for this particular
+	 * PHY type. If EP support for sm8250 is required, the
+	 * primary/secondary_rc split is to be reconsidered and adjusted
+	 * according to EP programming sequence.
+	 */
+	.secondary_rc = {
 	.serdes_tbl		= sm8250_qmp_gen3x1_pcie_serdes_tbl,
 	.serdes_tbl_num		= ARRAY_SIZE(sm8250_qmp_gen3x1_pcie_serdes_tbl),
 	.rx_tbl			= sm8250_qmp_gen3x1_pcie_rx_tbl,
@@ -1730,7 +1744,15 @@ static const struct qmp_phy_cfg sm8250_qmp_gen3x2_pciephy_cfg = {
 	.pcs_misc_tbl		= sm8250_qmp_pcie_pcs_misc_tbl,
 	.pcs_misc_tbl_num	= ARRAY_SIZE(sm8250_qmp_pcie_pcs_misc_tbl),
 	},
-	.secondary = {
+	/*
+	 * For sm8250 the split between the primary and secondary_rc tables is
+	 * historical, it reflects the programming sequence common to all PCIe
+	 * PHYs on this platform and a sequence required for this particular
+	 * PHY type. If EP support for sm8250 is required, the
+	 * primary/secondary_rc split is to be reconsidered and adjusted
+	 * according to EP programming sequence.
+	 */
+	.secondary_rc = {
 	.tx_tbl			= sm8250_qmp_gen3x2_pcie_tx_tbl,
 	.tx_tbl_num		= ARRAY_SIZE(sm8250_qmp_gen3x2_pcie_tx_tbl),
 	.rx_tbl			= sm8250_qmp_gen3x2_pcie_rx_tbl,
@@ -1955,7 +1977,7 @@ static int qcom_qmp_phy_pcie_serdes_init(struct qmp_phy *qphy)
 	void __iomem *serdes = qphy->serdes;
 
 	qcom_qmp_phy_pcie_configure(serdes, cfg->regs, cfg->primary.serdes_tbl, cfg->primary.serdes_tbl_num);
-	qcom_qmp_phy_pcie_configure(serdes, cfg->regs, cfg->secondary.serdes_tbl, cfg->secondary.serdes_tbl_num);
+	qcom_qmp_phy_pcie_configure(serdes, cfg->regs, qphy->secondary->serdes_tbl, qphy->secondary->serdes_tbl_num);
 
 	return 0;
 }
@@ -2049,6 +2071,10 @@ static int qcom_qmp_phy_pcie_power_on(struct phy *phy)
 	unsigned int mask, val, ready;
 	int ret;
 
+	/* Default to RC mode if the mode was not selected using phy_set_mode_ext() */
+	if (!qphy->secondary)
+		qphy->secondary = &cfg->secondary_rc;
+
 	qcom_qmp_phy_pcie_serdes_init(qphy);
 
 	ret = clk_prepare_enable(qphy->pipe_clk);
@@ -2061,39 +2087,39 @@ static int qcom_qmp_phy_pcie_power_on(struct phy *phy)
 	qcom_qmp_phy_pcie_configure_lane(tx, cfg->regs,
 					 cfg->primary.tx_tbl, cfg->primary.tx_tbl_num, 1);
 	qcom_qmp_phy_pcie_configure_lane(tx, cfg->regs,
-					 cfg->secondary.tx_tbl, cfg->secondary.tx_tbl_num, 1);
+					 qphy->secondary->tx_tbl, qphy->secondary->tx_tbl_num, 1);
 
 	/* Configuration for other LANE for USB-DP combo PHY */
 	if (cfg->is_dual_lane_phy) {
 		qcom_qmp_phy_pcie_configure_lane(qphy->tx2, cfg->regs,
 						 cfg->primary.tx_tbl, cfg->primary.tx_tbl_num, 2);
 		qcom_qmp_phy_pcie_configure_lane(qphy->tx2, cfg->regs,
-						 cfg->secondary.tx_tbl, cfg->secondary.tx_tbl_num, 2);
+						 qphy->secondary->tx_tbl, qphy->secondary->tx_tbl_num, 2);
 	}
 
 	qcom_qmp_phy_pcie_configure_lane(rx, cfg->regs,
 					 cfg->primary.rx_tbl, cfg->primary.rx_tbl_num, 1);
 	qcom_qmp_phy_pcie_configure_lane(rx, cfg->regs,
-					 cfg->secondary.rx_tbl, cfg->secondary.rx_tbl_num, 1);
+					 qphy->secondary->rx_tbl, qphy->secondary->rx_tbl_num, 1);
 
 	if (cfg->is_dual_lane_phy) {
 		qcom_qmp_phy_pcie_configure_lane(qphy->rx2, cfg->regs,
 						 cfg->primary.rx_tbl, cfg->primary.rx_tbl_num, 2);
 		qcom_qmp_phy_pcie_configure_lane(qphy->rx2, cfg->regs,
-						 cfg->secondary.rx_tbl, cfg->secondary.rx_tbl_num, 2);
+						 qphy->secondary->rx_tbl, qphy->secondary->rx_tbl_num, 2);
 	}
 
 	qcom_qmp_phy_pcie_configure(pcs, cfg->regs,
 				    cfg->primary.pcs_tbl, cfg->primary.pcs_tbl_num);
 	qcom_qmp_phy_pcie_configure(pcs, cfg->regs,
-				    cfg->secondary.pcs_tbl, cfg->secondary.pcs_tbl_num);
+				    qphy->secondary->pcs_tbl, qphy->secondary->pcs_tbl_num);
 
 	qcom_qmp_phy_pcie_configure(pcs_misc, cfg->regs,
 				    cfg->primary.pcs_misc_tbl,
 				    cfg->primary.pcs_misc_tbl_num);
 	qcom_qmp_phy_pcie_configure(pcs_misc, cfg->regs,
-				    cfg->secondary.pcs_misc_tbl,
-				    cfg->secondary.pcs_misc_tbl_num);
+				    qphy->secondary->pcs_misc_tbl,
+				    qphy->secondary->pcs_misc_tbl_num);
 
 	/*
 	 * Pull out PHY from POWER DOWN state.
@@ -2195,6 +2221,11 @@ static int qcom_qmp_phy_pcie_set_mode(struct phy *phy,
 
 	qphy->mode = mode;
 
+	if (submode)
+		qphy->secondary = &qphy->cfg->secondary_ep;
+	else
+		qphy->secondary = &qphy->cfg->secondary_rc;
+
 	return 0;
 }
 
-- 
2.35.1

