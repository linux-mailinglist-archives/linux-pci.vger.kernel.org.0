Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C225E41BBCE
	for <lists+linux-pci@lfdr.de>; Wed, 29 Sep 2021 02:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243490AbhI2AnK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Sep 2021 20:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243483AbhI2AnH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Sep 2021 20:43:07 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B540DC061749;
        Tue, 28 Sep 2021 17:41:26 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id s17so1889856edd.8;
        Tue, 28 Sep 2021 17:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XuDX1fjPxUMaCX2fPXgHk2QJqjD/rlL/TYuS7K5aiyY=;
        b=pW4Twil7mHU8/OsScaGIbf9FWpgLKQgPOxLKFH5t0z3atxj72qO488OY8sebRVrElx
         sehpyEyLmRNrBAZ5O+T4cyTXjnpGC1wTMJ9NPMZe/OuifGom56I0CKzoOR2wTPf6RcvK
         9GVzSAVPJA1PDzHi+27GmnoKMA+neDvwPunbnT0gur9/uSLQci01QvZQgAdKRfNbyW2L
         3KL2Omn3INz6Q2+oJb8rZJwycX7MDAxNFudX3XMXNvCrlZN+9Of+MaUP/xjhnC7YDsXS
         wdf5jEXdHSm/hz0zK8oDPbQ2k5UoKQBb1ZfFQKWyza8itC57JO+x0ERCjDY9plBfEKrR
         GSZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XuDX1fjPxUMaCX2fPXgHk2QJqjD/rlL/TYuS7K5aiyY=;
        b=ZTXD5J5bJ0mjlH2WV5EFTbOy8ROWNKsSOYy7KlTXqdENrGBSxmpJMgRE9ZY2ELcT4j
         BTDAEFbFd4LdOrijE3hfbWEBgx77feTRWkhhPm6NHBXGOh+li7Gebp4AOlS1X5iNSiaL
         UvEvdEdlDbpixMUQ64xZ0DfyUsyTm9YZkvskJXcj8sAFbDBrDQlooV9kzoK8TiAnUTdp
         3mjZ2y0AlC8wTFGEUdvyepsqwADHRMJtFrIeqEtqTf7iRJanDVtp2ZbuuDAXWBTvd3De
         3vRr1s0Cp06RPjEa9XU6b4oZ1ZHXXLbgP28sxCeJF9NJvaxaSWCYuj8N+9JRycfnurrJ
         5FYA==
X-Gm-Message-State: AOAM531S6WzBxnTuGqSPEcUYrY2M1ayFahQLATxl9M5oxu5u98ca283s
        lzwyM/d3yWak5yxxyI1lbzI=
X-Google-Smtp-Source: ABdhPJzOvL7/8vtL8wqWHEyHwhsV86lAPaxatggaIgdcEOUmTrSl5m5KtuUbZSjCBfFjxj/86pnNbA==
X-Received: by 2002:a17:906:ff51:: with SMTP id zo17mr10532703ejb.193.1632876084702;
        Tue, 28 Sep 2021 17:41:24 -0700 (PDT)
Received: from localhost.localdomain ([2a02:ab88:10f:c9f0:35c7:3af0:a197:61d0])
        by smtp.googlemail.com with ESMTPSA id y1sm372727edv.79.2021.09.28.17.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 17:41:24 -0700 (PDT)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     helgaas@kernel.org
Cc:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC v3 PATCH 3/3] PCI/ASPM: Remove struct aspm_latency
Date:   Wed, 29 Sep 2021 02:41:16 +0200
Message-Id: <20210929004116.20650-4-refactormyself@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210929004116.20650-1-refactormyself@gmail.com>
References: <20210929004116.20650-1-refactormyself@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The struct aspm_latency is now used only inside pcie_aspm_check_latency().

Since this struct is trivial, this patch:
  - replaces struct aspm_latency variables with u32 variables
  - removes struct aspm_latency

Signed-off-by: Saheed O. Bolarinwa <refactormyself@gmail.com>
---
 drivers/pci/pcie/aspm.c | 30 ++++++++++++------------------
 1 file changed, 12 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 0c0c055823f1..8093c9335e1f 100644
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
@@ -384,9 +379,9 @@ static struct pci_dev *pci_function_0(struct pci_bus *linkbus)
 static void pcie_aspm_check_latency(struct pci_dev *endpoint)
 {
 	u32 reg32, latency, encoding, lnkcap_up, lnkcap_dw, l1_switch_latency = 0;
+	u32 latency_up_l0s, latency_up_l1, latency_dw_l0s, latency_dw_l1;
+	u32 acceptable_l0s, acceptable_l1;
 	struct pci_dev *downstream;
-	struct aspm_latency latency_up, latency_dw;
-	struct aspm_latency *acceptable;
 	struct pcie_link_state *link;
 
 	/* Device not in D0 doesn't need latency check */
@@ -399,28 +394,28 @@ static void pcie_aspm_check_latency(struct pci_dev *endpoint)
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
 		pcie_capability_read_dword(downstream, PCI_EXP_LNKCAP, &lnkcap_dw);
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
@@ -435,9 +430,9 @@ static void pcie_aspm_check_latency(struct pci_dev *endpoint)
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
 
@@ -664,7 +659,6 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 
 	/* Get and check endpoint acceptable latencies */
 	list_for_each_entry(child, &linkbus->devices, bus_list) {
-
 		if (pci_pcie_type(child) != PCI_EXP_TYPE_ENDPOINT &&
 		    pci_pcie_type(child) != PCI_EXP_TYPE_LEG_END)
 			continue;
-- 
2.20.1

