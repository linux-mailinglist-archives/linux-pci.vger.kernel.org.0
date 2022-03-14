Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8E994D7F92
	for <lists+linux-pci@lfdr.de>; Mon, 14 Mar 2022 11:12:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232070AbiCNKOB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Mar 2022 06:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233973AbiCNKN7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Mar 2022 06:13:59 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E15972ED;
        Mon, 14 Mar 2022 03:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647252769; x=1678788769;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=c8lMY83U7bDWqT64s5CwKGyHVEMkl2FJOdW10OwOnfg=;
  b=HYkc7FUIz6bu8HiofXC1HVMbp6lFE2gksjLgdKOzzyRVJctg32pUSiKT
   TQDFqgH+wlrKIAmmb6xSGRbjAhAO6IguZ0V+BvZFbR6I3sYwwAGJmHu3D
   OIT5woD8pjYYrpEiNXTnADSFvllNlE++Wkdbz9Rio9DjXPV1j+Mwgy56M
   SoCy7ymqPTajTGfAh+mvjr/nxMIixGBHxUB4AMtngqh2ZpKg51tiUPJhU
   GdgMBobm13c+xKY3dVszR95IschTy8TZttd16EKPHV+KmoVwPL+zzW1DG
   3k1HmiuqY0kctMUPGkk0HvVH5wh0WmQ5YRufpu2ximxgp5dDH4ct2lKLF
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10285"; a="235933428"
X-IronPort-AV: E=Sophos;i="5.90,180,1643702400"; 
   d="scan'208";a="235933428"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 03:12:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,180,1643702400"; 
   d="scan'208";a="512145411"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 14 Mar 2022 03:12:47 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 560E0150; Mon, 14 Mar 2022 12:13:06 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        micklorain@protonmail.com
Subject: [PATCH v1 1/1] PCI: Disable MSI for ATI PCIe-USB adapter
Date:   Mon, 14 Mar 2022 12:13:04 +0200
Message-Id: <20220314101304.89866-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

ATI PCIe-USB adapter advertises MSI, but it doesn't work by yet unknown reason.

Disable MSI for these devices.

Fixes: 306c54d0edb6 ("usb: hcd: Try MSI interrupts on PCI devices")
BugLink: https://lore.kernel.org/all/20200702143045.23429-1-andriy.shevchenko@linux.intel.com/
Reported-by: micklorain@protonmail.com
Tested-by: micklorain@protonmail.com
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pci/quirks.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 65f7f6b0576c..cc6a87a32b62 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3041,6 +3041,13 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_BROADCOM,
 			PCI_DEVICE_ID_TIGON3_5715S,
 			quirk_msi_intx_disable_bug);
 
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x4386, quirk_msi_intx_disable_bug);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x4387, quirk_msi_intx_disable_bug);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x4388, quirk_msi_intx_disable_bug);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x4389, quirk_msi_intx_disable_bug);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x438a, quirk_msi_intx_disable_bug);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x438b, quirk_msi_intx_disable_bug);
+
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x4390,
 			quirk_msi_intx_disable_ati_bug);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x4391,
-- 
2.35.1

