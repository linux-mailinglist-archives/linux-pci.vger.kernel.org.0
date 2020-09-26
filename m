Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F996279A97
	for <lists+linux-pci@lfdr.de>; Sat, 26 Sep 2020 18:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729740AbgIZQJq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 26 Sep 2020 12:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729448AbgIZQJq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 26 Sep 2020 12:09:46 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 101E7C0613CE;
        Sat, 26 Sep 2020 09:09:46 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id e23so2704349eja.3;
        Sat, 26 Sep 2020 09:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S9aQwc+PCXsFhcBP9B3buLgLm5i11ItqWdopFn2Q6u8=;
        b=mJz3H0Pc++vE/5/LLlbAUiaNAFhfEM4af+bwy7gxpM3JPo0j7Bidn6BRAvFjj/BWkH
         74MwBEvv9DS0XYGM1wnGhQ/gAbf9pIDa9F0RerBbFf7xCkW9gwcSj36qSQ/mKSiFQu03
         ewrqsec9BBaz6lk7aFs+7iXPx3L9SrxMffg8M2DW6ZxFU2sz0BbEOFOBK+O3aT0lVxa+
         3OedArQPmmmqxngK1vhOuF6LVBCFgbQo0xueUisSqXSaGbtgvSHpUICaFx4/Ai47Dp3o
         p/BRQZMjNKamCJjTWb8ZYzEFsZSSVR4wbjQXwzD71AFuMbCIVbFerkStSM4zY14yu0oZ
         Kvww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S9aQwc+PCXsFhcBP9B3buLgLm5i11ItqWdopFn2Q6u8=;
        b=bxHhSikkHJ8tSFsYxusLWmwULQVQymGgfd4kfQZ2R1/mXDjzuAcijV1ApCFclNZr7Y
         YI9hHOzGYBxi1xtAWGnsWI9jopXj1zwFMpr0wsUlC6/xUsUB63uYmp4Hi+XRNheeP6Q+
         u57o/hKmsxeRBux9DsyrgP1u0Gf2Al9JhP38Lc9ConGHx3vdY/FzSkgvjn5/wSEmS+EW
         y6teMGet6V2eW8dn3WMOAlsrBF7nqlBggaxTc3sc8GWDqgwu0tQp+ZySBLvZbCpDsH4n
         Hsl14PUI08yV0kDo8Jt9YFC7Ly4idlXKlatOs+XUMV2EH9lgwN9j1MjBpEDoxIoDkWDa
         Xz6Q==
X-Gm-Message-State: AOAM532g/phqmtVPVROX6m5a+EoiqgAjoYopdwBQ7iOIlrGN9d3RzEdI
        xcnS1ccqwb2BjoWF0lAspGNlkWioxF40ww==
X-Google-Smtp-Source: ABdhPJyVC2laUx2EzaRwyPizJ9IaoVs9J2Z56SkJZthNfHAcZHd0butvaxYPmy6iPYrNM0VWVAMtEg==
X-Received: by 2002:a17:906:7f0b:: with SMTP id d11mr8208853ejr.439.1601136584421;
        Sat, 26 Sep 2020 09:09:44 -0700 (PDT)
Received: from desktop.lan (ip-89-176-112-137.net.upcbroadband.cz. [89.176.112.137])
        by smtp.gmail.com with ESMTPSA id c11sm4608899edu.44.2020.09.26.09.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2020 09:09:43 -0700 (PDT)
From:   marek.vasut@gmail.com
To:     linux-pci@vger.kernel.org
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH V2] PCI: rcar: Add L1 link state fix into data abort hook
Date:   Sat, 26 Sep 2020 18:09:34 +0200
Message-Id: <20200926160934.136182-1-marek.vasut@gmail.com>
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

If a PCIe access happens inside of this window, where the controller
is inbetween L0 and L1 link states, the access generates a fault and
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
---
 drivers/pci/controller/pcie-rcar-host.c | 65 +++++++++++++++++++++++++
 drivers/pci/controller/pcie-rcar.h      |  7 +++
 2 files changed, 72 insertions(+)

diff --git a/drivers/pci/controller/pcie-rcar-host.c b/drivers/pci/controller/pcie-rcar-host.c
index cdc0963f154e..f8ff8c55716a 100644
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
+ * the L1 link state fixup function, called from ARM fault handler.
+ */
+static void __iomem *pcie_base;
+/*
+ * Static copy of bus clock pointer, so we can check whether the clock
+ * are enabled or not.
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
@@ -1050,4 +1072,47 @@ static struct platform_driver rcar_pcie_driver = {
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
+	if (!pcie_base || !pcie_bus_clk || !__clk_is_enabled(pcie_bus_clk))
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
+static int __init rcar_pcie_init(void)
+{
+#ifdef CONFIG_ARM_LPAE
+	hook_fault_code(17, rcar_pcie_aarch32_abort_handler, SIGBUS, 0,
+			"asynchronous external abort");
+#else
+	hook_fault_code(22, rcar_pcie_aarch32_abort_handler, SIGBUS, 0,
+			"imprecise external abort");
+#endif
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

