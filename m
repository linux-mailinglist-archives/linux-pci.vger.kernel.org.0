Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 131EB350EB3
	for <lists+linux-pci@lfdr.de>; Thu,  1 Apr 2021 08:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233361AbhDAGBn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Apr 2021 02:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233362AbhDAGBK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Apr 2021 02:01:10 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76EFCC061788
        for <linux-pci@vger.kernel.org>; Wed, 31 Mar 2021 23:01:09 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id w11so471796ply.6
        for <linux-pci@vger.kernel.org>; Wed, 31 Mar 2021 23:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=N3Ofv7Rek7cgGq9uaGjBnpEgWWaqpn6QcKrofIPEUwg=;
        b=khgPA2tQj0XBl2pjmoT1nQKH2acgI+DuwZDuMbLf2uyMrCQKpwXFRC2bkp5RSvE4bR
         dpj/jj1FSTaErZYHck9AuCc7U9cjMBG0NCw4eJrFCQGkDoIx6ApYpcsY8wG6iuq5KKF4
         arNMGBm/Kc412mQ8pwCeZ3dJ6uJO0a7FiVG7ZLKpEsubvuwA560wW6Vsl6LbV/3nav0k
         /37SBRMn8mdwx7h46HewEDJOdO0Wx5ENT1UW2PI2VMihHUpecdzQvMU4MF2h4F6T00vR
         V5DRlHfr2hcROXKGeVqExb6aASusihjhKxlKnJNTycdj6UO2FzMt28303zUN4d+A84vf
         HNZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N3Ofv7Rek7cgGq9uaGjBnpEgWWaqpn6QcKrofIPEUwg=;
        b=eNcZTLZwyOajUgoBCGwLa9G4jyyoUx9u7/AuXKQwMfxjE7CN4CSJbTRkmu2FDMiXDt
         BqjiLdW0mUwa9YagrNd7l8o32D9WKcCnYDiewQG2F5DjU1VQqN4ahh02xnsK0Byg26Vk
         7EBvZXrPS/TJzjt9iu5KkRA0sOURkyC0horlBp2gojJTyhVEHHSHph2adU7gzrwtWApE
         DvfiTgHRwBNJYCoaA22UgHM6nHJOO3klLQu0gYSQM+TCf6dOwT+ABxPfsxyw+qHv/FJv
         hx6QeoIecxgsti97pay81xSqKQehQ1emYggFGIg18s+MSnK3YNptX9KC5YeJMApdD1ek
         pW1w==
X-Gm-Message-State: AOAM533jcXnuZUXoySVVG/ZVk9DOTU7kOBY9k8woYhbT0B1q0DrmDGUH
        lMD6ONPU3YeID6NGIVZLF94emQ==
X-Google-Smtp-Source: ABdhPJwHZ+BcpY81xjQ/CI0AKookTPicx5Fd19k1RijF0z5miZkInR3ttYqjRggO0gvUVrY6JGCAWA==
X-Received: by 2002:a17:90a:2e0d:: with SMTP id q13mr7467523pjd.225.1617256869026;
        Wed, 31 Mar 2021 23:01:09 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id a6sm4037328pfc.61.2021.03.31.23.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 23:01:08 -0700 (PDT)
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
Subject: [PATCH v4 2/6] clk: sifive: Use reset-simple in prci driver for PCIe driver
Date:   Thu,  1 Apr 2021 14:00:50 +0800
Message-Id: <20210401060054.40788-3-greentime.hu@sifive.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210401060054.40788-1-greentime.hu@sifive.com>
References: <20210401060054.40788-1-greentime.hu@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

We use reset-simple in this patch so that pcie driver can use
devm_reset_control_get() to get this reset data structure and use
reset_control_deassert() to deassert pcie_power_up_rst_n.

Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Acked-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/sifive/Kconfig       |  2 ++
 drivers/clk/sifive/sifive-prci.c | 13 +++++++++++++
 drivers/clk/sifive/sifive-prci.h |  4 ++++
 drivers/reset/Kconfig            |  1 +
 4 files changed, 20 insertions(+)

diff --git a/drivers/clk/sifive/Kconfig b/drivers/clk/sifive/Kconfig
index 1c14eb20c066..9132c3c4aa86 100644
--- a/drivers/clk/sifive/Kconfig
+++ b/drivers/clk/sifive/Kconfig
@@ -10,6 +10,8 @@ if CLK_SIFIVE
 
 config CLK_SIFIVE_PRCI
 	bool "PRCI driver for SiFive SoCs"
+	select RESET_CONTROLLER
+	select RESET_SIMPLE
 	select CLK_ANALOGBITS_WRPLL_CLN28HPC
 	help
 	  Supports the Power Reset Clock interface (PRCI) IP block found in
diff --git a/drivers/clk/sifive/sifive-prci.c b/drivers/clk/sifive/sifive-prci.c
index 8fdba5da2902..0704fddba6b9 100644
--- a/drivers/clk/sifive/sifive-prci.c
+++ b/drivers/clk/sifive/sifive-prci.c
@@ -583,6 +583,19 @@ static int sifive_prci_probe(struct platform_device *pdev)
 	if (IS_ERR(pd->va))
 		return PTR_ERR(pd->va);
 
+	pd->reset.rcdev.owner = THIS_MODULE;
+	pd->reset.rcdev.nr_resets = PRCI_RST_NR;
+	pd->reset.rcdev.ops = &reset_simple_ops;
+	pd->reset.rcdev.of_node = pdev->dev.of_node;
+	pd->reset.active_low = true;
+	pd->reset.membase = pd->va + PRCI_DEVICESRESETREG_OFFSET;
+	spin_lock_init(&pd->reset.lock);
+
+	r = devm_reset_controller_register(&pdev->dev, &pd->reset.rcdev);
+	if (r) {
+		dev_err(dev, "could not register reset controller: %d\n", r);
+		return r;
+	}
 	r = __prci_register_clocks(dev, pd, desc);
 	if (r) {
 		dev_err(dev, "could not register clocks: %d\n", r);
diff --git a/drivers/clk/sifive/sifive-prci.h b/drivers/clk/sifive/sifive-prci.h
index 022c67cf053c..91658a88af4e 100644
--- a/drivers/clk/sifive/sifive-prci.h
+++ b/drivers/clk/sifive/sifive-prci.h
@@ -11,6 +11,7 @@
 
 #include <linux/clk/analogbits-wrpll-cln28hpc.h>
 #include <linux/clk-provider.h>
+#include <linux/reset/reset-simple.h>
 #include <linux/platform_device.h>
 
 /*
@@ -121,6 +122,8 @@
 #define PRCI_DEVICESRESETREG_CHIPLINK_RST_N_MASK			\
 		(0x1 << PRCI_DEVICESRESETREG_CHIPLINK_RST_N_SHIFT)
 
+#define PRCI_RST_NR						7
+
 /* CLKMUXSTATUSREG */
 #define PRCI_CLKMUXSTATUSREG_OFFSET				0x2c
 #define PRCI_CLKMUXSTATUSREG_TLCLKSEL_STATUS_SHIFT		1
@@ -221,6 +224,7 @@
  */
 struct __prci_data {
 	void __iomem *va;
+	struct reset_simple_data reset;
 	struct clk_hw_onecell_data hw_clks;
 };
 
diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 71ab75a46491..d0f5d0afc240 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -187,6 +187,7 @@ config RESET_SIMPLE
 	   - RCC reset controller in STM32 MCUs
 	   - Allwinner SoCs
 	   - ZTE's zx2967 family
+	   - SiFive FU740 SoCs
 
 config RESET_STM32MP157
 	bool "STM32MP157 Reset Driver" if COMPILE_TEST
-- 
2.30.2

