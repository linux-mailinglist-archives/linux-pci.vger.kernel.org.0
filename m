Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85DF15B3354
	for <lists+linux-pci@lfdr.de>; Fri,  9 Sep 2022 11:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbiIIJOu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Sep 2022 05:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232119AbiIIJOr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Sep 2022 05:14:47 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B2E1B7E5
        for <linux-pci@vger.kernel.org>; Fri,  9 Sep 2022 02:14:43 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id v6so1127888ljj.0
        for <linux-pci@vger.kernel.org>; Fri, 09 Sep 2022 02:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=c6Bo/uoa0XY0JEtnOx/QwekPxbXR192GKM+6+VpQ4dg=;
        b=T/Y/v0IZK72mKXZqSgxNM+cVa0CTnPCbNXrSDc0Qvl79qcxao8NDyKXyKAnuHxLBZ0
         LHIqMCGjxMgQXC0PVweGJibI2qNscfQS4UxfXnmP3Pe2PrSVrui7T0agi7rQercpqd95
         qoVtybPtN9OHWBu4q6/rWBGOKfm1d2XxMJTIpIusMFxkHCN+fePgNtGjUBVet64bzzQo
         SDLxtK65U4VZqt2eClwVP4t0+7W7lVr207gpiKn4SrW22jLz1bQNgToXrvXRYgC0BtsB
         bVBNg19F1haQkjDvlx7WuNdafC06i/f0D9JUwU1VPEfepYm40hRHZ1Ro+bryZkmCA3no
         /HCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=c6Bo/uoa0XY0JEtnOx/QwekPxbXR192GKM+6+VpQ4dg=;
        b=SvxPHj6y9Kl++BuWu0cr+RErzpegO3PwSXSVO86q0/SBxwiqLKUIEyWwXvu/A5xGbU
         yzun7RzhRMwuAhqWbL91cqMidJdfwk9nIYMH5TQfD3AQQhiQGygvF2nf2S8NMaLybYsu
         eudL2esVQslpO2wSpc0tlZDylcat5fDkcqbteyIxPaxvAh2ZR+gpj/pbGqzTh7RnemZQ
         VRruLcmxBmxzFxeTC79pk2HyZwfQt0Avs6Yn/ONHp1ItYCAy6ogsuZUiQaBNMt7ALhaq
         DzQctyy1Y7/9ntNMfr0nCuar14KTe1JdzgFFM+yFFswa6i+BUoBO5ZI4JBZy/cPMtWah
         n+Ng==
X-Gm-Message-State: ACgBeo2ViWaRX1DXOH8xYZrrKljKU9zioI+02/nZXPAtKXaR1ONQ+3AF
        SXQSCB1BijQY62AUTtYm/hiB2g==
X-Google-Smtp-Source: AA6agR5UduAA1QJ3K0GJ05p6BcClCZndDN9i4HfZ2IhJLgcyNF2WunegL9LNoQHv/tmL9kxQUgCneQ==
X-Received: by 2002:a05:651c:1108:b0:26b:e28a:535f with SMTP id e8-20020a05651c110800b0026be28a535fmr766859ljo.261.1662714881456;
        Fri, 09 Sep 2022 02:14:41 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id z26-20020a2e4c1a000000b0026acbb6ed1asm201615lja.66.2022.09.09.02.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 02:14:41 -0700 (PDT)
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
Subject: [PATCH v3 7/9] phy: qcom-qmp-pcie: Support SM8450 PCIe1 PHY in EP mode
Date:   Fri,  9 Sep 2022 12:14:31 +0300
Message-Id: <20220909091433.3715981-8-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220909091433.3715981-1-dmitry.baryshkov@linaro.org>
References: <20220909091433.3715981-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support for using PCIe1 (gen4x2) in EP mode on SM8450. The tables to
program are mostly common with the RC mode tables, so only register
difference are split into separate RC and EP tables.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c      | 78 +++++++++++++++----
 .../qualcomm/phy-qcom-qmp-pcs-pcie-v5_20.h    |  1 +
 2 files changed, 64 insertions(+), 15 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
index d945e8c61811..423639f2244f 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
@@ -1228,15 +1228,29 @@ static const struct qmp_phy_init_tbl sm8450_qmp_gen3x1_pcie_pcs_misc_tbl[] = {
 };
 
 static const struct qmp_phy_init_tbl sm8450_qmp_gen4x2_pcie_serdes_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_BIAS_EN_CLKBUFLR_EN, 0x14),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_PLL_IVCO, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_LOCK_CMP_EN, 0x46),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_LOCK_CMP_CFG, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_VCO_TUNE_MAP, 0x02),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_HSCLK_SEL, 0x12),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_HSCLK_HS_SWITCH_SEL, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_CORECLK_DIV_MODE0, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_CORECLK_DIV_MODE1, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_CMN_MISC1, 0x88),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_CMN_CONFIG, 0x06),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_CMN_MODE, 0x14),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_VCO_DC_LEVEL_CTRL, 0x0f),
+};
+
+static const struct qmp_phy_init_tbl sm8450_qmp_gen4x2_pcie_rc_serdes_tbl[] = {
 	QMP_PHY_INIT_CFG(QSERDES_V5_COM_SSC_PER1, 0x31),
 	QMP_PHY_INIT_CFG(QSERDES_V5_COM_SSC_PER2, 0x01),
 	QMP_PHY_INIT_CFG(QSERDES_V5_COM_SSC_STEP_SIZE1_MODE0, 0xde),
 	QMP_PHY_INIT_CFG(QSERDES_V5_COM_SSC_STEP_SIZE2_MODE0, 0x07),
 	QMP_PHY_INIT_CFG(QSERDES_V5_COM_SSC_STEP_SIZE1_MODE1, 0x97),
 	QMP_PHY_INIT_CFG(QSERDES_V5_COM_SSC_STEP_SIZE2_MODE1, 0x0c),
-	QMP_PHY_INIT_CFG(QSERDES_V5_COM_BIAS_EN_CLKBUFLR_EN, 0x14),
 	QMP_PHY_INIT_CFG(QSERDES_V5_COM_CLK_ENABLE1, 0x90),
-	QMP_PHY_INIT_CFG(QSERDES_V5_COM_PLL_IVCO, 0x0f),
 	QMP_PHY_INIT_CFG(QSERDES_V5_COM_CP_CTRL_MODE0, 0x06),
 	QMP_PHY_INIT_CFG(QSERDES_V5_COM_CP_CTRL_MODE1, 0x06),
 	QMP_PHY_INIT_CFG(QSERDES_V5_COM_PLL_RCTRL_MODE0, 0x16),
@@ -1244,8 +1258,6 @@ static const struct qmp_phy_init_tbl sm8450_qmp_gen4x2_pcie_serdes_tbl[] = {
 	QMP_PHY_INIT_CFG(QSERDES_V5_COM_PLL_CCTRL_MODE0, 0x36),
 	QMP_PHY_INIT_CFG(QSERDES_V5_COM_PLL_CCTRL_MODE1, 0x36),
 	QMP_PHY_INIT_CFG(QSERDES_V5_COM_SYSCLK_EN_SEL, 0x08),
-	QMP_PHY_INIT_CFG(QSERDES_V5_COM_LOCK_CMP_EN, 0x46),
-	QMP_PHY_INIT_CFG(QSERDES_V5_COM_LOCK_CMP_CFG, 0x04),
 	QMP_PHY_INIT_CFG(QSERDES_V5_COM_LOCK_CMP1_MODE0, 0x0a),
 	QMP_PHY_INIT_CFG(QSERDES_V5_COM_LOCK_CMP2_MODE0, 0x1a),
 	QMP_PHY_INIT_CFG(QSERDES_V5_COM_LOCK_CMP1_MODE1, 0x14),
@@ -1258,17 +1270,8 @@ static const struct qmp_phy_init_tbl sm8450_qmp_gen4x2_pcie_serdes_tbl[] = {
 	QMP_PHY_INIT_CFG(QSERDES_V5_COM_DIV_FRAC_START1_MODE1, 0x55),
 	QMP_PHY_INIT_CFG(QSERDES_V5_COM_DIV_FRAC_START2_MODE1, 0x55),
 	QMP_PHY_INIT_CFG(QSERDES_V5_COM_DIV_FRAC_START3_MODE1, 0x05),
-	QMP_PHY_INIT_CFG(QSERDES_V5_COM_VCO_TUNE_MAP, 0x02),
 	QMP_PHY_INIT_CFG(QSERDES_V5_COM_CLK_SELECT, 0x34),
-	QMP_PHY_INIT_CFG(QSERDES_V5_COM_HSCLK_SEL, 0x12),
-	QMP_PHY_INIT_CFG(QSERDES_V5_COM_HSCLK_HS_SWITCH_SEL, 0x00),
-	QMP_PHY_INIT_CFG(QSERDES_V5_COM_CORECLK_DIV_MODE0, 0x0a),
-	QMP_PHY_INIT_CFG(QSERDES_V5_COM_CORECLK_DIV_MODE1, 0x04),
-	QMP_PHY_INIT_CFG(QSERDES_V5_COM_CMN_MISC1, 0x88),
 	QMP_PHY_INIT_CFG(QSERDES_V5_COM_CORE_CLK_EN, 0x20),
-	QMP_PHY_INIT_CFG(QSERDES_V5_COM_CMN_CONFIG, 0x06),
-	QMP_PHY_INIT_CFG(QSERDES_V5_COM_CMN_MODE, 0x14),
-	QMP_PHY_INIT_CFG(QSERDES_V5_COM_VCO_DC_LEVEL_CTRL, 0x0f),
 };
 
 static const struct qmp_phy_init_tbl sm8450_qmp_gen4x2_pcie_tx_tbl[] = {
@@ -1336,14 +1339,44 @@ static const struct qmp_phy_init_tbl sm8450_qmp_gen4x2_pcie_pcs_tbl[] = {
 };
 
 static const struct qmp_phy_init_tbl sm8450_qmp_gen4x2_pcie_pcs_misc_tbl[] = {
-	QMP_PHY_INIT_CFG(QPHY_V5_20_PCS_PCIE_ENDPOINT_REFCLK_DRIVE, 0xc1),
-	QMP_PHY_INIT_CFG(QPHY_V5_20_PCS_PCIE_OSC_DTCT_ACTIONS, 0x00),
 	QMP_PHY_INIT_CFG(QPHY_V5_20_PCS_PCIE_G4_EQ_CONFIG5, 0x02),
 	QMP_PHY_INIT_CFG(QPHY_V5_20_PCS_PCIE_EQ_CONFIG1, 0x16),
 	QMP_PHY_INIT_CFG(QPHY_V5_20_PCS_PCIE_RX_MARGINING_CONFIG3, 0x28),
 	QMP_PHY_INIT_CFG(QPHY_V5_20_PCS_PCIE_G4_PRE_GAIN, 0x2e),
 };
 
+static const struct qmp_phy_init_tbl sm8450_qmp_gen4x2_pcie_rc_pcs_misc_tbl[] = {
+	QMP_PHY_INIT_CFG(QPHY_V5_20_PCS_PCIE_ENDPOINT_REFCLK_DRIVE, 0xc1),
+	QMP_PHY_INIT_CFG(QPHY_V5_20_PCS_PCIE_OSC_DTCT_ACTIONS, 0x00),
+};
+
+static const struct qmp_phy_init_tbl sm8450_qmp_gen4x2_pcie_ep_serdes_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_BG_TIMER, 0x02),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_SYS_CLK_CTRL, 0x07),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_CP_CTRL_MODE0, 0x27),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_CP_CTRL_MODE1, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_PLL_RCTRL_MODE0, 0x17),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_PLL_RCTRL_MODE1, 0x19),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_PLL_CCTRL_MODE0, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_PLL_CCTRL_MODE1, 0x03),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_SYSCLK_EN_SEL, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_LOCK_CMP1_MODE0, 0xff),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_LOCK_CMP2_MODE0, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_LOCK_CMP1_MODE1, 0xff),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_LOCK_CMP2_MODE1, 0x09),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_DEC_START_MODE0, 0x19),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_DEC_START_MODE1, 0x28),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_INTEGLOOP_GAIN0_MODE0, 0xfb),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_INTEGLOOP_GAIN1_MODE0, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_INTEGLOOP_GAIN0_MODE1, 0xfb),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_INTEGLOOP_GAIN1_MODE1, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_CORE_CLK_EN, 0x60),
+};
+
+static const struct qmp_phy_init_tbl sm8450_qmp_gen4x2_pcie_ep_pcs_misc_tbl[] = {
+	QMP_PHY_INIT_CFG(QPHY_V5_20_PCS_PCIE_OSC_DTCT_MODE2_CONFIG5, 0x08),
+};
+
 struct qmp_phy;
 
 struct qmp_phy_cfg_tables {
@@ -1922,6 +1955,21 @@ static const struct qmp_phy_cfg sm8450_qmp_gen4x2_pciephy_cfg = {
 	.pcs_misc_tbl		= sm8450_qmp_gen4x2_pcie_pcs_misc_tbl,
 	.pcs_misc_tbl_num	= ARRAY_SIZE(sm8450_qmp_gen4x2_pcie_pcs_misc_tbl),
 	},
+
+	.secondary_rc = &(struct qmp_phy_cfg_tables) {
+	.serdes_tbl		= sm8450_qmp_gen4x2_pcie_rc_serdes_tbl,
+	.serdes_tbl_num		= ARRAY_SIZE(sm8450_qmp_gen4x2_pcie_rc_serdes_tbl),
+	.pcs_misc_tbl		= sm8450_qmp_gen4x2_pcie_rc_pcs_misc_tbl,
+	.pcs_misc_tbl_num	= ARRAY_SIZE(sm8450_qmp_gen4x2_pcie_rc_pcs_misc_tbl),
+	},
+
+	.secondary_ep = &(struct qmp_phy_cfg_tables) {
+	.serdes_tbl		= sm8450_qmp_gen4x2_pcie_ep_serdes_tbl,
+	.serdes_tbl_num		= ARRAY_SIZE(sm8450_qmp_gen4x2_pcie_ep_serdes_tbl),
+	.pcs_misc_tbl		= sm8450_qmp_gen4x2_pcie_ep_pcs_misc_tbl,
+	.pcs_misc_tbl_num	= ARRAY_SIZE(sm8450_qmp_gen4x2_pcie_ep_pcs_misc_tbl),
+	},
+
 	.clk_list		= sdm845_pciephy_clk_l,
 	.num_clks		= ARRAY_SIZE(sdm845_pciephy_clk_l),
 	.reset_list		= sdm845_pciephy_reset_l,
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v5_20.h b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v5_20.h
index 1eedf50cf9cb..c9fa90b45475 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v5_20.h
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v5_20.h
@@ -8,6 +8,7 @@
 
 /* Only for QMP V5_20 PHY - PCIe PCS registers */
 #define QPHY_V5_20_PCS_PCIE_ENDPOINT_REFCLK_DRIVE	0x01c
+#define QPHY_V5_20_PCS_PCIE_OSC_DTCT_MODE2_CONFIG5	0x084
 #define QPHY_V5_20_PCS_PCIE_OSC_DTCT_ACTIONS		0x090
 #define QPHY_V5_20_PCS_PCIE_EQ_CONFIG1			0x0a0
 #define QPHY_V5_20_PCS_PCIE_G4_EQ_CONFIG5		0x108
-- 
2.35.1

