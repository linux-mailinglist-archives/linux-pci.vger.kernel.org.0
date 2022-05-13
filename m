Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAF335268CB
	for <lists+linux-pci@lfdr.de>; Fri, 13 May 2022 19:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383196AbiEMRxw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 May 2022 13:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383190AbiEMRxs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 May 2022 13:53:48 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 331BF4506C
        for <linux-pci@vger.kernel.org>; Fri, 13 May 2022 10:53:46 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id t25so15773693lfg.7
        for <linux-pci@vger.kernel.org>; Fri, 13 May 2022 10:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V6nPAG235vy01BqFZQ1TvbSleybA03xqCPudZbmriGU=;
        b=THFHVO+Ob/Ldd2ZRuA19e9JMWuFjiLSZVVT00QsJoe9u3+MDBeXisIzq4/IWd8XZDW
         d7Vj58pnKDwsGlGmjOcxACPUd+CTH23IwFp47wLsPVjMsT8JoZywqOTpGEzTfd5kgJ4L
         BtUqSq4OyzPhxhU4vPqd6miR21trc/Zw3dzXOOKRH0fz1cknaKyueiqxxR4Rm/8knPQv
         lubDwOvWbtCDAkdt4aHnHnBQavk0y+GzO8xv1uinSmXi6G5tk/Plv3Y0jV8PGml5jw5o
         YH4o1nd0RmnSgf1v3nZvbYCXkXMLM4/ilcdBnVxYhQRYGl5+AsGlZOYeoYIq8vWGFNoZ
         hPxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V6nPAG235vy01BqFZQ1TvbSleybA03xqCPudZbmriGU=;
        b=39riUUtwzATJ7vhZnixCV12yiHoNyd7Q4Dk0hdn17JnN1oQArqUeYtOmV0LipBOqob
         Q0PswSTHH4fmRHyalfGo7yie5S5ZjkSdXlPHd4Ns0PI1ZwrqOW3cTFZS40tcppKlT/DY
         dH1lffx4JEHF1ZSCppEdlt4PYlTzjWX6E0p8ImFmIx9zNudowlRWxRDhS5J9+AfMHpf3
         GiI2LWrlli1u1tlIdJ641FoghxkxhyYjnH9ZptypXqQwgHqK/4/ILpY9lvp8BgM3eag6
         Q8vpp/zL8xZCkgM6u0cs1FtPEFyD7ImfrI3ELrrpYiWv6pvwpyy6C+4Hbt11hIync4XT
         eEmg==
X-Gm-Message-State: AOAM533xkmvgD6wTWOXVHFhwjMF4KaN3YBV3+C/Z07/HaWjshEFeup+X
        fbLVDVjSczCAyM2MvyvTq1sAVg5CeBjNsw==
X-Google-Smtp-Source: ABdhPJzUWyKYqjeNclROftNifQI4IPYXRGZ2na3aFPSS7IguBiGgo1PoalO9WTBHvvDGxEyoqtXeoA==
X-Received: by 2002:a05:6512:3a94:b0:473:de2d:acf with SMTP id q20-20020a0565123a9400b00473de2d0acfmr4180593lfu.136.1652464424200;
        Fri, 13 May 2022 10:53:44 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id n2-20020a195502000000b0047255d21164sm448614lfe.147.2022.05.13.10.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 10:53:43 -0700 (PDT)
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
Subject: [PATCH v6 4/5] clk: qcom: gcc-sc7280: use new clk_regmap_pipe_src_ops for PCIe pipe clocks
Date:   Fri, 13 May 2022 20:53:38 +0300
Message-Id: <20220513175339.2981959-5-dmitry.baryshkov@linaro.org>
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
 drivers/clk/qcom/gcc-sc7280.c | 49 ++++++++++++++---------------------
 1 file changed, 19 insertions(+), 30 deletions(-)

diff --git a/drivers/clk/qcom/gcc-sc7280.c b/drivers/clk/qcom/gcc-sc7280.c
index 423627d49719..05589ddefcde 100644
--- a/drivers/clk/qcom/gcc-sc7280.c
+++ b/drivers/clk/qcom/gcc-sc7280.c
@@ -17,6 +17,7 @@
 #include "clk-rcg.h"
 #include "clk-regmap-divider.h"
 #include "clk-regmap-mux.h"
+#include "clk-regmap-phy-mux.h"
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
+static struct clk_regmap_phy_mux gcc_pcie_0_pipe_clk_src = {
 	.reg = 0x6b054,
 	.shift = 0,
 	.width = 2,
-	.parent_map = gcc_parent_map_6,
+	.phy_src_val = 0, /* pipe_clk */
+	.ref_src_val = 2, /* bi_tcxo */
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
+			.ops = &clk_regmap_phy_mux_ops,
 		},
 	},
 };
 
-static struct clk_regmap_mux gcc_pcie_1_pipe_clk_src = {
+static struct clk_regmap_phy_mux gcc_pcie_1_pipe_clk_src = {
 	.reg = 0x8d054,
 	.shift = 0,
 	.width = 2,
-	.parent_map = gcc_parent_map_7,
+	.phy_src_val = 0, /* pipe_clk */
+	.ref_src_val = 2, /* bi_tcxo */
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
+			.ops = &clk_regmap_phy_mux_ops,
 		},
 	},
 };
-- 
2.35.1

