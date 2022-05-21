Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9477452F719
	for <lists+linux-pci@lfdr.de>; Sat, 21 May 2022 02:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232972AbiEUAx6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 May 2022 20:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237569AbiEUAx5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 May 2022 20:53:57 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E451AD5B0
        for <linux-pci@vger.kernel.org>; Fri, 20 May 2022 17:53:56 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id bu29so17024713lfb.0
        for <linux-pci@vger.kernel.org>; Fri, 20 May 2022 17:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T+YiK8dxsrGm0m2VhiIGzrrysQ7BgDNB7nIlgNquoww=;
        b=sSIXdE9p5G79cWnri1fdGlFgZb76DuCz93192G8Ry0Ksrk4jLE8H5YZ3qzVust7aMO
         nYDIoRWJKjVQP0xXSMnnLi6SkNRw9yfOGMo0jUfH67MImHJflnyuc8rpt8mtMKIuFyPH
         X6EPY7eCfJunW57xE1IVqa3xunNJBh/AtBnAXR8fucVqoOB41Crqj1m9RGVL0BG2aLiL
         95mzaogqx5/ZQHGb4MlwNMp++vPW5q6BohkucswofxW1yXhF4NOdJsSnynLpWmIW5ysZ
         RQlFJOH5TUETMpqLmuN2EtivwkgFnf2p0d9RRCqNOPjSn50DXfdEkXkVO0fgIzWoMCd+
         qj5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T+YiK8dxsrGm0m2VhiIGzrrysQ7BgDNB7nIlgNquoww=;
        b=V5/+YrubDuN6t5/uOJrP5Xfw7eXyjrLpA1cPetl1qeCZJOI3UxkCa2Jq00nqYBTdSE
         BtLpoOFAlnUaEe96TpMi7o1vGnKhYJYsV1JZAipQMC/5c0fSXIs7vxgEGQ/F1p4TQGub
         Rfz4qIW3HkT80qI+RNP0XXSvOHmt9hBV9kOnGgmuaLy4Wo3YqKtTYLTqNJetRUJIeKtk
         zDSm+BWRUeG6aUEWan61TxmaME64ZGo1/K6b4cEfiG/tM8444hA0AI1VvCTvC9JcxgKt
         vcFt+dKliboXcaYtEUQu/VM31lIg7c4cs9EpqXMKOEfiyVtIldxXBCljXlMU+2XFUjg6
         A2gw==
X-Gm-Message-State: AOAM532r/nG5VvSlfIbECIqb44Jxn4ODXGLNrGyCmIvNFuRisnI4GMic
        yRB7JRGntI11gR+tQHah9dzczw==
X-Google-Smtp-Source: ABdhPJxEqoUT09DUnay3AI+EsKfFnUjXPSHSi6TWr+Zj+GeIKtsXACbcpOQGvEZy4t1WkoXRr4iFGw==
X-Received: by 2002:a05:6512:3b93:b0:474:188b:1c99 with SMTP id g19-20020a0565123b9300b00474188b1c99mr8708430lfv.549.1653094434408;
        Fri, 20 May 2022 17:53:54 -0700 (PDT)
Received: from eriador.lan ([2001:470:dd84:abc0::8a5])
        by smtp.gmail.com with ESMTPSA id u14-20020a056512094e00b0047255d21187sm844559lft.182.2022.05.20.17.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 17:53:53 -0700 (PDT)
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
Subject: [PATCH v7 4/8] clk: qcom: regmap: add PHY clock source implementation
Date:   Sat, 21 May 2022 03:53:39 +0300
Message-Id: <20220521005343.1429642-5-dmitry.baryshkov@linaro.org>
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
 drivers/clk/qcom/clk-regmap-phy-mux.h | 33 ++++++++++++++
 3 files changed, 96 insertions(+)
 create mode 100644 drivers/clk/qcom/clk-regmap-phy-mux.c
 create mode 100644 drivers/clk/qcom/clk-regmap-phy-mux.h

diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index 36789f5233ef..08594230c1c1 100644
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
index 000000000000..a1adc075b471
--- /dev/null
+++ b/drivers/clk/qcom/clk-regmap-phy-mux.c
@@ -0,0 +1,62 @@
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
+#include "clk-regmap-phy-mux.h"
+
+#define PHY_MUX_MASK		GENMASK(1, 0)
+#define PHY_MUX_PHY_SRC		0
+#define PHY_MUX_REF_SRC		2
+
+static inline struct clk_regmap_phy_mux *to_clk_regmap_phy_mux(struct clk_regmap *clkr)
+{
+	return container_of(clkr, struct clk_regmap_phy_mux, clkr);
+}
+
+static int phy_mux_is_enabled(struct clk_hw *hw)
+{
+	struct clk_regmap *clkr = to_clk_regmap(hw);
+	struct clk_regmap_phy_mux *phy_mux = to_clk_regmap_phy_mux(clkr);
+	unsigned int val;
+
+	regmap_read(clkr->regmap, phy_mux->reg, &val);
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
+	struct clk_regmap_phy_mux *phy_mux = to_clk_regmap_phy_mux(clkr);
+
+	return regmap_update_bits(clkr->regmap, phy_mux->reg,
+				  PHY_MUX_MASK,
+				  FIELD_PREP(PHY_MUX_MASK, PHY_MUX_PHY_SRC));
+}
+
+static void phy_mux_disable(struct clk_hw *hw)
+{
+	struct clk_regmap *clkr = to_clk_regmap(hw);
+	struct clk_regmap_phy_mux *phy_mux = to_clk_regmap_phy_mux(clkr);
+
+	regmap_update_bits(clkr->regmap, phy_mux->reg,
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
diff --git a/drivers/clk/qcom/clk-regmap-phy-mux.h b/drivers/clk/qcom/clk-regmap-phy-mux.h
new file mode 100644
index 000000000000..614dd384695c
--- /dev/null
+++ b/drivers/clk/qcom/clk-regmap-phy-mux.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2022, Linaro Ltd.
+ */
+
+#ifndef __QCOM_CLK_REGMAP_PHY_MUX_H__
+#define __QCOM_CLK_REGMAP_PHY_MUX_H__
+
+#include "clk-regmap.h"
+
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
+struct clk_regmap_phy_mux {
+	u32			reg;
+	struct clk_regmap	clkr;
+};
+
+extern const struct clk_ops clk_regmap_phy_mux_ops;
+
+#endif
-- 
2.35.1

