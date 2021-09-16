Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 624AB40D508
	for <lists+linux-pci@lfdr.de>; Thu, 16 Sep 2021 10:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235515AbhIPIvC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Sep 2021 04:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235422AbhIPIu5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Sep 2021 04:50:57 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABDD1C061574;
        Thu, 16 Sep 2021 01:49:36 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id g8so13982409edt.7;
        Thu, 16 Sep 2021 01:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XuDX1fjPxUMaCX2fPXgHk2QJqjD/rlL/TYuS7K5aiyY=;
        b=ENGNJ7iM2mVnJbSHbjNOPxiXlAqVVy58G2EVm/qn62VnOqO4OT848ONjrQ1DqvoD2J
         W6RHCicH1fDtPziIzS+pbpLkQgyF86EI8mVCYzjY3BVUgXfPh6p+WVwPxTGzvwG0bjXH
         cSEVkqvBaK49CIqy7KdK5l80ANxqMrYNdIgWlZ55duP4xIU9DfgihCdt8kr01Zzk9TXb
         m4vgQpA514Sm5MKaf79GL4t4E4d5Ljl650Ua5tVVI/AMurLrM+o+7pRKdfoVP31yttqQ
         /I0GEdVSz9QOCT/Qr3CVjPczJxDOKete4fOl5pZSNDdR1aWtQ1sO+3eG9jPmQv/1I1iC
         TYwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XuDX1fjPxUMaCX2fPXgHk2QJqjD/rlL/TYuS7K5aiyY=;
        b=YpSZPa3Cv7p5GSaSYrK01NDyyqggw6Px4TBcPdGifA/tnGu9D0pweBp4zKPYPIj15G
         eACsxcWoaoW+1DLJAQbG8WBiqSmMqqmaLCKJI/wWjDpPPZhrlIMrOTKA1NBHZMlkpd/9
         sDZaeF4gZJanzTKcNvd9zEQ88C4NxNILcUED3sojgDwYnPhJw5qwBbYZEWDON50RE//B
         Wat2U7Fm1RDY3CQSE+Gmq9iDUls6nv3VM9B8d3FCaourcXAU3tdgfFWvoVUJ6RF9K22q
         HoxumtzSfrQO3zX7H04CX4H5qlQ0DVRU8L+BgrKwHKMGM++XvNX+1Af38AyaKyLS2V2w
         Idew==
X-Gm-Message-State: AOAM533uzmuTJmKLObhApa8bWCy95dgRSRzMKu3wE2F7Wd5UoCpb+tNh
        3AD01VpQ9eoiAq893X5l/Z0=
X-Google-Smtp-Source: ABdhPJzz5QC0FAKpPRkviSN6gUEtFGbdX3sYWib9yHvzw8h0mreMP6bQ5DnpT9prf9nwxqXVqOWUHw==
X-Received: by 2002:a05:6402:510b:: with SMTP id m11mr5380060edd.82.1631782175327;
        Thu, 16 Sep 2021 01:49:35 -0700 (PDT)
Received: from localhost.localdomain (catv-176-63-0-115.catv.broadband.hu. [176.63.0.115])
        by smtp.googlemail.com with ESMTPSA id dh16sm1085838edb.63.2021.09.16.01.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 01:49:34 -0700 (PDT)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     helgaas@kernel.org
Cc:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com
Subject: [RFC PATCH 3/3 v1] PCI/ASPM: Remove struct aspm_latency
Date:   Thu, 16 Sep 2021 10:49:26 +0200
Message-Id: <20210916084926.32614-4-refactormyself@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210916084926.32614-1-refactormyself@gmail.com>
References: <20210916084926.32614-1-refactormyself@gmail.com>
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

