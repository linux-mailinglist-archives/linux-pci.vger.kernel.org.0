Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B094D4EAB88
	for <lists+linux-pci@lfdr.de>; Tue, 29 Mar 2022 12:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235340AbiC2KpN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Mar 2022 06:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235334AbiC2KpL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Mar 2022 06:45:11 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC3110709D;
        Tue, 29 Mar 2022 03:43:28 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id i131-20020a1c3b89000000b0038ce25c870dso1011816wma.1;
        Tue, 29 Mar 2022 03:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=c2IFYmnlX3LtctOF/OSJwOtEdVTa8Sr9rCZrDFOChA0=;
        b=MohBJjdITUVsfvUmHBXpu7GyFMZORSvH64LX576VszGrWf7iKVZAGnfMjcCodzQ2FZ
         MNnhRr0z6OisrsxV8RFVeWUIGu5MEhCHTLKUb/x3SoBgza4UhLQwjLXahX51XFTePasW
         joj7JUtjgkpYU0t8wrBOGAXy+8nQy5BDkvn8uPUJiGsyJ3LiOHGks3KYIEJhzzchpET/
         k3Girg2lUUjvDVzV6FqatO0/bLc5MR94o4MrX2TnLz/k3SakuS4ZTg9wc41xVF6CmPV0
         MLrxMNGzKd2LisUieL1Fag/KRGYVZlZrvPmvn/ambcMxpQ9WcMOnTLvVmGNy+1tjC8sD
         pVQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=c2IFYmnlX3LtctOF/OSJwOtEdVTa8Sr9rCZrDFOChA0=;
        b=5B8Ca1f2x00mrren61HNKeqfPOupv2CxQHeblVeTOKpNnfbOfm1lCib+aNp3WUsPwF
         WBRMwbGaCTgagjtLnJGzpVkTKNwrOKezSz6I2fe+QwmjNRx0S7t8IgSEF1iM2IJ4P7lB
         n4uxSlWXQIG1uF9XiawDntAdnwl5ZhDFhWz6Pg/Fa05oNkyuS6s3E/SxeS80iXS5wHzg
         u9CCWmrJDKtotL1dYbQSv2nol2xZuMbs6+HSGZ08rjkD5HDtcpVFB5rlyBRzJhc+bgu8
         oMEG5taZ2FBUs0axdIL37P4JO2jzgHH8FrydgjvUWUGNojOtYPt6J+hDy2M15Yv8/ku6
         L3LQ==
X-Gm-Message-State: AOAM530mZwJQpU0Xxra2OoGdmRzfpjAozHVYYoDCCPiGNROXpBYTgLOC
        oPjjRYEkZ9pclqVN6HGLcnWgTzEGkDtJMQ==
X-Google-Smtp-Source: ABdhPJw7tx4g4MZ08usc5YDD7s3pGkWUgVVJoXyhaO7drros5Femduwp5f1svB0Bnlq17kmlrvDs7w==
X-Received: by 2002:a05:600c:348c:b0:38c:f335:7219 with SMTP id a12-20020a05600c348c00b0038cf3357219mr6137784wmq.174.1648550607033;
        Tue, 29 Mar 2022 03:43:27 -0700 (PDT)
Received: from Dev-shlomop.pliops.ent (bzq-219-32-62.isdn.bezeqint.net. [62.219.32.62])
        by smtp.googlemail.com with ESMTPSA id 3-20020a5d47a3000000b0020412ba45f6sm16919344wrb.8.2022.03.29.03.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 03:43:26 -0700 (PDT)
From:   Shlomo Pongratz <shlomopongratz@gmail.com>
X-Google-Original-From: Shlomo Pongratz <shlomop@pliops.com>
To:     linux-pci@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, andrew.maier@eideticom.com,
        logang@deltatee.com, bhelgaas@google.com, jgg@nvidia.com,
        Shlomo Pongratz <shlomop@pliops.com>
Subject: [PATCH V3 1/1] Intel Sky Lake-E host root ports check.
Date:   Tue, 29 Mar 2022 13:43:21 +0300
Message-Id: <20220329104321.4712-2-shlomop@pliops.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220329104321.4712-1-shlomop@pliops.com>
References: <20220329104321.4712-1-shlomop@pliops.com>
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
 drivers/pci/p2pdma.c | 42 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 37 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 30b1df3c9d2f..c088d4ab64f4 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -307,6 +307,7 @@ static const struct pci_p2pdma_whitelist_entry {
 	unsigned short device;
 	enum {
 		REQ_SAME_HOST_BRIDGE	= 1 << 0,
+		IS_ROOT_PORT		= 1 << 1,
 	} flags;
 } pci_p2pdma_whitelist[] = {
 	/* Intel Xeon E5/Core i7 */
@@ -316,15 +317,38 @@ static const struct pci_p2pdma_whitelist_entry {
 	{PCI_VENDOR_ID_INTEL,	0x2f00, REQ_SAME_HOST_BRIDGE},
 	{PCI_VENDOR_ID_INTEL,	0x2f01, REQ_SAME_HOST_BRIDGE},
 	/* Intel SkyLake-E */
-	{PCI_VENDOR_ID_INTEL,	0x2030, 0},
-	{PCI_VENDOR_ID_INTEL,	0x2031, 0},
-	{PCI_VENDOR_ID_INTEL,	0x2032, 0},
-	{PCI_VENDOR_ID_INTEL,	0x2033, 0},
+	{PCI_VENDOR_ID_INTEL,	0x2030, IS_ROOT_PORT},
+	{PCI_VENDOR_ID_INTEL,	0x2031, IS_ROOT_PORT},
+	{PCI_VENDOR_ID_INTEL,	0x2032, IS_ROOT_PORT},
+	{PCI_VENDOR_ID_INTEL,	0x2033, IS_ROOT_PORT},
 	{PCI_VENDOR_ID_INTEL,	0x2020, 0},
 	{PCI_VENDOR_ID_INTEL,	0x09a2, 0},
 	{}
 };
 
+/*
+ * The functionality of thisunction can be integrated into
+ * __host_bridge_whitelist function but this will make the code
+ * less readable
+ */
+static bool pci_is_root_port(struct pci_dev *root)
+{
+	const struct pci_p2pdma_whitelist_entry *entry;
+	unsigned short vendor, device;
+
+	vendor = root->vendor;
+	device = root->device;
+
+	for (entry = pci_p2pdma_whitelist; entry->vendor; entry++) {
+		if (vendor != entry->vendor || device != entry->device)
+			continue;
+
+		if (entry->flags & IS_ROOT_PORT)
+			return true;
+	}
+	return false;
+}
+
 /*
  * This lookup function tries to find the PCI device corresponding to a given
  * host bridge.
@@ -333,6 +357,11 @@ static const struct pci_p2pdma_whitelist_entry {
  * bus->devices list and that the devfn is 00.0. These assumptions should hold
  * for all the devices in the whitelist above.
  *
+ * The method above will work in most cases but not for all.
+ * Note that the Intel devices 2030, 2031, 2032 and 2033 are ports A, B, C and D.
+ * Consider on a bus X only port C has devices connected to it so in the PCI scan only
+ * device 8086:2032 on 0000:X:02.0 will be found as bridges with no children are ignored
+ *
  * This function is equivalent to pci_get_slot(host->bus, 0), however it does
  * not take the pci_bus_sem lock seeing __host_bridge_whitelist() must not
  * sleep.
@@ -350,7 +379,9 @@ static struct pci_dev *pci_host_bridge_dev(struct pci_host_bridge *host)
 
 	if (!root)
 		return NULL;
-	if (root->devfn != PCI_DEVFN(0, 0))
+
+	/* Intel Sky Lake-E host root ports can be on no zero slot */
+	if (root->devfn != PCI_DEVFN(0, 0) && !pci_is_root_port(root))
 		return NULL;
 
 	return root;
@@ -372,6 +403,7 @@ static bool __host_bridge_whitelist(struct pci_host_bridge *host,
 	for (entry = pci_p2pdma_whitelist; entry->vendor; entry++) {
 		if (vendor != entry->vendor || device != entry->device)
 			continue;
+
 		if (entry->flags & REQ_SAME_HOST_BRIDGE && !same_host_bridge)
 			return false;
 
-- 
2.17.1

