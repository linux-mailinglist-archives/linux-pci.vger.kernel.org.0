Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3EC5253A0
	for <lists+linux-pci@lfdr.de>; Thu, 12 May 2022 19:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357053AbiELR3U (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 May 2022 13:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357055AbiELR3Q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 May 2022 13:29:16 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4337C26BC81
        for <linux-pci@vger.kernel.org>; Thu, 12 May 2022 10:29:15 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id j4so10310294lfh.8
        for <linux-pci@vger.kernel.org>; Thu, 12 May 2022 10:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qI547iTMf+foloVmLrNvftsZyKVNTwMO8gUotf5W2tw=;
        b=RLYolMHVdVhRg8OjvPolS7i6ERtJC6QKiQihqq5DAyjvR30OtNWTGfZEJqYVCxSyTm
         Od4k71afwnt7UtqvsO8RqwI7tbql0IpolCH4mA6CdBWZLPiwppao1XnaiL0EBdi8AUbu
         ebXLDZrog+hU8c+qGVAh53RRRHZX0wGnxyiHYlJxU5BuOQg9HCBkVm3nNdQai6+zEIfp
         MlnfhlbHNW3+hDkgWjUAUh/1LV1ScViU1vICNBp4jUJtPv7MO0dCE3MXSo+cNwiobbH7
         V0juCIx+kXNaUiDz1JIi+uanCzq/TTJptCkwI1pwH+je+PKfuMD9CjC1XkwaOG5xsjWr
         8DGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qI547iTMf+foloVmLrNvftsZyKVNTwMO8gUotf5W2tw=;
        b=wxAui68J2FOVb37gzQdopDrrwZCef2p6zP/FJLQ1Tf/6n9qqxfWe/N7AvB8ZXFM+XP
         F72AVEglIlFZVBWywu5G18rKg0cqX7+GoLP4ySeKtX7aZnJaqnqXIGNcXGHCfKR6NEOk
         4cLx+rarfxV/MMh4XvqlVQB/0YTgyoGchxllKODDlYIMFVWFtXhOjV7VdMsCupqfPr7B
         w+W7FxMSxzgkzLdnL2U58qWFczlL7vDgaNEjIVKHgWSoM2GmAXOwlk200JazzNa+Hux6
         +FuI+egaqTwqDX/c1/M1gZJjGU4mXf1qfcKv/KS/QmxD/66Ux/UE6dnWF0Fbm2mj6rfw
         aVqA==
X-Gm-Message-State: AOAM5302USwrDQeurx/674+KXLcsifrnR27Nj3sDuPWpi3eFa7wVBXJM
        VJAZKq5Bmm2nQDQ2qV8f9DxyJQ==
X-Google-Smtp-Source: ABdhPJyNT5Dj2CFFCo3z6qmHezLypXTNWo6w+nS6IhyPDTKKko3dMn6bk20vbPXQ5U1ARaoXPZ3MMQ==
X-Received: by 2002:ac2:4893:0:b0:473:a537:1be2 with SMTP id x19-20020ac24893000000b00473a5371be2mr540175lfc.523.1652376553554;
        Thu, 12 May 2022 10:29:13 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id y10-20020a2e95ca000000b0024f3d1dae9asm11520ljh.34.2022.05.12.10.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 10:29:13 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Prasad Malisetty <pmaliset@codeaurora.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v5 4/5] clk: qcom: gcc-sc7280: use new clk_regmap_pipe_src_ops for PCIe pipe clocks
Date:   Thu, 12 May 2022 20:29:08 +0300
Message-Id: <20220512172909.2436302-5-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220512172909.2436302-1-dmitry.baryshkov@linaro.org>
References: <20220512172909.2436302-1-dmitry.baryshkov@linaro.org>
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

Use newly defined clk_regmap_pipe_src_ops for PCIe pipe clocks to let
the clock framework automatically park the clock when the clock is
switched off and restore the parent when the clock is switched on.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/clk/qcom/gcc-sc7280.c | 49 ++++++++++++++---------------------
 1 file changed, 19 insertions(+), 30 deletions(-)

diff --git a/drivers/clk/qcom/gcc-sc7280.c b/drivers/clk/qcom/gcc-sc7280.c
index 423627d49719..dbe12580ca70 100644
--- a/drivers/clk/qcom/gcc-sc7280.c
+++ b/drivers/clk/qcom/gcc-sc7280.c
@@ -17,6 +17,7 @@
 #include "clk-rcg.h"
 #include "clk-regmap-divider.h"
 #include "clk-regmap-mux.h"
+#include "clk-regmap-pipe-src.h"
 #include "common.h"
 #include "gdsc.h"
 #include "reset.h"
@@ -255,26 +256,6 @@ static const struct clk_parent_data gcc_parent_data_5[] = {
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
@@ -369,32 +350,40 @@ static const struct clk_parent_data gcc_parent_data_15[] = {
 	{ .hw = &gcc_mss_gpll0_main_div_clk_src.clkr.hw },
 };
 
-static struct clk_regmap_mux gcc_pcie_0_pipe_clk_src = {
+static struct clk_regmap_pipe_src gcc_pcie_0_pipe_clk_src = {
 	.reg = 0x6b054,
 	.shift = 0,
 	.width = 2,
-	.parent_map = gcc_parent_map_6,
+	.working_val = 0, /* pipe_clk */
+	.park_val = 2, /* bi_tcxo */
 	.clkr = {
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_pcie_0_pipe_clk_src",
-			.parent_data = gcc_parent_data_6,
-			.num_parents = ARRAY_SIZE(gcc_parent_data_6),
-			.ops = &clk_regmap_mux_closest_ops,
+			.parent_data = &(const struct clk_parent_data){
+				.fw_name = "pcie_0_pipe_clk",
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_regmap_pipe_src_ops,
 		},
 	},
 };
 
-static struct clk_regmap_mux gcc_pcie_1_pipe_clk_src = {
+static struct clk_regmap_pipe_src gcc_pcie_1_pipe_clk_src = {
 	.reg = 0x8d054,
 	.shift = 0,
 	.width = 2,
-	.parent_map = gcc_parent_map_7,
+	.working_val = 0, /* pipe_clk */
+	.park_val = 2, /* bi_tcxo */
 	.clkr = {
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_pcie_1_pipe_clk_src",
-			.parent_data = gcc_parent_data_7,
-			.num_parents = ARRAY_SIZE(gcc_parent_data_7),
-			.ops = &clk_regmap_mux_closest_ops,
+			.parent_data = &(const struct clk_parent_data){
+				.fw_name = "pcie_1_pipe_clk",
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_regmap_pipe_src_ops,
 		},
 	},
 };
-- 
2.35.1

