Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60AC777837D
	for <lists+linux-pci@lfdr.de>; Fri, 11 Aug 2023 00:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbjHJWNh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Aug 2023 18:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbjHJWNh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Aug 2023 18:13:37 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 024C92717
        for <linux-pci@vger.kernel.org>; Thu, 10 Aug 2023 15:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691705616; x=1723241616;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jH3rAY32ezogdL6tn5YLkttVl4VuOAWf7ilO5OOGm3M=;
  b=PAHK7Tamc9B91YiE2q4zVRUPVmeMOX9QLw4iXCvdTjemFzl9mwFAokdB
   BH7iVFlsG7IzTBBM9xL61dvRtcB7qgF1sWBklNqqCos6srxAiGUw1Q2z+
   z21QoGyCo5anwoPui2XeOR4hTuLSWCjBZBzJr9oz4uNk0khrlT8zo/J/V
   udERBjekjS7te+cUxVWgiM7/xsR+SP8tKyYGpHPlL/MyIFm9ljeoiCerT
   n91dCD40Kz5jxYRN+F7/SFXKucCV2eMeE7kGlLUn93JTm73YOUrukm9Vb
   gUa564PsCnqQdtw2y3y399NjDgyOAMvNGbsVmkUo0u3Ji/5Orn3vzWOKd
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="374302585"
X-IronPort-AV: E=Sophos;i="6.01,163,1684825200"; 
   d="scan'208";a="374302585"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 15:13:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="767426865"
X-IronPort-AV: E=Sophos;i="6.01,163,1684825200"; 
   d="scan'208";a="767426865"
Received: from unknown (HELO localhost.ch.intel.com) ([10.2.230.30])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 15:13:35 -0700
From:   Nirmal Patel <nirmal.patel@linux.intel.com>
To:     nirmal.patel@linux.intel.com, <linux-pci@vger.kernel.org>
Subject: [PATCH v5] PCI: vmd: Disable bridge window for domain reset
Date:   Thu, 10 Aug 2023 17:50:29 -0400
Message-Id: <20230810215029.1177379-1-nirmal.patel@linux.intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

During domain reset process vmd_domain_reset() clears PCI
configuration space of VMD root ports. But certain platform
has observed following errors and failed to boot.
  ...
  DMAR: VT-d detected Invalidation Queue Error: Reason f
  DMAR: VT-d detected Invalidation Time-out Error: SID ffff
  DMAR: VT-d detected Invalidation Completion Error: SID ffff
  DMAR: QI HEAD: UNKNOWN qw0 = 0x0, qw1 = 0x0
  DMAR: QI PRIOR: UNKNOWN qw0 = 0x0, qw1 = 0x0
  DMAR: Invalidation Time-out Error (ITE) cleared

The root cause is that memset_io() clears prefetchable memory base/limit
registers and prefetchable base/limit 32 bits registers sequentially.
This seems to be enabling prefetchable memory if the device disabled
prefetchable memory originally.

Here is an example (before memset_io()):

  PCI configuration space for 10000:00:00.0:
  86 80 30 20 06 00 10 00 04 00 04 06 00 00 01 00
  00 00 00 00 00 00 00 00 00 01 01 00 00 00 00 20
  00 00 00 00 01 00 01 00 ff ff ff ff 75 05 00 00
  ...

So, prefetchable memory is ffffffff00000000-575000fffff, which is
disabled. When memset_io() clears prefetchable base 32 bits register,
the prefetchable memory becomes 0000000000000000-575000fffff, which is
enabled and incorrect.

Here is the quote from section 7.5.1.3.9 of PCI Express Base 6.0 spec:

  The Prefetchable Memory Limit register must be programmed to a smaller
  value than the Prefetchable Memory Base register if there is no
  prefetchable memory on the secondary side of the bridge.

This is believed to be the reason for the failure and in addition the
sequence of operation in vmd_domain_reset() is not following the PCIe
specs.

Disable the bridge window by executing a sequence of operations
borrowed from pci_disable_bridge_window() and pci_setup_bridge_io(),
that comply with the PCI specifications.

Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>
---
v4->v5: Revome PCI_CAPABILITY_LIST from the reset.
v3->v4: Following same operation as pci_setup_bridge_io.
v2->v3: Add more information to commit description.
v1->v2: Follow same chain of operation as pci_disable_bridge_window
        and update commit log.
---
 drivers/pci/controller/vmd.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 769eedeb8802..c5b1295ab208 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -526,8 +526,23 @@ static void vmd_domain_reset(struct vmd_dev *vmd)
 				     PCI_CLASS_BRIDGE_PCI))
 					continue;
 
-				memset_io(base + PCI_IO_BASE, 0,
-					  PCI_ROM_ADDRESS1 - PCI_IO_BASE);
+				/*
+				 * Temporarily disable the I/O range before updating
+				 * PCI_IO_BASE.
+				 */
+				writel(0x0000ffff, base + PCI_IO_BASE_UPPER16);
+				/* Update lower 16 bits of I/O base/limit */
+				writew(0x00f0, base + PCI_IO_BASE);
+				/* Update upper 16 bits of I/O base/limit */
+				writel(0, base + PCI_IO_BASE_UPPER16);
+
+				/* MMIO Base/Limit */
+				writel(0x0000fff0, base + PCI_MEMORY_BASE);
+
+				/* Prefetchable MMIO Base/Limit */
+				writel(0, base + PCI_PREF_LIMIT_UPPER32);
+				writel(0x0000fff0, base + PCI_PREF_MEMORY_BASE);
+				writel(0xffffffff, base + PCI_PREF_BASE_UPPER32);
 			}
 		}
 	}
-- 
2.31.1

