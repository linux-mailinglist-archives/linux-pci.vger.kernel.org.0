Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD5765002A2
	for <lists+linux-pci@lfdr.de>; Thu, 14 Apr 2022 01:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238951AbiDMXeM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Apr 2022 19:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237881AbiDMXeM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Apr 2022 19:34:12 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE2E625C6F
        for <linux-pci@vger.kernel.org>; Wed, 13 Apr 2022 16:31:48 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id o2so6171595lfu.13
        for <linux-pci@vger.kernel.org>; Wed, 13 Apr 2022 16:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ez6GRWNF3PnxFPCupS/2a9zu+yZIPLKLCs3ME+QE95o=;
        b=s3hQew9UUQmXSTPDsr1jEH1ZcXM19IvjavQTAtRoIdnffeLJsxsx38vea+eaulldyO
         9YFczq6w1uz3HfYTOJfSbsNufNsvw2Cvk6g+g8lSR5GOPvNdhliZJsaCPonuCzNxOIDG
         3qmkEMsIiU0ps0gcN9vAYTrlMZSJUEHC9fuX0y49wUMzLGJmqQy2WDJlQ9AfdqIjvF6V
         Uu7B1u8x8At/LiIZ/MpdYy0QM7dRJXR8kNdTMyW6ZhlfadYflzEDNrtMIAL0Ico+bBHS
         lOyR1XtM9YLSgkaEJYezmgP9e5Jmnfw4Er7hhxOZNkwBJxunV8rWT9Vq+etDx+ZXB/gw
         2hJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ez6GRWNF3PnxFPCupS/2a9zu+yZIPLKLCs3ME+QE95o=;
        b=TQdL0zQE7b9ZBb+EoLG2dXufc8qtO1Oc1FonW5bESLmOmNWAx/erT5Oj558LbVIPB5
         60sXhOPfvkk/jYZA7vEJSD1qicqj3t9EneeIvm1LN6/joiPyLKkXOc4JgNngPrtyzqCf
         upR0ikY3mpcPmxpIuPv/104A48c9LaH2/jbQHZ5i6MfOodGxpK2RDBEYNF6xG9jg7UoP
         VYdG83etVmKm8SUAkLFOXXrzINPWON2OKoG9GKhfUg7qZuJfqGYXTExav0KJU32bXg8r
         eXY8e3hrnvaEMscQIQGG5vyu3txzlwF46L+8Ci//45+49vycUMQKbD8yKJDT6/TMOrTB
         RV9g==
X-Gm-Message-State: AOAM530Dyq5WDPjYkDxTe1cRuMXhi+/BspBQmspYsN0eXOoSt8n0XRuU
        yQecnigL2OXGjuj+ueRa7y08Hg==
X-Google-Smtp-Source: ABdhPJwZHbjQJD5R0JILMYgyDeIOfjwG8TubDOixGnYz7IHN5yA+Qz5+fQsRBzwdI0qa/Vy4JbEA3Q==
X-Received: by 2002:a05:6512:3bc:b0:46d:1026:2f39 with SMTP id v28-20020a05651203bc00b0046d10262f39mr40147lfp.351.1649892707217;
        Wed, 13 Apr 2022 16:31:47 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id m5-20020a0565120a8500b0044a2963700fsm40982lfu.70.2022.04.13.16.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 16:31:46 -0700 (PDT)
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
Subject: [PATCH v3 1/6] clk: qcom: add two parent_map helpers
Date:   Thu, 14 Apr 2022 02:31:39 +0300
Message-Id: <20220413233144.275926-2-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220413233144.275926-1-dmitry.baryshkov@linaro.org>
References: <20220413233144.275926-1-dmitry.baryshkov@linaro.org>
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

Add two helpers that use parent_maps to convert between cfg and src
values.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/clk/qcom/common.c | 24 ++++++++++++++++++++++++
 drivers/clk/qcom/common.h |  5 +++++
 2 files changed, 29 insertions(+)

diff --git a/drivers/clk/qcom/common.c b/drivers/clk/qcom/common.c
index 75f09e6e057e..5f6230a67896 100644
--- a/drivers/clk/qcom/common.c
+++ b/drivers/clk/qcom/common.c
@@ -81,6 +81,30 @@ int qcom_find_cfg_index(struct clk_hw *hw, const struct parent_map *map, u8 cfg)
 }
 EXPORT_SYMBOL_GPL(qcom_find_cfg_index);
 
+int qcom_map_src_cfg(struct clk_hw *hw, const struct parent_map *map, u8 src)
+{
+	int i, num_parents = clk_hw_get_num_parents(hw);
+
+	for (i = 0; i < num_parents; i++)
+		if (src == map[i].src)
+			return map[i].cfg;
+
+	return -ENOENT;
+}
+EXPORT_SYMBOL_GPL(qcom_map_src_cfg);
+
+int qcom_map_cfg_src(struct clk_hw *hw, const struct parent_map *map, u8 cfg)
+{
+	int i, num_parents = clk_hw_get_num_parents(hw);
+
+	for (i = 0; i < num_parents; i++)
+		if (cfg == map[i].cfg)
+			return map[i].src;
+
+	return -ENOENT;
+}
+EXPORT_SYMBOL_GPL(qcom_map_cfg_src);
+
 struct regmap *
 qcom_cc_map(struct platform_device *pdev, const struct qcom_cc_desc *desc)
 {
diff --git a/drivers/clk/qcom/common.h b/drivers/clk/qcom/common.h
index 9c8f7b798d9f..fef31a432dcd 100644
--- a/drivers/clk/qcom/common.h
+++ b/drivers/clk/qcom/common.h
@@ -51,6 +51,11 @@ extern int qcom_find_src_index(struct clk_hw *hw, const struct parent_map *map,
 			       u8 src);
 extern int qcom_find_cfg_index(struct clk_hw *hw, const struct parent_map *map,
 			       u8 cfg);
+extern int qcom_map_src_cfg(struct clk_hw *hw, const struct parent_map *map,
+			    u8 src);
+
+extern int qcom_map_cfg_src(struct clk_hw *hw, const struct parent_map *map,
+			    u8 cfg);
 
 extern int qcom_cc_register_board_clk(struct device *dev, const char *path,
 				      const char *name, unsigned long rate);
-- 
2.35.1

