Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 949447988EC
	for <lists+linux-pci@lfdr.de>; Fri,  8 Sep 2023 16:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243929AbjIHOgt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Sep 2023 10:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239320AbjIHOgt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Sep 2023 10:36:49 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 891E51BF9
        for <linux-pci@vger.kernel.org>; Fri,  8 Sep 2023 07:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694183801; x=1725719801;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EOys5/dzQPH9uXnwslcx3/hnosLNBq5bjAQw/j9gA6E=;
  b=l+rmwKp/6XwM2F0qImfmN8tYt9nZRg9U0s0xYG9RZBlg76SVba+NsHy2
   0Bq4nSQHENcGt5nqssvCGdY9/0Mla/AD5nfv/nscw66JhMzNiIMbRwHyv
   U/nAJxs1gxlqYv1eaEvV4ROtl2QiZCJd5oiLt0sMmDy24XYZ7CCu3WGIM
   MDc6poPcgQrR3lccQ+TUVBFNqYG6Y6NdCaT7Sdyfm2+gRsCrWGnqFxqq3
   mOKHnthgTmKOm4gSyovjkxdTUeGctt3okiaXbZNhp8xHyVAo0SgpRs9Or
   VfhzRaOw3ur8ooA0mMHsVtPCsXmEnzyWf+kKcwBGrDVrSgckkZEWJZX5Y
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="362719527"
X-IronPort-AV: E=Sophos;i="6.02,237,1688454000"; 
   d="scan'208";a="362719527"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2023 07:36:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="808037740"
X-IronPort-AV: E=Sophos;i="6.02,237,1688454000"; 
   d="scan'208";a="808037740"
Received: from bartoszp-dev.igk.intel.com ([10.91.3.51])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2023 07:36:37 -0700
From:   Bartosz Pawlowski <bartosz.pawlowski@intel.com>
To:     linux-pci@vger.kernel.org, bhelgaas@google.com
Cc:     sheenamo@google.com, justai@google.com,
        andriy.shevchenko@intel.com, joel.a.gibson@intel.com,
        emil.s.tantilov@intel.com, gaurav.s.emmanuel@intel.com,
        mike.conover@intel.com, shaopeng.he@intel.com,
        anthony.l.nguyen@intel.com, pavan.kumar.linga@intel.com,
        Bartosz Pawlowski <bartosz.pawlowski@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/2] PCI: Extract ATS disabling to a helper function
Date:   Fri,  8 Sep 2023 14:36:05 +0000
Message-ID: <20230908143606.685930-2-bartosz.pawlowski@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230908143606.685930-1-bartosz.pawlowski@intel.com>
References: <20230908143606.685930-1-bartosz.pawlowski@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Introduce quirk_no_ats() helper function to provide a standard way to
disable ATS capability in PCI quirks.

Signed-off-by: Bartosz Pawlowski <bartosz.pawlowski@intel.com>
Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pci/quirks.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 321156ca273d..a900546d8d45 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5505,6 +5505,12 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0420, quirk_no_ext_tags);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0422, quirk_no_ext_tags);
 
 #ifdef CONFIG_PCI_ATS
+static void quirk_no_ats(struct pci_dev *pdev)
+{
+	pci_info(pdev, "disabling ATS\n");
+	pdev->ats_cap = 0;
+}
+
 /*
  * Some devices require additional driver setup to enable ATS.  Don't use
  * ATS for those devices as ATS will be enabled before the driver has had a
@@ -5518,14 +5524,10 @@ static void quirk_amd_harvest_no_ats(struct pci_dev *pdev)
 		    (pdev->subsystem_device == 0xce19 ||
 		     pdev->subsystem_device == 0xcc10 ||
 		     pdev->subsystem_device == 0xcc08))
-			goto no_ats;
-		else
-			return;
+			quirk_no_ats(pdev);
+	} else {
+		quirk_no_ats(pdev);
 	}
-
-no_ats:
-	pci_info(pdev, "disabling ATS\n");
-	pdev->ats_cap = 0;
 }
 
 /* AMD Stoney platform GPU */
-- 
2.41.0

