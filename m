Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF7A8446F7D
	for <lists+linux-pci@lfdr.de>; Sat,  6 Nov 2021 18:53:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234728AbhKFR4A (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 6 Nov 2021 13:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234722AbhKFRz7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 6 Nov 2021 13:55:59 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85790C061570;
        Sat,  6 Nov 2021 10:53:17 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id m14so44018813edd.0;
        Sat, 06 Nov 2021 10:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+vbyct0ysNWFRh8lOEYGpZrf0n1PUQPKvtjJYv0U1Fg=;
        b=nop9XaODHozccoOylhdhI8CPJjPKM17ieNUWJrCtPumlVrHLbPl5sLg7lsMWd9IMJn
         ZwdePy1h1FDTqlt8HUo/ZQzK4tTjj2BfJHdIz9cgPTGecum6C1tA0yIv3qBlVNplilEW
         lXchoC8ZKChc+/e4Hw5nYd1TdJgHhRDFskQxKJrnE1Ebg66XcYgMGTNlskDRjvvP2kZg
         ROdHVD1n8K8F7gtd+7R2kNXFJFHk44W/RA2vZUggB1Wi1tpJWD5cXOv+bwWy8BZbef/1
         XJj7NMrqJChP89WOSTW/KAR3qz6X+zxCPM/Y8WyLmwmhiFHLBTImeukCgtGadgXnz6vx
         k3SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+vbyct0ysNWFRh8lOEYGpZrf0n1PUQPKvtjJYv0U1Fg=;
        b=hoxjAjZQqqIkKNIc91glro9D7fpgw0zyZJeLw5r35YcNhGvSt2vh/yhGUR69Hc6hfe
         vGf3IcL7oNiX838sSK67mtdVW5eEC9MHu7ZgTOQ3ZxPYGvjCCnIVN5mqDSslO0/60kSH
         v3z28dvRAXeCpRr41/SkcQgJ9Nx8jpUemenzGqSxKCyTjprrLigdp62/gtXCS57gg8k8
         3jPdGtChFuOfE50i6TBRMJL3qgZYgOplVW7e0hWAmYqioa0UYzpEiqUfVhW8FsJYTzOJ
         8hCaGF8Aa8rqfM9LeId7jJBbHqrwkhU/LDY2lcM6AyJZC+HjI2BDwh5K3wJMrz0+QT8m
         FUnA==
X-Gm-Message-State: AOAM530+hAjzQzOo7St1e/8Yh+Z3oBLe4AXgV19EoO5/iuGPoGMCXt4h
        MD+7RZHiDVBZHfZQODpI/0U=
X-Google-Smtp-Source: ABdhPJy40KmcRNVX01xMskLSiiWn2/IuuETjl2zBfZfQPI/LjM5hA1eMKF40N/I4XaTLe5lK6DCApw==
X-Received: by 2002:a17:906:6a0f:: with SMTP id qw15mr40649279ejc.463.1636221195944;
        Sat, 06 Nov 2021 10:53:15 -0700 (PDT)
Received: from localhost.localdomain ([2a02:ab88:109:9f0:f6a6:7fbe:807a:e1cc])
        by smtp.googlemail.com with ESMTPSA id g10sm6364857edr.56.2021.11.06.10.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Nov 2021 10:53:15 -0700 (PDT)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     helgaas@kernel.org
Cc:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v4 4/4] PCI/ASPM: Remove struct aspm_latency
Date:   Sat,  6 Nov 2021 18:53:05 +0100
Message-Id: <20211106175305.25565-5-refactormyself@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211106175305.25565-1-refactormyself@gmail.com>
References: <20211106175305.25565-1-refactormyself@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The struct aspm_latency is now used only inside pcie_aspm_check_latency().

  - replace struct aspm_latency variables with u32 variables
  - remove struct aspm_latency

Signed-off-by: Saheed O. Bolarinwa <refactormyself@gmail.com>
---
 drivers/pci/pcie/aspm.c | 30 ++++++++++++------------------
 1 file changed, 12 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 6afbb86d07b8..19459cb0af34 100644
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
@@ -384,8 +379,8 @@ static void encode_l12_threshold(u32 threshold_us, u32 *scale, u32 *value)
 static void pcie_aspm_check_latency(struct pci_dev *endpoint)
 {
 	u32 reg32, latency, encoding, lnkcap_up, lnkcap_dw, l1_switch_latency = 0;
-	struct aspm_latency latency_up, latency_dw;
-	struct aspm_latency *acceptable;
+	u32 latency_up_l0s, latency_up_l1, latency_dw_l0s, latency_dw_l1;
+	u32 acceptable_l0s, acceptable_l1;
 	struct pcie_link_state *link;
 
 	/* Device not in D0 doesn't need latency check */
@@ -397,29 +392,29 @@ static void pcie_aspm_check_latency(struct pci_dev *endpoint)
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
 		pcie_capability_read_dword(pci_function_0(link->pdev->subordinate),
 					   PCI_EXP_LNKCAP, &lnkcap_dw);
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
@@ -434,9 +429,9 @@ static void pcie_aspm_check_latency(struct pci_dev *endpoint)
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
 
@@ -663,7 +658,6 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 
 	/* Get and check endpoint acceptable latencies */
 	list_for_each_entry(child, &linkbus->devices, bus_list) {
-
 		if (pci_pcie_type(child) != PCI_EXP_TYPE_ENDPOINT &&
 		    pci_pcie_type(child) != PCI_EXP_TYPE_LEG_END)
 			continue;
-- 
2.20.1

