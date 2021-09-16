Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31E8B40D504
	for <lists+linux-pci@lfdr.de>; Thu, 16 Sep 2021 10:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235373AbhIPIuz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Sep 2021 04:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235388AbhIPIuz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Sep 2021 04:50:55 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F097BC061574;
        Thu, 16 Sep 2021 01:49:34 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id q3so13975660edt.5;
        Thu, 16 Sep 2021 01:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RnSNDopoK7uzkv1l2SFpaqjIdHMpI/zWn43dXT0r6aQ=;
        b=XuVDccirWBzX5u3qll6e3uICln4x1nn+9tWbpk0R3yo9+Uwdb9lzlYLLr2cW1EMaJm
         g2iBpH25FcxDol2db3LHMNqNPbRl75LzSguzoaeQ03X56FTHG8lPH+Q2BGNpxgLqLKqz
         oilUu5MC1Bzasct0SHtbG/ufKxh87qE4ztEO7h5cF4mPD76bgB8xlz5lmdCzk2RU4ppe
         dVX7ty3uxm0CSo5p+2ROSq0B3DoDwq0Yk+b7aZe54qLWyv5D6r7Y1X68bgT4nx8tHxH2
         7kja2EchsSxhVc0SWcNSBeM+4X+USskLSnvf2qhso5/VQZyOcKTO2hxavPINn5gaJNHE
         CO5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RnSNDopoK7uzkv1l2SFpaqjIdHMpI/zWn43dXT0r6aQ=;
        b=D1pmA0u2bb87+tdACKZqLYq0uejy9DaBc7p/T9dtz1nYWzCeWbfzMRFdtV5hs2xLWl
         AFviFHZFYeZ4QmrhQYH9suERTNR+Lt0ejejXWXlKNQHcZlwIW7MPz5NJ3L4vCFcVsx4G
         ZMSbSvn82K+o433ED6A3Cz+Etq1HPneBPjGXGO8PAcnpW6B0/Qz7sL+jP7hrOwmBxMQj
         WKcLlgqH7b1XV1le/uHfqVLeDEDA5n9rBFnPwxmlhz5eSkw1d4qRMkLRsNZD6XmPf+q+
         +Wwokp++n4IJaXls5D4xrCo9xvNCIphPVTK6r2zIzz+PSYdP483gXgdiQbVGN0RjEU5V
         L9qw==
X-Gm-Message-State: AOAM532M+dYCOhpY0CaEOJetpLM8kNfM33qwho/nynI1PZbkpDGrmSyR
        IeIN3t1iVS/0L2OmKn528RQ=
X-Google-Smtp-Source: ABdhPJzmRbZZ8GIc6Eaea4I/H8qx3qX7CGhUJbMarWSz2ENbCxHg1ERF/bEheLjZy6l6xtNZCeuq4g==
X-Received: by 2002:a17:906:f289:: with SMTP id gu9mr4816673ejb.559.1631782173499;
        Thu, 16 Sep 2021 01:49:33 -0700 (PDT)
Received: from localhost.localdomain (catv-176-63-0-115.catv.broadband.hu. [176.63.0.115])
        by smtp.googlemail.com with ESMTPSA id dh16sm1085838edb.63.2021.09.16.01.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 01:49:33 -0700 (PDT)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     helgaas@kernel.org
Cc:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com
Subject: [RFC PATCH 1/3 v1] PCI/ASPM: Remove cached latencies in struct pcie_link_state
Date:   Thu, 16 Sep 2021 10:49:24 +0200
Message-Id: <20210916084926.32614-2-refactormyself@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210916084926.32614-1-refactormyself@gmail.com>
References: <20210916084926.32614-1-refactormyself@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The latencies of the upstream and downstream are calculated within
pcie_aspm_cap_init() and cached in struct pcie_link_state.latency_*
These values are only used in pcie_aspm_check_latency() where they are
compared with the acceptable latencies on the link.

This patch:
  - removes `latency_*` entries from struct pcie_link_state.
  - calculates the latencies directly where they are needed.
  - moves pci_function_0() upward, so that the downstream device can be
    obtained directly.
  - further removes dependencies on struct pcie_link_state.

Signed-off-by: Saheed O. Bolarinwa <refactormyself@gmail.com>
---
 drivers/pci/pcie/aspm.c | 54 ++++++++++++++++++++++-------------------
 1 file changed, 29 insertions(+), 25 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 013a47f587ce..9e85dfc56657 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -66,9 +66,6 @@ struct pcie_link_state {
 	u32 clkpm_default:1;		/* Default Clock PM state by BIOS */
 	u32 clkpm_disable:1;		/* Clock PM disabled */
 
-	/* Exit latencies */
-	struct aspm_latency latency_up;	/* Upstream direction exit latency */
-	struct aspm_latency latency_dw;	/* Downstream direction exit latency */
 	/*
 	 * Endpoint acceptable latencies. A pcie downstream port only
 	 * has one slot under it, so at most there are 8 functions.
@@ -376,9 +373,25 @@ static void encode_l12_threshold(u32 threshold_us, u32 *scale, u32 *value)
 	}
 }
 
+/*
+ * The L1 PM substate capability is only implemented in function 0 in a
+ * multi function device.
+ */
+static struct pci_dev *pci_function_0(struct pci_bus *linkbus)
+{
+	struct pci_dev *child;
+
+	list_for_each_entry(child, &linkbus->devices, bus_list)
+		if (PCI_FUNC(child->devfn) == 0)
+			return child;
+	return NULL;
+}
+
 static void pcie_aspm_check_latency(struct pci_dev *endpoint)
 {
-	u32 latency, l1_switch_latency = 0;
+	u32 latency, lnkcap_up, lnkcap_dw, l1_switch_latency = 0;
+	struct pci_dev *downstream;
+	struct aspm_latency latency_up, latency_dw;
 	struct aspm_latency *acceptable;
 	struct pcie_link_state *link;
 
@@ -388,17 +401,26 @@ static void pcie_aspm_check_latency(struct pci_dev *endpoint)
 		return;
 
 	link = endpoint->bus->self->link_state;
+	downstream = pci_function_0(link->pdev->subordinate);
 	acceptable = &link->acceptable[PCI_FUNC(endpoint->devfn)];
 
 	while (link) {
+		/* Read direction exit latencies */
+		pcie_capability_read_dword(link->pdev, PCI_EXP_LNKCAP, &lnkcap_up);
+		pcie_capability_read_dword(downstream, PCI_EXP_LNKCAP, &lnkcap_dw);
+		latency_up.l0s = calc_l0s_latency(lnkcap_up);
+		latency_up.l1 = calc_l1_latency(lnkcap_up);
+		latency_dw.l0s = calc_l0s_latency(lnkcap_dw);
+		latency_dw.l1 = calc_l1_latency(lnkcap_dw);
+
 		/* Check upstream direction L0s latency */
 		if ((link->aspm_capable & ASPM_STATE_L0S_UP) &&
-		    (link->latency_up.l0s > acceptable->l0s))
+		    (latency_up.l0s > acceptable->l0s))
 			link->aspm_capable &= ~ASPM_STATE_L0S_UP;
 
 		/* Check downstream direction L0s latency */
 		if ((link->aspm_capable & ASPM_STATE_L0S_DW) &&
-		    (link->latency_dw.l0s > acceptable->l0s))
+		    (latency_dw.l0s > acceptable->l0s))
 			link->aspm_capable &= ~ASPM_STATE_L0S_DW;
 		/*
 		 * Check L1 latency.
@@ -413,7 +435,7 @@ static void pcie_aspm_check_latency(struct pci_dev *endpoint)
 		 * L1 exit latencies advertised by a device include L1
 		 * substate latencies (and hence do not do any check).
 		 */
-		latency = max_t(u32, link->latency_up.l1, link->latency_dw.l1);
+		latency = max_t(u32, latency_up.l1, latency_dw.l1);
 		if ((link->aspm_capable & ASPM_STATE_L1) &&
 		    (latency + l1_switch_latency > acceptable->l1))
 			link->aspm_capable &= ~ASPM_STATE_L1;
@@ -423,20 +445,6 @@ static void pcie_aspm_check_latency(struct pci_dev *endpoint)
 	}
 }
 
-/*
- * The L1 PM substate capability is only implemented in function 0 in a
- * multi function device.
- */
-static struct pci_dev *pci_function_0(struct pci_bus *linkbus)
-{
-	struct pci_dev *child;
-
-	list_for_each_entry(child, &linkbus->devices, bus_list)
-		if (PCI_FUNC(child->devfn) == 0)
-			return child;
-	return NULL;
-}
-
 static void pci_clear_and_set_dword(struct pci_dev *pdev, int pos,
 				    u32 clear, u32 set)
 {
@@ -593,8 +601,6 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 		link->aspm_enabled |= ASPM_STATE_L0S_UP;
 	if (parent_lnkctl & PCI_EXP_LNKCTL_ASPM_L0S)
 		link->aspm_enabled |= ASPM_STATE_L0S_DW;
-	link->latency_up.l0s = calc_l0s_latency(parent_lnkcap);
-	link->latency_dw.l0s = calc_l0s_latency(child_lnkcap);
 
 	/* Setup L1 state */
 	if (parent_lnkcap & child_lnkcap & PCI_EXP_LNKCAP_ASPM_L1)
@@ -602,8 +608,6 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 
 	if (parent_lnkctl & child_lnkctl & PCI_EXP_LNKCTL_ASPM_L1)
 		link->aspm_enabled |= ASPM_STATE_L1;
-	link->latency_up.l1 = calc_l1_latency(parent_lnkcap);
-	link->latency_dw.l1 = calc_l1_latency(child_lnkcap);
 
 	/* Setup L1 substate */
 	pci_read_config_dword(parent, parent->l1ss + PCI_L1SS_CAP,
-- 
2.20.1

