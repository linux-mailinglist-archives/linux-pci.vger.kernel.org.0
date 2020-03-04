Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C22E178879
	for <lists+linux-pci@lfdr.de>; Wed,  4 Mar 2020 03:39:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387643AbgCDCjK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Mar 2020 21:39:10 -0500
Received: from mga12.intel.com ([192.55.52.136]:44650 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387624AbgCDCjI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 3 Mar 2020 21:39:08 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Mar 2020 18:39:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,511,1574150400"; 
   d="scan'208";a="233866898"
Received: from skuppusw-desk.jf.intel.com ([10.7.201.16])
  by orsmga008.jf.intel.com with ESMTP; 03 Mar 2020 18:39:06 -0800
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v17 04/12] PCI: portdrv: remove unnecessary pcie_port_find_service()
Date:   Tue,  3 Mar 2020 18:36:27 -0800
Message-Id: <2d2e15ac7079baa5883e2a1c06e11985e375cdff.1583286655.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1583286655.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1583286655.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

Since pcie_do_recovery() has been refactored to not to depend
on PCIe service driver, we no longer have any users for
pcie_port_find_service() function. So just remove it.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/pci/pcie/portdrv.h      |  2 --
 drivers/pci/pcie/portdrv_core.c | 21 ---------------------
 2 files changed, 23 deletions(-)

diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
index 1e673619b101..c5da165ce016 100644
--- a/drivers/pci/pcie/portdrv.h
+++ b/drivers/pci/pcie/portdrv.h
@@ -161,7 +161,5 @@ static inline int pcie_aer_get_firmware_first(struct pci_dev *pci_dev)
 }
 #endif
 
-struct pcie_port_service_driver *pcie_port_find_service(struct pci_dev *dev,
-							u32 service);
 struct device *pcie_port_find_device(struct pci_dev *dev, u32 service);
 #endif /* _PORTDRV_H_ */
diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index 5075cb9e850c..50a9522ab07d 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -458,27 +458,6 @@ static int find_service_iter(struct device *device, void *data)
 	return 0;
 }
 
-/**
- * pcie_port_find_service - find the service driver
- * @dev: PCI Express port the service is associated with
- * @service: Service to find
- *
- * Find PCI Express port service driver associated with given service
- */
-struct pcie_port_service_driver *pcie_port_find_service(struct pci_dev *dev,
-							u32 service)
-{
-	struct pcie_port_service_driver *drv;
-	struct portdrv_service_data pdrvs;
-
-	pdrvs.drv = NULL;
-	pdrvs.service = service;
-	device_for_each_child(&dev->dev, &pdrvs, find_service_iter);
-
-	drv = pdrvs.drv;
-	return drv;
-}
-
 /**
  * pcie_port_find_device - find the struct device
  * @dev: PCI Express port the service is associated with
-- 
2.25.1

