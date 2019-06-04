Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26572347FE
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jun 2019 15:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727577AbfFDNRu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Jun 2019 09:17:50 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:50334 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727149AbfFDNRt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Jun 2019 09:17:49 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x54DHOCZ082297;
        Tue, 4 Jun 2019 08:17:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1559654244;
        bh=r7Ei7rsj5lX30OaH2FuRyDzaWU4cllou71wNl6pyjGU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=LSVcOA+Yvgp5r4q37wsXmkUbV/VfLRgfiNv3EB13v74k4jJgbghcsXk7Gnb59nUyf
         jSgBO6w/fIVnaXDF1mZkeFCQcxOtdDnsWypr0fkDmTYMDir+xvtwJ6WCRweqfrkiJy
         cZC3MNhpjHt2TvSlI8WXEamLJPJiycennA//lZtg=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x54DHOIc042670
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 4 Jun 2019 08:17:24 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 4 Jun
 2019 08:17:24 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 4 Jun 2019 08:17:24 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x54DGdGN098972;
        Tue, 4 Jun 2019 08:17:19 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Tom Joseph <tjoseph@cadence.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Jingoo Han <jingoohan1@gmail.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <linux-rockchip@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [RFC PATCH 07/30] PCI: cadence: Add read and write accessors to perform only 32-bit accesses
Date:   Tue, 4 Jun 2019 18:44:53 +0530
Message-ID: <20190604131516.13596-8-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190604131516.13596-1-kishon@ti.com>
References: <20190604131516.13596-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Certain platforms like TI's J721E allows only 32-bit register accesses.
Add read and write accessor to perform only 32-bit accesses in order to
support platfroms like TI's J721E.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/pcie-cadence.c | 40 +++++++++++++++++++++++++++
 drivers/pci/controller/pcie-cadence.h |  2 ++
 2 files changed, 42 insertions(+)

diff --git a/drivers/pci/controller/pcie-cadence.c b/drivers/pci/controller/pcie-cadence.c
index cd795f6fc1e2..de5b3b06f2d0 100644
--- a/drivers/pci/controller/pcie-cadence.c
+++ b/drivers/pci/controller/pcie-cadence.c
@@ -7,6 +7,46 @@
 
 #include "pcie-cadence.h"
 
+u32 cdns_pcie_read32(void __iomem *addr, int size)
+{
+	void __iomem *aligned_addr = PTR_ALIGN_DOWN(addr, 0x4);
+	unsigned int offset = (unsigned long)addr & 0x3;
+	u32 val = readl(aligned_addr);
+
+	if (!IS_ALIGNED((uintptr_t)addr, size)) {
+		pr_err("Invalid Address in function:%s\n", __func__);
+		return 0;
+	}
+
+	if (size > 2)
+		return val;
+
+	return (val >> (8 * offset)) & ((1 << (size * 8)) - 1);
+}
+
+void cdns_pcie_write32(void __iomem *addr, int size, u32 value)
+{
+	void __iomem *aligned_addr = PTR_ALIGN_DOWN(addr, 0x4);
+	unsigned int offset = (unsigned long)addr & 0x3;
+	u32 mask;
+	u32 val;
+
+	if (!IS_ALIGNED((uintptr_t)addr, size)) {
+		pr_err("Invalid Address in function:%s\n", __func__);
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
diff --git a/drivers/pci/controller/pcie-cadence.h b/drivers/pci/controller/pcie-cadence.h
index 0134c1b1ad65..d157bf5eabd5 100644
--- a/drivers/pci/controller/pcie-cadence.h
+++ b/drivers/pci/controller/pcie-cadence.h
@@ -406,6 +406,8 @@ void cdns_pcie_reset_outbound_region(struct cdns_pcie *pcie, u32 r);
 void cdns_pcie_disable_phy(struct cdns_pcie *pcie);
 int cdns_pcie_enable_phy(struct cdns_pcie *pcie);
 int cdns_pcie_init_phy(struct device *dev, struct cdns_pcie *pcie);
+u32 cdns_pcie_read32(void __iomem *addr, int size);
+void cdns_pcie_write32(void __iomem *addr, int size, u32 value);
 extern const struct dev_pm_ops cdns_pcie_pm_ops;
 
 #endif /* _PCIE_CADENCE_H */
-- 
2.17.1

