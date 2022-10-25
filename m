Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1C860C0E1
	for <lists+linux-pci@lfdr.de>; Tue, 25 Oct 2022 03:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbiJYBU7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Oct 2022 21:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231788AbiJYBTd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Oct 2022 21:19:33 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E5E330E;
        Mon, 24 Oct 2022 17:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666658653; x=1698194653;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=j9GU0NvKPdTwWUKD33Xw5eEiJBBSJNAvjNnyFVrvudM=;
  b=WSz4Va92gAAFa+/GPSfRJ8ZaKCaeyztskkfbP/uZ/9JlTPCfDDrWNzl+
   KY3kH15vH/qy+IxME4ejAEdURphUgEammEixMcnYPB2q4Md57128BRH24
   YYfjYDlXV727+D++fJmDz7PfMF64rL1RrfPEX0DeH6LZFYH9zL2UisfbT
   B4Q4EL+A+/ZGGlNrntzqKNYkaZGF2BDxs7M5Y8yrGPoM8m5ZX/GvAE1mE
   OooXWD/1eFDPL+hpAGh1JDIGXGiiSIB9j6jQC1ks0SeUfIxfamtS8pbiE
   h37LX4ExmfY5TRCOpkXtOW3kxqz6T8s9Zx62qdDw6Kdb//IWAc3egALTw
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="287274909"
X-IronPort-AV: E=Sophos;i="5.95,210,1661842800"; 
   d="scan'208";a="287274909"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 17:44:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="876618068"
X-IronPort-AV: E=Sophos;i="5.95,210,1661842800"; 
   d="scan'208";a="876618068"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 24 Oct 2022 17:44:12 -0700
Received: from debox1-desk4.intel.com (unknown [10.209.125.134])
        by linux.intel.com (Postfix) with ESMTP id 53E8A580D42;
        Mon, 24 Oct 2022 17:44:12 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     nirmal.patel@linux.intel.com, jonathan.derrick@linux.dev,
        lorenzo.pieralisi@arm.com, hch@infradead.org, kw@linux.com,
        robh@kernel.org, bhelgaas@google.com, david.e.box@linux.intel.com,
        michael.a.bottini@intel.com, rafael@kernel.org, me@adhityamohan.in
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V7 3/4] PCI: vmd: Add vmd_device_data
Date:   Mon, 24 Oct 2022 17:44:10 -0700
Message-Id: <20221025004411.2910026-4-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221025004411.2910026-1-david.e.box@linux.intel.com>
References: <20221025004411.2910026-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add vmd_device_data to allow adding additional info for driver data.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
Reviewed-by: Jon Derrick <jonathan.derrick@linux.dev>
Reviewed-by: Nirmal Patel <nirmal.patel@linux.intel.com>
---
 V7
   - Moved PCI_VDEVICE into separate earlier patch.
 V6
   - Inline the declarations for driver data in the vmd_ids list.
     Suggested by Jonathan
 V5
   - New patch

 drivers/pci/controller/vmd.c | 80 +++++++++++++++++++++++++-----------
 1 file changed, 55 insertions(+), 25 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 9dedca714c18..a53d88fd820c 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -68,6 +68,10 @@ enum vmd_features {
 	VMD_FEAT_CAN_BYPASS_MSI_REMAP		= (1 << 4),
 };
 
+struct vmd_device_data {
+	enum vmd_features features;
+};
+
 static DEFINE_IDA(vmd_instance_ida);
 
 /*
@@ -709,11 +713,12 @@ static void vmd_copy_host_bridge_flags(struct pci_host_bridge *root_bridge,
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
@@ -882,7 +887,8 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 
 static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
 {
-	unsigned long features = (unsigned long) id->driver_data;
+	struct vmd_device_data *info = (struct vmd_device_data *)id->driver_data;
+	unsigned long features = info->features;
 	struct vmd_dev *vmd;
 	int err;
 
@@ -927,7 +933,7 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
 
 	spin_lock_init(&vmd->cfg_lock);
 	pci_set_drvdata(dev, vmd);
-	err = vmd_enable_domain(vmd, features);
+	err = vmd_enable_domain(vmd, info);
 	if (err)
 		goto out_release_instance;
 
@@ -995,35 +1001,59 @@ static SIMPLE_DEV_PM_OPS(vmd_dev_pm_ops, vmd_suspend, vmd_resume);
 
 static const struct pci_device_id vmd_ids[] = {
 	{PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_VMD_201D),
-		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP,},
+		(kernel_ulong_t)&(struct vmd_device_data) {
+			.features = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP,
+		},
+	},
 	{PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_VMD_28C0),
-		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW |
-				VMD_FEAT_HAS_BUS_RESTRICTIONS |
-				VMD_FEAT_CAN_BYPASS_MSI_REMAP,},
+		(kernel_ulong_t)&(struct vmd_device_data) {
+			.features = VMD_FEAT_HAS_MEMBAR_SHADOW |
+				    VMD_FEAT_HAS_BUS_RESTRICTIONS |
+				    VMD_FEAT_CAN_BYPASS_MSI_REMAP,
+		},
+	},
 	{PCI_VDEVICE(INTEL, 0x467f),
-		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
-				VMD_FEAT_HAS_BUS_RESTRICTIONS |
-				VMD_FEAT_OFFSET_FIRST_VECTOR,},
+		(kernel_ulong_t)&(struct vmd_device_data) {
+			.features = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
+				    VMD_FEAT_HAS_BUS_RESTRICTIONS |
+				    VMD_FEAT_OFFSET_FIRST_VECTOR,
+		},
+	},
 	{PCI_VDEVICE(INTEL, 0x4c3d),
-		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
-				VMD_FEAT_HAS_BUS_RESTRICTIONS |
-				VMD_FEAT_OFFSET_FIRST_VECTOR,},
+		(kernel_ulong_t)&(struct vmd_device_data) {
+			.features = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
+				    VMD_FEAT_HAS_BUS_RESTRICTIONS |
+				    VMD_FEAT_OFFSET_FIRST_VECTOR,
+		},
+	},
 	{PCI_VDEVICE(INTEL, 0xa77f),
-		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
-				VMD_FEAT_HAS_BUS_RESTRICTIONS |
-				VMD_FEAT_OFFSET_FIRST_VECTOR,},
+		(kernel_ulong_t)&(struct vmd_device_data) {
+			.features = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
+				    VMD_FEAT_HAS_BUS_RESTRICTIONS |
+				    VMD_FEAT_OFFSET_FIRST_VECTOR,
+		},
+	},
 	{PCI_VDEVICE(INTEL, 0x7d0b),
-		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
-				VMD_FEAT_HAS_BUS_RESTRICTIONS |
-				VMD_FEAT_OFFSET_FIRST_VECTOR,},
+		(kernel_ulong_t)&(struct vmd_device_data) {
+			.features = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
+				    VMD_FEAT_HAS_BUS_RESTRICTIONS |
+				    VMD_FEAT_OFFSET_FIRST_VECTOR,
+		},
+	},
 	{PCI_VDEVICE(INTEL, 0xad0b),
-		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
-				VMD_FEAT_HAS_BUS_RESTRICTIONS |
-				VMD_FEAT_OFFSET_FIRST_VECTOR,},
+		(kernel_ulong_t)&(struct vmd_device_data) {
+			.features = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
+				    VMD_FEAT_HAS_BUS_RESTRICTIONS |
+				    VMD_FEAT_OFFSET_FIRST_VECTOR,
+		},
+	},
 	{PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_VMD_9A0B),
-		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
-				VMD_FEAT_HAS_BUS_RESTRICTIONS |
-				VMD_FEAT_OFFSET_FIRST_VECTOR,},
+		(kernel_ulong_t)&(struct vmd_device_data) {
+			.features = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
+				    VMD_FEAT_HAS_BUS_RESTRICTIONS |
+				    VMD_FEAT_OFFSET_FIRST_VECTOR,
+		},
+	},
 	{0,}
 };
 MODULE_DEVICE_TABLE(pci, vmd_ids);
-- 
2.25.1

