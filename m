Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E39F52FAD3E
	for <lists+linux-pci@lfdr.de>; Mon, 18 Jan 2021 23:20:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbhARWUT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Jan 2021 17:20:19 -0500
Received: from mx.socionext.com ([202.248.49.38]:16086 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725892AbhARWUS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 18 Jan 2021 17:20:18 -0500
X-Greylist: delayed 580 seconds by postgrey-1.27 at vger.kernel.org; Mon, 18 Jan 2021 17:20:17 EST
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 19 Jan 2021 07:09:55 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id 776C62059027;
        Tue, 19 Jan 2021 07:09:55 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Tue, 19 Jan 2021 07:09:55 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 0BCB9B1D40;
        Tue, 19 Jan 2021 07:09:55 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Marc Zyngier <maz@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v9 1/3] PCI: portdrv: Add pcie_port_service_get_irq() function
Date:   Tue, 19 Jan 2021 07:09:43 +0900
Message-Id: <1611007785-25771-2-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1611007785-25771-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1611007785-25771-1-git-send-email-hayashi.kunihiko@socionext.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add pcie_port_service_get_irq() that returns the virtual IRQ number
for specified portdrv service.

Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
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
index e1fed664..b60f0f3 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -477,6 +477,22 @@ struct device *pcie_port_find_device(struct pci_dev *dev,
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

