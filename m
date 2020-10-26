Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C18F299648
	for <lists+linux-pci@lfdr.de>; Mon, 26 Oct 2020 19:58:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1791075AbgJZS6V (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Oct 2020 14:58:21 -0400
Received: from mga03.intel.com ([134.134.136.65]:52496 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1791041AbgJZS6J (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 26 Oct 2020 14:58:09 -0400
IronPort-SDR: ru2kJ1aa+mRV1WY1dAelTvO7s4i17NWbFGGoyLFxNxD34uygZUGv1CGjrCWW7XQGxDJV21S6t0
 pvL9EDUVT6vQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9786"; a="168073149"
X-IronPort-AV: E=Sophos;i="5.77,420,1596524400"; 
   d="scan'208";a="168073149"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2020 11:58:08 -0700
IronPort-SDR: Acbb3fIgz6rL4CWP99tZwAz5kbTGjHDEKAmk1n8eMXwf6YylnYViBQrJC98lFMKh/Bs8jrxbIh
 SN5Y96ofpr1w==
X-IronPort-AV: E=Sophos;i="5.77,420,1596524400"; 
   d="scan'208";a="525607466"
Received: from dhrubajy-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.254.101.53])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2020 11:58:07 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com,
        knsathya@kernel.org
Subject: [PATCH v10 5/5] PCI/DPC: Move AER/DPC dependency checks out of DPC driver
Date:   Mon, 26 Oct 2020 11:56:43 -0700
Message-Id: <3cb6923f879b64a80df3670facdee327bcc39a4c.1603738449.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1603738449.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1603738449.git.sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <cover.1603738449.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1603738449.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

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
index 21f77420632b..a8b922044447 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -283,14 +283,10 @@ void pci_dpc_init(struct pci_dev *pdev)
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

