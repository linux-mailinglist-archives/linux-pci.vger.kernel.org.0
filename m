Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE4627EBE5
	for <lists+linux-pci@lfdr.de>; Wed, 30 Sep 2020 17:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730234AbgI3PKE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Sep 2020 11:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729350AbgI3PKD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Sep 2020 11:10:03 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F278C0613D1
        for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2020 08:10:03 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id f1so1210622plo.13
        for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2020 08:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kPU8AfEpU6C5gPe074bJ39/s5D+aIsmTVKO7kO6K6hA=;
        b=cWR8/c//B+b4Qsv3ZZtwMj6KQLePR9YdHRB7SusA+t+3jGGhSwRqrG/l8i2YTEWd+a
         02vEJEh3/Rs7ZWPogTm0WCH8CX3EgGFhzoDs9bFnaX+3GVxNdLkPFohQPKsyXNxcEXPd
         4OYV4bMTS2ym6dcpw9EzXkfoIhI19ozxzyV1I+iC4or2/+mWdDSW2/0RBJbQ6NLfQrMH
         cjCOnZTDvhYRCdvidhwuDYcBKDRdyrLQKbfno7bGzhJYQpwcPrbHDwsQWFNoC7y+xJzh
         yPMnmLAagIipv7A8HgJ/M+tmHLgN4QVQmBP8ef3k9Lujatb+9hZ4LrK7zu9CEOwdNe5w
         W0Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kPU8AfEpU6C5gPe074bJ39/s5D+aIsmTVKO7kO6K6hA=;
        b=m1x/uuFJFAKr5RumIO+iAudm1py8PvQPCF+uxQjAzq5Ql4qbbF32Ao7xnsKihNUC3N
         WdkCWimsBSFWuR45TKdAXfpImiKBQQ4HM+pApQGUKnEa0KpxFjxAupBelxezKuUAQldZ
         VMeXsH3Ho0Pw6IOb9TGlbDF7gt3JxPwUEDVHjPKRu0IMY9Lldctc2TFb5ZTKJV/H4+e/
         hx1y/azzjr/vF7/ju+RxLZWmCS/wL4+jqiR6a31IDtilG1yjqWiehxC/Oarg7hF/t6qu
         hht62/TLB0SbJYnuib+VeOPNy75bDVpgtSj/YnFS4ssgy7y7nQ514kvlWu443zNlx+Tc
         14CQ==
X-Gm-Message-State: AOAM533Fw/wwDhETBhTopKFXAG9vuPKZ1MGzOSiKH3iR0fb7MUErjhXq
        4Uz+b0TEdJ77Yk2UPEx5VG8A
X-Google-Smtp-Source: ABdhPJzxhYBOiH/Smq23WhzLWqRSlimtq0OHKw9MbC8hraTngRlrChzat2VIFFVkaSttxwvUXneQbg==
X-Received: by 2002:a17:90a:f001:: with SMTP id bt1mr2821308pjb.116.1601478602871;
        Wed, 30 Sep 2020 08:10:02 -0700 (PDT)
Received: from Mani-XPS-13-9360.localdomain ([2409:4072:6004:2356:f1f4:5bc8:894a:8c50])
        by smtp.gmail.com with ESMTPSA id o6sm2456444pjp.33.2020.09.30.08.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 08:10:02 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, kishon@ti.com,
        vkoul@kernel.org, robh@kernel.org
Cc:     svarbanov@mm-sol.com, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        mgautam@codeaurora.org, devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 2/5] phy: qcom-qmp: Add SM8250 PCIe QMP PHYs
Date:   Wed, 30 Sep 2020 20:39:22 +0530
Message-Id: <20200930150925.31921-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200930150925.31921-1-manivannan.sadhasivam@linaro.org>
References: <20200930150925.31921-1-manivannan.sadhasivam@linaro.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SM8250 has multiple different PHY versions:
QMP GEN3x1 PHY - 1 lane
QMP GEN3x2 PHY - 2 lanes
QMP Modem PHY - 2 lanes

Add support for these with relevant init sequence. In order to abstract
the init sequence, this commit introduces secondary tables which can
be used to factor out the unique sequence for each PHY while the former
tables can have the common sequence.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp.c | 278 +++++++++++++++++++++++++++-
 drivers/phy/qualcomm/phy-qcom-qmp.h |  18 ++
 2 files changed, 294 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
index 562053ce9455..dd72e29b42f8 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
@@ -217,6 +217,13 @@ static const unsigned int sdm845_ufsphy_regs_layout[QPHY_LAYOUT_SIZE] = {
 	[QPHY_PCS_READY_STATUS]		= 0x160,
 };
 
+static const unsigned int sm8250_pcie_regs_layout[QPHY_LAYOUT_SIZE] = {
+	[QPHY_SW_RESET]			= 0x00,
+	[QPHY_START_CTRL]		= 0x44,
+	[QPHY_PCS_STATUS]		= 0x14,
+	[QPHY_PCS_POWER_DOWN_CONTROL]	= 0x40,
+};
+
 static const unsigned int sm8150_ufsphy_regs_layout[QPHY_LAYOUT_SIZE] = {
 	[QPHY_START_CTRL]		= QPHY_V4_PCS_UFS_PHY_START,
 	[QPHY_PCS_READY_STATUS]		= QPHY_V4_PCS_UFS_READY_STATUS,
@@ -1743,6 +1750,149 @@ static const struct qmp_phy_init_tbl sm8250_usb3_uniphy_pcs_tbl[] = {
 	QMP_PHY_INIT_CFG(QPHY_V4_PCS_REFGEN_REQ_CONFIG1, 0x21),
 };
 
+static const struct qmp_phy_init_tbl sm8250_qmp_pcie_serdes_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_SYSCLK_EN_SEL, 0x08),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_CLK_SELECT, 0x34),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_CORECLK_DIV_MODE1, 0x08),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_PLL_IVCO, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_LOCK_CMP_EN, 0x42),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_VCO_TUNE1_MODE0, 0x24),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_VCO_TUNE2_MODE1, 0x03),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_VCO_TUNE1_MODE1, 0xb4),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_VCO_TUNE_MAP, 0x02),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_BIN_VCOCAL_HSCLK_SEL, 0x11),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_DEC_START_MODE0, 0x82),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_DIV_FRAC_START3_MODE0, 0x03),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_DIV_FRAC_START2_MODE0, 0x55),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_DIV_FRAC_START1_MODE0, 0x55),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_LOCK_CMP2_MODE0, 0x1a),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_LOCK_CMP1_MODE0, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_DEC_START_MODE1, 0x68),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_DIV_FRAC_START3_MODE1, 0x02),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_DIV_FRAC_START2_MODE1, 0xaa),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_DIV_FRAC_START1_MODE1, 0xab),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_LOCK_CMP2_MODE1, 0x34),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_LOCK_CMP1_MODE1, 0x14),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_HSCLK_SEL, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_CP_CTRL_MODE0, 0x06),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_PLL_RCTRL_MODE0, 0x16),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_PLL_CCTRL_MODE0, 0x36),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_CP_CTRL_MODE1, 0x06),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_PLL_RCTRL_MODE1, 0x16),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_PLL_CCTRL_MODE1, 0x36),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_BIN_VCOCAL_CMP_CODE2_MODE0, 0x1e),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_BIN_VCOCAL_CMP_CODE1_MODE0, 0xca),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_BIN_VCOCAL_CMP_CODE2_MODE1, 0x18),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_BIN_VCOCAL_CMP_CODE1_MODE1, 0xa2),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_SSC_EN_CENTER, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_SSC_PER1, 0x31),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_SSC_PER2, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_SSC_STEP_SIZE1_MODE0, 0xde),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_SSC_STEP_SIZE2_MODE0, 0x07),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_SSC_STEP_SIZE1_MODE1, 0x4c),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_SSC_STEP_SIZE2_MODE1, 0x06),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_CLK_ENABLE1, 0x90),
+};
+
+static const struct qmp_phy_init_tbl sm8250_qmp_gen3x1_pcie_serdes_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_SYSCLK_BUF_ENABLE, 0x07),
+};
+
+static const struct qmp_phy_init_tbl sm8250_qmp_pcie_tx_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V4_TX_RCV_DETECT_LVL_2, 0x12),
+	QMP_PHY_INIT_CFG(QSERDES_V4_TX_LANE_MODE_1, 0x35),
+	QMP_PHY_INIT_CFG(QSERDES_V4_TX_RES_CODE_LANE_OFFSET_TX, 0x11),
+};
+
+static const struct qmp_phy_init_tbl sm8250_qmp_pcie_rx_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_FO_GAIN, 0x0c),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_SO_GAIN, 0x03),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_GM_CAL, 0x1b),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_IDAC_TSETTLE_HIGH, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_IDAC_TSETTLE_LOW, 0xc0),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_AUX_DATA_TCOARSE_TFINE, 0x30),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_VGA_CAL_CNTRL1, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_VGA_CAL_CNTRL2, 0x07),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_SO_SATURATION_AND_ENABLE, 0x7f),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_PI_CONTROLS, 0x70),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_EQU_ADAPTOR_CNTRL2, 0x0e),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_EQU_ADAPTOR_CNTRL3, 0x4a),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_EQU_ADAPTOR_CNTRL4, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_SIGDET_CNTRL, 0x03),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_SIGDET_ENABLES, 0x1c),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_SIGDET_DEGLITCH_CNTRL, 0x1e),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_EQ_OFFSET_ADAPTOR_CNTRL1, 0x17),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_10_LOW, 0xd4),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_10_HIGH, 0x54),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_10_HIGH2, 0xdb),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_10_HIGH3, 0x3b),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_10_HIGH4, 0x31),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_LOW, 0x24),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_HIGH2, 0xff),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_HIGH3, 0x7f),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_DCC_CTRL1, 0x0c),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_HIGH, 0xe4),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_HIGH2, 0xec),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_HIGH3, 0x3b),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_HIGH4, 0x36),
+};
+
+static const struct qmp_phy_init_tbl sm8250_qmp_gen3x1_pcie_rx_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RCLK_AUXDATA_SEL, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_EQU_ADAPTOR_CNTRL1, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_DFE_EN_TIMER, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_LOW, 0x3f),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_HIGH4, 0x14),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_DFE_CTLE_POST_CAL_OFFSET, 0x30),
+};
+
+static const struct qmp_phy_init_tbl sm8250_qmp_pcie_pcs_tbl[] = {
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_P2U3_WAKEUP_DLY_TIME_AUXCLK_L, 0x01),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_RX_SIGDET_LVL, 0x77),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_RATE_SLEW_CNTRL1, 0x0b),
+};
+
+static const struct qmp_phy_init_tbl sm8250_qmp_gen3x1_pcie_pcs_tbl[] = {
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_REFGEN_REQ_CONFIG1, 0x0d),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_EQ_CONFIG5, 0x12),
+};
+
+static const struct qmp_phy_init_tbl sm8250_qmp_pcie_pcs_misc_tbl[] = {
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_PCIE_OSC_DTCT_ACTIONS, 0x00),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_PCIE_L1P1_WAKEUP_DLY_TIME_AUXCLK_L, 0x01),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_PCIE_L1P2_WAKEUP_DLY_TIME_AUXCLK_L, 0x01),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_PCIE_PRESET_P6_P7_PRE, 0x33),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_PCIE_PRESET_P10_PRE, 0x00),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_PCIE_PRESET_P10_POST, 0x58),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_PCIE_ENDPOINT_REFCLK_DRIVE, 0xc1),
+};
+
+static const struct qmp_phy_init_tbl sm8250_qmp_gen3x1_pcie_pcs_misc_tbl[] = {
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_PCIE_INT_AUX_CLK_CONFIG1, 0x00),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_PCIE_EQ_CONFIG2, 0x0f),
+};
+
+static const struct qmp_phy_init_tbl sm8250_qmp_gen3x2_pcie_tx_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V4_TX_PI_QEC_CTRL, 0x20),
+};
+
+static const struct qmp_phy_init_tbl sm8250_qmp_gen3x2_pcie_rx_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_EQU_ADAPTOR_CNTRL1, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_LOW, 0xbf),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_HIGH4, 0x15),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_DFE_CTLE_POST_CAL_OFFSET, 0x38),
+};
+
+static const struct qmp_phy_init_tbl sm8250_qmp_gen3x2_pcie_pcs_tbl[] = {
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_REFGEN_REQ_CONFIG1, 0x05),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_EQ_CONFIG2, 0x0f),
+};
+
+static const struct qmp_phy_init_tbl sm8250_qmp_gen3x2_pcie_pcs_misc_tbl[] = {
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_PCIE_POWER_STATE_CONFIG2, 0x0d),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_PCIE_POWER_STATE_CONFIG4, 0x07),
+};
+
 /* struct qmp_phy_cfg - per-PHY initialization config */
 struct qmp_phy_cfg {
 	/* phy-type - PCIE/UFS/USB */
@@ -1753,14 +1903,24 @@ struct qmp_phy_cfg {
 	/* Init sequence for PHY blocks - serdes, tx, rx, pcs */
 	const struct qmp_phy_init_tbl *serdes_tbl;
 	int serdes_tbl_num;
+	const struct qmp_phy_init_tbl *serdes_tbl_sec;
+	int serdes_tbl_num_sec;
 	const struct qmp_phy_init_tbl *tx_tbl;
 	int tx_tbl_num;
+	const struct qmp_phy_init_tbl *tx_tbl_sec;
+	int tx_tbl_num_sec;
 	const struct qmp_phy_init_tbl *rx_tbl;
 	int rx_tbl_num;
+	const struct qmp_phy_init_tbl *rx_tbl_sec;
+	int rx_tbl_num_sec;
 	const struct qmp_phy_init_tbl *pcs_tbl;
 	int pcs_tbl_num;
+	const struct qmp_phy_init_tbl *pcs_tbl_sec;
+	int pcs_tbl_num_sec;
 	const struct qmp_phy_init_tbl *pcs_misc_tbl;
 	int pcs_misc_tbl_num;
+	const struct qmp_phy_init_tbl *pcs_misc_tbl_sec;
+	int pcs_misc_tbl_num_sec;
 
 	/* clock ids to be requested */
 	const char * const *clk_list;
@@ -2139,6 +2299,83 @@ static const struct qmp_phy_cfg sdm845_qhp_pciephy_cfg = {
 	.pwrdn_delay_max	= 1005,		/* us */
 };
 
+static const struct qmp_phy_cfg sm8250_qmp_gen3x1_pciephy_cfg = {
+	.type = PHY_TYPE_PCIE,
+	.nlanes = 1,
+
+	.serdes_tbl		= sm8250_qmp_pcie_serdes_tbl,
+	.serdes_tbl_num		= ARRAY_SIZE(sm8250_qmp_pcie_serdes_tbl),
+	.serdes_tbl_sec		= sm8250_qmp_gen3x1_pcie_serdes_tbl,
+	.serdes_tbl_num_sec	= ARRAY_SIZE(sm8250_qmp_gen3x1_pcie_serdes_tbl),
+	.tx_tbl			= sm8250_qmp_pcie_tx_tbl,
+	.tx_tbl_num		= ARRAY_SIZE(sm8250_qmp_pcie_tx_tbl),
+	.rx_tbl			= sm8250_qmp_pcie_rx_tbl,
+	.rx_tbl_num		= ARRAY_SIZE(sm8250_qmp_pcie_rx_tbl),
+	.rx_tbl_sec		= sm8250_qmp_gen3x1_pcie_rx_tbl,
+	.rx_tbl_num_sec		= ARRAY_SIZE(sm8250_qmp_gen3x1_pcie_rx_tbl),
+	.pcs_tbl		= sm8250_qmp_pcie_pcs_tbl,
+	.pcs_tbl_num		= ARRAY_SIZE(sm8250_qmp_pcie_pcs_tbl),
+	.pcs_tbl_sec		= sm8250_qmp_gen3x1_pcie_pcs_tbl,
+	.pcs_tbl_num_sec		= ARRAY_SIZE(sm8250_qmp_gen3x1_pcie_pcs_tbl),
+	.pcs_misc_tbl		= sm8250_qmp_pcie_pcs_misc_tbl,
+	.pcs_misc_tbl_num	= ARRAY_SIZE(sm8250_qmp_pcie_pcs_misc_tbl),
+	.pcs_misc_tbl_sec		= sm8250_qmp_gen3x1_pcie_pcs_misc_tbl,
+	.pcs_misc_tbl_num_sec	= ARRAY_SIZE(sm8250_qmp_gen3x1_pcie_pcs_misc_tbl),
+	.clk_list		= sdm845_pciephy_clk_l,
+	.num_clks		= ARRAY_SIZE(sdm845_pciephy_clk_l),
+	.reset_list		= sdm845_pciephy_reset_l,
+	.num_resets		= ARRAY_SIZE(sdm845_pciephy_reset_l),
+	.vreg_list		= qmp_phy_vreg_l,
+	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
+	.regs			= sm8250_pcie_regs_layout,
+
+	.start_ctrl		= PCS_START | SERDES_START,
+	.pwrdn_ctrl		= SW_PWRDN | REFCLK_DRV_DSBL,
+
+	.has_pwrdn_delay	= true,
+	.pwrdn_delay_min	= 995,		/* us */
+	.pwrdn_delay_max	= 1005,		/* us */
+};
+
+static const struct qmp_phy_cfg sm8250_qmp_gen3x2_pciephy_cfg = {
+	.type = PHY_TYPE_PCIE,
+	.nlanes = 2,
+
+	.serdes_tbl		= sm8250_qmp_pcie_serdes_tbl,
+	.serdes_tbl_num		= ARRAY_SIZE(sm8250_qmp_pcie_serdes_tbl),
+	.tx_tbl			= sm8250_qmp_pcie_tx_tbl,
+	.tx_tbl_num		= ARRAY_SIZE(sm8250_qmp_pcie_tx_tbl),
+	.tx_tbl_sec		= sm8250_qmp_gen3x2_pcie_tx_tbl,
+	.tx_tbl_num_sec		= ARRAY_SIZE(sm8250_qmp_gen3x2_pcie_tx_tbl),
+	.rx_tbl			= sm8250_qmp_pcie_rx_tbl,
+	.rx_tbl_num		= ARRAY_SIZE(sm8250_qmp_pcie_rx_tbl),
+	.rx_tbl_sec		= sm8250_qmp_gen3x2_pcie_rx_tbl,
+	.rx_tbl_num_sec		= ARRAY_SIZE(sm8250_qmp_gen3x2_pcie_rx_tbl),
+	.pcs_tbl		= sm8250_qmp_pcie_pcs_tbl,
+	.pcs_tbl_num		= ARRAY_SIZE(sm8250_qmp_pcie_pcs_tbl),
+	.pcs_tbl_sec		= sm8250_qmp_gen3x2_pcie_pcs_tbl,
+	.pcs_tbl_num_sec		= ARRAY_SIZE(sm8250_qmp_gen3x2_pcie_pcs_tbl),
+	.pcs_misc_tbl		= sm8250_qmp_pcie_pcs_misc_tbl,
+	.pcs_misc_tbl_num	= ARRAY_SIZE(sm8250_qmp_pcie_pcs_misc_tbl),
+	.pcs_misc_tbl_sec		= sm8250_qmp_gen3x2_pcie_pcs_misc_tbl,
+	.pcs_misc_tbl_num_sec	= ARRAY_SIZE(sm8250_qmp_gen3x2_pcie_pcs_misc_tbl),
+	.clk_list		= sdm845_pciephy_clk_l,
+	.num_clks		= ARRAY_SIZE(sdm845_pciephy_clk_l),
+	.reset_list		= sdm845_pciephy_reset_l,
+	.num_resets		= ARRAY_SIZE(sdm845_pciephy_reset_l),
+	.vreg_list		= qmp_phy_vreg_l,
+	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
+	.regs			= sm8250_pcie_regs_layout,
+
+	.start_ctrl		= PCS_START | SERDES_START,
+	.pwrdn_ctrl		= SW_PWRDN | REFCLK_DRV_DSBL,
+
+	.is_dual_lane_phy	= true,
+	.has_pwrdn_delay	= true,
+	.pwrdn_delay_min	= 995,		/* us */
+	.pwrdn_delay_max	= 1005,		/* us */
+};
+
 static const struct qmp_phy_cfg qmp_v3_usb3phy_cfg = {
 	.type			= PHY_TYPE_USB3,
 	.nlanes			= 1,
@@ -2556,6 +2793,9 @@ static int qcom_qmp_phy_com_init(struct qmp_phy *qphy)
 	/* Serdes configuration */
 	qcom_qmp_phy_configure(serdes, cfg->regs, cfg->serdes_tbl,
 			       cfg->serdes_tbl_num);
+	if (cfg->serdes_tbl_sec)
+		qcom_qmp_phy_configure(serdes, cfg->regs, cfg->serdes_tbl_sec,
+				       cfg->serdes_tbl_num_sec);
 
 	if (cfg->has_phy_com_ctrl) {
 		void __iomem *status;
@@ -2693,24 +2933,49 @@ static int qcom_qmp_phy_enable(struct phy *phy)
 	/* Tx, Rx, and PCS configurations */
 	qcom_qmp_phy_configure_lane(tx, cfg->regs,
 				    cfg->tx_tbl, cfg->tx_tbl_num, 1);
+	if (cfg->tx_tbl_sec)
+		qcom_qmp_phy_configure_lane(qphy->tx2, cfg->regs, cfg->tx_tbl_sec,
+					    cfg->tx_tbl_num_sec, 2);
+
 	/* Configuration for other LANE for USB-DP combo PHY */
-	if (cfg->is_dual_lane_phy)
+	if (cfg->is_dual_lane_phy) {
 		qcom_qmp_phy_configure_lane(qphy->tx2, cfg->regs,
 					    cfg->tx_tbl, cfg->tx_tbl_num, 2);
+		if (cfg->tx_tbl_sec)
+			qcom_qmp_phy_configure_lane(qphy->tx2, cfg->regs,
+						    cfg->tx_tbl_sec,
+						    cfg->tx_tbl_num_sec, 2);
+	}
 
 	qcom_qmp_phy_configure_lane(rx, cfg->regs,
 				    cfg->rx_tbl, cfg->rx_tbl_num, 1);
-	if (cfg->is_dual_lane_phy)
+	if (cfg->rx_tbl_sec)
+		qcom_qmp_phy_configure_lane(rx, cfg->regs,
+					    cfg->rx_tbl_sec, cfg->rx_tbl_num_sec, 1);
+
+	if (cfg->is_dual_lane_phy) {
 		qcom_qmp_phy_configure_lane(qphy->rx2, cfg->regs,
 					    cfg->rx_tbl, cfg->rx_tbl_num, 2);
+		if (cfg->rx_tbl_sec)
+			qcom_qmp_phy_configure_lane(rx, cfg->regs,
+						    cfg->rx_tbl_sec,
+						    cfg->rx_tbl_num_sec, 1);
+	}
 
 	qcom_qmp_phy_configure(pcs, cfg->regs, cfg->pcs_tbl, cfg->pcs_tbl_num);
+	if (cfg->pcs_tbl_sec)
+		qcom_qmp_phy_configure(pcs, cfg->regs, cfg->pcs_tbl_sec,
+				       cfg->pcs_tbl_num_sec);
+
 	ret = reset_control_deassert(qmp->ufs_reset);
 	if (ret)
 		goto err_lane_rst;
 
 	qcom_qmp_phy_configure(pcs_misc, cfg->regs, cfg->pcs_misc_tbl,
 			       cfg->pcs_misc_tbl_num);
+	if (cfg->pcs_misc_tbl_sec)
+		qcom_qmp_phy_configure(pcs_misc, cfg->regs, cfg->pcs_misc_tbl_sec,
+				       cfg->pcs_misc_tbl_num_sec);
 
 	/*
 	 * Pull out PHY from POWER DOWN state.
@@ -3232,6 +3497,15 @@ static const struct of_device_id qcom_qmp_phy_of_match_table[] = {
 	}, {
 		.compatible = "qcom,sm8250-qmp-usb3-uni-phy",
 		.data = &sm8250_usb3_uniphy_cfg,
+	}, {
+		.compatible = "qcom,sm8250-qmp-gen3x1-pcie-phy",
+		.data = &sm8250_qmp_gen3x1_pciephy_cfg,
+	}, {
+		.compatible = "qcom,sm8250-qmp-gen3x2-pcie-phy",
+		.data = &sm8250_qmp_gen3x2_pciephy_cfg,
+	}, {
+		.compatible = "qcom,sm8250-qmp-modem-pcie-phy",
+		.data = &sm8250_qmp_gen3x2_pciephy_cfg,
 	},
 	{ },
 };
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.h b/drivers/phy/qualcomm/phy-qcom-qmp.h
index 4277f592684b..092f1884cba6 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp.h
+++ b/drivers/phy/qualcomm/phy-qcom-qmp.h
@@ -321,6 +321,7 @@
 #define QSERDES_V4_COM_SSC_STEP_SIZE2_MODE0		0x028
 #define QSERDES_V4_COM_SSC_STEP_SIZE1_MODE1		0x030
 #define QSERDES_V4_COM_SSC_STEP_SIZE2_MODE1		0x034
+#define QSERDES_V4_COM_CLK_ENABLE1			0x048
 #define QSERDES_V4_COM_SYSCLK_BUF_ENABLE		0x050
 #define QSERDES_V4_COM_PLL_IVCO				0x058
 #define QSERDES_V4_COM_CMN_IPTRIM			0x060
@@ -350,6 +351,7 @@
 #define QSERDES_V4_COM_VCO_TUNE1_MODE1			0x118
 #define QSERDES_V4_COM_VCO_TUNE2_MODE1			0x11c
 #define QSERDES_V4_COM_VCO_TUNE_INITVAL2		0x124
+#define QSERDES_V4_COM_CLK_SELECT			0x154
 #define QSERDES_V4_COM_HSCLK_SEL			0x158
 #define QSERDES_V4_COM_HSCLK_HS_SWITCH_SEL		0x15c
 #define QSERDES_V4_COM_CORECLK_DIV_MODE1		0x16c
@@ -389,12 +391,14 @@
 #define QSERDES_V4_RX_UCDR_SB2_GAIN1			0x054
 #define QSERDES_V4_RX_UCDR_SB2_GAIN2			0x058
 #define QSERDES_V4_RX_AUX_DATA_TCOARSE_TFINE			0x060
+#define QSERDES_V4_RX_RCLK_AUXDATA_SEL			0x064
 #define QSERDES_V4_RX_AC_JTAG_ENABLE			0x068
 #define QSERDES_V4_RX_AC_JTAG_MODE			0x078
 #define QSERDES_V4_RX_RX_TERM_BW			0x080
 #define QSERDES_V4_RX_VGA_CAL_CNTRL1			0x0d4
 #define QSERDES_V4_RX_VGA_CAL_CNTRL2			0x0d8
 #define QSERDES_V4_RX_GM_CAL				0x0dc
+#define QSERDES_V4_RX_RX_EQU_ADAPTOR_CNTRL1		0x0e8
 #define QSERDES_V4_RX_RX_EQU_ADAPTOR_CNTRL2		0x0ec
 #define QSERDES_V4_RX_RX_EQU_ADAPTOR_CNTRL3		0x0f0
 #define QSERDES_V4_RX_RX_EQU_ADAPTOR_CNTRL4		0x0f4
@@ -403,6 +407,7 @@
 #define QSERDES_V4_RX_RX_IDAC_MEASURE_TIME		0x100
 #define QSERDES_V4_RX_RX_EQ_OFFSET_ADAPTOR_CNTRL1	0x110
 #define QSERDES_V4_RX_RX_OFFSET_ADAPTOR_CNTRL2		0x114
+#define QSERDES_V4_RX_SIGDET_ENABLES			0x118
 #define QSERDES_V4_RX_SIGDET_CNTRL			0x11c
 #define QSERDES_V4_RX_SIGDET_LVL			0x120
 #define QSERDES_V4_RX_SIGDET_DEGLITCH_CNTRL		0x124
@@ -724,4 +729,17 @@
 #define QPHY_V4_PCS_MISC_TYPEC_STATUS			0x10
 #define QPHY_V4_PCS_MISC_PLACEHOLDER_STATUS		0x14
 
+/* Only for QMP V4 PHY - PCS_PCIE registers (same as PCS_MISC?) */
+#define QPHY_V4_PCS_PCIE_POWER_STATE_CONFIG2		0x0c
+#define QPHY_V4_PCS_PCIE_POWER_STATE_CONFIG4		0x14
+#define QPHY_V4_PCS_PCIE_ENDPOINT_REFCLK_DRIVE		0x1c
+#define QPHY_V4_PCS_PCIE_L1P1_WAKEUP_DLY_TIME_AUXCLK_L	0x40
+#define QPHY_V4_PCS_PCIE_L1P2_WAKEUP_DLY_TIME_AUXCLK_L	0x48
+#define QPHY_V4_PCS_PCIE_INT_AUX_CLK_CONFIG1		0x50
+#define QPHY_V4_PCS_PCIE_OSC_DTCT_ACTIONS		0x90
+#define QPHY_V4_PCS_PCIE_EQ_CONFIG2			0xa4
+#define QPHY_V4_PCS_PCIE_PRESET_P6_P7_PRE		0xb4
+#define QPHY_V4_PCS_PCIE_PRESET_P10_PRE			0xbc
+#define QPHY_V4_PCS_PCIE_PRESET_P10_POST		0xe0
+
 #endif
-- 
2.17.1

