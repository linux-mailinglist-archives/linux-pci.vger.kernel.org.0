Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BBCA34FCB0
	for <lists+linux-pci@lfdr.de>; Wed, 31 Mar 2021 11:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234552AbhCaJ0x (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 31 Mar 2021 05:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234705AbhCaJ0Z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 31 Mar 2021 05:26:25 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADAE3C06175F
        for <linux-pci@vger.kernel.org>; Wed, 31 Mar 2021 02:26:24 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id q10so2595268pgj.2
        for <linux-pci@vger.kernel.org>; Wed, 31 Mar 2021 02:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=nRm151gH2WNPBdZW2Pm7/P4rRlvfB4vy2qGGYIF+TvU=;
        b=jGpKikyus00eFIqtEgY6NV7lNEY4utua1IxoVg4DNwqnoLN9OccYYPcKtyZYoRAe5V
         d+EZVxv95OBp7JXyTVDLRb81Y4ujuMP4IGz2P9VfZuat/w1t3OxcPIDLAUBIsCAD63ke
         WM/YtUpzr2iR7uoa6kaDtNEyPtOzQ4/XUf2M/V+0gqmehdK71qLye+VMYyMtpLobqRDD
         GQM+PZ+BLbFk2MONaEQnMejzN6iV0kfDBUlCPHMvdSVIPuUlS6Vnaj/HMwFwQYNDdsw0
         KNarVLgDbOZ+0QOQRDpTQL2iS9cqpAv7mj4oWNUeJOEKVZ/1hnmAo/0PdwkIzZ6JX51g
         LF0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nRm151gH2WNPBdZW2Pm7/P4rRlvfB4vy2qGGYIF+TvU=;
        b=kE1wTnTnvTA4Otyx4elIXZ6UMDp9F/RApiRLPtjSbjPtr3Na+4jjHDyJGep2IGv58j
         ajbaPQ/rSKWO78FYAhTetj/QciDTpAplv2OFNwyNtjcB6rBZBy67MJ7JvjjSI+I0kLo3
         APUC6pXViiTj25+nBiiepcBL/hY5DrWhVZ7Qq/UDFaJyxa7NcTOqj5aPp6btukYuHmta
         YYj5a3avKw/7KTzHcx5QHOtrdI/i4ED8QF2J/+IwweN0ZHNqBRdIjcuDcUPT15XfLa+x
         3g87l6CncQgaSfDAOdbUt7bOJOiOghyVd0tZooxp5MXYXjKJcYkGl25Nh2swn4RLScvp
         eofQ==
X-Gm-Message-State: AOAM5334tjwKrF3ciluAwluYuZfcMX1MKXXpeaZxNPoiYevwBAFYRhaQ
        zXZNEZ25N2UhyMLb8O/ypNbFNw==
X-Google-Smtp-Source: ABdhPJy8nqhWqCO6h2sVYhdKI8yYCAXIvrkq+e4KgWUZiR9e4KmpTHBZ5+DYor4vc2BB3f4ZOSXTgQ==
X-Received: by 2002:a62:1492:0:b029:202:ec35:a893 with SMTP id 140-20020a6214920000b0290202ec35a893mr2164008pfu.22.1617182784263;
        Wed, 31 Mar 2021 02:26:24 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id 143sm1726505pfx.144.2021.03.31.02.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 02:26:23 -0700 (PDT)
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
Subject: [PATCH v3 2/6] clk: sifive: Use reset-simple in prci driver for PCIe driver
Date:   Wed, 31 Mar 2021 17:26:01 +0800
Message-Id: <20210331092605.105909-3-greentime.hu@sifive.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210331092605.105909-1-greentime.hu@sifive.com>
References: <20210331092605.105909-1-greentime.hu@sifive.com>
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

