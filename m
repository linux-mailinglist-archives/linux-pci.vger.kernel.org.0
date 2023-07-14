Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54345753AD8
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jul 2023 14:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235590AbjGNMZs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Jul 2023 08:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235946AbjGNMZ3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Jul 2023 08:25:29 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF04D3ABD;
        Fri, 14 Jul 2023 05:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689337498; x=1720873498;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9rLxITniA1sLQNMmewKfuHQKCayEQypmbjbNmv3sb5I=;
  b=SVFMGr1m8k8DJNNjzPQDlA7A4Ju+gkPsVghSZcLmxjB9Ne4X/HXs6hhM
   PlilqkxMOSqib4MFR7m4Ap+npNUI7cJ7PKbGKXGwjj5Gi9pvnZm/D1LK5
   LNJTJZewJbp+AxfTYBI/f/EzeMsqLxDYZj+4R6/M8jJofQapnw7jTPDPH
   nE+DxfKdwkJdaWBGdxTVrEFZziEQjvyX0Ma5mpmuILpDvZRnQGxDnWUSH
   XH5bO1udJyC2g4GLaTMl0ALTfE93/aDhgi9bKJuNbLCMQ5Q6AMV3HYUso
   Pm5ZHCF+tgN4RYs3SKzjn2BQHMd3x+2dui0Yqno1G+SN6Qmry6OpSfJ47
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="429225921"
X-IronPort-AV: E=Sophos;i="6.01,205,1684825200"; 
   d="scan'208";a="429225921"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 05:24:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="1053035016"
X-IronPort-AV: E=Sophos;i="6.01,205,1684825200"; 
   d="scan'208";a="1053035016"
Received: from dev2 (HELO DEV2.igk.intel.com) ([10.237.148.94])
  by fmsmga005.fm.intel.com with ESMTP; 14 Jul 2023 05:24:23 -0700
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
        <amadeuszx.slawinski@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 15/15] ASoC: Intel: sst: Convert to PCI device IDs defines
Date:   Fri, 14 Jul 2023 22:24:57 +0200
Message-Id: <20230714202457.423866-16-amadeuszx.slawinski@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230714202457.423866-1-amadeuszx.slawinski@linux.intel.com>
References: <20230714202457.423866-1-amadeuszx.slawinski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Use PCI device IDs from pci_ids.h header. BSW replaces CHV, as 0x22a8
was added in PCI header as BSW ID for consistency, as they are same
(similar) platforms. The ACPI IDs are used only internally and lower
16 bits uniquely define the device as vendor ID for Intel is 8086 for
all of them. Use PCI_DEVICE_DATA() to match PCI device to be consistent
with other Intel audio drivers.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
---
 sound/soc/intel/atom/sst/sst.c     | 9 +++++----
 sound/soc/intel/atom/sst/sst.h     | 7 ++-----
 sound/soc/intel/atom/sst/sst_pci.c | 4 ++--
 3 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/sound/soc/intel/atom/sst/sst.c b/sound/soc/intel/atom/sst/sst.c
index a0d29510d2bc..1807813298cb 100644
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
+	case PCI_DEVICE_ID_INTEL_SST_BSW:
 		sst->tstamp = SST_TIME_STAMP_MRFLD;
 		sst->ops = &mrfld_ops;
 		return 0;
@@ -222,7 +223,7 @@ static void sst_init_locks(struct intel_sst_drv *ctx)
 }
 
 int sst_alloc_drv_context(struct intel_sst_drv **ctx,
-		struct device *dev, unsigned int dev_id)
+		struct device *dev, unsigned short dev_id)
 {
 	*ctx = devm_kzalloc(dev, sizeof(struct intel_sst_drv), GFP_KERNEL);
 	if (!(*ctx))
diff --git a/sound/soc/intel/atom/sst/sst.h b/sound/soc/intel/atom/sst/sst.h
index 4d37d39fd8f4..126903e126e4 100644
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
@@ -358,7 +355,7 @@ struct sst_fw_save {
 struct intel_sst_drv {
 	int			sst_state;
 	int			irq_num;
-	unsigned int		dev_id;
+	unsigned short		dev_id;
 	void __iomem		*ddr;
 	void __iomem		*shim;
 	void __iomem		*mailbox;
@@ -523,7 +520,7 @@ int sst_register(struct device *);
 int sst_unregister(struct device *);
 
 int sst_alloc_drv_context(struct intel_sst_drv **ctx,
-		struct device *dev, unsigned int dev_id);
+		struct device *dev, unsigned short dev_id);
 int sst_context_init(struct intel_sst_drv *ctx);
 void sst_context_cleanup(struct intel_sst_drv *ctx);
 void sst_configure_runtime_pm(struct intel_sst_drv *ctx);
diff --git a/sound/soc/intel/atom/sst/sst_pci.c b/sound/soc/intel/atom/sst/sst_pci.c
index 4058b4f80a0c..d1e64c3500be 100644
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
+	{ PCI_DEVICE_DATA(INTEL, SST_TNG, 0) },
 	{ 0, }
 };
 
-- 
2.34.1

