Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84D4F4E8760
	for <lists+linux-pci@lfdr.de>; Sun, 27 Mar 2022 13:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233532AbiC0LV7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 27 Mar 2022 07:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233372AbiC0LV5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 27 Mar 2022 07:21:57 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E781041612;
        Sun, 27 Mar 2022 04:20:18 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 125-20020a1c0283000000b0038d043aac51so86693wmc.0;
        Sun, 27 Mar 2022 04:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nqTG3qvPHwSLd69Bhfl8DLcubWaO/b0b6Q2u3TZ8woU=;
        b=kW8guoavkgQEbzVbbIyP8SoQ2fcD6aDvJT2ojpRJ6IhRVtKwWVc40A+2Nq51YTihiP
         vBSvDe2lBnbzYp9dJD0QoDDO50CCGuNlwrsPEoK5FFUzxwfwuJ8mVJAifU+xvIDY0bue
         VhN4ucl4sJZ84tTrXrSE+zSFLdRxahBSLWXuokDFc4RXI+QS1JC7NsNTEDArxUwKErzu
         hYwNNzg0zRf3fQZmu6F3xuK+rtRYDsEFTCaa6HOaLY6GimJTdh7OaEb0e9H6niPhA4JP
         vgcDJJKFZ3pLTXzenB75boo9UVcaXm+ymrsjgeockib4NSaMPpTnroIPlg3wkuygt7IQ
         VfXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nqTG3qvPHwSLd69Bhfl8DLcubWaO/b0b6Q2u3TZ8woU=;
        b=yc1iEFn2QBLwA35n3LwoszBiInUQj+SVtDa58FYYvj2i/qU+7/6309rU20exR2S7Do
         6MWemHSyTS2d7CtzEyo5dNfn2+bvfW/aBqL2pAqbEQbwp9scE/4fXDlfHyod4ZYKda7R
         kbcEBGGjQp/ilnVJG86PjFQiV30+2sCKCqwudjziDMULQ6OA91AQUabM0aG2ZGXz7ANf
         gEGkyvGhx0WcxtnEq94q9QLEkseLEmS1zIA/G0kyz9Exh1TpBTnoNGpODeYJxlOkSWvf
         +hpHjjsiwb2w9nGbCoL0hYs9Q6nGEX4JgIKISCNaOMMoP4xK04sQ0LJMZ6iwILTl/s5K
         j5UA==
X-Gm-Message-State: AOAM530eHhVl7zJYu9pELXoDcTcYveM9HPG9ejHnd/2VbCO8WAmh5cHU
        Ar7dj46Nb4kgtBnJZWmCzSx501lccbC9Dg==
X-Google-Smtp-Source: ABdhPJwLVLt9eCpYZZ22EOvNs/KHqlHpdkKx1nAPePAcSxmhUfszndEa2afbcCnmmknRRSNkD3mmSw==
X-Received: by 2002:a05:600c:154d:b0:38c:e9b8:d13f with SMTP id f13-20020a05600c154d00b0038ce9b8d13fmr12081443wmg.183.1648380017076;
        Sun, 27 Mar 2022 04:20:17 -0700 (PDT)
Received: from Dev-shlomop.pliops.ent (bzq-219-32-62.isdn.bezeqint.net. [62.219.32.62])
        by smtp.googlemail.com with ESMTPSA id f13-20020a05600c4e8d00b0038c949ef0d5sm10030117wmq.8.2022.03.27.04.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Mar 2022 04:20:16 -0700 (PDT)
From:   Shlomo Pongratz <shlomopongratz@gmail.com>
X-Google-Original-From: Shlomo Pongratz <shlomop@pliops.com>
To:     linux-pci@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, andrew.maier@eideticom.com,
        logang@deltatee.com, bhelgaas@google.com,
        Shlomo Pongratz <shlomop@pliops.com>
Subject: [PATCH V2 1/1] Intel Sky Lake-E host root ports check.
Date:   Sun, 27 Mar 2022 14:20:11 +0300
Message-Id: <20220327112011.3350-2-shlomop@pliops.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220327112011.3350-1-shlomop@pliops.com>
References: <20220327112011.3350-1-shlomop@pliops.com>
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

The Intel devices 2030, 2031, 2032 and 2033 which are ports A, B, C and D,
and if all exist they will occupy slots 0 till 3 in that order.

Now if for example device 2030 is missing then there will no device on slot 0, but
other devices can reside on other slots according to there port.
For this reason the test that insisted that the bridge should be on slot 0 was modified
to support bridges that are not on slot 0.

Signed-off-by: Shlomo Pongratz <shlomop@pliops.com>
---
 drivers/pci/p2pdma.c | 38 +++++++++++++++++++++++++++-----------
 1 file changed, 27 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 30b1df3c9d2f..ca8585ffbe56 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -305,23 +305,24 @@ static bool cpu_supports_p2pdma(void)
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
-	{PCI_VENDOR_ID_INTEL,	0x09a2, 0},
+	{PCI_VENDOR_ID_INTEL,	0x2030, 0, 0},
+	{PCI_VENDOR_ID_INTEL,	0x2031, 1, 0},
+	{PCI_VENDOR_ID_INTEL,	0x2032, 2, 0},
+	{PCI_VENDOR_ID_INTEL,	0x2033, 3, 0},
+	{PCI_VENDOR_ID_INTEL,	0x2020, 0, 0},
+	{PCI_VENDOR_ID_INTEL,	0x09a2, 0, 0},
 	{}
 };
 
@@ -333,6 +334,11 @@ static const struct pci_p2pdma_whitelist_entry {
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
@@ -350,7 +356,10 @@ static struct pci_dev *pci_host_bridge_dev(struct pci_host_bridge *host)
 
 	if (!root)
 		return NULL;
-	if (root->devfn != PCI_DEVFN(0, 0))
+	/* Here just check that the function is 0
+	 * The slot number will be checked later
+	 */
+	if (PCI_FUNC(root->devfn) != 0)
 		return NULL;
 
 	return root;
@@ -372,6 +381,13 @@ static bool __host_bridge_whitelist(struct pci_host_bridge *host,
 	for (entry = pci_p2pdma_whitelist; entry->vendor; entry++) {
 		if (vendor != entry->vendor || device != entry->device)
 			continue;
+		/* For devices which are bounded to a specific slot
+		 * (e.g. Intel Sky Lake-E host root ports) check the port is
+		 * Identical to the slot number.
+		 * For other devices continue to inssist on slot 0
+		 */
+		if (PCI_SLOT(root->devfn) != entry->port)
+			return false;
 		if (entry->flags & REQ_SAME_HOST_BRIDGE && !same_host_bridge)
 			return false;
 
-- 
2.17.1

