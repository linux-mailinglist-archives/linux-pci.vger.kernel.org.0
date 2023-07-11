Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A412774EFB5
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jul 2023 15:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232359AbjGKNAI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Jul 2023 09:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbjGKM7y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Jul 2023 08:59:54 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F19C2688;
        Tue, 11 Jul 2023 05:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689080372; x=1720616372;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3vm/s2jyBsTzHoNtInr2TqgPAThMieXeVlEyUPbhIRM=;
  b=DDVdgx8j5yIy2wf7vP1jNgZf++mc1PoJVyb9qdJ+mu2lmk16natrC+rJ
   fhSSMvOkDHoMbFn6ej7gwzYwsKUKxxGsHQm32Z6y9p6ZyWwQHXMN7aWKx
   7EKo6X+Q2BIjT0W9HDxszUDrldGQOGuYVB8V7hnXuTtl3ZPa07OZljOVX
   Jt7WmZ37nJ+13z4JJ7/iNT0nWBAUHXy7LPcBcU9GYfiAOlWzu8Xl6uSgw
   YDxMXQy8S1UiP9reRQlwtAtTtz8GvETSs1V8LTWLObRIWJIQg0fIXLU5S
   JZCLvu0Fo+KJl2eci+f3xO/4kfXgSWeaQ9UYUAAlk0dyVvoVj5hCbGwxK
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="367187574"
X-IronPort-AV: E=Sophos;i="6.01,196,1684825200"; 
   d="scan'208";a="367187574"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 05:57:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="834666817"
X-IronPort-AV: E=Sophos;i="6.01,196,1684825200"; 
   d="scan'208";a="834666817"
Received: from dev2 (HELO DEV2.igk.intel.com) ([10.237.148.94])
  by fmsmga002.fm.intel.com with ESMTP; 11 Jul 2023 05:57:38 -0700
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
Subject: [PATCH 12/13] ASoC: SOF: Intel: Convert to PCI device IDs defines
Date:   Tue, 11 Jul 2023 14:57:25 +0200
Message-Id: <20230711125726.3509391-13-amadeuszx.slawinski@linux.intel.com>
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

Use PCI device IDs from pci_ids.h header and while at it change to using
PCI_DEVICE_DATA() macro, to simplify declarations.

Acked-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
---
 sound/soc/sof/intel/pci-apl.c |  9 +++----
 sound/soc/sof/intel/pci-cnl.c | 15 ++++--------
 sound/soc/sof/intel/pci-icl.c | 12 ++++------
 sound/soc/sof/intel/pci-mtl.c |  3 +--
 sound/soc/sof/intel/pci-skl.c |  6 ++---
 sound/soc/sof/intel/pci-tgl.c | 45 ++++++++++++-----------------------
 sound/soc/sof/intel/pci-tng.c |  3 +--
 7 files changed, 31 insertions(+), 62 deletions(-)

diff --git a/sound/soc/sof/intel/pci-apl.c b/sound/soc/sof/intel/pci-apl.c
index 69cad5a6bc72..083659ddfe6b 100644
--- a/sound/soc/sof/intel/pci-apl.c
+++ b/sound/soc/sof/intel/pci-apl.c
@@ -85,12 +85,9 @@ static const struct sof_dev_desc glk_desc = {
 
 /* PCI IDs */
 static const struct pci_device_id sof_pci_ids[] = {
-	{ PCI_DEVICE(0x8086, 0x5a98), /* BXT-P (ApolloLake) */
-		.driver_data = (unsigned long)&bxt_desc},
-	{ PCI_DEVICE(0x8086, 0x1a98),/* BXT-T */
-		.driver_data = (unsigned long)&bxt_desc},
-	{ PCI_DEVICE(0x8086, 0x3198), /* GeminiLake */
-		.driver_data = (unsigned long)&glk_desc},
+	{ PCI_DEVICE_DATA(INTEL, HDA_APL, &bxt_desc) },
+	{ PCI_DEVICE_DATA(INTEL, HDA_APL_T, &bxt_desc) },
+	{ PCI_DEVICE_DATA(INTEL, HDA_GML, &glk_desc) },
 	{ 0, }
 };
 MODULE_DEVICE_TABLE(pci, sof_pci_ids);
diff --git a/sound/soc/sof/intel/pci-cnl.c b/sound/soc/sof/intel/pci-cnl.c
index 8895508a0be6..e2c50e7b0aa7 100644
--- a/sound/soc/sof/intel/pci-cnl.c
+++ b/sound/soc/sof/intel/pci-cnl.c
@@ -120,16 +120,11 @@ static const struct sof_dev_desc cml_desc = {
 
 /* PCI IDs */
 static const struct pci_device_id sof_pci_ids[] = {
-	{ PCI_DEVICE(0x8086, 0x9dc8), /* CNL-LP */
-		.driver_data = (unsigned long)&cnl_desc},
-	{ PCI_DEVICE(0x8086, 0xa348), /* CNL-H */
-		.driver_data = (unsigned long)&cfl_desc},
-	{ PCI_DEVICE(0x8086, 0x02c8), /* CML-LP */
-		.driver_data = (unsigned long)&cml_desc},
-	{ PCI_DEVICE(0x8086, 0x06c8), /* CML-H */
-		.driver_data = (unsigned long)&cml_desc},
-	{ PCI_DEVICE(0x8086, 0xa3f0), /* CML-S */
-		.driver_data = (unsigned long)&cml_desc},
+	{ PCI_DEVICE_DATA(INTEL, HDA_CNL_LP, &cnl_desc) },
+	{ PCI_DEVICE_DATA(INTEL, HDA_CNL_H, &cfl_desc) },
+	{ PCI_DEVICE_DATA(INTEL, HDA_CML_LP, &cml_desc) },
+	{ PCI_DEVICE_DATA(INTEL, HDA_CML_H, &cml_desc) },
+	{ PCI_DEVICE_DATA(INTEL, HDA_CML_S, &cml_desc) },
 	{ 0, }
 };
 MODULE_DEVICE_TABLE(pci, sof_pci_ids);
diff --git a/sound/soc/sof/intel/pci-icl.c b/sound/soc/sof/intel/pci-icl.c
index 5fb5a820693e..0a65df3ed9e2 100644
--- a/sound/soc/sof/intel/pci-icl.c
+++ b/sound/soc/sof/intel/pci-icl.c
@@ -86,14 +86,10 @@ static const struct sof_dev_desc jsl_desc = {
 
 /* PCI IDs */
 static const struct pci_device_id sof_pci_ids[] = {
-	{ PCI_DEVICE(0x8086, 0x34C8), /* ICL-LP */
-		.driver_data = (unsigned long)&icl_desc},
-	{ PCI_DEVICE(0x8086, 0x3dc8), /* ICL-H */
-		.driver_data = (unsigned long)&icl_desc},
-	{ PCI_DEVICE(0x8086, 0x38c8), /* ICL-N */
-		.driver_data = (unsigned long)&jsl_desc},
-	{ PCI_DEVICE(0x8086, 0x4dc8), /* JSL-N */
-		.driver_data = (unsigned long)&jsl_desc},
+	{ PCI_DEVICE_DATA(INTEL, HDA_ICL_LP, &icl_desc) },
+	{ PCI_DEVICE_DATA(INTEL, HDA_ICL_H, &icl_desc) },
+	{ PCI_DEVICE_DATA(INTEL, HDA_ICL_N, &jsl_desc) },
+	{ PCI_DEVICE_DATA(INTEL, HDA_JSL_N, &jsl_desc) },
 	{ 0, }
 };
 MODULE_DEVICE_TABLE(pci, sof_pci_ids);
diff --git a/sound/soc/sof/intel/pci-mtl.c b/sound/soc/sof/intel/pci-mtl.c
index e276e1e37fed..7868b0827e84 100644
--- a/sound/soc/sof/intel/pci-mtl.c
+++ b/sound/soc/sof/intel/pci-mtl.c
@@ -52,8 +52,7 @@ static const struct sof_dev_desc mtl_desc = {
 
 /* PCI IDs */
 static const struct pci_device_id sof_pci_ids[] = {
-	{ PCI_DEVICE(0x8086, 0x7E28), /* MTL */
-		.driver_data = (unsigned long)&mtl_desc},
+	{ PCI_DEVICE_DATA(INTEL, HDA_MTL, &mtl_desc) },
 	{ 0, }
 };
 MODULE_DEVICE_TABLE(pci, sof_pci_ids);
diff --git a/sound/soc/sof/intel/pci-skl.c b/sound/soc/sof/intel/pci-skl.c
index 5e69af6eed34..a6588b138a8c 100644
--- a/sound/soc/sof/intel/pci-skl.c
+++ b/sound/soc/sof/intel/pci-skl.c
@@ -69,10 +69,8 @@ static struct sof_dev_desc kbl_desc = {
 
 /* PCI IDs */
 static const struct pci_device_id sof_pci_ids[] = {
-	/* Sunrise Point-LP */
-	{ PCI_DEVICE(0x8086, 0x9d70), .driver_data = (unsigned long)&skl_desc},
-	/* KBL */
-	{ PCI_DEVICE(0x8086, 0x9d71), .driver_data = (unsigned long)&kbl_desc},
+	{ PCI_DEVICE_DATA(INTEL, HDA_SKL_LP, &skl_desc) },
+	{ PCI_DEVICE_DATA(INTEL, HDA_KBL_LP, &kbl_desc) },
 	{ 0, }
 };
 MODULE_DEVICE_TABLE(pci, sof_pci_ids);
diff --git a/sound/soc/sof/intel/pci-tgl.c b/sound/soc/sof/intel/pci-tgl.c
index ca37ff1bbd2a..d688f9373fb2 100644
--- a/sound/soc/sof/intel/pci-tgl.c
+++ b/sound/soc/sof/intel/pci-tgl.c
@@ -284,36 +284,21 @@ static const struct sof_dev_desc rpl_desc = {
 
 /* PCI IDs */
 static const struct pci_device_id sof_pci_ids[] = {
-	{ PCI_DEVICE(0x8086, 0xa0c8), /* TGL-LP */
-		.driver_data = (unsigned long)&tgl_desc},
-	{ PCI_DEVICE(0x8086, 0x43c8), /* TGL-H */
-		.driver_data = (unsigned long)&tglh_desc},
-	{ PCI_DEVICE(0x8086, 0x4b55), /* EHL */
-		.driver_data = (unsigned long)&ehl_desc},
-	{ PCI_DEVICE(0x8086, 0x4b58), /* EHL */
-		.driver_data = (unsigned long)&ehl_desc},
-	{ PCI_DEVICE(0x8086, 0x7ad0), /* ADL-S */
-		.driver_data = (unsigned long)&adls_desc},
-	{ PCI_DEVICE(0x8086, 0x7a50), /* RPL-S */
-		.driver_data = (unsigned long)&rpls_desc},
-	{ PCI_DEVICE(0x8086, 0x51c8), /* ADL-P */
-		.driver_data = (unsigned long)&adl_desc},
-	{ PCI_DEVICE(0x8086, 0x51c9), /* ADL-PS */
-		.driver_data = (unsigned long)&adl_desc},
-	{ PCI_DEVICE(0x8086, 0x51ca), /* RPL-P */
-		.driver_data = (unsigned long)&rpl_desc},
-	{ PCI_DEVICE(0x8086, 0x51cb), /* RPL-P */
-		.driver_data = (unsigned long)&rpl_desc},
-	{ PCI_DEVICE(0x8086, 0x51cc), /* ADL-M */
-		.driver_data = (unsigned long)&adl_desc},
-	{ PCI_DEVICE(0x8086, 0x51cd), /* ADL-P */
-		.driver_data = (unsigned long)&adl_desc},
-	{ PCI_DEVICE(0x8086, 0x51ce), /* RPL-M */
-		.driver_data = (unsigned long)&rpl_desc},
-	{ PCI_DEVICE(0x8086, 0x51cf), /* RPL-PX */
-		.driver_data = (unsigned long)&rpl_desc},
-	{ PCI_DEVICE(0x8086, 0x54c8), /* ADL-N */
-		.driver_data = (unsigned long)&adl_n_desc},
+	{ PCI_DEVICE_DATA(INTEL, HDA_TGL_LP, &tgl_desc) },
+	{ PCI_DEVICE_DATA(INTEL, HDA_TGL_H, &tglh_desc) },
+	{ PCI_DEVICE_DATA(INTEL, HDA_EHL_0, &ehl_desc) },
+	{ PCI_DEVICE_DATA(INTEL, HDA_EHL_3, &ehl_desc) },
+	{ PCI_DEVICE_DATA(INTEL, HDA_ADL_S, &adls_desc) },
+	{ PCI_DEVICE_DATA(INTEL, HDA_RPL_S, &rpls_desc) },
+	{ PCI_DEVICE_DATA(INTEL, HDA_ADL_P, &adl_desc) },
+	{ PCI_DEVICE_DATA(INTEL, HDA_ADL_PS, &adl_desc) },
+	{ PCI_DEVICE_DATA(INTEL, HDA_RPL_P_0, &rpl_desc) },
+	{ PCI_DEVICE_DATA(INTEL, HDA_RPL_P_1, &rpl_desc) },
+	{ PCI_DEVICE_DATA(INTEL, HDA_ADL_M, &adl_desc) },
+	{ PCI_DEVICE_DATA(INTEL, HDA_ADL_PX, &adl_desc) },
+	{ PCI_DEVICE_DATA(INTEL, HDA_RPL_M, &rpl_desc) },
+	{ PCI_DEVICE_DATA(INTEL, HDA_RPL_PX, &rpl_desc) },
+	{ PCI_DEVICE_DATA(INTEL, HDA_ADL_N, &adl_n_desc) },
 	{ 0, }
 };
 MODULE_DEVICE_TABLE(pci, sof_pci_ids);
diff --git a/sound/soc/sof/intel/pci-tng.c b/sound/soc/sof/intel/pci-tng.c
index 8c22a00266c0..12e81456a80c 100644
--- a/sound/soc/sof/intel/pci-tng.c
+++ b/sound/soc/sof/intel/pci-tng.c
@@ -225,8 +225,7 @@ static const struct sof_dev_desc tng_desc = {
 
 /* PCI IDs */
 static const struct pci_device_id sof_pci_ids[] = {
-	{ PCI_DEVICE(0x8086, 0x119a),
-		.driver_data = (unsigned long)&tng_desc},
+	{ PCI_DEVICE_DATA(INTEL, ADSP_TNG, &tng_desc) },
 	{ 0, }
 };
 MODULE_DEVICE_TABLE(pci, sof_pci_ids);
-- 
2.34.1

