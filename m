Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91FA74E4EAA
	for <lists+linux-pci@lfdr.de>; Wed, 23 Mar 2022 09:50:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242939AbiCWIvu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Mar 2022 04:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242961AbiCWIvs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Mar 2022 04:51:48 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 568187561D
        for <linux-pci@vger.kernel.org>; Wed, 23 Mar 2022 01:50:15 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id s25so893749lji.5
        for <linux-pci@vger.kernel.org>; Wed, 23 Mar 2022 01:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3m7sD5DReLGuXAEizIRitWnlXHp9Kn3L0qq2hxmokpc=;
        b=gv9gcPlHQ35G9R6MWJXTwf0cGkoBwsLehTQsndz59t01evyNDJF5UrpJT2BcNu8OyX
         I+OooxIhJSXZhbAU84NvqSuzUuGD37pZQNSH30RT3xBfDaXEaXkBeJhB7+JmiHen2EAA
         3X1b1xS3jj2yn4cT7rDWvFXpWDudayGtu/6Fey9G8Nk81/151t4hD8n8lGRSeuZkSTdS
         b20JVBL+/RpxZQRpTl1V62CnosEGj2NQqidLJR4Ll/h5/5bGuNPq8NHckgocdSPhqhu3
         6DK3Mxbxlu5FHAI4pCEiSFyzHw5s3AXRmyH22rw7jAQTXg23FytFK7Yg/Gw72TXMpvUf
         ZLEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3m7sD5DReLGuXAEizIRitWnlXHp9Kn3L0qq2hxmokpc=;
        b=yZwXQYgUbd2C7HHlkhH5v2B1WMIwXvfeUjjlBDgm+rKZGduhXDeX6co8A1H8FUpiOn
         eLc1HZ+x71vgfsorkhlmianYpWbJMQURrRVzSUHoEzWWqGxdylt3M816MS2c4fYS6Usj
         6pi/AKcvUsmi91rsWRYsCzB8GZrymAbkEsJIvdnPTB+dCfGJiGHbvDHlB+ZUVod6TjC1
         uv/NxSdloc+kGAIk2oiX4fxZx39hBpGcBFDl/IRVDMkwdQMNNzOyZveFaQyjAsFyW5in
         UzlxLVN3aNH10DKs6e9oHIiduwnVPB/tG9dqcQXFFmSNCB8Zo+DrGSHbFgmBndi9FifA
         1IRA==
X-Gm-Message-State: AOAM530SRuhflfPrnVT8j0eYBsnZZStTAbKnSpkrYwVrfZJCn0+eH+Pw
        EtK7MCUA+bNUIHzVuuaIJNeK1Q==
X-Google-Smtp-Source: ABdhPJy1vlu6yxy06uWNWZ48yM4MosclnzEQBTVrPPCqlL7MPEExEmPACb/jv15/v0LmctoyviJRsA==
X-Received: by 2002:a2e:87c4:0:b0:249:2cdf:da53 with SMTP id v4-20020a2e87c4000000b002492cdfda53mr23163574ljj.161.1648025413622;
        Wed, 23 Mar 2022 01:50:13 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id c40-20020a05651223a800b0044a1edf823dsm1376140lfv.150.2022.03.23.01.50.12
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
Subject: [PATCH v1 2/5] clk: qcom: gcc-sm8450: use new clk_regmap_mux_safe_ops for PCIe pipe clocks
Date:   Wed, 23 Mar 2022 11:50:07 +0300
Message-Id: <20220323085010.1753493-3-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220323085010.1753493-1-dmitry.baryshkov@linaro.org>
References: <20220323085010.1753493-1-dmitry.baryshkov@linaro.org>
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

Use newly defined clk_regmap_mux_safe_ops for PCIe pipe clocks to let
the clock framework automatically park the clock when the clock is
switched off and restore the parent when the clock is switched on.

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/clk/qcom/gcc-sm8450.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/qcom/gcc-sm8450.c b/drivers/clk/qcom/gcc-sm8450.c
index 593a195467ff..fb6decd3df49 100644
--- a/drivers/clk/qcom/gcc-sm8450.c
+++ b/drivers/clk/qcom/gcc-sm8450.c
@@ -243,13 +243,14 @@ static struct clk_regmap_mux gcc_pcie_0_pipe_clk_src = {
 	.reg = 0x7b060,
 	.shift = 0,
 	.width = 2,
+	.safe_src_parent = P_BI_TCXO,
 	.parent_map = gcc_parent_map_4,
 	.clkr = {
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_pcie_0_pipe_clk_src",
 			.parent_data = gcc_parent_data_4,
 			.num_parents = ARRAY_SIZE(gcc_parent_data_4),
-			.ops = &clk_regmap_mux_closest_ops,
+			.ops = &clk_regmap_mux_safe_ops,
 		},
 	},
 };
@@ -273,13 +274,14 @@ static struct clk_regmap_mux gcc_pcie_1_pipe_clk_src = {
 	.reg = 0x9d064,
 	.shift = 0,
 	.width = 2,
+	.safe_src_parent = P_BI_TCXO,
 	.parent_map = gcc_parent_map_6,
 	.clkr = {
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_pcie_1_pipe_clk_src",
 			.parent_data = gcc_parent_data_6,
 			.num_parents = ARRAY_SIZE(gcc_parent_data_6),
-			.ops = &clk_regmap_mux_closest_ops,
+			.ops = &clk_regmap_mux_safe_ops,
 		},
 	},
 };
-- 
2.35.1

