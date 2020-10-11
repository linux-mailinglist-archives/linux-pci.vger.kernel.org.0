Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5891828A822
	for <lists+linux-pci@lfdr.de>; Sun, 11 Oct 2020 18:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387857AbgJKQBE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 11 Oct 2020 12:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387795AbgJKQA5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 11 Oct 2020 12:00:57 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B263C0613CE;
        Sun, 11 Oct 2020 09:00:57 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id g4so14421234edk.0;
        Sun, 11 Oct 2020 09:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ojZEEFZxPZdtQ6sKcaMcjwoEmjziAPcwY6V8YAUtJKs=;
        b=PTPJLlCrZXDDuvOY1iLLrY2DoEGTx8sKUPh8r9p7ykK5HoohGu+aqBBPPmFWVku7fv
         /oAcxhTLx8WNg0GgF0Z5GbpacNhx9GXyfGFNChtRmnlfLIVYDMIyvIXql784AuO3amNm
         7YQvv6ug18+fNP2GHPr1UM6m79PYxaIGOOCG/pEwEhpBPgNZ3W6sUM3k13SKB+bh2eJT
         YW+WgvdIyDOe+9Div9ZDByq38ndtygCEOtaiHvkofq4gkK5xuFZ/ltrT5stDNk/cTPAx
         xWcNv1Mwp+2+Ej5pHzCZpWvkv7alqnz7EbNpVwXOK9xibx80J69dAth7QbolIVSHRBz3
         Hafg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ojZEEFZxPZdtQ6sKcaMcjwoEmjziAPcwY6V8YAUtJKs=;
        b=GlLyGQuJrB0nVypvqW8yJZyBc6azqYgwRI6gh6sooOMZLPFnJ8K/jwGrufB72yH4HN
         4dZeyj4uGViRikJzEWOBw6VViqiGYMV/q/LHzUZuK3t/Jr1kBojLe5saF1Tqxl/2kite
         0M1PNwKZS1yqvSxMwdkTe0jRad9Yb3eiIxl8/hx+ya+JQUXREmgV6zplMHhg1Jmam4Bp
         TqfeactW/EWNVmZsrYTUAPQRNNJtenvZS39/94ACjasALTwqND290LRHz40wSTQ/2KuH
         aLiezmvq6QjPiZmPvhCqS6yQLXYdSjA1vbGd5nSIxZ3qrKl9AnamAlvyn+2aCHHbK9/k
         eKdQ==
X-Gm-Message-State: AOAM533hn20/7PlkW2EYAsqcvq5hWRORe2t6iG+iYVD5XK7H1lnbUCLU
        n5dGsmtbA2boDVDrNb1Iwk23BHFunmF3VQ==
X-Google-Smtp-Source: ABdhPJw+h/LuFfLxIxWHqh9Hw2MZsfCAER/Osm8sx39pS9hmvRHwl1RJP3y30z9++sq8/QCc78iM6g==
X-Received: by 2002:a50:d7d8:: with SMTP id m24mr9595870edj.388.1602432055435;
        Sun, 11 Oct 2020 09:00:55 -0700 (PDT)
Received: from localhost.localdomain (ip-89-176-112-137.net.upcbroadband.cz. [89.176.112.137])
        by smtp.gmail.com with ESMTPSA id rn10sm9254004ejb.8.2020.10.11.09.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2020 09:00:53 -0700 (PDT)
From:   marek.vasut@gmail.com
To:     linux-pci@vger.kernel.org
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH V3] PCI: rcar: Add L1 link state fix into data abort hook
Date:   Sun, 11 Oct 2020 18:00:45 +0200
Message-Id: <20201011160045.574323-1-marek.vasut@gmail.com>
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
---
 drivers/pci/controller/pcie-rcar-host.c | 76 +++++++++++++++++++++++++
 drivers/pci/controller/pcie-rcar.h      |  7 +++
 2 files changed, 83 insertions(+)

diff --git a/drivers/pci/controller/pcie-rcar-host.c b/drivers/pci/controller/pcie-rcar-host.c
index cdc0963f154e..6311e2bac04e 100644
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
+static const struct of_device_id rcar_pcie_abort_handler_of_match[] = {
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

