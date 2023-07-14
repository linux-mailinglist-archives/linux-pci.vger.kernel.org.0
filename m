Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2A1E753908
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jul 2023 12:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234875AbjGNK4q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Jul 2023 06:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236346AbjGNK4a (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Jul 2023 06:56:30 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 454223C3A;
        Fri, 14 Jul 2023 03:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689332154; x=1720868154;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=g0WaMz10MmiDZgZOz+x0E2A2UYntgNbZ+38tvXaJXpM=;
  b=D64CT1E3SqX3NRwbNMQvX6mFFbzpI1kQCvyjwUwoUUn7SjJXYT7gZQWz
   NG9IYgSaC8eX3LK92b79B9sS5eu0nDLYvXhdnSJrfghI5YFU+4GtOcpeg
   EguEljdAbbu7XDPXXFXn6Z3Cn65Io4vtHkb10VP0HDRGK7/KgA6u1VtOi
   IgZvzRZVYcWIdY0KGlOHLmQsbaEiCT2ksWVB5rkkQVqXIgJq9SSDg6zLF
   MoBn0lUTlbugVGzOQdiVqPaq27mwVqUqP9fGUopSDllxyJUUmrjGoPykc
   VcVUd4MdOWiOgFn9jOzwqe/I0XogYSLjNzh0v92rpJZoztZ1fA7RO/QVT
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="364321261"
X-IronPort-AV: E=Sophos;i="6.01,205,1684825200"; 
   d="scan'208";a="364321261"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 03:55:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="722365649"
X-IronPort-AV: E=Sophos;i="6.01,205,1684825200"; 
   d="scan'208";a="722365649"
Received: from dev2 (HELO DEV2.igk.intel.com) ([10.237.148.94])
  by orsmga002.jf.intel.com with ESMTP; 14 Jul 2023 03:55:45 -0700
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
Subject: [PATCH v2 15/15] ASoC: Intel: sst: Convert to PCI device IDs defines
Date:   Fri, 14 Jul 2023 20:56:15 +0200
Message-Id: <20230714185615.370597-16-amadeuszx.slawinski@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230714185615.370597-1-amadeuszx.slawinski@linux.intel.com>
References: <20230714185615.370597-1-amadeuszx.slawinski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Use PCI device IDs from pci_ids.h header.

Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
---
 sound/soc/intel/atom/sst/sst.c     | 7 ++++---
 sound/soc/intel/atom/sst/sst.h     | 3 ---
 sound/soc/intel/atom/sst/sst_pci.c | 4 ++--
 3 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/sound/soc/intel/atom/sst/sst.c b/sound/soc/intel/atom/sst/sst.c
index a0d29510d2bc..74614f9b086a 100644
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
@@ -174,9 +175,9 @@ int sst_driver_ops(struct intel_sst_drv *sst)
 {
 
 	switch (sst->dev_id) {
-	case SST_MRFLD_PCI_ID:
-	case SST_BYT_ACPI_ID:
-	case SST_CHV_ACPI_ID:
+	case PCI_DEVICE_ID_INTEL_SST_TNG:
+	case PCI_DEVICE_ID_INTEL_SST_BYT:
+	case PCI_DEVICE_ID_INTEL_SST_CHV:
 		sst->tstamp = SST_TIME_STAMP_MRFLD;
 		sst->ops = &mrfld_ops;
 		return 0;
diff --git a/sound/soc/intel/atom/sst/sst.h b/sound/soc/intel/atom/sst/sst.h
index 4d37d39fd8f4..eab374bf0066 100644
--- a/sound/soc/intel/atom/sst/sst.h
+++ b/sound/soc/intel/atom/sst/sst.h
@@ -20,9 +20,6 @@
 
 /* driver names */
 #define SST_DRV_NAME "intel_sst_driver"
-#define SST_MRFLD_PCI_ID 0x119A
-#define SST_BYT_ACPI_ID	0x80860F28
-#define SST_CHV_ACPI_ID	0x808622A8
 
 #define SST_SUSPEND_DELAY 2000
 #define FW_CONTEXT_MEM (64*1024)
diff --git a/sound/soc/intel/atom/sst/sst_pci.c b/sound/soc/intel/atom/sst/sst_pci.c
index 4058b4f80a0c..7ed142bb3dc0 100644
--- a/sound/soc/intel/atom/sst/sst_pci.c
+++ b/sound/soc/intel/atom/sst/sst_pci.c
@@ -32,7 +32,7 @@ static int sst_platform_get_resources(struct intel_sst_drv *ctx)
 
 	/* map registers */
 	/* DDR base */
-	if (ctx->dev_id == SST_MRFLD_PCI_ID) {
+	if (ctx->dev_id == PCI_DEVICE_ID_INTEL_SST_TNG) {
 		ctx->ddr_base = pci_resource_start(pci, 0);
 		/* check that the relocated IMR base matches with FW Binary */
 		ddr_base = relocate_imr_addr_mrfld(ctx->ddr_base);
@@ -173,7 +173,7 @@ static void intel_sst_remove(struct pci_dev *pci)
 
 /* PCI Routines */
 static const struct pci_device_id intel_sst_ids[] = {
-	{ PCI_VDEVICE(INTEL, SST_MRFLD_PCI_ID), 0},
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_SST_TNG), 0},
 	{ 0, }
 };
 
-- 
2.34.1

