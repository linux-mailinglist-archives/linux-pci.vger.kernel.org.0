Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CED612BBA9E
	for <lists+linux-pci@lfdr.de>; Sat, 21 Nov 2020 01:13:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728606AbgKUAKo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Nov 2020 19:10:44 -0500
Received: from mga02.intel.com ([134.134.136.20]:34304 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728470AbgKUAKm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 20 Nov 2020 19:10:42 -0500
IronPort-SDR: MG6QpcnTL5jF/kL0Y+yx7goJrJ7xo/ViVElSAZylYAT1h6/9xLNAxPZw+c55YSCXIMGksGtIPG
 MRq/ba8f7WOw==
X-IronPort-AV: E=McAfee;i="6000,8403,9811"; a="158601568"
X-IronPort-AV: E=Sophos;i="5.78,357,1599548400"; 
   d="scan'208";a="158601568"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2020 16:10:41 -0800
IronPort-SDR: j/L2xqU21MXT2aIQJBuV2OzV28RFz25qrFesKAH52lCaIyre7v+IFjAvoc9OT6zVQFY6I55snN
 iyyK3SFd4nIw==
X-IronPort-AV: E=Sophos;i="5.78,357,1599548400"; 
   d="scan'208";a="369387305"
Received: from unknown (HELO arch-ashland-svkelley.intel.com) ([10.212.171.128])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2020 16:10:41 -0800
From:   Sean V Kelley <sean.v.kelley@intel.com>
To:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        xerces.zhao@gmail.com, rafael.j.wysocki@intel.com,
        ashok.raj@intel.com, tony.luck@intel.com,
        sathyanarayanan.kuppuswamy@intel.com, qiuxu.zhuo@intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean V Kelley <sean.v.kelley@intel.com>
Subject: [PATCH v12 06/15] PCI/ERR: Simplify by computing pci_pcie_type() once
Date:   Fri, 20 Nov 2020 16:10:27 -0800
Message-Id: <20201121001036.8560-7-sean.v.kelley@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201121001036.8560-1-sean.v.kelley@intel.com>
References: <20201121001036.8560-1-sean.v.kelley@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Instead of calling pci_pcie_type(dev) twice, call it once and save the
result.  No functional change intended.

[bhelgaas: split to separate patch]
Link: https://lore.kernel.org/r/20201002184735.1229220-6-seanvk.dev@oregontracks.org
Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/pci/pcie/aer.c         | 5 +++--
 drivers/pci/pcie/err.c         | 5 +++--
 drivers/pci/pcie/portdrv_pci.c | 9 +++++----
 3 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 6fe2d4ef0635..0ba0b47ae751 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1034,6 +1034,7 @@ EXPORT_SYMBOL_GPL(aer_recover_queue);
  */
 int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info)
 {
+	int type = pci_pcie_type(dev);
 	int aer = dev->aer_cap;
 	int temp;
 
@@ -1052,8 +1053,8 @@ int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info)
 			&info->mask);
 		if (!(info->status & ~info->mask))
 			return 0;
-	} else if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
-	           pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM ||
+	} else if (type == PCI_EXP_TYPE_ROOT_PORT ||
+		   type == PCI_EXP_TYPE_DOWNSTREAM ||
 		   info->severity == AER_NONFATAL) {
 
 		/* Link is still healthy for IO reads */
diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 05f61da5ed9d..7a5af873d8bc 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -150,6 +150,7 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 		pci_channel_state_t state,
 		pci_ers_result_t (*reset_subordinates)(struct pci_dev *pdev))
 {
+	int type = pci_pcie_type(dev);
 	pci_ers_result_t status = PCI_ERS_RESULT_CAN_RECOVER;
 	struct pci_bus *bus;
 
@@ -157,8 +158,8 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 	 * Error recovery runs on all subordinates of the first downstream port.
 	 * If the downstream port detected the error, it is cleared at the end.
 	 */
-	if (!(pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
-	      pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM))
+	if (!(type == PCI_EXP_TYPE_ROOT_PORT ||
+	      type == PCI_EXP_TYPE_DOWNSTREAM))
 		dev = pci_upstream_bridge(dev);
 	bus = dev->subordinate;
 
diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
index 4d880679b9b1..ff9517ee92b3 100644
--- a/drivers/pci/pcie/portdrv_pci.c
+++ b/drivers/pci/pcie/portdrv_pci.c
@@ -101,13 +101,14 @@ static const struct dev_pm_ops pcie_portdrv_pm_ops = {
 static int pcie_portdrv_probe(struct pci_dev *dev,
 					const struct pci_device_id *id)
 {
+	int type = pci_pcie_type(dev);
 	int status;
 
 	if (!pci_is_pcie(dev) ||
-	    ((pci_pcie_type(dev) != PCI_EXP_TYPE_ROOT_PORT) &&
-	     (pci_pcie_type(dev) != PCI_EXP_TYPE_UPSTREAM) &&
-	     (pci_pcie_type(dev) != PCI_EXP_TYPE_DOWNSTREAM) &&
-	     (pci_pcie_type(dev) != PCI_EXP_TYPE_RC_EC)))
+	    ((type != PCI_EXP_TYPE_ROOT_PORT) &&
+	     (type != PCI_EXP_TYPE_UPSTREAM) &&
+	     (type != PCI_EXP_TYPE_DOWNSTREAM) &&
+	     (type != PCI_EXP_TYPE_RC_EC)))
 		return -ENODEV;
 
 	status = pcie_port_device_register(dev);
-- 
2.29.2

