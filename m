Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0834133FF4E
	for <lists+linux-pci@lfdr.de>; Thu, 18 Mar 2021 07:09:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbhCRGJH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Mar 2021 02:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbhCRGIg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Mar 2021 02:08:36 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E02AEC06175F
        for <linux-pci@vger.kernel.org>; Wed, 17 Mar 2021 23:08:35 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id j25so2753030pfe.2
        for <linux-pci@vger.kernel.org>; Wed, 17 Mar 2021 23:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=+Ajx//Hrn2Nysbs5OX32IPY3AqQ7T4AzxnnPGV+AONg=;
        b=Ep5j77s2uyFhZTdf2aWch6QKWGcwQGf2ydAGmR47fOokZTEPEMazSqbWYDEYuHUf2j
         gwpMSrzYPEoTtReWWYPWQdT7ksvroeD54vnbeiA5ZTCS7Eox8HjvP9v3qtW5spoM65cF
         hN0CHfGpceU4Amh8rrVqA01C7+JCznukhEyfcNWlYgFfyXCKXZJZcC2JVUQOECzCxiqK
         7gMl7G1zv4TQsmyvVWgHL49wqFNcwpbVosR7MaUZl5VjsemFmNKTRe/5fk19a5Ljyfej
         yE+jlpGn4h7i6K8lR7QNi9h6nCf8lgZM5QHwI+YifN+kYIDp3vW4AxJNwmEP25ZF9ESU
         zVaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+Ajx//Hrn2Nysbs5OX32IPY3AqQ7T4AzxnnPGV+AONg=;
        b=CBxcoJWPZWhSu8vu8ooDLeuP/9dYnXftQQ0Ln+26ANE4FdSU+yyfk9S5Ib1TSvb/Js
         pN7ce3J1DA9eLXwXZjvl/L2ifYbgPbTIA6MuHI4MGMsMfvxuy/UJV98sU5pkgPWDDsST
         1PVQnGuo86i7sxgXJPesvTyRjcuTI7SAN3YeMk5FBXUDMj+jAE8txDzLLkSfCWgwzma4
         B7d5H2zRriRkPo+DUGy9ZxTPjcKGICrOf18j1ZZSsO5RoyRZcctVR4bdZbz/wtrIKU8G
         ruN7G6N1AvngiGKFQhAg3dpaxinRhHUT96Ozk190gEjG4vTSSo2n6NOFKAFHf8ACq/Bn
         M9xw==
X-Gm-Message-State: AOAM531E8+VLWMhG9ibRCP6mknIutzgXDYE8INVf67WU//YXLtHhDNWP
        wn3qbj74HE9c6O+dx+n5vjtIRQ==
X-Google-Smtp-Source: ABdhPJxXB321/zc8CA1G6SDaw5CzywX3n3gKzC1wA/MZPyDLcLi67Vz1r2QOR6T5rwIKI3dm8e4YQA==
X-Received: by 2002:a63:2c8f:: with SMTP id s137mr5521095pgs.51.1616047715433;
        Wed, 17 Mar 2021 23:08:35 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id 68sm967353pfd.75.2021.03.17.23.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 23:08:35 -0700 (PDT)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     greentime.hu@sifive.com, paul.walmsley@sifive.com, hes@sifive.com,
        erik.danie@sifive.com, zong.li@sifive.com, bhelgaas@google.com,
        robh+dt@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu,
        mturquette@baylibre.com, sboyd@kernel.org,
        lorenzo.pieralisi@arm.com, p.zabel@pengutronix.de,
        alex.dewar90@gmail.com, khilman@baylibre.com,
        hayashi.kunihiko@socionext.com, vidyas@nvidia.com,
        jh80.chung@samsung.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        helgaas@kernel.org
Subject: [PATCH v2 2/6] clk: sifive: Use reset-simple in prci driver for PCIe driver
Date:   Thu, 18 Mar 2021 14:08:09 +0800
Message-Id: <91d016e59bab9d9175168a63e7bcd81fdb69b549.1615954046.git.greentime.hu@sifive.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1615954045.git.greentime.hu@sifive.com>
References: <cover.1615954045.git.greentime.hu@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

We use reset-simple in this patch so that pcie driver can use
devm_reset_control_get() to get this reset data structure and use
reset_control_deassert() to deassert pcie_power_up_rst_n.

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
---
 drivers/clk/sifive/Kconfig       |  2 ++
 drivers/clk/sifive/sifive-prci.c | 13 +++++++++++++
 drivers/clk/sifive/sifive-prci.h |  4 ++++
 drivers/reset/Kconfig            |  3 ++-
 4 files changed, 21 insertions(+), 1 deletion(-)

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
index baf7313dac92..871ccb287993 100644
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
index 71ab75a46491..f094df93d911 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -173,7 +173,7 @@ config RESET_SCMI
 
 config RESET_SIMPLE
 	bool "Simple Reset Controller Driver" if COMPILE_TEST
-	default ARCH_AGILEX || ARCH_ASPEED || ARCH_BITMAIN || ARCH_REALTEK || ARCH_STM32 || ARCH_STRATIX10 || ARCH_SUNXI || ARCH_ZX || ARC
+	default ARCH_AGILEX || ARCH_ASPEED || ARCH_BITMAIN || ARCH_REALTEK || ARCH_STM32 || ARCH_STRATIX10 || ARCH_SUNXI || ARCH_ZX || ARC || RISCV
 	help
 	  This enables a simple reset controller driver for reset lines that
 	  that can be asserted and deasserted by toggling bits in a contiguous,
@@ -187,6 +187,7 @@ config RESET_SIMPLE
 	   - RCC reset controller in STM32 MCUs
 	   - Allwinner SoCs
 	   - ZTE's zx2967 family
+	   - SiFive FU740 SoCs
 
 config RESET_STM32MP157
 	bool "STM32MP157 Reset Driver" if COMPILE_TEST
-- 
2.30.2

