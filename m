Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFF2E776B0D
	for <lists+linux-pci@lfdr.de>; Wed,  9 Aug 2023 23:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232191AbjHIVia (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Aug 2023 17:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbjHIVia (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Aug 2023 17:38:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466851BCF
        for <linux-pci@vger.kernel.org>; Wed,  9 Aug 2023 14:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691617109; x=1723153109;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Z3KdIJWJzreqm09c8s71JBRGDg7rW1K1+OW3npQcbUk=;
  b=ezD6Vk20EWTwEKhsPKZaBicCeqfYJmTp/xh21a/7hxgmdv2Pgabo7uOP
   RTuqAaLh5Lqfyt5DJbsKMXBEsKU5hYOhbxtbwL2A0FQVQ1VtpBy9v/RIt
   ezedz6NEu8CVA/hQwEDAxts67CoXBBHAo3eUNYPiSsFp5T7n+nvC8uWy5
   3fKsfsmwE6yqY2idYKfx/8XGJ6ja/31yPgvjJyw/SHfCI4BuM/Jge4H2d
   MMSY5Mv0AIv+By1jCVpRysqbOoxAL8crbZ0O4RWdV0pPSUIqVGEkMYVJn
   rK7MeCFWADVYRmfB03T2esqzgMzpeyhWYPTd2zPQW64l+nSaO0Dhpcc+u
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="361370106"
X-IronPort-AV: E=Sophos;i="6.01,160,1684825200"; 
   d="scan'208";a="361370106"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 14:38:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="905800304"
X-IronPort-AV: E=Sophos;i="6.01,160,1684825200"; 
   d="scan'208";a="905800304"
Received: from unknown (HELO localhost.ch.intel.com) ([10.2.230.30])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 14:38:28 -0700
From:   Nirmal Patel <nirmal.patel@linux.intel.com>
To:     nirmal.patel@linux.intel.com, <linux-pci@vger.kernel.org>
Subject: [PATCH v4] PCI: vmd: Disable bridge window for domain reset
Date:   Wed,  9 Aug 2023 17:14:54 -0400
Message-Id: <20230809211454.1150589-1-nirmal.patel@linux.intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
v3->v4: Following same operation as pci_setup_bridge_io.
v2->v3: Add more information to commit description.
v1->v2: Follow same chain of operation as pci_disable_bridge_window
        and update commit log.
---
 drivers/pci/controller/vmd.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 769eedeb8802..ae5b4c1704e4 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -526,8 +526,21 @@ static void vmd_domain_reset(struct vmd_dev *vmd)
 				     PCI_CLASS_BRIDGE_PCI))
 					continue;
 
-				memset_io(base + PCI_IO_BASE, 0,
-					  PCI_ROM_ADDRESS1 - PCI_IO_BASE);
+				/* Temporarily disable the I/O range before updating PCI_IO_BASE */
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
+				writeb(0, base + PCI_CAPABILITY_LIST);
 			}
 		}
 	}
-- 
2.31.1

