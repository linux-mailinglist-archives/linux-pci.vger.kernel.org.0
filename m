Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3FC67A63FE
	for <lists+linux-pci@lfdr.de>; Tue, 19 Sep 2023 14:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbjISM5V (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Sep 2023 08:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232314AbjISM5S (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Sep 2023 08:57:18 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD57181;
        Tue, 19 Sep 2023 05:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695128232; x=1726664232;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=owLTR4BdRMVCw3koAJFrF4ot3jKom6tn6pjCI8DaxDE=;
  b=BUn2aCvY0PRW97GtYI8KgcrX2dUMFYS3ATs3aGb+N7JKIDzguhR/nWzh
   NsTRu6wBBs6O7EJwnLcSsIRqSiiypVDfP+2hi28YhNO8IYlpIuk+KTld5
   0NnZqzZg/5uLrFto3DxkmIUayAFnDt7exRhUG/NGO3veo3QPQjtAxYzxh
   t0VnVyK6E7vkem3DlO83hxhQ9PqzTITbHX+ZFKQDM7DKrek2R19R1t53+
   Sky1ENdMhXudDbiieyZH6ch1Y38sCjmKM1swFAg88kpWJgXaHTSv4SdF8
   DxkmdC/JkGz0ZfMlh5vZPJK7SIPEHJmFgBNsl/whklY3IudMTJ/trrFsg
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="359324642"
X-IronPort-AV: E=Sophos;i="6.02,159,1688454000"; 
   d="scan'208";a="359324642"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 05:57:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="746228718"
X-IronPort-AV: E=Sophos;i="6.02,159,1688454000"; 
   d="scan'208";a="746228718"
Received: from vdesserx-mobl1.ger.corp.intel.com (HELO localhost.localdomain) ([10.249.32.31])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 05:57:06 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v3 2/8] media: cobalt: Use FIELD_GET() to extract Link Width
Date:   Tue, 19 Sep 2023 15:56:42 +0300
Message-Id: <20230919125648.1920-3-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230919125648.1920-1-ilpo.jarvinen@linux.intel.com>
References: <20230919125648.1920-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Use FIELD_GET() to extract PCIe Negotiated and Maximum Link Width fields
instead of custom masking and shifting.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/media/pci/cobalt/cobalt-driver.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/media/pci/cobalt/cobalt-driver.c b/drivers/media/pci/cobalt/cobalt-driver.c
index 74edcc76d12f..6e1a0614e6d0 100644
--- a/drivers/media/pci/cobalt/cobalt-driver.c
+++ b/drivers/media/pci/cobalt/cobalt-driver.c
@@ -8,6 +8,7 @@
  *  All rights reserved.
  */
 
+#include <linux/bitfield.h>
 #include <linux/delay.h>
 #include <media/i2c/adv7604.h>
 #include <media/i2c/adv7842.h>
@@ -210,17 +211,17 @@ void cobalt_pcie_status_show(struct cobalt *cobalt)
 	pcie_capability_read_word(pci_dev, PCI_EXP_LNKSTA, &stat);
 	cobalt_info("PCIe link capability 0x%08x: %s per lane and %u lanes\n",
 			capa, get_link_speed(capa),
-			(capa & PCI_EXP_LNKCAP_MLW) >> 4);
+			FIELD_GET(PCI_EXP_LNKCAP_MLW, capa));
 	cobalt_info("PCIe link control 0x%04x\n", ctrl);
 	cobalt_info("PCIe link status 0x%04x: %s per lane and %u lanes\n",
 		    stat, get_link_speed(stat),
-		    (stat & PCI_EXP_LNKSTA_NLW) >> 4);
+		    FIELD_GET(PCI_EXP_LNKSTA_NLW, stat));
 
 	/* Bus */
 	pcie_capability_read_dword(pci_bus_dev, PCI_EXP_LNKCAP, &capa);
 	cobalt_info("PCIe bus link capability 0x%08x: %s per lane and %u lanes\n",
 			capa, get_link_speed(capa),
-			(capa & PCI_EXP_LNKCAP_MLW) >> 4);
+			FIELD_GET(PCI_EXP_LNKCAP_MLW, capa));
 
 	/* Slot */
 	pcie_capability_read_dword(pci_dev, PCI_EXP_SLTCAP, &capa);
@@ -239,7 +240,7 @@ static unsigned pcie_link_get_lanes(struct cobalt *cobalt)
 	if (!pci_is_pcie(pci_dev))
 		return 0;
 	pcie_capability_read_word(pci_dev, PCI_EXP_LNKSTA, &link);
-	return (link & PCI_EXP_LNKSTA_NLW) >> 4;
+	return FIELD_GET(PCI_EXP_LNKSTA_NLW, link);
 }
 
 static unsigned pcie_bus_link_get_lanes(struct cobalt *cobalt)
@@ -250,7 +251,7 @@ static unsigned pcie_bus_link_get_lanes(struct cobalt *cobalt)
 	if (!pci_is_pcie(pci_dev))
 		return 0;
 	pcie_capability_read_dword(pci_dev, PCI_EXP_LNKCAP, &link);
-	return (link & PCI_EXP_LNKCAP_MLW) >> 4;
+	return FIELD_GET(PCI_EXP_LNKCAP_MLW, link);
 }
 
 static void msi_config_show(struct cobalt *cobalt, struct pci_dev *pci_dev)
-- 
2.30.2

