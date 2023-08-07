Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BAB47730E7
	for <lists+linux-pci@lfdr.de>; Mon,  7 Aug 2023 23:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbjHGVII (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Aug 2023 17:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjHGVII (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Aug 2023 17:08:08 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F705B6
        for <linux-pci@vger.kernel.org>; Mon,  7 Aug 2023 14:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691442487; x=1722978487;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2nTdv/xqxHRd+c6pWCgvHUz9diY2VEs0/f4FN8mJBvg=;
  b=UG9d1CwxeLdswOBCBQ7FPaz726OF8MYgdKszbwnkF0RNsXVdmJdvJ2ky
   3M8BQJZFbKj6Zd84v06TrH7qob9LP/RL+4BgA1vOu13wkGSza+PaR2GqN
   1ZxRN60SNZZjHGvGTWQHTbDdGNC8g0var4X16kyMM17ffLvEIaFc9LbbR
   m5EeIQJlLbUvCJqqIvrXAetr8sgUYWRZdtuYhFziAwfHrK0UfLPzce1KY
   +jti31kFWS/cztFKRAj16CJQgWcdE/9uRqUTrYoR0FlJqDSXZ1Eqe0G7G
   ec1ZjSBdOFtazaFWIWsEaauCmpkQKErOAOJxfdMlPkk8JaRhaqVb5PnMd
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="373405178"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200"; 
   d="scan'208";a="373405178"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2023 14:08:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="801091509"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200"; 
   d="scan'208";a="801091509"
Received: from unknown (HELO localhost.ch.intel.com) ([10.2.230.30])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2023 14:07:57 -0700
From:   Nirmal Patel <nirmal.patel@linux.intel.com>
To:     nirmal.patel@linux.intel.com, <linux-pci@vger.kernel.org>
Subject: [PATCH v3] PCI: vmd: Disable bridge window for domain reset
Date:   Mon,  7 Aug 2023 16:45:20 -0400
Message-Id: <20230807204520.1088801-1-nirmal.patel@linux.intel.com>
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
enabled.

This is believed to be the reason for the failure and in addition the
sequence of operation in vmd_domain_reset() is not following the PCIe
specs.

Here is the quote from section 7.5.1.3.9 of PCI Express Base 6.0 spec:

  The Prefetchable Memory Limit register must be programmed to a smaller
  value than the Prefetchable Memory Base register if there is no
  prefetchable memory on the secondary side of the bridg

Disable the bridge window by executing a sequence of operations
borrowed from pci_disable_bridge_window(), that comply with the
PCI specifications.

Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>
---
v3->v3: Add more information to commit description.
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

