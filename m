Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9457614020
	for <lists+linux-pci@lfdr.de>; Mon, 31 Oct 2022 22:49:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbiJaVtJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 Oct 2022 17:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiJaVtI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 Oct 2022 17:49:08 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5435C13DD7
        for <linux-pci@vger.kernel.org>; Mon, 31 Oct 2022 14:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667252948; x=1698788948;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eGkxWvaxKV20uZTjktHtbaON8wam2e0PKrrvX+5D3O8=;
  b=Z66lRC78kOw5GLhJlHLN2mGpeJPBsIek200KEVvW4/eOz2O2Cyq6koiS
   LAfyeDAyIFYXBIpikeAnH03/DxsC2BSf2MZCci6DA8zKFT9srb6riyjLg
   N6m9Hl0oAiRMdSkAlxfy/GI31EZjMMztbcHN0SmlVAGR07d65sxmTDDaP
   6G7USYnsU6yIb40udpbkt9Y0uJC6C9S+Rz5LsJ0BVTCPGcZrpayq3JrIr
   pWsaTti/IIaWxqC+vppsVIkeGTn63zJZB2ImZriA2OKdnzRu1FwCRLJ0H
   e3dT80/L/gsoZQjsUOsHhXmy6hHL2+/pdrw4ZLVkdcywcLErliOF7OpMb
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="307732431"
X-IronPort-AV: E=Sophos;i="5.95,228,1661842800"; 
   d="scan'208";a="307732431"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2022 14:49:08 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="584802331"
X-IronPort-AV: E=Sophos;i="5.95,228,1661842800"; 
   d="scan'208";a="584802331"
Received: from francisco-wc.ch.intel.com ([10.2.230.36])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2022 14:49:07 -0700
From:   francisco.munoz.ruiz@linux.intel.com
To:     helgaas@kernel.org
Cc:     lorenzo.pieralisi@arm.com, jonathan.derrick@linux.dev,
        linux-pci@vger.kernel.org,
        Francisco Munoz <francisco.munoz.ruiz@linux.intel.com>,
        Nirmal Patel <nirmal.patel@linux.intel.com>
Subject: [PATCH V2] PCI: vmd: Fix secondary bus reset for Intel bridges
Date:   Mon, 31 Oct 2022 14:45:01 -0700
Message-Id: <20221031214501.28279-1-francisco.munoz.ruiz@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221024204534.GA589134@bhelgaas>
References: <20221024204534.GA589134@bhelgaas>
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
Bridges owned by VMD are parentless. Internally, pci_reset_bus applies
a reset to the parent of the pci device supplied as argument, but in this
case it failed because there wasn't a parent.

In more detail, this change allows the VMD driver to enumerate NVMe devices
in pass-through configurations when host reboots are performed. Commit id
“6aab5622296b990024ee67dd7efa7d143e7558d0” attempted to fix this, but
later we discovered that the code inside pci_reset_bus wasn’t triggering
secondary bus resets.  Therefore, we updated the parameters passed to
it, and now NVMe SSDs attached to VMD bridges are properly enumerated in
VT-d pass-through scenarios.

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

Hi Bjorn,

I updated the commit message with more details. Hopefully, this will 
clarify its purpose.

Thanks,
Francisco.
