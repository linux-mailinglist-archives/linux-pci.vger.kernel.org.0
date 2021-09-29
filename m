Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B927141BBCA
	for <lists+linux-pci@lfdr.de>; Wed, 29 Sep 2021 02:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242626AbhI2AnF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Sep 2021 20:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243446AbhI2AnE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Sep 2021 20:43:04 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37682C06161C;
        Tue, 28 Sep 2021 17:41:24 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id v10so1857874edj.10;
        Tue, 28 Sep 2021 17:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u8/OQHyTfBKc9k6MqctWLYPYytJ0Iv55vUhhrisQJfM=;
        b=FrP+ioCcZEEzsbMeYmqzBcjfJME8t6Sy58v9aLRWQ8XOhHcKVxVqaIl7CiSStFGfPy
         hK7reVMDpkRbBFAXIDxOuN7qaVg0AzuY7rZn+sugw2la/WXkrUsxf1y/AsZtB69bkAf1
         4eYJs5yffe70MC0TWj6t1cGeHz1SDteIUu1j/aLIkuW9Y4CYyAGHGNYGBY2sB5VI2HHN
         c1ofSdWtkFtnn+7ZSxk8DdF1TA0BFRYCE+FGwkUFgX9waIXT6wnP8GkiFZFq81CQ7bFY
         DK2Qqo3k3il5jC8KnOa684Gub6eWwFee1IFVKoLs+tTAagv98W1V6K8W3ICSEsBWBWiR
         HAGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u8/OQHyTfBKc9k6MqctWLYPYytJ0Iv55vUhhrisQJfM=;
        b=WrS7JwcqIHfCrd4yIL/bsNzBxProcD1oWIux11nkp+UIuEzony+goGgubxV9qVXpcc
         yf50B32f3ZsLXEg4O1Sbl8WzuzgGWpD+Q+zF5gLdh5+Ol72tiQpbdN8q0YzOIUjkpRC9
         YlN7l7KLXdTePb54soNce80mR61+buMFx3TtqXaGFLCWjrZAHbs6uM4yQx0rNcGviReu
         6rI0dZrEsGzVjaG08s0YFXmz0L03YHuzISCDY1gVF2OVTMnzamwNFvAgHpdDYsW74mrW
         37yZPaRKbNs+tOV19BOdjfKOITvVlvlzw6YRS94znkl2pgGut+aecA8ue8RInAuRfj/p
         +djg==
X-Gm-Message-State: AOAM5319KMW8p2+WKELf/i/VMXIzg6On4gJWJMJayOZ0AS31mKaDVMWT
        V7/+cvVR6lxuzIn3Xh2IRGo=
X-Google-Smtp-Source: ABdhPJySrbPE7KqvfC1MwWLuySFf5L4BICAdL37D4dMjCDIEfEmBT7CNHdWzkIggDbitm01HuUBAUA==
X-Received: by 2002:a17:907:7675:: with SMTP id kk21mr8844245ejc.114.1632876082829;
        Tue, 28 Sep 2021 17:41:22 -0700 (PDT)
Received: from localhost.localdomain ([2a02:ab88:10f:c9f0:35c7:3af0:a197:61d0])
        by smtp.googlemail.com with ESMTPSA id y1sm372727edv.79.2021.09.28.17.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 17:41:22 -0700 (PDT)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     helgaas@kernel.org
Cc:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v3 1/3] PCI/ASPM: Do not cache link latencies
Date:   Wed, 29 Sep 2021 02:41:14 +0200
Message-Id: <20210929004116.20650-2-refactormyself@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210929004116.20650-1-refactormyself@gmail.com>
References: <20210929004116.20650-1-refactormyself@gmail.com>
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
  obtained by calling it directly.
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

