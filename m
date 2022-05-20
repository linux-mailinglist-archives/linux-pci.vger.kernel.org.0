Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7C952E24E
	for <lists+linux-pci@lfdr.de>; Fri, 20 May 2022 04:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344642AbiETB64 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 May 2022 21:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344626AbiETB6z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 May 2022 21:58:55 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8481EEBE88
        for <linux-pci@vger.kernel.org>; Thu, 19 May 2022 18:58:53 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id p22so11950231lfo.10
        for <linux-pci@vger.kernel.org>; Thu, 19 May 2022 18:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tn6JYbHNbNcR79TWrW0cXNZc3LAbDQuagXGTIjXncgY=;
        b=lBzu2b1k5sNarhW2X2E+gXSc3lbJtXglVTMAYk3MuENFN0ZUrEaNW7KBywlxmGs9Hi
         iNfpk/GR3be5DUVEbkSDu6TxBDn30Ed8brhLjF4ntbiRXGF07bHIxhZsoTzXniSLlacu
         4es+/YJKHTdae6TIL7SRa0fjoJAR1ZsuIzx/VWOwtQVj89blQxbZvK6SJefTPgvsC3I4
         WINv24tO9Ndz04by4HNiW2GG4hBhSuxIyYRrw7GRT+8+bgMcCOjW2f5G0Tf+dzhwDsAf
         rgqiUxhgeDBKL4PO1wjsNj6B2Or3b/S2W/wolsEfzGy9vaHwAeh1Ypov3BsOGtt8tbqP
         lkIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tn6JYbHNbNcR79TWrW0cXNZc3LAbDQuagXGTIjXncgY=;
        b=DxdLAHqsqhN/8RbIH5cnwlyOyCHRGVZkDCYEAXuKeO/1+Vmf7V1V/S5J+/CN5OspuO
         Bkt8OUKMIx8JnzAdALcucCZ8SeumYjCOfACbx/rLa4QM0sxk3x12Si8zIyytiub7QI5q
         Gj6kmTAbZKYJ/bmoby2ziCN6uhV3pITcwLaCoVoLgUer9pVtSxXmKmb4VMvCVQR4VwwL
         QvM6IuWNgO+gz7Sop86bFEzm0dNX2gItPt8DU5r43+gkwDARRaMjW7jXaLRy8AGvsmWu
         GFEMRZt4fsY6Ca30HvohpnpxfemlXvxxuzGBvssFAtGO/0LngcDYGerQtsaskegCOruv
         65xg==
X-Gm-Message-State: AOAM530YkKJxT/3cEbz+kuF+fbzLuOF4dUVH5K5PwwVtvHPokXFk7D7M
        LQzUnJv45ws07lLwDYNc0P3uBA==
X-Google-Smtp-Source: ABdhPJxAoMSfaX7aJowrbLuB5B5X0QVvbFbRwkQoAJeRJGWY1LWCoS/JF+u/UaMhGx1NDH1grgmc2Q==
X-Received: by 2002:a05:6512:281e:b0:478:44f5:3011 with SMTP id cf30-20020a056512281e00b0047844f53011mr1067546lfb.397.1653011933102;
        Thu, 19 May 2022 18:58:53 -0700 (PDT)
Received: from eriador.lan ([2001:470:dd84:abc0::8a5])
        by smtp.gmail.com with ESMTPSA id u28-20020ac24c3c000000b0047255d21192sm467370lfq.193.2022.05.19.18.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 18:58:52 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <quic_tdas@quicinc.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH v7 4/6] clk: qcom: gcc-sc7280: use new clk_regmap_phy_mux_ops for PCIe pipe clocks
Date:   Fri, 20 May 2022 04:58:42 +0300
Message-Id: <20220520015844.1190511-5-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220520015844.1190511-1-dmitry.baryshkov@linaro.org>
References: <20220520015844.1190511-1-dmitry.baryshkov@linaro.org>
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

Use newly defined clk_regmap_phy_mux_ops for PCIe pipe clocks to let
the clock framework automatically park the clock when the clock is
switched off and restore the parent when the clock is switched on.

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/clk/qcom/gcc-sc7280.c | 70 +++++++++++------------------------
 1 file changed, 22 insertions(+), 48 deletions(-)

diff --git a/drivers/clk/qcom/gcc-sc7280.c b/drivers/clk/qcom/gcc-sc7280.c
index dafbbc8f3bf4..83652afbc717 100644
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
@@ -369,35 +349,29 @@ static const struct clk_parent_data gcc_parent_data_15[] = {
 	{ .hw = &gcc_mss_gpll0_main_div_clk_src.clkr.hw },
 };
 
-static struct clk_regmap_mux gcc_pcie_0_pipe_clk_src = {
-	.reg = 0x6b054,
-	.shift = 0,
-	.width = 2,
-	.safe_src_parent = P_BI_TCXO,
-	.parent_map = gcc_parent_map_6,
-	.clkr = {
-		.hw.init = &(struct clk_init_data){
-			.name = "gcc_pcie_0_pipe_clk_src",
-			.parent_data = gcc_parent_data_6,
-			.num_parents = ARRAY_SIZE(gcc_parent_data_6),
-			.ops = &clk_regmap_mux_safe_ops,
+static struct clk_regmap gcc_pcie_0_pipe_clk_src = {
+	.enable_reg = 0x6b054,
+	.hw.init = &(struct clk_init_data){
+		.name = "gcc_pcie_0_pipe_clk_src",
+		.parent_data = &(const struct clk_parent_data){
+			.fw_name = "pcie_0_pipe_clk",
 		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_regmap_phy_mux_ops,
 	},
 };
 
-static struct clk_regmap_mux gcc_pcie_1_pipe_clk_src = {
-	.reg = 0x8d054,
-	.shift = 0,
-	.width = 2,
-	.safe_src_parent = P_BI_TCXO,
-	.parent_map = gcc_parent_map_7,
-	.clkr = {
-		.hw.init = &(struct clk_init_data){
-			.name = "gcc_pcie_1_pipe_clk_src",
-			.parent_data = gcc_parent_data_7,
-			.num_parents = ARRAY_SIZE(gcc_parent_data_7),
-			.ops = &clk_regmap_mux_safe_ops,
+static struct clk_regmap gcc_pcie_1_pipe_clk_src = {
+	.enable_reg = 0x8d054,
+	.hw.init = &(struct clk_init_data){
+		.name = "gcc_pcie_1_pipe_clk_src",
+		.parent_data = &(const struct clk_parent_data){
+			.fw_name = "pcie_1_pipe_clk",
 		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_regmap_phy_mux_ops,
 	},
 };
 
@@ -1760,7 +1734,7 @@ static struct clk_branch gcc_pcie_0_pipe_clk = {
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_pcie_0_pipe_clk",
 			.parent_hws = (const struct clk_hw*[]){
-				&gcc_pcie_0_pipe_clk_src.clkr.hw,
+				&gcc_pcie_0_pipe_clk_src.hw,
 			},
 			.num_parents = 1,
 			.flags = CLK_SET_RATE_PARENT,
@@ -1850,7 +1824,7 @@ static struct clk_branch gcc_pcie_1_pipe_clk = {
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_pcie_1_pipe_clk",
 			.parent_hws = (const struct clk_hw*[]){
-				&gcc_pcie_1_pipe_clk_src.clkr.hw,
+				&gcc_pcie_1_pipe_clk_src.hw,
 			},
 			.num_parents = 1,
 			.flags = CLK_SET_RATE_PARENT,
@@ -3246,7 +3220,7 @@ static struct clk_regmap *gcc_sc7280_clocks[] = {
 	[GCC_PCIE_0_MSTR_AXI_CLK] = &gcc_pcie_0_mstr_axi_clk.clkr,
 	[GCC_PCIE_0_PHY_RCHNG_CLK_SRC] = &gcc_pcie_0_phy_rchng_clk_src.clkr,
 	[GCC_PCIE_0_PIPE_CLK] = &gcc_pcie_0_pipe_clk.clkr,
-	[GCC_PCIE_0_PIPE_CLK_SRC] = &gcc_pcie_0_pipe_clk_src.clkr,
+	[GCC_PCIE_0_PIPE_CLK_SRC] = &gcc_pcie_0_pipe_clk_src,
 	[GCC_PCIE_0_SLV_AXI_CLK] = &gcc_pcie_0_slv_axi_clk.clkr,
 	[GCC_PCIE_0_SLV_Q2A_AXI_CLK] = &gcc_pcie_0_slv_q2a_axi_clk.clkr,
 	[GCC_PCIE_1_AUX_CLK] = &gcc_pcie_1_aux_clk.clkr,
@@ -3255,7 +3229,7 @@ static struct clk_regmap *gcc_sc7280_clocks[] = {
 	[GCC_PCIE_1_MSTR_AXI_CLK] = &gcc_pcie_1_mstr_axi_clk.clkr,
 	[GCC_PCIE_1_PHY_RCHNG_CLK_SRC] = &gcc_pcie_1_phy_rchng_clk_src.clkr,
 	[GCC_PCIE_1_PIPE_CLK] = &gcc_pcie_1_pipe_clk.clkr,
-	[GCC_PCIE_1_PIPE_CLK_SRC] = &gcc_pcie_1_pipe_clk_src.clkr,
+	[GCC_PCIE_1_PIPE_CLK_SRC] = &gcc_pcie_1_pipe_clk_src,
 	[GCC_PCIE_1_SLV_AXI_CLK] = &gcc_pcie_1_slv_axi_clk.clkr,
 	[GCC_PCIE_1_SLV_Q2A_AXI_CLK] = &gcc_pcie_1_slv_q2a_axi_clk.clkr,
 	[GCC_PCIE_THROTTLE_CORE_CLK] = &gcc_pcie_throttle_core_clk.clkr,
-- 
2.35.1

