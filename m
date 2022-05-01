Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83879516763
	for <lists+linux-pci@lfdr.de>; Sun,  1 May 2022 21:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352313AbiEATZ3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 1 May 2022 15:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352454AbiEATZW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 1 May 2022 15:25:22 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1011B1E7
        for <linux-pci@vger.kernel.org>; Sun,  1 May 2022 12:21:55 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id bn33so16250025ljb.6
        for <linux-pci@vger.kernel.org>; Sun, 01 May 2022 12:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u5z4QyWYNTy6L/lCR+FZCBsAGIg/8YgUSM/QII5QhQY=;
        b=eDAJBdVftYnOteJFrY6U+htI3tbDrj9FldFIs6U9uROzQpiNMp0SYdqzAPk1woy4C7
         2byTEjnQ/Dbjrvym3tmSkILFRc8pp/5+A1A1yMUXLQIdVYp6v1ErODpBmiXc0LYG3kvh
         FhCWPKMv/nIP1E7Rp6eYGrFJ7gv6pl58HV3CIWDu4wZ+g/DJ6Srbq9nRWehe8wVvaOQG
         yzUbtYZeOCR/ZFzhAKV+1eUDRh+NtE0qGLFIUsMubCzRXx2pnm6kvk59we1l8Uv5GoQq
         DjaPKfNoTLK7yfDUyyDBi6V7/aEf58+yb7oRu5fRK5mkyJOXm11xZ5PZJJvxCOvSCi7b
         khbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u5z4QyWYNTy6L/lCR+FZCBsAGIg/8YgUSM/QII5QhQY=;
        b=mShlXp8jd5JtvKoT6FUbjN8JHHshXEC7SBccZS3jDFUYOBNhheVXy/RWgueXy21l8z
         8Y88EQfvesB5dnho6a1wQlEn4umJVnwsOeIzg3kRnBLVuyVQhcufz5I0a0IeWJs9mYTp
         Cvi2+tLkFIKI9W2mO+6PUPd9uijJf1xRbMxX9x5PmXs6SqdEKaxm1VJ3PMFHpSl60qKr
         m9Y4nyXzS8/YZOMIn4KwoxmdbzDNbFe56QIVlgfvUAvcgSZlJzTIZFkmo6zlfTtIUlCt
         w1XVHDYlJgQ2FRv7JosvG2Elb4UeaCLnalfYd7RoCB9TZX3jJxt9OMj2b+g015xWkg/s
         TP3A==
X-Gm-Message-State: AOAM5312XPjdHIJq6VoSfUs8/Lv1c0wkM+S5ezO/aU5wQdq3lSfAIAqZ
        V+fI7Ue9DH0MJmt7U/6Q2eYwbA==
X-Google-Smtp-Source: ABdhPJwj6nLcq3YQ7z/tcp1/phic4i0AwIonoPWDB+cIKjKAij9pXfAgSCs3n4ruZS3zQt2e6W5RQA==
X-Received: by 2002:a2e:a7cd:0:b0:24f:505f:737d with SMTP id x13-20020a2ea7cd000000b0024f505f737dmr3770048ljp.168.1651432914210;
        Sun, 01 May 2022 12:21:54 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id q3-20020a2e8743000000b0024f3d1daee6sm865928ljj.110.2022.05.01.12.21.53
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
Subject: [PATCH v4 4/5] clk: qcom: gcc-sc7280: use new clk_regmap_pipe_ops for PCIe pipe clocks
Date:   Sun,  1 May 2022 22:21:48 +0300
Message-Id: <20220501192149.4128158-5-dmitry.baryshkov@linaro.org>
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
 drivers/clk/qcom/gcc-sc7280.c | 49 ++++++++++++++---------------------
 1 file changed, 19 insertions(+), 30 deletions(-)

diff --git a/drivers/clk/qcom/gcc-sc7280.c b/drivers/clk/qcom/gcc-sc7280.c
index 423627d49719..458e7bd4a3cb 100644
--- a/drivers/clk/qcom/gcc-sc7280.c
+++ b/drivers/clk/qcom/gcc-sc7280.c
@@ -17,6 +17,7 @@
 #include "clk-rcg.h"
 #include "clk-regmap-divider.h"
 #include "clk-regmap-mux.h"
+#include "clk-regmap-pipe.h"
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
+static struct clk_regmap_pipe gcc_pcie_0_pipe_clk_src = {
 	.reg = 0x6b054,
 	.shift = 0,
 	.width = 2,
-	.parent_map = gcc_parent_map_6,
+	.enable_val = 0, /* pipe_clk */
+	.disable_val = 2, /* bi_tcxo */
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
+			.ops = &clk_regmap_pipe_ops,
 		},
 	},
 };
 
-static struct clk_regmap_mux gcc_pcie_1_pipe_clk_src = {
+static struct clk_regmap_pipe gcc_pcie_1_pipe_clk_src = {
 	.reg = 0x8d054,
 	.shift = 0,
 	.width = 2,
-	.parent_map = gcc_parent_map_7,
+	.enable_val = 0, /* pipe_clk */
+	.disable_val = 2, /* bi_tcxo */
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
+			.ops = &clk_regmap_pipe_ops,
 		},
 	},
 };
-- 
2.35.1

