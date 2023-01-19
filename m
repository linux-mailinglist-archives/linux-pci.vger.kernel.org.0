Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 889FA672E2C
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jan 2023 02:31:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjASBbm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Jan 2023 20:31:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbjASBai (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Jan 2023 20:30:38 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F73D2C647;
        Wed, 18 Jan 2023 17:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674091700; x=1705627700;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/fMvxq4ANCu2cW712GMMTIFRFtohqCRfRXkl6DAzvos=;
  b=WZrJQnrCS1MIiO+78TrLWPEZ3C8AYcw1GsQxe0iI0Wg/jvq2jLoumIuH
   zVpgWpcho3tJW2X/e6mL3e4gCj0LBGiafIB8CsQ8XaGjPqbKg8QqRLwsS
   VRinlaM68VMEvITZ2ZgdOItXGu8Vz3QiKS0OjNgWuJU9HB7zXXu0cXRZp
   WXpLDhDInnX1R9vq4u+Fa3FLp0/NZW0AEU54qVHfBm+Db/9NmprX1TjzL
   i4E7A6BwzdE/P9QbIMX8yZ+JbGTNyd+2hiaDHPSHQMrPEVfv+CbFJgyg5
   2cF3Cw/V/djB68rliwVzHTEknmUFnAcFmw5F5U2MjxVqLBrrYoz83/9Wy
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="322847462"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="322847462"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 17:28:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="767995625"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="767995625"
Received: from unknown (HELO fedora.sh.intel.com) ([10.238.175.104])
  by fmsmga002.fm.intel.com with ESMTP; 18 Jan 2023 17:28:14 -0800
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
Subject: [PATCH v1 03/12] PCI: hotplug: add and expose link disable API
Date:   Wed, 18 Jan 2023 20:35:53 -0500
Message-Id: <20230119013602.607466-4-tianfei.zhang@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230119013602.607466-1-tianfei.zhang@intel.com>
References: <20230119013602.607466-1-tianfei.zhang@intel.com>
MIME-Version: 1.0
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
disappears from the PCIe bus. This needs to be managed to
avoid PCIe errors while the device is not present. Also,
re-probing and rescan the PCI devices must be performed after
loading the new images. Export functions from pciehp driver
necessary for disable and enable the PCI link of a PCI hotplug
bridge.

Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
---
 drivers/pci/hotplug/pciehp.h     | 1 +
 drivers/pci/hotplug/pciehp_hpc.c | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index c7f455a3b08f..8b58d0e84644 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -195,6 +195,7 @@ int pciehp_get_raw_indicator_status(struct hotplug_slot *h_slot, u8 *status);
 int pciehp_slot_reset(struct pcie_device *dev);
 
 int pciehp_link_enable(struct controller *ctrl);
+int pciehp_link_disable(struct controller *ctrl);
 
 static inline const char *slot_name(struct controller *ctrl)
 {
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 11e4bc58aec0..729546c0c1f9 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -353,6 +353,12 @@ int pciehp_link_enable(struct controller *ctrl)
 }
 EXPORT_SYMBOL_NS_GPL(pciehp_link_enable, PCIEHP);
 
+int pciehp_link_disable(struct controller *ctrl)
+{
+	return __pciehp_link_set(ctrl, false);
+}
+EXPORT_SYMBOL_NS_GPL(pciehp_link_disable, PCIEHP);
+
 int pciehp_get_raw_indicator_status(struct hotplug_slot *hotplug_slot,
 				    u8 *status)
 {
-- 
2.38.1

