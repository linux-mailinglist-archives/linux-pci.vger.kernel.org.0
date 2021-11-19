Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4417E457724
	for <lists+linux-pci@lfdr.de>; Fri, 19 Nov 2021 20:39:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236068AbhKSTmh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Nov 2021 14:42:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236017AbhKSTmf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 Nov 2021 14:42:35 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69119C06173E;
        Fri, 19 Nov 2021 11:39:26 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id g14so46984214edb.8;
        Fri, 19 Nov 2021 11:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jMOymKcoA7+p43ADFlUIl6/jjGD/+QXRL1PpHntJR0c=;
        b=kTG74u1j1PtsIPYQ5Cc5YJZt0qQYeglkRX8FerBLsIzmVPe5YhOckBaSy2sui/ov8J
         xadTJ8XxRM7nnhpoetoSHskeNWm9EzpG4P96bitpckFnkzjPHo4V2qiY0nXr08nPdukT
         aasjSRp8y4VAlrIwNLFwSSyceBFYkSGS16e8WodM8fD6ZK8BfMQsikgiCRkQzkFFOnVY
         7PMyD72zxsnbpcoMFN2vxymEkXirZ0pQ4Rr3Vmhib2AD6oeHjti7wJfo15Of9P6ZPpOL
         JWI2P0JJ4qHT7vNu35WSbmKrF9lfUyeKq36upGOSiqYTsYH+2cFhFdR7zkAe6ymp8JEA
         vnOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jMOymKcoA7+p43ADFlUIl6/jjGD/+QXRL1PpHntJR0c=;
        b=CmUPO/7PCEXzdMbB0XVeGDBSM8TUqbd4u2ThvT3cw/iSLJeExb2gOjG4S5jh5K0x/B
         il8nwsieKf42yrYI5yiyuZ0wAtuf8HXBMxlHa/bS6mSFAcbKu0Q3y7tgL7HSaD/JA7+O
         SQZF3kLVMBhILQlPJzpHRemdNcS4VomGK12myLP+7/6m9XD5Ad6BdxH0P9WUu+E7b3ft
         XUOhoq5FwEiTyIf0m4qFhUr3HgOeZEfaiY3uJuK1VVjQb14f2IYjCHGEym49X5aPvaeA
         2C9oioyoRchzQ8L0jF1APk+sc98rTBxuYFWuqcolabSD8kv4OZcELwTbVGs6NmGoDIjH
         U8BQ==
X-Gm-Message-State: AOAM531MwuvxqzK6mHK2+VlbS4baMf0P9XmZAz1+oiRFI0XUsxySK9jU
        GljC0z7w/x7qDnHY8j6gnoE=
X-Google-Smtp-Source: ABdhPJytFq+B7WD659CbPgZTsdUyKzXm+//8iWdsbnp9oqTiBcH+D6X1wh6Bf/faryrJaAo+kwrzDw==
X-Received: by 2002:a17:907:7d8d:: with SMTP id oz13mr10772183ejc.361.1637350765028;
        Fri, 19 Nov 2021 11:39:25 -0800 (PST)
Received: from localhost.localdomain (catv-176-63-2-222.catv.broadband.hu. [176.63.2.222])
        by smtp.googlemail.com with ESMTPSA id sb19sm327521ejc.120.2021.11.19.11.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 11:39:24 -0800 (PST)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     helgaas@kernel.org
Cc:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, hch@lst.de
Subject: [RFC PATCH v5 4/4] PCI/ASPM: Remove struct aspm_latency
Date:   Fri, 19 Nov 2021 20:37:32 +0100
Message-Id: <20211119193732.12343-5-refactormyself@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211119193732.12343-1-refactormyself@gmail.com>
References: <20211119193732.12343-1-refactormyself@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The struct aspm_latency is now used only inside pcie_aspm_check_latency().

  - replace struct aspm_latency variables with u32 variables
  - remove struct aspm_latency

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Saheed O. Bolarinwa <refactormyself@gmail.com>
---
 drivers/pci/pcie/aspm.c | 32 +++++++++++++-------------------
 1 file changed, 13 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index a8821fe1ffe7..e29611080a90 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -41,11 +41,6 @@
 #define ASPM_STATE_ALL		(ASPM_STATE_L0S | ASPM_STATE_L1 |	\
 				 ASPM_STATE_L1SS)
 
-struct aspm_latency {
-	u32 l0s;			/* L0s latency (nsec) */
-	u32 l1;				/* L1 latency (nsec) */
-};
-
 struct pcie_link_state {
 	struct pci_dev *pdev;		/* Upstream component of the Link */
 	struct pci_dev *downstream;	/* Downstream component, function 0 */
@@ -384,9 +379,9 @@ static void encode_l12_threshold(u32 threshold_us, u32 *scale, u32 *value)
 static void pcie_aspm_check_latency(struct pci_dev *endpoint)
 {
 	u32 reg32, latency, encoding, lnkcap_up, lnkcap_dw;
-	u32 l1_switch_latency = 0;
-	struct aspm_latency latency_up, latency_dw;
-	struct aspm_latency *acceptable;
+	u32 l1_switch_latency = 0, latency_up_l0s;
+	u32 latency_up_l1, latency_dw_l0s, latency_dw_l1;
+	u32 acceptable_l0s, acceptable_l1;
 	struct pcie_link_state *link;
 
 	/* Device not in D0 doesn't need latency check */
@@ -398,10 +393,10 @@ static void pcie_aspm_check_latency(struct pci_dev *endpoint)
 	pcie_capability_read_dword(endpoint, PCI_EXP_DEVCAP, &reg32);
 	/* Calculate endpoint L0s acceptable latency */
 	encoding = (reg32 & PCI_EXP_DEVCAP_L0S) >> 6;
-	acceptable->l0s = calc_l0s_acceptable(encoding);
+	acceptable_l0s = calc_l0s_acceptable(encoding);
 	/* Calculate endpoint L1 acceptable latency */
 	encoding = (reg32 & PCI_EXP_DEVCAP_L1) >> 9;
-	acceptable->l1 = calc_l1_acceptable(encoding);
+	acceptable_l1 = calc_l1_acceptable(encoding);
 
 	while (link) {
 		struct pci_dev *dev = pci_function_0(
@@ -414,19 +409,19 @@ static void pcie_aspm_check_latency(struct pci_dev *endpoint)
 		pcie_capability_read_dword(dev,
 					   PCI_EXP_LNKCAP,
 					   &lnkcap_dw);
-		latency_up.l0s = calc_l0s_latency(lnkcap_up);
-		latency_up.l1 = calc_l1_latency(lnkcap_up);
-		latency_dw.l0s = calc_l0s_latency(lnkcap_dw);
-		latency_dw.l1 = calc_l1_latency(lnkcap_dw);
+		latency_up_l0s = calc_l0s_latency(lnkcap_up);
+		latency_up_l1 = calc_l1_latency(lnkcap_up);
+		latency_dw_l0s = calc_l0s_latency(lnkcap_dw);
+		latency_dw_l1 = calc_l1_latency(lnkcap_dw);
 
 		/* Check upstream direction L0s latency */
 		if ((link->aspm_capable & ASPM_STATE_L0S_UP) &&
-		    (latency_up.l0s > acceptable->l0s))
+		    (latency_up_l0s > acceptable_l0s))
 			link->aspm_capable &= ~ASPM_STATE_L0S_UP;
 
 		/* Check downstream direction L0s latency */
 		if ((link->aspm_capable & ASPM_STATE_L0S_DW) &&
-		    (latency_dw.l0s > acceptable->l0s))
+		    (latency_dw_l0s > acceptable_l0s))
 			link->aspm_capable &= ~ASPM_STATE_L0S_DW;
 		/*
 		 * Check L1 latency.
@@ -441,9 +436,9 @@ static void pcie_aspm_check_latency(struct pci_dev *endpoint)
 		 * L1 exit latencies advertised by a device include L1
 		 * substate latencies (and hence do not do any check).
 		 */
-		latency = max_t(u32, latency_up.l1, latency_dw.l1);
+		latency = max_t(u32, latency_up_l1, latency_dw_l1);
 		if ((link->aspm_capable & ASPM_STATE_L1) &&
-		    (latency + l1_switch_latency > acceptable->l1))
+		    (latency + l1_switch_latency > acceptable_l1))
 			link->aspm_capable &= ~ASPM_STATE_L1;
 		l1_switch_latency += 1000;
 
@@ -670,7 +665,6 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 
 	/* Get and check endpoint acceptable latencies */
 	list_for_each_entry(child, &linkbus->devices, bus_list) {
-
 		if (pci_pcie_type(child) != PCI_EXP_TYPE_ENDPOINT &&
 		    pci_pcie_type(child) != PCI_EXP_TYPE_LEG_END)
 			continue;
-- 
2.20.1

