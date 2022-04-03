Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C92134F06B6
	for <lists+linux-pci@lfdr.de>; Sun,  3 Apr 2022 02:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbiDCBAd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 2 Apr 2022 21:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbiDCBAc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 2 Apr 2022 21:00:32 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 365DF13CC4;
        Sat,  2 Apr 2022 17:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648947519; x=1680483519;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nVAOtsgMnAV1IoOL1iOgLnzwJVC7f0kFIyd7uqIf+BM=;
  b=a6Ip6XgyvdpY4d4ZndcKPkgqMQnC1i5HlkTiPtBYEED5Vo/BpIVino33
   93FlTuM/H4tGGlAEg5yGluYCqgLzf9IMCfzjBdWC4hWx4MEXpl4KFng7p
   ZritWjYJQvElXAFlrnAPd0CSzQ/pvY66n+g6WcKapkStzonpmOEzkJf8t
   9SnoaRjPeNoMvk2OQRu1iYbBvt3wthgZ1CCtXpqKFI3+WuCWPQdl3zk9v
   Ixt0foXwUg0cs2HlMuZeUfyPtE5HcifJBj64Q0pmDEyvrSX5FHvWzv9Rj
   Miz0svgQbIowvVDdf0tyW/INMXA1DCiowZS5AoymRsCfXf11qukbhHpi6
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10305"; a="260525497"
X-IronPort-AV: E=Sophos;i="5.90,231,1643702400"; 
   d="scan'208";a="260525497"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2022 17:58:38 -0700
X-IronPort-AV: E=Sophos;i="5.90,231,1643702400"; 
   d="scan'208";a="548245047"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2022 17:58:37 -0700
Subject: [PATCH] cxl/mem: Disable suspend
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org
Date:   Sat, 02 Apr 2022 17:58:37 -0700
Message-ID: <164894751774.951952.9428402449668442020.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The CXL specification claims S3 support at a hardware level, but at a
system software level there are some missing pieces. Section 9.4 rightly
claims that "CXL mem adapters may need aux power to retain memory
context across S3", but there is no enumeration mechanism for the OS to
determine if a given adapter has that support. Moreover the save state
and resume image for the system may inadvertantly end up in a CXL device
that needs to be restored before the save state is recoverable. I.e. a
circular dependency that is not resolvable without a third party
save-area.

Arrange for the cxl_mem driver to fail S3 attempts. This still nominaly
allows for suspend, but requires unbinding all CXL memory devices before
the suspend to ensure the typical DRAM flow is taken. The cxl_mem unbind
flow is intended to also tear down all CXL memory regions associated
with a given cxl_memdev.

It is reasonable to assume that any device participating in a System RAM
range published in the EFI memory map is covered by aux power and
save-area outside the device itself. So this restriction can be
minimized in the future once pre-existing region enumeration support
arrives, and perhaps a spec update to clarify if the EFI memory is
sufficent for determining the range of devices managed by
platform-firmware for S3 support.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/memdev.c |    1 -
 drivers/cxl/mem.c         |   26 ++++++++++++++++++++++++++
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 1f76b28f9826..efe4d2e9bfef 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -251,7 +251,6 @@ static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
 	dev->bus = &cxl_bus_type;
 	dev->devt = MKDEV(cxl_mem_major, cxlmd->id);
 	dev->type = &cxl_memdev_type;
-	device_set_pm_not_required(dev);
 	INIT_WORK(&cxlmd->detach_work, detach_memdev);
 
 	cdev = &cxlmd->cdev;
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 49a4b1c47299..0660bb1488cb 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -3,6 +3,7 @@
 #include <linux/device.h>
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/pm.h>
 
 #include "cxlmem.h"
 #include "cxlpci.h"
@@ -210,10 +211,35 @@ static int cxl_mem_probe(struct device *dev)
 	return rc;
 }
 
+static int cxl_mem_suspend(struct device *dev)
+{
+	/*
+	 * The kernel may be operating out of CXL memory on this device,
+	 * there is no spec defined way to determine whether this device
+	 * preserves contents over suspend, and there is no simple way
+	 * to arrange for the suspend image to avoid CXL memory which
+	 * would setup a circular dependency between PCI resume and save
+	 * state restoration.
+	 */
+	dev_err(dev, "CXL memory suspend not supported\n");
+	return -EBUSY;
+}
+
+static int cxl_mem_resume(struct device *dev)
+{
+	/* nothing to do since suspend is prevented */
+	return 0;
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(cxl_pm_ops, cxl_mem_suspend, cxl_mem_resume);
+
 static struct cxl_driver cxl_mem_driver = {
 	.name = "cxl_mem",
 	.probe = cxl_mem_probe,
 	.id = CXL_DEVICE_MEMORY_EXPANDER,
+	.drv = {
+		.pm = &cxl_pm_ops,
+	},
 };
 
 module_cxl_driver(cxl_mem_driver);

