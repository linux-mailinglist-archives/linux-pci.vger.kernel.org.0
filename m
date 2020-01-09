Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1F5E1361D0
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jan 2020 21:33:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725839AbgAIUdm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Jan 2020 15:33:42 -0500
Received: from mga01.intel.com ([192.55.52.88]:37112 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727738AbgAIUdm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 9 Jan 2020 15:33:42 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jan 2020 12:33:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,414,1571727600"; 
   d="scan'208";a="396206709"
Received: from unknown (HELO nsgsw-rhel7p6.lm.intel.com) ([10.232.116.226])
  by orsmga005.jf.intel.com with ESMTP; 09 Jan 2020 12:33:41 -0800
From:   Jon Derrick <jonathan.derrick@intel.com>
To:     <iommu@lists.linux-foundation.org>, <linux-pci@vger.kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Keith Busch <kbusch@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Christoph Hellwig <hch@lst.de>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jon Derrick <jonathan.derrick@intel.com>
Subject: [PATCH v2 1/5] x86/pci: Add a to_pci_sysdata helper
Date:   Thu,  9 Jan 2020 07:30:52 -0700
Message-Id: <1578580256-3483-2-git-send-email-jonathan.derrick@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1578580256-3483-1-git-send-email-jonathan.derrick@intel.com>
References: <1578580256-3483-1-git-send-email-jonathan.derrick@intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

From: Christoph Hellwig <hch@lst.de>

Various helpers need the pci_sysdata just to dereference a single field
in it.  Add a little helper that returns the properly typed sysdata
pointer to require a little less boilerplate code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
[jonathan.derrick: added un-const cast]
Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 arch/x86/include/asm/pci.h | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/arch/x86/include/asm/pci.h b/arch/x86/include/asm/pci.h
index 90d0731..cf680c5 100644
--- a/arch/x86/include/asm/pci.h
+++ b/arch/x86/include/asm/pci.h
@@ -35,12 +35,15 @@ struct pci_sysdata {
 
 #ifdef CONFIG_PCI
 
+static inline struct pci_sysdata *to_pci_sysdata(struct pci_bus *bus)
+{
+	return bus->sysdata;
+}
+
 #ifdef CONFIG_PCI_DOMAINS
 static inline int pci_domain_nr(struct pci_bus *bus)
 {
-	struct pci_sysdata *sd = bus->sysdata;
-
-	return sd->domain;
+	return to_pci_sysdata(bus)->domain;
 }
 
 static inline int pci_proc_domain(struct pci_bus *bus)
@@ -52,23 +55,20 @@ static inline int pci_proc_domain(struct pci_bus *bus)
 #ifdef CONFIG_PCI_MSI_IRQ_DOMAIN
 static inline void *_pci_root_bus_fwnode(struct pci_bus *bus)
 {
-	struct pci_sysdata *sd = bus->sysdata;
-
-	return sd->fwnode;
+	return to_pci_sysdata(bus)->fwnode;
 }
 
 #define pci_root_bus_fwnode	_pci_root_bus_fwnode
 #endif
 
+#if IS_ENABLED(CONFIG_VMD)
 static inline bool is_vmd(struct pci_bus *bus)
 {
-#if IS_ENABLED(CONFIG_VMD)
-	struct pci_sysdata *sd = bus->sysdata;
-
-	return sd->vmd_domain;
+	return to_pci_sysdata(bus)->vmd_domain;
+}
 #else
-	return false;
-#endif
+#define is_vmd(bus)		false
+#endif /* CONFIG_VMD */
 }
 
 /* Can be used to override the logic in pci_scan_bus for skipping
@@ -124,9 +124,7 @@ static inline void early_quirks(void) { }
 /* Returns the node based on pci bus */
 static inline int __pcibus_to_node(const struct pci_bus *bus)
 {
-	const struct pci_sysdata *sd = bus->sysdata;
-
-	return sd->node;
+	return to_pci_sysdata((struct pci_bus *) bus)->node;
 }
 
 static inline const struct cpumask *
-- 
1.8.3.1

