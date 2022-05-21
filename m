Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 962D552F713
	for <lists+linux-pci@lfdr.de>; Sat, 21 May 2022 02:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348108AbiEUAxy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 May 2022 20:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354258AbiEUAxx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 May 2022 20:53:53 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 625341AEC74
        for <linux-pci@vger.kernel.org>; Fri, 20 May 2022 17:53:52 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id br17so4630735lfb.2
        for <linux-pci@vger.kernel.org>; Fri, 20 May 2022 17:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2uivrgmJUAM211xuglcveu2q7wPnyfsAfIjgsQu02+M=;
        b=jBxq1FVyXlncQ83UZr1Q0Wf3yGyUK4h0JrcyJVkJNw0Zyy1IhRim8gO+xMX6YnGdhX
         2EheDy5M/yM7YUQGRHRAUWaUpPnPS9xqZkHAFsN3aWPkoPc+AqYh2FZJ4pAJeZ+L9lyr
         6+i0iKhE1U1yZfk5obJ94F3M/93Os8kl1fRmvXPXr5/g+IfB3/rL1yXAva0EEnyT4RUT
         CCYPi40jlIQEY5/lQGi84PYNtu61t4hsDzZQVo1zoY7cmi2/3IBpHRmR0nFJrq6Sah6b
         GAtiD2Pj3fSXCL5qF/QV7QOyAYzvVVPEDXWEM2ts/nI7vvW8Sk8jHtI6d8ni4I2rYgHR
         Pe3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2uivrgmJUAM211xuglcveu2q7wPnyfsAfIjgsQu02+M=;
        b=FPZO8kZL8/0teMb3dK97z2vYfmzPpeZB8Aqr6x+u1z9dXa9W63EVJ/BkcjoXVxETbX
         S1kmxTu7UZ/Ggj+bUyd02/pKeRssnlgXVKlqbPjCE3j2tpGar+VkT2dOrdgtREF9Ab/K
         Bz1u8ucGOk8JkG823zSNlNfFxySx8eagvtf15ic0RBRsP3WlClx1Z9ZlfqLDEHO4KLI/
         ZbksQ3kFQoRhuDrdIxssouYB1ALsYL1XxyR959RTL8LT3aM/yFjjGXJLaSikrVJKHHRn
         v760APwT4ItTiVX4xtF5M9UdiHrOifXjlbR6ypaaKg6uZjw//b6Qqknewqyag1B30p1q
         An9w==
X-Gm-Message-State: AOAM530s4+G8pk9UWkDccCl+3kJIbmbjEtLKzZ0s9PyWSsCn9ibV5sHr
        zwU1dFkQwgeVyDbiOJtezeP62g==
X-Google-Smtp-Source: ABdhPJyPJ+GS6D2f4TxyaBYfEDzLbHqWhVLrlipJNaFEwO8/Z8qzqJIvdNZHHVQqK5BAvJAKJpabIg==
X-Received: by 2002:a19:5043:0:b0:477:cc18:840a with SMTP id z3-20020a195043000000b00477cc18840amr6649401lfj.437.1653094430782;
        Fri, 20 May 2022 17:53:50 -0700 (PDT)
Received: from eriador.lan ([2001:470:dd84:abc0::8a5])
        by smtp.gmail.com with ESMTPSA id u14-20020a056512094e00b0047255d21187sm844559lft.182.2022.05.20.17.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 17:53:49 -0700 (PDT)
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
Subject: [PATCH v7 2/8] Revert "clk: qcom: gcc-sc7280: use new clk_regmap_mux_safe_ops for PCIe pipe clocks"
Date:   Sat, 21 May 2022 03:53:37 +0300
Message-Id: <20220521005343.1429642-3-dmitry.baryshkov@linaro.org>
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

Johan Hovold has pointed out that there are several deficiencies and a
race condition in the regmap_mux_safe ops that were merged. Revert the
commit that switches gcc-sc7280 driver to use regmap_mux_safe.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/clk/qcom/gcc-sc7280.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/qcom/gcc-sc7280.c b/drivers/clk/qcom/gcc-sc7280.c
index dafbbc8f3bf4..423627d49719 100644
--- a/drivers/clk/qcom/gcc-sc7280.c
+++ b/drivers/clk/qcom/gcc-sc7280.c
@@ -373,14 +373,13 @@ static struct clk_regmap_mux gcc_pcie_0_pipe_clk_src = {
 	.reg = 0x6b054,
 	.shift = 0,
 	.width = 2,
-	.safe_src_parent = P_BI_TCXO,
 	.parent_map = gcc_parent_map_6,
 	.clkr = {
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_pcie_0_pipe_clk_src",
 			.parent_data = gcc_parent_data_6,
 			.num_parents = ARRAY_SIZE(gcc_parent_data_6),
-			.ops = &clk_regmap_mux_safe_ops,
+			.ops = &clk_regmap_mux_closest_ops,
 		},
 	},
 };
@@ -389,14 +388,13 @@ static struct clk_regmap_mux gcc_pcie_1_pipe_clk_src = {
 	.reg = 0x8d054,
 	.shift = 0,
 	.width = 2,
-	.safe_src_parent = P_BI_TCXO,
 	.parent_map = gcc_parent_map_7,
 	.clkr = {
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_pcie_1_pipe_clk_src",
 			.parent_data = gcc_parent_data_7,
 			.num_parents = ARRAY_SIZE(gcc_parent_data_7),
-			.ops = &clk_regmap_mux_safe_ops,
+			.ops = &clk_regmap_mux_closest_ops,
 		},
 	},
 };
-- 
2.35.1

