Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB0D0623FE1
	for <lists+linux-pci@lfdr.de>; Thu, 10 Nov 2022 11:33:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbiKJKdz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Nov 2022 05:33:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbiKJKdy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Nov 2022 05:33:54 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2462760EA3
        for <linux-pci@vger.kernel.org>; Thu, 10 Nov 2022 02:33:53 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id f37so2345561lfv.8
        for <linux-pci@vger.kernel.org>; Thu, 10 Nov 2022 02:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3+ONmInHewy6MvbwX/y3/rZ6bIRRiJ+CsA99YGYkRuE=;
        b=dGC6g/ebjKy+EDzTqUEet3S2/XfZrarIPgUMWhWitAvwvHVW+Zi/isYa1yseobo2je
         gthfb0OcSH3QA5GAQegE5M8cKwcEvOsAUywo60hizoC642TRyTWElXQeq34yr9aRsIEI
         9NvFp6XqsGabAzZZBIRDAXip+4J2sdzzHj6lNI4mGC/NhD0XDz3bkPdD0voRr0ClI/1d
         b0cckIKeDbsdOvMXD8vT+16HW/FIhRFNKvco5hyCkyurE5mdQrcFvXRP5HwB08DVdMj4
         gs4NHM6Okl2NhXv4y5EWeu1CK8YFt2NG6egMoC0RjOe2fPXW5L12DF6sjHGkt5eCYTyN
         e9bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3+ONmInHewy6MvbwX/y3/rZ6bIRRiJ+CsA99YGYkRuE=;
        b=Za6sxedFSykm/MlG9Q8rp6Q/A9oTqlGJuOBcA4U1Nqih+lJvlD1IzHjKIjgci5Jmqg
         kB96KbktSMriN4LR3Vl4O6Bpui+3JoFqeBpzugxaZHUClmJWIRT+qaqizwYBy7A1aSQm
         +UjBZxPPV7Wv7VKtxx3cx/PoGra5F18z+ktlzzHCmzPWrgpRGeudA7myZZotTi7m6h49
         YzsIOSGucdIhcyKUDgHay0KDuIFSBsz5SDpgoiGhcn2kpI/Su0CDfVfNzIGRV2wRwAeE
         iVnWp9soYVqKucU8MWGgePE15P01HwWW/5G7/WjonQAQ9kz5U4GnMWx7azU1cN/+yEpC
         0aRQ==
X-Gm-Message-State: ACrzQf0OsZFtqnNv8PIf5c/E3KgOdNZvqsXEsXi7k0MhEXm+BCj9/T5N
        Ykmp2SUI6/B2pR8KeMHlq1s9iA==
X-Google-Smtp-Source: AMsMyM5lPiZlo2em6hDnFq27Px4ge6GN9cIWmwI7HkC6UrZMARYErjLOH8zByrHlGnAOfVQuvJ4PSg==
X-Received: by 2002:ac2:4466:0:b0:4ac:12b8:a263 with SMTP id y6-20020ac24466000000b004ac12b8a263mr20936682lfl.522.1668076431506;
        Thu, 10 Nov 2022 02:33:51 -0800 (PST)
Received: from localhost.localdomain ([195.165.23.90])
        by smtp.gmail.com with ESMTPSA id p22-20020ac246d6000000b00498f32ae907sm2687837lfo.95.2022.11.10.02.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 02:33:51 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Johan Hovold <johan@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 4/8] phy: qcom-qmp-pcie: split sm8450 gen3 PHY config tables
Date:   Thu, 10 Nov 2022 13:33:41 +0300
Message-Id: <20221110103345.729018-5-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221110103345.729018-1-dmitry.baryshkov@linaro.org>
References: <20221110103345.729018-1-dmitry.baryshkov@linaro.org>
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

SM8350 PHY config tables are mostly the same as SM8450 gen3 PHY config
tables. Split these tables to be used by SM8350 config.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 26 ++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
index 47cccc4b35b2..d9f8dffbe1da 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
@@ -1252,7 +1252,6 @@ static const struct qmp_phy_init_tbl sm8450_qmp_gen3x1_pcie_serdes_tbl[] = {
 	QMP_PHY_INIT_CFG(QSERDES_V5_COM_BIN_VCOCAL_CMP_CODE1_MODE0, 0xca),
 	QMP_PHY_INIT_CFG(QSERDES_V5_COM_BIN_VCOCAL_CMP_CODE2_MODE1, 0x18),
 	QMP_PHY_INIT_CFG(QSERDES_V5_COM_BIN_VCOCAL_CMP_CODE1_MODE1, 0xa2),
-	QMP_PHY_INIT_CFG(QSERDES_V5_COM_SYSCLK_BUF_ENABLE, 0x07),
 	QMP_PHY_INIT_CFG(QSERDES_V5_COM_SSC_EN_CENTER, 0x01),
 	QMP_PHY_INIT_CFG(QSERDES_V5_COM_SSC_PER1, 0x31),
 	QMP_PHY_INIT_CFG(QSERDES_V5_COM_SSC_PER2, 0x01),
@@ -1263,6 +1262,10 @@ static const struct qmp_phy_init_tbl sm8450_qmp_gen3x1_pcie_serdes_tbl[] = {
 	QMP_PHY_INIT_CFG(QSERDES_V5_COM_CLK_ENABLE1, 0x90),
 };
 
+static const struct qmp_phy_init_tbl sm8450_qmp_gen3x1_pcie_rc_serdes_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_SYSCLK_BUF_ENABLE, 0x07),
+};
+
 static const struct qmp_phy_init_tbl sm8450_qmp_gen3x1_pcie_tx_tbl[] = {
 	QMP_PHY_INIT_CFG(QSERDES_V5_TX_PI_QEC_CTRL, 0x20),
 	QMP_PHY_INIT_CFG(QSERDES_V5_TX_LANE_MODE_1, 0x75),
@@ -1274,8 +1277,6 @@ static const struct qmp_phy_init_tbl sm8450_qmp_gen3x1_pcie_tx_tbl[] = {
 static const struct qmp_phy_init_tbl sm8450_qmp_gen3x1_pcie_rx_tbl[] = {
 	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_00_LOW, 0x7f),
 	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_00_HIGH, 0xff),
-	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_00_HIGH2, 0xbf),
-	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_00_HIGH3, 0x3f),
 	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_00_HIGH4, 0xd8),
 	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_01_LOW, 0xdc),
 	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_01_HIGH, 0xdc),
@@ -1283,14 +1284,19 @@ static const struct qmp_phy_init_tbl sm8450_qmp_gen3x1_pcie_rx_tbl[] = {
 	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_01_HIGH3, 0x34),
 	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_01_HIGH4, 0xa6),
 	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_10_HIGH3, 0x34),
-	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_10_HIGH4, 0x38),
-	QMP_PHY_INIT_CFG(QSERDES_V5_RX_VGA_CAL_CNTRL2, 0x07),
 	QMP_PHY_INIT_CFG(QSERDES_V5_RX_GM_CAL, 0x00),
 	QMP_PHY_INIT_CFG(QSERDES_V5_RX_UCDR_SB2_THRESH1, 0x08),
 	QMP_PHY_INIT_CFG(QSERDES_V5_RX_UCDR_SB2_THRESH2, 0x08),
-	QMP_PHY_INIT_CFG(QSERDES_V5_RX_UCDR_PI_CONTROLS, 0xf0),
 	QMP_PHY_INIT_CFG(QSERDES_V5_RX_DFE_CTLE_POST_CAL_OFFSET, 0x38),
 	QMP_PHY_INIT_CFG(QSERDES_V5_RX_TX_ADAPT_POST_THRESH, 0xf0),
+};
+
+static const struct qmp_phy_init_tbl sm8450_qmp_gen3x1_pcie_rc_rx_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_00_HIGH2, 0xbf),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_00_HIGH3, 0x3f),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_10_HIGH4, 0x38),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_VGA_CAL_CNTRL2, 0x07),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_UCDR_PI_CONTROLS, 0xf0),
 	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_EQU_ADAPTOR_CNTRL4, 0x07),
 	QMP_PHY_INIT_CFG(QSERDES_V5_RX_UCDR_FO_GAIN, 0x09),
 	QMP_PHY_INIT_CFG(QSERDES_V5_RX_UCDR_SO_GAIN, 0x05),
@@ -2030,6 +2036,14 @@ static const struct qmp_phy_cfg sm8450_qmp_gen3x1_pciephy_cfg = {
 		.pcs_misc	= sm8450_qmp_gen3x1_pcie_pcs_misc_tbl,
 		.pcs_misc_num	= ARRAY_SIZE(sm8450_qmp_gen3x1_pcie_pcs_misc_tbl),
 	},
+
+	.tbls_rc = &(const struct qmp_phy_cfg_tbls) {
+		.serdes		= sm8450_qmp_gen3x1_pcie_rc_serdes_tbl,
+		.serdes_num	= ARRAY_SIZE(sm8450_qmp_gen3x1_pcie_rc_serdes_tbl),
+		.rx		= sm8450_qmp_gen3x1_pcie_rc_rx_tbl,
+		.rx_num		= ARRAY_SIZE(sm8450_qmp_gen3x1_pcie_rc_rx_tbl),
+	},
+
 	.clk_list		= sdm845_pciephy_clk_l,
 	.num_clks		= ARRAY_SIZE(sdm845_pciephy_clk_l),
 	.reset_list		= sdm845_pciephy_reset_l,
-- 
2.35.1

