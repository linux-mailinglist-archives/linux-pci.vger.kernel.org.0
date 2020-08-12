Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C346242D94
	for <lists+linux-pci@lfdr.de>; Wed, 12 Aug 2020 18:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbgHLQrR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Aug 2020 12:47:17 -0400
Received: from mga12.intel.com ([192.55.52.136]:33838 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726394AbgHLQrQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Aug 2020 12:47:16 -0400
IronPort-SDR: tzBxlSL46TwXODiNxfCbjt9vLPe0xxWFRs3fZCDAPj8dFIx/s8iM0NziKv4ovpE7jNwY0aAZz0
 ykvVdMaxEGtg==
X-IronPort-AV: E=McAfee;i="6000,8403,9711"; a="133538490"
X-IronPort-AV: E=Sophos;i="5.76,305,1592895600"; 
   d="scan'208";a="133538490"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2020 09:47:15 -0700
IronPort-SDR: mWsRAJl50r5pU7b589S8H4vR3+uN2S+dBuivFDocEQhO4yRd/r+ba3nT0Cb3uYYE8iPX2JAFtC
 1QOWV21YUjwg==
X-IronPort-AV: E=Sophos;i="5.76,305,1592895600"; 
   d="scan'208";a="439442667"
Received: from ticede-or-099.amr.corp.intel.com (HELO arch-ashland-svkelley.intel.com) ([10.254.58.97])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2020 09:47:13 -0700
From:   Sean V Kelley <sean.v.kelley@intel.com>
To:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        rjw@rjwysocki.net, ashok.raj@intel.com, tony.luck@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com, qiuxu.zhuo@intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean V Kelley <sean.v.kelley@intel.com>
Subject: [PATCH v3 07/10] PCI: Add 'rcec' field to pci_dev for associated RCiEPs
Date:   Wed, 12 Aug 2020 09:46:56 -0700
Message-Id: <20200812164659.1118946-8-sean.v.kelley@intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200812164659.1118946-1-sean.v.kelley@intel.com>
References: <20200812164659.1118946-1-sean.v.kelley@intel.com>
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

Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Co-developed-by: Sean V Kelley <sean.v.kelley@intel.com>
Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
---
 drivers/pci/pcie/aer.c         |  9 +++++----
 drivers/pci/pcie/err.c         | 10 ++++++++++
 drivers/pci/pcie/portdrv_pci.c | 15 +++++++++++++++
 include/linux/pci.h            |  1 +
 4 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 3acf56683915..f1bf06be449e 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1335,17 +1335,18 @@ static int aer_probe(struct pcie_device *dev)
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
index 04528b57876b..a5b7e708079d 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -202,6 +202,12 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 		pci_walk_dev_affected(dev, report_frozen_detected, &status);
 		if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_END) {
 			status = flr_on_rciep(dev);
+			/*
+			 * The callback only clears the Root Error Status
+			 * of the RCEC (see aer.c).
+			 */
+			if (dev->rcec)
+				reset_link(dev->rcec);
 			if (status != PCI_ERS_RESULT_RECOVERED) {
 				pci_warn(dev, "function level reset failed\n");
 				goto failed;
@@ -245,7 +251,11 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 	     pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC)) {
 		pci_aer_clear_device_status(dev);
 		pci_aer_clear_nonfatal_status(dev);
+	} else if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_END && dev->rcec) {
+		pci_aer_clear_device_status(dev->rcec);
+		pci_aer_clear_nonfatal_status(dev->rcec);
 	}
+
 	pci_info(dev, "device recovery successful\n");
 	return status;
 
diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
index d5b109499b10..a64e88b7166b 100644
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
index c7fc5726872c..ba29816c827b 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -330,6 +330,7 @@ struct pci_dev {
 #ifdef CONFIG_PCIEPORTBUS
 	u16		rcec_cap;	/* RCEC capability offset */
 	struct rcec_ext *rcec_ext;	/* RCEC cached assoc. endpoint extended capabilities */
+	struct pci_dev	*rcec;		/* Associated RCEC device */
 #endif
 	u8		pcie_cap;	/* PCIe capability offset */
 	u8		msi_cap;	/* MSI capability offset */
-- 
2.28.0

