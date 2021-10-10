Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 258904283FB
	for <lists+linux-pci@lfdr.de>; Mon, 11 Oct 2021 00:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbhJJWJW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 10 Oct 2021 18:09:22 -0400
Received: from phobos.denx.de ([85.214.62.61]:53144 "EHLO phobos.denx.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230364AbhJJWJW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 10 Oct 2021 18:09:22 -0400
Received: from tr.lan (ip-89-176-112-137.net.upcbroadband.cz [89.176.112.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 5D14A832DE;
        Mon, 11 Oct 2021 00:07:20 +0200 (CEST)
From:   marek.vasut@gmail.com
To:     linux-pci@vger.kernel.org
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH v2] PCI: rcar: Remove __clk_is_enabled() call
Date:   Mon, 11 Oct 2021 00:06:58 +0200
Message-Id: <20211010220658.873504-1-marek.vasut@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.2 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Marek Vasut <marek.vasut+renesas@gmail.com>

Remove __clk_is_enabled() call, otherwise the following build error occurs:
  arm-linux-gnueabi-ld: drivers/pci/controller/pcie-rcar-host.o: in function `rcar_pcie_aarch32_abort_handler':
  pcie-rcar-host.c:(.text+0xdd0): undefined reference to `__clk_is_enabled'
This should be OK, since the bus clock are always enabled in probe() of the driver.

Fixes: a115b1bd3af0 ("PCI: rcar: Add L1 link state fix into data abort hook")
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
---
 drivers/pci/controller/pcie-rcar-host.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/pci/controller/pcie-rcar-host.c b/drivers/pci/controller/pcie-rcar-host.c
index 8f3131844e77..e3b7bf250e36 100644
--- a/drivers/pci/controller/pcie-rcar-host.c
+++ b/drivers/pci/controller/pcie-rcar-host.c
@@ -51,11 +51,6 @@ struct rcar_msi {
  * the L1 link state fixup function, called from the ARM fault handler.
  */
 static void __iomem *pcie_base;
-/*
- * Static copy of bus clock pointer, so we can check whether the clock
- * is enabled or not.
- */
-static struct clk *pcie_bus_clk;
 #endif
 
 /* Structure representing the PCIe interface */
@@ -794,7 +789,6 @@ static int rcar_pcie_get_resources(struct rcar_pcie_host *host)
 #ifdef CONFIG_ARM
 	/* Cache static copy for L1 link state fixup hook on aarch32 */
 	pcie_base = pcie->base;
-	pcie_bus_clk = host->bus_clk;
 #endif
 
 	return 0;
@@ -1064,7 +1058,7 @@ static int rcar_pcie_aarch32_abort_handler(unsigned long addr,
 
 	spin_lock_irqsave(&pmsr_lock, flags);
 
-	if (!pcie_base || !__clk_is_enabled(pcie_bus_clk)) {
+	if (!pcie_base) {
 		ret = 1;
 		goto unlock_exit;
 	}
-- 
2.33.0

