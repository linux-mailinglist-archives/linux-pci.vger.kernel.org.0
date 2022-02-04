Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4905A4A9B43
	for <lists+linux-pci@lfdr.de>; Fri,  4 Feb 2022 15:46:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359430AbiBDOqx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Feb 2022 09:46:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359417AbiBDOqw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Feb 2022 09:46:52 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36258C061749
        for <linux-pci@vger.kernel.org>; Fri,  4 Feb 2022 06:46:52 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id n8so13126336lfq.4
        for <linux-pci@vger.kernel.org>; Fri, 04 Feb 2022 06:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4itJXUtYogtLjP/C5kuslRrxl4UhvqybVmRTOjqgGzk=;
        b=MHe9zlCFy+vkTW3PBcu6vL52zJprEi+YLERBnYbQKhGcQyBGJ/Pq8GfhJCt6Rx9dOA
         lxqnBlgHmrdy76qvZgMFaRbnkd/fjqyefS9sRQXkoSFfc2JtOH642XKXU313ThMzzdAw
         gGIMPTP3mQR0HRA6RdkXkRe8gzRThvh7RB/ODO0Wxw6gI84GSr6R2o2msPpgTtLyDAy8
         dW6QhGmmiJ/toOFDCjuuuCQda1HsjY7vGXleRZ+PkTzeKAhliYR61kpU1WqjMVibRTC6
         +dAeLqgHkrDTMTrB9mrvj/81rK5sMki13dH7CC7lb5uhKhfzZ1/s0stJCb9Lcvv9/dRx
         Xaug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4itJXUtYogtLjP/C5kuslRrxl4UhvqybVmRTOjqgGzk=;
        b=BP7BaFOY+nwetO3R5AQfFas1mpvajpt6LPoTKqbaw47DKF9BPeNm4sX6UMljh0byXu
         7u8pa4gHZSX5MA6bsMMdX7BWqLjh7xIkTWfjaIXZThbG88i2p7J1TY2wiUiMfFEk3+nx
         LINIflkc/iZ5ZE4x3ar0XTdbZl+ltZ1HwKG44yFHGZFQ0qowOI6r1CehINShkNFgnnq7
         APsBMge1D32rihhP/qoVAGqlKEFoY2cHm29X6gECZ4t+W0EMwdlVvoLmuqxcM30aH8Qp
         VZp6qMEwr5W/wP7cigBAcemHo2fC9/apWisJ2DSODv3ETu9HamiNEXlz3D5vlZ4QHQtP
         6wmA==
X-Gm-Message-State: AOAM530iO816qf36qvDcvXel7+JdRiSeOgZ+51IJbG9sgLW80sLIvHqM
        d2+TPkXCsE/cX16I65/o2aKC+w==
X-Google-Smtp-Source: ABdhPJxP9osAP8Paagwb19g2FhSJKpP3HNDj150cw/KJOYE6z151czlCbpyDUrW8QSsUZ9Q0f4gKUg==
X-Received: by 2002:a05:6512:33d2:: with SMTP id d18mr2596891lfg.370.1643986010575;
        Fri, 04 Feb 2022 06:46:50 -0800 (PST)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id y23sm348222lfb.2.2022.02.04.06.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 06:46:50 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <swboyd@chromium.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Prasad Malisetty <pmaliset@codeaurora.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 04/11] clk: qcom: gcc-sc7280: switch PCIe GDSCs to pipe_clk_gdsc
Date:   Fri,  4 Feb 2022 17:46:38 +0300
Message-Id: <20220204144645.3016603-5-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220204144645.3016603-1-dmitry.baryshkov@linaro.org>
References: <20220204144645.3016603-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Change sc7280's PCIe GDSCs to use new API for managing corresponding
pipe clock sources.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/clk/qcom/gcc-sc7280.c | 114 ++++++++++++----------------------
 1 file changed, 40 insertions(+), 74 deletions(-)

diff --git a/drivers/clk/qcom/gcc-sc7280.c b/drivers/clk/qcom/gcc-sc7280.c
index 423627d49719..e88a2a2416ff 100644
--- a/drivers/clk/qcom/gcc-sc7280.c
+++ b/drivers/clk/qcom/gcc-sc7280.c
@@ -255,26 +255,6 @@ static const struct clk_parent_data gcc_parent_data_5[] = {
 	{ .hw = &gcc_gpll0_out_even.clkr.hw },
 };
 
-static const struct parent_map gcc_parent_map_6[] = {
-	{ P_PCIE_0_PIPE_CLK, 0 },
-	{ P_BI_TCXO, 2 },
-};
-
-static const struct clk_parent_data gcc_parent_data_6[] = {
-	{ .fw_name = "pcie_0_pipe_clk", .name = "pcie_0_pipe_clk" },
-	{ .fw_name = "bi_tcxo" },
-};
-
-static const struct parent_map gcc_parent_map_7[] = {
-	{ P_PCIE_1_PIPE_CLK, 0 },
-	{ P_BI_TCXO, 2 },
-};
-
-static const struct clk_parent_data gcc_parent_data_7[] = {
-	{ .fw_name = "pcie_1_pipe_clk", .name = "pcie_1_pipe_clk" },
-	{ .fw_name = "bi_tcxo" },
-};
-
 static const struct parent_map gcc_parent_map_8[] = {
 	{ P_BI_TCXO, 0 },
 	{ P_GCC_GPLL0_OUT_MAIN, 1 },
@@ -369,36 +349,6 @@ static const struct clk_parent_data gcc_parent_data_15[] = {
 	{ .hw = &gcc_mss_gpll0_main_div_clk_src.clkr.hw },
 };
 
-static struct clk_regmap_mux gcc_pcie_0_pipe_clk_src = {
-	.reg = 0x6b054,
-	.shift = 0,
-	.width = 2,
-	.parent_map = gcc_parent_map_6,
-	.clkr = {
-		.hw.init = &(struct clk_init_data){
-			.name = "gcc_pcie_0_pipe_clk_src",
-			.parent_data = gcc_parent_data_6,
-			.num_parents = ARRAY_SIZE(gcc_parent_data_6),
-			.ops = &clk_regmap_mux_closest_ops,
-		},
-	},
-};
-
-static struct clk_regmap_mux gcc_pcie_1_pipe_clk_src = {
-	.reg = 0x8d054,
-	.shift = 0,
-	.width = 2,
-	.parent_map = gcc_parent_map_7,
-	.clkr = {
-		.hw.init = &(struct clk_init_data){
-			.name = "gcc_pcie_1_pipe_clk_src",
-			.parent_data = gcc_parent_data_7,
-			.num_parents = ARRAY_SIZE(gcc_parent_data_7),
-			.ops = &clk_regmap_mux_closest_ops,
-		},
-	},
-};
-
 static struct clk_regmap_mux gcc_ufs_phy_rx_symbol_0_clk_src = {
 	.reg = 0x77058,
 	.shift = 0,
@@ -1757,10 +1707,6 @@ static struct clk_branch gcc_pcie_0_pipe_clk = {
 		.enable_mask = BIT(4),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_pcie_0_pipe_clk",
-			.parent_hws = (const struct clk_hw*[]){
-				&gcc_pcie_0_pipe_clk_src.clkr.hw,
-			},
-			.num_parents = 1,
 			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
@@ -1847,10 +1793,6 @@ static struct clk_branch gcc_pcie_1_pipe_clk = {
 		.enable_mask = BIT(30),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_pcie_1_pipe_clk",
-			.parent_hws = (const struct clk_hw*[]){
-				&gcc_pcie_1_pipe_clk_src.clkr.hw,
-			},
-			.num_parents = 1,
 			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
@@ -3113,22 +3055,48 @@ static struct clk_branch gcc_wpss_rscp_clk = {
 	},
 };
 
-static struct gdsc gcc_pcie_0_gdsc = {
-	.gdscr = 0x6b004,
-	.pd = {
-		.name = "gcc_pcie_0_gdsc",
+static struct pipe_clk_gdsc gcc_pcie_0_gdsc = {
+	.base = {
+		.gdscr = 0x6b004,
+		.pd = {
+			.name = "gcc_pcie_0_gdsc",
+		},
+		.pwrsts = PWRSTS_OFF_ON,
+		.flags = VOTABLE,
+	},
+	.num_clocks = 1,
+	.clocks = {
+		{
+			/* gcc_pcie_0_pipe_clk_src */
+			.reg = 0x6b054,
+			.shift = 0,
+			.width = 2,
+			.on_value = 0,
+			.off_value = 2,
+		},
 	},
-	.pwrsts = PWRSTS_OFF_ON,
-	.flags = VOTABLE,
 };
 
-static struct gdsc gcc_pcie_1_gdsc = {
-	.gdscr = 0x8d004,
-	.pd = {
-		.name = "gcc_pcie_1_gdsc",
+static struct pipe_clk_gdsc gcc_pcie_1_gdsc = {
+	.base = {
+		.gdscr = 0x8d004,
+		.pd = {
+			.name = "gcc_pcie_1_gdsc",
+		},
+		.pwrsts = PWRSTS_OFF_ON,
+		.flags = VOTABLE,
+	},
+	.num_clocks = 1,
+	.clocks = {
+		{
+			/* gcc_pcie_1_pipe_clk_src */
+			.reg = 0x8d054,
+			.shift = 0,
+			.width = 2,
+			.on_value = 0,
+			.off_value = 2,
+		},
 	},
-	.pwrsts = PWRSTS_OFF_ON,
-	.flags = VOTABLE,
 };
 
 static struct gdsc gcc_ufs_phy_gdsc = {
@@ -3244,7 +3212,6 @@ static struct clk_regmap *gcc_sc7280_clocks[] = {
 	[GCC_PCIE_0_MSTR_AXI_CLK] = &gcc_pcie_0_mstr_axi_clk.clkr,
 	[GCC_PCIE_0_PHY_RCHNG_CLK_SRC] = &gcc_pcie_0_phy_rchng_clk_src.clkr,
 	[GCC_PCIE_0_PIPE_CLK] = &gcc_pcie_0_pipe_clk.clkr,
-	[GCC_PCIE_0_PIPE_CLK_SRC] = &gcc_pcie_0_pipe_clk_src.clkr,
 	[GCC_PCIE_0_SLV_AXI_CLK] = &gcc_pcie_0_slv_axi_clk.clkr,
 	[GCC_PCIE_0_SLV_Q2A_AXI_CLK] = &gcc_pcie_0_slv_q2a_axi_clk.clkr,
 	[GCC_PCIE_1_AUX_CLK] = &gcc_pcie_1_aux_clk.clkr,
@@ -3253,7 +3220,6 @@ static struct clk_regmap *gcc_sc7280_clocks[] = {
 	[GCC_PCIE_1_MSTR_AXI_CLK] = &gcc_pcie_1_mstr_axi_clk.clkr,
 	[GCC_PCIE_1_PHY_RCHNG_CLK_SRC] = &gcc_pcie_1_phy_rchng_clk_src.clkr,
 	[GCC_PCIE_1_PIPE_CLK] = &gcc_pcie_1_pipe_clk.clkr,
-	[GCC_PCIE_1_PIPE_CLK_SRC] = &gcc_pcie_1_pipe_clk_src.clkr,
 	[GCC_PCIE_1_SLV_AXI_CLK] = &gcc_pcie_1_slv_axi_clk.clkr,
 	[GCC_PCIE_1_SLV_Q2A_AXI_CLK] = &gcc_pcie_1_slv_q2a_axi_clk.clkr,
 	[GCC_PCIE_THROTTLE_CORE_CLK] = &gcc_pcie_throttle_core_clk.clkr,
@@ -3391,8 +3357,8 @@ static struct clk_regmap *gcc_sc7280_clocks[] = {
 };
 
 static struct gdsc *gcc_sc7280_gdscs[] = {
-	[GCC_PCIE_0_GDSC] = &gcc_pcie_0_gdsc,
-	[GCC_PCIE_1_GDSC] = &gcc_pcie_1_gdsc,
+	[GCC_PCIE_0_GDSC] = &gcc_pcie_0_gdsc.base,
+	[GCC_PCIE_1_GDSC] = &gcc_pcie_1_gdsc.base,
 	[GCC_UFS_PHY_GDSC] = &gcc_ufs_phy_gdsc,
 	[GCC_USB30_PRIM_GDSC] = &gcc_usb30_prim_gdsc,
 	[GCC_USB30_SEC_GDSC] = &gcc_usb30_sec_gdsc,
-- 
2.34.1

