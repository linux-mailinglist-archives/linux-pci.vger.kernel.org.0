Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06DF24EC62C
	for <lists+linux-pci@lfdr.de>; Wed, 30 Mar 2022 16:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346596AbiC3OKS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Mar 2022 10:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344087AbiC3OKS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Mar 2022 10:10:18 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E69E7197FAE;
        Wed, 30 Mar 2022 07:08:31 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id b19so29445448wrh.11;
        Wed, 30 Mar 2022 07:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qMb8I9yb8zXna+ph82rtTSaTfX9Wmxw5201Wn2H77RE=;
        b=j2XmH+NydNmOeH96zyWRc8tcCxM54QYx85qeir6RyQS/AJ9/ROnsaB/AjQKjZd8lfA
         x4ggAK3oLlX38GeDfLZR+ovA6iyoYHN3NOm7aWgoERCEoAbG1fx1jfV/yVt7fDEoJKPI
         mciVIjPyTcyrxV5kV+EBxIEIpnlb02WGlr7KgDf8thIx/xDM+sfe7dkQyaSZrqSJ3Lcu
         SKUZmc6/Q2iOHo030H5/bUKxsjjZYRp4JuKHQC+4lZJ+Jd6Y9+UqV3QC1fbuDOfldgi4
         yRhP4w8q6GXtTOu+1iA/vQJLpNfyd4bFf28j8NfM3HaJYnNrT3UzBPurd2TwK0f5URKp
         /pyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qMb8I9yb8zXna+ph82rtTSaTfX9Wmxw5201Wn2H77RE=;
        b=Ki1SrBlrUFAGwrL22N4J7mHNzOVkQhKnE5nka+0DcQYYpDCVWyBn1rarWihOXV1PLp
         rr3SwcfWN+Whi3sIspEOscMigmet+DyqXURM7oVtKcto5/9OfEQKSSStAnD/48tXLX/6
         HgyqdUczkOV49FHycwFLD4t6++SiVzDVHQW0hrRm1srTtgmPASrmjwIkmDir9vMi/cmf
         PXzQ9FnNe3cBGY2MQcl0sCg5RCbab6TlRUzDLYo/2z20lw/3eMsNsqJYOZd8HozjqrHp
         KeY7BiTkptL+f9Skh2dX7lNq3wS24ge2uj2jNrQLhJHeErMO0fNigqht7ZoRW9XCRA5x
         QyKQ==
X-Gm-Message-State: AOAM532wzX487ixF6iTUE4hxSRD8gyOUhz1SasKra1vufk0Fx99CHLQk
        UmgoLxTpVTmcSLsjR5R+QCyY/sHMjMNHZg==
X-Google-Smtp-Source: ABdhPJzxinf0tXRpnGQ8FeOLnI56RGRfyhOPiP5IL4JxY0Sj2ZHKcj3xgYZqU0qf+zxt28BK3bt6Pg==
X-Received: by 2002:a5d:59a3:0:b0:203:d9fa:6968 with SMTP id p3-20020a5d59a3000000b00203d9fa6968mr36695096wrr.585.1648649309992;
        Wed, 30 Mar 2022 07:08:29 -0700 (PDT)
Received: from Dev-shlomop.pliops.ent (bzq-219-32-62.isdn.bezeqint.net. [62.219.32.62])
        by smtp.googlemail.com with ESMTPSA id 14-20020a056000154e00b00203f8adde0csm22272782wry.32.2022.03.30.07.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 07:08:29 -0700 (PDT)
From:   Shlomo Pongratz <shlomopongratz@gmail.com>
X-Google-Original-From: Shlomo Pongratz <shlomop@pliops.com>
To:     linux-pci@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, andrew.maier@eideticom.com,
        logang@deltatee.com, bhelgaas@google.com, jgg@nvidia.com,
        helgaas@kernel.org, Shlomo Pongratz <shlomop@pliops.com>
Subject: [PATCH V4 1/1] Intel Sky Lake-E host root ports check.
Date:   Wed, 30 Mar 2022 17:08:23 +0300
Message-Id: <20220330140823.28826-2-shlomop@pliops.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220330140823.28826-1-shlomop@pliops.com>
References: <20220330140823.28826-1-shlomop@pliops.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In commit 7b94b53db34f ("PCI/P2PDMA: Add Intel Sky Lake-E Root Ports B, C, D to
the whitelist")
Andrew Maier added the Sky Lake-E additional devices
2031, 2032 and 2033 root ports to the already existing 2030 device.

The Intel devices 2030, 2031, 2032 and 2033 which are root ports A, B, C and D,
respectively and if all exist they will occupy slots 0 till 3 in that order.

The original code handled only the case where the devices in the whiltlist are
host bridges and assumed that they will be found on slot 0.

This assumption doesn't hold for root ports so an explicit test was added to
cover this case.

Signed-off-by: Shlomo Pongratz <shlomop@pliops.com>
---
 drivers/pci/p2pdma.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 30b1df3c9d2f..107905dfa229 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -327,15 +327,18 @@ static const struct pci_p2pdma_whitelist_entry {
 
 /*
  * This lookup function tries to find the PCI device corresponding to a given
- * host bridge.
+ * host bridge or a root port.
  *
  * It assumes the host bridge device is the first PCI device in the
- * bus->devices list and that the devfn is 00.0. These assumptions should hold
- * for all the devices in the whitelist above.
+ * bus->devices list and that the devfn is 00.0. The first assumption should
+ * hold for all the devices in the whitelist above, however the second one
+ * doesn't always holds for root ports, for example Intel SkyLake-E devices
+ * 2030, 2031, 2032 and 2033 which are root ports (A, B, C and D respectively).
+ * So being a root port is checked explicitly.
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
@@ -350,7 +353,10 @@ static struct pci_dev *pci_host_bridge_dev(struct pci_host_bridge *host)
 
 	if (!root)
 		return NULL;
-	if (root->devfn != PCI_DEVFN(0, 0))
+
+	/* Is it a host bridge or a root port? */
+	if (root->devfn != PCI_DEVFN(0, 0) &&
+		pci_pcie_type(root) != PCI_EXP_TYPE_ROOT_PORT)
 		return NULL;
 
 	return root;
-- 
2.17.1

