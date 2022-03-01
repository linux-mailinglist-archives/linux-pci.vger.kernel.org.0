Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4D54C850B
	for <lists+linux-pci@lfdr.de>; Tue,  1 Mar 2022 08:26:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232936AbiCAH0l (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Mar 2022 02:26:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232909AbiCAH0l (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Mar 2022 02:26:41 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF7507C7A2
        for <linux-pci@vger.kernel.org>; Mon, 28 Feb 2022 23:25:50 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id y11so13411519pfa.6
        for <linux-pci@vger.kernel.org>; Mon, 28 Feb 2022 23:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yYf0qM8EzXfF4UkYBAdwkh5DAfiu0yUybShsdnlJ+V0=;
        b=OJxwzhHgEsVo+qhgTQnli2R+CjEf7JVaYGVO6PFFqt8z8/R9UudZNTcmUSYlFjYB+o
         QFl0KbCVwI7CLk54kN8BF8m98PUNCXjSPqQpTr1ipiSek3tNJRGO+DKcTFjZrFLDfYNt
         nEcdwzffGTeDCYXm69eY6Qs/BP9L1JvP+qGhM1eZjzqY345/xJyL6HGRBRi4tqLIhlQU
         G0NdngJrjKmXTOFhA/0ASxYG49Jmj/KSZsRfgW6t9uYYnX2jhvVUCw0D0fH9onzZHzvT
         uBEnReZtaQ2zN6xfxORCgtx/exXZAMFXu7eC50MmJt4dGC8VrzAxxF6FRZuCcgKI2O6Z
         dskQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yYf0qM8EzXfF4UkYBAdwkh5DAfiu0yUybShsdnlJ+V0=;
        b=H2cAIkJdIKNaswjzuYHRaEmQYid0bmo14Rjab6x9ytjX1PqAZUfXvRz0yeAiK4xLFx
         m9PW0glxOVfHJ1YBpSOhI5OrhghC3/Ii0Yi1BTwirmOhZWFTuKACq2mmuWLPRUv83Mog
         +Xfcy9p9MPg/RiYEx1rzzfU96fOSaWAjszzDwnA4okRE1eg1hSHeAVhMysbktWUJe8ib
         jELK/KRnwIjTNRrc+HB6E0ysObaPCavBXi2M08j++0GTAxkRkz4ckjdDcXtHwNDs/pFa
         oHRgedQCbctdMGrhWhh8x6f6u9sQ1Wpu//rfLq2KYZ5S1kyn3T2LLe7yqxdoWfkZDKNV
         8AVQ==
X-Gm-Message-State: AOAM531XVzyRHKSDxE8vPRllKodl3U/k73I2qNMZM/l76a5Y1uypG7xu
        NcxO77n9fyg5R5l2z8qM2dPPxw==
X-Google-Smtp-Source: ABdhPJyculC8o0NXatgS9GYyv2bppChWIIDtFt5acPzzUzpIRQuc6H14UbgJxQKwPYv4Yf2fTJ20nA==
X-Received: by 2002:a05:6a00:244b:b0:4c9:319e:ecb7 with SMTP id d11-20020a056a00244b00b004c9319eecb7mr25843234pfj.58.1646119550062;
        Mon, 28 Feb 2022 23:25:50 -0800 (PST)
Received: from localhost.localdomain ([223.179.136.225])
        by smtp.gmail.com with ESMTPSA id m6-20020a62f206000000b004e152bc0527sm15680445pfh.153.2022.02.28.23.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 23:25:49 -0800 (PST)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        lorenzo.pieralisi@arm.com, agross@kernel.org,
        bjorn.andersson@linaro.org, svarbanov@mm-sol.com,
        bhelgaas@google.com, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, sboyd@kernel.org, mturquette@baylibre.com,
        linux-clk@vger.kernel.org, Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v2 4/7] phy: qcom-qmp: Add SM8150 PCIe QMP PHYs
Date:   Tue,  1 Mar 2022 12:55:08 +0530
Message-Id: <20220301072511.117818-5-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220301072511.117818-1-bhupesh.sharma@linaro.org>
References: <20220301072511.117818-1-bhupesh.sharma@linaro.org>
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

SM8150 has multiple (different) PHY versions:
QMP GEN3x1 PHY - 1 lane
QMP GEN3x2 PHY - 2 lanes

Add support for these with relevant init sequence.

Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp.c | 90 +++++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
index 8ea87c69f463..0805c1bab690 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
@@ -3294,6 +3294,11 @@ static const char * const sdm845_pciephy_clk_l[] = {
 	"aux", "cfg_ahb", "ref", "refgen",
 };
 
+/* the pcie phy on sm8150 doesn't have a ref clock */
+static const char * const sm8150_pciephy_clk_l[] = {
+	"aux", "cfg_ahb", "refgen",
+};
+
 static const char * const qmp_v4_phy_clk_l[] = {
 	"aux", "ref_clk_src", "ref", "com_aux",
 };
@@ -3583,6 +3588,85 @@ static const struct qmp_phy_cfg sdm845_qhp_pciephy_cfg = {
 	.pwrdn_delay_max	= 1005,		/* us */
 };
 
+static const struct qmp_phy_cfg sm8150_qmp_gen3x1_pciephy_cfg = {
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
+	.clk_list		= sm8150_pciephy_clk_l,
+	.num_clks		= ARRAY_SIZE(sm8150_pciephy_clk_l),
+	.reset_list		= sdm845_pciephy_reset_l,
+	.num_resets		= ARRAY_SIZE(sdm845_pciephy_reset_l),
+	.vreg_list		= qmp_phy_vreg_l,
+	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
+	.regs			= sm8250_pcie_regs_layout,
+
+	.start_ctrl		= PCS_START | SERDES_START,
+	.pwrdn_ctrl		= SW_PWRDN | REFCLK_DRV_DSBL,
+	.phy_status		= PHYSTATUS,
+
+	.has_pwrdn_delay	= true,
+	.pwrdn_delay_min	= 995,		/* us */
+	.pwrdn_delay_max	= 1005,		/* us */
+};
+
+static const struct qmp_phy_cfg sm8150_qmp_gen3x2_pciephy_cfg = {
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
+	.clk_list		= sm8150_pciephy_clk_l,
+	.num_clks		= ARRAY_SIZE(sm8150_pciephy_clk_l),
+	.reset_list		= sdm845_pciephy_reset_l,
+	.num_resets		= ARRAY_SIZE(sdm845_pciephy_reset_l),
+	.vreg_list		= qmp_phy_vreg_l,
+	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
+	.regs			= sm8250_pcie_regs_layout,
+
+	.start_ctrl		= PCS_START | SERDES_START,
+	.pwrdn_ctrl		= SW_PWRDN | REFCLK_DRV_DSBL,
+	.phy_status		= PHYSTATUS,
+
+	.is_dual_lane_phy	= true,
+	.has_pwrdn_delay	= true,
+	.pwrdn_delay_min	= 995,		/* us */
+	.pwrdn_delay_max	= 1005,		/* us */
+};
+
 static const struct qmp_phy_cfg sm8250_qmp_gen3x1_pciephy_cfg = {
 	.type = PHY_TYPE_PCIE,
 	.nlanes = 1,
@@ -6004,6 +6088,12 @@ static const struct of_device_id qcom_qmp_phy_of_match_table[] = {
 	}, {
 		.compatible = "qcom,sm6115-qmp-ufs-phy",
 		.data = &sm6115_ufsphy_cfg,
+	}, {
+		.compatible = "qcom,sm8150-qmp-gen3x1-pcie-phy",
+		.data = &sm8150_qmp_gen3x1_pciephy_cfg,
+	}, {
+		.compatible = "qcom,sm8150-qmp-gen3x2-pcie-phy",
+		.data = &sm8150_qmp_gen3x2_pciephy_cfg,
 	}, {
 		.compatible = "qcom,sm8150-qmp-ufs-phy",
 		.data = &sm8150_ufsphy_cfg,
-- 
2.35.1

