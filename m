Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 477761361D1
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jan 2020 21:33:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbgAIUdn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Jan 2020 15:33:43 -0500
Received: from mga01.intel.com ([192.55.52.88]:37112 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727738AbgAIUdn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 9 Jan 2020 15:33:43 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jan 2020 12:33:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,414,1571727600"; 
   d="scan'208";a="396206710"
Received: from unknown (HELO nsgsw-rhel7p6.lm.intel.com) ([10.232.116.226])
  by orsmga005.jf.intel.com with ESMTP; 09 Jan 2020 12:33:42 -0800
From:   Jon Derrick <jonathan.derrick@intel.com>
To:     <iommu@lists.linux-foundation.org>, <linux-pci@vger.kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Keith Busch <kbusch@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Christoph Hellwig <hch@lst.de>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 2/5] x86/pci: Replace the vmd_domain field with a vmd_dev pointer
Date:   Thu,  9 Jan 2020 07:30:53 -0700
Message-Id: <1578580256-3483-3-git-send-email-jonathan.derrick@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1578580256-3483-1-git-send-email-jonathan.derrick@intel.com>
References: <1578580256-3483-1-git-send-email-jonathan.derrick@intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

From: Christoph Hellwig <hch@lst.de>

Store the actual VMD device in struct pci_sysdata, so that we can later
use it directly for DMA mappings.

Reviewed-by: Jon Derrick <jonathan.derrick@intel.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/x86/include/asm/pci.h   | 5 ++---
 drivers/pci/controller/vmd.c | 2 +-
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/pci.h b/arch/x86/include/asm/pci.h
index cf680c5..7c6c7d7 100644
--- a/arch/x86/include/asm/pci.h
+++ b/arch/x86/include/asm/pci.h
@@ -25,7 +25,7 @@ struct pci_sysdata {
 	void		*fwnode;	/* IRQ domain for MSI assignment */
 #endif
 #if IS_ENABLED(CONFIG_VMD)
-	bool vmd_domain;		/* True if in Intel VMD domain */
+	struct device	*vmd_dev;	/* Main device if in Intel VMD domain */
 #endif
 };
 
@@ -64,12 +64,11 @@ static inline void *_pci_root_bus_fwnode(struct pci_bus *bus)
 #if IS_ENABLED(CONFIG_VMD)
 static inline bool is_vmd(struct pci_bus *bus)
 {
-	return to_pci_sysdata(bus)->vmd_domain;
+	return to_pci_sysdata(bus)->vmd_dev != NULL;
 }
 #else
 #define is_vmd(bus)		false
 #endif /* CONFIG_VMD */
-}
 
 /* Can be used to override the logic in pci_scan_bus for skipping
    already-configured bus numbers - to be used for buggy BIOSes
diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 2128422..907b5bd 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -679,7 +679,7 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 		.parent = res,
 	};
 
-	sd->vmd_domain = true;
+	sd->vmd_dev = &vmd->dev->dev;
 	sd->domain = vmd_find_free_domain();
 	if (sd->domain < 0)
 		return sd->domain;
-- 
1.8.3.1

