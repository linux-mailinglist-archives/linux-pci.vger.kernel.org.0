Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAA925268C4
	for <lists+linux-pci@lfdr.de>; Fri, 13 May 2022 19:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383189AbiEMRxr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 May 2022 13:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383179AbiEMRxp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 May 2022 13:53:45 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D45545ACA
        for <linux-pci@vger.kernel.org>; Fri, 13 May 2022 10:53:44 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id i10so15728099lfg.13
        for <linux-pci@vger.kernel.org>; Fri, 13 May 2022 10:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L0aR97lb5cmX1f4lsSdHRRFvz7LpsWRaYXNxCplaKBU=;
        b=twLjsvsxle6RzVJnc2l3pB6lMKwraYomdovy+02rDOBYo2q123rDrleGhI5KtNsA50
         U77bcXSrEe9VdL2/G7eVanDiN6H9MonCpJqtf8qtFk9lUgybA+hzxCylEIuSuDNv2m0Y
         jGBpRgvZYwpQ+n7k4TAbHsWGNM8/SKJtshVgRiqckZcFjp30CNu2sN/CU8jepV+PB+Zu
         oa2sTs+3AhOSluSVcjNH1qdjXPqN9EOWXAk5uR95XzzIboN2WxfWIwpBr3CBxVqBg+fE
         o+BBiI6wkhOucpcfroxw1ZJvFEFfcCjl7WkH+2d5d/RjTfNo6W/lSLfQQWiogZxSb3n1
         tnYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L0aR97lb5cmX1f4lsSdHRRFvz7LpsWRaYXNxCplaKBU=;
        b=m54VII8I360vBLXAVUc6VJ/9khosvWyabCdOZXG/UunTLUZkWjh1JQleX5/mDeMn/K
         kwbdBLJTfg7GtZ1anWsN+KgCF7Wz6goZrNWwZ5aFwbbjdLiBfOBZ8CuhuRs3oi8g3qWD
         THY0INFSgm5WOaB0QlHijDAxIDeCXyk97fBINmelFHBhoyjpECrUZodsLGCeu6Z2QkCI
         Oxx2g6lLHt0GVMdhTKAYOFKWDsBBke4EtebFePul4z3HjkQO6C98xI0AKvoNuVt8at95
         8fydwHyu47xM78yB26N5BfK5jE9IXDf5aRb8BcnhNPVfK7ridOnGDvqoqcPEe/BviDLb
         d6rw==
X-Gm-Message-State: AOAM530JEY1I3aNs32sINLNc/aYXmqzL1dzHWv0/I6v5+wS93He/76io
        wlivoj/ndEM9uMPaCJBOyL4u3g==
X-Google-Smtp-Source: ABdhPJyNcP/0I473fQkaGnfKYe3fSXGQbxlvy+MZpAoe5q3TqWJWepiba7koxLFuIZ4FebeJZ+cS1A==
X-Received: by 2002:ac2:5f84:0:b0:471:fd0f:a6e7 with SMTP id r4-20020ac25f84000000b00471fd0fa6e7mr4059065lfe.41.1652464422597;
        Fri, 13 May 2022 10:53:42 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id n2-20020a195502000000b0047255d21164sm448614lfe.147.2022.05.13.10.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 10:53:42 -0700 (PDT)
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
Cc:     Prasad Malisetty <quic_pmaliset@quicinc.com>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v6 2/5] clk: qcom: regmap: add PHY clock source implementation
Date:   Fri, 13 May 2022 20:53:36 +0300
Message-Id: <20220513175339.2981959-3-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220513175339.2981959-1-dmitry.baryshkov@linaro.org>
References: <20220513175339.2981959-1-dmitry.baryshkov@linaro.org>
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

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/clk/qcom/Makefile             |  1 +
 drivers/clk/qcom/clk-regmap-phy-mux.c | 62 +++++++++++++++++++++++++++
 drivers/clk/qcom/clk-regmap-phy-mux.h | 37 ++++++++++++++++
 3 files changed, 100 insertions(+)
 create mode 100644 drivers/clk/qcom/clk-regmap-phy-mux.c
 create mode 100644 drivers/clk/qcom/clk-regmap-phy-mux.h

diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index 671cf5821af1..e4ceb5819ae6 100644
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
index 000000000000..d7a45f7fa1aa
--- /dev/null
+++ b/drivers/clk/qcom/clk-regmap-phy-mux.c
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
+#include "clk-regmap-phy-mux.h"
+
+static inline struct clk_regmap_phy_mux *to_clk_regmap_phy_mux(struct clk_hw *hw)
+{
+	return container_of(to_clk_regmap(hw), struct clk_regmap_phy_mux, clkr);
+}
+
+static int phy_mux_is_enabled(struct clk_hw *hw)
+{
+	struct clk_regmap_phy_mux *phy_mux = to_clk_regmap_phy_mux(hw);
+	struct clk_regmap *clkr = to_clk_regmap(hw);
+	unsigned int mask = GENMASK(phy_mux->width + phy_mux->shift - 1, phy_mux->shift);
+	unsigned int val;
+
+	regmap_read(clkr->regmap, phy_mux->reg, &val);
+	val = (val & mask) >> phy_mux->shift;
+
+	WARN_ON(val != phy_mux->phy_src_val && val != phy_mux->ref_src_val);
+
+	return val == phy_mux->phy_src_val;
+}
+
+static int phy_mux_enable(struct clk_hw *hw)
+{
+	struct clk_regmap_phy_mux *phy_mux = to_clk_regmap_phy_mux(hw);
+	struct clk_regmap *clkr = to_clk_regmap(hw);
+	unsigned int mask = GENMASK(phy_mux->width + phy_mux->shift - 1, phy_mux->shift);
+	unsigned int val;
+
+	val = phy_mux->phy_src_val << phy_mux->shift;
+
+	return regmap_update_bits(clkr->regmap, phy_mux->reg, mask, val);
+}
+
+static void phy_mux_disable(struct clk_hw *hw)
+{
+	struct clk_regmap_phy_mux *phy_mux = to_clk_regmap_phy_mux(hw);
+	struct clk_regmap *clkr = to_clk_regmap(hw);
+	unsigned int mask = GENMASK(phy_mux->width + phy_mux->shift - 1, phy_mux->shift);
+	unsigned int val;
+
+	val = phy_mux->ref_src_val << phy_mux->shift;
+
+	regmap_update_bits(clkr->regmap, phy_mux->reg, mask, val);
+}
+
+const struct clk_ops clk_regmap_phy_mux_ops = {
+	.enable = phy_mux_enable,
+	.disable = phy_mux_disable,
+	.is_enabled = phy_mux_is_enabled,
+};
+EXPORT_SYMBOL_GPL(clk_regmap_phy_mux_ops);
diff --git a/drivers/clk/qcom/clk-regmap-phy-mux.h b/drivers/clk/qcom/clk-regmap-phy-mux.h
new file mode 100644
index 000000000000..6260912191c5
--- /dev/null
+++ b/drivers/clk/qcom/clk-regmap-phy-mux.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2022, Linaro Ltd.
+ * Author: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
+ */
+
+#ifndef __QCOM_CLK_REGMAP_PHY_MUX_H__
+#define __QCOM_CLK_REGMAP_PHY_MUX_H__
+
+#include <linux/clk-provider.h>
+#include "clk-regmap.h"
+
+/*
+ * A special clock implementation for PHY pipe and symbols clock sources.
+ *
+ * If the clock is running off the from-PHY source, report it as enabled.
+ * Report it as disabled otherwise (if it uses reference source).
+ *
+ * This way the PHY will disable the pipe clock before turning off the GDSC,
+ * which in turn would lead to disabling corresponding pipe_clk_src (and thus
+ * it being parked to a safe, reference clock source). And vice versa, after
+ * enabling the GDSC the PHY will enable the pipe clock, which would cause
+ * pipe_clk_src to be switched from a safe source to the working one.
+ */
+
+struct clk_regmap_phy_mux {
+	u32			reg;
+	u32			shift;
+	u32			width;
+	u32			phy_src_val;
+	u32			ref_src_val;
+	struct clk_regmap	clkr;
+};
+
+extern const struct clk_ops clk_regmap_phy_mux_ops;
+
+#endif
-- 
2.35.1

