Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5191C489EB9
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jan 2022 19:01:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238663AbiAJSBO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 Jan 2022 13:01:14 -0500
Received: from mga09.intel.com ([134.134.136.24]:50374 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238610AbiAJSBN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 10 Jan 2022 13:01:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641837673; x=1673373673;
  h=from:to:cc:subject:date:message-id;
  bh=4R4m2JnlhOfFaMJ6bSzrdmzLSKSTs3kFRvVCKFiCpOc=;
  b=dtLVX2/PylD3egEqgrdme298tulv43juQ3z/uNMbCoLq/AKOoTjfeifS
   vQcOszpbJcH4OuwiQBtmInK9iMnTIFXGkl5jdN2gkY4XHH3BJM7FD8gsl
   nXdgwCX/YhAQt3+ZfPi03ukLK66mV4N4aPnlqxQdtUjoreCDjtjngRoAX
   90b2Lj7LfAhzPFQt2bNJTFMeCe4oonCczp1EIQte/1beowjmRcLvbEvZb
   0vnc1GdGQxmQbigoUPwpC192JLFN+bDRMml6ba184gZvsz8asXCnfmnZR
   7GAIltdFg5SE+5tMfo5W+BK1GQ0iKDUtBcaq72rLpCkrT3yeJZxuvb7ND
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10222"; a="243079316"
X-IronPort-AV: E=Sophos;i="5.88,277,1635231600"; 
   d="scan'208";a="243079316"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2022 10:00:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,277,1635231600"; 
   d="scan'208";a="622754694"
Received: from brillo-chrome.jf.intel.com ([10.54.77.27])
  by orsmga004.jf.intel.com with ESMTP; 10 Jan 2022 10:00:51 -0800
From:   Sanrio Alvares <sanrio.alvares@intel.com>
To:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     mika.westerberg@linux.intel.com,
        Sanrio Alvares <sanrio.alvares@intel.com>
Subject: [PATCH v2] PCI / thunderbolt: Add quirk to handle incorrect Supported Link Speeds
Date:   Mon, 10 Jan 2022 18:00:49 +0000
Message-Id: <20220110180049.59403-1-sanrio.alvares@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In PCIe config space the "Supported Link Speeds" Vector value is 0x07,
in all downstream ports for Intel Titan Ridge. Which means link
supports Gen1, Gen2 and Gen3. While actually max link speed is 2.5GT/s
so the value of this vector should be 0x01.

As a consequence of reporting >2.5GT/s, we need to delay the full 1s
which makes resuming longer than needed.

Signed-off-by: Sanrio Alvares <sanrio.alvares@intel.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
Changes from v1:
- add static to quirk_intel_tbt_supported_link_speeds
---
 drivers/pci/pci.c    |  4 ++++
 drivers/pci/quirks.c | 14 ++++++++++++++
 include/linux/pci.h  |  1 +
 3 files changed, 19 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 3d2fb394986a..92401552d385 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6136,6 +6136,10 @@ enum pci_bus_speed pcie_get_speed_cap(struct pci_dev *dev)
 {
 	u32 lnkcap2, lnkcap;
 
+	/* Use overridden value of Supported Link Speed */
+	if (dev->supported_link_speed)
+		return dev->supported_link_speed;
+
 	/*
 	 * Link Capabilities 2 was added in PCIe r3.0, sec 7.8.18.  The
 	 * implementation note there recommends using the Supported Link
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 003950c738d2..2cbe0beeac08 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5293,6 +5293,20 @@ static void quirk_intel_qat_vf_cap(struct pci_dev *pdev)
 }
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x443, quirk_intel_qat_vf_cap);
 
+/*
+ * Intel Titan Ridge returns incorrect Supported Link Speeds Vector
+ * when max Link Speed is 2.5GT/s. This results in an extra 1s delay during
+ * resume_noirq with pcie tunneling enabled. Override that value:
+ */
+static void quirk_intel_tbt_supported_link_speeds(struct pci_dev *pdev)
+{
+	pci_info(pdev, "applying Supported Link Speeds quirk\n");
+	pdev->supported_link_speed = PCIE_SPEED_2_5GT;
+}
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x15e7, quirk_intel_tbt_supported_link_speeds);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x15ea, quirk_intel_tbt_supported_link_speeds);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x15ef, quirk_intel_tbt_supported_link_speeds);
+
 /*
  * FLR may cause the following to devices to hang:
  *
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 18a75c8e615c..633e81e9fe3b 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -502,6 +502,7 @@ struct pci_dev {
 	struct pci_p2pdma __rcu *p2pdma;
 #endif
 	u16		acs_cap;	/* ACS Capability offset */
+	u8		supported_link_speed; /* Override Supported Link Speed value from device */
 	phys_addr_t	rom;		/* Physical address if not from BAR */
 	size_t		romlen;		/* Length if not from BAR */
 	char		*driver_override; /* Driver name to force a match */
-- 
2.17.1

