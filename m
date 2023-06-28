Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24D3A7411BF
	for <lists+linux-pci@lfdr.de>; Wed, 28 Jun 2023 14:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231613AbjF1Mu6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Jun 2023 08:50:58 -0400
Received: from mga14.intel.com ([192.55.52.115]:59121 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230446AbjF1Mup (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Jun 2023 08:50:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687956645; x=1719492645;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3AVsoshV580ox4TPHPVqbeF3N9M1fkfqjuyCWEE/4H0=;
  b=STmJz/3XUA9gPLr+OWerudVAvlSI76RWZ3XmMF/YRxXjDYlCl/UB8Yy5
   KAcYEbwriYvUINuP35c1LD/qRGnu6hpQx2MQjcOkisjnHThZ+QF7FRlei
   WQfAZqwJTedfpSIL9y/1rs0dovHeHF6pnAGQQPcSFA6B24Q8ncMUuU+lc
   WmlsOnBqLfiW5dszsckN35K+da4viS1IRi6e5xUDApI/oN+/U0TSrOws3
   GrGoj6kSoQmqG2ciFxRc0DaslWa1FPeSNYIvGVKql6AmfojUgSrwNkBLS
   wo6TDxGO1t1ID9fmNV8Cr+JlGUs0Hs2aBb+5S4Fk5obSAcW9vy/+0KxdQ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="361875588"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="361875588"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2023 05:50:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="891035106"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="891035106"
Received: from dev2 (HELO DEV2.igk.intel.com) ([10.237.148.94])
  by orsmga005.jf.intel.com with ESMTP; 28 Jun 2023 05:50:31 -0700
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
Subject: [RFC PATCH 5/8] ASoC: Intel: avs: Update PCI ID list
Date:   Wed, 28 Jun 2023 22:51:32 +0200
Message-Id: <20230628205135.517241-6-amadeuszx.slawinski@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230628205135.517241-1-amadeuszx.slawinski@linux.intel.com>
References: <20230628205135.517241-1-amadeuszx.slawinski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Use PCI device IDs from pci_ids.h header and while at it change to using
PCI_DEVICE_DATA macro, to simplify declarations.

Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
---
 sound/soc/intel/avs/core.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/soc/intel/avs/core.c b/sound/soc/intel/avs/core.c
index 637501850728..2ba179e31e43 100644
--- a/sound/soc/intel/avs/core.c
+++ b/sound/soc/intel/avs/core.c
@@ -745,14 +745,14 @@ static const struct avs_spec apl_desc = {
 };
 
 static const struct pci_device_id avs_ids[] = {
-	{ PCI_VDEVICE(INTEL, 0x9d70), (unsigned long)&skl_desc }, /* SKL */
-	{ PCI_VDEVICE(INTEL, 0xa170), (unsigned long)&skl_desc }, /* SKL-H */
-	{ PCI_VDEVICE(INTEL, 0x9d71), (unsigned long)&skl_desc }, /* KBL */
-	{ PCI_VDEVICE(INTEL, 0xa171), (unsigned long)&skl_desc }, /* KBL-H */
-	{ PCI_VDEVICE(INTEL, 0xa2f0), (unsigned long)&skl_desc }, /* KBL-S */
-	{ PCI_VDEVICE(INTEL, 0xa3f0), (unsigned long)&skl_desc }, /* CML-V */
-	{ PCI_VDEVICE(INTEL, 0x5a98), (unsigned long)&apl_desc }, /* APL */
-	{ PCI_VDEVICE(INTEL, 0x3198), (unsigned long)&apl_desc }, /* GML */
+	{ PCI_DEVICE_DATA(INTEL, HDA_SKL_LP,	&skl_desc) },
+	{ PCI_DEVICE_DATA(INTEL, HDA_SKL,	&skl_desc) },
+	{ PCI_DEVICE_DATA(INTEL, HDA_KBL_LP,	&skl_desc) },
+	{ PCI_DEVICE_DATA(INTEL, HDA_KBL,	&skl_desc) },
+	{ PCI_DEVICE_DATA(INTEL, HDA_KBL_H,	&skl_desc) },
+	{ PCI_DEVICE_DATA(INTEL, HDA_CML_S,	&skl_desc) },
+	{ PCI_DEVICE_DATA(INTEL, HDA_APL,	&apl_desc) },
+	{ PCI_DEVICE_DATA(INTEL, HDA_GML,	&apl_desc) },
 	{ 0 }
 };
 MODULE_DEVICE_TABLE(pci, avs_ids);
-- 
2.34.1

