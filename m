Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC87516759
	for <lists+linux-pci@lfdr.de>; Sun,  1 May 2022 21:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352792AbiEATZW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 1 May 2022 15:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351162AbiEATZV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 1 May 2022 15:25:21 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96678B1F5
        for <linux-pci@vger.kernel.org>; Sun,  1 May 2022 12:21:54 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id c15so16250929ljr.9
        for <linux-pci@vger.kernel.org>; Sun, 01 May 2022 12:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VEliCrw6ydx3s0cVhlHZTikGpa+NeXcs92Ko4fOLqTU=;
        b=HSs6Gpt/Dc/6PHtD7S/gtefVgvhiKfKtBntCTSKEVi9phbrISok9JHgEvFJfOMvMH6
         uOap/t4geMh75TWse7f8QlcMndiYWpSEU7zsXpelZ80EpLvS9ZlmaDbLpzykSkH+c3/+
         P7Dm+FpnhNBFgjRBIOdaZm+eRFX9qrWGF47NI3iiLraH9dyJhmYgu8Y6/KMtrJsOZFF0
         cTtzREgUkNMJJRIbugUSV7iBRiZzwcD7G5qBvcZqQ/XwV/tXvDYI8Xuwt+O9Tc7CMKTX
         CSok+KCuNTIndHq2PdxzzWBZWht3rRopzimOV0wCixeSd784APG5t2y22oZCpdyXpxXC
         SXYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VEliCrw6ydx3s0cVhlHZTikGpa+NeXcs92Ko4fOLqTU=;
        b=zQCm4KJ9Nqw87Zpz0zDIvHTMiAC+7vHdnm4HtvxKrBW+6zZkI7UNA0EFMZQQCQFxD2
         TehMYt1N/SerHb6nlmQx5Ih9WsnqE1GtNrIrOssbdzXIqEhI8gUISwkmFPfz+xw2uAq2
         iwVtkfqQ893556c6v6EmPvYk660dF+6tlqDpDjO0FA6678haPvciUuybhhsgjg/SZdlX
         j1oEe+He8M4nCYstiO/ejokJE6IByROBkVHU01Soc+qTNL98K4u+f+p+He4UnKOd7ENJ
         p+vvgjNwV+zbjJXTlnBwmUljYiE44gjiVmz5/gWQWFwtgnyBGQy2lKAR7xASDojkCzwe
         7bOA==
X-Gm-Message-State: AOAM533Ha0IwytBwY+eLY/Go0b2tFGDSW+69WFl0b2FATeLcGf6aBRzr
        rBtpSdtP/HMzs0tjGTeGsbVlpw==
X-Google-Smtp-Source: ABdhPJzPv75rwiRFoS7vVDaryUDVA1if9+ElGNNTcuJ7EDCFqCebC/lU1YNU6Ky4zQnaYunlP65/ZA==
X-Received: by 2002:a2e:954f:0:b0:24f:4457:950d with SMTP id t15-20020a2e954f000000b0024f4457950dmr6375177ljh.35.1651432912887;
        Sun, 01 May 2022 12:21:52 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id q3-20020a2e8743000000b0024f3d1daee6sm865928ljj.110.2022.05.01.12.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 May 2022 12:21:52 -0700 (PDT)
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
Subject: [PATCH v4 2/5] clk: qcom: regmap: add pipe clk implementation
Date:   Sun,  1 May 2022 22:21:46 +0300
Message-Id: <20220501192149.4128158-3-dmitry.baryshkov@linaro.org>
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

On recent Qualcomm platforms the QMP PIPE clocks feed into a set of
muxes which must be parked to the "safe" source (bi_tcxo) when
corresponding GDSC is turned off and on again. Currently this is
handcoded in the PCIe driver by reparenting the gcc_pipe_N_clk_src
clock. However the same code sequence should be applied in the
pcie-qcom endpoint, USB3 and UFS drivers.

Rather than copying this sequence over and over again, follow the
example of clk_rcg2_shared_ops and implement this parking in the
enable() and disable() clock operations. Suppliement the regmap-mux with
the new regmap-pipe implementation, which hides multiplexer behind
simple branch-like clock. This is possible since each of this
multiplexers has just two clock sources: working (pipe) and safe
(bi_tcxo) clock sources. If the clock is running off the external pipe
source, report it as enable and report it as disabled otherwise.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/clk/qcom/Makefile          |  1 +
 drivers/clk/qcom/clk-regmap-pipe.c | 62 ++++++++++++++++++++++++++++++
 drivers/clk/qcom/clk-regmap-pipe.h | 24 ++++++++++++
 3 files changed, 87 insertions(+)
 create mode 100644 drivers/clk/qcom/clk-regmap-pipe.c
 create mode 100644 drivers/clk/qcom/clk-regmap-pipe.h

diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index 671cf5821af1..882c8ecc2e93 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -11,6 +11,7 @@ clk-qcom-y += clk-branch.o
 clk-qcom-y += clk-regmap-divider.o
 clk-qcom-y += clk-regmap-mux.o
 clk-qcom-y += clk-regmap-mux-div.o
+clk-qcom-y += clk-regmap-pipe.o
 clk-qcom-$(CONFIG_KRAIT_CLOCKS) += clk-krait.o
 clk-qcom-y += clk-hfpll.o
 clk-qcom-y += reset.o
diff --git a/drivers/clk/qcom/clk-regmap-pipe.c b/drivers/clk/qcom/clk-regmap-pipe.c
new file mode 100644
index 000000000000..9a7c27cc644b
--- /dev/null
+++ b/drivers/clk/qcom/clk-regmap-pipe.c
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
+#include "clk-regmap-pipe.h"
+
+static inline struct clk_regmap_pipe *to_clk_regmap_pipe(struct clk_hw *hw)
+{
+	return container_of(to_clk_regmap(hw), struct clk_regmap_pipe, clkr);
+}
+
+static int pipe_is_enabled(struct clk_hw *hw)
+{
+	struct clk_regmap_pipe *pipe = to_clk_regmap_pipe(hw);
+	struct clk_regmap *clkr = to_clk_regmap(hw);
+	unsigned int mask = GENMASK(pipe->width + pipe->shift - 1, pipe->shift);
+	unsigned int val;
+
+	regmap_read(clkr->regmap, pipe->reg, &val);
+	val = (val & mask) >> pipe->shift;
+
+	WARN_ON(unlikely(val != pipe->enable_val && val != pipe->disable_val));
+
+	return val == pipe->enable_val;
+}
+
+static int pipe_enable(struct clk_hw *hw)
+{
+	struct clk_regmap_pipe *pipe = to_clk_regmap_pipe(hw);
+	struct clk_regmap *clkr = to_clk_regmap(hw);
+	unsigned int mask = GENMASK(pipe->width + pipe->shift - 1, pipe->shift);
+	unsigned int val;
+
+	val = pipe->enable_val << pipe->shift;
+
+	return regmap_update_bits(clkr->regmap, pipe->reg, mask, val);
+}
+
+static void pipe_disable(struct clk_hw *hw)
+{
+	struct clk_regmap_pipe *pipe = to_clk_regmap_pipe(hw);
+	struct clk_regmap *clkr = to_clk_regmap(hw);
+	unsigned int mask = GENMASK(pipe->width + pipe->shift - 1, pipe->shift);
+	unsigned int val;
+
+	val = pipe->disable_val << pipe->shift;
+
+	regmap_update_bits(clkr->regmap, pipe->reg, mask, val);
+}
+
+const struct clk_ops clk_regmap_pipe_ops = {
+	.enable = pipe_enable,
+	.disable = pipe_disable,
+	.is_enabled = pipe_is_enabled,
+};
+EXPORT_SYMBOL_GPL(clk_regmap_pipe_ops);
diff --git a/drivers/clk/qcom/clk-regmap-pipe.h b/drivers/clk/qcom/clk-regmap-pipe.h
new file mode 100644
index 000000000000..cfaa792a029b
--- /dev/null
+++ b/drivers/clk/qcom/clk-regmap-pipe.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2022, Linaru Ltd.
+ * Author: Dmitry Baryshkov
+ */
+
+#ifndef __QCOM_CLK_REGMAP_PIPE_H__
+#define __QCOM_CLK_REGMAP_PIPE_H__
+
+#include <linux/clk-provider.h>
+#include "clk-regmap.h"
+
+struct clk_regmap_pipe {
+	u32			reg;
+	u32			shift;
+	u32			width;
+	u32			enable_val;
+	u32			disable_val;
+	struct clk_regmap	clkr;
+};
+
+extern const struct clk_ops clk_regmap_pipe_ops;
+
+#endif
-- 
2.35.1

