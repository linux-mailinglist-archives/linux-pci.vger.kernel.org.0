Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0006749D7
	for <lists+linux-pci@lfdr.de>; Fri, 20 Jan 2023 04:15:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbjATDPb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Jan 2023 22:15:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjATDP3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Jan 2023 22:15:29 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D634FAE7;
        Thu, 19 Jan 2023 19:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674184527; x=1705720527;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Mgdt2t5MbqMc36Ij8W4BDJHachCKFX3KwgqQXYMUwBg=;
  b=dCAbiwXA14KKxTJLDNzA0+tX/JBEIhs0xEQIs28zGvwhBVLjqn4eRI4I
   ZKYKUF76RHuclhGh4m93e9+uotuuTtu/LCrFT8edQbnkWcTrWM6X0sDrI
   9gC4wZmsNOyILDoFbuoL8Y+3WUqUQw4HgQB6aW190+PjcW7BHW5/Ochl+
   bs8yczbixCdx0fhrQ2W0E9jGSWKAkmtAwU/NgAGWcsyaECrQ8mW4SVt59
   mtGDC2UW9ROyAISN22kVGEjt88l6OTkuBnxbJDWlDVl8gym6JJ2sP25KN
   Vw7H5qL3/PWieZs5fphbYAxJnOjh1C8yAH9lVQcsTJebdr9i0JVfI98k+
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="390012687"
X-IronPort-AV: E=Sophos;i="5.97,230,1669104000"; 
   d="scan'208";a="390012687"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 19:15:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="638009310"
X-IronPort-AV: E=Sophos;i="5.97,230,1669104000"; 
   d="scan'208";a="638009310"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 19 Jan 2023 19:15:23 -0800
Received: from debox1-desk4.intel.com (unknown [10.212.255.207])
        by linux.intel.com (Postfix) with ESMTP id 29087580C4A;
        Thu, 19 Jan 2023 19:15:23 -0800 (PST)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     david.e.box@linux.intel.com, nirmal.patel@linux.intel.com,
        jonathan.derrick@linux.dev, lorenzo.pieralisi@arm.com,
        hch@infradead.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, michael.a.bottini@intel.com,
        rafael@kernel.org, me@adhityamohan.in
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V10 2/4] PCI: vmd: Use PCI_VDEVICE in device list
Date:   Thu, 19 Jan 2023 19:15:20 -0800
Message-Id: <20230120031522.2304439-3-david.e.box@linux.intel.com>
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

Use PCI_VDEVICE to simply the device table.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
Reviewed-by: Jon Derrick <jonathan.derrick@linux.dev>
Reviewed-by: Nirmal Patel <nirmal.patel@linux.intel.com>
---
 V10 - Changed commit message.

 V9 - No change

 V8 - No change

 V7 - New Patch. Separate patch suggested by Lorenzo

 drivers/pci/controller/vmd.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 769eedeb8802..1fc3f2174359 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -1017,33 +1017,33 @@ static int vmd_resume(struct device *dev)
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

