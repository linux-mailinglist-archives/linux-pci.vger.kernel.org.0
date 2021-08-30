Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 820063FB258
	for <lists+linux-pci@lfdr.de>; Mon, 30 Aug 2021 10:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234732AbhH3IWL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Aug 2021 04:22:11 -0400
Received: from thoth.sbs.de ([192.35.17.2]:54694 "EHLO thoth.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233318AbhH3IWK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 30 Aug 2021 04:22:10 -0400
X-Greylist: delayed 777 seconds by postgrey-1.27 at vger.kernel.org; Mon, 30 Aug 2021 04:22:09 EDT
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id 17U88BLP018646
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Aug 2021 10:08:11 +0200
Received: from [167.87.2.75] ([167.87.2.75])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 17U88AWF007376;
        Mon, 30 Aug 2021 10:08:11 +0200
From:   Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH v2] PCI/portdrv: Do not setup up IRQs if there are no users
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <8f9a13ac-8ab1-15ac-06cb-c131b488a36f@siemens.com>
Date:   Mon, 30 Aug 2021 10:08:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Jan Kiszka <jan.kiszka@siemens.com>

Avoid registering service IRQs if there is no service that offers them
or no driver to register a handler against them. This saves IRQ vectors
when they are limited (e.g. on x86) and also avoids that spurious events
could hit a missing handler. Such spurious events need to be generated
by the Jailhouse hypervisor for active MSI vectors when enabling or
disabling itself.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Changes in v2:
 - move initialization of irqs to address test bot finding

 drivers/pci/pcie/portdrv_core.c | 47 +++++++++++++++++++++------------
 1 file changed, 30 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index e1fed6649c41..0e2556269429 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -166,9 +166,6 @@ static int pcie_init_service_irqs(struct pci_dev *dev, int *irqs, int mask)
 {
 	int ret, i;
 
-	for (i = 0; i < PCIE_PORT_DEVICE_MAXSERVICES; i++)
-		irqs[i] = -1;
-
 	/*
 	 * If we support PME but can't use MSI/MSI-X for it, we have to
 	 * fall back to INTx or other interrupts, e.g., a system shared
@@ -312,8 +309,10 @@ static int pcie_device_init(struct pci_dev *pdev, int service, int irq)
  */
 int pcie_port_device_register(struct pci_dev *dev)
 {
-	int status, capabilities, i, nr_service;
-	int irqs[PCIE_PORT_DEVICE_MAXSERVICES];
+	int status, capabilities, irq_services, i, nr_service;
+	int irqs[PCIE_PORT_DEVICE_MAXSERVICES] = {
+		[0 ... PCIE_PORT_DEVICE_MAXSERVICES-1] = -1
+	};
 
 	/* Enable PCI Express port device */
 	status = pci_enable_device(dev);
@@ -326,18 +325,32 @@ int pcie_port_device_register(struct pci_dev *dev)
 		return 0;
 
 	pci_set_master(dev);
-	/*
-	 * Initialize service irqs. Don't use service devices that
-	 * require interrupts if there is no way to generate them.
-	 * However, some drivers may have a polling mode (e.g. pciehp_poll_mode)
-	 * that can be used in the absence of irqs.  Allow them to determine
-	 * if that is to be used.
-	 */
-	status = pcie_init_service_irqs(dev, irqs, capabilities);
-	if (status) {
-		capabilities &= PCIE_PORT_SERVICE_HP;
-		if (!capabilities)
-			goto error_disable;
+
+	irq_services = 0;
+	if (IS_ENABLED(CONFIG_PCIE_PME))
+		irq_services |= PCIE_PORT_SERVICE_PME;
+	if (IS_ENABLED(CONFIG_PCIEAER))
+		irq_services |= PCIE_PORT_SERVICE_AER;
+	if (IS_ENABLED(CONFIG_HOTPLUG_PCI_PCIE))
+		irq_services |= PCIE_PORT_SERVICE_HP;
+	if (IS_ENABLED(CONFIG_PCIE_DPC))
+		irq_services |= PCIE_PORT_SERVICE_DPC;
+	irq_services &= capabilities;
+
+	if (irq_services) {
+		/*
+		 * Initialize service irqs. Don't use service devices that
+		 * require interrupts if there is no way to generate them.
+		 * However, some drivers may have a polling mode (e.g.
+		 * pciehp_poll_mode) that can be used in the absence of irqs.
+		 * Allow them to determine if that is to be used.
+		 */
+		status = pcie_init_service_irqs(dev, irqs, irq_services);
+		if (status) {
+			irq_services &= PCIE_PORT_SERVICE_HP;
+			if (!irq_services)
+				goto error_disable;
+		}
 	}
 
 	/* Allocate child services if any */
-- 
2.31.1
