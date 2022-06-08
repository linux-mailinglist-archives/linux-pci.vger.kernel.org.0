Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32894542E73
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jun 2022 12:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236941AbiFHKwp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Jun 2022 06:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236983AbiFHKwo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Jun 2022 06:52:44 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E27821EA045
        for <linux-pci@vger.kernel.org>; Wed,  8 Jun 2022 03:52:41 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id h23so32610565lfe.4
        for <linux-pci@vger.kernel.org>; Wed, 08 Jun 2022 03:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hw/vKxsD44EhJg33dp8RrayiLTcgoLp2NrXfG+xaaF4=;
        b=H2AU3LfWpjFlZMJ/WXROnYEst4u+8jnPokzTemBihySlxHrm3AtL2Zfq3Ss4+hn9UF
         Rz0m6VPRcdoj3+VfeeSjO2wqdzeDhcYPs45SN52ojL+fE5w5WrP7aRWrfbGiEx2gSrNv
         EfZk7zKGk9lhUF4l+HR9dTUnneNiqsJ0V8E25P7PRsItdavjcotyKSLYG1XMqdCz7EEd
         nVK1dUn01GavTxGbDFCPpXmOxtR4Ls23ZOIfpvHHFdPr6wC0jsJv+K8eMB3DugnPIKD/
         V4xcNKJ4FZdRCurH9z3BvCl/+/0E7qfEtEaUBy5DjtaTYUyb9iC5+ABFzIHAPVpG6+oQ
         oUHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hw/vKxsD44EhJg33dp8RrayiLTcgoLp2NrXfG+xaaF4=;
        b=5s9nLb8rkdoLb7ORvBbdrFJzpZuT1U3JmLjvzgSIjrvpODRIz7h2heqUU2OkwW3sFo
         RVEU2dCOQZ6WWosVaTZmqaVjM/YC4cue5qm4QkSeaDge0PKiy1l/Em9Isj4gGAQJ4Ymx
         5t7wZFoyeKL4bqrbkTF/C8PzGAYy0LcY9lVBje0K9QPjgiM/ZRXhhhEvW0lnMCs1woRa
         tS5xNiVPBBgf2JuQdK+CvJ1clvM190qJEd6dB3QjZs5SV9EoJNDh7FTPRMYLMmaD3nVH
         V0E1VTaRhlTdpRdWKtMt5hFCV+f6PS3PG4v4HwPbivQcfZy4jQP2NB4xKac5WSNf5Mb6
         9JTg==
X-Gm-Message-State: AOAM5330qfQFvdPjdgSClTBdHsCuceq9NFxcc81z4/7hPTcja/+dukXe
        p7Qw/ZaS/wJRQdzNOumWqInWBg==
X-Google-Smtp-Source: ABdhPJwwC+5R3/tDDO53TvC00TCiwrFn2izb43rm1LTwt8yb3mlPzpH/OIlg3uL398KLo7fWBJhwCw==
X-Received: by 2002:a05:6512:ad4:b0:479:1d73:3508 with SMTP id n20-20020a0565120ad400b004791d733508mr15401259lfu.520.1654685560233;
        Wed, 08 Jun 2022 03:52:40 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id e9-20020a2e5009000000b002556b0cd5acsm3232337ljb.56.2022.06.08.03.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 03:52:39 -0700 (PDT)
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
        linux-pci@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v11 1/5] clk: qcom: regmap: add PHY clock source implementation
Date:   Wed,  8 Jun 2022 13:52:34 +0300
Message-Id: <20220608105238.2973600-2-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220608105238.2973600-1-dmitry.baryshkov@linaro.org>
References: <20220608105238.2973600-1-dmitry.baryshkov@linaro.org>
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

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
Tested-by: Johan Hovold <johan+linaro@kernel.org>
Reported-by: kernel test robot <lkp@intel.com>
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
index 000000000000..7b7243b7107d
--- /dev/null
+++ b/drivers/clk/qcom/clk-regmap-phy-mux.c
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022, Linaro Ltd.
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/bitfield.h>
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

