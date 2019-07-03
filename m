Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83C405EDDA
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2019 22:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbfGCUsu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Jul 2019 16:48:50 -0400
Received: from mga05.intel.com ([192.55.52.43]:7207 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727359AbfGCUsj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 3 Jul 2019 16:48:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jul 2019 13:48:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,448,1557212400"; 
   d="scan'208";a="172258098"
Received: from skuppusw-desk.jf.intel.com ([10.54.74.33])
  by FMSMGA003.fm.intel.com with ESMTP; 03 Jul 2019 13:48:38 -0700
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, keith.busch@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v4 6/7] PCI/ATS: Disable PF/VF ATS service independently
Date:   Wed,  3 Jul 2019 13:46:23 -0700
Message-Id: <9a3027e646f202606ca63c351baeb14a04b13886.1562172836.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1562172836.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1562172836.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

Currently all VF's needs to be disable their ATS service before
disabling the ATS service in corresponding PF device. But this logic is
incorrect and does not align with the spec. Also it might lead to
some power and performance impact in the system. As per PCIe spec r4.0,
sec 9.3.7.8, ATS Capabilities in VFs and their associated PFs may be
enabled/disabled independently. So remove this dependency logic in
enable/disable code.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Keith Busch <keith.busch@intel.com>
Suggested-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/pci/ats.c   | 11 -----------
 include/linux/pci.h |  1 -
 2 files changed, 12 deletions(-)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index d2ee9ee56636..c3e3cbfe9a99 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -140,8 +140,6 @@ int pci_enable_ats(struct pci_dev *dev, int ps)
 		pdev = pci_physfn(dev);
 		if (pdev->ats_stu != ps)
 			return -EINVAL;
-
-		atomic_inc(&pdev->ats_ref_cnt);  /* count enabled VFs */
 	} else {
 		dev->ats_stu = ps;
 		ctrl |= PCI_ATS_CTRL_STU(dev->ats_stu - PCI_ATS_MIN_STU);
@@ -159,20 +157,11 @@ EXPORT_SYMBOL_GPL(pci_enable_ats);
  */
 void pci_disable_ats(struct pci_dev *dev)
 {
-	struct pci_dev *pdev;
 	u16 ctrl;
 
 	if (WARN_ON(!dev->ats_enabled))
 		return;
 
-	if (atomic_read(&dev->ats_ref_cnt))
-		return;		/* VFs still enabled */
-
-	if (dev->is_virtfn) {
-		pdev = pci_physfn(dev);
-		atomic_dec(&pdev->ats_ref_cnt);
-	}
-
 	pci_read_config_word(dev, dev->ats_cap + PCI_ATS_CTRL, &ctrl);
 	ctrl &= ~PCI_ATS_CTRL_ENABLE;
 	pci_write_config_word(dev, dev->ats_cap + PCI_ATS_CTRL, ctrl);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index a317c3115d69..442ced0d2dd1 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -449,7 +449,6 @@ struct pci_dev {
 	};
 	u16		ats_cap;	/* ATS Capability offset */
 	u8		ats_stu;	/* ATS Smallest Translation Unit */
-	atomic_t	ats_ref_cnt;	/* Number of VFs with ATS enabled */
 #endif
 #ifdef CONFIG_PCI_PRI
 	struct mutex	pri_lock;	/* PRI enable lock */
-- 
2.21.0

