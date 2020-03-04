Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D57E5178883
	for <lists+linux-pci@lfdr.de>; Wed,  4 Mar 2020 03:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387648AbgCDCjK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Mar 2020 21:39:10 -0500
Received: from mga12.intel.com ([192.55.52.136]:44652 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387626AbgCDCjI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 3 Mar 2020 21:39:08 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Mar 2020 18:39:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,511,1574150400"; 
   d="scan'208";a="233866902"
Received: from skuppusw-desk.jf.intel.com ([10.7.201.16])
  by orsmga008.jf.intel.com with ESMTP; 03 Mar 2020 18:39:06 -0800
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v17 05/12] PCI: portdrv: remove reset_link member from pcie_port_service_driver
Date:   Tue,  3 Mar 2020 18:36:28 -0800
Message-Id: <13d4866abf46f034f706f255287258cda99fadb4.1583286655.git.sathyanarayanan.kuppuswamy@linux.intel.com>
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

reset_link member in struct pcie_port_service_driver was
mainly added to let pcie_do_recovery() trigger the driver
specific reset_link() on PCIe fatal errors. But after
modifying the pcie_do_recovery() function to accept reset_link
callback as function parameter, we no longer have need to use
or set reset_link in struct pcie_port_service_driver. So remove
it.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/pci/pcie/aer.c     | 1 -
 drivers/pci/pcie/dpc.c     | 1 -
 drivers/pci/pcie/portdrv.h | 3 ---
 3 files changed, 5 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 1235eca0a2e6..c0540c3761dc 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1500,7 +1500,6 @@ static struct pcie_port_service_driver aerdriver = {
 
 	.probe		= aer_probe,
 	.remove		= aer_remove,
-	.reset_link	= aer_root_reset,
 };
 
 /**
diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index 114358d62ddf..1ae5d94944eb 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -313,7 +313,6 @@ static struct pcie_port_service_driver dpcdriver = {
 	.service	= PCIE_PORT_SERVICE_DPC,
 	.probe		= dpc_probe,
 	.remove		= dpc_remove,
-	.reset_link	= dpc_reset_link,
 };
 
 int __init pcie_dpc_init(void)
diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
index c5da165ce016..64b5e081cdb2 100644
--- a/drivers/pci/pcie/portdrv.h
+++ b/drivers/pci/pcie/portdrv.h
@@ -92,9 +92,6 @@ struct pcie_port_service_driver {
 	/* Device driver may resume normal operations */
 	void (*error_resume)(struct pci_dev *dev);
 
-	/* Link Reset Capability - AER service driver specific */
-	pci_ers_result_t (*reset_link)(struct pci_dev *dev);
-
 	int port_type;  /* Type of the port this driver can handle */
 	u32 service;    /* Port service this device represents */
 
-- 
2.25.1

