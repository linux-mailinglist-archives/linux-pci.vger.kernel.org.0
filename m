Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DED5562497C
	for <lists+linux-pci@lfdr.de>; Thu, 10 Nov 2022 19:32:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231981AbiKJScL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Nov 2022 13:32:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232022AbiKJScJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Nov 2022 13:32:09 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B1404D5D1
        for <linux-pci@vger.kernel.org>; Thu, 10 Nov 2022 10:32:05 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id g7so4855777lfv.5
        for <linux-pci@vger.kernel.org>; Thu, 10 Nov 2022 10:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1xDiE8Bwh4Ikzuy5U7/SCqTlGH/WFHTyDSOulj4Kkk0=;
        b=Wq9nbkGm3KhdNOhFibwjbPYtgs8u+Tt4vlD84n+FZ0fLBeT9O+mxHaiSX7vnZRhu9E
         UilfdS3A4/A6rqKclw5XfFhynriW/6qvmWjokO6kyY6oEBDVXBI0nbjxV2PLpNH648MG
         stcjthn4glfJNXZfO5YfVvLnobuoCIaPSV2uNC7DxVYW/v3FExGp/80GlClx6NlWyORd
         89LphlkEJV7T/ZBuOhch7gbN60twediB49/AbCx+2PC9fqk6hGHNaHmeFuCfQLQFWrbr
         ho68qTUksehDJH+NhaDoxX9jI7Lgv07AXRVXduVqxeDtmJ6JDBCjjMXteJtvEejh/+Wn
         JIhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1xDiE8Bwh4Ikzuy5U7/SCqTlGH/WFHTyDSOulj4Kkk0=;
        b=vP4RPgjFRPvrdrtmyNpAu3zW1jKsT/acAOkEHQwmmm05HhNwvrqVctqP5e3O/DZXQy
         B8c/dfzw+oPWOQKME6SqO0xKJyD5gepuaPz2QdgrTTy/M0zoWsYswicGTPBVHVjawlcz
         V+VrXYe3S3Q/PVCcnxuJiu41F0ADYZfXdcjAWZDxVNe0fGI9fYU3RMUjWUjlst5ymBiq
         Vv0mGLjf30fH3KU9xZkGQ3XC/9Zffo2mXliKRUKC8BbTNEzWtY/MRyM2ruKzt9ibV79c
         YFQKowZqcN+yC6JybVX/KFmkNjaBVXRAdDWhzpK4rcBPBoVw6Hj1hbTpS4hyJIB2vNno
         TmMA==
X-Gm-Message-State: ACrzQf2Gs59Js2I9XSSotfUK+eKtxHL/GCHq83ofXyF1LOCqQBuFRGTG
        e4fvbB98dDLw/dYEEkk0fVSsAg==
X-Google-Smtp-Source: AMsMyM7CcI29MQdO46JKEGpoghMAkO8R0v0nCMV598pYpghJbEgoRxuUMM7csUIaO8e46uwuBJj4cQ==
X-Received: by 2002:a19:6454:0:b0:4b0:54a9:38a3 with SMTP id b20-20020a196454000000b004b054a938a3mr1690828lfj.20.1668105123378;
        Thu, 10 Nov 2022 10:32:03 -0800 (PST)
Received: from eriador.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id m18-20020a197112000000b004a2550db9ddsm2837087lfc.245.2022.11.10.10.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 10:32:03 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v3 5/8] phy: qcom-qmp-pcie: rename the sm8450 gen3 PHY config tables
Date:   Thu, 10 Nov 2022 21:31:55 +0300
Message-Id: <20221110183158.856242-6-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221110183158.856242-1-dmitry.baryshkov@linaro.org>
References: <20221110183158.856242-1-dmitry.baryshkov@linaro.org>
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
tables. Rename generic tables to remove x1 suffix.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
index d9f8dffbe1da..4a55b2439952 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
@@ -1218,7 +1218,7 @@ static const struct qmp_phy_init_tbl sdx55_qmp_pcie_pcs_misc_tbl[] = {
 	QMP_PHY_INIT_CFG(QPHY_V4_20_PCS_LANE1_INSIG_MX_CTRL2, 0x00),
 };
 
-static const struct qmp_phy_init_tbl sm8450_qmp_gen3x1_pcie_serdes_tbl[] = {
+static const struct qmp_phy_init_tbl sm8450_qmp_gen3_pcie_serdes_tbl[] = {
 	QMP_PHY_INIT_CFG(QSERDES_V5_COM_SYSCLK_EN_SEL, 0x08),
 	QMP_PHY_INIT_CFG(QSERDES_V5_COM_CLK_SELECT, 0x34),
 	QMP_PHY_INIT_CFG(QSERDES_V5_COM_CORECLK_DIV_MODE1, 0x08),
@@ -1274,7 +1274,7 @@ static const struct qmp_phy_init_tbl sm8450_qmp_gen3x1_pcie_tx_tbl[] = {
 	QMP_PHY_INIT_CFG(QSERDES_V5_TX_RES_CODE_LANE_OFFSET_RX, 0x04),
 };
 
-static const struct qmp_phy_init_tbl sm8450_qmp_gen3x1_pcie_rx_tbl[] = {
+static const struct qmp_phy_init_tbl sm8450_qmp_gen3_pcie_rx_tbl[] = {
 	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_00_LOW, 0x7f),
 	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_00_HIGH, 0xff),
 	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_00_HIGH4, 0xd8),
@@ -1302,7 +1302,7 @@ static const struct qmp_phy_init_tbl sm8450_qmp_gen3x1_pcie_rc_rx_tbl[] = {
 	QMP_PHY_INIT_CFG(QSERDES_V5_RX_UCDR_SO_GAIN, 0x05),
 };
 
-static const struct qmp_phy_init_tbl sm8450_qmp_gen3x1_pcie_pcs_tbl[] = {
+static const struct qmp_phy_init_tbl sm8450_qmp_gen3_pcie_pcs_tbl[] = {
 	QMP_PHY_INIT_CFG(QPHY_V5_PCS_RX_SIGDET_LVL, 0x77),
 	QMP_PHY_INIT_CFG(QPHY_V5_PCS_RATE_SLEW_CNTRL1, 0x0b),
 	QMP_PHY_INIT_CFG(QPHY_V5_PCS_REFGEN_REQ_CONFIG1, 0x05),
@@ -2025,14 +2025,14 @@ static const struct qmp_phy_cfg sm8450_qmp_gen3x1_pciephy_cfg = {
 	.lanes			= 1,
 
 	.tbls = {
-		.serdes		= sm8450_qmp_gen3x1_pcie_serdes_tbl,
-		.serdes_num	= ARRAY_SIZE(sm8450_qmp_gen3x1_pcie_serdes_tbl),
+		.serdes		= sm8450_qmp_gen3_pcie_serdes_tbl,
+		.serdes_num	= ARRAY_SIZE(sm8450_qmp_gen3_pcie_serdes_tbl),
 		.tx		= sm8450_qmp_gen3x1_pcie_tx_tbl,
 		.tx_num		= ARRAY_SIZE(sm8450_qmp_gen3x1_pcie_tx_tbl),
-		.rx		= sm8450_qmp_gen3x1_pcie_rx_tbl,
-		.rx_num		= ARRAY_SIZE(sm8450_qmp_gen3x1_pcie_rx_tbl),
-		.pcs		= sm8450_qmp_gen3x1_pcie_pcs_tbl,
-		.pcs_num	= ARRAY_SIZE(sm8450_qmp_gen3x1_pcie_pcs_tbl),
+		.rx		= sm8450_qmp_gen3_pcie_rx_tbl,
+		.rx_num		= ARRAY_SIZE(sm8450_qmp_gen3_pcie_rx_tbl),
+		.pcs		= sm8450_qmp_gen3_pcie_pcs_tbl,
+		.pcs_num	= ARRAY_SIZE(sm8450_qmp_gen3_pcie_pcs_tbl),
 		.pcs_misc	= sm8450_qmp_gen3x1_pcie_pcs_misc_tbl,
 		.pcs_misc_num	= ARRAY_SIZE(sm8450_qmp_gen3x1_pcie_pcs_misc_tbl),
 	},
-- 
2.35.1

