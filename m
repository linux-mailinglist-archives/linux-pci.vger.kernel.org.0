Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B555E4F08B0
	for <lists+linux-pci@lfdr.de>; Sun,  3 Apr 2022 12:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356329AbiDCKWK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 3 Apr 2022 06:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356297AbiDCKWK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 3 Apr 2022 06:22:10 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6242A3057C;
        Sun,  3 Apr 2022 03:20:16 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id h4so10246739wrc.13;
        Sun, 03 Apr 2022 03:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DjmQ/60oEsUOVlbM/+sAzXrdxlHPtL6WOZl1FVBOfSw=;
        b=NzTuwFGAvevnkfF2CZiC+nsjkjYF26Bz9yF89nT6ur11+Kc5dEcSs/miXSJdcez6mt
         e/NU2JcPoxFu5OKQVbJcyfaFYpPYv3/YgERmuC+r5VLBfQr1GEHE1LG0Zezz4QBqLTdy
         cdt0OWA8rAkX1dHefmBN/bm5zEeE5Icncp4JU7OTjmtJFpkXfmmFd2s73FaWX0+6/U1S
         wMzbTgO0SG4Ya0jBsyU1nXCU6xfHkl/bmVtSZMW9mBr59Qh0TVS3/M9E4UYjbnAELkqL
         pjGLSLyLBDhvWp/gh+iEgWd2edNi3v+V5liO8/iue8vQzQe1ppc5Ao+jYI6pevJ1T04b
         ohxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DjmQ/60oEsUOVlbM/+sAzXrdxlHPtL6WOZl1FVBOfSw=;
        b=Q6eGyTPQHkDYSgtFeuzW4XqRMSUA58fnef+ECcTKRpYjS7Gi6/lpyfYbsScv59hdEP
         dGGkf3hg4PZf3nRNWS03Igx05LNfX5ekIssrxyi/5GbsPMasDNB6CzMWiZ/4w7KJZbVQ
         A/zpkkhhPQQ1KqyUWIv78kuu6Y4RGOXBaZUyiGzfiRZHQ6M6mql+kMzqCDe3tnjmWJf3
         sKQU0xJi0otHo4lHouoIJ7oXT5hDNV200dIPApixvYr0ZyM1QnOO+hdpIV93Q3CUo+vS
         XaERK8fMS3mu/Fu39GxEr30l5Z1yROfEr9jPNwio9J4/lbpxzhOssJXWKI8qVFwctEdH
         oPMw==
X-Gm-Message-State: AOAM5314ZUxNXGrojO/Ds3MFj+9IJPRZcJkLfuo+jTIpoKTrvpp9FDj6
        BklIm3mUwwwi3d7FLJsFMNef19GV55I=
X-Google-Smtp-Source: ABdhPJz7mE4GGrW3/bwr8E8GW8yq21yEERHVFUERh/7i46ZYkcHXf68fEiCSygq2DWPEm4LMV1krjQ==
X-Received: by 2002:adf:d1e7:0:b0:205:8909:a67f with SMTP id g7-20020adfd1e7000000b002058909a67fmr13419004wrd.66.1648981214536;
        Sun, 03 Apr 2022 03:20:14 -0700 (PDT)
Received: from Dev-shlomop.pliops.ent (bzq-219-32-62.isdn.bezeqint.net. [62.219.32.62])
        by smtp.googlemail.com with ESMTPSA id k23-20020a7bc417000000b0038ccada7566sm13639895wmi.11.2022.04.03.03.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Apr 2022 03:20:14 -0700 (PDT)
From:   Shlomo Pongratz <shlomopongratz@gmail.com>
X-Google-Original-From: Shlomo Pongratz <shlomop@pliops.com>
To:     linux-pci@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, andrew.maier@eideticom.com,
        logang@deltatee.com, bhelgaas@google.com, jgg@nvidia.com,
        helgaas@kernel.org, Shlomo Pongratz <shlomop@pliops.com>
Subject: [PATCH V6 1/1] Intel Sky Lake-E host root ports check.
Date:   Sun,  3 Apr 2022 13:20:08 +0300
Message-Id: <20220403102008.7122-2-shlomop@pliops.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220403102008.7122-1-shlomop@pliops.com>
References: <20220403102008.7122-1-shlomop@pliops.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In commit 7b94b53db34f ("PCI/P2PDMA: Add Intel Sky Lake-E Root Ports B, C,
 D to the whitelist")
Andrew Maier added the Sky Lake-E additional devices
2031, 2032 and 2033 root ports to the already existing 2030 device.

The Intel devices 2030, 2031, 2032 and 2033 which are root ports A, B, C
and D, respectively and if all exist they will occupy slots 0 till 3 in
that order.

The original code handled only the case where the devices in the whitelist
are host bridges and assumed that they will be found on slot 0.

Since this assumption doesn't hold for root ports, add a test to cover this
case.

Signed-off-by: Shlomo Pongratz <shlomop@pliops.com>
---
 drivers/pci/p2pdma.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 30b1df3c9d2f..c281bf5b304a 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -327,15 +327,19 @@ static const struct pci_p2pdma_whitelist_entry {
 
 /*
  * This lookup function tries to find the PCI device corresponding to a given
- * host bridge.
+ * host bridge or a root port.
  *
  * It assumes the host bridge device is the first PCI device in the
- * bus->devices list and that the devfn is 00.0. These assumptions should hold
- * for all the devices in the whitelist above.
+ * bus->devices list and that the devfn is 00.0. The first assumption should
+ * hold for all the devices in the whitelist above, however the second
+ * assumption doesn't always hold for root ports.
+ * For example for Intel Skylake devices 2030, 2031, 2032 and 2033,
+ * which are root ports (A, B, C and D respectively).
+ * So the function checks explicitly that the device is a root port.
  *
- * This function is equivalent to pci_get_slot(host->bus, 0), however it does
- * not take the pci_bus_sem lock seeing __host_bridge_whitelist() must not
- * sleep.
+ * This function is equivalent to pci_get_slot(host->bus, 0) (except for
+ * the root port test), however it does not take the pci_bus_sem lock seeing
+ * __host_bridge_whitelist() must not sleep.
  *
  * For this to be safe, the caller should hold a reference to a device on the
  * bridge, which should ensure the host_bridge device will not be freed
@@ -350,7 +354,14 @@ static struct pci_dev *pci_host_bridge_dev(struct pci_host_bridge *host)
 
 	if (!root)
 		return NULL;
-	if (root->devfn != PCI_DEVFN(0, 0))
+
+	/* Verify that the device is a host bridge or a root port
+	 * It is assumed that host bridges have a 0 devfn, (common practice)
+	 * but some of the entries in the whitelist are root ports that can
+	 * have any devfn
+	 */
+	if (root->devfn != PCI_DEVFN(0, 0) &&
+	    pci_pcie_type(root) != PCI_EXP_TYPE_ROOT_PORT)
 		return NULL;
 
 	return root;
-- 
2.17.1

