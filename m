Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC8390BAB
	for <lists+linux-pci@lfdr.de>; Sat, 17 Aug 2019 02:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbfHQAN2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Aug 2019 20:13:28 -0400
Received: from mga05.intel.com ([192.55.52.43]:12918 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726126AbfHQANY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 16 Aug 2019 20:13:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Aug 2019 17:13:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,395,1559545200"; 
   d="scan'208";a="168195015"
Received: from skuppusw-desk.jf.intel.com ([10.54.74.33])
  by orsmga007.jf.intel.com with ESMTP; 16 Aug 2019 17:13:22 -0700
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, keith.busch@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v6 7/8] PCI/ATS: Disable PF/VF ATS service independently
Date:   Fri, 16 Aug 2019 17:10:21 -0700
Message-Id: <cdebd76955086c99a2f5578725c970005b092f6c.1565997310.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1565997310.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1565997310.git.sathyanarayanan.kuppuswamy@linux.intel.com>
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
index ca633482e565..3a3e81630d7c 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -108,8 +108,6 @@ int pci_enable_ats(struct pci_dev *dev, int ps)
 		pdev = pci_physfn(dev);
 		if (pdev->ats_stu != ps)
 			return -EINVAL;
-
-		atomic_inc(&pdev->ats_ref_cnt);  /* count enabled VFs */
 	} else {
 		dev->ats_stu = ps;
 		ctrl |= PCI_ATS_CTRL_STU(dev->ats_stu - PCI_ATS_MIN_STU);
@@ -127,20 +125,11 @@ EXPORT_SYMBOL_GPL(pci_enable_ats);
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
index 735dc731e0aa..5c72590df0bf 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -452,7 +452,6 @@ struct pci_dev {
 	};
 	u16		ats_cap;	/* ATS Capability offset */
 	u8		ats_stu;	/* ATS Smallest Translation Unit */
-	atomic_t	ats_ref_cnt;	/* Number of VFs with ATS enabled */
 #endif
 #ifdef CONFIG_PCI_PRI
 	u16		pri_cap;	/* PRI Capability offset */
-- 
2.21.0

