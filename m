Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD72378BDFC
	for <lists+linux-pci@lfdr.de>; Tue, 29 Aug 2023 07:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233079AbjH2Fhm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Aug 2023 01:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235873AbjH2FhT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Aug 2023 01:37:19 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB19DCFA
        for <linux-pci@vger.kernel.org>; Mon, 28 Aug 2023 22:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693287413; x=1724823413;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bHD66iJaUsCCGg2oV9U/+l0GUO8TLEr/gbJhtDI3wO0=;
  b=GqSZqExtqxAfsrbFJ3e1HIAa5dSmc9mvrj+LZOiRQ/JYTdHDtbaALOWq
   Kgv9EjZ9eodw+8W+VIbQ05h90LRiY/S7Fvm996yzhfETX6LJLwUQTp5JJ
   5+J+HALPA0hdC08+z2h45T30CprwSzQgXwre3Uk2pf6I+qZkh28nG28D8
   DB6EJ9X5TAefDq4W6GpS4ONs8vYqMxywpeC77ObhSN8Qh1OQZW+j/79A+
   6K+BivqEJ+skSoySK0Op+nv5N5esF2udeOPMTlb4yCnCDWtpxcKzl6Aje
   TN++ajldOS3ypg9x0fGSR6ryfgFpUZX6lVUc2MGs9xlWKQMkc2Brmn7gv
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="461646246"
X-IronPort-AV: E=Sophos;i="6.02,208,1688454000"; 
   d="scan'208";a="461646246"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 22:36:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="808549148"
X-IronPort-AV: E=Sophos;i="6.02,208,1688454000"; 
   d="scan'208";a="808549148"
Received: from unknown (HELO localhost.ch.intel.com) ([10.2.230.30])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 22:36:01 -0700
From:   Nirmal Patel <nirmal.patel@linux.intel.com>
To:     nirmal.patel@linux.intel.com, <linux-pci@vger.kernel.org>
Subject: [PATCH v4] PCI: vmd: Do not change the BIOS Hotplug setting on VMD rootports
Date:   Tue, 29 Aug 2023 01:10:22 -0400
Message-Id: <20230829051022.1328383-1-nirmal.patel@linux.intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Currently during Host boot up, VMD UEFI driver loads and configures
all the VMD endpoints devices and devices behind VMD. Then during
VMD rootport creation, VMD driver honors ACPI settings for Hotplug,
AER, DPC, PM and enables these features based on BIOS settings.

During the Guest boot up, ACPI settings along with VMD UEFI driver are
not present in Guest BIOS which results in assigning default values to
Hotplug, AER, DPC, etc. As a result hotplug is disabled on the VMD
rootports in the Guest OS.

VMD driver in Guest should be able to see the same settings as seen
by Host VMD driver. Because of the missing implementation of VMD UEFI
driver in Guest BIOS, the Hotplug is disabled on VMD rootport in
Guest OS. Hot inserted drives don't show up and hot removed drives
do not disappear even if VMD supports Hotplug in Guest. This
behavior is observed in various combinations of guest OSes i.e. RHEL,
SLES and hypervisors i.e. KVM and ESXI.

This change will make the VMD Host and Guest Driver to keep the settings
implemented by the UEFI VMD DXE driver and thus honoring the user
selections for hotplug in the BIOS.

Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>
---
v3->v4: Rewrite the commit log.
v2->v3: Update the commit log.
v1->v2: Update the commit log.
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

