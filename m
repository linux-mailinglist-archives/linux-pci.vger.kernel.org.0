Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3F402BB974
	for <lists+linux-pci@lfdr.de>; Fri, 20 Nov 2020 23:55:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729080AbgKTWvz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Nov 2020 17:51:55 -0500
Received: from mga04.intel.com ([192.55.52.120]:15001 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728905AbgKTWvz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 20 Nov 2020 17:51:55 -0500
IronPort-SDR: svz5TYfK2lqqQUyJWlhE1aJ6tij6wbFuvwrw51QIAHVJ62uIwaprMGkNKMVwwo9UW/+mJwPF0Z
 I+bbTf+N/52Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9811"; a="168985730"
X-IronPort-AV: E=Sophos;i="5.78,357,1599548400"; 
   d="scan'208";a="168985730"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2020 14:51:55 -0800
IronPort-SDR: W1X+h2sLTf2kjhDDC+E0ecB0wnF/NMZr6QP88Rn//fziVyZnMp8PQLICnYLqGqYnehR8uSBj8A
 jGFHhfEzTzlw==
X-IronPort-AV: E=Sophos;i="5.78,357,1599548400"; 
   d="scan'208";a="357852085"
Received: from sabakhle-mobl1.amr.corp.intel.com (HELO jderrick-mobl.amr.corp.intel.com) ([10.213.165.80])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2020 14:51:54 -0800
From:   Jon Derrick <jonathan.derrick@intel.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
        Nirmal Patel <nirmal.patel@intel.com>,
        Sushma Kalakota <sushmax.kalakota@intel.com>,
        Jon Derrick <jonathan.derrick@intel.com>
Subject: [PATCH 3/5] PCI: vmd: Add offset translation helper
Date:   Fri, 20 Nov 2020 15:51:42 -0700
Message-Id: <20201120225144.15138-4-jonathan.derrick@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201120225144.15138-1-jonathan.derrick@intel.com>
References: <20201120225144.15138-1-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Adds a helper for translating physical addresses to bridge window
offsets. No functional changes.

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 drivers/pci/controller/vmd.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index c7b5614..b0504ee 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -483,6 +483,16 @@ static int vmd_find_free_domain(void)
 	return domain + 1;
 }
 
+static void vmd_phys_to_offset(struct vmd_dev *vmd, u64 phys1, u64 phys2,
+				 resource_size_t *offset1,
+				 resource_size_t *offset2)
+{
+	*offset1 = vmd->dev->resource[VMD_MEMBAR1].start -
+			(phys1 & PCI_BASE_ADDRESS_MEM_MASK);
+	*offset2 = vmd->dev->resource[VMD_MEMBAR2].start -
+			(phys2 & PCI_BASE_ADDRESS_MEM_MASK);
+}
+
 static int vmd_get_phys_offsets(struct vmd_dev *vmd, bool native_hint,
 				resource_size_t *offset1,
 				resource_size_t *offset2)
@@ -507,8 +517,8 @@ static int vmd_get_phys_offsets(struct vmd_dev *vmd, bool native_hint,
 			phys1 = readq(membar2 + MB2_SHADOW_OFFSET);
 			phys2 = readq(membar2 + MB2_SHADOW_OFFSET + 8);
 			pci_iounmap(dev, membar2);
-		} else
-			return 0;
+			vmd_phys_to_offset(vmd, phys1, phys2, offset1, offset2);
+		}
 	} else {
 		/* Hypervisor-Emulated Vendor-Specific Capability */
 		int pos = pci_find_capability(dev, PCI_CAP_ID_VNDR);
@@ -525,15 +535,10 @@ static int vmd_get_phys_offsets(struct vmd_dev *vmd, bool native_hint,
 			pci_read_config_dword(dev, pos + 16, &reg);
 			pci_read_config_dword(dev, pos + 20, &regu);
 			phys2 = (u64) regu << 32 | reg;
-		} else
-			return 0;
+			vmd_phys_to_offset(vmd, phys1, phys2, offset1, offset2);
+		}
 	}
 
-	*offset1 = dev->resource[VMD_MEMBAR1].start -
-			(phys1 & PCI_BASE_ADDRESS_MEM_MASK);
-	*offset2 = dev->resource[VMD_MEMBAR2].start -
-			(phys2 & PCI_BASE_ADDRESS_MEM_MASK);
-
 	return 0;
 }
 
-- 
1.8.3.1

