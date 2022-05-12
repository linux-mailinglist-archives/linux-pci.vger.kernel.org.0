Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60AD5525397
	for <lists+linux-pci@lfdr.de>; Thu, 12 May 2022 19:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357036AbiELR3S (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 May 2022 13:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357049AbiELR3P (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 May 2022 13:29:15 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62B526BC96
        for <linux-pci@vger.kernel.org>; Thu, 12 May 2022 10:29:13 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id bu29so10410002lfb.0
        for <linux-pci@vger.kernel.org>; Thu, 12 May 2022 10:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DN8fx1hfNVFS4Z0luAgkQ8WPp9oKgLsI13oOEr/g8qw=;
        b=CWHs/BhtnxlcnRUsurFNaZ9J2AG2Lq0FxWMAn3XzdPw6vjjmlNQFB+cYheT6yjrXSS
         lw0uvFxn+ulCNzSFi7nOmwM6iQc/s+HR6GbYLs2Izi44HBJFFh5jhcy+RnPuNxui8OHF
         DmtA9T7AAIAa0x81xgiXuZadOLx/du2K8TciRIuHJ4bjcG2nlTtT9kDLgPjOJtOjxGfD
         2Wo9iPqkzi0GcLuflGcbcrpoczovg+YxwFPdR139kdwd3tSZ36cWWCmHNGZfIwUp4GNI
         FW2m2UoCh+rDRI2Qsc/mqU80r8kLOVVd0vaJGlj3lfCCoQlQ0nt5xU84VHz2YHlqfmCY
         MvCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DN8fx1hfNVFS4Z0luAgkQ8WPp9oKgLsI13oOEr/g8qw=;
        b=hFkityGH7R4D9IHGEv0mYAVFVxHC9yUXdvLI1OjJq24pOFQX34MyP8CNOcA1JKJe2g
         8gpSC0wZVByYq2M4kAQ4W7Ir+qVSmy8KLBfYfYsAeOm/wn93NAV+AS5+soDtjziD1Isv
         PmzRP1FJL0OwFnZPa0DFndXvR+UY7/0L8TEtqBmWGtSc0bRRU1Xamb5mZkkQQKBihJwj
         QYEcxtI+coXD4Eb9L2Y/DFTe1EOiHc6G4+4uEqNY6VhWhMFKvqbDJIhTFXWhkzL9G19c
         HsS6smKoqcRMlolFMdNWll11+EGaKL5rcyQ+wvQXtKB7TeZwhpPSDMdMLkJvKj1/E+B7
         7/bw==
X-Gm-Message-State: AOAM533RiBzkcxvzWfD8hQgihfoBigl54CesAQuocM0Yt1R4NxCMf9e9
        Cp3R+J3tvfP+6P5T+rH8/sh0Yg==
X-Google-Smtp-Source: ABdhPJy9IlxdUuvCdiy9297ttn1SE6fTbIU6lja3kelgDKY4SwyMfZyavHa3jj3H/MbVIvHrz2deaA==
X-Received: by 2002:a05:6512:b96:b0:473:a0d7:d203 with SMTP id b22-20020a0565120b9600b00473a0d7d203mr604998lfv.179.1652376552056;
        Thu, 12 May 2022 10:29:12 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id y10-20020a2e95ca000000b0024f3d1dae9asm11520ljh.34.2022.05.12.10.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 10:29:11 -0700 (PDT)
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
Cc:     Prasad Malisetty <pmaliset@codeaurora.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v5 2/5] clk: qcom: regmap: add PHY clock source implementation
Date:   Thu, 12 May 2022 20:29:06 +0300
Message-Id: <20220512172909.2436302-3-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220512172909.2436302-1-dmitry.baryshkov@linaro.org>
References: <20220512172909.2436302-1-dmitry.baryshkov@linaro.org>
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
the new clk_regmap_pipe_src type, which implements such multiplexers
as a simple gate clocks.

This is possible since each of these multiplexers has just two clock
sources: working (pipe) and safe/park (bi_tcxo) clock sources. If the
clock is running off the external pipe source, report it as enabled and
report it as disabled otherwise.

This way the PHY will disable the pipe clock before turning off the
GDSC, which in turn would lead to disabling corresponding pipe_clk_src
(and thus parked to a safe clock srouce). And vice versa, after enabling
the GDSC the PHY will enable the pipe clock, which would cause
pipe_clk_src to be switched from a safe source to the working one.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/clk/qcom/Makefile              |  1 +
 drivers/clk/qcom/clk-regmap-pipe-src.c | 62 ++++++++++++++++++++++++++
 drivers/clk/qcom/clk-regmap-pipe-src.h | 24 ++++++++++
 3 files changed, 87 insertions(+)
 create mode 100644 drivers/clk/qcom/clk-regmap-pipe-src.c
 create mode 100644 drivers/clk/qcom/clk-regmap-pipe-src.h

diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index 671cf5821af1..03b945535e49 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -11,6 +11,7 @@ clk-qcom-y += clk-branch.o
 clk-qcom-y += clk-regmap-divider.o
 clk-qcom-y += clk-regmap-mux.o
 clk-qcom-y += clk-regmap-mux-div.o
+clk-qcom-y += clk-regmap-pipe-src.o
 clk-qcom-$(CONFIG_KRAIT_CLOCKS) += clk-krait.o
 clk-qcom-y += clk-hfpll.o
 clk-qcom-y += reset.o
diff --git a/drivers/clk/qcom/clk-regmap-pipe-src.c b/drivers/clk/qcom/clk-regmap-pipe-src.c
new file mode 100644
index 000000000000..02047987ab5f
--- /dev/null
+++ b/drivers/clk/qcom/clk-regmap-pipe-src.c
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022, Linaro Ltd.
+ */
+
+#include <linux/kernel.h>
+#include <linux/bitops.h>
+#include <linux/regmap.h>
+#include <linux/export.h>
+
+#include "clk-regmap-pipe-src.h"
+
+static inline struct clk_regmap_pipe_src *to_clk_regmap_pipe_src(struct clk_hw *hw)
+{
+	return container_of(to_clk_regmap(hw), struct clk_regmap_pipe_src, clkr);
+}
+
+static int pipe_src_is_enabled(struct clk_hw *hw)
+{
+	struct clk_regmap_pipe_src *pipe = to_clk_regmap_pipe_src(hw);
+	struct clk_regmap *clkr = to_clk_regmap(hw);
+	unsigned int mask = GENMASK(pipe->width + pipe->shift - 1, pipe->shift);
+	unsigned int val;
+
+	regmap_read(clkr->regmap, pipe->reg, &val);
+	val = (val & mask) >> pipe->shift;
+
+	WARN_ON(unlikely(val != pipe->working_val && val != pipe->park_val));
+
+	return val == pipe->working_val;
+}
+
+static int pipe_src_enable(struct clk_hw *hw)
+{
+	struct clk_regmap_pipe_src *pipe = to_clk_regmap_pipe_src(hw);
+	struct clk_regmap *clkr = to_clk_regmap(hw);
+	unsigned int mask = GENMASK(pipe->width + pipe->shift - 1, pipe->shift);
+	unsigned int val;
+
+	val = pipe->working_val << pipe->shift;
+
+	return regmap_update_bits(clkr->regmap, pipe->reg, mask, val);
+}
+
+static void pipe_src_disable(struct clk_hw *hw)
+{
+	struct clk_regmap_pipe_src *pipe = to_clk_regmap_pipe_src(hw);
+	struct clk_regmap *clkr = to_clk_regmap(hw);
+	unsigned int mask = GENMASK(pipe->width + pipe->shift - 1, pipe->shift);
+	unsigned int val;
+
+	val = pipe->park_val << pipe->shift;
+
+	regmap_update_bits(clkr->regmap, pipe->reg, mask, val);
+}
+
+const struct clk_ops clk_regmap_pipe_src_ops = {
+	.enable = pipe_src_enable,
+	.disable = pipe_src_disable,
+	.is_enabled = pipe_src_is_enabled,
+};
+EXPORT_SYMBOL_GPL(clk_regmap_pipe_src_ops);
diff --git a/drivers/clk/qcom/clk-regmap-pipe-src.h b/drivers/clk/qcom/clk-regmap-pipe-src.h
new file mode 100644
index 000000000000..3aa4a9f402cd
--- /dev/null
+++ b/drivers/clk/qcom/clk-regmap-pipe-src.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2022, Linaro Ltd.
+ * Author: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
+ */
+
+#ifndef __QCOM_CLK_REGMAP_PIPE_SRC_H__
+#define __QCOM_CLK_REGMAP_PIPE_SRC_H__
+
+#include <linux/clk-provider.h>
+#include "clk-regmap.h"
+
+struct clk_regmap_pipe_src {
+	u32			reg;
+	u32			shift;
+	u32			width;
+	u32			working_val;
+	u32			park_val;
+	struct clk_regmap	clkr;
+};
+
+extern const struct clk_ops clk_regmap_pipe_src_ops;
+
+#endif
-- 
2.35.1

