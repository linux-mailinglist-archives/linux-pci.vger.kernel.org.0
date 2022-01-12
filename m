Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CFF648C132
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jan 2022 10:43:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237055AbiALJnB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Jan 2022 04:43:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238775AbiALJm7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Jan 2022 04:42:59 -0500
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org [IPv6:2001:67c:2050:1::465:204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E88EC06173F
        for <linux-pci@vger.kernel.org>; Wed, 12 Jan 2022 01:42:59 -0800 (PST)
Received: from smtp202.mailbox.org (unknown [91.198.250.118])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4JYjKY0SpMzQlGd;
        Wed, 12 Jan 2022 10:42:57 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
From:   Stefan Roese <sr@denx.de>
To:     linux-pci@vger.kernel.org
Cc:     Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>
Subject: [RESEND PATCH v2 2/4] PCI: Add pci_check_platform_service_irqs
Date:   Wed, 12 Jan 2022 10:42:49 +0100
Message-Id: <20220112094251.1271531-2-sr@denx.de>
In-Reply-To: <20220112094251.1271531-1-sr@denx.de>
References: <20220112094251.1271531-1-sr@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>

Adding method pci_check_platform_service_irqs to check if platform
has registered method to proivde dedicated IRQ lines for PCIe services
like AER.

Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Signed-off-by: Stefan Roese <sr@denx.de>
Tested-by: Stefan Roese <sr@denx.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>
Cc: Pali Rohár <pali@kernel.org>
Cc: Michal Simek <michal.simek@xilinx.com>
---
 include/linux/pci.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 291eadade811..d6812d596ecc 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2420,6 +2420,24 @@ static inline bool pci_ari_enabled(struct pci_bus *bus)
 	return bus->self && bus->self->ari_enabled;
 }
 
+/**
+ * pci_check_platform_service_irqs - check platform service irq's
+ * @pdev: PCI Express device to check
+ * @irqs: Array of irqs to populate
+ * @mask: Bitmask of capabilities
+ */
+static inline void pci_check_platform_service_irqs(struct pci_dev *dev,
+						   int *irqs, int mask)
+{
+	struct pci_host_bridge *bridge;
+
+	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT) {
+		bridge = pci_find_host_bridge(dev->bus);
+		if (bridge && bridge->setup_platform_service_irq)
+			bridge->setup_platform_service_irq(bridge, irqs, mask);
+	}
+}
+
 /**
  * pci_is_thunderbolt_attached - whether device is on a Thunderbolt daisy chain
  * @pdev: PCI device to check
-- 
2.34.1

