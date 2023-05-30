Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD30717014
	for <lists+linux-pci@lfdr.de>; Tue, 30 May 2023 23:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233421AbjE3V7t (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 May 2023 17:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233628AbjE3V7s (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 May 2023 17:59:48 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D23CAA
        for <linux-pci@vger.kernel.org>; Tue, 30 May 2023 14:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685483976; x=1717019976;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Gs0a0e67Z1AGpqKObS7tTS6PkKI8LscyYZSog/7DaV0=;
  b=UXonn62DM7dgC7zlRBA9qqszyxO5oLYk7FfIsKj4TdGBLDvYUcys6+aL
   Zu31nkkpWNIUWUOHQX8oKuLhKHi0LgIg/MsjIZjW7caFEa/cfhvsW9c7x
   IB9RIQ3D50OhRr4Cz8mYTMmtBIoMcuhJD+PnBpAKpmf59vTUNw7y8jLW6
   CipcSyqinnThGi1rdJUjISBxVVho5G4i7OMWI0Gi5pyZwH2ZyFU6m5lvw
   YmU4e21Zx3czy8VfLIQHM5e1IEbGuLFIDXr0QMkaPsGDeeI18DKkA2LVs
   yDEKyNS0GV3S06g7CaqxKpsHH+MaQya6tjO9Um+w3qKl3LI/TdcHeO8zi
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="418545071"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="418545071"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 14:59:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="1036767090"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="1036767090"
Received: from unknown (HELO ocsbesrhlrepo01.amr.corp.intel.com) ([10.2.230.16])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 14:59:32 -0700
From:   Nirmal Patel <nirmal.patel@linux.intel.com>
To:     <linux-pci@vger.kernel.org>
Cc:     Nirmal Patel <nirmal.patel@linux.intel.com>
Subject: [PATCH] PCI: vmd: Fix domain reset operation
Date:   Tue, 30 May 2023 14:47:06 -0700
Message-Id: <20230530214706.75700-1-nirmal.patel@linux.intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

During domain reset process we are accidentally enabling
the prefetchable memory by writing 0x0 to Prefetchable Memory
Base and Prefetchable Memory Limit registers. As a result certain
platforms failed to boot up.

Here is the quote from section 7.5.1.3.9 of PCI Express Base 6.0 spec:

  The Prefetchable Memory Limit register must be programmed to a smaller
  value than the Prefetchable Memory Base register if there is no
  prefetchable memory on the secondary side of the bridge.

When clearing Prefetchable Memory Base, Prefetchable Memory
Limit and Prefetchable Base Upper 32 bits, the prefetchable
memory range becomes 0x0-0x575000fffff. As a result the
prefetchable memory is enabled accidentally.

Implementing correct operation by writing a value to Prefetchable
Base Memory larger than the value of Prefetchable Memory Limit.

Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>
---
 drivers/pci/controller/vmd.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 769eedeb8802..f3eb740e3028 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -526,8 +526,18 @@ static void vmd_domain_reset(struct vmd_dev *vmd)
 				     PCI_CLASS_BRIDGE_PCI))
 					continue;
 
-				memset_io(base + PCI_IO_BASE, 0,
-					  PCI_ROM_ADDRESS1 - PCI_IO_BASE);
+				writel(0, base + PCI_IO_BASE);
+				writew(0xFFF0, base + PCI_MEMORY_BASE);
+				writew(0, base + PCI_MEMORY_LIMIT);
+
+				writew(0xFFF1, base + PCI_PREF_MEMORY_BASE);
+				writew(0, base + PCI_PREF_MEMORY_LIMIT);
+
+				writel(0xFFFFFFFF, base + PCI_PREF_BASE_UPPER32);
+				writel(0, base + PCI_PREF_LIMIT_UPPER32);
+
+				writel(0, base + PCI_IO_BASE_UPPER16);
+				writeb(0, base + PCI_CAPABILITY_LIST);
 			}
 		}
 	}
-- 
2.27.0

