Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 100CD4BB0E4
	for <lists+linux-pci@lfdr.de>; Fri, 18 Feb 2022 05:51:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbiBREv1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Feb 2022 23:51:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbiBREv0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Feb 2022 23:51:26 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA9F82BB11;
        Thu, 17 Feb 2022 20:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645159870; x=1676695870;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=u4q792RCz+H3dOJaH3q90T0pGToJjOH3Rm2aZCHpaP8=;
  b=aKQqXXFp3enKmpvKrzMYp0KFkNhhDA6GxzuXjBmbFHl3OZspOzjQrcv0
   TWITJGDcvwHY8i0JnGFTUQkRke5fT7z2BMcp/1lmDc5+seeFHinu6Flwl
   ifl4Myn7/HONC9ddMZx+BeAt5vmGPOALteE/XCIVBoLPhz59tafdHNgfv
   G9J8zf6FL70nLgGXBi2FQETXSzl1uARNflBpIZnr7kpBdO/s/mru5Ie5+
   1TBrpLN+VgGGCUGpVY4ed3GNZ1suozsr9pBrlCEbFjL+pPaCAp4g+g6eL
   zV4ZZcx6Uv2gY5msvkH33ioZk0oeAKVHJAe4zYxRlmARqVCa6B8k8UvxM
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10261"; a="251250339"
X-IronPort-AV: E=Sophos;i="5.88,377,1635231600"; 
   d="scan'208";a="251250339"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 20:51:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,377,1635231600"; 
   d="scan'208";a="546102725"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 17 Feb 2022 20:51:10 -0800
Received: from debox1-desk4.lan (unknown [10.251.23.8])
        by linux.intel.com (Postfix) with ESMTP id C5BD9580CB8;
        Thu, 17 Feb 2022 20:51:09 -0800 (PST)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     nirmal.patel@linux.intel.com, jonathan.derrick@linux.dev,
        lorenzo.pieralisi@arm.com, hch@infradead.org, kw@linux.com,
        robh@kernel.org, bhelgaas@google.com, david.e.box@linux.intel.com,
        michael.a.bottini@linux.intel.com, rafael@kernel.org,
        me@adhityamohan.in
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V5 2/3] PCI: vmd: Add vmd_device_data
Date:   Thu, 17 Feb 2022 20:50:55 -0800
Message-Id: <20220218045056.333799-3-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220218045056.333799-1-david.e.box@linux.intel.com>
References: <20220218045056.333799-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add vmd_device_data to allow adding additional info for driver data. Also
refactor the PCI ID list to use PCI_VDEVICE and simplify assignments for
devices that use the same driver_data.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---

V5
  - New patch

 drivers/pci/controller/vmd.c | 58 ++++++++++++++++++++----------------
 1 file changed, 32 insertions(+), 26 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index cc166c683638..a582c351b461 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -69,6 +69,10 @@ enum vmd_features {
 	VMD_FEAT_CAN_BYPASS_MSI_REMAP		= (1 << 4),
 };
 
+struct vmd_device_data {
+	enum vmd_features features;
+};
+
 static DEFINE_IDA(vmd_instance_ida);
 
 /*
@@ -710,11 +714,12 @@ static void vmd_copy_host_bridge_flags(struct pci_host_bridge *root_bridge,
 	vmd_bridge->native_dpc = root_bridge->native_dpc;
 }
 
-static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
+static int vmd_enable_domain(struct vmd_dev *vmd, struct vmd_device_data *info)
 {
 	struct pci_sysdata *sd = &vmd->sysdata;
 	struct resource *res;
 	u32 upper_bits;
+	unsigned long features = info->features;
 	unsigned long flags;
 	LIST_HEAD(resources);
 	resource_size_t offset[2] = {0};
@@ -881,7 +886,8 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 
 static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
 {
-	unsigned long features = (unsigned long) id->driver_data;
+	struct vmd_device_data *info = (struct vmd_device_data *)id->driver_data;
+	unsigned long features = info->features;
 	struct vmd_dev *vmd;
 	int err;
 
@@ -925,7 +931,7 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
 
 	spin_lock_init(&vmd->cfg_lock);
 	pci_set_drvdata(dev, vmd);
-	err = vmd_enable_domain(vmd, features);
+	err = vmd_enable_domain(vmd, info);
 	if (err)
 		goto out_release_instance;
 
@@ -993,30 +999,30 @@ static int vmd_resume(struct device *dev)
 #endif
 static SIMPLE_DEV_PM_OPS(vmd_dev_pm_ops, vmd_suspend, vmd_resume);
 
+static const struct vmd_device_data vmd_201d_data = {
+	.features = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP,
+};
+
+static const struct vmd_device_data vmd_28c0_data = {
+	.features = VMD_FEAT_HAS_MEMBAR_SHADOW |
+		    VMD_FEAT_HAS_BUS_RESTRICTIONS |
+		    VMD_FEAT_CAN_BYPASS_MSI_REMAP,
+};
+
+static const struct vmd_device_data vmd_467f_data = {
+	.features = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
+		    VMD_FEAT_HAS_BUS_RESTRICTIONS |
+		    VMD_FEAT_OFFSET_FIRST_VECTOR,
+};
+
 static const struct pci_device_id vmd_ids[] = {
-	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_VMD_201D),
-		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP,},
-	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_VMD_28C0),
-		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW |
-				VMD_FEAT_HAS_BUS_RESTRICTIONS |
-				VMD_FEAT_CAN_BYPASS_MSI_REMAP,},
-	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x467f),
-		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
-				VMD_FEAT_HAS_BUS_RESTRICTIONS |
-				VMD_FEAT_OFFSET_FIRST_VECTOR,},
-	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x4c3d),
-		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
-				VMD_FEAT_HAS_BUS_RESTRICTIONS |
-				VMD_FEAT_OFFSET_FIRST_VECTOR,},
-	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0xa77f),
-		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
-				VMD_FEAT_HAS_BUS_RESTRICTIONS |
-				VMD_FEAT_OFFSET_FIRST_VECTOR,},
-	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_VMD_9A0B),
-		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
-				VMD_FEAT_HAS_BUS_RESTRICTIONS |
-				VMD_FEAT_OFFSET_FIRST_VECTOR,},
-	{0,}
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_VMD_201D), (kernel_ulong_t)&vmd_201d_data },
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_VMD_28C0), (kernel_ulong_t)&vmd_28c0_data },
+	{ PCI_VDEVICE(INTEL, 0x467f), (kernel_ulong_t)&vmd_467f_data },
+	{ PCI_VDEVICE(INTEL, 0x4c3d), (kernel_ulong_t)&vmd_467f_data },
+	{ PCI_VDEVICE(INTEL, 0xa77f), (kernel_ulong_t)&vmd_467f_data },
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_VMD_9A0B), (kernel_ulong_t)&vmd_467f_data },
+	{ }
 };
 MODULE_DEVICE_TABLE(pci, vmd_ids);
 
-- 
2.25.1

