Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 398ED53C71C
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jun 2022 10:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242865AbiFCIpC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Jun 2022 04:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242859AbiFCIpA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Jun 2022 04:45:00 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4535C36E1A
        for <linux-pci@vger.kernel.org>; Fri,  3 Jun 2022 01:44:59 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id t25so11534649lfg.7
        for <linux-pci@vger.kernel.org>; Fri, 03 Jun 2022 01:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/EDLNTI5pI/Mi1iA33N6km0sR5Uc9crbW1Xns2oX9B0=;
        b=ZJ271B6Ikppj9bkr5p1LXeNC+LkvtzH56jVb1P3l1eEmah7Yq3s2Aykn7Wj2NIcjoH
         kS6rsqTEA+xlfTFOg5gzPRSMNU89MPzxyDW/NvgwVKW/xlBWKbC8k73Ct076RHEbdrAl
         s9zruWzS1BKpcsXo0KlSoOTL0RU1Eabjr42abK18yOQzx9TPjwGyhaJtCasGK189Dt0U
         1A4YbbJjTA391JIqLKMN2NuVD3CjB8xDHRn7mkvvXZy8C0HjPWHYErGy6fL246lvxSlO
         LYBQKyFgL2MgKiVBM1qr1nmSb1WLf6OBC0qg9cK7+Wrm90IZNFbMgytwIXE83YlmcpJM
         mAYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/EDLNTI5pI/Mi1iA33N6km0sR5Uc9crbW1Xns2oX9B0=;
        b=aIH4s63+2FgLjOV0CcB/psDKmoMDhPdc/64DTohONazH/KGx1zGVLWZTrl2oYGFmoD
         GIVjGy6FM8SHdpKY1iUuq1x9WJAYbnOLrmcSBsoZ2LL0adDYsA/J+y9aei+n+x5Gb5Q0
         JK7xbRW06YC02UQ54lvX4r0kfspn3GOmOG+aty/lG50Sd/c07Pyl9MsQhOZqyoh30Kkt
         KpmwJIWVoLebb158t2VMJ7uqTnLXsp3kKq2C841E1iD7CVokPTomiC/htnUx3Z8KXwwH
         /9F3wbxsL+u40U7en0pn58oZ/EyqXP7t1p37/uvLqwywAS6vfOoUS18rxMjSA9i5UOwV
         Fnjw==
X-Gm-Message-State: AOAM531DDS+YdgKLju8CqB64wJY+nAuvKHHkwqx6Hrpo1ZGec0VNnqKk
        3lt3iP01zPuavC+movc5hJtwgQ==
X-Google-Smtp-Source: ABdhPJzzDPH8l/po4iPtWattIFQsO/9iDQ1nPLb0cEovjjXcHx+04KVBeXUGoLOiX82JHqWWIEcvZQ==
X-Received: by 2002:a05:6512:2a9a:b0:477:caea:4ba with SMTP id dt26-20020a0565122a9a00b00477caea04bamr52651544lfb.575.1654245897543;
        Fri, 03 Jun 2022 01:44:57 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id b7-20020a0565120b8700b00478f8c9d402sm1474817lfv.20.2022.06.03.01.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 01:44:57 -0700 (PDT)
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
Subject: [PATCH v10 2/5] clk: qcom: gcc-sm8450: use new clk_regmap_phy_mux_ops for PCIe pipe clocks
Date:   Fri,  3 Jun 2022 11:44:51 +0300
Message-Id: <20220603084454.1861142-3-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220603084454.1861142-1-dmitry.baryshkov@linaro.org>
References: <20220603084454.1861142-1-dmitry.baryshkov@linaro.org>
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

