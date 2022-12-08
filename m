Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A90464671B
	for <lists+linux-pci@lfdr.de>; Thu,  8 Dec 2022 03:39:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbiLHCjt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Dec 2022 21:39:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbiLHCjs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Dec 2022 21:39:48 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 537C2D2DA;
        Wed,  7 Dec 2022 18:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670467187; x=1702003187;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=n2kbEHfcByHaWIZQ1y7JTsLS9250kq92PDDaSZGQ45k=;
  b=SMZxoU9pTiO8MNJLoiKu2tbAIdw5nthFGEntwCLjPPuDo8wkH9p5CNKr
   jTa1Qg4NgclQ94RKevds/ZaSKM8XUI6DQk+1XnzJydSRbG48MhHgoqNBU
   M1347SVkijkBhAbmJMpEV/W3QVP9NlffG3hhXM45McPpTTASzG4XkzmRk
   IhO6l0XKUlCvh5guQngClpO/o5bQwgnATI0Hpq/RmZOFGLtLZsm+4sMYh
   HWdFQ6atAQrqQb6IuD/x1DSmLaAGVhbMvN56XS1XWNniMDyBtoHGDjv9p
   XF6wPUeyQ9jiCEMABoglPIkc0XCihSTxPRwW2QNHmTFCHLY4OoBX/dkef
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="318194610"
X-IronPort-AV: E=Sophos;i="5.96,226,1665471600"; 
   d="scan'208";a="318194610"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 18:39:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="624530641"
X-IronPort-AV: E=Sophos;i="5.96,226,1665471600"; 
   d="scan'208";a="624530641"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 07 Dec 2022 18:39:43 -0800
Received: from debox1-desk4.intel.com (unknown [10.212.164.201])
        by linux.intel.com (Postfix) with ESMTP id 23039580DA1;
        Wed,  7 Dec 2022 18:39:43 -0800 (PST)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     nirmal.patel@linux.intel.com, jonathan.derrick@linux.dev,
        lorenzo.pieralisi@arm.com, hch@infradead.org, kw@linux.com,
        robh@kernel.org, bhelgaas@google.com, michael.a.bottini@intel.com,
        rafael@kernel.org, sathyanarayanan.kuppuswamy@linux.intel.com,
        me@adhityamohan.in
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V9 2/4] PCI: vmd: Use PCI_VDEVICE in device list
Date:   Wed,  7 Dec 2022 18:39:40 -0800
Message-Id: <20221208023942.491721-3-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221208023942.491721-1-david.e.box@linux.intel.com>
References: <20221208023942.491721-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        UPPERCASE_50_75 autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Refactor the PCI ID list to use PCI_VDEVICE.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
Reviewed-by: Jon Derrick <jonathan.derrick@linux.dev>
Reviewed-by: Nirmal Patel <nirmal.patel@linux.intel.com>
---
 V9 - No change

 V8 - No change

 V7 - New Patch. Separate patch suggested by Lorenzo

 drivers/pci/controller/vmd.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index e06e9f4fc50f..9dedca714c18 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -994,33 +994,33 @@ static int vmd_resume(struct device *dev)
 static SIMPLE_DEV_PM_OPS(vmd_dev_pm_ops, vmd_suspend, vmd_resume);
 
 static const struct pci_device_id vmd_ids[] = {
-	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_VMD_201D),
+	{PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_VMD_201D),
 		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP,},
-	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_VMD_28C0),
+	{PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_VMD_28C0),
 		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW |
 				VMD_FEAT_HAS_BUS_RESTRICTIONS |
 				VMD_FEAT_CAN_BYPASS_MSI_REMAP,},
-	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x467f),
+	{PCI_VDEVICE(INTEL, 0x467f),
 		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
 				VMD_FEAT_HAS_BUS_RESTRICTIONS |
 				VMD_FEAT_OFFSET_FIRST_VECTOR,},
-	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x4c3d),
+	{PCI_VDEVICE(INTEL, 0x4c3d),
 		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
 				VMD_FEAT_HAS_BUS_RESTRICTIONS |
 				VMD_FEAT_OFFSET_FIRST_VECTOR,},
-	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0xa77f),
+	{PCI_VDEVICE(INTEL, 0xa77f),
 		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
 				VMD_FEAT_HAS_BUS_RESTRICTIONS |
 				VMD_FEAT_OFFSET_FIRST_VECTOR,},
-	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x7d0b),
+	{PCI_VDEVICE(INTEL, 0x7d0b),
 		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
 				VMD_FEAT_HAS_BUS_RESTRICTIONS |
 				VMD_FEAT_OFFSET_FIRST_VECTOR,},
-	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0xad0b),
+	{PCI_VDEVICE(INTEL, 0xad0b),
 		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
 				VMD_FEAT_HAS_BUS_RESTRICTIONS |
 				VMD_FEAT_OFFSET_FIRST_VECTOR,},
-	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_VMD_9A0B),
+	{PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_VMD_9A0B),
 		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
 				VMD_FEAT_HAS_BUS_RESTRICTIONS |
 				VMD_FEAT_OFFSET_FIRST_VECTOR,},
-- 
2.34.1

