Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E73034FCA9
	for <lists+linux-pci@lfdr.de>; Wed, 31 Mar 2021 11:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234543AbhCaJ0W (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 31 Mar 2021 05:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234654AbhCaJ0U (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 31 Mar 2021 05:26:20 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA73AC061760
        for <linux-pci@vger.kernel.org>; Wed, 31 Mar 2021 02:26:20 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id il9-20020a17090b1649b0290114bcb0d6c2so875930pjb.0
        for <linux-pci@vger.kernel.org>; Wed, 31 Mar 2021 02:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=iem/o5Wviui0HsOm3wOLhBTYCPdAfCVcmm4ly76UOFI=;
        b=EmTZEO+tLIrx2N1av1O2ISSaCe3Sit2lVrz0vKkqPgbelUJ/UWFc3YqTtpfWcHvddS
         x0zVfRr8faqWrZIu8H3xrokSQ6oQgw2rTBdn8k0i2awCRdSiymoh3GOiQi4VPNkG9QJM
         TuPIAT6LoMNfMjcAW+Lm1fdl8+TKRzQqyblbb0qarbxiuKFiagSoFBkYa4OYUzOj5Q1R
         w2pqsv3O+tvd4qm0MSS+GDR5qXehsJp5xe/N9LPd7hV6pVa4bCi+HOscVQPLuRnXTNQU
         yKcx/MxvKA6eHd2zK/xrS/LE8pvmawojBe7omvbITmI/3vyt5jfejf9txpE7tp6YAdWY
         MTEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iem/o5Wviui0HsOm3wOLhBTYCPdAfCVcmm4ly76UOFI=;
        b=dCQshwdsDRTe/oBNPyXtaaxK+TXm4QZArdXZe5yl0tx/IY2rG9wZ4BlHJ/2ckJWXx2
         g1r7W8c4SBevKMX/F0UFtW94ZkiiVMwg+xJFA5Eq+8C548H03+1m4FuiP1bLIxShIDFN
         Xo6lTkuhRFe5zywkPhwHghhvrCZze4AnY2zwlOhO0k3hRD6OQLfHn6n06ws0oacVv8qJ
         BYPClWJ95V+U3WTTIaWKximZ5Ft+2R3GOLJyKgAfsjHoN0c7/d/MMDLzLN5VA+DXMngz
         EEq9Q7/1PKG/m6ZtfNtRl144xILH4PzmkUWTf6Xu+xbL5LOIa/Mf0FkDMKPN2ZZCrzHo
         fJtw==
X-Gm-Message-State: AOAM532vX1+4Xj6YSDXnQfTFvJaI/E+/3+1/KXEQay/SnwN55K07iRxq
        jasscJo6B+6si4yUARMIyy8NTQ==
X-Google-Smtp-Source: ABdhPJxDud5xHhVJWB0Z31Hr00bqHa+lZrM5XSfTl7fixJpyKaTh7E9Y/GHWQed+ctLNPggUMxHEXw==
X-Received: by 2002:a17:902:aa87:b029:e5:e1fc:be6 with SMTP id d7-20020a170902aa87b02900e5e1fc0be6mr2464667plr.4.1617182780337;
        Wed, 31 Mar 2021 02:26:20 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id 143sm1726505pfx.144.2021.03.31.02.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 02:26:19 -0700 (PDT)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     greentime.hu@sifive.com, paul.walmsley@sifive.com, hes@sifive.com,
        erik.danie@sifive.com, zong.li@sifive.com, bhelgaas@google.com,
        robh+dt@kernel.org, aou@eecs.berkeley.edu, mturquette@baylibre.com,
        sboyd@kernel.org, lorenzo.pieralisi@arm.com,
        p.zabel@pengutronix.de, alex.dewar90@gmail.com,
        khilman@baylibre.com, hayashi.kunihiko@socionext.com,
        vidyas@nvidia.com, jh80.chung@samsung.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, helgaas@kernel.org
Subject: [PATCH v3 1/6] clk: sifive: Add pcie_aux clock in prci driver for PCIe driver
Date:   Wed, 31 Mar 2021 17:26:00 +0800
Message-Id: <20210331092605.105909-2-greentime.hu@sifive.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210331092605.105909-1-greentime.hu@sifive.com>
References: <20210331092605.105909-1-greentime.hu@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

We add pcie_aux clock in this patch so that pcie driver can use
clk_prepare_enable() and clk_disable_unprepare() to enable and disable
pcie_aux clock.

Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
---
 drivers/clk/sifive/fu740-prci.c               | 11 +++++
 drivers/clk/sifive/fu740-prci.h               |  2 +-
 drivers/clk/sifive/sifive-prci.c              | 41 +++++++++++++++++++
 drivers/clk/sifive/sifive-prci.h              |  9 ++++
 include/dt-bindings/clock/sifive-fu740-prci.h |  1 +
 5 files changed, 63 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/sifive/fu740-prci.c b/drivers/clk/sifive/fu740-prci.c
index 764d1097aa51..53f6e00a03b9 100644
--- a/drivers/clk/sifive/fu740-prci.c
+++ b/drivers/clk/sifive/fu740-prci.c
@@ -72,6 +72,12 @@ static const struct clk_ops sifive_fu740_prci_hfpclkplldiv_clk_ops = {
 	.recalc_rate = sifive_prci_hfpclkplldiv_recalc_rate,
 };
 
+static const struct clk_ops sifive_fu740_prci_pcie_aux_clk_ops = {
+	.enable = sifive_prci_pcie_aux_clock_enable,
+	.disable = sifive_prci_pcie_aux_clock_disable,
+	.is_enabled = sifive_prci_pcie_aux_clock_is_enabled,
+};
+
 /* List of clock controls provided by the PRCI */
 struct __prci_clock __prci_init_clocks_fu740[] = {
 	[PRCI_CLK_COREPLL] = {
@@ -120,4 +126,9 @@ struct __prci_clock __prci_init_clocks_fu740[] = {
 		.parent_name = "hfpclkpll",
 		.ops = &sifive_fu740_prci_hfpclkplldiv_clk_ops,
 	},
+	[PRCI_CLK_PCIE_AUX] = {
+		.name = "pcie_aux",
+		.parent_name = "hfclk",
+		.ops = &sifive_fu740_prci_pcie_aux_clk_ops,
+	},
 };
diff --git a/drivers/clk/sifive/fu740-prci.h b/drivers/clk/sifive/fu740-prci.h
index 13ef971f7764..511a0bf7ba2b 100644
--- a/drivers/clk/sifive/fu740-prci.h
+++ b/drivers/clk/sifive/fu740-prci.h
@@ -9,7 +9,7 @@
 
 #include "sifive-prci.h"
 
-#define NUM_CLOCK_FU740	8
+#define NUM_CLOCK_FU740	9
 
 extern struct __prci_clock __prci_init_clocks_fu740[NUM_CLOCK_FU740];
 
diff --git a/drivers/clk/sifive/sifive-prci.c b/drivers/clk/sifive/sifive-prci.c
index c78b042750e2..baf7313dac92 100644
--- a/drivers/clk/sifive/sifive-prci.c
+++ b/drivers/clk/sifive/sifive-prci.c
@@ -448,6 +448,47 @@ void sifive_prci_hfpclkpllsel_use_hfpclkpll(struct __prci_data *pd)
 	r = __prci_readl(pd, PRCI_HFPCLKPLLSEL_OFFSET);	/* barrier */
 }
 
+/* PCIE AUX clock APIs for enable, disable. */
+int sifive_prci_pcie_aux_clock_is_enabled(struct clk_hw *hw)
+{
+	struct __prci_clock *pc = clk_hw_to_prci_clock(hw);
+	struct __prci_data *pd = pc->pd;
+	u32 r;
+
+	r = __prci_readl(pd, PRCI_PCIE_AUX_OFFSET);
+
+	if (r & PRCI_PCIE_AUX_EN_MASK)
+		return 1;
+	else
+		return 0;
+}
+
+int sifive_prci_pcie_aux_clock_enable(struct clk_hw *hw)
+{
+	struct __prci_clock *pc = clk_hw_to_prci_clock(hw);
+	struct __prci_data *pd = pc->pd;
+	u32 r;
+
+	if (sifive_prci_pcie_aux_clock_is_enabled(hw))
+		return 0;
+
+	__prci_writel(1, PRCI_PCIE_AUX_OFFSET, pd);
+	r = __prci_readl(pd, PRCI_PCIE_AUX_OFFSET);	/* barrier */
+
+	return 0;
+}
+
+void sifive_prci_pcie_aux_clock_disable(struct clk_hw *hw)
+{
+	struct __prci_clock *pc = clk_hw_to_prci_clock(hw);
+	struct __prci_data *pd = pc->pd;
+	u32 r;
+
+	__prci_writel(0, PRCI_PCIE_AUX_OFFSET, pd);
+	r = __prci_readl(pd, PRCI_PCIE_AUX_OFFSET);	/* barrier */
+
+}
+
 /**
  * __prci_register_clocks() - register clock controls in the PRCI
  * @dev: Linux struct device
diff --git a/drivers/clk/sifive/sifive-prci.h b/drivers/clk/sifive/sifive-prci.h
index dbdbd1722688..022c67cf053c 100644
--- a/drivers/clk/sifive/sifive-prci.h
+++ b/drivers/clk/sifive/sifive-prci.h
@@ -67,6 +67,11 @@
 #define PRCI_DDRPLLCFG1_CKE_SHIFT	31
 #define PRCI_DDRPLLCFG1_CKE_MASK	(0x1 << PRCI_DDRPLLCFG1_CKE_SHIFT)
 
+/* PCIEAUX */
+#define PRCI_PCIE_AUX_OFFSET		0x14
+#define PRCI_PCIE_AUX_EN_SHIFT		0
+#define PRCI_PCIE_AUX_EN_MASK		(0x1 << PRCI_PCIE_AUX_EN_SHIFT)
+
 /* GEMGXLPLLCFG0 */
 #define PRCI_GEMGXLPLLCFG0_OFFSET	0x1c
 #define PRCI_GEMGXLPLLCFG0_DIVR_SHIFT	0
@@ -296,4 +301,8 @@ unsigned long sifive_prci_tlclksel_recalc_rate(struct clk_hw *hw,
 unsigned long sifive_prci_hfpclkplldiv_recalc_rate(struct clk_hw *hw,
 						   unsigned long parent_rate);
 
+int sifive_prci_pcie_aux_clock_is_enabled(struct clk_hw *hw);
+int sifive_prci_pcie_aux_clock_enable(struct clk_hw *hw);
+void sifive_prci_pcie_aux_clock_disable(struct clk_hw *hw);
+
 #endif /* __SIFIVE_CLK_SIFIVE_PRCI_H */
diff --git a/include/dt-bindings/clock/sifive-fu740-prci.h b/include/dt-bindings/clock/sifive-fu740-prci.h
index cd7706ea5677..7899b7fee7db 100644
--- a/include/dt-bindings/clock/sifive-fu740-prci.h
+++ b/include/dt-bindings/clock/sifive-fu740-prci.h
@@ -19,5 +19,6 @@
 #define PRCI_CLK_CLTXPLL	       5
 #define PRCI_CLK_TLCLK		       6
 #define PRCI_CLK_PCLK		       7
+#define PRCI_CLK_PCIE_AUX	       8
 
 #endif	/* __DT_BINDINGS_CLOCK_SIFIVE_FU740_PRCI_H */
-- 
2.30.2

