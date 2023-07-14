Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4375753AB2
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jul 2023 14:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235220AbjGNMXr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Jul 2023 08:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235586AbjGNMXq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Jul 2023 08:23:46 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90997269D;
        Fri, 14 Jul 2023 05:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689337425; x=1720873425;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0HqKtJ7QgGuXsamckNKB63HUVNTDPsag6P1nR7loQCE=;
  b=c8KVJa4Jg6xL88906Ek2FK27ckPju3SvENp55WzHnzk3aZ4lxC01VmhU
   9IynxCW9eYIO81l/SLbdnqKDLypc2h9L7svw9APiTtSik8LVx0LxQRmAC
   grc+MzPt5Nqh4vhR/uM8Xoci0e23cuoq3hvIKU19feq0esvgyaBkkTaYM
   GEVoxTOsTxYgUlgJxCNaB8JpKZpKmmZefTfURb456VKTt3VTVEZct9NEi
   pyVtYHhOrEjYCvvUios5UNnutEmMt6OjzG3fPBfO1xWDA7ki40cvLmn1Z
   GScLQX01LmCTAVZz2ErpLcFCtA/yg/oxLfsOLT7E1yKmse5zP6pJQEo04
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="429225784"
X-IronPort-AV: E=Sophos;i="6.01,205,1684825200"; 
   d="scan'208";a="429225784"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 05:23:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="1053034852"
X-IronPort-AV: E=Sophos;i="6.01,205,1684825200"; 
   d="scan'208";a="1053034852"
Received: from dev2 (HELO DEV2.igk.intel.com) ([10.237.148.94])
  by fmsmga005.fm.intel.com with ESMTP; 14 Jul 2023 05:23:42 -0700
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
Subject: [PATCH v3 01/15] PCI: Sort Intel PCI IDs by number
Date:   Fri, 14 Jul 2023 22:24:43 +0200
Message-Id: <20230714202457.423866-2-amadeuszx.slawinski@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230714202457.423866-1-amadeuszx.slawinski@linux.intel.com>
References: <20230714202457.423866-1-amadeuszx.slawinski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        UPPERCASE_50_75,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Some of the PCI IDs are not sorted correctly, reorder them by growing ID
number.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
---
 include/linux/pci_ids.h | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 2dc75df1437f..add7fb6bd844 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2677,8 +2677,6 @@
 #define PCI_DEVICE_ID_INTEL_82815_MC	0x1130
 #define PCI_DEVICE_ID_INTEL_82815_CGC	0x1132
 #define PCI_DEVICE_ID_INTEL_82092AA_0	0x1221
-#define PCI_DEVICE_ID_INTEL_7505_0	0x2550
-#define PCI_DEVICE_ID_INTEL_7205_0	0x255d
 #define PCI_DEVICE_ID_INTEL_82437	0x122d
 #define PCI_DEVICE_ID_INTEL_82371FB_0	0x122e
 #define PCI_DEVICE_ID_INTEL_82371FB_1	0x1230
@@ -2772,6 +2770,8 @@
 #define PCI_DEVICE_ID_INTEL_82850_HB	0x2530
 #define PCI_DEVICE_ID_INTEL_82860_HB	0x2531
 #define PCI_DEVICE_ID_INTEL_E7501_MCH	0x254c
+#define PCI_DEVICE_ID_INTEL_7505_0	0x2550
+#define PCI_DEVICE_ID_INTEL_7205_0	0x255d
 #define PCI_DEVICE_ID_INTEL_82845G_HB	0x2560
 #define PCI_DEVICE_ID_INTEL_82845G_IG	0x2562
 #define PCI_DEVICE_ID_INTEL_82865_HB	0x2570
@@ -2806,9 +2806,9 @@
 #define PCI_DEVICE_ID_INTEL_3000_HB	0x2778
 #define PCI_DEVICE_ID_INTEL_82945GM_HB	0x27a0
 #define PCI_DEVICE_ID_INTEL_82945GM_IG	0x27a2
+#define PCI_DEVICE_ID_INTEL_ICH7_30	0x27b0
 #define PCI_DEVICE_ID_INTEL_ICH7_0	0x27b8
 #define PCI_DEVICE_ID_INTEL_ICH7_1	0x27b9
-#define PCI_DEVICE_ID_INTEL_ICH7_30	0x27b0
 #define PCI_DEVICE_ID_INTEL_TGP_LPC	0x27bc
 #define PCI_DEVICE_ID_INTEL_ICH7_31	0x27bd
 #define PCI_DEVICE_ID_INTEL_ICH7_17	0x27da
@@ -2824,14 +2824,14 @@
 #define PCI_DEVICE_ID_INTEL_ICH8_6	0x2850
 #define PCI_DEVICE_ID_INTEL_VMD_28C0	0x28c0
 #define PCI_DEVICE_ID_INTEL_ICH9_0	0x2910
-#define PCI_DEVICE_ID_INTEL_ICH9_1	0x2917
 #define PCI_DEVICE_ID_INTEL_ICH9_2	0x2912
 #define PCI_DEVICE_ID_INTEL_ICH9_3	0x2913
 #define PCI_DEVICE_ID_INTEL_ICH9_4	0x2914
-#define PCI_DEVICE_ID_INTEL_ICH9_5	0x2919
-#define PCI_DEVICE_ID_INTEL_ICH9_6	0x2930
 #define PCI_DEVICE_ID_INTEL_ICH9_7	0x2916
+#define PCI_DEVICE_ID_INTEL_ICH9_1	0x2917
 #define PCI_DEVICE_ID_INTEL_ICH9_8	0x2918
+#define PCI_DEVICE_ID_INTEL_ICH9_5	0x2919
+#define PCI_DEVICE_ID_INTEL_ICH9_6	0x2930
 #define PCI_DEVICE_ID_INTEL_I7_MCR	0x2c18
 #define PCI_DEVICE_ID_INTEL_I7_MC_TAD	0x2c19
 #define PCI_DEVICE_ID_INTEL_I7_MC_RAS	0x2c1a
@@ -2848,8 +2848,8 @@
 #define PCI_DEVICE_ID_INTEL_I7_MC_CH2_ADDR  0x2c31
 #define PCI_DEVICE_ID_INTEL_I7_MC_CH2_RANK  0x2c32
 #define PCI_DEVICE_ID_INTEL_I7_MC_CH2_TC    0x2c33
-#define PCI_DEVICE_ID_INTEL_I7_NONCORE	0x2c41
 #define PCI_DEVICE_ID_INTEL_I7_NONCORE_ALT 0x2c40
+#define PCI_DEVICE_ID_INTEL_I7_NONCORE	0x2c41
 #define PCI_DEVICE_ID_INTEL_LYNNFIELD_NONCORE     0x2c50
 #define PCI_DEVICE_ID_INTEL_LYNNFIELD_NONCORE_ALT 0x2c51
 #define PCI_DEVICE_ID_INTEL_LYNNFIELD_NONCORE_REV2 0x2c70
@@ -2895,10 +2895,10 @@
 #define PCI_DEVICE_ID_INTEL_IOAT_TBG3	0x3433
 #define PCI_DEVICE_ID_INTEL_82830_HB	0x3575
 #define PCI_DEVICE_ID_INTEL_82830_CGC	0x3577
-#define PCI_DEVICE_ID_INTEL_82854_HB	0x358c
-#define PCI_DEVICE_ID_INTEL_82854_IG	0x358e
 #define PCI_DEVICE_ID_INTEL_82855GM_HB	0x3580
 #define PCI_DEVICE_ID_INTEL_82855GM_IG	0x3582
+#define PCI_DEVICE_ID_INTEL_82854_HB	0x358c
+#define PCI_DEVICE_ID_INTEL_82854_IG	0x358e
 #define PCI_DEVICE_ID_INTEL_E7520_MCH	0x3590
 #define PCI_DEVICE_ID_INTEL_E7320_MCH	0x3592
 #define PCI_DEVICE_ID_INTEL_MCH_PA	0x3595
@@ -2908,11 +2908,11 @@
 #define PCI_DEVICE_ID_INTEL_MCH_PC	0x3599
 #define PCI_DEVICE_ID_INTEL_MCH_PC1	0x359a
 #define PCI_DEVICE_ID_INTEL_E7525_MCH	0x359e
+#define PCI_DEVICE_ID_INTEL_IOAT_CNB	0x360b
+#define PCI_DEVICE_ID_INTEL_FBD_CNB	0x360c
 #define PCI_DEVICE_ID_INTEL_I7300_MCH_ERR 0x360c
 #define PCI_DEVICE_ID_INTEL_I7300_MCH_FB0 0x360f
 #define PCI_DEVICE_ID_INTEL_I7300_MCH_FB1 0x3610
-#define PCI_DEVICE_ID_INTEL_IOAT_CNB	0x360b
-#define PCI_DEVICE_ID_INTEL_FBD_CNB	0x360c
 #define PCI_DEVICE_ID_INTEL_IOAT_JSF0	0x3710
 #define PCI_DEVICE_ID_INTEL_IOAT_JSF1	0x3711
 #define PCI_DEVICE_ID_INTEL_IOAT_JSF2	0x3712
@@ -2943,16 +2943,12 @@
 #define PCI_DEVICE_ID_INTEL_IOAT_SNB7	0x3c27
 #define PCI_DEVICE_ID_INTEL_IOAT_SNB8	0x3c2e
 #define PCI_DEVICE_ID_INTEL_IOAT_SNB9	0x3c2f
-#define PCI_DEVICE_ID_INTEL_UNC_HA	0x3c46
-#define PCI_DEVICE_ID_INTEL_UNC_IMC0	0x3cb0
-#define PCI_DEVICE_ID_INTEL_UNC_IMC1	0x3cb1
-#define PCI_DEVICE_ID_INTEL_UNC_IMC2	0x3cb4
-#define PCI_DEVICE_ID_INTEL_UNC_IMC3	0x3cb5
 #define PCI_DEVICE_ID_INTEL_UNC_QPI0	0x3c41
 #define PCI_DEVICE_ID_INTEL_UNC_QPI1	0x3c42
 #define PCI_DEVICE_ID_INTEL_UNC_R2PCIE	0x3c43
 #define PCI_DEVICE_ID_INTEL_UNC_R3QPI0	0x3c44
 #define PCI_DEVICE_ID_INTEL_UNC_R3QPI1	0x3c45
+#define PCI_DEVICE_ID_INTEL_UNC_HA	0x3c46
 #define PCI_DEVICE_ID_INTEL_SBRIDGE_IMC_RAS	0x3c71	/* 15.1 */
 #define PCI_DEVICE_ID_INTEL_SBRIDGE_IMC_ERR0	0x3c72	/* 16.2 */
 #define PCI_DEVICE_ID_INTEL_SBRIDGE_IMC_ERR1	0x3c73	/* 16.3 */
@@ -2964,6 +2960,10 @@
 #define PCI_DEVICE_ID_INTEL_SBRIDGE_IMC_TAD1	0x3cab	/* 15.3 */
 #define PCI_DEVICE_ID_INTEL_SBRIDGE_IMC_TAD2	0x3cac	/* 15.4 */
 #define PCI_DEVICE_ID_INTEL_SBRIDGE_IMC_TAD3	0x3cad	/* 15.5 */
+#define PCI_DEVICE_ID_INTEL_UNC_IMC0	0x3cb0
+#define PCI_DEVICE_ID_INTEL_UNC_IMC1	0x3cb1
+#define PCI_DEVICE_ID_INTEL_UNC_IMC2	0x3cb4
+#define PCI_DEVICE_ID_INTEL_UNC_IMC3	0x3cb5
 #define PCI_DEVICE_ID_INTEL_SBRIDGE_IMC_DDRIO	0x3cb8	/* 17.0 */
 #define PCI_DEVICE_ID_INTEL_JAKETOWN_UBOX	0x3ce0
 #define PCI_DEVICE_ID_INTEL_SBRIDGE_SAD0	0x3cf4	/* 12.6 */
-- 
2.34.1

