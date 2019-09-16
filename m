Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB5FB416F
	for <lists+linux-pci@lfdr.de>; Mon, 16 Sep 2019 21:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391092AbfIPTzw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Sep 2019 15:55:52 -0400
Received: from mga01.intel.com ([192.55.52.88]:35459 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732696AbfIPTzt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 16 Sep 2019 15:55:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Sep 2019 12:55:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,513,1559545200"; 
   d="scan'208";a="177152715"
Received: from unknown (HELO debian-vmd.lm.intel.com) ([10.232.112.42])
  by orsmga007.jf.intel.com with ESMTP; 16 Sep 2019 12:55:48 -0700
From:   Jon Derrick <jonathan.derrick@intel.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Keith Busch <keith.busch@intel.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] PCI: vmd: Fix shadow offsets to reflect spec changes
Date:   Mon, 16 Sep 2019 07:54:35 -0600
Message-Id: <20190916135435.5017-3-jonathan.derrick@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190916135435.5017-1-jonathan.derrick@intel.com>
References: <20190916135435.5017-1-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The shadow offset scratchpad was moved to 0x2000-0x2010. Update the
location to get the correct shadow offset.

Cc: stable@vger.kernel.org # v5.2+
Fixes: 6788958e ("PCI: vmd: Assign membar addresses from shadow registers")
Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 drivers/pci/controller/vmd.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 2e4da3f51d6b..a35d3f3996d7 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -31,6 +31,9 @@
 #define PCI_REG_VMLOCK		0x70
 #define MB2_SHADOW_EN(vmlock)	(vmlock & 0x2)
 
+#define MB2_SHADOW_OFFSET	0x2000
+#define MB2_SHADOW_SIZE		16
+
 enum vmd_features {
 	/*
 	 * Device may contain registers which hint the physical location of the
@@ -578,7 +581,7 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 		u32 vmlock;
 		int ret;
 
-		membar2_offset = 0x2018;
+		membar2_offset = MB2_SHADOW_OFFSET + MB2_SHADOW_SIZE;
 		ret = pci_read_config_dword(vmd->dev, PCI_REG_VMLOCK, &vmlock);
 		if (ret || vmlock == ~0)
 			return -ENODEV;
@@ -590,9 +593,9 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 			if (!membar2)
 				return -ENOMEM;
 			offset[0] = vmd->dev->resource[VMD_MEMBAR1].start -
-						readq(membar2 + 0x2008);
+					readq(membar2 + MB2_SHADOW_OFFSET);
 			offset[1] = vmd->dev->resource[VMD_MEMBAR2].start -
-						readq(membar2 + 0x2010);
+					readq(membar2 + MB2_SHADOW_OFFSET + 8);
 			pci_iounmap(vmd->dev, membar2);
 		}
 	}
-- 
2.20.1

