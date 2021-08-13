Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AFD13EBE50
	for <lists+linux-pci@lfdr.de>; Sat, 14 Aug 2021 00:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235059AbhHMWgv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Aug 2021 18:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235213AbhHMWgu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Aug 2021 18:36:50 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6E1EC0617AD
        for <linux-pci@vger.kernel.org>; Fri, 13 Aug 2021 15:36:19 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id f10so4660338wml.2
        for <linux-pci@vger.kernel.org>; Fri, 13 Aug 2021 15:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gQKL19PiE8Rrzwimt6iLEhRsa+5YO25zGGI/eXyJAyk=;
        b=O45BtnKnjLDRdA18XwPoR8usvx2VmJEJodkyD4GAot1esvb4gzhJ4ls0Jazdkar6tH
         2V2eOHeSSwK3zFStjBMu4r+ePbz0mL0lssNP7rdVh1JRKxSE79P6R3gMOvsYRwWAUOW0
         JISA/vP/wd9Y1id2EQkQ17zlYeL1X66S8wdVGkY8dfn7bKFOgbtV2ua8r676N9FagLTI
         KRG8mFomNVj2xM0AOY4Vt8EfXV40VzZ46geAUhS9HrkT1dkSX6dan5s8AuH6Sx0kHyWU
         5Kz4B/IYNCX/heX5gR7AVry8QO/3z1wR/tOjgjvJIyT/47Q8ZPXlujFpxwdRsuRea7JY
         y7yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gQKL19PiE8Rrzwimt6iLEhRsa+5YO25zGGI/eXyJAyk=;
        b=CEJD1iuh8F5RY0B7fSE7P1d3RCm6ymVKk82mF+hGhZDsxD0pL8TJhN7KZyowaTbpw2
         sfzsyEVfwu7BnLgf5EWEu0G92l1Sn5aENEBaxI723JQ6q2prJadq3qHvCpLBZf5JdTXh
         0xzZMWWDrdCy34VudOvh8wvVw54vzy4lLl1RST9q4atLfrT0L39vfFBmHZUxwLiBGlQv
         B0lJLtsr9OTEW2ia0zuaRjmSrAroejOuhe7AXF2C0Z/UXsxcyMda1fbRjnFL981+tJzZ
         BGPoJALyieBui2Iaa1MRefOwWYgZwdsLsfjClKdl4tTCW3Ds+lOwYCiGlSbA53/Y0zNs
         dbWg==
X-Gm-Message-State: AOAM532BR5vSS4KAYJoqLEDbHms2hfN9OcTJ/J6cPguXH+PriePbo53I
        CIfmoE3v2vJVrF1NIJxwUOcqX2oVd5W/Lg==
X-Google-Smtp-Source: ABdhPJyaH+iYLuG7tvZ6Hmlp/Wk175qtkidjep4oXhPJffV7uFtqrvQU8tHig1RL+Lbj7gvGjsVURA==
X-Received: by 2002:a1c:7503:: with SMTP id o3mr4767527wmc.129.1628894177614;
        Fri, 13 Aug 2021 15:36:17 -0700 (PDT)
Received: from localhost.localdomain ([2a02:ab88:144:f570:b509:5224:f519:ca15])
        by smtp.googlemail.com with ESMTPSA id 6sm2621028wmk.20.2021.08.13.15.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 15:36:17 -0700 (PDT)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     linux-pci@vger.kernel.org
Cc:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>
Subject: [RFC PATCH 3/3] PCI/ASPM: Remove struct aspm_latency
Date:   Sat, 14 Aug 2021 00:36:09 +0200
Message-Id: <20210813223610.8687-4-refactormyself@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210813223610.8687-1-refactormyself@gmail.com>
References: <20210813223610.8687-1-refactormyself@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The struct aspm_latency is now used only inside pcie_aspm_check_latency()
Since this struct is trivial, it can be replaced with actual u32 variables
within the function.
This will not impact any functionality.

  - replace struct aspm_latency variables with u32 variables
  - Remove struct aspm_latency

Signed-off-by: Saheed O. Bolarinwa <refactormyself@gmail.com>
---
 drivers/pci/pcie/aspm.c | 30 ++++++++++++------------------
 1 file changed, 12 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index b713a2c8040f..7e5524b14127 100644
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
@@ -370,8 +365,8 @@ static void encode_l12_threshold(u32 threshold_us, u32 *scale, u32 *value)
 static void pcie_aspm_check_latency(struct pci_dev *endpoint)
 {
 	u32 reg32, latency, encoding, lnkcap_up, lnkcap_dw, l1_switch_latency = 0;
-	struct aspm_latency latency_up, latency_dw;
-	struct aspm_latency *acceptable;
+	u32 latency_up_l0s, latency_up_l1, latency_dw_l0s, latency_dw_l1;
+	u32 acceptable_l0s, acceptable_l1;
 	struct pcie_link_state *link;
 
 	/* Device not in D0 doesn't need latency check */
@@ -383,28 +378,28 @@ static void pcie_aspm_check_latency(struct pci_dev *endpoint)
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
 		/* Read direction exit latencies */
 		pcie_capability_read_dword(link->pdev, PCI_EXP_LNKCAP, &lnkcap_up);
 		pcie_capability_read_dword(link->downstream, PCI_EXP_LNKCAP, &lnkcap_dw);
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
@@ -419,9 +414,9 @@ static void pcie_aspm_check_latency(struct pci_dev *endpoint)
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
 
@@ -662,7 +657,6 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 
 	/* Get and check endpoint acceptable latencies */
 	list_for_each_entry(child, &linkbus->devices, bus_list) {
-
 		if (pci_pcie_type(child) != PCI_EXP_TYPE_ENDPOINT &&
 		    pci_pcie_type(child) != PCI_EXP_TYPE_LEG_END)
 			continue;
-- 
2.20.1

