Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E82504E2ADD
	for <lists+linux-pci@lfdr.de>; Mon, 21 Mar 2022 15:33:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243302AbiCUOeN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Mar 2022 10:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349950AbiCUOdS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Mar 2022 10:33:18 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C3492B1B3;
        Mon, 21 Mar 2022 07:31:27 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id b19so20934795wrh.11;
        Mon, 21 Mar 2022 07:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=PL5VEgEzpRTaebf6MQD/gbU8LyaK1T1vt9TheGPUarY=;
        b=j3c8qHAGhF1qQPZdeWuuohBdUEySVAEMABRs2gdKgm3doGNx1gKATdthnPaJBX3BpX
         jeRRyN0C9/hNtU5SzUukIaU30TCHNTOGHqT3ZtnnCT0cbkuEhy/ori7TlnEXuoiLivEs
         sHVx9YG2jG/o+fuLUx6Hk2PxzYgIE7HEMuJDe9WNPeomdgK7tL7qnwekiL6rYU73Nxkz
         F0EjAt7He9AgQ33S3yOwmX+SsbNIOEDUs6/XyA18+5jaAQSrRwQlVniNQsccjMq/Rplo
         6UsVdx55Gk7Kl9OGX7Qs6M9pODvgAlQQf3ZsoqX7oiE9wi2z7sABPj9u00EdD0tfK9in
         3swg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=PL5VEgEzpRTaebf6MQD/gbU8LyaK1T1vt9TheGPUarY=;
        b=cHM3UaE236ksYhU8foZS2gmhodu+hQeH3kgVjvx24tmkSWkDG6+Nv7jO7qpUy9Qi0R
         Nb3BjD/gdZFXc7+AAgHbPMq79DZiWMqzOPny7f04Mpyqs90irhNeAi7LETXnerGEkPQm
         LfI1Cakw2QQ2C4vnqatEqo/wx2KbipLT2tZGDWDE0wRRa4FXwHjOrFAPhum08c2fbMGU
         y9BnhvPM0WB6x6rB5DUU/FNT1sj7BERksssLHORtaQardByVJ3kbLlc5mO6f6q4yCyBH
         GX3YfQfPv6XBmtPZVzzsSdG0qyPvmGcBBaF6ShkOqwNcsQwFLsKrLRALFAZMfoSxtv4x
         4pIQ==
X-Gm-Message-State: AOAM531m2ov9+wWjVh6EUh9SHL8LG3MNupWfqdzTL94462FoTS8e7WKm
        ZrIioq8oqY3K0uN9Zb9uUbuCy/sVWOV20w==
X-Google-Smtp-Source: ABdhPJzXcOMIJxRPFJWA9Yn4sR96mVXIJ5BXUGKsWiI8p1XCN6py4aI67N8Arj2ZFMLE4NlSI9GPtg==
X-Received: by 2002:adf:816b:0:b0:203:7fae:a245 with SMTP id 98-20020adf816b000000b002037faea245mr18743143wrm.619.1647873085475;
        Mon, 21 Mar 2022 07:31:25 -0700 (PDT)
Received: from Dev-shlomop.pliops.ent (bzq-219-32-62.isdn.bezeqint.net. [62.219.32.62])
        by smtp.googlemail.com with ESMTPSA id f7-20020a05600c154700b0038c85aade39sm10642703wmg.47.2022.03.21.07.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 07:31:25 -0700 (PDT)
From:   Shlomo Pongratz <shlomopongratz@gmail.com>
X-Google-Original-From: Shlomo Pongratz <shlomop@pliops.com>
To:     linux-pci@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, andrew.maier@eideticom.com,
        logang@deltatee.com, bhelgaas@google.com,
        Shlomo Pongratz <shlomop@pliops.com>
Subject: [PATCH v1] Intel Sky Lake-E host root ports check.
Date:   Mon, 21 Mar 2022 16:31:20 +0200
Message-Id: <20220321143120.12191-1-shlomop@pliops.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On commit 7b94b53db34f ("PCI/P2PDMA: Add Intel Sky Lake-E Root Ports B, C, D to the whitelist")
Andrew Maier added the Sky Lake-E additional devices
2031, 2032 and 2033 root ports to the already existing 2030 device.
Note that the Intel devices 2030, 2031, 2032 and 2033 are ports A, B, C and D.
Consider on a bus X only port C is connected downstream so in the PCI scan only
device 8086:2032 on 0000:X:02.0 will be found as bridges that have no children are ignored.
As a result the routine pci_host_bridge_dev will return NULL for devices under slot C.
In the proposed patch port field is added to the whitelist which is 0 for 2030, 1 for 2031,
2 for 2032 3 for 2033 and 0 for all other devices.

Signed-off-by: Shlomo Pongratz <shlomop@pliops.com>
---
 drivers/pci/p2pdma.c | 35 +++++++++++++++++++++++++----------
 1 file changed, 25 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 1015274bd2fe..86f6594a0b8a 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -305,22 +305,23 @@ static bool cpu_supports_p2pdma(void)
 static const struct pci_p2pdma_whitelist_entry {
 	unsigned short vendor;
 	unsigned short device;
+	unsigned short port;
 	enum {
 		REQ_SAME_HOST_BRIDGE	= 1 << 0,
 	} flags;
 } pci_p2pdma_whitelist[] = {
 	/* Intel Xeon E5/Core i7 */
-	{PCI_VENDOR_ID_INTEL,	0x3c00, REQ_SAME_HOST_BRIDGE},
-	{PCI_VENDOR_ID_INTEL,	0x3c01, REQ_SAME_HOST_BRIDGE},
+	{PCI_VENDOR_ID_INTEL,	0x3c00, 0, REQ_SAME_HOST_BRIDGE},
+	{PCI_VENDOR_ID_INTEL,	0x3c01, 0, REQ_SAME_HOST_BRIDGE},
 	/* Intel Xeon E7 v3/Xeon E5 v3/Core i7 */
-	{PCI_VENDOR_ID_INTEL,	0x2f00, REQ_SAME_HOST_BRIDGE},
-	{PCI_VENDOR_ID_INTEL,	0x2f01, REQ_SAME_HOST_BRIDGE},
+	{PCI_VENDOR_ID_INTEL,	0x2f00, 0, REQ_SAME_HOST_BRIDGE},
+	{PCI_VENDOR_ID_INTEL,	0x2f01, 0, REQ_SAME_HOST_BRIDGE},
 	/* Intel SkyLake-E */
-	{PCI_VENDOR_ID_INTEL,	0x2030, 0},
-	{PCI_VENDOR_ID_INTEL,	0x2031, 0},
-	{PCI_VENDOR_ID_INTEL,	0x2032, 0},
-	{PCI_VENDOR_ID_INTEL,	0x2033, 0},
-	{PCI_VENDOR_ID_INTEL,	0x2020, 0},
+	{PCI_VENDOR_ID_INTEL,	0x2030, 0, 0},
+	{PCI_VENDOR_ID_INTEL,	0x2031, 1, 0},
+	{PCI_VENDOR_ID_INTEL,	0x2032, 2, 0},
+	{PCI_VENDOR_ID_INTEL,	0x2033, 3, 0},
+	{PCI_VENDOR_ID_INTEL,	0x2020, 0, 0},
 	{}
 };
 
@@ -332,6 +333,11 @@ static const struct pci_p2pdma_whitelist_entry {
  * bus->devices list and that the devfn is 00.0. These assumptions should hold
  * for all the devices in the whitelist above.
  *
+ * The method above will work in most cases but not for all.
+ * Note that the Intel devices 2030, 2031, 2032 and 2033 are ports A, B, C and D.
+ * Consider on a bus X only port C is connected downstream so in the PCI scan only
+ * device 8086:2032 on 0000:X:02.0 will be found as birdges with no children are ignored
+ *
  * This function is equivalent to pci_get_slot(host->bus, 0), however it does
  * not take the pci_bus_sem lock seeing __host_bridge_whitelist() must not
  * sleep.
@@ -349,7 +355,10 @@ static struct pci_dev *pci_host_bridge_dev(struct pci_host_bridge *host)
 
 	if (!root)
 		return NULL;
-	if (root->devfn != PCI_DEVFN(0, 0))
+	/* Here just check that the function is 0
+	 * The slot number will be checked later
+	 */
+	if (PCI_FUNC(root->devfn) != 0)
 		return NULL;
 
 	return root;
@@ -371,6 +380,12 @@ static bool __host_bridge_whitelist(struct pci_host_bridge *host,
 	for (entry = pci_p2pdma_whitelist; entry->vendor; entry++) {
 		if (vendor != entry->vendor || device != entry->device)
 			continue;
+		/* For Intel Sky Lake-E host root ports check the port is
+		 * Identical to the slot number.
+		 * For other devices continue to inssist on slot 0
+		 */
+		if (PCI_SLOT(root->devfn) != entry->port)
+			return false;
 		if (entry->flags & REQ_SAME_HOST_BRIDGE && !same_host_bridge)
 			return false;
 
-- 
2.17.1

