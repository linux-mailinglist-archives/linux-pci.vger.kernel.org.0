Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1CC45E8448
	for <lists+linux-pci@lfdr.de>; Fri, 23 Sep 2022 22:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233221AbiIWUpo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Sep 2022 16:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233234AbiIWUpT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Sep 2022 16:45:19 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA091284BD
        for <linux-pci@vger.kernel.org>; Fri, 23 Sep 2022 13:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663965680; x=1695501680;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8M5acJ2HkiH1o+cRLITNX3gtv9ppRjyFzjQQ7Ni+/74=;
  b=PobzNgGeCUFkNh9h7tordsOI0NRr2A2mZjcpHTIRBtNpRFbSdv5Y88sN
   h8zv03Y/9b5kIY0vgI9YkuVpm5cQLpLFb2pEpv8Wxz7dIWK4rNZhXtMd2
   i0VSSsEjJVknlbimLc/pQi5WvWUF8Dr6xAudf1nSAQdI8GsNC5rjfDMXp
   ku+PfLdxp4OodyFHr+jPVfzIM7hlIphv6V1IG0q48S1cZxlOO3O1w1TN7
   ZNiqTH576URmcigzA8jWERj9m2fnN1K6ZjK6ICpfqoQGuqebepjDNNSb9
   /D7ZgtmVaIWkXx6Qa2mg5nRCKd6Nj6EBoblFiPtz6b1iBusk94TVkgPEF
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10479"; a="280418145"
X-IronPort-AV: E=Sophos;i="5.93,340,1654585200"; 
   d="scan'208";a="280418145"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 13:41:19 -0700
X-IronPort-AV: E=Sophos;i="5.93,340,1654585200"; 
   d="scan'208";a="724281565"
Received: from francisco-wc.ch.intel.com ([10.2.230.36])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 13:41:19 -0700
From:   francisco.munoz.ruiz@linux.intel.com
To:     helgaas@kernel.org, lorenzo.pieralisi@arm.com
Cc:     jonathan.derrick@linux.dev, linux-pci@vger.kernel.org,
        Francisco Munoz <francisco.munoz.ruiz@linux.intel.com>,
        Nirmal Patel <nirmal.patel@linux.intel.com>
Subject: [PATCH] PCI: vmd: Fix secondary bus reset for Intel bridges
Date:   Fri, 23 Sep 2022 13:37:57 -0700
Message-Id: <20220923203757.4918-1-francisco.munoz.ruiz@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Francisco Munoz <francisco.munoz.ruiz@linux.intel.com>

The reset was never applied in the current implementation because Intel
Bridges owned by VMD are parentless. Internally, the reset API applies
a reset to the parent of the pci device supplied as argument, but in this
case it failed because there wasn't a parent. This change feeds a child
device of an Intel Bridge to the reset API and internally the reset is
applied to its parent.

Signed-off-by: Francisco Munoz <francisco.munoz.ruiz@linux.intel.com>
Reviewed-by: Nirmal Patel <nirmal.patel@linux.intel.com>
---
 drivers/pci/controller/vmd.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index e06e9f4fc50f..34d6ba675440 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -859,8 +859,16 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 
 	pci_scan_child_bus(vmd->bus);
 	vmd_domain_reset(vmd);
-	list_for_each_entry(child, &vmd->bus->children, node)
-		pci_reset_bus(child->self);
+
+	list_for_each_entry(child, &vmd->bus->children, node) {
+		if (!list_empty(&child->devices)) {
+			pci_reset_bus(list_first_entry(&child->devices,
+						       struct pci_dev,
+						       bus_list));
+			break;
+		}
+	}
+
 	pci_assign_unassigned_bus_resources(vmd->bus);
 
 	/*
-- 
2.25.1

