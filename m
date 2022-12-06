Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1AE6439DC
	for <lists+linux-pci@lfdr.de>; Tue,  6 Dec 2022 01:21:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbiLFAVY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Dec 2022 19:21:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiLFAVX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Dec 2022 19:21:23 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E34A31DDFB
        for <linux-pci@vger.kernel.org>; Mon,  5 Dec 2022 16:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670286082; x=1701822082;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sJtvBVVosCdO10ejLTwxoRjDxeJsK+OZ8LttXRFf6a8=;
  b=OGTEaFhacQrdcoi0RjlCi/72VUMgXQTZVb802HgmH9owzlulIXiaU7jk
   qVteZARwDYMI60ko6SNdQAy3COZwQvmlW/evLbwtXf4HvPwJwEhlUUHWU
   QbCW/oLL/6sI7FjsH7V9l9E3JKROjy9uHgHCXDkLUVkOIB5C8YI9U9hdV
   OkyB8iJj8Q+fay7ABY1NvyEpVtIeXSxgh4cTNprLKanvNLF4qBBAKOCUm
   sMEGld71B+gd9G2wyOz0yyYzZlcuR9fVWz+xo7sdWg+OLYlHYQWS3SYY/
   0oF4Gsl10TtsqxWq1Q1MlzBKExW84x/UYrgQ1apyBVQkftchYxtTFpy5x
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="380791543"
X-IronPort-AV: E=Sophos;i="5.96,220,1665471600"; 
   d="scan'208";a="380791543"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 16:21:19 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="623701717"
X-IronPort-AV: E=Sophos;i="5.96,220,1665471600"; 
   d="scan'208";a="623701717"
Received: from francisco-wc.ch.intel.com ([10.2.230.36])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 16:21:19 -0800
From:   francisco.munoz.ruiz@linux.intel.com
To:     alex.williamson@redhat.com, myron.stowe@redhat.com,
        lorenzo.pieralisi@arm.com
Cc:     helgaas@kernel.org, jonathan.derrick@linux.dev,
        linux-pci@vger.kernel.org,
        Francisco Munoz <francisco.munoz.ruiz@linux.intel.com>,
        Nirmal Patel <nirmal.patel@linux.intel.com>
Subject: [PATCH V4] PCI: vmd: Fix secondary bus reset for Intel bridges
Date:   Mon,  5 Dec 2022 17:16:37 -0700
Message-Id: <20221206001637.4744-1-francisco.munoz.ruiz@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Francisco Munoz <francisco.munoz.ruiz@linux.intel.com>

The reset was never applied in the current implementation because Intel
Bridges owned by VMD are parentless. Internally, pci_reset_bus() applies
a reset to the parent of the PCI device supplied as argument, but in this
case it failed because there wasn't a parent.

In more detail, this change allows the VMD driver to enumerate NVMe devices
in pass-through configurations when guest reboots are performed. There was
an attempted to fix this, but later we discovered that the code inside
pci_reset_bus() wasn’t triggering secondary bus resets. Therefore, we
updated the parameters passed to it, and now NVMe SSDs attached to VMD
bridges are properly enumerated in VT-d pass-through scenarios.

Fixes: 6aab5622296b ("PCI: vmd: Clean up domain before enumeration")
Signed-off-by: Francisco Munoz <francisco.munoz.ruiz@linux.intel.com>
Reviewed-by: Nirmal Patel <nirmal.patel@linux.intel.com>
Reviewed-by: Jonathan Derrick <jonathan.derrick@linux.dev>
---
V4:
    - Changed WARN_ON() for pci_warn()
    - Introduced an explanation in code
    - Update commit message
V3:
    - Add WARN_ON()
    - Include Jonathan as reviewer
    - Update commit message
V2:
    - Update commit message

 drivers/pci/controller/vmd.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index e06e9f4fc50f..6d5373173011 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -719,6 +719,7 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 	resource_size_t offset[2] = {0};
 	resource_size_t membar2_offset = 0x2000;
 	struct pci_bus *child;
+	struct pci_dev *dev;
 	int ret;
 
 	/*
@@ -859,8 +860,25 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 
 	pci_scan_child_bus(vmd->bus);
 	vmd_domain_reset(vmd);
-	list_for_each_entry(child, &vmd->bus->children, node)
-		pci_reset_bus(child->self);
+
+	/* When Intel VMD is enabled, the OS does not discover the Root Ports
+	 * owned by Intel VMD within the MMCFG space. pci_reset_bus() applies
+	 * a reset to the parent of the PCI device supplied as argument. This
+	 * is why we pass a child device, so the reset can be triggered at
+	 * the Intel bridge level and propagated to all the children in the
+	 * hierarchy.
+	 */
+	list_for_each_entry(child, &vmd->bus->children, node) {
+		if (!list_empty(&child->devices)) {
+			dev = list_first_entry(&child->devices,
+					       struct pci_dev, bus_list);
+			if (pci_reset_bus(dev))
+				pci_warn(dev, "can't reset device: %d\n", ret);
+
+			break;
+		}
+	}
+
 	pci_assign_unassigned_bus_resources(vmd->bus);
 
 	/*
-- 
2.25.1

