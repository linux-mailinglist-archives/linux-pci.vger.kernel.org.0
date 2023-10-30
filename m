Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 533377DC14B
	for <lists+linux-pci@lfdr.de>; Mon, 30 Oct 2023 21:36:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbjJ3UgK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Oct 2023 16:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231395AbjJ3UgJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Oct 2023 16:36:09 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41BF7100
        for <linux-pci@vger.kernel.org>; Mon, 30 Oct 2023 13:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698698166; x=1730234166;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ym2ctNINyktJImW/k0OG/PnDZ1yktsI43wV0RXJdc+A=;
  b=Pb14MbaCVizC6WwFcIkst4IG6vC8OrrTBuEZ/KHvQqkKrDZ/xWQWtH3N
   r/9gSC7YoiqKkvDxvsHmMWeR2JjcYjlVovAYcziC8jZkkbA8rWhcpSXHr
   d03K21YkDEA3JBm5SkNBLoh85Qp3Y4J+p4emZNmWocPgnoXffIUweIGZM
   xxIgfrBMXtus2qDMJYCsGYPPcxB5/Zcp2AO+GlNTT1iE8Bujtgq4T1Ekc
   kDUJPAk36hQv8BMiUcX4gcFK1FjKATX9jTOXk3xDP6D9BtAeuuSPd24G3
   rJOL29w/vgOZCt1G28Q9FgEVGyqkWi85nxfNu760z49QrgFQAkww5NB1d
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="454620124"
X-IronPort-AV: E=Sophos;i="6.03,264,1694761200"; 
   d="scan'208";a="454620124"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 13:35:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="826162119"
X-IronPort-AV: E=Sophos;i="6.03,264,1694761200"; 
   d="scan'208";a="826162119"
Received: from unknown (HELO localhost.ch.intel.com) ([10.2.230.30])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 13:35:58 -0700
From:   Nirmal Patel <nirmal.patel@linux.intel.com>
To:     nirmal.patel@linux.intel.com, <linux-pci@vger.kernel.org>
Subject: [PATCH] PCI: vmd: Enable Hotplug based on BIOS setting on VMD rootports
Date:   Mon, 30 Oct 2023 16:16:54 -0400
Message-Id: <20231030201654.27505-1-nirmal.patel@linux.intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

VMD Hotplug should be enabled or disabled based on VMD rootports'
Hotplug configuration in BIOS. is_hotplug_bridge is set on each
VMD rootport based on Hotplug capable bit in SltCap in probe.c.
Check is_hotplug_bridge and enable or disable native_pcie_hotplug
based on that value.

Currently VMD driver copies ACPI settings or platform configurations
for Hotplug, AER, DPC, PM, etc and enables or disables these features
on VMD bridge which is not correct in case of Hotplug.

Also during the Guest boot up, ACPI settings along with VMD UEFI
driver are not present in Guest BIOS which results in assigning
default values to Hotplug, AER, DPC, etc. As a result Hotplug is
disabled on VMD in the Guest OS.

This patch will make sure that Hotplug is enabled properly in Host
as well as in VM.

Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>
---
---
 drivers/pci/controller/vmd.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 769eedeb8802..e39eaef5549a 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -720,6 +720,7 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 	resource_size_t membar2_offset = 0x2000;
 	struct pci_bus *child;
 	struct pci_dev *dev;
+	struct pci_host_bridge *vmd_bridge;
 	int ret;
 
 	/*
@@ -886,8 +887,16 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 	 * and will fail pcie_bus_configure_settings() early. It can instead be
 	 * run on each of the real root ports.
 	 */
-	list_for_each_entry(child, &vmd->bus->children, node)
+	vmd_bridge = to_pci_host_bridge(vmd->bus->bridge);
+	list_for_each_entry(child, &vmd->bus->children, node) {
 		pcie_bus_configure_settings(child);
+		/*
+		 * When Hotplug is enabled on vmd root-port, enable it on vmd
+		 * bridge.
+		 */
+		if (child->self->is_hotplug_bridge)
+			vmd_bridge->native_pcie_hotplug = 1;
+	}
 
 	pci_bus_add_devices(vmd->bus);
 
-- 
2.31.1

