Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5C12381160
	for <lists+linux-pci@lfdr.de>; Fri, 14 May 2021 22:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbhENUHT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 May 2021 16:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231841AbhENUHS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 May 2021 16:07:18 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76685C061574;
        Fri, 14 May 2021 13:06:05 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id df21so8740830edb.3;
        Fri, 14 May 2021 13:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BiGIBtdVws30LoLfAG6IIDlptJZEWM6VqDfkKAesSQM=;
        b=WfAkctE+foUXBOJs/LBNeZkpmxWOr8ArhpFjN2qN2gzTQas2GUJzltv90oivb7Bg0p
         HY4risKbU/SXZrdRODfSE7nA128Jx9jv802eDeqRQcRmopcNwYDwbAmzL4deSxQC4zeq
         kzss8o/7BrHpTVOCoeABiWpi2JHQ+LxXGhP4oQucuFgl/DgQ8ojQRJveOEtzrj//rOz+
         KjaLHtEhqaxQ9c2zIWreiDq3Vx2wtxPpXCk8/YlOCpGPfU9bRtyQUkQaSgTf50yUsllH
         CZjgRtRzouKiJ52qJBf3gC3j8bMf4bcpSfGs+3R6YjDBUQXM0qAxyl6O9W+M5EW4zaZb
         i3dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BiGIBtdVws30LoLfAG6IIDlptJZEWM6VqDfkKAesSQM=;
        b=mrBOrIEZs5h7ELFCaJJ5aoJ0ZPF3Kyxk9ipcKjdHgHkTB4UVDfEtEReq+GLSWWfgmx
         q9YgoLA+yEUNEE5yOsb61gpPe/iUHj2wcCflWRmFI0oS1Iqqt/3ZfbbPjh4+j2YNbgQ5
         MUw1AJoV8Pc+UTGdsnNOpqStlEqsHW1oR0SumyDdvyKpVxsR7BfDDHcLlaHHoAAK61Uk
         XOaSnOYrTasGAhG0tNXe/xFf/Tg4YvqHBhPZEUB7hCj/6xR/kH2gBK+yfNaETiyuvIGk
         BLx/UA5gAgj6bqxBji5vJlMTwTJ0wHFq36o1YVa3DQvyA/yGFG3c2mjNSdTP9XsEbjyx
         s2tA==
X-Gm-Message-State: AOAM53370p77aZkkL1MwbVg1gZu9iwzmkG1vsvRBAXOPeJSAYwSqWOLa
        LOkVldFsEJxOfuyvYSnjmCr+93vFEzs=
X-Google-Smtp-Source: ABdhPJyGqdpU8scKEWNlwo5xC12pJf1WI8qgudSG+5uXpnvE/qYeRYAeJW2e8Jvn8iMNVJ/n7suDTQ==
X-Received: by 2002:a05:6402:31b1:: with SMTP id dj17mr57609575edb.7.1621022764259;
        Fri, 14 May 2021 13:06:04 -0700 (PDT)
Received: from tr.lan (ip-89-176-112-137.net.upcbroadband.cz. [89.176.112.137])
        by smtp.gmail.com with ESMTPSA id o8sm4068556ejm.18.2021.05.14.13.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 13:06:03 -0700 (PDT)
From:   marek.vasut@gmail.com
To:     linux-pci@vger.kernel.org
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH V6] PCI: rcar: Add L1 link state fix into data abort hook
Date:   Fri, 14 May 2021 22:05:49 +0200
Message-Id: <20210514200549.431275-1-marek.vasut@gmail.com>
X-Mailer: git-send-email 2.30.2
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

While it was suggested to disable L1 link state support completely on
the controller level, this would not prevent the L1 link state entry
initiated by the link partner. This happens e.g. in case a PCIe card
enters D3Hot state, which could be initiated from pci_set_power_state()
if the card indicates D3Hot support, which in turn means link must enter
L1 state. So instead, fix up the L1 link state after all.

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
V5: - Add mutex around rcar_pcie_aarch32_abort_handler()
    - Update commit message again to point out issues with L1/D3Hot states
V6: - Return 1 only if condition cannot be fixed
---
 drivers/pci/controller/pcie-rcar-host.c | 84 +++++++++++++++++++++++++
 drivers/pci/controller/pcie-rcar.h      |  7 +++
 2 files changed, 91 insertions(+)

diff --git a/drivers/pci/controller/pcie-rcar-host.c b/drivers/pci/controller/pcie-rcar-host.c
index 765cf2b45e24..0d3f8dc5ff8a 100644
--- a/drivers/pci/controller/pcie-rcar-host.c
+++ b/drivers/pci/controller/pcie-rcar-host.c
@@ -13,6 +13,7 @@
 
 #include <linux/bitops.h>
 #include <linux/clk.h>
+#include <linux/clk-provider.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
@@ -41,6 +42,21 @@ struct rcar_msi {
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
@@ -776,6 +792,12 @@ static int rcar_pcie_get_resources(struct rcar_pcie_host *host)
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
@@ -1031,4 +1053,66 @@ static struct platform_driver rcar_pcie_driver = {
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
+	int ret = 0;
+	u32 pmsr;
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
+		while (!(readl(pcie_base + PMSR) & L1FAEG))
+			;
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

