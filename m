Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D603581D2B
	for <lists+linux-pci@lfdr.de>; Wed, 27 Jul 2022 03:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbiG0Bdv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Jul 2022 21:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbiG0Bdv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 Jul 2022 21:33:51 -0400
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE5743AE74;
        Tue, 26 Jul 2022 18:33:49 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.101.196.174])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id D66123F0E1;
        Wed, 27 Jul 2022 01:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1658885628;
        bh=zAZzDf5aGoTBpAzJoH3PK3AquzA6pEp7Sdhc0ZGtT3Q=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=n08e71jppZrm/5ZH++ydry++70qnxTirBD69Wny/y3E2uHFaUroEpOAOPrqmkHq5T
         n6n9q4J2SWNsX0KlGsJbgyd3hdlrKL2rA/Yz/TwzHHnLKLbHKhGKHSELVPEPwgwcjc
         CEe1bX5+HtqkFQTK+yqmqaHiF3qWkscGAHSx5wHYcYfxqikHApXBNv1lziGhPFZOXH
         sMJM+bAIO+K4iNWktotjLWijfNVK2lcyKJMJmWbwNEFtRyVJaBkXGtIAdy3O7BhD3Q
         UzJZ6KruMm6y2tqzXO5ee2koXLAmTp1O3+Yb0VvFUkNMsJ8DlLNeTSHQmKzWr9029d
         qLBqNrLMcMXFw==
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     bhelgaas@google.com
Cc:     mika.westerberg@linux.intel.com, koba.ko@canonical.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Lukas Wunner <lukas@wunner.de>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Stuart Hayes <stuart.w.hayes@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] PCI/portdrv: Flag services when IRQ is shared with PME
Date:   Wed, 27 Jul 2022 09:32:50 +0800
Message-Id: <20220727013255.269815-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

After commit cb1f65c1e142 ("PM: s2idle: ACPI: Fix wakeup interrupts
handling"), there's a system that always gets woken up by spurious PME
event when one of the root port is put to D3cold.

'/sys/power/pm_wakeup_irq' shows 122, which is an IRQ shared between
PME, AER and DPC:
pcieport 0000:00:01.0: PME: Signaling with IRQ 122
pcieport 0000:00:01.0: AER: enabled with IRQ 122
pcieport 0000:00:01.0: DPC: enabled with IRQ 122

Disabling services one by one and the issue goes away when
PCIE_PORT_SERVICE_AER is not enabled. Following the lead, more info can
be found on resume when pci_aer_clear_status() is removed from
pci_restore_state() to print out what happened:
pcieport 0000:00:01.0: AER: Corrected error received: 0000:00:01.0
pcieport 0000:00:01.0: PCIe Bus Error: severity=Corrected, type=Physical Layer, (Receiver ID)
pcieport 0000:00:01.0:   device [8086:4c01] error status/mask=00000001/00002000
pcieport 0000:00:01.0:    [ 0] RxErr

Since the corrected AER error happens at physical layer when the root
port is transitioning to D3cold, making system be able to suspend is
more important than reporting issues like this.

So introduce a new flag to indicate when IRQ is shared with PME,
therefore AER and DPC can be suspended to prevent any spurious wakeup.
HP already has its own suspend routine so it doesn't need to use this
flag.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=216295
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/pci/pcie/portdrv.h      | 11 ++++++-----
 drivers/pci/pcie/portdrv_core.c | 21 +++++++++++++++------
 2 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
index 0ef4bf5f811d9..97a9d15638cc8 100644
--- a/drivers/pci/pcie/portdrv.h
+++ b/drivers/pci/pcie/portdrv.h
@@ -57,11 +57,12 @@ static inline int pcie_dpc_init(void) { return 0; }
 #define PCIE_ANY_PORT			(~0)
 
 struct pcie_device {
-	int		irq;	    /* Service IRQ/MSI/MSI-X Vector */
-	struct pci_dev *port;	    /* Root/Upstream/Downstream Port */
-	u32		service;    /* Port service this device represents */
-	void		*priv_data; /* Service Private Data */
-	struct device	device;     /* Generic Device Interface */
+	int		irq;	        /* Service IRQ/MSI/MSI-X Vector */
+	struct pci_dev *port;	        /* Root/Upstream/Downstream Port */
+	u32		service;        /* Port service this device represents */
+	bool		shared_pme_irq; /* Service IRQ shared with PME */
+	void		*priv_data;     /* Service Private Data */
+	struct device	device;         /* Generic Device Interface */
 };
 #define to_pcie_device(d) container_of(d, struct pcie_device, device)
 
diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index 604feeb84ee40..ddc6854cdde2d 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -274,7 +274,7 @@ static int get_port_device_capability(struct pci_dev *dev)
  * @service: Type of service to associate with the service device
  * @irq: Interrupt vector to associate with the service device
  */
-static int pcie_device_init(struct pci_dev *pdev, int service, int irq)
+static struct pcie_device *pcie_device_init(struct pci_dev *pdev, int service, int irq)
 {
 	int retval;
 	struct pcie_device *pcie;
@@ -282,7 +282,7 @@ static int pcie_device_init(struct pci_dev *pdev, int service, int irq)
 
 	pcie = kzalloc(sizeof(*pcie), GFP_KERNEL);
 	if (!pcie)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 	pcie->port = pdev;
 	pcie->irq = irq;
 	pcie->service = service;
@@ -300,12 +300,12 @@ static int pcie_device_init(struct pci_dev *pdev, int service, int irq)
 	retval = device_register(device);
 	if (retval) {
 		put_device(device);
-		return retval;
+		return ERR_PTR(retval);
 	}
 
 	pm_runtime_no_callbacks(device);
 
-	return 0;
+	return pcie;
 }
 
 /**
@@ -350,10 +350,19 @@ int pcie_port_device_register(struct pci_dev *dev)
 	nr_service = 0;
 	for (i = 0; i < PCIE_PORT_DEVICE_MAXSERVICES; i++) {
 		int service = 1 << i;
+		struct pcie_device *pcie;
 		if (!(capabilities & service))
 			continue;
-		if (!pcie_device_init(dev, service, irqs[i]))
-			nr_service++;
+
+		pcie = pcie_device_init(dev, service, irqs[i]);
+		if (IS_ERR(pcie))
+			continue;
+
+		nr_service++;
+
+		if (i != PCIE_PORT_SERVICE_PME_SHIFT &&
+		    irqs[i] == irqs[PCIE_PORT_SERVICE_PME_SHIFT])
+			pcie->shared_pme_irq = true;
 	}
 	if (!nr_service)
 		goto error_cleanup_irqs;
-- 
2.36.1

