Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 326AE7B860B
	for <lists+linux-pci@lfdr.de>; Wed,  4 Oct 2023 19:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233437AbjJDRCX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Oct 2023 13:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243543AbjJDRCW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Oct 2023 13:02:22 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB3B7AD;
        Wed,  4 Oct 2023 10:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696438939; x=1727974939;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=88we1DSu8Bs6O8JdeNsZBSGueiNIhCurw3oB1CXvjPA=;
  b=X/Tt+JH0i9W5exi3UiF/0XgNUubfABjhsNG9199Ry685otuL7QmSYQj3
   xpycX+N+G37MNy7DOtPUngal0OQcKFrImzT5x3uN5U97+Kb4ucn0zYfLd
   slwbGWAAZLuDSStwH4LtNMT8wt3yWZIWqF6PYHq/GgckrKSJv4+cz+Bgz
   QGaPTjc4gsejq149fweXtGFML2PAOUQuZGB1ZHWLuyqg5hbra9V69qtbn
   nR/Y5dN5wxOpQaDn+GrYplVBiViUd441Jxb1KvRScpFcDtRRQvvA0bGsK
   LnFPWfq2AJdUTK5quyiM8gG/tnVyPSfMFiv31pZdWqAC0Eer39zymvgvw
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="362589465"
X-IronPort-AV: E=Sophos;i="6.03,200,1694761200"; 
   d="scan'208";a="362589465"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 10:02:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="821765087"
X-IronPort-AV: E=Sophos;i="6.03,200,1694761200"; 
   d="scan'208";a="821765087"
Received: from jbrandeb-spr1.jf.intel.com ([10.166.28.233])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 10:02:17 -0700
From:   Jesse Brandeburg <jesse.brandeburg@intel.com>
To:     intel-wired-lan@lists.osuosl.org
Cc:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        linux-pci@vger.kernel.org, pmenzel@molgen.mpg.de,
        netdev@vger.kernel.org, jkc@redhat.com, jay.vosburgh@canonical.com,
        Vishal Agrawal <vagrawal@redhat.com>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-net v3] ice: reset first in crash dump kernels
Date:   Wed,  4 Oct 2023 10:02:14 -0700
Message-Id: <20231004170214.474792-1-jesse.brandeburg@intel.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When the system boots into the crash dump kernel after a panic, the ice
networking device may still have pending transactions that can cause errors
or machine checks when the device is re-enabled. This can prevent the crash
dump kernel from loading the driver or collecting the crash data.

To avoid this issue, perform a function level reset (FLR) on the ice device
via PCIe config space before enabling it on the crash kernel. This will
clear any outstanding transactions and stop all queues and interrupts.
Restore the config space after the FLR, otherwise it was found in testing
that the driver wouldn't load successfully.

The following sequence causes the original issue:
- Load the ice driver with modprobe ice
- Enable SR-IOV with 2 VFs: echo 2 > /sys/class/net/eth0/device/sriov_num_vfs
- Trigger a crash with echo c > /proc/sysrq-trigger
- Load the ice driver again (or let it load automatically) with modprobe ice
- The system crashes again during pcim_enable_device()

Fixes: 837f08fdecbe ("ice: Add basic driver framework for Intel(R) E800 Series")

Reported-by: Vishal Agrawal <vagrawal@redhat.com>
Reviewed-by: Jay Vosburgh <jay.vosburgh@canonical.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
---
v3: add Fixes tag as approximate, added Jay's RB tag
v2: respond to list comments and update commit message
v1: initial version
---
 drivers/net/ethernet/intel/ice/ice_main.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index c8286adae946..6550c46e4e36 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -6,6 +6,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <generated/utsrelease.h>
+#include <linux/crash_dump.h>
 #include "ice.h"
 #include "ice_base.h"
 #include "ice_lib.h"
@@ -5014,6 +5015,20 @@ ice_probe(struct pci_dev *pdev, const struct pci_device_id __always_unused *ent)
 		return -EINVAL;
 	}
 
+	/* when under a kdump kernel initiate a reset before enabling the
+	 * device in order to clear out any pending DMA transactions. These
+	 * transactions can cause some systems to machine check when doing
+	 * the pcim_enable_device() below.
+	 */
+	if (is_kdump_kernel()) {
+		pci_save_state(pdev);
+		pci_clear_master(pdev);
+		err = pcie_flr(pdev);
+		if (err)
+			return err;
+		pci_restore_state(pdev);
+	}
+
 	/* this driver uses devres, see
 	 * Documentation/driver-api/driver-model/devres.rst
 	 */

base-commit: 6a70e5cbedaf8ad10528ac9ac114f3ec20f422df
-- 
2.39.3

