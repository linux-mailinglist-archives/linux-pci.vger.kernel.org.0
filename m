Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78F247411A5
	for <lists+linux-pci@lfdr.de>; Wed, 28 Jun 2023 14:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbjF1Mum (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Jun 2023 08:50:42 -0400
Received: from mga14.intel.com ([192.55.52.115]:59116 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231409AbjF1MuW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Jun 2023 08:50:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687956622; x=1719492622;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4nqsxOxfbufe1rn6XDu4qMnXZ1AacpOYGrC5eIcmaT4=;
  b=TYooTqWxel0bc4a9KFW4VPdv6Y4cJ597aEzziTlP9e44x1beDpIt1qXB
   bcl2KlCwSFVlqMZ+AgoG2p2qBJo+lLjtXRmBwG8N1zdyxgy95bucYgwe5
   s3ZOEqT1ounkaq2n+rh5F7dGRxa4w1YSZWWdFfsAGaFuv0kQU2BU9LofG
   52xYwYTec6p0JEFDh19+/reBhKgxNDq6dRJPnG6pcyqaKHgciZlLet4fr
   KTO5HSzjIc17aVUOvWI/P7SvULd1YWO2wEBJpgsQ23O4PozS4QJtFRUKQ
   FN9FgoLgRKGe8BsdzQ60l2c2FizG3dpX3y7pDI0yjn3CsbcalNjSKDFIx
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="361875561"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="361875561"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2023 05:50:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="891035045"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="891035045"
Received: from dev2 (HELO DEV2.igk.intel.com) ([10.237.148.94])
  by orsmga005.jf.intel.com with ESMTP; 28 Jun 2023 05:50:18 -0700
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
        =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
Subject: [RFC PATCH 1/8] PCI: Add Intel Audio DSP devices to pci_ids.h
Date:   Wed, 28 Jun 2023 22:51:28 +0200
Message-Id: <20230628205135.517241-2-amadeuszx.slawinski@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230628205135.517241-1-amadeuszx.slawinski@linux.intel.com>
References: <20230628205135.517241-1-amadeuszx.slawinski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Those IDs are mostly sprinkled between HDA, Skylake, SOF and avs drivers.
Almost every use contains additional comments to identify to which
platform those IDs refer to. Add those IDs to pci_ids.h header, so that
there is one place which defines those names.

Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
---
 include/linux/pci_ids.h | 44 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index a99b1fcfc617..de675c6cfb63 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2636,6 +2636,7 @@
 
 #define PCI_VENDOR_ID_INTEL		0x8086
 #define PCI_DEVICE_ID_INTEL_EESSC	0x0008
+#define PCI_DEVICE_ID_INTEL_HDA_CML_LP	0x02c8
 #define PCI_DEVICE_ID_INTEL_PXHD_0	0x0320
 #define PCI_DEVICE_ID_INTEL_PXHD_1	0x0321
 #define PCI_DEVICE_ID_INTEL_PXH_0	0x0329
@@ -2651,6 +2652,7 @@
 #define PCI_DEVICE_ID_INTEL_82424	0x0483
 #define PCI_DEVICE_ID_INTEL_82378	0x0484
 #define PCI_DEVICE_ID_INTEL_82425	0x0486
+#define PCI_DEVICE_ID_INTEL_HDA_CML_H	0x06c8
 #define PCI_DEVICE_ID_INTEL_MRST_SD0	0x0807
 #define PCI_DEVICE_ID_INTEL_MRST_SD1	0x0808
 #define PCI_DEVICE_ID_INTEL_MFD_SD	0x0820
@@ -2662,12 +2664,19 @@
 #define PCI_DEVICE_ID_INTEL_QUARK_X1000_ILB	0x095e
 #define PCI_DEVICE_ID_INTEL_I960	0x0960
 #define PCI_DEVICE_ID_INTEL_I960RM	0x0962
+#define PCI_DEVICE_ID_INTEL_HDA_HSW_0	0x0a0c
+#define PCI_DEVICE_ID_INTEL_HDA_HSW_2	0x0c0c
 #define PCI_DEVICE_ID_INTEL_CENTERTON_ILB	0x0c60
+#define PCI_DEVICE_ID_INTEL_HDA_HSW_3	0x0d0c
+#define PCI_DEVICE_ID_INTEL_HDA_BYT	0x0f04
 #define PCI_DEVICE_ID_INTEL_8257X_SOL	0x1062
 #define PCI_DEVICE_ID_INTEL_82573E_SOL	0x1085
 #define PCI_DEVICE_ID_INTEL_82573L_SOL	0x108f
 #define PCI_DEVICE_ID_INTEL_82815_MC	0x1130
 #define PCI_DEVICE_ID_INTEL_82815_CGC	0x1132
+#define PCI_DEVICE_ID_INTEL_HDA_MRFLD	0x119a
+#define PCI_DEVICE_ID_INTEL_HDA_BDW	0x160c
+#define PCI_DEVICE_ID_INTEL_HDA_APL_T	0x1a98
 #define PCI_DEVICE_ID_INTEL_82092AA_0	0x1221
 #define PCI_DEVICE_ID_INTEL_7505_0	0x2550
 #define PCI_DEVICE_ID_INTEL_7205_0	0x255d
@@ -2710,6 +2719,7 @@
 #define PCI_DEVICE_ID_INTEL_PANTHERPOINT_LPC_MIN	0x1e40
 #define PCI_DEVICE_ID_INTEL_PANTHERPOINT_LPC_MAX	0x1e5f
 #define PCI_DEVICE_ID_INTEL_VMD_201D	0x201d
+#define PCI_DEVICE_ID_INTEL_HDA_BSW	0x2284
 #define PCI_DEVICE_ID_INTEL_DH89XXCC_LPC_MIN	0x2310
 #define PCI_DEVICE_ID_INTEL_DH89XXCC_LPC_MAX	0x231f
 #define PCI_DEVICE_ID_INTEL_82801AA_0	0x2410
@@ -2875,6 +2885,7 @@
 #define PCI_DEVICE_ID_INTEL_LYNNFIELD_MC_CH2_ADDR_REV2  0x2db1
 #define PCI_DEVICE_ID_INTEL_LYNNFIELD_MC_CH2_RANK_REV2  0x2db2
 #define PCI_DEVICE_ID_INTEL_LYNNFIELD_MC_CH2_TC_REV2    0x2db3
+#define PCI_DEVICE_ID_INTEL_HDA_GML	0x3198
 #define PCI_DEVICE_ID_INTEL_82855PM_HB	0x3340
 #define PCI_DEVICE_ID_INTEL_IOAT_TBG4	0x3429
 #define PCI_DEVICE_ID_INTEL_IOAT_TBG5	0x342a
@@ -2885,6 +2896,7 @@
 #define PCI_DEVICE_ID_INTEL_IOAT_TBG1	0x3431
 #define PCI_DEVICE_ID_INTEL_IOAT_TBG2	0x3432
 #define PCI_DEVICE_ID_INTEL_IOAT_TBG3	0x3433
+#define PCI_DEVICE_ID_INTEL_HDA_ICL_LP	0x34c8
 #define PCI_DEVICE_ID_INTEL_82830_HB	0x3575
 #define PCI_DEVICE_ID_INTEL_82830_CGC	0x3577
 #define PCI_DEVICE_ID_INTEL_82854_HB	0x358c
@@ -2917,6 +2929,7 @@
 #define PCI_DEVICE_ID_INTEL_IOAT_JSF9	0x3719
 #define PCI_DEVICE_ID_INTEL_QAT_C62X	0x37c8
 #define PCI_DEVICE_ID_INTEL_QAT_C62X_VF	0x37c9
+#define PCI_DEVICE_ID_INTEL_HDA_ICL_N	0x38c8
 #define PCI_DEVICE_ID_INTEL_ICH10_0	0x3a14
 #define PCI_DEVICE_ID_INTEL_ICH10_1	0x3a16
 #define PCI_DEVICE_ID_INTEL_ICH10_2	0x3a18
@@ -2961,12 +2974,27 @@
 #define PCI_DEVICE_ID_INTEL_SBRIDGE_SAD0	0x3cf4	/* 12.6 */
 #define PCI_DEVICE_ID_INTEL_SBRIDGE_BR		0x3cf5	/* 13.6 */
 #define PCI_DEVICE_ID_INTEL_SBRIDGE_SAD1	0x3cf6	/* 12.7 */
+#define PCI_DEVICE_ID_INTEL_HDA_ICL_H	0x3dc8
 #define PCI_DEVICE_ID_INTEL_IOAT_SNB	0x402f
 #define PCI_DEVICE_ID_INTEL_5400_ERR	0x4030
 #define PCI_DEVICE_ID_INTEL_5400_FBD0	0x4035
 #define PCI_DEVICE_ID_INTEL_5400_FBD1	0x4036
+#define PCI_DEVICE_ID_INTEL_HDA_JSL_N	0x4dc8
+#define PCI_DEVICE_ID_INTEL_HDA_TGL_H	0x43c8
+#define PCI_DEVICE_ID_INTEL_HDA_EHL_0	0x4b55
+#define PCI_DEVICE_ID_INTEL_HDA_EHL_3	0x4b58
 #define PCI_DEVICE_ID_INTEL_EP80579_0	0x5031
 #define PCI_DEVICE_ID_INTEL_EP80579_1	0x5032
+#define PCI_DEVICE_ID_INTEL_HDA_ADL_P	0x51c8
+#define PCI_DEVICE_ID_INTEL_HDA_ADL_PS	0x51c9
+#define PCI_DEVICE_ID_INTEL_HDA_RPL_P_0	0x51ca
+#define PCI_DEVICE_ID_INTEL_HDA_RPL_P_1	0x51cb
+#define PCI_DEVICE_ID_INTEL_HDA_ADL_M	0x51cc
+#define PCI_DEVICE_ID_INTEL_HDA_ADL_PX	0x51cd
+#define PCI_DEVICE_ID_INTEL_HDA_RPL_M	0x51ce
+#define PCI_DEVICE_ID_INTEL_HDA_RPL_PX	0x51cf
+#define PCI_DEVICE_ID_INTEL_HDA_ADL_N	0x54c8
+#define PCI_DEVICE_ID_INTEL_HDA_APL	0x5a98
 #define PCI_DEVICE_ID_INTEL_5100_16	0x65f0
 #define PCI_DEVICE_ID_INTEL_5100_19	0x65f3
 #define PCI_DEVICE_ID_INTEL_5100_21	0x65f5
@@ -3000,6 +3028,9 @@
 #define PCI_DEVICE_ID_INTEL_82443GX_0	0x71a0
 #define PCI_DEVICE_ID_INTEL_82443GX_2	0x71a2
 #define PCI_DEVICE_ID_INTEL_82372FB_1	0x7601
+#define PCI_DEVICE_ID_INTEL_HDA_RPL_S	0x7a50
+#define PCI_DEVICE_ID_INTEL_HDA_ADL_S	0x7ad0
+#define PCI_DEVICE_ID_INTEL_HDA_MTL	0x7e28
 #define PCI_DEVICE_ID_INTEL_SCH_LPC	0x8119
 #define PCI_DEVICE_ID_INTEL_SCH_IDE	0x811a
 #define PCI_DEVICE_ID_INTEL_E6XX_CU	0x8183
@@ -3011,8 +3042,21 @@
 #define PCI_DEVICE_ID_INTEL_84460GX	0x84ea
 #define PCI_DEVICE_ID_INTEL_IXP4XX	0x8500
 #define PCI_DEVICE_ID_INTEL_IXP2800	0x9004
+#define PCI_DEVICE_ID_INTEL_HDA_LKF	0x98c8
 #define PCI_DEVICE_ID_INTEL_VMD_9A0B	0x9a0b
+#define PCI_DEVICE_ID_INTEL_HDA_SKL_LP	0x9d70
+#define PCI_DEVICE_ID_INTEL_HDA_KBL_LP	0x9d71
+#define PCI_DEVICE_ID_INTEL_HDA_CNL_LP	0x9dc8
+#define PCI_DEVICE_ID_INTEL_HDA_TGL_LP	0xa0c8
+#define PCI_DEVICE_ID_INTEL_HDA_SKL	0xa170
+#define PCI_DEVICE_ID_INTEL_HDA_KBL	0xa171
+#define PCI_DEVICE_ID_INTEL_HDA_KBL_H	0xa2f0
+#define PCI_DEVICE_ID_INTEL_HDA_CNL_H	0xa348
+#define PCI_DEVICE_ID_INTEL_HDA_CML_S	0xa3f0
+#define PCI_DEVICE_ID_INTEL_HDA_LNL_P	0xa828
 #define PCI_DEVICE_ID_INTEL_S21152BB	0xb152
+#define PCI_DEVICE_ID_INTEL_HDA_CML_R	0xf0c8
+#define PCI_DEVICE_ID_INTEL_HDA_RKL_S	0xf1c8
 
 #define PCI_VENDOR_ID_WANGXUN		0x8088
 
-- 
2.34.1

