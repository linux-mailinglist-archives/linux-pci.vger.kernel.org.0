Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE33C40D51D
	for <lists+linux-pci@lfdr.de>; Thu, 16 Sep 2021 10:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235393AbhIPIxd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Sep 2021 04:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235316AbhIPIxc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Sep 2021 04:53:32 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FBC7C061574;
        Thu, 16 Sep 2021 01:52:12 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id v24so13997859eda.3;
        Thu, 16 Sep 2021 01:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GxP2uKBfbUku55tG87EMT8hB++2deSEx0R8pEtMyHjM=;
        b=quxD+i3vlplT3f62DHu1FaJ1Mv2vwOtL454uy4Ycp/uAj2y2+87ITb9Ck77fOiE6gY
         AtgqfFw62+1aok/KU6H1kEzq4LjwqHhOXD2o4V24hJjjmUKJgb2nsdPLNpBaL2H/jyR8
         C7YI1KwEmMUNB3pJVgwxDE7lbiYSHJGjv6Z6W2fQJrAVFFA8J9+sVyxs5abS5ouI0//F
         2HcnUZ/4/y8p20x/t5dW3r4zT1kPgkqJOMO8cBelRByiddTvbo24GS9lzSbv/QOABN3W
         wH+dkAnCkknMv2+0Y9ePDTkDI7tXWPY0Tv/C9HR3eXdiV/u/nq2MXNnnLcGK+zFjYJtR
         oxMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GxP2uKBfbUku55tG87EMT8hB++2deSEx0R8pEtMyHjM=;
        b=n3Y3J1QoW6ppq9n1yrQaM3iR5Qi7okQJ++DEVihlFB/C1Wek0tkE+eeAWeQXTAMfCa
         hNiO4w4NqH/9vEMuxr3KZlCFvLvhuUqH8VriUpU8mI3+S1SacqNYsGhE2yN5/M2UcQ6P
         0Ac11iJW2q3NWzRUEBitjRavCE2X2A3ngu6upYw2xImeuRaRBoI/M5Jw3kF1GjaJwpWT
         oqOdi1JufAhtoYz+ivdM1op/Tj2aTCBmztd8Ta4nTOPNAQKSTrldoy+w/S6CsXjFErZc
         oVnaInRigjl9phjd2fpwaoD0YVZWjbWTli32f0QUzxHRyVNvjXqXDTFIjwG3OJmqvS3t
         DoLg==
X-Gm-Message-State: AOAM531uC1z1Bhv/fgAGc1pWmxQZolmnDCeYKvWbb0LHXqDCKN8Pd1JF
        ZlLR32E90uKodxKJxO9TfzM=
X-Google-Smtp-Source: ABdhPJyTOoTkkiS4YZ6TdcIrcnKkOcdPTXzueT8hsiuRJNBW2hJvJk+7c+rtB2sro1jINh62KHRvMQ==
X-Received: by 2002:a05:6402:1e88:: with SMTP id f8mr5098655edf.126.1631782330869;
        Thu, 16 Sep 2021 01:52:10 -0700 (PDT)
Received: from localhost.localdomain (catv-176-63-0-115.catv.broadband.hu. [176.63.0.115])
        by smtp.googlemail.com with ESMTPSA id t24sm1112961edr.84.2021.09.16.01.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 01:52:10 -0700 (PDT)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     helgaas@kernel.org
Cc:     "Bolarinwa O. Saheed" <refactormyself@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com
Subject: [RFC PATCH 1/4] PCI/ASPM: Remove struct pcie_link_state.parent
Date:   Thu, 16 Sep 2021 10:52:03 +0200
Message-Id: <20210916085206.2268-2-refactormyself@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210916085206.2268-1-refactormyself@gmail.com>
References: <20210916085206.2268-1-refactormyself@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: "Bolarinwa O. Saheed" <refactormyself@gmail.com>

Information cached in struct pcie_link_state.parent is accessible
via struct pci_dev.

This patch:
 - removes *parent* from the *struct pcie_link_state*
 - adjusts all references to it to access the information directly

Signed-off-by: Bolarinwa O. Saheed <refactormyself@gmail.com>
---
OPINION: the checkpatch.pl scring warns on this line:
	`BUG_ON(root->pdev->bus->parent->self);`
however, I think if a root device reports a parent, that is serious!

 drivers/pci/pcie/aspm.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 013a47f587ce..48b83048aa30 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -50,7 +50,6 @@ struct pcie_link_state {
 	struct pci_dev *pdev;		/* Upstream component of the Link */
 	struct pci_dev *downstream;	/* Downstream component, function 0 */
 	struct pcie_link_state *root;	/* pointer to the root port link */
-	struct pcie_link_state *parent;	/* pointer to the parent Link state */
 	struct list_head sibling;	/* node in link_list */
 
 	/* ASPM state */
@@ -379,6 +378,7 @@ static void encode_l12_threshold(u32 threshold_us, u32 *scale, u32 *value)
 static void pcie_aspm_check_latency(struct pci_dev *endpoint)
 {
 	u32 latency, l1_switch_latency = 0;
+	struct pci_dev *parent;
 	struct aspm_latency *acceptable;
 	struct pcie_link_state *link;
 
@@ -419,7 +419,8 @@ static void pcie_aspm_check_latency(struct pci_dev *endpoint)
 			link->aspm_capable &= ~ASPM_STATE_L1;
 		l1_switch_latency += 1000;
 
-		link = link->parent;
+		parent = link->pdev->bus->parent->self;
+		link = !parent ? NULL : parent->link_state;
 	}
 }
 
@@ -793,9 +794,11 @@ static void pcie_config_aspm_link(struct pcie_link_state *link, u32 state)
 
 static void pcie_config_aspm_path(struct pcie_link_state *link)
 {
+	struct pci_dev *parent;
 	while (link) {
 		pcie_config_aspm_link(link, policy_to_aspm_state(link));
-		link = link->parent;
+		parent = link->pdev->bus->parent->self;
+		link = !parent ? NULL : parent->link_state;
 	}
 }
 
@@ -872,8 +875,7 @@ static struct pcie_link_state *alloc_pcie_link_state(struct pci_dev *pdev)
 			return NULL;
 		}
 
-		link->parent = parent;
-		link->root = link->parent->root;
+		link->root = parent->root;
 	}
 
 	list_add(&link->sibling, &link_list);
@@ -962,7 +964,7 @@ void pcie_aspm_init_link_state(struct pci_dev *pdev)
 static void pcie_update_aspm_capable(struct pcie_link_state *root)
 {
 	struct pcie_link_state *link;
-	BUG_ON(root->parent);
+	BUG_ON(root->pdev->bus->parent->self);
 	list_for_each_entry(link, &link_list, sibling) {
 		if (link->root != root)
 			continue;
@@ -985,6 +987,7 @@ static void pcie_update_aspm_capable(struct pcie_link_state *root)
 /* @pdev: the endpoint device */
 void pcie_aspm_exit_link_state(struct pci_dev *pdev)
 {
+	struct pci_dev *parent_dev;
 	struct pci_dev *parent = pdev->bus->self;
 	struct pcie_link_state *link, *root, *parent_link;
 
@@ -1002,7 +1005,8 @@ void pcie_aspm_exit_link_state(struct pci_dev *pdev)
 
 	link = parent->link_state;
 	root = link->root;
-	parent_link = link->parent;
+	parent_dev = link->pdev->bus->parent->self;
+	parent_link = !parent_dev ? NULL : parent_dev->link_state;
 
 	/* All functions are removed, so just disable ASPM for the link */
 	pcie_config_aspm_link(link, 0);
-- 
2.20.1

