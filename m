Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3C8053C69B
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jun 2022 09:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242669AbiFCH7W (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Jun 2022 03:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242679AbiFCH7T (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Jun 2022 03:59:19 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B26135DD3
        for <linux-pci@vger.kernel.org>; Fri,  3 Jun 2022 00:59:18 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id a15so11387783lfb.9
        for <linux-pci@vger.kernel.org>; Fri, 03 Jun 2022 00:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9RJouHgK6z7zFRRnATgt5I9ot1jPh7j9Bbrt6OrSheE=;
        b=ALzIuGXLSt0yObvvrgARybff1QYI+K3VTjOH6ggxfqz2XeiByfp5B7WnflotbGTR3r
         c58WvgVQ1x7Cf5Vc6nOy5EtHbSuD2IDpqoK3QXePd3t+5at47ipA7fHSgV+tDbtjVWJ7
         3TyGe9VxVwKSH5gttSebjjOyLKGzDua20uSx+DJ397JkrDS53Rp8go9NtNTk0nkRgg/9
         iZMkatYMDj45c4/0KCSotx+KbRHrOxCOagTJfCKjKNzdwHJZI+wnehW6Q5VQ+OdEstNT
         Bo4ui3YcqnIXcR9nmP7FiPTktCd8oSjAGwb1VROnpkouDaT/sQToTmqpLoJQIF+/U/LA
         m/XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9RJouHgK6z7zFRRnATgt5I9ot1jPh7j9Bbrt6OrSheE=;
        b=gs5bJ1KTeiKnAtkxWvsQV8AILo7r8kX15tsQ/I8D6xMd/LviwHf+bybvn9BZOta9Pc
         A7aqFcN+7+d4SEaS6qmLp5BUZjK3HopBuKjPt5tlPIveF4du2hnXsCaP49u9uA3R55pO
         qskj5zP1v8dtJ3LEeuczMYkpImY+P98wCANpuOVOWdt7nK9Xv30mMJiH0MsFiTilOSxD
         GcMnN8aILAkaZjeUitVcHcJP4vsPC3Cpw/Zi/jd8LAwFI6IFXUbllGOYFdWTC22146sY
         TfHDOKLioxnDu3J/hi9ci9Z41/b2tfuJwkNr71Aq2xHGo1p3GBgmUdZkRZwkS3ZDCPiM
         dwMg==
X-Gm-Message-State: AOAM533zh0pPzQeMqGRWy20U3hCa8r4JuNMnIFrPsnD4icfcmmAiFSmU
        LUG5Zx6tW012KfLFdrgbvNEYiA==
X-Google-Smtp-Source: ABdhPJy0AZ1ok16z2DTNGpHqsSLPYkkvnGDkuHq7SxeiusIhNubuMPn/GEJRLjVutC5HPiZk6v6qhQ==
X-Received: by 2002:a05:6512:31c8:b0:478:6f63:9a1d with SMTP id j8-20020a05651231c800b004786f639a1dmr5947687lfe.111.1654243156520;
        Fri, 03 Jun 2022 00:59:16 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id bp2-20020a056512158200b00477c5940bbasm1438428lfb.265.2022.06.03.00.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 00:59:16 -0700 (PDT)
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
Subject: [PATCH v9 3/5] clk: qcom: gcc-sc7280: use new clk_regmap_phy_mux_ops for PCIe pipe clocks
Date:   Fri,  3 Jun 2022 10:59:06 +0300
Message-Id: <20220603075908.1853011-4-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220603075908.1853011-1-dmitry.baryshkov@linaro.org>
References: <20220603075908.1853011-1-dmitry.baryshkov@linaro.org>
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

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
Tested-by: Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/clk/qcom/gcc-sc7280.c | 47 ++++++++++-------------------------
 1 file changed, 13 insertions(+), 34 deletions(-)

diff --git a/drivers/clk/qcom/gcc-sc7280.c b/drivers/clk/qcom/gcc-sc7280.c
index 423627d49719..5a853497d211 100644
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
@@ -369,32 +350,30 @@ static const struct clk_parent_data gcc_parent_data_15[] = {
 	{ .hw = &gcc_mss_gpll0_main_div_clk_src.clkr.hw },
 };
 
-static struct clk_regmap_mux gcc_pcie_0_pipe_clk_src = {
+static struct clk_regmap_phy_mux gcc_pcie_0_pipe_clk_src = {
 	.reg = 0x6b054,
-	.shift = 0,
-	.width = 2,
-	.parent_map = gcc_parent_map_6,
 	.clkr = {
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_pcie_0_pipe_clk_src",
-			.parent_data = gcc_parent_data_6,
-			.num_parents = ARRAY_SIZE(gcc_parent_data_6),
-			.ops = &clk_regmap_mux_closest_ops,
+			.parent_data = &(const struct clk_parent_data){
+				.fw_name = "pcie_0_pipe_clk", .name = "pcie_0_pipe_clk",
+			},
+			.num_parents = 1,
+			.ops = &clk_regmap_phy_mux_ops,
 		},
 	},
 };
 
-static struct clk_regmap_mux gcc_pcie_1_pipe_clk_src = {
+static struct clk_regmap_phy_mux gcc_pcie_1_pipe_clk_src = {
 	.reg = 0x8d054,
-	.shift = 0,
-	.width = 2,
-	.parent_map = gcc_parent_map_7,
 	.clkr = {
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_pcie_1_pipe_clk_src",
-			.parent_data = gcc_parent_data_7,
-			.num_parents = ARRAY_SIZE(gcc_parent_data_7),
-			.ops = &clk_regmap_mux_closest_ops,
+			.parent_data = &(const struct clk_parent_data){
+				.fw_name = "pcie_1_pipe_clk", .name = "pcie_1_pipe_clk",
+			},
+			.num_parents = 1,
+			.ops = &clk_regmap_phy_mux_ops,
 		},
 	},
 };
-- 
2.35.1

