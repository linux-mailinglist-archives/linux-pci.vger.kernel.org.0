Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 933F65AF7DD
	for <lists+linux-pci@lfdr.de>; Wed,  7 Sep 2022 00:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbiIFWYi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Sep 2022 18:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbiIFWYR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Sep 2022 18:24:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA2E6AB417;
        Tue,  6 Sep 2022 15:24:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D14361714;
        Tue,  6 Sep 2022 22:24:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35126C433D6;
        Tue,  6 Sep 2022 22:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662503050;
        bh=AvPvkozYP8lvZ3lyaRCBEZlCgNXntwO4lZojFieDtfc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bmcv0F9Ft7fOIr0Upkvq3lgYPE3ClrJBD26uNzovQwCifO9S6MuQ+jYyQlVlZ/H1S
         u47asImqLq1MnIYTGIQMAZw9LYscFev6hTLT6PIJ/EcMbzJOBkmnLhPsjtOwcEHp++
         xirr5l1F3rHUdwcquIJ9wiYwH6PUEdwNwa3oCX0MPLXdHp7CQPawsSu8JTeX0VsyDw
         TI4KXJ0sPwoB67qK9bApSQ7GNg9qffSMn6C0mXUMDsdjAS0+FvvZZdk6T15BnSFpY2
         ftKc1f08d0KMKMBSCAMOCpf9Y1ACDHhkSiNcWfvZ5Ptyswk6fNq3xNSS0CyyfXyPRD
         VFG0HdegCOj+A==
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
Subject: [PATCH v3 08/10] PCI/PTM: Move pci_ptm_info() body into its only caller
Date:   Tue,  6 Sep 2022 17:23:49 -0500
Message-Id: <20220906222351.64760-9-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220906222351.64760-1-helgaas@kernel.org>
References: <20220906222351.64760-1-helgaas@kernel.org>
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
entire body there.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/ptm.c | 39 +++++++++++++++++----------------------
 1 file changed, 17 insertions(+), 22 deletions(-)

diff --git a/drivers/pci/pcie/ptm.c b/drivers/pci/pcie/ptm.c
index 8ac844212436..d65f5af9700d 100644
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
 	int ptm = dev->ptm_cap;
@@ -183,6 +163,7 @@ static int __pci_enable_ptm(struct pci_dev *dev)
 int pci_enable_ptm(struct pci_dev *dev, u8 *granularity)
 {
 	int rc;
+	char clock_desc[8];
 
 	rc = __pci_enable_ptm(dev);
 	if (rc)
@@ -190,10 +171,24 @@ int pci_enable_ptm(struct pci_dev *dev, u8 *granularity)
 
 	dev->ptm_enabled = 1;
 
-	pci_ptm_info(dev);
-
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

