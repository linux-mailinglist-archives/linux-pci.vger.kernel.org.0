Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD42265C8D
	for <lists+linux-pci@lfdr.de>; Fri, 11 Sep 2020 11:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725850AbgIKJdv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Sep 2020 05:33:51 -0400
Received: from mx.socionext.com ([202.248.49.38]:30109 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbgIKJdu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 11 Sep 2020 05:33:50 -0400
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 11 Sep 2020 18:33:48 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id C35441800EE;
        Fri, 11 Sep 2020 18:33:48 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Fri, 11 Sep 2020 18:33:48 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
        by kinkan.css.socionext.com (Postfix) with ESMTP id 590FE1A0507;
        Fri, 11 Sep 2020 18:33:48 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v7 1/3] PCI: portdrv: Add pcie_port_service_get_irq() function
Date:   Fri, 11 Sep 2020 18:33:32 +0900
Message-Id: <1599816814-16515-2-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1599816814-16515-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1599816814-16515-1-git-send-email-hayashi.kunihiko@socionext.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add pcie_port_service_get_irq() that returns the virtual IRQ number
for specified portdrv service.

Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
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

