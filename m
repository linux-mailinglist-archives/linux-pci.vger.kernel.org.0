Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9C423C023
	for <lists+linux-pci@lfdr.de>; Tue,  4 Aug 2020 21:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728526AbgHDTlO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Aug 2020 15:41:14 -0400
Received: from mga18.intel.com ([134.134.136.126]:29273 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728409AbgHDTlL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 4 Aug 2020 15:41:11 -0400
IronPort-SDR: gSJ9uhVGs1EGwbbldooy2vwSXP8rlCPQPbnQxiplZLAKYA5OTj1Tft2CppNgc/5pgvswNX4I4B
 FFjgU67kw5Aw==
X-IronPort-AV: E=McAfee;i="6000,8403,9703"; a="139991112"
X-IronPort-AV: E=Sophos;i="5.75,434,1589266800"; 
   d="scan'208";a="139991112"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2020 12:41:10 -0700
IronPort-SDR: bQNNIpu6Uc1hJHn/WQypAhs7qz1dtAZYNzVxyBoE3v2PDy9vHyak0hKSHCUJRZx5r1UyC3bmhO
 GBJtkhmNe3og==
X-IronPort-AV: E=Sophos;i="5.75,434,1589266800"; 
   d="scan'208";a="467199267"
Received: from viveksh1-mobl.amr.corp.intel.com (HELO arch-ashland-svkelley.intel.com) ([10.255.83.117])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2020 12:41:09 -0700
From:   Sean V Kelley <sean.v.kelley@intel.com>
To:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        rjw@rjwysocki.net, ashok.raj@intel.com, tony.luck@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Sean V Kelley <sean.v.kelley@intel.com>
Subject: [PATCH V2 6/9] PCI: Add 'rcec' field to pci_dev for associated RCiEPs
Date:   Tue,  4 Aug 2020 12:40:49 -0700
Message-Id: <20200804194052.193272-7-sean.v.kelley@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200804194052.193272-1-sean.v.kelley@intel.com>
References: <20200804194052.193272-1-sean.v.kelley@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

When attempting error recovery for an RCiEP associated with an RCEC device,
there needs to be a way to update the Root Error Status, the Uncorrectable
Error Status and the Uncorrectable Error Severity of the parent RCEC.
So add the 'rcec' field to the pci_dev structure and provide a hook for the
Root Port Driver to associate RCiEPs with their respective parent RCEC.

Co-developed-by: Sean V Kelley <sean.v.kelley@intel.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
---
 drivers/pci/pcie/aer.c         |  9 +++++----
 drivers/pci/pcie/err.c         | 12 ++++++++++++
 drivers/pci/pcie/portdrv_pci.c | 15 +++++++++++++++
 include/linux/pci.h            |  3 +++
 4 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 87283cda3990..f658607e8e00 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1358,17 +1358,18 @@ static int aer_probe(struct pcie_device *dev)
 static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
 {
 	int aer = dev->aer_cap;
+	int rc = 0;
 	u32 reg32;
-	int rc;
-
 
 	/* Disable Root's interrupt in response to error messages */
 	pci_read_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, &reg32);
 	reg32 &= ~ROOT_PORT_INTR_ON_MESG_MASK;
 	pci_write_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, reg32);
 
-	rc = pci_bus_error_reset(dev);
-	pci_info(dev, "Root Port link has been reset\n");
+	if (pci_pcie_type(dev) != PCI_EXP_TYPE_RC_EC) {
+		rc = pci_bus_error_reset(dev);
+		pci_info(dev, "Root Port link has been reset\n");
+	}
 
 	/* Clear Root Error Status */
 	pci_read_config_dword(dev, aer + PCI_ERR_ROOT_STATUS, &reg32);
diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 4812aa678eff..43f1c55c76db 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -203,6 +203,12 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 		pci_walk_dev_affected(dev, report_frozen_detected, &status);
 		if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_END) {
 			status = flr_on_rciep(dev);
+			/*
+			 * The callback only clears the Root Error Status
+			 * of the RCEC (see aer.c).
+			 */
+			if (pcie_aer_is_native(dev) && dev->rcec)
+				reset_link(dev->rcec);
 			if (status != PCI_ERS_RESULT_RECOVERED) {
 				pci_warn(dev, "function level reset failed\n");
 				goto failed;
@@ -247,7 +253,13 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 		if (pcie_aer_is_native(dev))
 			pcie_clear_device_status(dev);
 		pci_aer_clear_nonfatal_status(dev);
+	} else if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_END) {
+		if (pcie_aer_is_native(dev) && dev->rcec)
+			pcie_clear_device_status(dev->rcec);
+		if (dev->rcec)
+			pci_aer_clear_nonfatal_status(dev->rcec);
 	}
+
 	pci_info(dev, "device recovery successful\n");
 	return status;
 
diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
index 4d880679b9b1..dff5c9e13412 100644
--- a/drivers/pci/pcie/portdrv_pci.c
+++ b/drivers/pci/pcie/portdrv_pci.c
@@ -90,6 +90,18 @@ static const struct dev_pm_ops pcie_portdrv_pm_ops = {
 #define PCIE_PORTDRV_PM_OPS	NULL
 #endif /* !PM */
 
+static int pcie_hook_rcec(struct pci_dev *pdev, void *data)
+{
+	struct pci_dev *rcec = (struct pci_dev *)data;
+
+	pdev->rcec = rcec;
+	pci_dbg(rcec, "RCiEP(under an RCEC) %04x:%02x:%02x.%d\n",
+		pci_domain_nr(pdev->bus), pdev->bus->number,
+		PCI_SLOT(pdev->devfn), PCI_FUNC(pdev->devfn));
+
+	return 0;
+}
+
 /*
  * pcie_portdrv_probe - Probe PCI-Express port devices
  * @dev: PCI-Express port device being probed
@@ -110,6 +122,9 @@ static int pcie_portdrv_probe(struct pci_dev *dev,
 	     (pci_pcie_type(dev) != PCI_EXP_TYPE_RC_EC)))
 		return -ENODEV;
 
+	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC)
+		pcie_walk_rcec(dev, pcie_hook_rcec, dev);
+
 	status = pcie_port_device_register(dev);
 	if (status)
 		return status;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index ee49469bd2b5..d5f7dbbf5e2f 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -326,6 +326,9 @@ struct pci_dev {
 #ifdef CONFIG_PCIEAER
 	u16		aer_cap;	/* AER capability offset */
 	struct aer_stats *aer_stats;	/* AER stats for this device */
+#endif
+#ifdef CONFIG_PCIEPORTBUS
+	struct pci_dev	*rcec;		/* Associated RCEC device */
 #endif
 	u8		pcie_cap;	/* PCIe capability offset */
 	u8		msi_cap;	/* MSI capability offset */
-- 
2.27.0

