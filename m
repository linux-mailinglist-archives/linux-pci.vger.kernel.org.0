Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39E1A748ABE
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jul 2023 19:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbjGERii (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Jul 2023 13:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbjGERih (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Jul 2023 13:38:37 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A47DD
        for <linux-pci@vger.kernel.org>; Wed,  5 Jul 2023 10:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688578716; x=1720114716;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5IjUGhvr9ZJk5iumgjRYkMSu1W/jRZ3epXA/HKMpizU=;
  b=AxOVO5nGJu1kUpq6GMVg8lcrkPVL/austbk4JRaxyk7GpmIO2/GEoL0y
   Ja15VtzMt5H4+7hI/5JT41lLxk19GAceQS+LmRB4XJ3rincsYi0YcFRYc
   b2JiZSoLHvOROrw0n7mCfTO3WSuvB0b19DsRVw6u7HWSvxKISWlgNXdcQ
   aGVYADIaUNJguLEieJYhCRATnWVmSg8bSvVh9XR3MHWDD/nmkW6/VWZvB
   3cOZOmW88UJJ6VY4RjTHbg1ILVvnJ5ubsgDlB8D+UssvUhWtsSAfkBi8G
   A3/qFnLvRwzj/9RRJZVj4cbDf7+SRc3shXQMamdC4TNAdqs67XpcXGL54
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="449768156"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="449768156"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2023 10:38:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="1049794542"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="1049794542"
Received: from unknown (HELO localhost.ch.intel.com) ([10.2.230.30])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2023 10:38:36 -0700
From:   Nirmal Patel <nirmal.patel@linux.intel.com>
To:     nirmal.patel@linux.intel.com, <linux-pci@vger.kernel.org>
Subject: [PATCH] PCI: vmd: VMD to control Hotplug on its rootports
Date:   Wed,  5 Jul 2023 13:20:38 -0400
Message-Id: <20230705172038.844706-1-nirmal.patel@linux.intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The hotplug functionality is broken in various combinations of guest
OSes i.e. RHEL, SlES and hypervisors i.e. KVM and ESXI.

VMD enabled on Intel ADL cpus caused interrupt storm for smasung
drives due to AER being enabled on VMD controlled root ports.
The patch 04b12ef163d10e348db664900ae7f611b83c7a0e
("PCI: vmd: Honor APCI _OSC on PCIe features.") was added to the VMD
driver to correct the issue based on the following assumption:
	“Since VMD is an aperture to regular PCIe root ports, honor ACPI
	_OSC to disable PCIe features accordingly to resolve the issue.”
	Link: https://lore.kernel.org/r/20211203031541.1428904-1-kai.heng.feng@canonical.com

VMD as a PCIe device is an end point(type 0), not a PCIe aperture
(pcie bridge). In fact VMD is a type 0 raid controller(class code).
When BIOS boots, all root ports under VMD is inaccessible by BIOS, and
as such, they maintain their power on default states. The VMD UEFI DXE
driver loads and configure all devices under VMD. This is how AER,
power management and hotplug gets enabled in UEFI, since the BIOS pci
driver cannot access the root ports.

The patch worked around the interrupt storm by assigning the native
ACPI states to the  root ports under VMD. It assigns AER, hotplug,
PME, etc. These have been restored back to the power on default state
in guest OS, which says the root port hot plug enable is default OFF.
At most, the work around should have only assigned AER state.
An additional patch should be added to exclude hot plug from the
original patch.
This will cause hot plug to start working again in the guest, as the
settings implemented by the UEFI VMD DXE driver will remain in effect
in Linux.

Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>
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

