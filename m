Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7785514141C
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jan 2020 23:30:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbgAQWa3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Jan 2020 17:30:29 -0500
Received: from mga03.intel.com ([134.134.136.65]:34028 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726587AbgAQWa3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 17 Jan 2020 17:30:29 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jan 2020 14:30:29 -0800
X-IronPort-AV: E=Sophos;i="5.70,331,1574150400"; 
   d="scan'208";a="219052205"
Received: from nsgsw-rhel7p6.lm.intel.com ([10.232.116.83])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jan 2020 14:30:28 -0800
From:   Jon Derrick <jonathan.derrick@intel.com>
To:     <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     <iommu@lists.linux-foundation.org>, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jon Derrick <jonathan.derrick@intel.com>
Subject: [PATCH v4 2/7] x86/PCI: Expose VMD's PCI Device in pci_sysdata
Date:   Fri, 17 Jan 2020 09:27:24 -0700
Message-Id: <1579278449-174098-3-git-send-email-jonathan.derrick@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1579278449-174098-1-git-send-email-jonathan.derrick@intel.com>
References: <1579278449-174098-1-git-send-email-jonathan.derrick@intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

To be used by Intel-IOMMU code to find the correct domain.

CC: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 arch/x86/include/asm/pci.h   | 4 ++--
 drivers/pci/controller/vmd.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/pci.h b/arch/x86/include/asm/pci.h
index a4e09db60..6512c54 100644
--- a/arch/x86/include/asm/pci.h
+++ b/arch/x86/include/asm/pci.h
@@ -25,7 +25,7 @@ struct pci_sysdata {
 	void		*fwnode;	/* IRQ domain for MSI assignment */
 #endif
 #if IS_ENABLED(CONFIG_VMD)
-	bool vmd_domain;		/* True if in Intel VMD domain */
+	struct pci_dev	*vmd_dev;	/* VMD Device if in Intel VMD domain */
 #endif
 };
 
@@ -64,7 +64,7 @@ static inline void *_pci_root_bus_fwnode(struct pci_bus *bus)
 #if IS_ENABLED(CONFIG_VMD)
 static inline bool is_vmd(struct pci_bus *bus)
 {
-	return to_pci_sysdata(bus)->vmd_domain;
+	return to_pci_sysdata(bus)->vmd_dev != NULL;
 }
 #else
 #define is_vmd(bus)		false
diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 2128422..d67ad56 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -679,7 +679,7 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 		.parent = res,
 	};
 
-	sd->vmd_domain = true;
+	sd->vmd_dev = vmd->dev;
 	sd->domain = vmd_find_free_domain();
 	if (sd->domain < 0)
 		return sd->domain;
-- 
1.8.3.1

