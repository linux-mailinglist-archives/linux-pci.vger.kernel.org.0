Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B095B27ED3C
	for <lists+linux-pci@lfdr.de>; Wed, 30 Sep 2020 17:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725372AbgI3Pgi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Sep 2020 11:36:38 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:47590 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728107AbgI3Pgf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Sep 2020 11:36:35 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08UFaMTc076620;
        Wed, 30 Sep 2020 10:36:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601480182;
        bh=nm506Ttw75QB9g3i8XfbJHgDWMXVATaPs9Pwq9jcU6c=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=tvJRjhiAM3L4lSy3Z8hJ3xTt4PQOMTrDS8BBsnoMWsyAzbwxm/qZtu6TjLIPY6K/L
         PJr4A57ETq7zSQ9NRZ8g9kv84xZB79uHt6IZVtvyRR2ZkB6QqtjpQBgQmLFrjz1RMc
         oDTI6t/UZa5KbHYtKwKfkkgmYFR6XbcRNJ671L/s=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08UFaMOw024460
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 30 Sep 2020 10:36:22 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 30
 Sep 2020 10:36:22 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 30 Sep 2020 10:36:22 -0500
Received: from a0393678-ssd.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08UFZLZX033254;
        Wed, 30 Sep 2020 10:36:17 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Tom Joseph <tjoseph@cadence.com>, Rob Herring <robh@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-ntb@googlegroups.com>
Subject: [PATCH v7 08/18] PCI: endpoint: Add pci_epc_ops to map MSI irq
Date:   Wed, 30 Sep 2020 21:05:09 +0530
Message-ID: <20200930153519.7282-9-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200930153519.7282-1-kishon@ti.com>
References: <20200930153519.7282-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add pci_epc_ops to map physical address to MSI address and return MSI
data. The physical address is an address in the outbound region. This is
required to implement doorbell functionality of NTB (non transparent
bridge) wherein EPC on either side of the interface (primary and
secondary) can directly write to the physical address (in outbound
region) of the other interface to ring doorbell using MSI.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/endpoint/pci-epc-core.c | 41 +++++++++++++++++++++++++++++
 include/linux/pci-epc.h             |  8 ++++++
 2 files changed, 49 insertions(+)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 3693eca5b030..cc8f9eb2b177 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -230,6 +230,47 @@ int pci_epc_raise_irq(struct pci_epc *epc, u8 func_no,
 }
 EXPORT_SYMBOL_GPL(pci_epc_raise_irq);
 
+/**
+ * pci_epc_map_msi_irq() - Map physical address to MSI address and return
+ *                         MSI data
+ * @epc: the EPC device which has the MSI capability
+ * @func_no: the physical endpoint function number in the EPC device
+ * @phys_addr: the physical address of the outbound region
+ * @interrupt_num: the MSI interrupt number
+ * @entry_size: Size of Outbound address region for each interrupt
+ * @msi_data: the data that should be written in order to raise MSI interrupt
+ *            with interrupt number as 'interrupt num'
+ * @msi_addr_offset: Offset of MSI address from the aligned outbound address
+ *                   to which the MSI address is mapped
+ *
+ * Invoke to map physical address to MSI address and return MSI data. The
+ * physical address should be an address in the outbound region. This is
+ * required to implement doorbell functionality of NTB wherein EPC on either
+ * side of the interface (primary and secondary) can directly write to the
+ * physical address (in outbound region) of the other interface to ring
+ * doorbell.
+ */
+int pci_epc_map_msi_irq(struct pci_epc *epc, u8 func_no, phys_addr_t phys_addr,
+			u8 interrupt_num, u32 entry_size, u32 *msi_data,
+			u32 *msi_addr_offset)
+{
+	int ret;
+
+	if (IS_ERR_OR_NULL(epc))
+		return -EINVAL;
+
+	if (!epc->ops->map_msi_irq)
+		return -EINVAL;
+
+	mutex_lock(&epc->lock);
+	ret = epc->ops->map_msi_irq(epc, func_no, phys_addr, interrupt_num,
+				    entry_size, msi_data, msi_addr_offset);
+	mutex_unlock(&epc->lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pci_epc_map_msi_irq);
+
 /**
  * pci_epc_get_msi() - get the number of MSI interrupt numbers allocated
  * @epc: the EPC device to which MSI interrupts was requested
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index d9cb3944fb87..b82c9b100e97 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -55,6 +55,7 @@ pci_epc_interface_string(enum pci_epc_interface_type type)
  * @get_msix: ops to get the number of MSI-X interrupts allocated by the RC
  *	     from the MSI-X capability register
  * @raise_irq: ops to raise a legacy, MSI or MSI-X interrupt
+ * @map_msi_irq: ops to map physical address to MSI address and return MSI data
  * @start: ops to start the PCI link
  * @stop: ops to stop the PCI link
  * @owner: the module owner containing the ops
@@ -77,6 +78,10 @@ struct pci_epc_ops {
 	int	(*get_msix)(struct pci_epc *epc, u8 func_no);
 	int	(*raise_irq)(struct pci_epc *epc, u8 func_no,
 			     enum pci_epc_irq_type type, u16 interrupt_num);
+	int	(*map_msi_irq)(struct pci_epc *epc, u8 func_no,
+			       phys_addr_t phys_addr, u8 interrupt_num,
+			       u32 entry_size, u32 *msi_data,
+			       u32 *msi_addr_offset);
 	int	(*start)(struct pci_epc *epc);
 	void	(*stop)(struct pci_epc *epc);
 	const struct pci_epc_features* (*get_features)(struct pci_epc *epc,
@@ -216,6 +221,9 @@ int pci_epc_get_msi(struct pci_epc *epc, u8 func_no);
 int pci_epc_set_msix(struct pci_epc *epc, u8 func_no, u16 interrupts,
 		     enum pci_barno, u32 offset);
 int pci_epc_get_msix(struct pci_epc *epc, u8 func_no);
+int pci_epc_map_msi_irq(struct pci_epc *epc, u8 func_no,
+			phys_addr_t phys_addr, u8 interrupt_num,
+			u32 entry_size, u32 *msi_data, u32 *msi_addr_offset);
 int pci_epc_raise_irq(struct pci_epc *epc, u8 func_no,
 		      enum pci_epc_irq_type type, u16 interrupt_num);
 int pci_epc_start(struct pci_epc *epc);
-- 
2.17.1

