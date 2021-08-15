Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B954E3ECA86
	for <lists+linux-pci@lfdr.de>; Sun, 15 Aug 2021 20:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbhHOSRb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 15 Aug 2021 14:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbhHOSRa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 15 Aug 2021 14:17:30 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67DB9C061764;
        Sun, 15 Aug 2021 11:17:00 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id u15so10202960wmj.1;
        Sun, 15 Aug 2021 11:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ux9pO3x1hQSBE99kyI1heGrozy/mYbOjhQCAwbGOSnQ=;
        b=T6ACtUucC/yMoe2azdeZ6bmt/HKhJlQltpLW+PkTRxUqoPxLfE0gZOnU8oepuUqHLS
         oRNKqw56/31d54TfpAfMp8zsTAYHFz90rgzKoLMnXw22Fysre4FPab9zs88ftEDPfOJl
         P5mjWN3n7LPdYx94ekatCAsLGIBXFTONT5zywXP56rhtQXBJF3awHBr57BT//6fwXXGZ
         +B0lNYIBoboOQ3o9ZoDoQNDLLWohQJxmLdp93qRquvi3ksSvmU+bnfxNPyqYL3leZD6I
         bp/CvnNCLIpj6jtkPethGMzTzaHt3p6mFCXoS4LNkHnZpguSmHWF0ndLnD8r3zF5Eieu
         MGUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ux9pO3x1hQSBE99kyI1heGrozy/mYbOjhQCAwbGOSnQ=;
        b=EqrpIJxB7tWcDwzK2wl38ZpvFOCobKnm3LYOod9mkGbGLCn2JD/F0NYZz768CqDMTy
         GFQ2YTUROMxknCtgEzbiic1W8oTQiI+uqmMYdd4wfR9l9AH9wNBYFt/VN/sJu2In83Ev
         pLvUIQX4LFCudWYgvGosPbsH8ug1yDUWCDfXs5akHpXaA4wXbpmjCq4KKymOHk09aJEN
         VlBgmm0bGTmEW3tRTosRpQWJPvce2M1iZsPWlgkxqTM9i4v3LKVi04WGxJEZ9yTRoE6E
         RwqieDdbI72a2reIdmjkvUh27fBbfpoZIU2LElJpgw53IaKLrbNlDqnqsnNcbjAmq6cd
         Md1Q==
X-Gm-Message-State: AOAM5320pRMSbWq/zsnvpQizEGkopaveSKKvAT/kafGHQ6CVxpb0qcP7
        UQrdhHcq0MxK2WJWoFudjKcaKoGvwQGBiA==
X-Google-Smtp-Source: ABdhPJwnlhc4uisPrMvFKz0bmp/H98d4kVoXUSMPVx2VfjQcV14wVhAngFlBKzgn7mkTlN+8NV3vbA==
X-Received: by 2002:a7b:ca56:: with SMTP id m22mr11499176wml.16.1629051418908;
        Sun, 15 Aug 2021 11:16:58 -0700 (PDT)
Received: from tr.lan (ip-89-176-112-137.net.upcbroadband.cz. [89.176.112.137])
        by smtp.gmail.com with ESMTPSA id i9sm11167501wre.36.2021.08.15.11.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Aug 2021 11:16:58 -0700 (PDT)
From:   marek.vasut@gmail.com
To:     linux-pci@vger.kernel.org
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH V7] PCI: rcar: Add L1 link state fix into data abort hook
Date:   Sun, 15 Aug 2021 20:16:50 +0200
Message-Id: <20210815181650.132579-1-marek.vasut@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Marek Vasut <marek.vasut+renesas@gmail.com>

When the link is in L1, hardware should return it to L0
automatically whenever a transaction targets a component on the
other end of the link (PCIe r5.0, sec 5.2).

The R-Car PCIe controller doesn't handle this transition correctly.
If the link is not in L0, an MMIO transaction targeting a downstream
device fails, and the controller reports an ARM imprecise external
abort.

Work around this by hooking the abort handler so the driver can
detect this situation and help the hardware complete the link state
transition.

When the R-Car controller receives a PM_ENTER_L1 DLLP from the
downstream component, it sets PMEL1RX bit in PMSR register, but then
the controller enters some sort of in-between state.  A subsequent
MMIO transaction will fail, resulting in the external abort.  The
abort handler detects this condition and completes the link state
transition by setting the L1IATN bit in PMCTLR and waiting for the
link state transition to complete.

Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: linux-renesas-soc@vger.kernel.org
---
V2: - Update commit message, add link to TFA repository commit
    - Handle the LPAE case as in ARM fault.c and fsr-{2,3}level.c
    - Cache clock and check whether they are enabled before register
      access
V3: - Fix commit message according to spellchecker
    - Use of_find_matching_node() to apply hook only on Gen1 and Gen2 RCar
      (in case the kernel is multiplatform)
V4: - Mark rcar_pcie_abort_handler_of_match with __initconst
V5: - Add mutex around rcar_pcie_aarch32_abort_handler()
    - Update commit message again to point out issues with L1/D3Hot states
V6: - Return 1 only if condition cannot be fixed
V7: - Replace commit message by one provided by upstream, verbatim
    - Use readl_poll_timeout_atomic() to poll for L1FAEG bit with timeout
---
 drivers/pci/controller/pcie-rcar-host.c | 86 +++++++++++++++++++++++++
 drivers/pci/controller/pcie-rcar.h      |  7 ++
 2 files changed, 93 insertions(+)

diff --git a/drivers/pci/controller/pcie-rcar-host.c b/drivers/pci/controller/pcie-rcar-host.c
index 00a8267eda14..8f3131844e77 100644
--- a/drivers/pci/controller/pcie-rcar-host.c
+++ b/drivers/pci/controller/pcie-rcar-host.c
@@ -13,12 +13,14 @@
 
 #include <linux/bitops.h>
 #include <linux/clk.h>
+#include <linux/clk-provider.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/iopoll.h>
 #include <linux/msi.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
@@ -41,6 +43,21 @@ struct rcar_msi {
 	int irq2;
 };
 
+#ifdef CONFIG_ARM
+/*
+ * Here we keep a static copy of the remapped PCIe controller address.
+ * This is only used on aarch32 systems, all of which have one single
+ * PCIe controller, to provide quick access to the PCIe controller in
+ * the L1 link state fixup function, called from the ARM fault handler.
+ */
+static void __iomem *pcie_base;
+/*
+ * Static copy of bus clock pointer, so we can check whether the clock
+ * is enabled or not.
+ */
+static struct clk *pcie_bus_clk;
+#endif
+
 /* Structure representing the PCIe interface */
 struct rcar_pcie_host {
 	struct rcar_pcie	pcie;
@@ -774,6 +791,12 @@ static int rcar_pcie_get_resources(struct rcar_pcie_host *host)
 	}
 	host->msi.irq2 = i;
 
+#ifdef CONFIG_ARM
+	/* Cache static copy for L1 link state fixup hook on aarch32 */
+	pcie_base = pcie->base;
+	pcie_bus_clk = host->bus_clk;
+#endif
+
 	return 0;
 
 err_irq2:
@@ -1029,4 +1052,67 @@ static struct platform_driver rcar_pcie_driver = {
 	},
 	.probe = rcar_pcie_probe,
 };
+
+#ifdef CONFIG_ARM
+static DEFINE_SPINLOCK(pmsr_lock);
+static int rcar_pcie_aarch32_abort_handler(unsigned long addr,
+		unsigned int fsr, struct pt_regs *regs)
+{
+	unsigned long flags;
+	u32 pmsr, val;
+	int ret = 0;
+
+	spin_lock_irqsave(&pmsr_lock, flags);
+
+	if (!pcie_base || !__clk_is_enabled(pcie_bus_clk)) {
+		ret = 1;
+		goto unlock_exit;
+	}
+
+	pmsr = readl(pcie_base + PMSR);
+
+	/*
+	 * Test if the PCIe controller received PM_ENTER_L1 DLLP and
+	 * the PCIe controller is not in L1 link state. If true, apply
+	 * fix, which will put the controller into L1 link state, from
+	 * which it can return to L0s/L0 on its own.
+	 */
+	if ((pmsr & PMEL1RX) && ((pmsr & PMSTATE) != PMSTATE_L1)) {
+		writel(L1IATN, pcie_base + PMCTLR);
+		ret = readl_poll_timeout_atomic(pcie_base + PMSR, val,
+						val & L1FAEG, 10, 1000);
+		WARN(ret, "Timeout waiting for L1 link state, ret=%d\n", ret);
+		writel(L1FAEG | PMEL1RX, pcie_base + PMSR);
+	}
+
+unlock_exit:
+	spin_unlock_irqrestore(&pmsr_lock, flags);
+	return ret;
+}
+
+static const struct of_device_id rcar_pcie_abort_handler_of_match[] __initconst = {
+	{ .compatible = "renesas,pcie-r8a7779" },
+	{ .compatible = "renesas,pcie-r8a7790" },
+	{ .compatible = "renesas,pcie-r8a7791" },
+	{ .compatible = "renesas,pcie-rcar-gen2" },
+	{},
+};
+
+static int __init rcar_pcie_init(void)
+{
+	if (of_find_matching_node(NULL, rcar_pcie_abort_handler_of_match)) {
+#ifdef CONFIG_ARM_LPAE
+		hook_fault_code(17, rcar_pcie_aarch32_abort_handler, SIGBUS, 0,
+				"asynchronous external abort");
+#else
+		hook_fault_code(22, rcar_pcie_aarch32_abort_handler, SIGBUS, 0,
+				"imprecise external abort");
+#endif
+	}
+
+	return platform_driver_register(&rcar_pcie_driver);
+}
+device_initcall(rcar_pcie_init);
+#else
 builtin_platform_driver(rcar_pcie_driver);
+#endif
diff --git a/drivers/pci/controller/pcie-rcar.h b/drivers/pci/controller/pcie-rcar.h
index d4c698b5f821..9bb125db85c6 100644
--- a/drivers/pci/controller/pcie-rcar.h
+++ b/drivers/pci/controller/pcie-rcar.h
@@ -85,6 +85,13 @@
 #define  LTSMDIS		BIT(31)
 #define  MACCTLR_INIT_VAL	(LTSMDIS | MACCTLR_NFTS_MASK)
 #define PMSR			0x01105c
+#define  L1FAEG			BIT(31)
+#define  PMEL1RX		BIT(23)
+#define  PMSTATE		GENMASK(18, 16)
+#define  PMSTATE_L1		(3 << 16)
+#define PMCTLR			0x011060
+#define  L1IATN			BIT(31)
+
 #define MACS2R			0x011078
 #define MACCGSPSETR		0x011084
 #define  SPCNGRSN		BIT(31)
-- 
2.30.2

