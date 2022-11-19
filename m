Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3AD1630A00
	for <lists+linux-pci@lfdr.de>; Sat, 19 Nov 2022 03:21:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbiKSCVr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Nov 2022 21:21:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235067AbiKSCVC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Nov 2022 21:21:02 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C78C5616;
        Fri, 18 Nov 2022 18:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668824082; x=1700360082;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rwsEQa82RGEY35/kVIyEKXcQKfXvSrWD1YVUMbGBB/c=;
  b=HsD+8euCxtgPhfPXD8M7kJ7TZIqQcyJHjQnbecmJOkA4NLqMa0YPEdGB
   NtZARpwjyGAHGoOxPy4g2irtGmZ6WPgKQM5e0SebsGKb4HV5I9A1+aN4J
   0eVXkRPC3D6wiYAG3qwIUHcAa4WOcIkybKHvlg1kVKQPIw403JzprRTD8
   DgNyOcKqieWH5iFhwDqAZVD5Mpur82DbHAMiMpxI3Bsjq0cYuEKgWgIm9
   wyQyApfdVeJ17XS8JgQhFA+N3nzZRqvnNj1hCoYJ43TrWWk3iJzKIcZAk
   cDtxiEvjEC5/WxPDZeqwa1xuJk5kUO7j/LMIAM3PU3QHst6fqjOSqa97G
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="313310239"
X-IronPort-AV: E=Sophos;i="5.96,175,1665471600"; 
   d="scan'208";a="313310239"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 18:14:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="815129819"
X-IronPort-AV: E=Sophos;i="5.96,175,1665471600"; 
   d="scan'208";a="815129819"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga005.jf.intel.com with ESMTP; 18 Nov 2022 18:14:12 -0800
Received: from debox1-desk4.lan (unknown [10.252.138.169])
        by linux.intel.com (Postfix) with ESMTP id 1E738580DFA;
        Fri, 18 Nov 2022 18:14:12 -0800 (PST)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     nirmal.patel@linux.intel.com, jonathan.derrick@linux.dev,
        lorenzo.pieralisi@arm.com, hch@infradead.org, kw@linux.com,
        robh@kernel.org, bhelgaas@google.com, david.e.box@linux.intel.com,
        michael.a.bottini@intel.com, rafael@kernel.org, me@adhityamohan.in
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V8 RESEND 2/4] PCI: vmd: Use PCI_VDEVICE in device list
Date:   Fri, 18 Nov 2022 18:14:09 -0800
Message-Id: <20221119021411.1383248-3-david.e.box@linux.intel.com>
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

Refactor the PCI ID list to use PCI_VDEVICE.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
Reviewed-by: Jon Derrick <jonathan.derrick@linux.dev>
Reviewed-by: Nirmal Patel <nirmal.patel@linux.intel.com>
---
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

