Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15F6B48E51B
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jan 2022 08:59:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234239AbiANH6l (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Jan 2022 02:58:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiANH6l (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Jan 2022 02:58:41 -0500
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org [IPv6:2001:67c:2050:1::465:107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF5BFC061574
        for <linux-pci@vger.kernel.org>; Thu, 13 Jan 2022 23:58:40 -0800 (PST)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:105:465:1:4:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4JZtwH1b95zQkd0;
        Fri, 14 Jan 2022 08:58:39 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
From:   Stefan Roese <sr@denx.de>
To:     linux-pci@vger.kernel.org
Cc:     Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH v4 1/2] PCI/portdrv: Add option to setup IRQs for platform-specific Service Errors
Date:   Fri, 14 Jan 2022 08:58:33 +0100
Message-Id: <20220114075834.1938409-2-sr@denx.de>
In-Reply-To: <20220114075834.1938409-1-sr@denx.de>
References: <20220114075834.1938409-1-sr@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>

As per section 6.2.4.1.2, 6.2.6 in PCIe r4.0 (and later versions),
platform-specific System Errors like AER can be delivered via platform-
specific interrupt lines.

This patch adds the init_platform_service_irqs() hook to struct
pci_host_bridge, making it possible that platforms may implement this
function to hook IRQs for these platform-specific System Errors, like
AER.

If these platform-specific service IRQs have been successfully
installed via pcie_init_platform_service_irqs(),
pcie_init_service_irqs() is skipped.

Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Signed-off-by: Stefan Roese <sr@denx.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>
Cc: Pali Rohár <pali@kernel.org>
Cc: Michal Simek <michal.simek@xilinx.com>
---
 drivers/pci/pcie/portdrv_core.c | 39 ++++++++++++++++++++++++++++++++-
 include/linux/pci.h             |  2 ++
 2 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index e7dcb1f23210..27b990cedb4c 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -190,6 +190,31 @@ static int pcie_init_service_irqs(struct pci_dev *dev, int *irqs, int mask)
 	return 0;
 }
 
+/**
+ * pcie_init_platform_service_irqs - initialize platform service irqs for
+ * platform-specific System Errors
+ * @dev: PCI Express port to handle
+ * @irqs: Array of irqs to populate
+ * @mask: Bitmask of capabilities
+ *
+ * Return value: -ENODEV, in case no platform-specific IRQ is available
+ */
+static int pcie_init_platform_service_irqs(struct pci_dev *dev,
+					   int *irqs, int mask)
+{
+	struct pci_host_bridge *bridge;
+
+	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT) {
+		bridge = pci_find_host_bridge(dev->bus);
+		if (bridge && bridge->init_platform_service_irqs) {
+			return bridge->init_platform_service_irqs(dev, irqs,
+								  mask);
+		}
+	}
+
+	return -ENODEV;
+}
+
 /**
  * get_port_device_capability - discover capabilities of a PCI Express port
  * @dev: PCI Express port to examine
@@ -335,7 +360,19 @@ int pcie_port_device_register(struct pci_dev *dev)
 		irq_services |= PCIE_PORT_SERVICE_DPC;
 	irq_services &= capabilities;
 
-	if (irq_services) {
+	/*
+	 * Some platforms have dedicated interrupts from root complex to
+	 * interrupt controller for PCIe platform-specific System Errors
+	 * like AER/PME etc., check if the platform registered with any such
+	 * IRQ.
+	 */
+	status = pcie_init_platform_service_irqs(dev, irqs, capabilities);
+
+	/*
+	 * Only install service irqs, when the platform-specific hook was
+	 * unsuccessful
+	 */
+	if (irq_services && status) {
 		/*
 		 * Initialize service IRQs. Don't use service devices that
 		 * require interrupts if there is no way to generate them.
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 18a75c8e615c..fb8aad3cb460 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -554,6 +554,8 @@ struct pci_host_bridge {
 	u8 (*swizzle_irq)(struct pci_dev *, u8 *); /* Platform IRQ swizzler */
 	int (*map_irq)(const struct pci_dev *, u8, u8);
 	void (*release_fn)(struct pci_host_bridge *);
+	int (*init_platform_service_irqs)(struct pci_dev *dev, int *irqs,
+					  int plat_mask);
 	void		*release_data;
 	unsigned int	ignore_reset_delay:1;	/* For entire hierarchy */
 	unsigned int	no_ext_tags:1;		/* No Extended Tags */
-- 
2.34.1

