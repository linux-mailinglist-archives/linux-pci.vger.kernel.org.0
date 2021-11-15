Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 993384515FA
	for <lists+linux-pci@lfdr.de>; Mon, 15 Nov 2021 22:02:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352403AbhKOVFE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Nov 2021 16:05:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353306AbhKOUzg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Nov 2021 15:55:36 -0500
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE12C079791;
        Mon, 15 Nov 2021 12:46:51 -0800 (PST)
Received: from tr.lan (ip-89-176-112-137.net.upcbroadband.cz [89.176.112.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id CF311831E9;
        Mon, 15 Nov 2021 21:46:47 +0100 (CET)
From:   marek.vasut@gmail.com
To:     linux-pci@vger.kernel.org
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Randy Dunlap <rdunlap@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH v4] PCI: rcar: Check if device is runtime suspended instead of __clk_is_enabled()
Date:   Mon, 15 Nov 2021 21:46:41 +0100
Message-Id: <20211115204641.12941-1-marek.vasut@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.2 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Marek Vasut <marek.vasut+renesas@gmail.com>

Replace __clk_is_enabled() with pm_runtime_suspended(),
as __clk_is_enabled() was checking the wrong bus clock
and caused the following build error too:
  arm-linux-gnueabi-ld: drivers/pci/controller/pcie-rcar-host.o: in function `rcar_pcie_aarch32_abort_handler':
  pcie-rcar-host.c:(.text+0xdd0): undefined reference to `__clk_is_enabled'

Fixes: a115b1bd3af0 ("PCI: rcar: Add L1 link state fix into data abort hook")
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: linux-renesas-soc@vger.kernel.org
---
V2: Drop the __clk_is_enabled(), like it was done already in V1 of
    a115b1bd3af0 ("PCI: rcar: Add L1 link state fix into data abort hook")
V3: Use pm_runtime_suspended() instead of __clk_is_enabled()
V4: Rework the commit message
---
 drivers/pci/controller/pcie-rcar-host.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/pcie-rcar-host.c b/drivers/pci/controller/pcie-rcar-host.c
index e12c2d8be05a..138592e22600 100644
--- a/drivers/pci/controller/pcie-rcar-host.c
+++ b/drivers/pci/controller/pcie-rcar-host.c
@@ -50,10 +50,10 @@ struct rcar_msi {
  */
 static void __iomem *pcie_base;
 /*
- * Static copy of bus clock pointer, so we can check whether the clock
- * is enabled or not.
+ * Static copy of pcie device pointer, so we can check whether the
+ * device is runtime suspended or not.
  */
-static struct clk *pcie_bus_clk;
+static struct device *pcie_dev;
 #endif
 
 /* Structure representing the PCIe interface */
@@ -792,7 +792,7 @@ static int rcar_pcie_get_resources(struct rcar_pcie_host *host)
 #ifdef CONFIG_ARM
 	/* Cache static copy for L1 link state fixup hook on aarch32 */
 	pcie_base = pcie->base;
-	pcie_bus_clk = host->bus_clk;
+	pcie_dev = pcie->dev;
 #endif
 
 	return 0;
@@ -1062,7 +1062,7 @@ static int rcar_pcie_aarch32_abort_handler(unsigned long addr,
 
 	spin_lock_irqsave(&pmsr_lock, flags);
 
-	if (!pcie_base || !__clk_is_enabled(pcie_bus_clk)) {
+	if (!pcie_base || pm_runtime_suspended(pcie_dev)) {
 		ret = 1;
 		goto unlock_exit;
 	}
-- 
2.33.0

