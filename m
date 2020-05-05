Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDDA81C4D5C
	for <lists+linux-pci@lfdr.de>; Tue,  5 May 2020 06:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725915AbgEEEmZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 May 2020 00:42:25 -0400
Received: from mga03.intel.com ([134.134.136.65]:20182 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725298AbgEEEmY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 May 2020 00:42:24 -0400
IronPort-SDR: xrZag7p/uiI/+yVU9WzKkXlJls6Zp3xOJieVjI4g75MxcUHJCfTHkNE0vqhWV1O4kT42PqE7QY
 QjARgYE3LqjQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2020 21:42:24 -0700
IronPort-SDR: 2vIZbgyyOTKoUofCWTRr5FoIBJMndkLa8KAwbvQPrJky7jEpaWFyNCw9V4ILMLpIlc09XkNhVE
 kNVSTqXkB9xQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,354,1583222400"; 
   d="scan'208";a="369299546"
Received: from otc-nc-03.jf.intel.com ([10.54.39.25])
  by fmsmga001.fm.intel.com with ESMTP; 04 May 2020 21:42:23 -0700
From:   Ashok Raj <ashok.raj@intel.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Cc:     Ashok Raj <ashok.raj@intel.com>, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Darrel Goeddel <DGoeddel@forcepoint.com>,
        Mark Scott <mscott@forcepoint.com>,
        Romil Sharma <rsharma@forcepoint.com>
Subject: [PATCH] iommu: Relax ACS requirement for RCiEP devices.
Date:   Mon,  4 May 2020 21:42:16 -0700
Message-Id: <1588653736-10835-1-git-send-email-ashok.raj@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCIe Spec recommends we can relax ACS requirement for RCIEP devices.

PCIe 5.0 Specification.
6.12 Access Control Services (ACS)
Implementation of ACS in RCiEPs is permitted but not required. It is
explicitly permitted that, within a single Root Complex, some RCiEPs
implement ACS and some do not. It is strongly recommended that Root Complex
implementations ensure that all accesses originating from RCiEPs
(PFs and VFs) without ACS capability are first subjected to processing by
the Translation Agent (TA) in the Root Complex before further decoding and
processing. The details of such Root Complex handling are outside the scope
of this specification.

Since Linux didn't give special treatment to allow this exception, certain
RCiEP MFD devices are getting grouped in a single iommu group. This
doesn't permit a single device to be assigned to a guest for instance.

In one vendor system: Device 14.x were grouped in a single IOMMU group.

/sys/kernel/iommu_groups/5/devices/0000:00:14.0
/sys/kernel/iommu_groups/5/devices/0000:00:14.2
/sys/kernel/iommu_groups/5/devices/0000:00:14.3

After the patch:
/sys/kernel/iommu_groups/5/devices/0000:00:14.0
/sys/kernel/iommu_groups/5/devices/0000:00:14.2
/sys/kernel/iommu_groups/6/devices/0000:00:14.3 <<< new group

14.0 and 14.2 are integrated devices, but legacy end points.
Whereas 14.3 was a PCIe compliant RCiEP.

00:14.3 Network controller: Intel Corporation Device 9df0 (rev 30)
Capabilities: [40] Express (v2) Root Complex Integrated Endpoint, MSI 00

This permits assigning this device to a guest VM.

Fixes: f096c061f552 ("iommu: Rework iommu_group_get_for_pci_dev()")
Signed-off-by: Ashok Raj <ashok.raj@intel.com>
To: Joerg Roedel <joro@8bytes.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-kernel@vger.kernel.org
Cc: iommu@lists.linux-foundation.org
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Darrel Goeddel <DGoeddel@forcepoint.com>
Cc: Mark Scott <mscott@forcepoint.com>,
Cc: Romil Sharma <rsharma@forcepoint.com>
Cc: Ashok Raj <ashok.raj@intel.com>
---
 drivers/iommu/iommu.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 2b471419e26c..5744bd65f3e2 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1187,7 +1187,20 @@ static struct iommu_group *get_pci_function_alias_group(struct pci_dev *pdev,
 	struct pci_dev *tmp = NULL;
 	struct iommu_group *group;
 
-	if (!pdev->multifunction || pci_acs_enabled(pdev, REQ_ACS_FLAGS))
+	/*
+	 * PCI Spec 5.0, Section 6.12 Access Control Service
+	 * Implementation of ACS in RCiEPs is permitted but not required.
+	 * It is explicitly permitted that, within a single Root
+	 * Complex, some RCiEPs implement ACS and some do not. It is
+	 * strongly recommended that Root Complex implementations ensure
+	 * that all accesses originating from RCiEPs (PFs and VFs) without
+	 * ACS capability are first subjected to processing by the Translation
+	 * Agent (TA) in the Root Complex before further decoding and
+	 * processing.
+	 */
+	if (!pdev->multifunction ||
+	    (pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END) ||
+	     pci_acs_enabled(pdev, REQ_ACS_FLAGS))
 		return NULL;
 
 	for_each_pci_dev(tmp) {
-- 
2.7.4

