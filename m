Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C96DC77E77F
	for <lists+linux-pci@lfdr.de>; Wed, 16 Aug 2023 19:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345176AbjHPRWE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Aug 2023 13:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345241AbjHPRVq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Aug 2023 13:21:46 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31CA92D45
        for <linux-pci@vger.kernel.org>; Wed, 16 Aug 2023 10:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692206505; x=1723742505;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=huWn2mwZZ2Ngy4H7xrIUHBwD/SQ1RTl0qEma5ZY/NpY=;
  b=ZyHYSftmJPtlyPzrZ2sBiGN2Uf4awugl/mrbWH8YcXynRnWFbfWjEuKo
   NvNIpcqkw8DvsddktK5nG2r4xHM5sKP9RpnDbzaDIvfTEFUH5C7L8vH4i
   6kCD/DYv38ETF6qTw0alIoyd2RZ65083KuB3nFRMhypFYge6Obqnq42QU
   n79jvZWuFZvR+te8MFnxZ0rbrXNuPW03ZiOAC79a7CM00gLxlJiRhl93N
   BN4ZxLeZY3LmRC9TpEHYtD0wDsqNoDH142VI3OysYfSe/m+z31RIZOTWh
   NOP/zMqcptrB3kIqK5bV2iYHlh6gXTZH4OypnA6Fa5HHnaQoMa4ePrCXt
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="372596292"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="372596292"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 10:21:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="769280037"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="769280037"
Received: from bartoszp-dev.igk.intel.com ([10.91.3.51])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 10:21:41 -0700
From:   Bartosz Pawlowski <bartosz.pawlowski@intel.com>
To:     linux-pci@vger.kernel.org, bhelgaas@google.com
Cc:     sheenamo@google.com, justai@google.com,
        andriy.shevchenko@intel.com, joel.a.gibson@intel.com,
        emil.s.tantilov@intel.com, gaurav.s.emmanuel@intel.com,
        mike.conover@intel.com, shaopeng.he@intel.com,
        anthony.l.nguyen@intel.com, pavan.kumar.linga@intel.com,
        Bartosz Pawlowski <bartosz.pawlowski@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 1/2] PCI: Extract ATS disabling to a helper function
Date:   Wed, 16 Aug 2023 17:21:14 +0000
Message-ID: <20230816172115.1375716-2-bartosz.pawlowski@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230816172115.1375716-1-bartosz.pawlowski@intel.com>
References: <20230816172115.1375716-1-bartosz.pawlowski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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

---------------------------------------------------------------------
Intel Technology Poland sp. z o.o.
ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-316 | Kapital zakladowy 200.000 PLN.
Spolka oswiadcza, ze posiada status duzego przedsiebiorcy w rozumieniu ustawy z dnia 8 marca 2013 r. o przeciwdzialaniu nadmiernym opoznieniom w transakcjach handlowych.

Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiekolwiek przegladanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by others is strictly prohibited.

