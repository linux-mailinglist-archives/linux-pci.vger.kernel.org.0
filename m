Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20EED1F0CE2
	for <lists+linux-pci@lfdr.de>; Sun,  7 Jun 2020 18:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbgFGQUT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 7 Jun 2020 12:20:19 -0400
Received: from mga02.intel.com ([134.134.136.20]:61717 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726852AbgFGQUS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 7 Jun 2020 12:20:18 -0400
IronPort-SDR: u+OkY4U8GXpfUj+e3flHZ6eEsoACAPSTu4GKXi0ZhDmIrza/Ib18Dy1BGLX+Syws3syhvB0rFM
 BLPXIGcQ3cGw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2020 09:20:14 -0700
IronPort-SDR: FRPUfK62WhGHPYA7JWfQ0KWJlVcm5+UPqTzX30uPS1wXKWWoJlFiwMwUPlx3IH6B20sHDldPjA
 w1cLCV3/KF5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,484,1583222400"; 
   d="scan'208";a="348938501"
Received: from skaushal-mobl5.gar.corp.intel.com (HELO localhost.localdomain) ([10.255.229.193])
  by orsmga001.jf.intel.com with ESMTP; 07 Jun 2020 09:20:14 -0700
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v5 4/4] PCI/DPC: Move AER/DPC dependency checks out of DPC driver
Date:   Sun,  7 Jun 2020 09:20:01 -0700
Message-Id: <2d4ba2e3d224bfb1cdce1dfca6f27049d605098d.1591545462.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1591545462.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1591545462.git.sathyanarayanan.kuppuswamy@linux.intel.com>
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

