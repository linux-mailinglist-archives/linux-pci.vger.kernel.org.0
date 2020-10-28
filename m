Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ACF729D55E
	for <lists+linux-pci@lfdr.de>; Wed, 28 Oct 2020 23:01:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729413AbgJ1WAW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Oct 2020 18:00:22 -0400
Received: from mx.socionext.com ([202.248.49.38]:49815 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729415AbgJ1WAT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Oct 2020 18:00:19 -0400
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 28 Oct 2020 10:31:55 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 7ED43180C13;
        Wed, 28 Oct 2020 10:31:55 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Wed, 28 Oct 2020 10:31:55 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
        by kinkan.css.socionext.com (Postfix) with ESMTP id D6F721A0509;
        Wed, 28 Oct 2020 10:31:54 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Marc Zyngier <maz@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v8 1/3] PCI: portdrv: Add pcie_port_service_get_irq() function
Date:   Wed, 28 Oct 2020 10:31:41 +0900
Message-Id: <1603848703-21099-2-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1603848703-21099-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1603848703-21099-1-git-send-email-hayashi.kunihiko@socionext.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add pcie_port_service_get_irq() that returns the virtual IRQ number
for specified portdrv service.

Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/pcie/portdrv.h      |  1 +
 drivers/pci/pcie/portdrv_core.c | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
index af7cf23..e256456 100644
--- a/drivers/pci/pcie/portdrv.h
+++ b/drivers/pci/pcie/portdrv.h
@@ -150,4 +150,5 @@ static inline void pcie_pme_interrupt_enable(struct pci_dev *dev, bool en) {}
 #endif /* !CONFIG_PCIE_PME */
 
 struct device *pcie_port_find_device(struct pci_dev *dev, u32 service);
+int pcie_port_service_get_irq(struct pci_dev *dev, u32 service);
 #endif /* _PORTDRV_H_ */
diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index 50a9522..f92daf8 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -480,6 +480,22 @@ struct device *pcie_port_find_device(struct pci_dev *dev,
 }
 EXPORT_SYMBOL_GPL(pcie_port_find_device);
 
+/*
+ * pcie_port_service_get_irq - get irq of the service
+ * @dev: PCI Express port the service is associated with
+ * @service: For the service to find
+ *
+ * Get irq number associated with given service on a pci_dev
+ */
+int pcie_port_service_get_irq(struct pci_dev *dev, u32 service)
+{
+	struct pcie_device *pciedev;
+
+	pciedev = to_pcie_device(pcie_port_find_device(dev, service));
+
+	return pciedev->irq;
+}
+
 /**
  * pcie_port_device_remove - unregister PCI Express port service devices
  * @dev: PCI Express port the service devices to unregister are associated with
-- 
2.7.4

