Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB865268C9
	for <lists+linux-pci@lfdr.de>; Fri, 13 May 2022 19:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379171AbiEMRxw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 May 2022 13:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383187AbiEMRxr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 May 2022 13:53:47 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 323F346161
        for <linux-pci@vger.kernel.org>; Fri, 13 May 2022 10:53:45 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id bx33so11115255ljb.12
        for <linux-pci@vger.kernel.org>; Fri, 13 May 2022 10:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Zj2vS7+dPCo48hDXlzORRFSry0+J2rNpHehW5KrDOXs=;
        b=yK5FA7mnanS4OMHs8BIbax1YjsmSKATlwm9SeY5iO7hF/d1ExlKlM3T1YyD96qGA/u
         qlp45F2dAfc9kGU7QYu2NwkSYw+C6l6OCybe6YDpDZV7oY0W/PHY8N/zHm1zNLWyX24H
         ezZF/n+5/mMbUo5j0KEFN75PjtlYnvMPir/eBCwM0aXN15Kxl5pFIQ/ShDXrgJ6C/S7f
         z/sQrqciiLy5pZhotlDfsnAdYsBFy2qpGAB7KZmDh/ceSlTs1xrHznqLUmb1k8oXX6GW
         sbb++EKWFRXEEtyczcLBYRuI6I+XXksRYrYK3BufqMGCfFbLpBkU736pPQ9jm48R1LGG
         yC3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zj2vS7+dPCo48hDXlzORRFSry0+J2rNpHehW5KrDOXs=;
        b=vkafhoo4dGlM96brgK/NJPI29yo5w7ZZ1lkiyU3ldALWg/edNw49npximmcKAVf0WF
         aj1ZO3ltVYPWg4LMzqSYTfJBp+kDHlhNaCedxmCrOPi8icnHQZeXU/yW5Zvs6lJCUF2e
         DblX98VEubRIZ7tfV3mmok6VwvNTzIAIri7MxOz9g3BReYEnUoEDuvzC+NLTQTAxUxiP
         XKU/iG0IHv3yDvkR18J3lgAilEbwABnPPJmJwzPJ++j9f0LZeFVaLTgrHFET+65VsT5p
         VuG67pjx/GPYFy2S58+YqY0lFB6JrdSxqaYBwn96hUbx+FpJwZSslyrOZZ/bc6ubTHi5
         fsig==
X-Gm-Message-State: AOAM530fKKPG2l0u609iaVquf1pmEQEDfCkRJdQ+98HjX0lBBxQCe6v6
        49hPtmjc1WpeRx/GLjZZWmu+ag==
X-Google-Smtp-Source: ABdhPJxfdiw94BVj9OGmA08UnwPfr4VBYY18UqmCV6YhjdXgEWt3nu0TYlDBc3+36bj6WaeLlZxfUA==
X-Received: by 2002:a05:651c:1506:b0:250:6459:d6d4 with SMTP id e6-20020a05651c150600b002506459d6d4mr3794771ljf.271.1652464423367;
        Fri, 13 May 2022 10:53:43 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id n2-20020a195502000000b0047255d21164sm448614lfe.147.2022.05.13.10.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 10:53:42 -0700 (PDT)
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
Cc:     Prasad Malisetty <quic_pmaliset@quicinc.com>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v6 3/5] clk: qcom: gcc-sm8450: use new clk_regmap_pipe_src_ops for PCIe pipe clocks
Date:   Fri, 13 May 2022 20:53:37 +0300
Message-Id: <20220513175339.2981959-4-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220513175339.2981959-1-dmitry.baryshkov@linaro.org>
References: <20220513175339.2981959-1-dmitry.baryshkov@linaro.org>
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
 drivers/clk/qcom/gcc-sm8450.c | 51 +++++++++++++----------------------
 1 file changed, 19 insertions(+), 32 deletions(-)

diff --git a/drivers/clk/qcom/gcc-sm8450.c b/drivers/clk/qcom/gcc-sm8450.c
index 593a195467ff..a140a89b73b4 100644
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
@@ -239,17 +218,21 @@ static const struct clk_parent_data gcc_parent_data_11[] = {
 	{ .fw_name = "bi_tcxo" },
 };
 
-static struct clk_regmap_mux gcc_pcie_0_pipe_clk_src = {
+static struct clk_regmap_phy_mux gcc_pcie_0_pipe_clk_src = {
 	.reg = 0x7b060,
 	.shift = 0,
 	.width = 2,
-	.parent_map = gcc_parent_map_4,
+	.phy_src_val = 0, /* pipe_clk */
+	.ref_src_val = 2, /* bi_tcxo */
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
+			.ops = &clk_regmap_phy_mux_ops,
 		},
 	},
 };
@@ -269,17 +252,21 @@ static struct clk_regmap_mux gcc_pcie_1_phy_aux_clk_src = {
 	},
 };
 
-static struct clk_regmap_mux gcc_pcie_1_pipe_clk_src = {
+static struct clk_regmap_phy_mux gcc_pcie_1_pipe_clk_src = {
 	.reg = 0x9d064,
 	.shift = 0,
 	.width = 2,
-	.parent_map = gcc_parent_map_6,
+	.phy_src_val = 0, /* pipe_clk */
+	.ref_src_val = 2, /* bi_tcxo */
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
+			.ops = &clk_regmap_phy_mux_ops,
 		},
 	},
 };
-- 
2.35.1

