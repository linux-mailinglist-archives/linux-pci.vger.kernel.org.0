Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46FB92BB975
	for <lists+linux-pci@lfdr.de>; Fri, 20 Nov 2020 23:55:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728905AbgKTWv5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Nov 2020 17:51:57 -0500
Received: from mga04.intel.com ([192.55.52.120]:15001 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728060AbgKTWv4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 20 Nov 2020 17:51:56 -0500
IronPort-SDR: h53o+rEr4ut3p+rWgG1FTXpL2jjiya+0dT6HM6naHrQWhD5b8LKm3j9G5RP59tDnxOHVY28WL8
 rj0lgsBde/XA==
X-IronPort-AV: E=McAfee;i="6000,8403,9811"; a="168985733"
X-IronPort-AV: E=Sophos;i="5.78,357,1599548400"; 
   d="scan'208";a="168985733"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2020 14:51:56 -0800
IronPort-SDR: 9XXB3RMwjG/P05XUB/Ry6ekr+jyrbY04OyLBsP3ifRzdKEaKjb6ZzYwFc2flCd1uDlxrPX5VQx
 0OEeAug8CGbQ==
X-IronPort-AV: E=Sophos;i="5.78,357,1599548400"; 
   d="scan'208";a="357852100"
Received: from sabakhle-mobl1.amr.corp.intel.com (HELO jderrick-mobl.amr.corp.intel.com) ([10.213.165.80])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2020 14:51:55 -0800
From:   Jon Derrick <jonathan.derrick@intel.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
        Nirmal Patel <nirmal.patel@intel.com>,
        Sushma Kalakota <sushmax.kalakota@intel.com>,
        Jon Derrick <jonathan.derrick@intel.com>
Subject: [PATCH 4/5] PCI: vmd: Pass features to vmd_get_phys_offsets()
Date:   Fri, 20 Nov 2020 15:51:43 -0700
Message-Id: <20201120225144.15138-5-jonathan.derrick@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201120225144.15138-1-jonathan.derrick@intel.com>
References: <20201120225144.15138-1-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Modifies the physical address offset parser to use the device-specific
features member. No functional changes.

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 drivers/pci/controller/vmd.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index b0504ee..71aa002 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -493,14 +493,14 @@ static void vmd_phys_to_offset(struct vmd_dev *vmd, u64 phys1, u64 phys2,
 			(phys2 & PCI_BASE_ADDRESS_MEM_MASK);
 }
 
-static int vmd_get_phys_offsets(struct vmd_dev *vmd, bool native_hint,
+static int vmd_get_phys_offsets(struct vmd_dev *vmd, unsigned long features,
 				resource_size_t *offset1,
 				resource_size_t *offset2)
 {
 	struct pci_dev *dev = vmd->dev;
 	u64 phys1, phys2;
 
-	if (native_hint) {
+	if (features & VMD_FEAT_HAS_MEMBAR_SHADOW) {
 		u32 vmlock;
 		int ret;
 
@@ -519,7 +519,7 @@ static int vmd_get_phys_offsets(struct vmd_dev *vmd, bool native_hint,
 			pci_iounmap(dev, membar2);
 			vmd_phys_to_offset(vmd, phys1, phys2, offset1, offset2);
 		}
-	} else {
+	} else if (features & VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP) {
 		/* Hypervisor-Emulated Vendor-Specific Capability */
 		int pos = pci_find_capability(dev, PCI_CAP_ID_VNDR);
 		u32 reg, regu;
@@ -638,16 +638,12 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 	 * and child devices. These registers will either return the host value
 	 * or 0, depending on an enable bit in the VMD device.
 	 */
-	if (features & VMD_FEAT_HAS_MEMBAR_SHADOW) {
+	if (features & VMD_FEAT_HAS_MEMBAR_SHADOW)
 		membar2_offset = MB2_SHADOW_OFFSET + MB2_SHADOW_SIZE;
-		ret = vmd_get_phys_offsets(vmd, true, &offset[0], &offset[1]);
-		if (ret)
-			return ret;
-	} else if (features & VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP) {
-		ret = vmd_get_phys_offsets(vmd, false, &offset[0], &offset[1]);
-		if (ret)
-			return ret;
-	}
+
+	ret = vmd_get_phys_offsets(vmd, features, &offset[0], &offset[1]);
+	if (ret)
+		return ret;
 
 	/*
 	 * Certain VMD devices may have a root port configuration option which
-- 
1.8.3.1

