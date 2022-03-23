Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 792BB4E4E9A
	for <lists+linux-pci@lfdr.de>; Wed, 23 Mar 2022 09:50:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242971AbiCWIvy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Mar 2022 04:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242974AbiCWIvs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Mar 2022 04:51:48 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 127E275622
        for <linux-pci@vger.kernel.org>; Wed, 23 Mar 2022 01:50:16 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id s25so893791lji.5
        for <linux-pci@vger.kernel.org>; Wed, 23 Mar 2022 01:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7AIHmdlMdzmULilg6qWLqJ5/9CAU4VNtUbygox8IGUI=;
        b=XNyUyEwMUh62jEe0Pn/MWDdtye+jGSz3CouiHuVJzS+nEOLdXWh3b25XaMuknEpzSz
         72k8mvxHUOD4U2i8CoQOGrMU4FshojddsEDRe6ggJ/2HmumYhon3FKIcOhy//Fk7IIq5
         B5u3tsukxVdjJ19SS2zRP6P8AcVGq9hhZ/RIN6ioPnVKLM9fIX/LXNeix8/WZVcSzZxV
         Ep3rEUi2TaxO7Zez3fxRXLZ8dNdAts5OaXLS8ich5Slp4e1MywrU7Ff3FOeHntCWDJtq
         RXewW5//WDPWm0hfnht7gP/H564oOP2rfc0w6tFtjpfH95QeSYWATkmbyPP8v5Kqg/u8
         Ohbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7AIHmdlMdzmULilg6qWLqJ5/9CAU4VNtUbygox8IGUI=;
        b=3FVVO0h4Dvam4JmKktLGIh5J6B8RAiNRprCNqcDJpUBRhsVPbIop49KmvQgwWWGfaL
         BDg/qpJfKNy8da8aA3X8WlvB36M6KdoxQrX1l5qr63qYMfL0hnMlQCyHDXUshfwDZNp5
         eHjeZiGUghkrgopEbih1P7ZnuhMmlk+kTi4DiD1tp8Y0OZRNXmuw7DaEO9v+1FJFgJAN
         dlnDbKDa1t9pPvXkyeKD5mZN0XNDogEYWbp9a3WRwExF0ng0PhypbZygMz9QsnEVa+pb
         ZJEgDO3igYtzl8dbzzrual8pewLCmQO0WH1f7cEhVwTZ/bxFmcCTFlL+5TFk96MMiDxO
         rTFw==
X-Gm-Message-State: AOAM531Z076i7K5d5Fn8EFaLG/hvfeU22MjRhi1gLoUWIEGcPc6BYxvP
        CkHv+Zp60bRMrWhNG9UwPAqMEA==
X-Google-Smtp-Source: ABdhPJxn7ck6/VN+5W2bmvjXzEoUox1WI0toEkIsA/0PcbdXUp41W6ysCi31A3OmtH8w+9/mk1ie9Q==
X-Received: by 2002:a2e:a266:0:b0:249:8463:7d71 with SMTP id k6-20020a2ea266000000b0024984637d71mr10118413ljm.107.1648025414338;
        Wed, 23 Mar 2022 01:50:14 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id c40-20020a05651223a800b0044a1edf823dsm1376140lfv.150.2022.03.23.01.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 01:50:13 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <tdas@codeaurora.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Prasad Malisetty <quic_pmaliset@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH v1 3/5] clk: qcom: gcc-sc7280: use new clk_regmap_mux_safe_ops for PCIe pipe clocks
Date:   Wed, 23 Mar 2022 11:50:08 +0300
Message-Id: <20220323085010.1753493-4-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220323085010.1753493-1-dmitry.baryshkov@linaro.org>
References: <20220323085010.1753493-1-dmitry.baryshkov@linaro.org>
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

Use newly defined clk_regmap_mux_safe_ops for PCIe pipe clocks to let
the clock framework automatically park the clock when the clock is
switched off and restore the parent when the clock is switched on.

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/clk/qcom/gcc-sc7280.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/qcom/gcc-sc7280.c b/drivers/clk/qcom/gcc-sc7280.c
index 423627d49719..dafbbc8f3bf4 100644
--- a/drivers/clk/qcom/gcc-sc7280.c
+++ b/drivers/clk/qcom/gcc-sc7280.c
@@ -373,13 +373,14 @@ static struct clk_regmap_mux gcc_pcie_0_pipe_clk_src = {
 	.reg = 0x6b054,
 	.shift = 0,
 	.width = 2,
+	.safe_src_parent = P_BI_TCXO,
 	.parent_map = gcc_parent_map_6,
 	.clkr = {
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_pcie_0_pipe_clk_src",
 			.parent_data = gcc_parent_data_6,
 			.num_parents = ARRAY_SIZE(gcc_parent_data_6),
-			.ops = &clk_regmap_mux_closest_ops,
+			.ops = &clk_regmap_mux_safe_ops,
 		},
 	},
 };
@@ -388,13 +389,14 @@ static struct clk_regmap_mux gcc_pcie_1_pipe_clk_src = {
 	.reg = 0x8d054,
 	.shift = 0,
 	.width = 2,
+	.safe_src_parent = P_BI_TCXO,
 	.parent_map = gcc_parent_map_7,
 	.clkr = {
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_pcie_1_pipe_clk_src",
 			.parent_data = gcc_parent_data_7,
 			.num_parents = ARRAY_SIZE(gcc_parent_data_7),
-			.ops = &clk_regmap_mux_closest_ops,
+			.ops = &clk_regmap_mux_safe_ops,
 		},
 	},
 };
-- 
2.35.1

