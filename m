Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C50C7516760
	for <lists+linux-pci@lfdr.de>; Sun,  1 May 2022 21:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352059AbiEATZ1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 1 May 2022 15:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352313AbiEATZW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 1 May 2022 15:25:22 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57CF8AE73
        for <linux-pci@vger.kernel.org>; Sun,  1 May 2022 12:21:55 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id n14so22171426lfu.13
        for <linux-pci@vger.kernel.org>; Sun, 01 May 2022 12:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EyEhF7k2pEreaYiBT9N8RZXij7PCGcC1qIj0oDB7VuY=;
        b=orZ1ch6O8YxVgW+lGRdQvK3l94rbdGhRsjYcVq1SD3hjvHRMDTT927ELMHh5jL4F3Z
         kzxjwsq0x8rq1isgnTPGw8eUhZEv4njcjMihdoXCULOFlVJfCYnbZPHo3Anath4RqqO5
         KnkCSMYSGAQksz4gUg478chqlVzn1d14i5nHjQTX/1RYPD7bPeoVHwyvX4mCfVs1WeK7
         Secfs/tewcptRc5regmPNTMuzVvaiiws2N688AHq0MEHNkcqlJcBS73dk+CUb/cIMOIJ
         yM+CNfwp7VesWNBo/ed6zg4GwD6AlZ+oNW8qZxcfDFWvlctu401EcfrctQPRgHAC0IjJ
         r+TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EyEhF7k2pEreaYiBT9N8RZXij7PCGcC1qIj0oDB7VuY=;
        b=AyO6BIXnXrs4pT5zIssPKLkUMnKQLYR9a4ZAj17ICkECDz5u6431KxNP2+WBia7JdY
         jMF3BmgXMHkp1H3QSklGPnZxRcd/nhrtm3xjiBc73ma7o+ciReWgytMFzkW5ZVLmgN9A
         wZJGShFNguL9gFVW0lZWVWxyFwfPZl4xb6/HcuN1nrKzV8vtKRKGho8aAQbrnm7TW263
         RUDEBukZaWLFY3HjQVoKqWJoK1XwiutK4hFkktFO7UGzBqYOlN15ZfBcT/UTV5HvqSC6
         tWxuymL9xojASIyYHHqu+HOgiWnw6n5a14R20KNsY+Wt3gPgpJjS4r3aujyuMIlPaarP
         CZcA==
X-Gm-Message-State: AOAM5318Em9CBPgQApoNW21CSbJsAcI7/HUEhEQ7NG03714aFdVxk/QC
        3NXMI54SGnCzKiqPYjtZHTXAUQ==
X-Google-Smtp-Source: ABdhPJxGkltc7I3qBt2CB+HOmaEl/OwnQRC0EHZ3w7RgFM0PMp9wdGeB3xmCLkit25rDG0nu1dWW5A==
X-Received: by 2002:a05:6512:203b:b0:472:4d8b:b124 with SMTP id s27-20020a056512203b00b004724d8bb124mr7137366lfs.241.1651432913516;
        Sun, 01 May 2022 12:21:53 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id q3-20020a2e8743000000b0024f3d1daee6sm865928ljj.110.2022.05.01.12.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 May 2022 12:21:53 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <quic_tdas@quicinc.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Prasad Malisetty <quic_pmaliset@quicinc.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH v4 3/5] clk: qcom: gcc-sm8450: use new clk_regmap_pipe_ops for PCIe pipe clocks
Date:   Sun,  1 May 2022 22:21:47 +0300
Message-Id: <20220501192149.4128158-4-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220501192149.4128158-1-dmitry.baryshkov@linaro.org>
References: <20220501192149.4128158-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Use newly defined clk_regmap_pipe_ops for PCIe pipe clocks to let
the clock framework automatically park the clock when the clock is
switched off and restore the parent when the clock is switched on.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/clk/qcom/gcc-sm8450.c | 51 +++++++++++++----------------------
 1 file changed, 19 insertions(+), 32 deletions(-)

diff --git a/drivers/clk/qcom/gcc-sm8450.c b/drivers/clk/qcom/gcc-sm8450.c
index 593a195467ff..4dd48d62c2ff 100644
--- a/drivers/clk/qcom/gcc-sm8450.c
+++ b/drivers/clk/qcom/gcc-sm8450.c
@@ -17,6 +17,7 @@
 #include "clk-regmap.h"
 #include "clk-regmap-divider.h"
 #include "clk-regmap-mux.h"
+#include "clk-regmap-pipe.h"
 #include "gdsc.h"
 #include "reset.h"
 
@@ -26,9 +27,7 @@ enum {
 	P_GCC_GPLL0_OUT_MAIN,
 	P_GCC_GPLL4_OUT_MAIN,
 	P_GCC_GPLL9_OUT_MAIN,
-	P_PCIE_0_PIPE_CLK,
 	P_PCIE_1_PHY_AUX_CLK,
-	P_PCIE_1_PIPE_CLK,
 	P_SLEEP_CLK,
 	P_UFS_PHY_RX_SYMBOL_0_CLK,
 	P_UFS_PHY_RX_SYMBOL_1_CLK,
@@ -153,16 +152,6 @@ static const struct clk_parent_data gcc_parent_data_3[] = {
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
@@ -173,16 +162,6 @@ static const struct clk_parent_data gcc_parent_data_5[] = {
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
@@ -239,17 +218,21 @@ static const struct clk_parent_data gcc_parent_data_11[] = {
 	{ .fw_name = "bi_tcxo" },
 };
 
-static struct clk_regmap_mux gcc_pcie_0_pipe_clk_src = {
+static struct clk_regmap_pipe gcc_pcie_0_pipe_clk_src = {
 	.reg = 0x7b060,
 	.shift = 0,
 	.width = 2,
-	.parent_map = gcc_parent_map_4,
+	.enable_val = 0, /* pipe_clk */
+	.disable_val = 2, /* bi_tcxo */
 	.clkr = {
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_pcie_0_pipe_clk_src",
-			.parent_data = gcc_parent_data_4,
-			.num_parents = ARRAY_SIZE(gcc_parent_data_4),
-			.ops = &clk_regmap_mux_closest_ops,
+			.parent_data = &(const struct clk_parent_data){
+				.fw_name = "pcie_0_pipe_clk",
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_regmap_pipe_ops,
 		},
 	},
 };
@@ -269,17 +252,21 @@ static struct clk_regmap_mux gcc_pcie_1_phy_aux_clk_src = {
 	},
 };
 
-static struct clk_regmap_mux gcc_pcie_1_pipe_clk_src = {
+static struct clk_regmap_pipe gcc_pcie_1_pipe_clk_src = {
 	.reg = 0x9d064,
 	.shift = 0,
 	.width = 2,
-	.parent_map = gcc_parent_map_6,
+	.enable_val = 0, /* pipe_clk */
+	.disable_val = 2, /* bi_tcxo */
 	.clkr = {
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_pcie_1_pipe_clk_src",
-			.parent_data = gcc_parent_data_6,
-			.num_parents = ARRAY_SIZE(gcc_parent_data_6),
-			.ops = &clk_regmap_mux_closest_ops,
+			.parent_data = &(const struct clk_parent_data){
+				.fw_name = "pcie_1_pipe_clk",
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_regmap_pipe_ops,
 		},
 	},
 };
-- 
2.35.1

