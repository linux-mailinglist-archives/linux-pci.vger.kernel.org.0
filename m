Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00EE852E246
	for <lists+linux-pci@lfdr.de>; Fri, 20 May 2022 04:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344650AbiETB64 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 May 2022 21:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344638AbiETB6z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 May 2022 21:58:55 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88910EBEB2
        for <linux-pci@vger.kernel.org>; Thu, 19 May 2022 18:58:53 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id s5so8129191ljd.10
        for <linux-pci@vger.kernel.org>; Thu, 19 May 2022 18:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wG0wuxUV/+KVtoJL5kMj1RqHKozuaFqKYSigut5z9HI=;
        b=Q+CmOepDT3n8gEk44gK3MxbJIEkphDithhmbFaa9aw7tRL21OLvIqR9KE/Eh0lHY+9
         4d/9zKSB6dINPK4dOrFM0peAIZ5yICIWSDFgDBUIgte/VJtWis4PNfUSt7Jj1bgzhicg
         aBDo9N51R5UeBd+AUkT/pKzZATfOLyYmS1UHqG3lJASvM54DMqOBlGFddiO0BK8zzZLL
         Z3DnOuwAz2PEuAfEqmPGRvr4wniDb/Qjj0/rsfd3K6yssGR7JjqN1hefDzb4jtMPhHzc
         jUAMBokkOufgMtqmLRr+Ecr37314FJ1TXPnnGdPxfO1Vy6NOF/I926UB+a/A9krUzsv/
         /6kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wG0wuxUV/+KVtoJL5kMj1RqHKozuaFqKYSigut5z9HI=;
        b=xZhzRbBLW1TRncMTJJ6NcSH323KLsdK5k83m6GBoZOwz/Y6/b7FU+SDLm4dgBzQDaM
         52SGbOvTVjeDGVaM3J32D0i1L+gqgZVGnZg0GhI987PC2lDiC1L+6/D3K3gnLr2c5N6T
         dwRfMJcaGgZ1lwszaRGfKh3WTrgwIdZx1OG+iBMUeI8judt8w3ponirt0dUHPQ9wAKx4
         h66JlZ5q5BFI9tuHeYYfvhh+4gheuob2rYDs0FR44Ye3TZ8yzdFwwJ8Z4G/m2Sw//s6o
         N0VtiObJiRR9lttY8Wfhuw2j5udfwsmq6es8rFJvWHCk02ffbDRbdfx0D8tce0+nUtEH
         XwPA==
X-Gm-Message-State: AOAM530Z4xEoV94y2hCfOlRpBqSDf7qdyWIQ98jleBzvYppU2emJCAY/
        uPGMQg2exDzLxtNNbvdaG4Lp5Q==
X-Google-Smtp-Source: ABdhPJzDcrkPf3xWc/G+vbtvyokerWNAGXQP8EDwtCZ6vwnVeGpOj6tQWmJrZ3VrEJzKtP5AnBdZrg==
X-Received: by 2002:a05:651c:2118:b0:253:dede:5fa2 with SMTP id a24-20020a05651c211800b00253dede5fa2mr146439ljq.414.1653011931671;
        Thu, 19 May 2022 18:58:51 -0700 (PDT)
Received: from eriador.lan ([2001:470:dd84:abc0::8a5])
        by smtp.gmail.com with ESMTPSA id u28-20020ac24c3c000000b0047255d21192sm467370lfq.193.2022.05.19.18.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 18:58:51 -0700 (PDT)
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
Subject: [PATCH v7 3/6] clk: qcom: gcc-sm8450: use new clk_regmap_phy_mux_ops for PCIe pipe clocks
Date:   Fri, 20 May 2022 04:58:41 +0300
Message-Id: <20220520015844.1190511-4-dmitry.baryshkov@linaro.org>
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
 drivers/clk/qcom/gcc-sm8450.c | 72 +++++++++++------------------------
 1 file changed, 22 insertions(+), 50 deletions(-)

diff --git a/drivers/clk/qcom/gcc-sm8450.c b/drivers/clk/qcom/gcc-sm8450.c
index fb6decd3df49..8a62f141ab23 100644
--- a/drivers/clk/qcom/gcc-sm8450.c
+++ b/drivers/clk/qcom/gcc-sm8450.c
@@ -26,9 +26,7 @@ enum {
 	P_GCC_GPLL0_OUT_MAIN,
 	P_GCC_GPLL4_OUT_MAIN,
 	P_GCC_GPLL9_OUT_MAIN,
-	P_PCIE_0_PIPE_CLK,
 	P_PCIE_1_PHY_AUX_CLK,
-	P_PCIE_1_PIPE_CLK,
 	P_SLEEP_CLK,
 	P_UFS_PHY_RX_SYMBOL_0_CLK,
 	P_UFS_PHY_RX_SYMBOL_1_CLK,
@@ -153,16 +151,6 @@ static const struct clk_parent_data gcc_parent_data_3[] = {
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
@@ -173,16 +161,6 @@ static const struct clk_parent_data gcc_parent_data_5[] = {
 	{ .fw_name = "bi_tcxo" },
 };
 
-static const struct parent_map gcc_parent_map_6[] = {
-	{ P_PCIE_1_PIPE_CLK, 0 },
-	{ P_BI_TCXO, 2 },
-};
-
-static const struct clk_parent_data gcc_parent_data_6[] = {
-	{ .fw_name = "pcie_1_pipe_clk" },
-	{ .fw_name = "bi_tcxo" },
-};
-
 static const struct parent_map gcc_parent_map_7[] = {
 	{ P_BI_TCXO, 0 },
 	{ P_GCC_GPLL0_OUT_MAIN, 1 },
@@ -239,19 +217,16 @@ static const struct clk_parent_data gcc_parent_data_11[] = {
 	{ .fw_name = "bi_tcxo" },
 };
 
-static struct clk_regmap_mux gcc_pcie_0_pipe_clk_src = {
-	.reg = 0x7b060,
-	.shift = 0,
-	.width = 2,
-	.safe_src_parent = P_BI_TCXO,
-	.parent_map = gcc_parent_map_4,
-	.clkr = {
-		.hw.init = &(struct clk_init_data){
-			.name = "gcc_pcie_0_pipe_clk_src",
-			.parent_data = gcc_parent_data_4,
-			.num_parents = ARRAY_SIZE(gcc_parent_data_4),
-			.ops = &clk_regmap_mux_safe_ops,
+static struct clk_regmap gcc_pcie_0_pipe_clk_src = {
+	.enable_reg = 0x7b060,
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
 
@@ -270,19 +245,16 @@ static struct clk_regmap_mux gcc_pcie_1_phy_aux_clk_src = {
 	},
 };
 
-static struct clk_regmap_mux gcc_pcie_1_pipe_clk_src = {
-	.reg = 0x9d064,
-	.shift = 0,
-	.width = 2,
-	.safe_src_parent = P_BI_TCXO,
-	.parent_map = gcc_parent_map_6,
-	.clkr = {
-		.hw.init = &(struct clk_init_data){
-			.name = "gcc_pcie_1_pipe_clk_src",
-			.parent_data = gcc_parent_data_6,
-			.num_parents = ARRAY_SIZE(gcc_parent_data_6),
-			.ops = &clk_regmap_mux_safe_ops,
+static struct clk_regmap gcc_pcie_1_pipe_clk_src = {
+	.enable_reg = 0x9d064,
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
 
@@ -1549,7 +1521,7 @@ static struct clk_branch gcc_pcie_0_pipe_clk = {
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_pcie_0_pipe_clk",
 			.parent_data = &(const struct clk_parent_data){
-				.hw = &gcc_pcie_0_pipe_clk_src.clkr.hw,
+				.hw = &gcc_pcie_0_pipe_clk_src.hw,
 			},
 			.num_parents = 1,
 			.flags = CLK_SET_RATE_PARENT,
@@ -1690,7 +1662,7 @@ static struct clk_branch gcc_pcie_1_pipe_clk = {
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_pcie_1_pipe_clk",
 			.parent_data = &(const struct clk_parent_data){
-				.hw = &gcc_pcie_1_pipe_clk_src.clkr.hw,
+				.hw = &gcc_pcie_1_pipe_clk_src.hw,
 			},
 			.num_parents = 1,
 			.flags = CLK_SET_RATE_PARENT,
@@ -3024,7 +2996,7 @@ static struct clk_regmap *gcc_sm8450_clocks[] = {
 	[GCC_PCIE_0_PHY_RCHNG_CLK] = &gcc_pcie_0_phy_rchng_clk.clkr,
 	[GCC_PCIE_0_PHY_RCHNG_CLK_SRC] = &gcc_pcie_0_phy_rchng_clk_src.clkr,
 	[GCC_PCIE_0_PIPE_CLK] = &gcc_pcie_0_pipe_clk.clkr,
-	[GCC_PCIE_0_PIPE_CLK_SRC] = &gcc_pcie_0_pipe_clk_src.clkr,
+	[GCC_PCIE_0_PIPE_CLK_SRC] = &gcc_pcie_0_pipe_clk_src,
 	[GCC_PCIE_0_SLV_AXI_CLK] = &gcc_pcie_0_slv_axi_clk.clkr,
 	[GCC_PCIE_0_SLV_Q2A_AXI_CLK] = &gcc_pcie_0_slv_q2a_axi_clk.clkr,
 	[GCC_PCIE_1_AUX_CLK] = &gcc_pcie_1_aux_clk.clkr,
@@ -3037,7 +3009,7 @@ static struct clk_regmap *gcc_sm8450_clocks[] = {
 	[GCC_PCIE_1_PHY_RCHNG_CLK] = &gcc_pcie_1_phy_rchng_clk.clkr,
 	[GCC_PCIE_1_PHY_RCHNG_CLK_SRC] = &gcc_pcie_1_phy_rchng_clk_src.clkr,
 	[GCC_PCIE_1_PIPE_CLK] = &gcc_pcie_1_pipe_clk.clkr,
-	[GCC_PCIE_1_PIPE_CLK_SRC] = &gcc_pcie_1_pipe_clk_src.clkr,
+	[GCC_PCIE_1_PIPE_CLK_SRC] = &gcc_pcie_1_pipe_clk_src,
 	[GCC_PCIE_1_SLV_AXI_CLK] = &gcc_pcie_1_slv_axi_clk.clkr,
 	[GCC_PCIE_1_SLV_Q2A_AXI_CLK] = &gcc_pcie_1_slv_q2a_axi_clk.clkr,
 	[GCC_PDM2_CLK] = &gcc_pdm2_clk.clkr,
-- 
2.35.1

