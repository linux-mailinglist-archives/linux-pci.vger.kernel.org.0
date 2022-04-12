Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 605CE4FE8CB
	for <lists+linux-pci@lfdr.de>; Tue, 12 Apr 2022 21:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358894AbiDLTlP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Apr 2022 15:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352835AbiDLTlG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Apr 2022 15:41:06 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36AD4BB82
        for <linux-pci@vger.kernel.org>; Tue, 12 Apr 2022 12:38:46 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 15so10559553ljw.8
        for <linux-pci@vger.kernel.org>; Tue, 12 Apr 2022 12:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7AIHmdlMdzmULilg6qWLqJ5/9CAU4VNtUbygox8IGUI=;
        b=gf2DWvtp8X96llUq5WWFMCuIbQlTw3x7+rphw1OZVo+UmAXIJEFZnz57IzF2hutZHE
         fTYmKrUC+qAg2td0o3zEgJ7wplnWWnLBgQOcGRGJoVeCARJJS9KowyK0U+BQKtYYMLKZ
         ZzsnOmrFUB7Pz+4zlmMtyfbi/9dTA6kIRDpwSSArUckRDnm7dAQ9bOcPXPuFexfU1ejm
         0R7z6ek+9J1g/9q6JwxCTzwYllRLd7BHPuauXAQ7zruK06qfkHKpHusLH2ThN854jjU7
         GaS353rMTOysLw98SUZM7BD40AfBZbzQzltEvHbcOr35MxAoQdMvBpIoXVUjmdNZ6GmN
         gM8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7AIHmdlMdzmULilg6qWLqJ5/9CAU4VNtUbygox8IGUI=;
        b=S1SI4C/NlV4mJNZmW5Qy2WqPRvdl81D0TtFCoEDSpo27kbKFzyQth64TxY9MZT+dyu
         DOqPkdM431SS1zyqwVzZLbnQSf8BhW/zhaEfzk60R2JbisAnNmIOKYkvAsZAkxz5HKyf
         BRyYrYMWwKAk1NMTvzavIC7noHkxPzBsCvYDX3N7BZajTm8UVjEUj0U4I76TSUCAXqo7
         wqgOshYnA8F27qEbH27ljOQBHVEkZJb4PjjxIO8/SNCWHGLEJinScMTM8JSIqYfEUXZf
         NC+YpgMz825zBPLdpCYGuHXnNk2I1UYPrE6EeDsPBM9Z3XVYgPvauBigu4/GZTYjyWa7
         /2MQ==
X-Gm-Message-State: AOAM530HyhyPafELalDMSGvH7uFrOvnTrKIKI0vKzJG+RIJPZceITXKa
        ptRlyycwyypIeG8TSPYuz4trcQ==
X-Google-Smtp-Source: ABdhPJy5Yqd0jHrINXB4AdA3/oP7bWaZtIGhD+LStxlMzh6aVIpEIfjtVjiCI+2GKDMrUNj05+w4vg==
X-Received: by 2002:a2e:934d:0:b0:24b:41cf:fb50 with SMTP id m13-20020a2e934d000000b0024b41cffb50mr18378989ljh.336.1649792324792;
        Tue, 12 Apr 2022 12:38:44 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id m4-20020a0565120a8400b00450abeb42b3sm2731641lfu.235.2022.04.12.12.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 12:38:43 -0700 (PDT)
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
Subject: [PATCH v2 3/5] clk: qcom: gcc-sc7280: use new clk_regmap_mux_safe_ops for PCIe pipe clocks
Date:   Tue, 12 Apr 2022 22:38:37 +0300
Message-Id: <20220412193839.2545814-4-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220412193839.2545814-1-dmitry.baryshkov@linaro.org>
References: <20220412193839.2545814-1-dmitry.baryshkov@linaro.org>
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

