Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1817E267C8D
	for <lists+linux-pci@lfdr.de>; Sat, 12 Sep 2020 23:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725888AbgILVTR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 12 Sep 2020 17:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbgILVTP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 12 Sep 2020 17:19:15 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 906B9C061573;
        Sat, 12 Sep 2020 14:19:14 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id q13so18026778ejo.9;
        Sat, 12 Sep 2020 14:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bNSX1gfKdUAbUKYqBunUmPmG+GR2nDo8zNHaxK4Z+hE=;
        b=m4lAqeqvfRzCfi9MNfg2VTeiKcsW+Pf/eAMSleoGMx939veXQfEN3p/GqjeU9M+ARr
         dlIll77Cjy1ZxAb4FlarsWiVXC5/tEtdLmd/JMPYA4ssNJi8OwU+u9EuTs+Hbl/NY+kf
         3Ieoc6MTnQHqkpEHqrpIVqTDgu6D63f7uA6h8qL88k7iVdv/rYnrRSCXMnLxyyR/uvu9
         Xz5l0DxT/WXyB3K/Ofr3pvr2jvG27Ek0bqGtBS51p5voZBXOFtFW1nl8sva4HnsendAb
         dWoofbRr7Vmyjz+51PhOdHzCStJt/YwKW1Mhg49JMaCzzo/EPIanGsycuIx6mHF9b97m
         IPQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bNSX1gfKdUAbUKYqBunUmPmG+GR2nDo8zNHaxK4Z+hE=;
        b=MmSDyIjqs7WnwIV3ppIefKxWT/QFvhb1yZCbRrUM/uO6bfuksVzbGquZC3MQWIEP+a
         oy3aWNqTAD9dyMqjS2ITS109tHXQP5+sbu4ul2/opZhHeB0OuknECnxoTenL3gPqPB/9
         ecq8fqcJJsEZuJj/DGPOekeLdjLJlMXFNtMirpQqvf6laoPrKGMhUaNbTjmwvS+moxDr
         LM8wHf6Lem3At6GRXYNW8zLPuPFO3Xzn7bpjwG9IXGEgjnULagFJ1kc7k54g1Zk6sjke
         SFsI763yToAQIYeeDWfVJsXuyz/wQRxYmH2KfDtGj7VrfgZk6GsoCHNheVt70jPs4tno
         MC4g==
X-Gm-Message-State: AOAM532Ol/M1JYM7+u+AkDTbjAiUbRBcp/bxg5lRoQjdcqPwJ8cJ4W3U
        Rnv9krliiFS5y9OTQ2IGnMKdMPDcrsc=
X-Google-Smtp-Source: ABdhPJxOXfEep7TKm9+o8/WofHfPBwWmScczLLvTdT1r9nkM1fiiGb+tafqPJegSoCSSjngU+H+P4Q==
X-Received: by 2002:a17:906:c55:: with SMTP id t21mr7765097ejf.276.1599945552658;
        Sat, 12 Sep 2020 14:19:12 -0700 (PDT)
Received: from desktop.lan (ip-89-176-112-137.net.upcbroadband.cz. [89.176.112.137])
        by smtp.gmail.com with ESMTPSA id h13sm3959008ejl.77.2020.09.12.14.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2020 14:19:11 -0700 (PDT)
From:   marek.vasut@gmail.com
To:     linux-pci@vger.kernel.org
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH] PCI: rcar: Add L1 link state fix into data abort hook
Date:   Sat, 12 Sep 2020 23:18:53 +0200
Message-Id: <20200912211853.15321-1-marek.vasut@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
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
the Aarch64 R-Car perform the same fixup in TFA, see TFA commit
0969397f2 ("rcar_gen3: plat: Prevent PCIe hang during L1X config access")

Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: linux-renesas-soc@vger.kernel.org
---
 drivers/pci/controller/pcie-rcar-host.c | 58 +++++++++++++++++++++++++
 drivers/pci/controller/pcie-rcar.h      |  7 +++
 2 files changed, 65 insertions(+)

diff --git a/drivers/pci/controller/pcie-rcar-host.c b/drivers/pci/controller/pcie-rcar-host.c
index cdc0963f154e..949de5b2d699 100644
--- a/drivers/pci/controller/pcie-rcar-host.c
+++ b/drivers/pci/controller/pcie-rcar-host.c
@@ -42,6 +42,16 @@ struct rcar_msi {
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
+#endif
+
 static inline struct rcar_msi *to_rcar_msi(struct msi_controller *chip)
 {
 	return container_of(chip, struct rcar_msi, chip);
@@ -804,6 +814,11 @@ static int rcar_pcie_get_resources(struct rcar_pcie_host *host)
 	}
 	host->msi.irq2 = i;
 
+#ifdef CONFIG_ARM
+	/* Cache static copy for L1 link state fixup hook on aarch32 */
+	pcie_base = pcie->base;
+#endif
+
 	return 0;
 
 err_irq2:
@@ -1050,4 +1065,47 @@ static struct platform_driver rcar_pcie_driver = {
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
+	/*
+	 * Since probe() can be deferred we need to make sure that
+	 * hook_fault_code is not called after __init memory is freed
+	 * by kernel and since rcar_pcie_abort_handler() is a no-op,
+	 * we can install the handler here without risking it
+	 * accessing some uninitialized driver state.
+	 */
+	hook_fault_code(16 + 6, rcar_pcie_aarch32_abort_handler, SIGBUS, 0,
+			"imprecise external abort");
+
+	return platform_driver_register(&rcar_pcie_driver);
+}
+device_initcall(rcar_pcie_init);
+#else
 builtin_platform_driver(rcar_pcie_driver);
+#endif
diff --git a/drivers/pci/controller/pcie-rcar.h b/drivers/pci/controller/pcie-rcar.h
index d4c698b5f821..73269296ae05 100644
--- a/drivers/pci/controller/pcie-rcar.h
+++ b/drivers/pci/controller/pcie-rcar.h
@@ -85,6 +85,13 @@
 #define  LTSMDIS		BIT(31)
 #define  MACCTLR_INIT_VAL	(LTSMDIS | MACCTLR_NFTS_MASK)
 #define PMSR			0x01105c
+#define  L1FAEG			BIT(31)
+#define  PMEL1RX		BIT(23)
+#define  PMSTATE		GENMASK(18, 16)
+#define  PMSTATE_L1		GENMASK(17, 16)
+#define PMCTLR			0x011060
+#define  L1IATN			BIT(31)
+
 #define MACS2R			0x011078
 #define MACCGSPSETR		0x011084
 #define  SPCNGRSN		BIT(31)
-- 
2.28.0

