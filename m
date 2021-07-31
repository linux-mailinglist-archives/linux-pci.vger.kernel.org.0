Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 370673DC603
	for <lists+linux-pci@lfdr.de>; Sat, 31 Jul 2021 14:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232211AbhGaMzC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 31 Jul 2021 08:55:02 -0400
Received: from bmailout3.hostsharing.net ([176.9.242.62]:40603 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbhGaMzC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 31 Jul 2021 08:55:02 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 511EC100D9410;
        Sat, 31 Jul 2021 14:54:53 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 1FF2E24FF2A; Sat, 31 Jul 2021 14:54:53 +0200 (CEST)
Message-Id: <25334149b604e005058aeb0fdf51e01f991d5d74.1627638184.git.lukas@wunner.de>
In-Reply-To: <cover.1627638184.git.lukas@wunner.de>
References: <cover.1627638184.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Sat, 31 Jul 2021 14:39:02 +0200
Subject: [PATCH 2/4] PCI/portdrv: Remove unused resume err_handler
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Sinan Kaya <okaya@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
        Keith Busch <kbusch@kernel.org>,
        Yicong Yang <yangyicong@hisilicon.com>,
        linux-pci@vger.kernel.org, Russell Currey <ruscur@russell.cc>,
        "Oliver OHalloran" <oohall@gmail.com>,
        Stuart Hayes <stuart.w.hayes@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Commit 3e41a317ae45 ("PCI/AER: Remove unused aer_error_resume()")
removed the resume err_handler from AER.  Since no other port service
implements the callback, support for it can be removed from portdrv.
It can be revived later if need be, preferably by re-using the
pcie_port_device_iter() iterator.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: Keith Busch <kbusch@kernel.org>
---
 drivers/pci/pcie/portdrv.h     |  2 --
 drivers/pci/pcie/portdrv_pci.c | 24 ------------------------
 2 files changed, 26 deletions(-)

diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
index 92a776d211ec..e9fe0fef6cde 100644
--- a/drivers/pci/pcie/portdrv.h
+++ b/drivers/pci/pcie/portdrv.h
@@ -86,8 +86,6 @@ struct pcie_port_service_driver {
 	int (*runtime_resume)(struct pcie_device *dev);
 
 	int (*slot_reset)(struct pcie_device *dev);
-	/* Device driver may resume normal operations */
-	void (*error_resume)(struct pci_dev *dev);
 
 	int port_type;  /* Type of the port this driver can handle */
 	u32 service;    /* Port service this device represents */
diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
index 1af74c3d9d5d..35eca6277a96 100644
--- a/drivers/pci/pcie/portdrv_pci.c
+++ b/drivers/pci/pcie/portdrv_pci.c
@@ -173,29 +173,6 @@ static pci_ers_result_t pcie_portdrv_mmio_enabled(struct pci_dev *dev)
 	return PCI_ERS_RESULT_RECOVERED;
 }
 
-static int resume_iter(struct device *device, void *data)
-{
-	struct pcie_device *pcie_device;
-	struct pcie_port_service_driver *driver;
-
-	if (device->bus == &pcie_port_bus_type && device->driver) {
-		driver = to_service_driver(device->driver);
-		if (driver && driver->error_resume) {
-			pcie_device = to_pcie_device(device);
-
-			/* Forward error message to service drivers */
-			driver->error_resume(pcie_device->port);
-		}
-	}
-
-	return 0;
-}
-
-static void pcie_portdrv_err_resume(struct pci_dev *dev)
-{
-	device_for_each_child(&dev->dev, NULL, resume_iter);
-}
-
 /*
  * LINUX Device Driver Model
  */
@@ -213,7 +190,6 @@ static const struct pci_error_handlers pcie_portdrv_err_handler = {
 	.error_detected = pcie_portdrv_error_detected,
 	.slot_reset = pcie_portdrv_slot_reset,
 	.mmio_enabled = pcie_portdrv_mmio_enabled,
-	.resume = pcie_portdrv_err_resume,
 };
 
 static struct pci_driver pcie_portdriver = {
-- 
2.31.1

