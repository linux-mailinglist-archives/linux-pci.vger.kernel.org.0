Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A51FB52E245
	for <lists+linux-pci@lfdr.de>; Fri, 20 May 2022 04:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344625AbiETB6x (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 May 2022 21:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344640AbiETB6x (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 May 2022 21:58:53 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D991EEBE88
        for <linux-pci@vger.kernel.org>; Thu, 19 May 2022 18:58:51 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id o22so8139062ljp.8
        for <linux-pci@vger.kernel.org>; Thu, 19 May 2022 18:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E5Gh1ILAKMW/krfK9XLvKTPNo78YRm/rpFUA2qFfucc=;
        b=PrRAnngSwlX6D6mqDDsgAgMzBeSfhpB6DXkKUSuHT+EB4gSloIlqbwdK39q1cMQJN4
         vaS2NfxKLT+MdfYIrBdEDD94tFYgKaw4jO+tuHS8kYVKjmvIPTqGfMNHiikA/JwSO5eW
         yqvlDPbNkKdF/zdhvgcXTpkrl6VNiEk0xETM6FKSSpZHpnb/YmLuRiseIaAozTG5oMmU
         Q0/bcwDSeTsTzflcb9CgvLR24fInQenj8P4UCQY1sdAK+q9pAGD3/ViyKC0fMB0df9ht
         kcSVqz6ctOnslviMN0WPEsuBizFgDVgzuplT6T6upGB6Y1Eqghxu6TuvrThQZz4Pgsz9
         Ingg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E5Gh1ILAKMW/krfK9XLvKTPNo78YRm/rpFUA2qFfucc=;
        b=kGVhzZhSwRpdZseNRokGr0KQm0FUWG+QX1JNY9xOgMnDm4FwRfqIp/XpWZZNV2JY+2
         poF0UK4xBxfEbHIqE84F5NDJLVyU0PUAXcVVqKJizVh4BvVhxuEX+QYfxkGcBJbfPJiI
         MEmCCCvEN2WcQCsHnRV9ah6k9sCvrm74ClEFy7+2FY3q8npgr9Q8CHx8I1bbcbEgFI7W
         2bD68Xq7EPyOjStHd6PsAjprOvhJowc7aUGdFGywbXsEIMAsh+xwqgRtUZcMWmWXROgE
         YrL9oEKlLG+dlCsYVVBWqubew6t5JN/8CrJ8ussHjyzZsVj2t+2xwHq7uLAIQgI7AGhv
         16UA==
X-Gm-Message-State: AOAM531bZu/Aet68Ia8PbH2tSyIhkDVWZpx8lG2oAI9KlleK7oa922Tx
        eOr6MQTbapP3ZkwqgCY/YNF7jw==
X-Google-Smtp-Source: ABdhPJzVHp6BUQNcGumdiUbW1R5UPYGdWR6Ct95wy4vMM9zqwfrYwlRw2NRDATNJl7n6qQIykkPNBg==
X-Received: by 2002:a2e:944a:0:b0:24f:10bd:b7e8 with SMTP id o10-20020a2e944a000000b0024f10bdb7e8mr4373363ljh.238.1653011930212;
        Thu, 19 May 2022 18:58:50 -0700 (PDT)
Received: from eriador.lan ([2001:470:dd84:abc0::8a5])
        by smtp.gmail.com with ESMTPSA id u28-20020ac24c3c000000b0047255d21192sm467370lfq.193.2022.05.19.18.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 18:58:49 -0700 (PDT)
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
Subject: [PATCH v7 2/6] clk: qcom: regmap: add PHY clock source implementation
Date:   Fri, 20 May 2022 04:58:40 +0300
Message-Id: <20220520015844.1190511-3-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220520015844.1190511-1-dmitry.baryshkov@linaro.org>
References: <20220520015844.1190511-1-dmitry.baryshkov@linaro.org>
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

On recent Qualcomm platforms the QMP PIPE clocks feed into a set of
muxes which must be parked to the "safe" source (bi_tcxo) when
corresponding GDSC is turned off and on again. Currently this is
handcoded in the PCIe driver by reparenting the gcc_pipe_N_clk_src
clock. However the same code sequence should be applied in the
pcie-qcom endpoint, USB3 and UFS drivers.

Rather than copying this sequence over and over again, follow the
example of clk_rcg2_shared_ops and implement this parking in the
enable() and disable() clock operations. Supplement the regmap-mux with
the new clk_regmap_phy_mux type, which implements such multiplexers
as a simple gate clocks.

This is possible since each of these multiplexers has just two clock
sources: one coming from the PHY and a reference (XO) one.  If the clock
is running off the from-PHY source, report it as enabled. Report it as
disabled otherwise (if it uses reference source).

This way the PHY will disable the pipe clock before turning off the
GDSC, which in turn would lead to disabling corresponding pipe_clk_src
(and thus it being parked to a safe, reference clock source). And vice
versa, after enabling the GDSC the PHY will enable the pipe clock, which
would cause pipe_clk_src to be switched from a safe source to the
working one.

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
Tested-by: Johan Hovold <johan+linaro@kernel.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/clk/qcom/Makefile             |  1 +
 drivers/clk/qcom/clk-regmap-phy-mux.c | 53 +++++++++++++++++++++++++++
 drivers/clk/qcom/clk-regmap.h         | 17 +++++++++
 3 files changed, 71 insertions(+)
 create mode 100644 drivers/clk/qcom/clk-regmap-phy-mux.c

diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index dff6aeb980e6..6d242f46bd1d 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -11,6 +11,7 @@ clk-qcom-y += clk-branch.o
 clk-qcom-y += clk-regmap-divider.o
 clk-qcom-y += clk-regmap-mux.o
 clk-qcom-y += clk-regmap-mux-div.o
+clk-qcom-y += clk-regmap-phy-mux.o
 clk-qcom-$(CONFIG_KRAIT_CLOCKS) += clk-krait.o
 clk-qcom-y += clk-hfpll.o
 clk-qcom-y += reset.o
diff --git a/drivers/clk/qcom/clk-regmap-phy-mux.c b/drivers/clk/qcom/clk-regmap-phy-mux.c
new file mode 100644
index 000000000000..dc96714a6175
--- /dev/null
+++ b/drivers/clk/qcom/clk-regmap-phy-mux.c
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022, Linaro Ltd.
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/bitops.h>
+#include <linux/regmap.h>
+#include <linux/export.h>
+
+#include "clk-regmap.h"
+
+#define PHY_MUX_MASK		GENMASK(1, 0)
+#define PHY_MUX_PHY_SRC		0
+#define PHY_MUX_REF_SRC		2
+
+static int phy_mux_is_enabled(struct clk_hw *hw)
+{
+	struct clk_regmap *clkr = to_clk_regmap(hw);
+	unsigned int val;
+
+	regmap_read(clkr->regmap, clkr->enable_reg, &val);
+	val = FIELD_GET(PHY_MUX_MASK, val);
+
+	WARN_ON(val != PHY_MUX_PHY_SRC && val != PHY_MUX_REF_SRC);
+
+	return val == PHY_MUX_PHY_SRC;
+}
+
+static int phy_mux_enable(struct clk_hw *hw)
+{
+	struct clk_regmap *clkr = to_clk_regmap(hw);
+
+	return regmap_update_bits(clkr->regmap, clkr->enable_reg,
+				  PHY_MUX_MASK,
+				  FIELD_PREP(PHY_MUX_MASK, PHY_MUX_PHY_SRC));
+}
+
+static void phy_mux_disable(struct clk_hw *hw)
+{
+	struct clk_regmap *clkr = to_clk_regmap(hw);
+
+	regmap_update_bits(clkr->regmap, clkr->enable_reg,
+			   PHY_MUX_MASK,
+			   FIELD_PREP(PHY_MUX_MASK, PHY_MUX_REF_SRC));
+}
+
+const struct clk_ops clk_regmap_phy_mux_ops = {
+	.enable = phy_mux_enable,
+	.disable = phy_mux_disable,
+	.is_enabled = phy_mux_is_enabled,
+};
+EXPORT_SYMBOL_GPL(clk_regmap_phy_mux_ops);
diff --git a/drivers/clk/qcom/clk-regmap.h b/drivers/clk/qcom/clk-regmap.h
index 14ec659a3a77..a58cd1d790fe 100644
--- a/drivers/clk/qcom/clk-regmap.h
+++ b/drivers/clk/qcom/clk-regmap.h
@@ -35,4 +35,21 @@ int clk_enable_regmap(struct clk_hw *hw);
 void clk_disable_regmap(struct clk_hw *hw);
 int devm_clk_register_regmap(struct device *dev, struct clk_regmap *rclk);
 
+/*
+ * A clock implementation for PHY pipe and symbols clock muxes.
+ *
+ * If the clock is running off the from-PHY source, report it as enabled.
+ * Report it as disabled otherwise (if it uses reference source).
+ *
+ * This way the PHY will disable the pipe clock before turning off the GDSC,
+ * which in turn would lead to disabling corresponding pipe_clk_src (and thus
+ * it being parked to a safe, reference clock source). And vice versa, after
+ * enabling the GDSC the PHY will enable the pipe clock, which would cause
+ * pipe_clk_src to be switched from a safe source to the working one.
+ *
+ * For some platforms this should be used for the UFS symbol_clk_src clocks
+ * too.
+ */
+extern const struct clk_ops clk_regmap_phy_mux_ops;
+
 #endif
-- 
2.35.1

