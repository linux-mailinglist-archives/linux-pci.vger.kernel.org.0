Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E17677CDA87
	for <lists+linux-pci@lfdr.de>; Wed, 18 Oct 2023 13:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbjJRLe0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Oct 2023 07:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbjJRLeX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Oct 2023 07:34:23 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BABE110F;
        Wed, 18 Oct 2023 04:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697628861; x=1729164861;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MqRibY96VGUvi4t4Y8OdfajrD7rQssLGYBUaujkdMxs=;
  b=fphr2OIXahRYqsnweJgi7pKz8g0bpB5qr+uH3MXpZwhAqJs1ypwgZpKj
   ASH3xl5Kv3uWQCkQs6bUkokLRjpRmHqCqb5WzmGTcdsqgW/GWugaTJNgv
   Vy/Lnq5ugCgXf6J3v4FwhVANLb8fjfYWeT6EUZeMfY5Q+SvSr4LqFy/XC
   v8X0UCFlgjkE4bsFVXpuiKYUvA6jUxFaUiZdsGaWgfPSj3YoviRRNvZ5U
   KUILqUK+sa1Ws2Zy/P0rPGzSL/7BF0IZ3myge+mE8KruVUinTyOcKSbNV
   ty9z15VeZ60CDF03sOxIoF3JGB0oGRx/zNGcuCx0tqMnr3ofBq9T9otf4
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="371056786"
X-IronPort-AV: E=Sophos;i="6.03,234,1694761200"; 
   d="scan'208";a="371056786"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 04:34:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="930150816"
X-IronPort-AV: E=Sophos;i="6.03,234,1694761200"; 
   d="scan'208";a="930150816"
Received: from suguccin-mobl1.amr.corp.intel.com (HELO localhost) ([10.252.44.63])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 04:34:02 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 3/7] PCI: hotplug: Use FIELD_GET/PREP()
Date:   Wed, 18 Oct 2023 14:32:50 +0300
Message-Id: <20231018113254.17616-4-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231018113254.17616-1-ilpo.jarvinen@linux.intel.com>
References: <20231018113254.17616-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Instead of handcrafted shifts to handle register fields, use
FIELD_GET/FIELD_PREP().

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/hotplug/pciehp_core.c | 3 ++-
 drivers/pci/hotplug/pciehp_hpc.c  | 5 +++--
 drivers/pci/hotplug/pnv_php.c     | 3 ++-
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
index 4042d87d539d..ddd55ad97a58 100644
--- a/drivers/pci/hotplug/pciehp_core.c
+++ b/drivers/pci/hotplug/pciehp_core.c
@@ -20,6 +20,7 @@
 #define pr_fmt(fmt) "pciehp: " fmt
 #define dev_fmt pr_fmt
 
+#include <linux/bitfield.h>
 #include <linux/moduleparam.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
@@ -103,7 +104,7 @@ static int set_attention_status(struct hotplug_slot *hotplug_slot, u8 status)
 	struct pci_dev *pdev = ctrl->pcie->port;
 
 	if (status)
-		status <<= PCI_EXP_SLTCTL_ATTN_IND_SHIFT;
+		status = FIELD_PREP(PCI_EXP_SLTCTL_AIC, status);
 	else
 		status = PCI_EXP_SLTCTL_ATTN_IND_OFF;
 
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index fd713abdfb9f..b1d0a1b3917d 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -14,6 +14,7 @@
 
 #define dev_fmt(fmt) "pciehp: " fmt
 
+#include <linux/bitfield.h>
 #include <linux/dmi.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
@@ -484,7 +485,7 @@ int pciehp_set_raw_indicator_status(struct hotplug_slot *hotplug_slot,
 	struct pci_dev *pdev = ctrl_dev(ctrl);
 
 	pci_config_pm_runtime_get(pdev);
-	pcie_write_cmd_nowait(ctrl, status << 6,
+	pcie_write_cmd_nowait(ctrl, FIELD_PREP(PCI_EXP_SLTCTL_AIC, status),
 			      PCI_EXP_SLTCTL_AIC | PCI_EXP_SLTCTL_PIC);
 	pci_config_pm_runtime_put(pdev);
 	return 0;
@@ -1028,7 +1029,7 @@ struct controller *pcie_init(struct pcie_device *dev)
 		PCI_EXP_SLTSTA_DLLSC | PCI_EXP_SLTSTA_PDC);
 
 	ctrl_info(ctrl, "Slot #%d AttnBtn%c PwrCtrl%c MRL%c AttnInd%c PwrInd%c HotPlug%c Surprise%c Interlock%c NoCompl%c IbPresDis%c LLActRep%c%s\n",
-		(slot_cap & PCI_EXP_SLTCAP_PSN) >> 19,
+		FIELD_GET(PCI_EXP_SLTCAP_PSN, slot_cap),
 		FLAG(slot_cap, PCI_EXP_SLTCAP_ABP),
 		FLAG(slot_cap, PCI_EXP_SLTCAP_PCP),
 		FLAG(slot_cap, PCI_EXP_SLTCAP_MRLSP),
diff --git a/drivers/pci/hotplug/pnv_php.c b/drivers/pci/hotplug/pnv_php.c
index 881d420637bf..694349be9d0a 100644
--- a/drivers/pci/hotplug/pnv_php.c
+++ b/drivers/pci/hotplug/pnv_php.c
@@ -5,6 +5,7 @@
  * Copyright Gavin Shan, IBM Corporation 2016.
  */
 
+#include <linux/bitfield.h>
 #include <linux/libfdt.h>
 #include <linux/module.h>
 #include <linux/pci.h>
@@ -731,7 +732,7 @@ static int pnv_php_enable_msix(struct pnv_php_slot *php_slot)
 
 	/* Check hotplug MSIx entry is in range */
 	pcie_capability_read_word(pdev, PCI_EXP_FLAGS, &pcie_flag);
-	entry.entry = (pcie_flag & PCI_EXP_FLAGS_IRQ) >> 9;
+	entry.entry = FIELD_GET(PCI_EXP_FLAGS_IRQ, pcie_flag);
 	if (entry.entry >= nr_entries)
 		return -ERANGE;
 
-- 
2.30.2

