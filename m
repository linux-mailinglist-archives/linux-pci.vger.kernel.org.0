Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F09F54A2BA3
	for <lists+linux-pci@lfdr.de>; Sat, 29 Jan 2022 05:39:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352373AbiA2EjE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Jan 2022 23:39:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352374AbiA2EjB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Jan 2022 23:39:01 -0500
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 006FEC061714;
        Fri, 28 Jan 2022 20:39:00 -0800 (PST)
Received: from tr.lan (ip-89-176-112-137.net.upcbroadband.cz [89.176.112.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 16916820AE;
        Sat, 29 Jan 2022 05:38:56 +0100 (CET)
From:   marek.vasut@gmail.com
To:     linux-pci@vger.kernel.org
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH v4 1/2] PCI: rcar: Finish transition to L1 state in rcar_pcie_config_access()
Date:   Sat, 29 Jan 2022 05:38:36 +0100
Message-Id: <20220129043837.172126-1-marek.vasut@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.5 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Marek Vasut <marek.vasut+renesas@gmail.com>

In case the controller is transitioning to L1 in rcar_pcie_config_access(),
any read/write access to PCIECDR triggers asynchronous external abort. This
is because the transition to L1 link state must be manually finished by the
driver. The PCIe IP can transition back from L1 state to L0 on its own.

Avoid triggering the abort in rcar_pcie_config_access() by checking whether
the controller is in the transition state, and if so, finish the transition
right away. This prevents a lot of unnecessary exceptions, although not all
of them.

Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Krzysztof Wilczyński <kw@linux.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: linux-renesas-soc@vger.kernel.org
---
V2: Pull DEFINE_SPINLOCK(pmsr_lock) and rcar_pcie_wakeup() out of ifdef(CONFIG_ARM),
    since this change is applicable even on arm64
V3: - Convert non-zero return value from rcar_pcie_wakeup() in either
      PCIBIOS_SET_FAILED in rcar_pcie_config_access(), or, 1 in
      rcar_pcie_aarch32_abort_handler().
    - Set error response using PCI_SET_ERROR_RESPONSE() in
      rcar_pcie_config_access()
    - Fix double spinlock unlock in rcar_pcie_aarch32_abort_handler().
V4: No change
---
 drivers/pci/controller/pcie-rcar-host.c | 76 +++++++++++++++----------
 1 file changed, 45 insertions(+), 31 deletions(-)

diff --git a/drivers/pci/controller/pcie-rcar-host.c b/drivers/pci/controller/pcie-rcar-host.c
index 38b6e02edfa9..7d38a9c50093 100644
--- a/drivers/pci/controller/pcie-rcar-host.c
+++ b/drivers/pci/controller/pcie-rcar-host.c
@@ -65,6 +65,42 @@ struct rcar_pcie_host {
 	int			(*phy_init_fn)(struct rcar_pcie_host *host);
 };
 
+static DEFINE_SPINLOCK(pmsr_lock);
+
+static int rcar_pcie_wakeup(struct device *pcie_dev, void __iomem *pcie_base)
+{
+	unsigned long flags;
+	u32 pmsr, val;
+	int ret = 0;
+
+	spin_lock_irqsave(&pmsr_lock, flags);
+
+	if (!pcie_base || pm_runtime_suspended(pcie_dev)) {
+		ret = -EINVAL;
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
 static struct rcar_pcie_host *msi_to_host(struct rcar_msi *msi)
 {
 	return container_of(msi, struct rcar_pcie_host, msi);
@@ -85,6 +121,14 @@ static int rcar_pcie_config_access(struct rcar_pcie_host *host,
 {
 	struct rcar_pcie *pcie = &host->pcie;
 	unsigned int dev, func, reg, index;
+	int ret;
+
+	/* Wake the bus up in case it is in L1 state. */
+	ret = rcar_pcie_wakeup(pcie->dev, pcie->base);
+	if (ret) {
+		PCI_SET_ERROR_RESPONSE(data);
+		return PCIBIOS_SET_FAILED;
+	}
 
 	dev = PCI_SLOT(devfn);
 	func = PCI_FUNC(devfn);
@@ -1050,40 +1094,10 @@ static struct platform_driver rcar_pcie_driver = {
 };
 
 #ifdef CONFIG_ARM
-static DEFINE_SPINLOCK(pmsr_lock);
 static int rcar_pcie_aarch32_abort_handler(unsigned long addr,
 		unsigned int fsr, struct pt_regs *regs)
 {
-	unsigned long flags;
-	u32 pmsr, val;
-	int ret = 0;
-
-	spin_lock_irqsave(&pmsr_lock, flags);
-
-	if (!pcie_base || pm_runtime_suspended(pcie_dev)) {
-		ret = 1;
-		goto unlock_exit;
-	}
-
-	pmsr = readl(pcie_base + PMSR);
-
-	/*
-	 * Test if the PCIe controller received PM_ENTER_L1 DLLP and
-	 * the PCIe controller is not in L1 link state. If true, apply
-	 * fix, which will put the controller into L1 link state, from
-	 * which it can return to L0s/L0 on its own.
-	 */
-	if ((pmsr & PMEL1RX) && ((pmsr & PMSTATE) != PMSTATE_L1)) {
-		writel(L1IATN, pcie_base + PMCTLR);
-		ret = readl_poll_timeout_atomic(pcie_base + PMSR, val,
-						val & L1FAEG, 10, 1000);
-		WARN(ret, "Timeout waiting for L1 link state, ret=%d\n", ret);
-		writel(L1FAEG | PMEL1RX, pcie_base + PMSR);
-	}
-
-unlock_exit:
-	spin_unlock_irqrestore(&pmsr_lock, flags);
-	return ret;
+	return !!rcar_pcie_wakeup(pcie_dev, pcie_base);
 }
 
 static const struct of_device_id rcar_pcie_abort_handler_of_match[] __initconst = {
-- 
2.34.1

