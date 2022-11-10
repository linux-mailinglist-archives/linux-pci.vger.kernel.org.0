Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7DE623FE7
	for <lists+linux-pci@lfdr.de>; Thu, 10 Nov 2022 11:34:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbiKJKd7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Nov 2022 05:33:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbiKJKd4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Nov 2022 05:33:56 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A87663E1
        for <linux-pci@vger.kernel.org>; Thu, 10 Nov 2022 02:33:55 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id a15so843581ljb.7
        for <linux-pci@vger.kernel.org>; Thu, 10 Nov 2022 02:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I0ux6Fb8pC5iN9QZnYoEuuzHikbMNTF+6uQlLAmZuts=;
        b=lF60ka9rOsV4MUfCLuJZYQjue3pe37EKW1KCsd7K2p8SpZlg4t0qM/R6h0JHrWVmI4
         p0fiwlAgn+HosA7ZEhrMQkzynUrj651OZIryvGKfU6u63zNZOkvJtVx4U1u/3zjSfLSe
         fZVca/H+MlZkXvTKwUK0i38lLsi9Aj3SfLdlxOkNjtfvbu6DW43q0W2pgF76W4ruBBOq
         8pksIEPoMgptoKCxvkVTX6tvHBzvjKSHm2YKq32j94mbrSNwhtXot1DDqPF/4ykR/O+5
         DgQKCQBCFaGoEKs3dNnfRbKwCKPBzhpLOeDAFwwyyG7MMuFnaRrWp/COoVk/8MattuOw
         MePw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I0ux6Fb8pC5iN9QZnYoEuuzHikbMNTF+6uQlLAmZuts=;
        b=K2HVPTPi3mvuD7CRfdh2EWTLBEfcAhYbn3IPJiB4DxdueRod6w6cm16eMur0j1lWJr
         7p+xLdE/Xb0AUMdDMHMLBAjwk13rmpsn0Hm/+r3A0U1NPg5sV7dfEfzA3pCaW0bMNUKZ
         nm+l+k7Xmq9O/WLkqt6zC/uyPg9DVFr796JwTQbWSdEYcbsbfxFtNBzI1X5A+y3XGdPK
         X7BWcWAcMATP9VkJelhVf1xVcg3/R4NUHDa1QPO31NuCJDjYRh91kyLy47sib10hjoRw
         0KNI7JHoXjg60nFhhT8EltgVSzjz05Gq3j6M+bnIog+kN2NF2uANnRbOWfDLqoxdwXXR
         wVSA==
X-Gm-Message-State: ACrzQf0/0QoMggnIvl9coAdU9RiRB5fS/bEt484gVvMr/m7nHUVkLIsn
        kyCnLJOgSEnN7e1nSDVeUEt1ng==
X-Google-Smtp-Source: AMsMyM4QTWNGGlYwO4UnsHFp7bOYEVpgm4bFLIASh20H9mlRBij4F8iInSFMOUzgawlvjFXw47PY7A==
X-Received: by 2002:a2e:8ec3:0:b0:277:4b35:d94a with SMTP id e3-20020a2e8ec3000000b002774b35d94amr7933633ljl.21.1668076433462;
        Thu, 10 Nov 2022 02:33:53 -0800 (PST)
Received: from localhost.localdomain ([195.165.23.90])
        by smtp.gmail.com with ESMTPSA id p22-20020ac246d6000000b00498f32ae907sm2687837lfo.95.2022.11.10.02.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 02:33:53 -0800 (PST)
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
Subject: [PATCH v2 6/8] phy: qcom-qmp-pcie: add support for sm8350 platform
Date:   Thu, 10 Nov 2022 13:33:43 +0300
Message-Id: <20221110103345.729018-7-dmitry.baryshkov@linaro.org>
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

Add support for a single-lane and two-lane PCIe PHYs found on Qualcomm
SM8350 platform.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 120 ++++++++++++++++++++++-
 1 file changed, 119 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
index 4a55b2439952..a1f5d31d161b 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
@@ -1315,6 +1315,40 @@ static const struct qmp_phy_init_tbl sm8450_qmp_gen3x1_pcie_pcs_misc_tbl[] = {
 	QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_ENDPOINT_REFCLK_DRIVE, 0xc1),
 };
 
+static const struct qmp_phy_init_tbl sm8350_qmp_gen3x1_pcie_tx_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V5_TX_PI_QEC_CTRL, 0x20),
+	QMP_PHY_INIT_CFG(QSERDES_V5_TX_LANE_MODE_1, 0x75),
+	QMP_PHY_INIT_CFG(QSERDES_V5_TX_LANE_MODE_4, 0x3f),
+	QMP_PHY_INIT_CFG(QSERDES_V5_TX_RES_CODE_LANE_OFFSET_TX, 0x1d),
+	QMP_PHY_INIT_CFG(QSERDES_V5_TX_RES_CODE_LANE_OFFSET_RX, 0x0c),
+};
+
+static const struct qmp_phy_init_tbl sm8350_qmp_gen3x1_pcie_rc_rx_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_00_HIGH2, 0xbf),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_00_HIGH3, 0x3f),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_VGA_CAL_CNTRL2, 0x07),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_UCDR_PI_CONTROLS, 0xf0),
+};
+
+static const struct qmp_phy_init_tbl sm8350_qmp_gen3x2_pcie_rc_rx_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_00_HIGH2, 0x7f),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_00_HIGH3, 0x34),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_VGA_CAL_CNTRL2, 0x0f),
+};
+
+static const struct qmp_phy_init_tbl sm8350_qmp_gen3x2_pcie_tx_tbl[] = {
+	QMP_PHY_INIT_CFG_LANE(QSERDES_V5_TX_PI_QEC_CTRL, 0x02, 1),
+	QMP_PHY_INIT_CFG_LANE(QSERDES_V5_TX_PI_QEC_CTRL, 0x04, 2),
+	QMP_PHY_INIT_CFG(QSERDES_V5_TX_LANE_MODE_1, 0xd5),
+	QMP_PHY_INIT_CFG(QSERDES_V5_TX_LANE_MODE_4, 0x3f),
+	QMP_PHY_INIT_CFG(QSERDES_V5_TX_RES_CODE_LANE_OFFSET_TX, 0x1d),
+	QMP_PHY_INIT_CFG(QSERDES_V5_TX_RES_CODE_LANE_OFFSET_RX, 0x0c),
+};
+
+static const struct qmp_phy_init_tbl sm8350_qmp_gen3x2_pcie_rc_pcs_tbl[] = {
+	QMP_PHY_INIT_CFG(QPHY_V5_PCS_EQ_CONFIG2, 0x0f),
+};
+
 static const struct qmp_phy_init_tbl sm8450_qmp_gen4x2_pcie_serdes_tbl[] = {
 	QMP_PHY_INIT_CFG(QSERDES_V5_COM_BIAS_EN_CLKBUFLR_EN, 0x14),
 	QMP_PHY_INIT_CFG(QSERDES_V5_COM_PLL_IVCO, 0x0f),
@@ -2021,6 +2055,80 @@ static const struct qmp_phy_cfg sdx55_qmp_pciephy_cfg = {
 	.phy_status		= PHYSTATUS_4_20,
 };
 
+static const struct qmp_phy_cfg sm8350_qmp_gen3x1_pciephy_cfg = {
+	.lanes			= 1,
+
+	.offsets		= &qmp_pcie_offsets_v5,
+
+	.tables = {
+		.serdes		= sm8450_qmp_gen3_pcie_serdes_tbl,
+		.serdes_num	= ARRAY_SIZE(sm8450_qmp_gen3_pcie_serdes_tbl),
+		.tx		= sm8350_qmp_gen3x1_pcie_tx_tbl,
+		.tx_num		= ARRAY_SIZE(sm8350_qmp_gen3x1_pcie_tx_tbl),
+		.rx		= sm8450_qmp_gen3_pcie_rx_tbl,
+		.rx_num		= ARRAY_SIZE(sm8450_qmp_gen3_pcie_rx_tbl),
+		.pcs		= sm8450_qmp_gen3_pcie_pcs_tbl,
+		.pcs_num	= ARRAY_SIZE(sm8450_qmp_gen3_pcie_pcs_tbl),
+		.pcs_misc	= sm8450_qmp_gen3x1_pcie_pcs_misc_tbl,
+		.pcs_misc_num	= ARRAY_SIZE(sm8450_qmp_gen3x1_pcie_pcs_misc_tbl),
+	},
+
+	.tables_rc = &(const struct qmp_phy_cfg_tables) {
+		.serdes		= sm8450_qmp_gen3x1_pcie_rc_serdes_tbl,
+		.serdes_num	= ARRAY_SIZE(sm8450_qmp_gen3x1_pcie_rc_serdes_tbl),
+		.rx		= sm8350_qmp_gen3x1_pcie_rc_rx_tbl,
+		.rx_num		= ARRAY_SIZE(sm8350_qmp_gen3x1_pcie_rc_rx_tbl),
+	},
+
+	.clk_list		= sc8280xp_pciephy_clk_l,
+	.num_clks		= ARRAY_SIZE(sc8280xp_pciephy_clk_l),
+	.reset_list		= sdm845_pciephy_reset_l,
+	.num_resets		= ARRAY_SIZE(sdm845_pciephy_reset_l),
+	.vreg_list		= qmp_phy_vreg_l,
+	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
+	.regs			= sm8250_pcie_regs_layout,
+
+	.pwrdn_ctrl		= SW_PWRDN | REFCLK_DRV_DSBL,
+	.phy_status		= PHYSTATUS,
+};
+
+static const struct qmp_phy_cfg sm8350_qmp_gen3x2_pciephy_cfg = {
+	.lanes			= 2,
+
+	.offsets		= &qmp_pcie_offsets_v5,
+
+	.tables = {
+		.serdes		= sm8450_qmp_gen3_pcie_serdes_tbl,
+		.serdes_num	= ARRAY_SIZE(sm8450_qmp_gen3_pcie_serdes_tbl),
+		.tx		= sm8350_qmp_gen3x2_pcie_tx_tbl,
+		.tx_num		= ARRAY_SIZE(sm8350_qmp_gen3x2_pcie_tx_tbl),
+		.rx		= sm8450_qmp_gen3_pcie_rx_tbl,
+		.rx_num		= ARRAY_SIZE(sm8450_qmp_gen3_pcie_rx_tbl),
+		.pcs		= sm8450_qmp_gen3_pcie_pcs_tbl,
+		.pcs_num	= ARRAY_SIZE(sm8450_qmp_gen3_pcie_pcs_tbl),
+		.pcs_misc	= sc8280xp_qmp_gen3x2_pcie_pcs_misc_tbl,
+		.pcs_misc_num	= ARRAY_SIZE(sc8280xp_qmp_gen3x2_pcie_pcs_misc_tbl),
+	},
+
+	.tables_rc = &(const struct qmp_phy_cfg_tables) {
+		.rx		= sm8350_qmp_gen3x2_pcie_rc_rx_tbl,
+		.rx_num		= ARRAY_SIZE(sm8350_qmp_gen3x2_pcie_rc_rx_tbl),
+		.pcs		= sm8350_qmp_gen3x2_pcie_rc_pcs_tbl,
+		.pcs_num	= ARRAY_SIZE(sm8350_qmp_gen3x2_pcie_rc_pcs_tbl),
+	},
+
+	.clk_list		= sc8280xp_pciephy_clk_l,
+	.num_clks		= ARRAY_SIZE(sc8280xp_pciephy_clk_l),
+	.reset_list		= sdm845_pciephy_reset_l,
+	.num_resets		= ARRAY_SIZE(sdm845_pciephy_reset_l),
+	.vreg_list		= qmp_phy_vreg_l,
+	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
+	.regs			= sm8250_pcie_regs_layout,
+
+	.pwrdn_ctrl		= SW_PWRDN | REFCLK_DRV_DSBL,
+	.phy_status		= PHYSTATUS,
+};
+
 static const struct qmp_phy_cfg sm8450_qmp_gen3x1_pciephy_cfg = {
 	.lanes			= 1,
 
@@ -2617,7 +2725,11 @@ static int qmp_pcie_parse_dt(struct qmp_pcie *qmp)
 	qmp->pipe_clks[0].id = "pipe";
 	qmp->pipe_clks[1].id = "pipediv2";
 
-	ret = devm_clk_bulk_get(dev, qmp->num_pipe_clks, qmp->pipe_clks);
+	ret = devm_clk_bulk_get(dev, 1, qmp->pipe_clks);
+	if (ret)
+		return ret;
+
+	ret = devm_clk_bulk_get_optional(dev, qmp->num_pipe_clks - 1, qmp->pipe_clks + 1);
 	if (ret)
 		return ret;
 
@@ -2737,6 +2849,12 @@ static const struct of_device_id qmp_pcie_of_match_table[] = {
 	}, {
 		.compatible = "qcom,sm8250-qmp-modem-pcie-phy",
 		.data = &sm8250_qmp_gen3x2_pciephy_cfg,
+	}, {
+		.compatible = "qcom,sm8350-qmp-gen3x1-pcie-phy",
+		.data = &sm8350_qmp_gen3x1_pciephy_cfg,
+	}, {
+		.compatible = "qcom,sm8350-qmp-gen3x2-pcie-phy",
+		.data = &sm8350_qmp_gen3x2_pciephy_cfg,
 	}, {
 		.compatible = "qcom,sm8450-qmp-gen3x1-pcie-phy",
 		.data = &sm8450_qmp_gen3x1_pciephy_cfg,
-- 
2.35.1

