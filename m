Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEDB24C8231
	for <lists+linux-pci@lfdr.de>; Tue,  1 Mar 2022 05:21:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232229AbiCAEVR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Feb 2022 23:21:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232331AbiCAEVH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Feb 2022 23:21:07 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE272F00E;
        Mon, 28 Feb 2022 20:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646108394; x=1677644394;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jVLzZIkE06jbqrtxiCO2PmKZxUVeTSb1DUOuP2uR+ZY=;
  b=QA0RyfD37RTtapH5eQUCZutZvoYPNiuaQbclisSUZqvVI6X3RNfXq5wi
   eAA2K7NCXDH2Y4u6Q1ZchOO+rJqj6c/HYqP2wnBxEF2qVH6r6VMTKM/iw
   PFdG2LxpPaZ/jTReMTZO8SMHOYxD5567vbLl5K8QDI2IgSDWVslrtg5So
   1JZo40sZlZ17KLUwlAiJySVrlNZ2/XeAW7un3XxxvvHHfW5OGdc0CIEQz
   4+nWxTB8+xKGyVNyeGPU3XjkzyIidrulyLJeodkeOD6b1SsHvATRDHMDq
   IUdRzHBubYkcRUUGH4cx8WnlfoJQckKFx5l69ylaeZGdOyoxF1XYJAYnz
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="253243225"
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="253243225"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 20:19:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="550546074"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 28 Feb 2022 20:19:44 -0800
Received: from debox1-desk4.lan (unknown [10.251.9.202])
        by linux.intel.com (Postfix) with ESMTP id 1965B5808DB;
        Mon, 28 Feb 2022 20:19:44 -0800 (PST)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     nirmal.patel@linux.intel.com, jonathan.derrick@linux.dev,
        lorenzo.pieralisi@arm.com, hch@infradead.org, kw@linux.com,
        robh@kernel.org, bhelgaas@google.com, david.e.box@linux.intel.com,
        michael.a.bottini@linux.intel.com, rafael@kernel.org,
        me@adhityamohan.in
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V6 2/3] PCI: vmd: Add vmd_device_data
Date:   Mon, 28 Feb 2022 20:19:42 -0800
Message-Id: <20220301041943.2935892-3-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220301041943.2935892-1-david.e.box@linux.intel.com>
References: <20220301041943.2935892-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add vmd_device_data to allow adding additional info for driver data. Also
refactor the PCI ID list to use PCI_VDEVICE.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
 V6
   - Inline the declarations for driver data in the vmd_ids list.
     Suggested by Jonathan
 V5
   - New patch

 drivers/pci/controller/vmd.c | 76 ++++++++++++++++++++++++------------
 1 file changed, 50 insertions(+), 26 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index cc166c683638..cde6e2cba210 100644
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
 
@@ -994,29 +1000,47 @@ static int vmd_resume(struct device *dev)
 static SIMPLE_DEV_PM_OPS(vmd_dev_pm_ops, vmd_suspend, vmd_resume);
 
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
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_VMD_201D),
+		(kernel_ulong_t)&(struct vmd_device_data) {
+			.features = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP,
+		},
+	},
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_VMD_28C0),
+		(kernel_ulong_t)&(struct vmd_device_data) {
+			.features = VMD_FEAT_HAS_MEMBAR_SHADOW |
+				    VMD_FEAT_HAS_BUS_RESTRICTIONS |
+				    VMD_FEAT_CAN_BYPASS_MSI_REMAP,
+		},
+	},
+	{ PCI_VDEVICE(INTEL, 0x467f),
+		(kernel_ulong_t)&(struct vmd_device_data) {
+			.features = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
+				    VMD_FEAT_HAS_BUS_RESTRICTIONS |
+				    VMD_FEAT_OFFSET_FIRST_VECTOR,
+		},
+	},
+	{ PCI_VDEVICE(INTEL, 0x4c3d),
+		(kernel_ulong_t)&(struct vmd_device_data) {
+			.features = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
+				    VMD_FEAT_HAS_BUS_RESTRICTIONS |
+				    VMD_FEAT_OFFSET_FIRST_VECTOR,
+		},
+	},
+	{ PCI_VDEVICE(INTEL, 0xa77f),
+		(kernel_ulong_t)&(struct vmd_device_data) {
+			.features = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
+				    VMD_FEAT_HAS_BUS_RESTRICTIONS |
+				    VMD_FEAT_OFFSET_FIRST_VECTOR,
+		},
+	},
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_VMD_9A0B),
+		(kernel_ulong_t)&(struct vmd_device_data) {
+			.features = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
+				    VMD_FEAT_HAS_BUS_RESTRICTIONS |
+				    VMD_FEAT_OFFSET_FIRST_VECTOR,
+		},
+	},
+	{ }
 };
 MODULE_DEVICE_TABLE(pci, vmd_ids);
 
-- 
2.25.1

