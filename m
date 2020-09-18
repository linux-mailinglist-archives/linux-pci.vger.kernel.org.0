Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1D2A2705F8
	for <lists+linux-pci@lfdr.de>; Fri, 18 Sep 2020 22:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbgIRUIk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Sep 2020 16:08:40 -0400
Received: from mga12.intel.com ([192.55.52.136]:55763 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726118AbgIRUIk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 18 Sep 2020 16:08:40 -0400
IronPort-SDR: M+aViFh0ulrAzOi3C1S8mCh5RmwezVj4D2FrQQRE488uCOo+++C3qaYu/4/aK+XKswISj0igp+
 JfT/a0odEt4Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9748"; a="139519434"
X-IronPort-AV: E=Sophos;i="5.77,274,1596524400"; 
   d="scan'208";a="139519434"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2020 12:58:37 -0700
IronPort-SDR: KW4c6Y0DrB1VklPOIGYjKy1BSltdam4aMwPlmuJVJG+uYDNIMixyoT/bmzvMuIfG0Kzu7I0S7z
 pvJaqrPZN+nA==
X-IronPort-AV: E=Sophos;i="5.77,274,1596524400"; 
   d="scan'208";a="303453436"
Received: from pbashab-mobl2.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.254.127.73])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2020 12:58:37 -0700
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v9 5/5] PCI/DPC: Move AER/DPC dependency checks out of DPC driver
Date:   Fri, 18 Sep 2020 12:58:34 -0700
Message-Id: <2c112fb150348099af5db2f399b21968ab6577e3.1600457297.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1600457297.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1600457297.git.sathyanarayanan.kuppuswamy@linux.intel.com>
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
 drivers/pci/pcie/dpc.c          | 4 ----
 drivers/pci/pcie/portdrv_core.c | 1 +
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index 5b1025a2994d..6261b0382f65 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -280,14 +280,10 @@ void pci_dpc_init(struct pci_dev *pdev)
 static int dpc_probe(struct pcie_device *dev)
 {
 	struct pci_dev *pdev = dev->port;
-	struct pci_host_bridge *host = pci_find_host_bridge(pdev->bus);
 	struct device *device = &dev->device;
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

