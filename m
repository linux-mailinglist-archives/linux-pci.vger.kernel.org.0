Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E79286749D9
	for <lists+linux-pci@lfdr.de>; Fri, 20 Jan 2023 04:15:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjATDPc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Jan 2023 22:15:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjATDP3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Jan 2023 22:15:29 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D33728F7DB;
        Thu, 19 Jan 2023 19:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674184527; x=1705720527;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=p82/P5FyL4hjQWeYsD2JZOeD1zgyf9FQ2v36bO41SHQ=;
  b=RKwMfqbBrPthSCyIM0PhWYYO+LlLbe/PIGwrhxzPK3RP/tAJ86Mg+P4L
   YAg5O1Vfc+L4k09f6HK4LJ2xfVSzsSPVEfWwOJk6XJEU4IM1N+cWHgtMF
   PWK2VM/aPSARsoJ5N11kG/lJCBduKEdFgJ9AMDvSZEcbwYLTn1bMWpuqu
   721nmex20vZUXkYDUPYSs5CxJCInZt+Lr9ozzXTUlLQuDOeDF6s030MiG
   crl5xdGCRePMVd+t2lLlIU+Ywg1G1a9Ya1GeUIV4jJC8reLDsn63r4oyB
   myC7n2uOvPl+xyt+FcZHGUOMI3/teFC5v4HnUiwEeJkcTBWAoDo/khF4P
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="390012695"
X-IronPort-AV: E=Sophos;i="5.97,230,1669104000"; 
   d="scan'208";a="390012695"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 19:15:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="638009317"
X-IronPort-AV: E=Sophos;i="5.97,230,1669104000"; 
   d="scan'208";a="638009317"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 19 Jan 2023 19:15:23 -0800
Received: from debox1-desk4.intel.com (unknown [10.212.255.207])
        by linux.intel.com (Postfix) with ESMTP id 67143580AFF;
        Thu, 19 Jan 2023 19:15:23 -0800 (PST)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     david.e.box@linux.intel.com, nirmal.patel@linux.intel.com,
        jonathan.derrick@linux.dev, lorenzo.pieralisi@arm.com,
        hch@infradead.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, michael.a.bottini@intel.com,
        rafael@kernel.org, me@adhityamohan.in
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V10 3/4] PCI: vmd: Create feature grouping for client products
Date:   Thu, 19 Jan 2023 19:15:21 -0800
Message-Id: <20230120031522.2304439-4-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230120031522.2304439-1-david.e.box@linux.intel.com>
References: <20230120031522.2304439-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,UPPERCASE_50_75 autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Simplify the device ID list by creating a grouping of features shared by
client products.

Suggested-by: Jon Derrick <jonathan.derrick@linux.dev>
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
 V10 - No change.

 V9 - No change.

 V8 - New patch.

 drivers/pci/controller/vmd.c | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 1fc3f2174359..47fa3e5f2dc5 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -68,6 +68,10 @@ enum vmd_features {
 	VMD_FEAT_CAN_BYPASS_MSI_REMAP		= (1 << 4),
 };
 
+#define VMD_FEATS_CLIENT	(VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |	\
+				 VMD_FEAT_HAS_BUS_RESTRICTIONS |	\
+				 VMD_FEAT_OFFSET_FIRST_VECTOR)
+
 static DEFINE_IDA(vmd_instance_ida);
 
 /*
@@ -1024,29 +1028,17 @@ static const struct pci_device_id vmd_ids[] = {
 				VMD_FEAT_HAS_BUS_RESTRICTIONS |
 				VMD_FEAT_CAN_BYPASS_MSI_REMAP,},
 	{PCI_VDEVICE(INTEL, 0x467f),
-		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
-				VMD_FEAT_HAS_BUS_RESTRICTIONS |
-				VMD_FEAT_OFFSET_FIRST_VECTOR,},
+		.driver_data = VMD_FEATS_CLIENT,},
 	{PCI_VDEVICE(INTEL, 0x4c3d),
-		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
-				VMD_FEAT_HAS_BUS_RESTRICTIONS |
-				VMD_FEAT_OFFSET_FIRST_VECTOR,},
+		.driver_data = VMD_FEATS_CLIENT,},
 	{PCI_VDEVICE(INTEL, 0xa77f),
-		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
-				VMD_FEAT_HAS_BUS_RESTRICTIONS |
-				VMD_FEAT_OFFSET_FIRST_VECTOR,},
+		.driver_data = VMD_FEATS_CLIENT,},
 	{PCI_VDEVICE(INTEL, 0x7d0b),
-		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
-				VMD_FEAT_HAS_BUS_RESTRICTIONS |
-				VMD_FEAT_OFFSET_FIRST_VECTOR,},
+		.driver_data = VMD_FEATS_CLIENT,},
 	{PCI_VDEVICE(INTEL, 0xad0b),
-		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
-				VMD_FEAT_HAS_BUS_RESTRICTIONS |
-				VMD_FEAT_OFFSET_FIRST_VECTOR,},
+		.driver_data = VMD_FEATS_CLIENT,},
 	{PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_VMD_9A0B),
-		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
-				VMD_FEAT_HAS_BUS_RESTRICTIONS |
-				VMD_FEAT_OFFSET_FIRST_VECTOR,},
+		.driver_data = VMD_FEATS_CLIENT,},
 	{0,}
 };
 MODULE_DEVICE_TABLE(pci, vmd_ids);
-- 
2.34.1

