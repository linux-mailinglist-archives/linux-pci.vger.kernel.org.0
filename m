Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 039EC4A9B3D
	for <lists+linux-pci@lfdr.de>; Fri,  4 Feb 2022 15:46:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359414AbiBDOqy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Feb 2022 09:46:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359406AbiBDOqx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Feb 2022 09:46:53 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2256BC061744
        for <linux-pci@vger.kernel.org>; Fri,  4 Feb 2022 06:46:53 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id o12so13029281lfg.12
        for <linux-pci@vger.kernel.org>; Fri, 04 Feb 2022 06:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RA4FOAXJ6P+53lO4zwbKIwRpBbTm5dltdfGX+k3V2eE=;
        b=x5sfI3ozKAlxUhdelqK9eLiuzuEzlBqC0o3C7D+uw3opCEHasKnK00xbTkaWsXqjEb
         FcMF3obutzuWjjOzOqN0BZKG7IadtamfDcsblKoGCb/9dT6Q2bt2SrwL3RrSXem1d8XM
         vUrbOtmCY5SaBsbC9x9SDz06O+nH4W50XL3yjF2lww8dnZOmj5EWOI9b9BKjaeZiL643
         NyTiUwO3LuynQ14Vr49g8lJSRYTpVwP2sGE0GaBdBWqz2tFyfTwweh5p7XMrbt3uMy1T
         x7HcMwKXzL/+ZDcx2lmYZik8Di6LF0Gklq8WIN+hMA48n6HWHLFG/5u0KWAEnbFSiGXn
         /dHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RA4FOAXJ6P+53lO4zwbKIwRpBbTm5dltdfGX+k3V2eE=;
        b=wcYMnav6lfoBfT5rP9QU1lQpTzQ9vPrhVemzIKDYL/ynRVQS7sP1kHdj314TIhE5F1
         1LnuniH/ZLcqY5GkONgCMXEA+yjltq6ZtRnCfZPPj6tvh/IGO6oW71BzOtyIipZA7gsc
         rxDfhtTCUTbJ4sgjN5VWDQ4wBfPRHcD6x7fn7YrI5etLiwg5wVMDaCtHyRnIDbCdja2e
         KR3hoxbhVSDsQw+aUTOqiFCTM/qlyaBK+/xg5clnY9C4M7nVqHAmDIhqbs8yk0Sf7o8Z
         Ox2zLjhBmv3lNPx5F+/Dm1C9BonfYBGaY19k+CKeJF04+L3krIETM7A6XELHJj8nJ8Hx
         MODw==
X-Gm-Message-State: AOAM531XrnlVTRZV817ADDSpYmxr9dJTYDYZ1u2NJmUULBgIeuurnk7Q
        G8/ysaZJs+7vN53uuWeCGzbuOA==
X-Google-Smtp-Source: ABdhPJwYLirTRdiKsvsmvABqTI2YLEW3Ybf8arrEfYtsZBN5BpL7an6VetIuwMXWNwVI//tECbdxkQ==
X-Received: by 2002:a05:6512:3d03:: with SMTP id d3mr2518225lfv.591.1643986011409;
        Fri, 04 Feb 2022 06:46:51 -0800 (PST)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id y23sm348222lfb.2.2022.02.04.06.46.50
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
Subject: [PATCH v2 05/11] clk: qcom: gcc-sm8450: switch PCIe GDSCs to pipe_clk_gdsc
Date:   Fri,  4 Feb 2022 17:46:39 +0300
Message-Id: <20220204144645.3016603-6-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220204144645.3016603-1-dmitry.baryshkov@linaro.org>
References: <20220204144645.3016603-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Change sm8450's PCIe GDSCs to use new API for managing corresponding
pipe clock sources.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/clk/qcom/gcc-sm8450.c | 104 ++++++++++++++--------------------
 1 file changed, 42 insertions(+), 62 deletions(-)

diff --git a/drivers/clk/qcom/gcc-sm8450.c b/drivers/clk/qcom/gcc-sm8450.c
index 593a195467ff..a81456598b28 100644
--- a/drivers/clk/qcom/gcc-sm8450.c
+++ b/drivers/clk/qcom/gcc-sm8450.c
@@ -153,16 +153,6 @@ static const struct clk_parent_data gcc_parent_data_3[] = {
 	{ .fw_name = "bi_tcxo" },
 };
 
-static const struct parent_map gcc_parent_map_4[] = {
-	{ P_PCIE_0_PIPE_CLK, 0 },
-	{ P_BI_TCXO, 2 },
-};
-
-static const struct clk_parent_data gcc_parent_data_4[] = {
-	{ .fw_name = "pcie_0_pipe_clk", },
-	{ .fw_name = "bi_tcxo", },
-};
-
 static const struct parent_map gcc_parent_map_5[] = {
 	{ P_PCIE_1_PHY_AUX_CLK, 0 },
 	{ P_BI_TCXO, 2 },
@@ -239,21 +229,6 @@ static const struct clk_parent_data gcc_parent_data_11[] = {
 	{ .fw_name = "bi_tcxo" },
 };
 
-static struct clk_regmap_mux gcc_pcie_0_pipe_clk_src = {
-	.reg = 0x7b060,
-	.shift = 0,
-	.width = 2,
-	.parent_map = gcc_parent_map_4,
-	.clkr = {
-		.hw.init = &(struct clk_init_data){
-			.name = "gcc_pcie_0_pipe_clk_src",
-			.parent_data = gcc_parent_data_4,
-			.num_parents = ARRAY_SIZE(gcc_parent_data_4),
-			.ops = &clk_regmap_mux_closest_ops,
-		},
-	},
-};
-
 static struct clk_regmap_mux gcc_pcie_1_phy_aux_clk_src = {
 	.reg = 0x9d080,
 	.shift = 0,
@@ -269,21 +244,6 @@ static struct clk_regmap_mux gcc_pcie_1_phy_aux_clk_src = {
 	},
 };
 
-static struct clk_regmap_mux gcc_pcie_1_pipe_clk_src = {
-	.reg = 0x9d064,
-	.shift = 0,
-	.width = 2,
-	.parent_map = gcc_parent_map_6,
-	.clkr = {
-		.hw.init = &(struct clk_init_data){
-			.name = "gcc_pcie_1_pipe_clk_src",
-			.parent_data = gcc_parent_data_6,
-			.num_parents = ARRAY_SIZE(gcc_parent_data_6),
-			.ops = &clk_regmap_mux_closest_ops,
-		},
-	},
-};
-
 static struct clk_regmap_mux gcc_ufs_phy_rx_symbol_0_clk_src = {
 	.reg = 0x87060,
 	.shift = 0,
@@ -1546,10 +1506,6 @@ static struct clk_branch gcc_pcie_0_pipe_clk = {
 		.enable_mask = BIT(4),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_pcie_0_pipe_clk",
-			.parent_data = &(const struct clk_parent_data){
-				.hw = &gcc_pcie_0_pipe_clk_src.clkr.hw,
-			},
-			.num_parents = 1,
 			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
@@ -1687,10 +1643,6 @@ static struct clk_branch gcc_pcie_1_pipe_clk = {
 		.enable_mask = BIT(30),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_pcie_1_pipe_clk",
-			.parent_data = &(const struct clk_parent_data){
-				.hw = &gcc_pcie_1_pipe_clk_src.clkr.hw,
-			},
-			.num_parents = 1,
 			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
@@ -2952,20 +2904,50 @@ static struct clk_branch gcc_video_axi1_clk = {
 	},
 };
 
-static struct gdsc pcie_0_gdsc = {
-	.gdscr = 0x7b004,
-	.pd = {
-		.name = "pcie_0_gdsc",
+static struct pipe_clk_gdsc pcie_0_gdsc = {
+	.base = {
+		.gdscr = 0x7b004,
+		.pd = {
+			.name = "pcie_0_gdsc",
+			.power_on = gdsc_pipe_enable,
+			.power_off = gdsc_pipe_disable,
+		},
+		.pwrsts = PWRSTS_OFF_ON,
+	},
+	.num_clocks = 1,
+	.clocks = {
+		{
+			/* gcc_pcie_0_pipe_clk_src */
+			.reg = 0x7b060,
+			.shift = 0,
+			.width = 2,
+			.on_value = 0,
+			.off_value = 2,
+		},
 	},
-	.pwrsts = PWRSTS_OFF_ON,
 };
 
-static struct gdsc pcie_1_gdsc = {
-	.gdscr = 0x9d004,
-	.pd = {
-		.name = "pcie_1_gdsc",
+static struct pipe_clk_gdsc pcie_1_gdsc = {
+	.base = {
+		.gdscr = 0x9d004,
+		.pd = {
+			.name = "pcie_1_gdsc",
+			.power_on = gdsc_pipe_enable,
+			.power_off = gdsc_pipe_disable,
+		},
+		.pwrsts = PWRSTS_OFF_ON,
+	},
+	.num_clocks = 1,
+	.clocks = {
+		{
+			/* gcc_pcie_1_pipe_clk_src */
+			.reg = 0x9d064,
+			.shift = 0,
+			.width = 2,
+			.on_value = 0,
+			.off_value = 2,
+		},
 	},
-	.pwrsts = PWRSTS_OFF_ON,
 };
 
 static struct gdsc ufs_phy_gdsc = {
@@ -3022,7 +3004,6 @@ static struct clk_regmap *gcc_sm8450_clocks[] = {
 	[GCC_PCIE_0_PHY_RCHNG_CLK] = &gcc_pcie_0_phy_rchng_clk.clkr,
 	[GCC_PCIE_0_PHY_RCHNG_CLK_SRC] = &gcc_pcie_0_phy_rchng_clk_src.clkr,
 	[GCC_PCIE_0_PIPE_CLK] = &gcc_pcie_0_pipe_clk.clkr,
-	[GCC_PCIE_0_PIPE_CLK_SRC] = &gcc_pcie_0_pipe_clk_src.clkr,
 	[GCC_PCIE_0_SLV_AXI_CLK] = &gcc_pcie_0_slv_axi_clk.clkr,
 	[GCC_PCIE_0_SLV_Q2A_AXI_CLK] = &gcc_pcie_0_slv_q2a_axi_clk.clkr,
 	[GCC_PCIE_1_AUX_CLK] = &gcc_pcie_1_aux_clk.clkr,
@@ -3035,7 +3016,6 @@ static struct clk_regmap *gcc_sm8450_clocks[] = {
 	[GCC_PCIE_1_PHY_RCHNG_CLK] = &gcc_pcie_1_phy_rchng_clk.clkr,
 	[GCC_PCIE_1_PHY_RCHNG_CLK_SRC] = &gcc_pcie_1_phy_rchng_clk_src.clkr,
 	[GCC_PCIE_1_PIPE_CLK] = &gcc_pcie_1_pipe_clk.clkr,
-	[GCC_PCIE_1_PIPE_CLK_SRC] = &gcc_pcie_1_pipe_clk_src.clkr,
 	[GCC_PCIE_1_SLV_AXI_CLK] = &gcc_pcie_1_slv_axi_clk.clkr,
 	[GCC_PCIE_1_SLV_Q2A_AXI_CLK] = &gcc_pcie_1_slv_q2a_axi_clk.clkr,
 	[GCC_PDM2_CLK] = &gcc_pdm2_clk.clkr,
@@ -3216,8 +3196,8 @@ static const struct clk_rcg_dfs_data gcc_dfs_clocks[] = {
 };
 
 static struct gdsc *gcc_sm8450_gdscs[] = {
-	[PCIE_0_GDSC] = &pcie_0_gdsc,
-	[PCIE_1_GDSC] = &pcie_1_gdsc,
+	[PCIE_0_GDSC] = &pcie_0_gdsc.base,
+	[PCIE_1_GDSC] = &pcie_1_gdsc.base,
 	[UFS_PHY_GDSC] = &ufs_phy_gdsc,
 	[USB30_PRIM_GDSC] = &usb30_prim_gdsc,
 };
-- 
2.34.1

