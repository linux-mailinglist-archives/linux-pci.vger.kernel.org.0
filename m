Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 647D2672E25
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jan 2023 02:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbjASBbd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Jan 2023 20:31:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbjASBah (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Jan 2023 20:30:37 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B385B12F10;
        Wed, 18 Jan 2023 17:28:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674091694; x=1705627694;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UAZ94p0WUC/AaXFVxPFR+U579xW3l9C+CQE+2DDw6Tc=;
  b=lniYkZfNFFZW4nTGLG5eQTp9WggnA9/1kwSBuedTWQ5Dzh8u1EGokFOB
   Yun/spLiIRiGjBG0mopH3EmknIs7w3p6AGHkC1TUE5j33ynMAx0V1GDTK
   Uea7D9tIYDqTqj1Wesx2vSYJT9Jh4FfCDdN73icmjfaUxyzVfVEwEbkeQ
   pE2bvxWRWoQIj6cIH+BtUqFF7V84AzPU83DnddRGgbOyaW8MQLnG+lKrG
   4ZiElEKGfEORzZ4qMTeJy7D98JmdHgRM2W8rWeRVB1pTmRvJpv3mg9jjO
   UwCwb1gO3gAl0TxnQaN1eUk0W1C8zd2YiB2Ow1qXMY8zqa3uTPK+FE60A
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="322847445"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="322847445"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 17:28:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="767995621"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="767995621"
Received: from unknown (HELO fedora.sh.intel.com) ([10.238.175.104])
  by fmsmga002.fm.intel.com with ESMTP; 18 Jan 2023 17:28:08 -0800
From:   Tianfei Zhang <tianfei.zhang@intel.com>
To:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-fpga@vger.kernel.org, lukas@wunner.de, kabel@kernel.org,
        mani@kernel.org, pali@kernel.org, mdf@kernel.org, hao.wu@intel.com,
        yilun.xu@intel.com, trix@redhat.com, jgg@ziepe.ca,
        ira.weiny@intel.com, andriy.shevchenko@linux.intel.com,
        dan.j.williams@intel.com, keescook@chromium.org, rafael@kernel.org,
        russell.h.weight@intel.com, corbet@lwn.net,
        linux-doc@vger.kernel.org, ilpo.jarvinen@linux.intel.com,
        lee@kernel.org, gregkh@linuxfoundation.org,
        matthew.gerlach@linux.intel.com
Cc:     Tianfei Zhang <tianfei.zhang@intel.com>
Subject: [PATCH v1 02/12] PCI: hotplug: expose APIs from pciehp driver
Date:   Wed, 18 Jan 2023 20:35:52 -0500
Message-Id: <20230119013602.607466-3-tianfei.zhang@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230119013602.607466-1-tianfei.zhang@intel.com>
References: <20230119013602.607466-1-tianfei.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When a PCIe-based FPGA card is reprogrammed, it temporarily
disappears from the PCIe bus. This needs to be managed by
disabling the link to avoid PCIe errors while the device is
not present. Also, re-enabling the link and rescan the PCI
devices must be performed after loading the new images. Export
functions from pciehp driver necessary for removing and
reconfiguring the PCI devices below a PCI hotplug bridge.

Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/hotplug/pciehp.h     | 2 ++
 drivers/pci/hotplug/pciehp_hpc.c | 5 ++++-
 drivers/pci/hotplug/pciehp_pci.c | 2 ++
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index e0a614acee05..c7f455a3b08f 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -194,6 +194,8 @@ int pciehp_get_raw_indicator_status(struct hotplug_slot *h_slot, u8 *status);
 
 int pciehp_slot_reset(struct pcie_device *dev);
 
+int pciehp_link_enable(struct controller *ctrl);
+
 static inline const char *slot_name(struct controller *ctrl)
 {
 	return hotplug_slot_name(&ctrl->hotplug_slot);
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 10e9670eea0b..11e4bc58aec0 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -328,6 +328,7 @@ int pciehp_check_link_status(struct controller *ctrl)
 
 	return 0;
 }
+EXPORT_SYMBOL_NS_GPL(pciehp_check_link_status, PCIEHP);
 
 static int __pciehp_link_set(struct controller *ctrl, bool enable)
 {
@@ -346,10 +347,11 @@ static int __pciehp_link_set(struct controller *ctrl, bool enable)
 	return 0;
 }
 
-static int pciehp_link_enable(struct controller *ctrl)
+int pciehp_link_enable(struct controller *ctrl)
 {
 	return __pciehp_link_set(ctrl, true);
 }
+EXPORT_SYMBOL_NS_GPL(pciehp_link_enable, PCIEHP);
 
 int pciehp_get_raw_indicator_status(struct hotplug_slot *hotplug_slot,
 				    u8 *status)
@@ -482,6 +484,7 @@ int pciehp_query_power_fault(struct controller *ctrl)
 	pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
 	return !!(slot_status & PCI_EXP_SLTSTA_PFD);
 }
+EXPORT_SYMBOL_NS_GPL(pciehp_query_power_fault, PCIEHP);
 
 int pciehp_set_raw_indicator_status(struct hotplug_slot *hotplug_slot,
 				    u8 status)
diff --git a/drivers/pci/hotplug/pciehp_pci.c b/drivers/pci/hotplug/pciehp_pci.c
index d17f3bf36f70..dd44e999b777 100644
--- a/drivers/pci/hotplug/pciehp_pci.c
+++ b/drivers/pci/hotplug/pciehp_pci.c
@@ -69,6 +69,7 @@ int pciehp_configure_device(struct controller *ctrl)
 	pci_unlock_rescan_remove();
 	return ret;
 }
+EXPORT_SYMBOL_NS_GPL(pciehp_configure_device, PCIEHP);
 
 /**
  * pciehp_unconfigure_device() - remove PCI devices below a hotplug bridge
@@ -120,3 +121,4 @@ void pciehp_unconfigure_device(struct controller *ctrl, bool presence)
 
 	pci_unlock_rescan_remove();
 }
+EXPORT_SYMBOL_NS_GPL(pciehp_unconfigure_device, PCIEHP);
-- 
2.38.1

