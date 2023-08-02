Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B845A76D12E
	for <lists+linux-pci@lfdr.de>; Wed,  2 Aug 2023 17:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234219AbjHBPMv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Aug 2023 11:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234034AbjHBPMm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Aug 2023 11:12:42 -0400
Received: from mgamail.intel.com (unknown [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 297122690
        for <linux-pci@vger.kernel.org>; Wed,  2 Aug 2023 08:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690989161; x=1722525161;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=znXh8jhk50KTy9cQHFdBDmGE/L6ZUCXCnIswbewkii8=;
  b=XmGqMrjP+vkgmsnacGQa1/lxWaq9Xkjt21z9cJ963JY5TGjfcCbSsOJi
   eAputgOxZ1tCSqXZWEb6ulfBou+sT/n6uSn6jiRVgdJvimf+je0irYScx
   2FCKxEglmAFMlQsB6nZyF91ntLHg98E+ZQHA+1uHpU/jhM967wbRNgioJ
   VgzoiP1aNg7P0FZNq7CIRWAm/Ump1HD3sS49y6DcFKof6vn0SAZApRVPE
   lif279xJWRBzobUfgUVv9170Usz+knzHppr6tuI/xC4kgVWZq9UdEhnrX
   wkCbfQx2SuZlil25opMtGCt6VQpZPiaIlHaFLz8RoNkzN2j5wE+YiNbjZ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="369607282"
X-IronPort-AV: E=Sophos;i="6.01,249,1684825200"; 
   d="scan'208";a="369607282"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 08:01:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="732428698"
X-IronPort-AV: E=Sophos;i="6.01,249,1684825200"; 
   d="scan'208";a="732428698"
Received: from rickylop-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.212.125.114])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 08:01:16 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        "T, Arun" <arun.t@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 5/5] ALSA: hda/i915: extend connectivity check to cover Intel ARL
Date:   Wed,  2 Aug 2023 10:01:05 -0500
Message-Id: <20230802150105.24604-6-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230802150105.24604-1-pierre-louis.bossart@linux.intel.com>
References: <20230802150105.24604-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
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

From: Kai Vehmanen <kai.vehmanen@linux.intel.com>

Expand the HDA/I915 connectivity check to correctly handle
the PCI topology used in some Intel Arrow Lake products.

Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Tested-by: "T, Arun" <arun.t@intel.com>
Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/hda/hdac_i915.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/sound/hda/hdac_i915.c b/sound/hda/hdac_i915.c
index 2a451ff4fe6a..b428537f284c 100644
--- a/sound/hda/hdac_i915.c
+++ b/sound/hda/hdac_i915.c
@@ -75,16 +75,22 @@ static bool connectivity_check(struct pci_dev *i915, struct pci_dev *hdac)
 	if (bus_a == bus_b)
 		return true;
 
+	bus_a = bus_a->parent;
+	bus_b = bus_b->parent;
+
+	/* connected via parent bus (may be NULL!) */
+	if (bus_a == bus_b)
+		return true;
+
+	if (!bus_a || !bus_b)
+		return false;
+
 	/*
 	 * on i915 discrete GPUs with embedded HDA audio, the two
 	 * devices are connected via 2nd level PCI bridge
 	 */
 	bus_a = bus_a->parent;
 	bus_b = bus_b->parent;
-	if (!bus_a || !bus_b)
-		return false;
-	bus_a = bus_a->parent;
-	bus_b = bus_b->parent;
 	if (bus_a && bus_a == bus_b)
 		return true;
 
-- 
2.39.2

