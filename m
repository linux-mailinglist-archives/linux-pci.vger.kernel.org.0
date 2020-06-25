Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CBF420A335
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jun 2020 18:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404480AbgFYQmG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Jun 2020 12:42:06 -0400
Received: from mga14.intel.com ([192.55.52.115]:9144 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404106AbgFYQmG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 25 Jun 2020 12:42:06 -0400
IronPort-SDR: AgAidPGZj0ehRrBjTqnOsYIgtQYj3Qv8JoxkjOi2WIC7PuNdN/8sezv3yiyeQgEgBQFYzP5Bje
 Zjt8kc489k/Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9663"; a="144046368"
X-IronPort-AV: E=Sophos;i="5.75,280,1589266800"; 
   d="scan'208";a="144046368"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2020 09:42:05 -0700
IronPort-SDR: BHpScd520FocsEirVnLMO7bCQGym+15l4kVWpE2KC4qkLsU3YIa8tB5I6Hg5w4ReGmUoXRCKR+
 i0SeDt0M9LPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,280,1589266800"; 
   d="scan'208";a="479702145"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.116.74])
  by fmsmga005.fm.intel.com with ESMTP; 25 Jun 2020 09:42:05 -0700
From:   Jon Derrick <jonathan.derrick@intel.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, <linux-pci@vger.kernel.org>,
        Sushma Kalakota <sushmax.kalakota@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jon Derrick <jonathan.derrick@intel.com>
Subject: [PATCH] PCI: vmd: Keep fwnode allocated through VMD irqdomain life
Date:   Thu, 25 Jun 2020 12:24:49 -0400
Message-Id: <20200625162450.5419-1-jonathan.derrick@intel.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

The VMD domain does not subscribe to ACPI, and so does not operate on
it's irqdomain fwnode. It was freeing the handle after allocation of the
domain. As of 181e9d4efaf6a (irqdomain: Make __irq_domain_add() less
OF-dependent), the fwnode is put during irq_domain_remove causing a page
fault. This patch keeps VMD's fwnode allocated through the lifetime of
the VMD irqdomain.

Fixes: ae904cafd59d ("PCI/vmd: Create named irq domain")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Co-developed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
Hi Lorenzo, Bjorn,

Please take this patch for v5.8 fixes. It fixes an issue during VMD
unload.

Thanks
Jon

 drivers/pci/controller/vmd.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index e386d4eac407..ebec0a6e77ed 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -546,9 +546,10 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 
 	vmd->irq_domain = pci_msi_create_irq_domain(fn, &vmd_msi_domain_info,
 						    x86_vector_domain);
-	irq_domain_free_fwnode(fn);
-	if (!vmd->irq_domain)
+	if (!vmd->irq_domain) {
+		irq_domain_free_fwnode(fn);
 		return -ENODEV;
+	}
 
 	pci_add_resource(&resources, &vmd->resources[0]);
 	pci_add_resource_offset(&resources, &vmd->resources[1], offset[0]);
@@ -559,6 +560,7 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 	if (!vmd->bus) {
 		pci_free_resource_list(&resources);
 		irq_domain_remove(vmd->irq_domain);
+		irq_domain_free_fwnode(fn);
 		return -ENODEV;
 	}
 
@@ -672,6 +674,7 @@ static void vmd_cleanup_srcu(struct vmd_dev *vmd)
 static void vmd_remove(struct pci_dev *dev)
 {
 	struct vmd_dev *vmd = pci_get_drvdata(dev);
+	struct fwnode_handle *fn = vmd->irq_domain->fwnode;
 
 	sysfs_remove_link(&vmd->dev->dev.kobj, "domain");
 	pci_stop_root_bus(vmd->bus);
@@ -679,6 +682,7 @@ static void vmd_remove(struct pci_dev *dev)
 	vmd_cleanup_srcu(vmd);
 	vmd_detach_resources(vmd);
 	irq_domain_remove(vmd->irq_domain);
+	irq_domain_free_fwnode(fn);
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.18.1

