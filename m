Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4371B41BBDB
	for <lists+linux-pci@lfdr.de>; Wed, 29 Sep 2021 02:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243474AbhI2Apt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Sep 2021 20:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243507AbhI2Apr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Sep 2021 20:45:47 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD6A4C061745;
        Tue, 28 Sep 2021 17:44:06 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id bd28so1894083edb.9;
        Tue, 28 Sep 2021 17:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l2b36K0VOEbskUSIYtzJAJSfMxT71VREguqbCSTPpWU=;
        b=KMfsKV9f+1N9bMaDc82Uc+u0pvOBjnmkVVkF6+KIujtFNDEowLMAgIJghV7+twAJxJ
         gkPokOGez6K09iirfblMhnu9qfdiEpEL2qdWDz0PWPsoA1EKNJGpMePf0MV3UMPaOFvz
         cBWhJKEBi4CcG4GraxAIN/KA6ZLh9jJTONYCrHLwsHEI7yTAZG1gQZD+I22HQCVd/uVt
         if2JQvxjPKYnbCxglwgaABxq/tfMeh+J5pGdIwRW0RYFyktw/EolDRrpSFT2w2DGvuoN
         OxDeUA9KXh362WWzkeKnRvoNYSncU5VT+W9K6FEePDLOyd26dRdMhzRasylrc/0RPasr
         YYqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l2b36K0VOEbskUSIYtzJAJSfMxT71VREguqbCSTPpWU=;
        b=o0dzRkpg9plHb8FjyR/MT2ilQsfGBdHUkqBvd8GmznrEk6PdeBHv6UZccYeIfXmhSD
         mjsd6wu+i4jWaAM/KsAlhZFkQ9qfq1Y3KVVyv1matptXQJZfPf5QRadlNZDWcmzLaZlO
         tzKD3F+AIK2ifwpqigUg9I1TlQ2F2tLtWG30c8gGuJRV0ngBx0PZttUPRQV53/UQRy8p
         2iqqLMDdxdzgrWUyR8WXHxGntEL7doZq78+/9AMnGMYnel5JYsECo58hpKx40M8EG3SB
         A8sOKk/NV+h2xhxhU4gwHljbLbNkrpggJb0BN8DYaSybjJf/eZ05qzYtns/7ZK+n5I+E
         pvNg==
X-Gm-Message-State: AOAM531FTwfmn2HZtqD7zWFLhOAN3yn9FXhu8HnAptk4YOtDzGTfRSxQ
        SvEauTY+155MSGkB7J4ETQoR4Cy5yII=
X-Google-Smtp-Source: ABdhPJze8Fy7nKeq1XIX17NpgsoMlr9uJqX8w6Li1nKuDI6BNn4oMqIZz3SCUmH2h3ukYTrZLoF5Lg==
X-Received: by 2002:a50:d90b:: with SMTP id t11mr11789788edj.32.1632876245475;
        Tue, 28 Sep 2021 17:44:05 -0700 (PDT)
Received: from localhost.localdomain ([2a02:ab88:10f:c9f0:35c7:3af0:a197:61d0])
        by smtp.googlemail.com with ESMTPSA id r19sm383578edt.54.2021.09.28.17.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 17:44:05 -0700 (PDT)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     helgaas@kernel.org
Cc:     "Bolarinwa O. Saheed" <refactormyself@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 1/4] [PCI/ASPM:] Remove struct pcie_link_state.clkpm_default
Date:   Wed, 29 Sep 2021 02:43:57 +0200
Message-Id: <20210929004400.25717-2-refactormyself@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210929004400.25717-1-refactormyself@gmail.com>
References: <20210929004400.25717-1-refactormyself@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: "Bolarinwa O. Saheed" <refactormyself@gmail.com>

The clkpm_default member of the struct pcie_link_state stores the
value of the default clkpm state as it is in the BIOS.

This patch:
- Removes clkpm_default from struct pcie_link_state
- Creates pcie_get_clkpm_state() which return the clkpm state
  obtained the BIOS
- Replaces references to clkpm_default with call to
  pcie_get_clkpm_state()

Signed-off-by: Bolarinwa O. Saheed <refactormyself@gmail.com>
---
 drivers/pci/pcie/aspm.c | 37 +++++++++++++++++++++++++++----------
 1 file changed, 27 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 013a47f587ce..c23da9a4e2fb 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -63,7 +63,6 @@ struct pcie_link_state {
 	/* Clock PM state */
 	u32 clkpm_capable:1;		/* Clock PM capable? */
 	u32 clkpm_enabled:1;		/* Current Clock PM state */
-	u32 clkpm_default:1;		/* Default Clock PM state by BIOS */
 	u32 clkpm_disable:1;		/* Clock PM disabled */
 
 	/* Exit latencies */
@@ -123,6 +122,30 @@ static int policy_to_aspm_state(struct pcie_link_state *link)
 	return 0;
 }
 
+static int pcie_get_clkpm_state(struct pci_dev *pdev)
+{
+	int enabled = 1;
+	u32 reg32;
+	u16 reg16;
+	struct pci_dev *child;
+	struct pci_bus *linkbus = pdev->subordinate;
+
+	/* All functions should have the same clkpm state, take the worst */
+	list_for_each_entry(child, &linkbus->devices, bus_list) {
+		pcie_capability_read_dword(child, PCI_EXP_LNKCAP, &reg32);
+		if (!(reg32 & PCI_EXP_LNKCAP_CLKPM)) {
+			enabled = 0;
+			break;
+		}
+
+		pcie_capability_read_word(child, PCI_EXP_LNKCTL, &reg16);
+		if (!(reg16 & PCI_EXP_LNKCTL_CLKREQ_EN))
+			enabled = 0;
+	}
+
+	return enabled;
+}
+
 static int policy_to_clkpm_state(struct pcie_link_state *link)
 {
 	switch (aspm_policy) {
@@ -134,7 +157,7 @@ static int policy_to_clkpm_state(struct pcie_link_state *link)
 		/* Enable Clock PM */
 		return 1;
 	case POLICY_DEFAULT:
-		return link->clkpm_default;
+		return pcie_get_clkpm_state(link->pdev);
 	}
 	return 0;
 }
@@ -168,9 +191,8 @@ static void pcie_set_clkpm(struct pcie_link_state *link, int enable)
 
 static void pcie_clkpm_cap_init(struct pcie_link_state *link, int blacklist)
 {
-	int capable = 1, enabled = 1;
+	int capable = 1;
 	u32 reg32;
-	u16 reg16;
 	struct pci_dev *child;
 	struct pci_bus *linkbus = link->pdev->subordinate;
 
@@ -179,15 +201,10 @@ static void pcie_clkpm_cap_init(struct pcie_link_state *link, int blacklist)
 		pcie_capability_read_dword(child, PCI_EXP_LNKCAP, &reg32);
 		if (!(reg32 & PCI_EXP_LNKCAP_CLKPM)) {
 			capable = 0;
-			enabled = 0;
 			break;
 		}
-		pcie_capability_read_word(child, PCI_EXP_LNKCTL, &reg16);
-		if (!(reg16 & PCI_EXP_LNKCTL_CLKREQ_EN))
-			enabled = 0;
 	}
-	link->clkpm_enabled = enabled;
-	link->clkpm_default = enabled;
+	link->clkpm_enabled = pcie_get_clkpm_state(link->pdev);
 	link->clkpm_capable = capable;
 	link->clkpm_disable = blacklist ? 1 : 0;
 }
-- 
2.20.1

