Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39A885B4080
	for <lists+linux-pci@lfdr.de>; Fri,  9 Sep 2022 22:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbiIIUZ1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Sep 2022 16:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbiIIUZY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Sep 2022 16:25:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36ACC9E2F0;
        Fri,  9 Sep 2022 13:25:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E7EE6B8263B;
        Fri,  9 Sep 2022 20:25:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CBD0C433C1;
        Fri,  9 Sep 2022 20:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662755119;
        bh=ObX4WKvSP1zWADS1BUQmuFfP7uJh4RJ/d8LngQndkIk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dVd1Uwt/Eww9jEhzK/ulXzQpGU2JD2gLm7mFE6ORhFDpPP79lxyjcNBlZJr+6KmkR
         oLQVAIC2kulaOIy+KSR2kDrtq7r8poa6UrE6pY4EJ3Ch1C6aG/i3mL9V3OxafMXBP7
         WS5a1mEaU+EbiBKUc28x9zIfdXWb0IX6YJcJIOTjsF2bJnYJfdp/8pVjoQBteq2C4G
         Pz1N+bc7Snq0JvUOLZZg/k4izCqXXRdnZU8Qrv1UMdIPtV7tg6dRIBaQcHt8kb+uSa
         EQ49NgSkBIgt4YVr2kDOEBQ8dKNT7HHHh87U2tM8LK+99lXhCT7fT0fU8RqGIJHj7B
         IknN9xaahGXqA==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Rajvi Jingar <rajvi.jingar@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Koba Ko <koba.ko@canonical.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v4 5/9] PCI/PTM: Move pci_ptm_info() body into its only caller
Date:   Fri,  9 Sep 2022 15:25:01 -0500
Message-Id: <20220909202505.314195-6-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220909202505.314195-1-helgaas@kernel.org>
References: <20220909202505.314195-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

pci_ptm_info() is simple and is only called by pci_enable_ptm().  Move the
entire body there.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/ptm.c | 38 +++++++++++++++++---------------------
 1 file changed, 17 insertions(+), 21 deletions(-)

diff --git a/drivers/pci/pcie/ptm.c b/drivers/pci/pcie/ptm.c
index 70a28b74e721..fc296b352fe2 100644
--- a/drivers/pci/pcie/ptm.c
+++ b/drivers/pci/pcie/ptm.c
@@ -9,26 +9,6 @@
 #include <linux/pci.h>
 #include "../pci.h"
 
-static void pci_ptm_info(struct pci_dev *dev)
-{
-	char clock_desc[8];
-
-	switch (dev->ptm_granularity) {
-	case 0:
-		snprintf(clock_desc, sizeof(clock_desc), "unknown");
-		break;
-	case 255:
-		snprintf(clock_desc, sizeof(clock_desc), ">254ns");
-		break;
-	default:
-		snprintf(clock_desc, sizeof(clock_desc), "%uns",
-			 dev->ptm_granularity);
-		break;
-	}
-	pci_info(dev, "PTM enabled%s, %s granularity\n",
-		 dev->ptm_root ? " (root)" : "", clock_desc);
-}
-
 static void __pci_disable_ptm(struct pci_dev *dev)
 {
 	u16 ptm = dev->ptm_cap;
@@ -213,16 +193,32 @@ static int __pci_enable_ptm(struct pci_dev *dev)
 int pci_enable_ptm(struct pci_dev *dev, u8 *granularity)
 {
 	int rc;
+	char clock_desc[8];
 
 	rc = __pci_enable_ptm(dev);
 	if (rc)
 		return rc;
 
 	dev->ptm_enabled = 1;
-	pci_ptm_info(dev);
 
 	if (granularity)
 		*granularity = dev->ptm_granularity;
+
+	switch (dev->ptm_granularity) {
+	case 0:
+		snprintf(clock_desc, sizeof(clock_desc), "unknown");
+		break;
+	case 255:
+		snprintf(clock_desc, sizeof(clock_desc), ">254ns");
+		break;
+	default:
+		snprintf(clock_desc, sizeof(clock_desc), "%uns",
+			 dev->ptm_granularity);
+		break;
+	}
+	pci_info(dev, "PTM enabled%s, %s granularity\n",
+		 dev->ptm_root ? " (root)" : "", clock_desc);
+
 	return 0;
 }
 EXPORT_SYMBOL(pci_enable_ptm);
-- 
2.25.1

