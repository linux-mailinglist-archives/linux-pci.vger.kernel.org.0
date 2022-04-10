Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9294FAD7C
	for <lists+linux-pci@lfdr.de>; Sun, 10 Apr 2022 12:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237710AbiDJKyc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 10 Apr 2022 06:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237695AbiDJKyb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 10 Apr 2022 06:54:31 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E85E532DF;
        Sun, 10 Apr 2022 03:52:21 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id t1so1295180wra.4;
        Sun, 10 Apr 2022 03:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rHweLFr2iB2uow0Aua6+s52CdEHuVE0yA9XJTKzkZR8=;
        b=oBqncmVi7bp5wwUA11WsyCBTjx31GRE3mpjzEzVL2cMLWHur7jSC0SJ+IEsWUG7r6y
         30NOR+X0gdzLaF/QbtcQ+sK03wFHpBVEuX0RdNiRLSzc5bwmLJL/03MZtxtJqKn+/aW4
         yj6uBzLnXjTRNolvPu2oEWoHXfmMfreZWCTVVeJvvKRnGxxVO3KuqHotZw8O6dUxsX6Y
         Doa+sqJNiywrAv8UtL7JfQbYA3qrvJLHEmHOIghLQv9cudIBu8vMt/fxq96psBhT36ow
         Q1V0Xa/Z40iB+tuwQxyysgmMQvVLE/deD24cOTgFIDry8nAPE/cp8SN7zQe/YcyfuDQP
         RZfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rHweLFr2iB2uow0Aua6+s52CdEHuVE0yA9XJTKzkZR8=;
        b=GnlFPxK9GPYtrO2vh66NYsOqBBWl6HMThNrFbhTUKepIf2qRkHS4zU1iblg8nGOUWd
         XQVzeZ/ojcW71vTnpY2vZVYwSU76ODMe7yHwco3TcB1jnZTPGlAqxbU28GxIALyqgZXE
         icSv2lC4aYHXipw5QZcAbNBGXQENmsgV+jMOIqoEnPT9igmVa7pRAVvfAe8o/cSPWOn1
         K5fNQ+1tWjm1adwc4Xd38xi5C66HPhnPjiy/0H+QLy5B1Bjm7mcU958pgyR2s8UZtN0H
         RqNRftjHT88sW+e4HbqDCXL/cbcVJnaYxYtmOlviPyZUVLr6TrFXyeOqMo4SwyFzDVpl
         eQkA==
X-Gm-Message-State: AOAM531BkL3sfQwcIkk2IMVgrp3Ku72dQFDd9snHmlGu4W+Qlc/Sz8qM
        qULoZp7GTd7gEMxOLSXQABBCgctb7Iw=
X-Google-Smtp-Source: ABdhPJzhiFc2yYcyvG6IJ+B2OHrFSUBIuR0/I0ScdziAbfOs2Yq63hi2b0/sVQj4b+ibYzrcKAqKyA==
X-Received: by 2002:adf:8123:0:b0:206:1759:f164 with SMTP id 32-20020adf8123000000b002061759f164mr21755909wrm.654.1649587939458;
        Sun, 10 Apr 2022 03:52:19 -0700 (PDT)
Received: from Dev-shlomop.pliops.ent (bzq-219-32-62.isdn.bezeqint.net. [62.219.32.62])
        by smtp.googlemail.com with ESMTPSA id j9-20020a5d4529000000b00207a5b7f613sm666740wra.69.2022.04.10.03.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Apr 2022 03:52:19 -0700 (PDT)
From:   Shlomo Pongratz <shlomopongratz@gmail.com>
X-Google-Original-From: Shlomo Pongratz <shlomop@pliops.com>
To:     linux-pci@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, andrew.maier@eideticom.com,
        logang@deltatee.com, bhelgaas@google.com, jgg@nvidia.com,
        helgaas@kernel.org, Shlomo Pongratz <shlomop@pliops.com>
Subject: [PATCH V7 1/1] Intel Sky Lake-E host root ports check.
Date:   Sun, 10 Apr 2022 13:52:13 +0300
Message-Id: <20220410105213.690-2-shlomop@pliops.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220410105213.690-1-shlomop@pliops.com>
References: <20220410105213.690-1-shlomop@pliops.com>
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
 drivers/pci/p2pdma.c | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 30b1df3c9d2f..187047be83a0 100644
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
@@ -350,10 +354,19 @@ static struct pci_dev *pci_host_bridge_dev(struct pci_host_bridge *host)
 
 	if (!root)
 		return NULL;
-	if (root->devfn != PCI_DEVFN(0, 0))
-		return NULL;
 
-	return root;
+	/* Verify that the device is a host bridge or a root port
+	 * It is assumed that host bridges have a 0 devfn, (common practice)
+	 * but some of the entries in the whitelist are root ports that can
+	 * have any devfn
+	 */
+	if (root->devfn == PCI_DEVFN(0, 0))
+		return root;
+
+	if (pci_pcie_type(root) == PCI_EXP_TYPE_ROOT_PORT)
+		return root;
+
+	return NULL;
 }
 
 static bool __host_bridge_whitelist(struct pci_host_bridge *host,
-- 
2.17.1

