Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6982152F71D
	for <lists+linux-pci@lfdr.de>; Sat, 21 May 2022 02:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345027AbiEUAx7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 May 2022 20:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354263AbiEUAx7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 May 2022 20:53:59 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECAFD1AEC7C
        for <linux-pci@vger.kernel.org>; Fri, 20 May 2022 17:53:57 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id w14so16891024lfl.13
        for <linux-pci@vger.kernel.org>; Fri, 20 May 2022 17:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tCXX/Suoor8FeffrE1PZMey9/yk9K9HFCl7bJI8LK0Q=;
        b=PlsLnRZcE5o5c21WAKOxrI+RFu+D9tCU4ItCkD3uB7kQJqcGo6ICMyMnpclygpW75I
         2TZMKLYr8udTVj4jemfrgWP1kSmOU+XTmeHpX3p4oT8L6NJOg87uwmx9omlaGVcKdQhx
         +VRhIJXyzPKefp7amL7ndHZ2gr8JemZVJXVq/1PbWupzgE+TUAv41xmpL+igUm+LZrNR
         BV7410xcTzGh0p//BZF8xPiJAM5k44qNntdAIBj6s6JYBMSrK35nDj8XIABFgTAkGrRo
         LoQ+Ng94JfbMXufcR44Jgz3ejQa6d9E4p5LV3bf1+Orn+KprDA556BsVFVbxJQEHjHA7
         uHyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tCXX/Suoor8FeffrE1PZMey9/yk9K9HFCl7bJI8LK0Q=;
        b=w2eA7WoL9ZndG2DRG4oUrilhaQsdX2UWbfIfxRyR9dYnXJnNd0D7f0a6L3ryef9yIh
         WAlBye6kfBGSPhlPuatVhLiYPqq6LhYiI2oj4oKDvj5cKjvPHBsXj+To+5Uo29RGifnp
         LDcoJoce0jIGbVUU26llTwshfMFTtR7zJyX1GiJIUEC5JS8exCGniTc0TuLT6edY+Fs/
         FUeSIMmqrEKUsIMcxGHZ/I/VXyfSAkrQbZxzJWIPegFKtY3K+0QbynXDfoMhaXIpna2V
         HpRZDIQHieSPX81vudGHqjZs7S6jaGhaeDIGb1iHgNANqRLX7EE7xaZWVvc7VmjgZgVY
         o0qQ==
X-Gm-Message-State: AOAM533Vjxb1rhQ+v+y5z7x98F+ot2DwepZyhDLQShaG1x6f6acnB63x
        gSccl+4J5ygikWb5wDzh3eKDdQ==
X-Google-Smtp-Source: ABdhPJwR8SMI8cuMaG6W/ZmbnrRoPehYtmZ2aeM3FsEEZEsYO8mVlIjJ1epF+iXD9ZQ/+qSTqVJxSA==
X-Received: by 2002:a05:6512:39cd:b0:477:a28e:bb69 with SMTP id k13-20020a05651239cd00b00477a28ebb69mr8637331lfu.438.1653094436120;
        Fri, 20 May 2022 17:53:56 -0700 (PDT)
Received: from eriador.lan ([2001:470:dd84:abc0::8a5])
        by smtp.gmail.com with ESMTPSA id u14-20020a056512094e00b0047255d21187sm844559lft.182.2022.05.20.17.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 17:53:55 -0700 (PDT)
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
Subject: [PATCH v7 5/8] clk: qcom: gcc-sm8450: use new clk_regmap_phy_mux_ops for PCIe pipe clocks
Date:   Sat, 21 May 2022 03:53:40 +0300
Message-Id: <20220521005343.1429642-6-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220521005343.1429642-1-dmitry.baryshkov@linaro.org>
References: <20220521005343.1429642-1-dmitry.baryshkov@linaro.org>
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

Use newly defined clk_regmap_phy_mux_ops for PCIe pipe clocks to let
the clock framework automatically park the clock when the clock is
switched off and restore the parent when the clock is switched on.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/clk/qcom/gcc-sm8450.c | 49 ++++++++++-------------------------
 1 file changed, 13 insertions(+), 36 deletions(-)

diff --git a/drivers/clk/qcom/gcc-sm8450.c b/drivers/clk/qcom/gcc-sm8450.c
index 593a195467ff..666efa5ff978 100644
--- a/drivers/clk/qcom/gcc-sm8450.c
+++ b/drivers/clk/qcom/gcc-sm8450.c
@@ -17,6 +17,7 @@
 #include "clk-regmap.h"
 #include "clk-regmap-divider.h"
 #include "clk-regmap-mux.h"
+#include "clk-regmap-phy-mux.h"
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
@@ -239,17 +218,16 @@ static const struct clk_parent_data gcc_parent_data_11[] = {
 	{ .fw_name = "bi_tcxo" },
 };
 
-static struct clk_regmap_mux gcc_pcie_0_pipe_clk_src = {
+static struct clk_regmap_phy_mux gcc_pcie_0_pipe_clk_src = {
 	.reg = 0x7b060,
-	.shift = 0,
-	.width = 2,
-	.parent_map = gcc_parent_map_4,
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
+			.ops = &clk_regmap_phy_mux_ops,
 		},
 	},
 };
@@ -269,17 +247,16 @@ static struct clk_regmap_mux gcc_pcie_1_phy_aux_clk_src = {
 	},
 };
 
-static struct clk_regmap_mux gcc_pcie_1_pipe_clk_src = {
+static struct clk_regmap_phy_mux gcc_pcie_1_pipe_clk_src = {
 	.reg = 0x9d064,
-	.shift = 0,
-	.width = 2,
-	.parent_map = gcc_parent_map_6,
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
+			.ops = &clk_regmap_phy_mux_ops,
 		},
 	},
 };
-- 
2.35.1

