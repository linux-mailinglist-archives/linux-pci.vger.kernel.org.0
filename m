Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36E3A6309FB
	for <lists+linux-pci@lfdr.de>; Sat, 19 Nov 2022 03:21:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234501AbiKSCVa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Nov 2022 21:21:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232999AbiKSCUw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Nov 2022 21:20:52 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7F0B9725;
        Fri, 18 Nov 2022 18:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668824082; x=1700360082;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Axh+ZBumwlo0dW64PCUDUQPBaXXqzQOyDLHu/ClAkI4=;
  b=KlphkqrQjOPCzJIwoV5iSbnk9qeH9xn+kOnr0JmPictWAhYukME8rClm
   Wq+EkBfFNiLrfluCk6Zyf80afsrj2M2x99+zvqeKhBiWFZ6Raq/9gZdck
   Q0WwTdDkCfEKwON4mrnxv7Znm73yeJIrTKoL1zJ+9bt0YMrINC13/b54j
   4AFON9Qu8BPH6b9I3q8yk2qIaxzGsn83RwDXdq/fT9YJwy7f7e+1AHE2e
   kcG7zKn2nRYv1NH2rIyp3ZuCj573dpOG/FcF8jqLzwkL4Ta95QDDn0SS9
   jO3CsvOi5XRPeE5PaTVvPn/6X6rmiBlBSAPLct6DD+ecom/Q0lr8vucQI
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="310913056"
X-IronPort-AV: E=Sophos;i="5.96,175,1665471600"; 
   d="scan'208";a="310913056"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 18:14:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="729440803"
X-IronPort-AV: E=Sophos;i="5.96,175,1665471600"; 
   d="scan'208";a="729440803"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP; 18 Nov 2022 18:14:12 -0800
Received: from debox1-desk4.lan (unknown [10.252.138.169])
        by linux.intel.com (Postfix) with ESMTP id 65612580DDF;
        Fri, 18 Nov 2022 18:14:12 -0800 (PST)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     nirmal.patel@linux.intel.com, jonathan.derrick@linux.dev,
        lorenzo.pieralisi@arm.com, hch@infradead.org, kw@linux.com,
        robh@kernel.org, bhelgaas@google.com, david.e.box@linux.intel.com,
        michael.a.bottini@intel.com, rafael@kernel.org, me@adhityamohan.in
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V8 RESEND 3/4] PCI: vmd: Create feature grouping for client products
Date:   Fri, 18 Nov 2022 18:14:10 -0800
Message-Id: <20221119021411.1383248-4-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221119021411.1383248-1-david.e.box@linux.intel.com>
References: <20221119021411.1383248-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
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

 V8 - New patch.

 drivers/pci/controller/vmd.c | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 9dedca714c18..86f3085db014 100644
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
@@ -1001,29 +1005,17 @@ static const struct pci_device_id vmd_ids[] = {
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

