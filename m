Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2E6320B853
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jun 2020 20:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725283AbgFZSdE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Jun 2020 14:33:04 -0400
Received: from mga07.intel.com ([134.134.136.100]:60445 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725890AbgFZScw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 26 Jun 2020 14:32:52 -0400
IronPort-SDR: Z6PKapRUSp2fBNFE7veO+xQhUuihvXlJ5BNpLA95Rlmpgy2SiWXDFgNwW9ZyaFrk2SSFKpS4gP
 CZGmDRdILn6A==
X-IronPort-AV: E=McAfee;i="6000,8403,9664"; a="210514067"
X-IronPort-AV: E=Sophos;i="5.75,284,1589266800"; 
   d="scan'208";a="210514067"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2020 11:32:47 -0700
IronPort-SDR: 9LgsbEfJvUgDTYfGphuKqb2djomFJPNzlAdViOrszSaT7gsIP7vMY7qZA7Dcqf8Fp0Q2V50gqL
 o87N2L86B3FQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,284,1589266800"; 
   d="scan'208";a="302410005"
Received: from mwhender-mobl.amr.corp.intel.com (HELO localhost.localdomain) ([10.254.77.50])
  by orsmga007.jf.intel.com with ESMTP; 26 Jun 2020 11:32:46 -0700
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v6 4/4] PCI/DPC: Move AER/DPC dependency checks out of DPC driver
Date:   Fri, 26 Jun 2020 11:32:36 -0700
Message-Id: <c20af0ba97ee1bcb8affed21d295add5243069d6.1593195899.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1593195899.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1593195899.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

Currently, AER and DPC Capabilities dependency checks is
distributed between DPC and portdrv service drivers. So move
them out of DPC driver.

Also, since services & PCIE_PORT_SERVICE_AER check already
ensures AER native ownership, no need to add additional
pcie_aer_is_native() check.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/pci/pcie/dpc.c          | 3 ---
 drivers/pci/pcie/portdrv_core.c | 1 +
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index 5b1025a2994d..3efbe43764f3 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -285,9 +285,6 @@ static int dpc_probe(struct pcie_device *dev)
 	int status;
 	u16 ctl, cap;
 
-	if (!pcie_aer_is_native(pdev) && !host->native_dpc)
-		return -ENOTSUPP;
-
 	status = devm_request_threaded_irq(device, dev->irq, dpc_irq,
 					   dpc_handler, IRQF_SHARED,
 					   "pcie-dpc", pdev);
diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index e257a2ca3595..ffa1d9fc458e 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -252,6 +252,7 @@ static int get_port_device_capability(struct pci_dev *dev)
 	 * permission to use AER.
 	 */
 	if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DPC) &&
+	    host->native_dpc &&
 	    (host->native_dpc || (services & PCIE_PORT_SERVICE_AER)))
 		services |= PCIE_PORT_SERVICE_DPC;
 
-- 
2.17.1

