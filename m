Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9237974EFB6
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jul 2023 15:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232981AbjGKNAM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Jul 2023 09:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232882AbjGKM75 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Jul 2023 08:59:57 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E1D268D;
        Tue, 11 Jul 2023 05:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689080373; x=1720616373;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rbfp/ATGi8YL1NhYsnv9rDVDnh7mPVl04cteWEUCpLs=;
  b=hS0luW66oOJeOaMJ9bw2WHW7JVOAKv6vHHJyjPerp6g/VO0M59wu42/P
   Zp2MI3h69QE3M97UDhOQ0BjIVBWksA9nNbtvym5FqNOxTOuanQCgb2afE
   BWPwWCTFIeiepW/+5ri8pFvXLg580TtaLMI5gv9uSp5BTR67+/KBW35K/
   78hg9mSpWHx68Nk8dU84H12yrjoiG1jvyK74mH2fAswYyuFSiB2MJeRDA
   EgI9UwlC7vlNWAc4vMva84vwMjdSjHDI1kcPwmFR/gI/dnDADZZ9ibD4n
   C2j32Je9pFNBD4L7jrgsyzaXciPaB0p36qZ8beFii9oItc606WThb2F3n
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="367187580"
X-IronPort-AV: E=Sophos;i="6.01,196,1684825200"; 
   d="scan'208";a="367187580"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 05:57:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="834666843"
X-IronPort-AV: E=Sophos;i="6.01,196,1684825200"; 
   d="scan'208";a="834666843"
Received: from dev2 (HELO DEV2.igk.intel.com) ([10.237.148.94])
  by fmsmga002.fm.intel.com with ESMTP; 11 Jul 2023 05:57:41 -0700
From:   =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
Subject: [PATCH 13/13] ASoC: Intel: sst: Convert to PCI device IDs defines
Date:   Tue, 11 Jul 2023 14:57:26 +0200
Message-Id: <20230711125726.3509391-14-amadeuszx.slawinski@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230711125726.3509391-1-amadeuszx.slawinski@linux.intel.com>
References: <20230711125726.3509391-1-amadeuszx.slawinski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Use PCI device IDs from pci_ids.h header.

Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
---
 sound/soc/intel/atom/sst/sst.c     | 3 ++-
 sound/soc/intel/atom/sst/sst.h     | 1 -
 sound/soc/intel/atom/sst/sst_pci.c | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/intel/atom/sst/sst.c b/sound/soc/intel/atom/sst/sst.c
index a0d29510d2bc..f582e0737778 100644
--- a/sound/soc/intel/atom/sst/sst.c
+++ b/sound/soc/intel/atom/sst/sst.c
@@ -16,6 +16,7 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/firmware.h>
+#include <linux/pci.h>
 #include <linux/pm_runtime.h>
 #include <linux/pm_qos.h>
 #include <linux/async.h>
@@ -174,7 +175,7 @@ int sst_driver_ops(struct intel_sst_drv *sst)
 {
 
 	switch (sst->dev_id) {
-	case SST_MRFLD_PCI_ID:
+	case PCI_DEVICE_ID_INTEL_ADSP_TNG:
 	case SST_BYT_ACPI_ID:
 	case SST_CHV_ACPI_ID:
 		sst->tstamp = SST_TIME_STAMP_MRFLD;
diff --git a/sound/soc/intel/atom/sst/sst.h b/sound/soc/intel/atom/sst/sst.h
index 4d37d39fd8f4..6670aaf9aca4 100644
--- a/sound/soc/intel/atom/sst/sst.h
+++ b/sound/soc/intel/atom/sst/sst.h
@@ -20,7 +20,6 @@
 
 /* driver names */
 #define SST_DRV_NAME "intel_sst_driver"
-#define SST_MRFLD_PCI_ID 0x119A
 #define SST_BYT_ACPI_ID	0x80860F28
 #define SST_CHV_ACPI_ID	0x808622A8
 
diff --git a/sound/soc/intel/atom/sst/sst_pci.c b/sound/soc/intel/atom/sst/sst_pci.c
index 4058b4f80a0c..9098076d6c72 100644
--- a/sound/soc/intel/atom/sst/sst_pci.c
+++ b/sound/soc/intel/atom/sst/sst_pci.c
@@ -32,7 +32,7 @@ static int sst_platform_get_resources(struct intel_sst_drv *ctx)
 
 	/* map registers */
 	/* DDR base */
-	if (ctx->dev_id == SST_MRFLD_PCI_ID) {
+	if (ctx->dev_id == PCI_DEVICE_ID_INTEL_ADSP_TNG) {
 		ctx->ddr_base = pci_resource_start(pci, 0);
 		/* check that the relocated IMR base matches with FW Binary */
 		ddr_base = relocate_imr_addr_mrfld(ctx->ddr_base);
@@ -173,7 +173,7 @@ static void intel_sst_remove(struct pci_dev *pci)
 
 /* PCI Routines */
 static const struct pci_device_id intel_sst_ids[] = {
-	{ PCI_VDEVICE(INTEL, SST_MRFLD_PCI_ID), 0},
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_ADSP_TNG), 0},
 	{ 0, }
 };
 
-- 
2.34.1

