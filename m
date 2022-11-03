Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 669F4618978
	for <lists+linux-pci@lfdr.de>; Thu,  3 Nov 2022 21:18:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbiKCUSJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Nov 2022 16:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiKCUSJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Nov 2022 16:18:09 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340906366
        for <linux-pci@vger.kernel.org>; Thu,  3 Nov 2022 13:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667506688; x=1699042688;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=aAdWVXHTb177G751WHatq5ymCONeNx+sLZq7xLX09tI=;
  b=hxxI9iaOz7+WB2HDp326SJBskvM+EeU+LP4zBm5JaRE18yJ+bVnxdtpF
   OhXCa/d7Ji/gdyJQ/myxJeJY8w0LCaBLBb7qWfTUOoqIgUnO6DPWDAN9B
   zYBFWB7lcffyaQJz2r93ikmK63iRfqou0X1acE/acz3ny34PqWvgIAIAQ
   /nLXu+as2lmZ2Vamf00rs5JETN4R+P8FkH+CdcKUhTxsEyz2CxSm1mMTx
   Q9Li4WfFyUPXXhpHTgqM41I97sXxJLKmwZSnq/cQjC8QaWzcvoDfuQbRi
   vz/J0FpZXXIAfrBioaIehOR1uW+sygsWVYamqgxfSvCbiynHf1FHcyo1/
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="374030304"
X-IronPort-AV: E=Sophos;i="5.96,135,1665471600"; 
   d="scan'208";a="374030304"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 13:18:07 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="964075379"
X-IronPort-AV: E=Sophos;i="5.96,135,1665471600"; 
   d="scan'208";a="964075379"
Received: from francisco-wc.ch.intel.com ([10.2.230.36])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 13:18:06 -0700
From:   francisco.munoz.ruiz@linux.intel.com
To:     helgaas@kernel.org, alex.williamson@redhat.com,
        myron.stowe@redhat.com
Cc:     lorenzo.pieralisi@arm.com, jonathan.derrick@linux.dev,
        linux-pci@vger.kernel.org,
        Francisco Munoz <francisco.munoz.ruiz@linux.intel.com>,
        Nirmal Patel <nirmal.patel@linux.intel.com>
Subject: [PATCH V3] PCI: vmd: Fix secondary bus reset for Intel bridges
Date:   Thu,  3 Nov 2022 13:14:07 -0700
Message-Id: <20221103201407.3158-1-francisco.munoz.ruiz@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
in pass-through configurations when guest reboots are performed. Commit id
6aab5622296b ("PCI: vmd: Clean up domain before enumeration") attempted to
fix this, but later we discovered that the code inside pci_reset_bus() wasn’t
triggering secondary bus resets.  Therefore, we updated the parameters passed
to it, and now NVMe SSDs attached to VMD bridges are properly enumerated in
VT-d pass-through scenarios.

Signed-off-by: Francisco Munoz <francisco.munoz.ruiz@linux.intel.com>
Reviewed-by: Nirmal Patel <nirmal.patel@linux.intel.com>
Reviewed-by: Jonathan Derrick <jonathan.derrick@linux.dev>
---
V3:
    - Add WARN_ON
    - Include Jonathan as reviewer
    - Update commit message
V2:
    - Update commit message

 drivers/pci/controller/vmd.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index e06e9f4fc50f..2406be6644f3 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -859,8 +859,17 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 
 	pci_scan_child_bus(vmd->bus);
 	vmd_domain_reset(vmd);
-	list_for_each_entry(child, &vmd->bus->children, node)
-		pci_reset_bus(child->self);
+
+	list_for_each_entry(child, &vmd->bus->children, node) {
+		if (!list_empty(&child->devices)) {
+			ret = pci_reset_bus(list_first_entry(&child->devices,
+							     struct pci_dev,
+							     bus_list));
+			WARN_ON(ret);
+			break;
+		}
+	}
+
 	pci_assign_unassigned_bus_resources(vmd->bus);
 
 	/*
-- 
2.25.1

