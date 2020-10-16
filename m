Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1D382904B2
	for <lists+linux-pci@lfdr.de>; Fri, 16 Oct 2020 14:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407165AbgJPMEZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Oct 2020 08:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407120AbgJPMEZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Oct 2020 08:04:25 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916D2C061755;
        Fri, 16 Oct 2020 05:04:24 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id 33so2012491edq.13;
        Fri, 16 Oct 2020 05:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zaCJ25l7/97enfYnqktJQjgM2SQ4V7BUUEsNCe9nlhs=;
        b=TXkO2EbmYJhn+phbdTwmtSKvbZhMDGgT4AY3xYUE2b87OmxY5wqdgd8sVXcE02uQcT
         YmbfyijE6xGxCU5BXQXwUFyYZ0xcDRn6UAln2RthSgzwgosk43LZCe0TFGCSSwbw1taS
         K0EqmNFBTZteY5TxbBkM9KV8mJXm6ucX4Flg9XmJ7wfGl+443AVYptWGeKd2CcGMZrJW
         Y537wfPX/3/AaxnptB9V2btANFvGj9rh7xCWYv+ssl/y/Qf9A16mklB1D+LG49ghMOvy
         awvrGVPDGUYf9XpAYwaheEuPqc8BkS1YVJqXZa9DM/jYS/8tdDdURW9MmMCItZuPTV/T
         kmuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zaCJ25l7/97enfYnqktJQjgM2SQ4V7BUUEsNCe9nlhs=;
        b=Uz9a1iGeesunp1zj0jR3QYrh/v3mRpAOKU10nYEN1cQHp6hi327LlTPu+JHLGTqXd7
         d0gZaB6CH/489RyNWSYpnxaG/TGiqeVCXAoM9gu5DNfrR7poLT546T3Md3uS+KOGnz9B
         jdN7p2JjA3ue5wbMPiTEkzstfICIp7OVB8ynGnjKWEKHN2a+gBM64bS3j3BHIFrxZwMR
         /jrtn3tIH2poAhI8DMFi7qCShLPVgkoiEoyEdVhDz6hS3kC5moN2XtVSiBQv12sDMlY/
         muJeSC7Nc4cuo9L8vE8lAPZiQwpN9LfYvnit5xr0smgmzpNRxr91O2L8ex0mvJqcBZ+F
         Oh5A==
X-Gm-Message-State: AOAM530PbRiEZs/8jk4/3ke/y/y3DevpwFMiNbD7KejvrAiJbOQKViBp
        d5nZLsMEy/RE/qf0BVzNrrHH9ioiAzrixA==
X-Google-Smtp-Source: ABdhPJxWV9VWmhEwjMecIr1rglVfg6Xi7Z5QXZK5nJIfGab0gfWmwPWqy7SkKBkqd19KPWsttjYm7g==
X-Received: by 2002:aa7:c442:: with SMTP id n2mr3388004edr.309.1602849862871;
        Fri, 16 Oct 2020 05:04:22 -0700 (PDT)
Received: from localhost.localdomain (ip-89-176-112-137.net.upcbroadband.cz. [89.176.112.137])
        by smtp.gmail.com with ESMTPSA id j24sm1473214ejf.21.2020.10.16.05.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 05:04:22 -0700 (PDT)
From:   marek.vasut@gmail.com
To:     linux-pci@vger.kernel.org
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH V4] PCI: rcar: Add L1 link state fix into data abort hook
Date:   Fri, 16 Oct 2020 14:04:16 +0200
Message-Id: <20201016120416.7008-1-marek.vasut@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Marek Vasut <marek.vasut+renesas@gmail.com>

The R-Car PCIe controller is capable of handling L0s/L1 link states.
While the controller can enter and exit L0s link state, and exit L1
link state, without any additional action from the driver, to enter
L1 link state, the driver must complete the link state transition by
issuing additional commands to the controller.

The problem is, this transition is not atomic. The controller sets
PMEL1RX bit in PMSR register upon reception of PM_ENTER_L1 DLLP from
the PCIe card, but then the controller enters some sort of inbetween
state. The driver must detect this condition and complete the link
state transition, by setting L1IATN bit in PMCTLR and waiting for
the link state transition to complete.

If a PCIe access happens inside this window, where the controller
is between L0 and L1 link states, the access generates a fault and
the ARM 'imprecise external abort' handler is invoked.

Just like other PCI controller drivers, here we hook the fault handler,
perform the fixup to help the controller enter L1 link state, and then
restart the instruction which triggered the fault. Since the controller
is in L1 link state now, the link can exit from L1 link state to L0 and
successfully complete the access.

Note that this fixup is applicable only to Aarch32 R-Car controllers,
the Aarch64 R-Car perform the same fixup in TFA, see TFA commit [1]
0969397f2 ("rcar_gen3: plat: Prevent PCIe hang during L1X config access")
[1] https://github.com/ARM-software/arm-trusted-firmware/commit/0969397f295621aa26b3d14b76dd397d22be58bf

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
---
 drivers/pci/controller/pcie-rcar-host.c | 76 +++++++++++++++++++++++++
 drivers/pci/controller/pcie-rcar.h      |  7 +++
 2 files changed, 83 insertions(+)

diff --git a/drivers/pci/controller/pcie-rcar-host.c b/drivers/pci/controller/pcie-rcar-host.c
index cdc0963f154e..1194d5f3341b 100644
--- a/drivers/pci/controller/pcie-rcar-host.c
+++ b/drivers/pci/controller/pcie-rcar-host.c
@@ -13,6 +13,7 @@
 
 #include <linux/bitops.h>
 #include <linux/clk.h>
+#include <linux/clk-provider.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
@@ -42,6 +43,21 @@ struct rcar_msi {
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
 static inline struct rcar_msi *to_rcar_msi(struct msi_controller *chip)
 {
 	return container_of(chip, struct rcar_msi, chip);
@@ -804,6 +820,12 @@ static int rcar_pcie_get_resources(struct rcar_pcie_host *host)
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
@@ -1050,4 +1072,58 @@ static struct platform_driver rcar_pcie_driver = {
 	},
 	.probe = rcar_pcie_probe,
 };
+
+#ifdef CONFIG_ARM
+static int rcar_pcie_aarch32_abort_handler(unsigned long addr,
+		unsigned int fsr, struct pt_regs *regs)
+{
+	u32 pmsr;
+
+	if (!pcie_base || !__clk_is_enabled(pcie_bus_clk))
+		return 1;
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
+		while (!(readl(pcie_base + PMSR) & L1FAEG))
+			;
+		writel(L1FAEG | PMEL1RX, pcie_base + PMSR);
+		return 0;
+	}
+
+	return 1;
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
2.28.0

