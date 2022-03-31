Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4F8D4ED4DE
	for <lists+linux-pci@lfdr.de>; Thu, 31 Mar 2022 09:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232260AbiCaHhe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 31 Mar 2022 03:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbiCaHhd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 31 Mar 2022 03:37:33 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 665C536683;
        Thu, 31 Mar 2022 00:35:46 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id n63-20020a1c2742000000b0038d0c31db6eso1444414wmn.1;
        Thu, 31 Mar 2022 00:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ONmMTWjwSUqraFi8W4kEMWh1P85vP4XkVwxc2sGEVho=;
        b=lbje+9+gc3xrG6okJX1wpH5HxRuxoqmwxyGVA4N5L2zRjliQHyVf9z7Bx7HQB2si/t
         sGjHaKkVmop5cBri+7unpveSyKh7Ezpz619Umm+xhsboKbljVGAdGPc9DVrwSQUyMaAL
         hDAXtoChZEa/L4D9MsHS4VfKv+rASOffsVcQlDgEEe2rlpz76sPHwVwT9LjPXoYoWe9A
         hoXevcyPNs/cD621Xy9EgTm/M86D5UEHtoHtrHCZvU0CEdg8mrknYl1AgIgBxCKRnFBy
         3IOpXanfc/J1ZMEDqb32612Bsh648KG+EWRLtSjiDkOcVzPzw42dwtmYkCAyWmjKQ5je
         0OXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ONmMTWjwSUqraFi8W4kEMWh1P85vP4XkVwxc2sGEVho=;
        b=N6jnHjNEW0nzNEBY9twnG36F6YimrXXi0kFwA2SYe59zLtkBJmidZ6nK+0yjI/v4Lm
         6E+FCmuq+zkrn0RtGP1PdzG1fEz6faWaSCZGBajQT2EHLp4bPR5NXPjrk48tP+Q9GKjK
         Zb3Ryb1hjzorxQmtmWdYwNoiLN/Ud8CsUh0Z0jjzOp7jRQgsZ0sj+NygHhbMlKAhmJHl
         ExRA7yg9dgVuwctI1G2CEaTrfW8B9lxgV4v+OT6FgE3GNV06Cpwe/kisrRrN6XpvwyeB
         If3/7e+wa8cu5+2ZN06tH627zQuUc0TBxt4a4YTqGlRDVSOHbJtvhDmsomtw8HHlRV5u
         eHlQ==
X-Gm-Message-State: AOAM531qBK0Blk8leq38xM4yQ8pPXIPaIvyGjxQQ0WPGdW637Giun/kH
        /8crLkDZSt4MnyPB8bdnVylnczLI31RN7Q==
X-Google-Smtp-Source: ABdhPJxsvy5o1KeOx2Ju8ASmB4+B6wkPw2Sl5yJLtswda6ay7sAg3vJvogesdMfM9ImTK9rhvVCSRA==
X-Received: by 2002:a05:600c:4f0f:b0:38c:c8f5:73e7 with SMTP id l15-20020a05600c4f0f00b0038cc8f573e7mr3449115wmq.201.1648712144613;
        Thu, 31 Mar 2022 00:35:44 -0700 (PDT)
Received: from Dev-shlomop.pliops.ent (bzq-219-32-62.isdn.bezeqint.net. [62.219.32.62])
        by smtp.googlemail.com with ESMTPSA id o17-20020a05600c4fd100b0038cd5074c83sm6947108wmq.34.2022.03.31.00.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 00:35:44 -0700 (PDT)
From:   Shlomo Pongratz <shlomopongratz@gmail.com>
X-Google-Original-From: Shlomo Pongratz <shlomop@pliops.com>
To:     linux-pci@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, andrew.maier@eideticom.com,
        logang@deltatee.com, bhelgaas@google.com, jgg@nvidia.com,
        helgaas@kernel.org, Shlomo Pongratz <shlomop@pliops.com>
Subject: [PATCH V5 1/1] Intel Sky Lake-E host root ports check.
Date:   Thu, 31 Mar 2022 10:35:39 +0300
Message-Id: <20220331073539.14499-2-shlomop@pliops.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220331073539.14499-1-shlomop@pliops.com>
References: <20220331073539.14499-1-shlomop@pliops.com>
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

The original code handled only the case where the devices in the whitelist are
host bridges and assumed that they will be found on slot 0.

This assumption doesn't hold for root ports so an explicit test was added to
cover this case.

Signed-off-by: Shlomo Pongratz <shlomop@pliops.com>
---
 drivers/pci/p2pdma.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 30b1df3c9d2f..87c62ca0976d 100644
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
@@ -350,7 +353,14 @@ static struct pci_dev *pci_host_bridge_dev(struct pci_host_bridge *host)
 
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

