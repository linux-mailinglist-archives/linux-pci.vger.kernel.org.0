Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4381ADDEC
	for <lists+linux-pci@lfdr.de>; Fri, 17 Apr 2020 15:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730621AbgDQM7X (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Apr 2020 08:59:23 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:48970 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730166AbgDQM6m (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Apr 2020 08:58:42 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 03HCwGmN005383;
        Fri, 17 Apr 2020 07:58:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1587128296;
        bh=sgBGIYRfoiDyZ7UK78LuKRyCyWuLA2e8tBK1sp6YkcI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=WMfCm9mgHvpmcx9hERP/+7ycAFYMbTz+lLHJu3XeDmlhypxIZyciP93fnm041Uppp
         UauNOh418PD96iNNL4+iZSvtgPztbaBggDARa0SFfzhQNvCSCgWzv5NfQ7ghx2PmL+
         EKCk8SGIuMykzf/pUE1rVCyP4W9BqA+CgrbsaCeY=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 03HCwGuT051592;
        Fri, 17 Apr 2020 07:58:16 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 17
 Apr 2020 07:58:15 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 17 Apr 2020 07:58:15 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 03HCvsDA031089;
        Fri, 17 Apr 2020 07:58:12 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Tom Joseph <tjoseph@cadence.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 05/14] PCI: cadence: Add read/write accessors to perform only 32-bit accesses
Date:   Fri, 17 Apr 2020 18:27:44 +0530
Message-ID: <20200417125753.13021-6-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200417125753.13021-1-kishon@ti.com>
References: <20200417125753.13021-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Certain platforms like TI's J721E allow only 32-bit register accesses.
Add read and write accessors to perform only 32-bit accesses in order to
support platforms like TI's J721E.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/cadence/pcie-cadence.c | 40 +++++++++++++++++++
 drivers/pci/controller/cadence/pcie-cadence.h |  2 +
 2 files changed, 42 insertions(+)

diff --git a/drivers/pci/controller/cadence/pcie-cadence.c b/drivers/pci/controller/cadence/pcie-cadence.c
index cd795f6fc1e2..874b7fa93577 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.c
+++ b/drivers/pci/controller/cadence/pcie-cadence.c
@@ -7,6 +7,46 @@
 
 #include "pcie-cadence.h"
 
+u32 cdns_platform_pcie_read32(void __iomem *addr, int size)
+{
+	void __iomem *aligned_addr = PTR_ALIGN_DOWN(addr, 0x4);
+	unsigned int offset = (unsigned long)addr & 0x3;
+	u32 val = readl(aligned_addr);
+
+	if (!IS_ALIGNED((uintptr_t)addr, size)) {
+		WARN(1, "Address %p and size %d are not aligned\n", addr, size);
+		return 0;
+	}
+
+	if (size > 2)
+		return val;
+
+	return (val >> (8 * offset)) & ((1 << (size * 8)) - 1);
+}
+
+void cdns_platform_pcie_write32(void __iomem *addr, int size, u32 value)
+{
+	void __iomem *aligned_addr = PTR_ALIGN_DOWN(addr, 0x4);
+	unsigned int offset = (unsigned long)addr & 0x3;
+	u32 mask;
+	u32 val;
+
+	if (!IS_ALIGNED((uintptr_t)addr, size)) {
+		WARN(1, "Address %p and size %d are not aligned\n", addr, size);
+		return;
+	}
+
+	if (size > 2) {
+		writel(value, addr);
+		return;
+	}
+
+	mask = ~(((1 << (size * 8)) - 1) << (offset * 8));
+	val = readl(aligned_addr) & mask;
+	val |= value << (offset * 8);
+	writel(val, aligned_addr);
+}
+
 void cdns_pcie_set_outbound_region(struct cdns_pcie *pcie, u8 fn,
 				   u32 r, bool is_io,
 				   u64 cpu_addr, u64 pci_addr, size_t size)
diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
index a6c4816b68c0..03c21ce4c9e9 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.h
+++ b/drivers/pci/controller/cadence/pcie-cadence.h
@@ -503,6 +503,8 @@ void cdns_pcie_reset_outbound_region(struct cdns_pcie *pcie, u32 r);
 void cdns_pcie_disable_phy(struct cdns_pcie *pcie);
 int cdns_pcie_enable_phy(struct cdns_pcie *pcie);
 int cdns_pcie_init_phy(struct device *dev, struct cdns_pcie *pcie);
+u32 cdns_platform_pcie_read32(void __iomem *addr, int size);
+void cdns_platform_pcie_write32(void __iomem *addr, int size, u32 value);
 extern const struct dev_pm_ops cdns_pcie_pm_ops;
 
 #endif /* _PCIE_CADENCE_H */
-- 
2.17.1

