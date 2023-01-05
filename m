Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEE6165E6CB
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jan 2023 09:24:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbjAEIYm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Jan 2023 03:24:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232233AbjAEIYG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Jan 2023 03:24:06 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 621DB58F82;
        Thu,  5 Jan 2023 00:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672906869; x=1704442869;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ldOSn4RJNcTLaRtEAxrO/RtpGFwPKJQdNeOLTmCm9Kc=;
  b=KoOit2mj1atc7XUBbB4Wme42c3iWfpHpg0/WyOYtTBQHfCPGJXncko/H
   EZ3tU/GxGYrQLDEKCdYWQINm3j89NNEcz4J8XnYa28DqsvgDshODh9KZa
   G71iPWGrSZlsiypYXQOlpgHkzjIYOmheKE94Wzz/yl7j5wAkyIxKH0Czl
   8JTFMJBR53XoRRZxHPS0RUGuhOKmLZgyYMM6cPkqprxDJZny5/3Crfh7S
   38EQp2He+/S+jgMexzX582T4tycy9cawctjN0ZXNt10Dn29JmIUX8YyDl
   epG84phRdHMDmLyCJFWjPcRlLL5rrJZ2oTwK+VRl3lRqM4H/8i6FfOIr9
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="301843072"
X-IronPort-AV: E=Sophos;i="5.96,302,1665471600"; 
   d="scan'208";a="301843072"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2023 00:20:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="900848238"
X-IronPort-AV: E=Sophos;i="5.96,302,1665471600"; 
   d="scan'208";a="900848238"
Received: from icg-kernel3.bj.intel.com ([172.16.126.100])
  by fmsmga006.fm.intel.com with ESMTP; 05 Jan 2023 00:20:55 -0800
From:   bingbu.cao@intel.com
To:     linux-kernel@vger.kernel.org,
        stable.vger.kernel.org@vger.kernel.org, linux-pci@vger.kernel.org,
        iommu@lists.linux.dev
Cc:     baolu.lu@linux.intel.com, senozhatsky@chromium.org,
        bingbu.cao@intel.com, bingbu.cao@linux.intel.com,
        sangram.k.y@intel.com
Subject: [RESEND PATCH v3] iommu/vt-d: Use passthrough mode for the Intel IPUs
Date:   Thu,  5 Jan 2023 16:28:57 +0800
Message-Id: <20230105082857.4180299-1-bingbu.cao@intel.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bingbu Cao <bingbu.cao@intel.com>

Intel IPU(Image Processing Unit) has its own (IO)MMU hardware,
The IPU driver allocates its own page table that is not mapped
via the DMA, and thus the Intel IOMMU driver blocks access giving
this error:

DMAR: DRHD: handling fault status reg 3
DMAR: [DMA Read] Request device [00:05.0] PASID ffffffff
      fault addr 76406000 [fault reason 06] PTE Read access is not set

As IPU is not an external facing device which is not risky, so use
IOMMU passthrough mode for Intel IPUs.

Fixes: 26f5689592e2 ("media: staging/intel-ipu3: mmu: Implement driver")
Signed-off-by: Bingbu Cao <bingbu.cao@intel.com>
---
 drivers/iommu/intel/iommu.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 59df7e42fd53..b9097ef5b8a6 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -37,6 +37,15 @@
 #define IS_GFX_DEVICE(pdev) ((pdev->class >> 16) == PCI_BASE_CLASS_DISPLAY)
 #define IS_USB_DEVICE(pdev) ((pdev->class >> 8) == PCI_CLASS_SERIAL_USB)
 #define IS_ISA_DEVICE(pdev) ((pdev->class >> 8) == PCI_CLASS_BRIDGE_ISA)
+#define IS_INTEL_IPU(pdev) ((pdev)->vendor == PCI_VENDOR_ID_INTEL &&	\
+			    ((pdev)->device == 0x9a19 ||		\
+			     (pdev)->device == 0x9a39 ||		\
+			     (pdev)->device == 0x4e19 ||		\
+			     (pdev)->device == 0x465d ||		\
+			     (pdev)->device == 0x462e ||		\
+			     (pdev)->device == 0xa75d ||		\
+			     (pdev)->device == 0x7d19 ||		\
+			     (pdev)->device == 0x1919))
 #define IS_AZALIA(pdev) ((pdev)->vendor == 0x8086 && (pdev)->device == 0x3a3e)
 
 #define IOAPIC_RANGE_START	(0xfee00000)
@@ -287,12 +296,14 @@ int intel_iommu_enabled = 0;
 EXPORT_SYMBOL_GPL(intel_iommu_enabled);
 
 static int dmar_map_gfx = 1;
+static int dmar_map_ipu = 1;
 static int intel_iommu_superpage = 1;
 static int iommu_identity_mapping;
 static int iommu_skip_te_disable;
 
 #define IDENTMAP_GFX		2
 #define IDENTMAP_AZALIA		4
+#define IDENTMAP_IPU		8
 
 const struct iommu_ops intel_iommu_ops;
 
@@ -2584,6 +2595,9 @@ static int device_def_domain_type(struct device *dev)
 
 		if ((iommu_identity_mapping & IDENTMAP_GFX) && IS_GFX_DEVICE(pdev))
 			return IOMMU_DOMAIN_IDENTITY;
+
+		if ((iommu_identity_mapping & IDENTMAP_IPU) && IS_INTEL_IPU(pdev))
+			return IOMMU_DOMAIN_IDENTITY;
 	}
 
 	return 0;
@@ -2973,6 +2987,9 @@ static int __init init_dmars(void)
 	if (!dmar_map_gfx)
 		iommu_identity_mapping |= IDENTMAP_GFX;
 
+	if (!dmar_map_ipu)
+		iommu_identity_mapping |= IDENTMAP_IPU;
+
 	check_tylersburg_isoch();
 
 	ret = si_domain_init(hw_pass_through);
@@ -4799,6 +4816,18 @@ static void quirk_iommu_igfx(struct pci_dev *dev)
 	dmar_map_gfx = 0;
 }
 
+static void quirk_iommu_ipu(struct pci_dev *dev)
+{
+	if (!IS_INTEL_IPU(dev))
+		return;
+
+	if (risky_device(dev))
+		return;
+
+	pci_info(dev, "Passthrough IOMMU for integrated Intel IPU\n");
+	dmar_map_ipu = 0;
+}
+
 /* G4x/GM45 integrated gfx dmar support is totally busted. */
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x2a40, quirk_iommu_igfx);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x2e00, quirk_iommu_igfx);
@@ -4834,6 +4863,9 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x1632, quirk_iommu_igfx);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x163A, quirk_iommu_igfx);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x163D, quirk_iommu_igfx);
 
+/* make IPU dmar use identity mapping */
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, PCI_ANY_ID, quirk_iommu_ipu);
+
 static void quirk_iommu_rwbf(struct pci_dev *dev)
 {
 	if (risky_device(dev))
-- 
2.39.0

