Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3202A37294A
	for <lists+linux-pci@lfdr.de>; Tue,  4 May 2021 13:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbhEDLBe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 May 2021 07:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbhEDLB3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 May 2021 07:01:29 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE91C061343
        for <linux-pci@vger.kernel.org>; Tue,  4 May 2021 04:00:22 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id m124so1162693pgm.13
        for <linux-pci@vger.kernel.org>; Tue, 04 May 2021 04:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ddtby8u0R33cOntLLPoDYh0e5Ss2FvGJIP/FJDn2Hhw=;
        b=nK5+3Wxx25GLN15WqSNbNa5E54rLfzDmxI0Zyx+4kxtndBZjOqgHRKxtXL3xzmFwaZ
         Phwr9DqBdn5N7mGOmyv5OVMBDiycI3bwe4kmUT5N8tKLOL7bgc5jidxVdlwNJqwMST4f
         5kmFSaa5emm/cbP02gIoypUR2fqhWCiBXj/inYl9Bly2gCUaZqnLwNIwb1dLY4g1TkD7
         DSwJBHHniJ1KdhlV+ruBUzWylUsCtf0/B9DydDYuEifaBV6bQqHHjIcqFFXgxtyrfjNo
         jv+J6BXLmSqBSaHPUuinLISxMkYQAX7fvQ9umKbFBwmn/yQOvdwIyRZ3P/FbZk9dCBLY
         8UNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ddtby8u0R33cOntLLPoDYh0e5Ss2FvGJIP/FJDn2Hhw=;
        b=pccAknXE09qWLkkQ+e1COF51CLTQn2Uzfp6mBo7lBA3xIOQqAo3XGxXWoxcvJcg+tH
         30ZyH/CciLEnNP0JcbiySAjrBaWwWmFovLr+HM8N9rKkapmMe1/lExAibBO8iAZxjCDr
         fWj7EQiDqAthDVen8oxv+N7SWklcJzio8W5HDweqymxkeK/g8li5ba3osTOUB9znWIzq
         p8+s3JTLPpHfvL+4T6LF9tvk8flO3/Q5iY69h9LGyQw9UVqdInpK427rV7J18jna+605
         d/QZaSAPaRsjxxw4APWqCilz5H9+jgPcjMPPKJ7GSpM3wnCL/5OjI9sYQFIquiZIcGM4
         qrPQ==
X-Gm-Message-State: AOAM533KY+iZJIm/VMXDK4DOe85zLYhbl/4uNwnnWfLcVnLEdRv05tP7
        LOPcntsBohOKAzy8NUY2b9Mqrg==
X-Google-Smtp-Source: ABdhPJymWl5vUOYmViNUkZVNeRXaMKCprW0D+gm1Enp4gVbzlNWrhrkUq2lBvFxo/96g4Yx2hNgPHw==
X-Received: by 2002:a17:90a:e64e:: with SMTP id ep14mr26936300pjb.103.1620126021903;
        Tue, 04 May 2021 04:00:21 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id k17sm11762529pfa.68.2021.05.04.04.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 04:00:21 -0700 (PDT)
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
Subject: [PATCH v6 2/6] clk: sifive: Use reset-simple in prci driver for PCIe driver
Date:   Tue,  4 May 2021 18:59:36 +0800
Message-Id: <20210504105940.100004-3-greentime.hu@sifive.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210504105940.100004-1-greentime.hu@sifive.com>
References: <20210504105940.100004-1-greentime.hu@sifive.com>
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
index 9997a3fa4a38..0d79ba31a793 100644
--- a/drivers/clk/sifive/sifive-prci.c
+++ b/drivers/clk/sifive/sifive-prci.c
@@ -588,6 +588,19 @@ static int sifive_prci_probe(struct platform_device *pdev)
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
index 4171c6f76385..0f40dadf5705 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -197,6 +197,7 @@ config RESET_SIMPLE
 	   - RCC reset controller in STM32 MCUs
 	   - Allwinner SoCs
 	   - ZTE's zx2967 family
+	   - SiFive FU740 SoCs
 
 config RESET_STM32MP157
 	bool "STM32MP157 Reset Driver" if COMPILE_TEST
-- 
2.31.1

