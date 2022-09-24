Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76A735E8E4E
	for <lists+linux-pci@lfdr.de>; Sat, 24 Sep 2022 18:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233935AbiIXQDP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 24 Sep 2022 12:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233928AbiIXQDL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 24 Sep 2022 12:03:11 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9215C39B8F
        for <linux-pci@vger.kernel.org>; Sat, 24 Sep 2022 09:03:09 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id j16so4676935lfg.1
        for <linux-pci@vger.kernel.org>; Sat, 24 Sep 2022 09:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=M5n5dCOKuNZ01cFL9LjAdRZFGkruzMME2BozEvloAHI=;
        b=yQeaw3gG80YxOqTM2BeEAyrcDnFfh5SQCLrNinO9S8q5RpsAnG+pOkB+hVvcgTt6Gy
         nAYmjSQ3o2F/r900k73qFKoF5jM7OmiTaQ2ky//yUrCrkJz8PgQHqsXHVQapUWdfzrTf
         rhOsN/GcTzvo0U1lvBcFwWfO20B6Nh3EjCZBbpHyQGwb+QBsUdbE6XkfQrd/MR4MwYmg
         8RARP6kSpK+GmdcpJ0TuDYumKOjc9g1kWrpJ8JkiqmPPXSwqUsO/+ODvVolR4EWLXZaN
         lbt2UaxNhyRGp0vWRLM4QN4Vpp2WcyMs0H3dNjUMvINjV9UgkZzA+h0p5mCn1pauWJlr
         w0dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=M5n5dCOKuNZ01cFL9LjAdRZFGkruzMME2BozEvloAHI=;
        b=YXTKEXXY4gpbydI0sDsCh4anevwbDs9n+W/0el1z+mww8JuCGso4/iGfQ9yhmah1/w
         Xb/bhUxJvm+/EEOIcTZ1b/cimtPoza1IJx37nTUS1pJ7VGqpUIdc+rtdS5GGecEWnEcL
         zfJ7/O6HKT4YilF5q9umxRTaEYoGZHV5oXwXjktpCMOZkuKijP30oVAX3PPmSk33O2gu
         oIkmI2gcTSdLvOU1Io4D8RZShr9fDcjGoIuiP9ZHT2FhXWTvBQhLGcL8CSlHtdj4+dJ2
         gpvxTXAlkZkakwJtYxsNaxYSTK1nU+7dhDNZVhm1dhep/qz6HAzUak5PG1TNZcBtFFnF
         KC9Q==
X-Gm-Message-State: ACrzQf2eb/Dcp0ZBxWln7AWtXAJkpPkxNthQpJYpI81cRfEYDbNyGgct
        YIkJqHwl0bVSJSkC11+OBnjOdQ==
X-Google-Smtp-Source: AMsMyM6E5YAyujwi28hcEdBdNYnre6OFmBOsKzoPbIE4DmMx9E0GZ5NM9EXQIFPI2+jvDPP4f29caQ==
X-Received: by 2002:ac2:46f9:0:b0:498:f633:8136 with SMTP id q25-20020ac246f9000000b00498f6338136mr5836122lfo.117.1664035387548;
        Sat, 24 Sep 2022 09:03:07 -0700 (PDT)
Received: from eriador.lumag.spb.ru ([95.161.222.31])
        by smtp.gmail.com with ESMTPSA id 9-20020ac25f09000000b00499f9ba6af0sm1928015lfq.207.2022.09.24.09.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Sep 2022 09:03:07 -0700 (PDT)
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
Subject: [PATCH v4 4/6] phy: qcom-qmp-pcie: Support SM8450 PCIe1 PHY in EP mode
Date:   Sat, 24 Sep 2022 19:03:00 +0300
Message-Id: <20220924160302.285875-5-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220924160302.285875-1-dmitry.baryshkov@linaro.org>
References: <20220924160302.285875-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75 autolearn=no autolearn_force=no
        version=3.4.6
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
index 1fc23df59454..6dd4bc771979 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
@@ -1184,15 +1184,29 @@ static const struct qmp_phy_init_tbl sm8450_qmp_gen3x1_pcie_pcs_misc_tbl[] = {
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
@@ -1200,8 +1214,6 @@ static const struct qmp_phy_init_tbl sm8450_qmp_gen4x2_pcie_serdes_tbl[] = {
 	QMP_PHY_INIT_CFG(QSERDES_V5_COM_PLL_CCTRL_MODE0, 0x36),
 	QMP_PHY_INIT_CFG(QSERDES_V5_COM_PLL_CCTRL_MODE1, 0x36),
 	QMP_PHY_INIT_CFG(QSERDES_V5_COM_SYSCLK_EN_SEL, 0x08),
-	QMP_PHY_INIT_CFG(QSERDES_V5_COM_LOCK_CMP_EN, 0x46),
-	QMP_PHY_INIT_CFG(QSERDES_V5_COM_LOCK_CMP_CFG, 0x04),
 	QMP_PHY_INIT_CFG(QSERDES_V5_COM_LOCK_CMP1_MODE0, 0x0a),
 	QMP_PHY_INIT_CFG(QSERDES_V5_COM_LOCK_CMP2_MODE0, 0x1a),
 	QMP_PHY_INIT_CFG(QSERDES_V5_COM_LOCK_CMP1_MODE1, 0x14),
@@ -1214,17 +1226,8 @@ static const struct qmp_phy_init_tbl sm8450_qmp_gen4x2_pcie_serdes_tbl[] = {
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
@@ -1292,14 +1295,44 @@ static const struct qmp_phy_init_tbl sm8450_qmp_gen4x2_pcie_pcs_tbl[] = {
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
 struct qmp_phy_cfg_tables {
 	const struct qmp_phy_init_tbl *serdes_tbl;
 	int serdes_tbl_num;
@@ -1851,6 +1884,21 @@ static const struct qmp_phy_cfg sm8450_qmp_gen4x2_pciephy_cfg = {
 	.pcs_misc_tbl		= sm8450_qmp_gen4x2_pcie_pcs_misc_tbl,
 	.pcs_misc_tbl_num	= ARRAY_SIZE(sm8450_qmp_gen4x2_pcie_pcs_misc_tbl),
 	},
+
+	.extra_rc = &(struct qmp_phy_cfg_tables) {
+	.serdes_tbl		= sm8450_qmp_gen4x2_pcie_rc_serdes_tbl,
+	.serdes_tbl_num		= ARRAY_SIZE(sm8450_qmp_gen4x2_pcie_rc_serdes_tbl),
+	.pcs_misc_tbl		= sm8450_qmp_gen4x2_pcie_rc_pcs_misc_tbl,
+	.pcs_misc_tbl_num	= ARRAY_SIZE(sm8450_qmp_gen4x2_pcie_rc_pcs_misc_tbl),
+	},
+
+	.extra_ep = &(struct qmp_phy_cfg_tables) {
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

