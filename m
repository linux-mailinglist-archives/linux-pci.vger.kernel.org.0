Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A65B784511
	for <lists+linux-pci@lfdr.de>; Tue, 22 Aug 2023 17:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233381AbjHVPKW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Aug 2023 11:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233317AbjHVPKV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Aug 2023 11:10:21 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E454198
        for <linux-pci@vger.kernel.org>; Tue, 22 Aug 2023 08:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692717020; x=1724253020;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wNUHzu8X1xyIKy57Le2aOs1vQxwpc2Z6lXeZFfNSOS0=;
  b=FPTpgF5u6o4SCyI5lNgMoZ2sIxa2IhzM37zIvKYXM3MRA/dOsoJtPece
   /znsUCKj9L0zATvy95Lusp9Y7W0+EnsRXIsbuFxSOdqSDPEYZNXVbvQnb
   FNXrPyEVMgEJKeB1CV3CTmbI1PG9ORunTfj5J+iH3IQ059MfpYzSkV4lE
   cQbXCYEhajLcvoL90tXsihAv6mEg9RnB9GWxPdINcTHlasARFccDlzoBr
   Me+Nwp6wwOx8xMbmHo9Mw9CrgXhnOgc9skK/2f446S8VXFxGU7vc9zKc3
   QWJVjis52gOgqrUHOXSACTzDQyfr1tDSsOBH83BV/6xKH8ww5j58h+zbR
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="372795273"
X-IronPort-AV: E=Sophos;i="6.01,193,1684825200"; 
   d="scan'208";a="372795273"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 08:10:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="713193450"
X-IronPort-AV: E=Sophos;i="6.01,193,1684825200"; 
   d="scan'208";a="713193450"
Received: from unknown (HELO localhost.ch.intel.com) ([10.2.230.30])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 08:10:19 -0700
From:   Nirmal Patel <nirmal.patel@linux.intel.com>
To:     nirmal.patel@linux.intel.com, <linux-pci@vger.kernel.org>
Subject: [PATCH v3] PCI: vmd: Do not change the BIOS Hotplug setting on VMD rootports
Date:   Tue, 22 Aug 2023 10:45:22 -0400
Message-Id: <20230822144522.1310839-1-nirmal.patel@linux.intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The hotplug functionality is broken in various combinations of guest
OSes i.e. RHEL, SLES and hypervisors i.e. KVM and ESXI.

During the VMD rootport creation, VMD honors ACPI settings and assigns
respective values to Hotplug, AER, DPC, PM etc which works in case of
Host OS. But these have been restored back to the power on default
state in Guest OSes, which puts the root port hot plug enable to
default OFF.

The VMD UEFI driver loads and configure all devices under VMD in Host.
This is how AER, power management, DPC and Hotplug gets enabled.
Since the Guest BIOS doesn't have VMD UEFI driver, Hotplug  along with
DPC, AER, PM are Disabled.

This change will make the VMD Host and Guest Driver to keep the settings
implemented by the UEFI VMD DXE driver and thus honoring the user
selections for Hotplug in the BIOS.

Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>
---
v2->v3: Update commit log.
v1->v2: Update commit log.
---
 drivers/pci/controller/vmd.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 769eedeb8802..52c2461b4761 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -701,8 +701,6 @@ static int vmd_alloc_irqs(struct vmd_dev *vmd)
 static void vmd_copy_host_bridge_flags(struct pci_host_bridge *root_bridge,
 				       struct pci_host_bridge *vmd_bridge)
 {
-	vmd_bridge->native_pcie_hotplug = root_bridge->native_pcie_hotplug;
-	vmd_bridge->native_shpc_hotplug = root_bridge->native_shpc_hotplug;
 	vmd_bridge->native_aer = root_bridge->native_aer;
 	vmd_bridge->native_pme = root_bridge->native_pme;
 	vmd_bridge->native_ltr = root_bridge->native_ltr;
-- 
2.31.1

