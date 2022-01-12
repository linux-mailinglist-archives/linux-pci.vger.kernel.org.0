Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BEB548C133
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jan 2022 10:43:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346463AbiALJnC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Jan 2022 04:43:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346466AbiALJnA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Jan 2022 04:43:00 -0500
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org [IPv6:2001:67c:2050:1::465:107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40029C061756
        for <linux-pci@vger.kernel.org>; Wed, 12 Jan 2022 01:43:00 -0800 (PST)
Received: from smtp202.mailbox.org (unknown [91.198.250.118])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4JYjKZ3dCTzQl7q;
        Wed, 12 Jan 2022 10:42:58 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
From:   Stefan Roese <sr@denx.de>
To:     linux-pci@vger.kernel.org
Cc:     Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>
Subject: [RESEND PATCH v2 4/4] PCI: xilinx-nwl: Add method to setup_platform_service_irq hook
Date:   Wed, 12 Jan 2022 10:42:51 +0100
Message-Id: <20220112094251.1271531-4-sr@denx.de>
In-Reply-To: <20220112094251.1271531-1-sr@denx.de>
References: <20220112094251.1271531-1-sr@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>

Add nwl_setup_service_irqs hook to setup_platform_service_irq to
register platform provided IRQ number to kernel AER service.

Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Signed-off-by: Stefan Roese <sr@denx.de>
Tested-by: Stefan Roese <sr@denx.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>
Cc: Pali Rohár <pali@kernel.org>
Cc: Michal Simek <michal.simek@xilinx.com>
---
 drivers/pci/controller/pcie-xilinx-nwl.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c b/drivers/pci/controller/pcie-xilinx-nwl.c
index 414b679175b3..4969f35db7e5 100644
--- a/drivers/pci/controller/pcie-xilinx-nwl.c
+++ b/drivers/pci/controller/pcie-xilinx-nwl.c
@@ -24,6 +24,7 @@
 #include <linux/irqchip/chained_irq.h>
 
 #include "../pci.h"
+#include "../pcie/portdrv.h"
 
 /* Bridge core config registers */
 #define BRCFG_PCIE_RX0			0x00000000
@@ -806,6 +807,16 @@ static int nwl_pcie_parse_dt(struct nwl_pcie *pcie,
 	return 0;
 }
 
+static void nwl_setup_service_irqs(struct pci_host_bridge *bridge, int *irqs,
+				   int plat_mask)
+{
+	struct nwl_pcie *pcie;
+
+	pcie = pci_host_bridge_priv(bridge);
+	if (plat_mask & PCIE_PORT_SERVICE_AER)
+		irqs[PCIE_PORT_SERVICE_AER_SHIFT] = pcie->irq_misc;
+}
+
 static const struct of_device_id nwl_pcie_of_match[] = {
 	{ .compatible = "xlnx,nwl-pcie-2.11", },
 	{}
@@ -857,6 +868,7 @@ static int nwl_pcie_probe(struct platform_device *pdev)
 
 	bridge->sysdata = pcie;
 	bridge->ops = &nwl_pcie_ops;
+	bridge->setup_platform_service_irq = nwl_setup_service_irqs;
 
 	if (IS_ENABLED(CONFIG_PCI_MSI)) {
 		err = nwl_pcie_enable_msi(pcie);
-- 
2.34.1

