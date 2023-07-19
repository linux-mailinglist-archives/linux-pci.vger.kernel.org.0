Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6D6E75A06A
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jul 2023 23:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbjGSVQG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Jul 2023 17:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjGSVQG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Jul 2023 17:16:06 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EBE91FC0
        for <linux-pci@vger.kernel.org>; Wed, 19 Jul 2023 14:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689801365; x=1721337365;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YjYJXFZNKRa829Ef6CvuA69cIbjy+2D6KMvVRB+QSjQ=;
  b=JiCxmPDuNxw4vBG0VXkEsx05MVnvoOzA37jHJudZ4+1jiZwgcYuMVG45
   u/dCRg9J5cE7ITM3YoNvH8fVPXR34+KjM6xPgNx4VRSMesf6LBVQMISSp
   0yEPLUPIqmaOuY/MHIxp6iK7z/Z1EXNneEq1R+OevIZuuhOfYsbBz3Y1A
   EyCSN5vUSjMtmA2IylfeYYzx7WL4C0BzFibzPD2H31KMYhIOAApGVS7k5
   QjHnNI/Mn0EEaIUShuSDVqCBsAyz8McR6VlwiGpM5cGa3uZ2PkRtvrlyh
   CP+88dOjD7lcndBqGnmRqGxA0E8nDdrsR553M4C9yhYzR/S79ClmkGAdU
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="370139076"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="370139076"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2023 14:16:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="701395418"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="701395418"
Received: from unknown (HELO localhost.ch.intel.com) ([10.2.230.30])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2023 14:16:04 -0700
From:   Nirmal Patel <nirmal.patel@linux.intel.com>
To:     nirmal.patel@linux.intel.com, <linux-pci@vger.kernel.org>
Subject: [PATCH v2] PCI: vmd: Disable bridge window for domain reset
Date:   Wed, 19 Jul 2023 16:56:10 -0400
Message-Id: <20230719205610.922324-1-nirmal.patel@linux.intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

During domain reset process we are accidentally enabling
the prefetchable memory by writing 0x0 to Prefetchable Memory
Base and Prefetchable Memory Limit registers. As a result certain
platforms failed to boot up.

When clearing Prefetchable Memory Base, Prefetchable Memory
Limit and Prefetchable Base Upper 32 bits, the prefetchable
memory range becomes 0x0-0x575000fffff. As a result the
prefetchable memory is enabled accidentally. There is a gap
between implementation and the PCI Express spec.

Here is the quote from section 7.5.1.3.9 of PCI Express Base 6.0 spec:

  The Prefetchable Memory Limit register must be programmed to a smaller
  value than the Prefetchable Memory Base register if there is no
  prefetchable memory on the secondary side of the bridge.

Write proper values to required Memory Base registers and follow
same the style as  pci_disable_bridge_window.

Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>
---
v1->v2: Follow same chain of operation as pci_disable_bridge_window
        and update commit log.
---
 drivers/pci/controller/vmd.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 769eedeb8802..ca9081be917d 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -526,8 +526,16 @@ static void vmd_domain_reset(struct vmd_dev *vmd)
 				     PCI_CLASS_BRIDGE_PCI))
 					continue;
 
-				memset_io(base + PCI_IO_BASE, 0,
-					  PCI_ROM_ADDRESS1 - PCI_IO_BASE);
+				writel(0, base + PCI_IO_BASE);
+				/* MMIO Base/Limit */
+				writel(0x0000fff0, base + PCI_MEMORY_BASE);
+
+				/* Prefetchable MMIO Base/Limit */
+				writel(0, base + PCI_PREF_LIMIT_UPPER32);
+				writel(0x0000fff0, base + PCI_PREF_MEMORY_BASE);
+				writel(0xffffffff, base + PCI_PREF_BASE_UPPER32);
+				writel(0, base + PCI_IO_BASE_UPPER16);
+				writeb(0, base + PCI_CAPABILITY_LIST);
 			}
 		}
 	}
-- 
2.31.1

