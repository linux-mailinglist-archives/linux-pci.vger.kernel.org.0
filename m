Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B45514D11B
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jan 2020 20:16:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbgA2TQZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jan 2020 14:16:25 -0500
Received: from mga11.intel.com ([192.55.52.93]:42142 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726171AbgA2TQZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 29 Jan 2020 14:16:25 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jan 2020 11:16:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,378,1574150400"; 
   d="scan'208";a="315381629"
Received: from skuppusw-desk.jf.intel.com ([10.54.74.33])
  by fmsmga001.fm.intel.com with ESMTP; 29 Jan 2020 11:16:24 -0800
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v1 1/1] PCI/ATS: For VF PCIe device use PF PASID Capability
Date:   Wed, 29 Jan 2020 11:14:00 -0800
Message-Id: <fe891f9755cb18349389609e7fed9940fc5b081a.1580325170.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

Per PCIe r5.0, sec 9.3.7.14, if a PF implements the PASID Capability,
the PF PASID configuration is shared by its VFs. VFs must not implement
their own PASID Capability. But, commit 751035b8dc06 ("PCI/ATS: Cache
PASID Capability offset") when adding support for PASID Capability
offset caching, modified the pci_max_pasids() and pci_pasid_features()
APIs to use PASID Capability offset of VF device instead of using
PASID Capability offset of associated PF device. This change leads to
IOMMU bind failures when pci_max_pasids() and pci_pasid_features()
functions are invoked by PCIe VF devices.

So modify pci_max_pasids() and pci_pasid_features() functions to use
correct PASID Capability offset.

Fixes: 751035b8dc06 ("PCI/ATS: Cache PASID Capability offset")
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/pci/ats.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index 982b46f0a54d..b6f064c885c3 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -424,11 +424,12 @@ void pci_restore_pasid_state(struct pci_dev *pdev)
 int pci_pasid_features(struct pci_dev *pdev)
 {
 	u16 supported;
-	int pasid = pdev->pasid_cap;
+	int pasid;
 
 	if (pdev->is_virtfn)
 		pdev = pci_physfn(pdev);
 
+	pasid = pdev->pasid_cap;
 	if (!pasid)
 		return -EINVAL;
 
@@ -451,11 +452,12 @@ int pci_pasid_features(struct pci_dev *pdev)
 int pci_max_pasids(struct pci_dev *pdev)
 {
 	u16 supported;
-	int pasid = pdev->pasid_cap;
+	int pasid;
 
 	if (pdev->is_virtfn)
 		pdev = pci_physfn(pdev);
 
+	pasid = pdev->pasid_cap;
 	if (!pasid)
 		return -EINVAL;
 
-- 
2.21.0

