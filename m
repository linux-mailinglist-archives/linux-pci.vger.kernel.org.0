Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF2840D505
	for <lists+linux-pci@lfdr.de>; Thu, 16 Sep 2021 10:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235391AbhIPIu5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Sep 2021 04:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235394AbhIPIu4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Sep 2021 04:50:56 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE4CCC061574;
        Thu, 16 Sep 2021 01:49:35 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id g8so13982266edt.7;
        Thu, 16 Sep 2021 01:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PwaW7JRfkg2Q5KKUNVzg/WW9DNNysT3PVbxSJWsPSXg=;
        b=UatcTCrS5N7oQ2y78QP3HdyTNmmTz15jSyAC2IMZ9hkwrwIiC4lgukQismBMfocrl7
         yxXqVzw/1sIT3sbt335ZT4SUT1fYNT2dwrSFYhkoyNreRkFNwsMPAwfHunTIQu9lHaaz
         1Jnim7nkY3TGQAuShwzQ1IXs1Gp8oDPqfHPNwOvVr5bmjM4r8zmvERpU/f/AWrDZd+hS
         1kKx3CZZbmMjkvzbJDA6h3KBq5eimp588mGPsux2gccEJQpvZxd54diaILGKmZZF/QzW
         BCC98dbnIMWB626CIA8ZAWJjtHWTJZWzEjNCxYL8pM10HvD8/PNYWfIQXe27si7fznP1
         xHzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PwaW7JRfkg2Q5KKUNVzg/WW9DNNysT3PVbxSJWsPSXg=;
        b=pZJG1j/7plv4KCme1sngeJ8QSzmTtECMSqDzdFveZbaAP6OMBp5C/M6S2GU6FMFYf5
         wKE31RB5FpRR6InOymZE14pKaF6L+MKq+OSB1XvNLFEjW78nw6BMV9FFe2VP5/S8baq7
         SqyCmlaqkcBQDSUujShYXu4eqiTKCjz5fmgc6xnrqSPQGbfglULzvQBaG50nfnDPbYKC
         D+XhzORZljz8k87ydUefNOLjlPs5IcWjEpq72LbHYFJwuTnoBTZ+F3VSwui+GKBnq3Rl
         TSTXc6HO4vRe9D/d6OM/IO1Z+GpafPwgcd7J37y2JvJeb/pswtHqywMl07qlJf1XVxEk
         XuYA==
X-Gm-Message-State: AOAM533SLkNTNBa2YScq88cIqR5Gadiy2FA1AJwqoIuApP8cFmuHQxz0
        I6+90K1iHhzPPtDQuPpvJqCvE42+CTw=
X-Google-Smtp-Source: ABdhPJw0/V1UJd/o+YFUm4pAAphEB+/pIqt9VfxkC0tuTsS8zLODNECTdi16yGwvOzP1YID702tryA==
X-Received: by 2002:a17:906:f74f:: with SMTP id jp15mr5118428ejb.423.1631782174458;
        Thu, 16 Sep 2021 01:49:34 -0700 (PDT)
Received: from localhost.localdomain (catv-176-63-0-115.catv.broadband.hu. [176.63.0.115])
        by smtp.googlemail.com with ESMTPSA id dh16sm1085838edb.63.2021.09.16.01.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 01:49:34 -0700 (PDT)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     helgaas@kernel.org
Cc:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com
Subject: [RFC PATCH 2/3 v2] PCI/ASPM: Remove struct pcie_link_state.acceptable
Date:   Thu, 16 Sep 2021 10:49:25 +0200
Message-Id: <20210916084926.32614-3-refactormyself@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210916084926.32614-1-refactormyself@gmail.com>
References: <20210916084926.32614-1-refactormyself@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The acceptable latencies for each device on the bus are calculated within
pcie_aspm_cap_init() and cached in struct pcie_link_state.acceptable. They
are only used in pcie_aspm_check_latency() to validate actual latencies.
Thus, it is possible to avoid caching these values.

This patch:
  - removes `acceptable` from struct pcie_link_state
  - calculates the acceptable latency for each device directly
  - removes the calculations done within pcie_aspm_cap_init()

Signed-off-by: Saheed O. Bolarinwa <refactormyself@gmail.com>
---
 drivers/pci/pcie/aspm.c | 27 ++++++++-------------------
 1 file changed, 8 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 9e85dfc56657..0c0c055823f1 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -65,12 +65,6 @@ struct pcie_link_state {
 	u32 clkpm_enabled:1;		/* Current Clock PM state */
 	u32 clkpm_default:1;		/* Default Clock PM state by BIOS */
 	u32 clkpm_disable:1;		/* Clock PM disabled */
-
-	/*
-	 * Endpoint acceptable latencies. A pcie downstream port only
-	 * has one slot under it, so at most there are 8 functions.
-	 */
-	struct aspm_latency acceptable[8];
 };
 
 static int aspm_disabled, aspm_force;
@@ -389,7 +383,7 @@ static struct pci_dev *pci_function_0(struct pci_bus *linkbus)
 
 static void pcie_aspm_check_latency(struct pci_dev *endpoint)
 {
-	u32 latency, lnkcap_up, lnkcap_dw, l1_switch_latency = 0;
+	u32 reg32, latency, encoding, lnkcap_up, lnkcap_dw, l1_switch_latency = 0;
 	struct pci_dev *downstream;
 	struct aspm_latency latency_up, latency_dw;
 	struct aspm_latency *acceptable;
@@ -402,7 +396,13 @@ static void pcie_aspm_check_latency(struct pci_dev *endpoint)
 
 	link = endpoint->bus->self->link_state;
 	downstream = pci_function_0(link->pdev->subordinate);
-	acceptable = &link->acceptable[PCI_FUNC(endpoint->devfn)];
+	pcie_capability_read_dword(endpoint, PCI_EXP_DEVCAP, &reg32);
+	/* Calculate endpoint L0s acceptable latency */
+	encoding = (reg32 & PCI_EXP_DEVCAP_L0S) >> 6;
+	acceptable->l0s = calc_l0s_acceptable(encoding);
+	/* Calculate endpoint L1 acceptable latency */
+	encoding = (reg32 & PCI_EXP_DEVCAP_L1) >> 9;
+	acceptable->l1 = calc_l1_acceptable(encoding);
 
 	while (link) {
 		/* Read direction exit latencies */
@@ -664,22 +664,11 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 
 	/* Get and check endpoint acceptable latencies */
 	list_for_each_entry(child, &linkbus->devices, bus_list) {
-		u32 reg32, encoding;
-		struct aspm_latency *acceptable =
-			&link->acceptable[PCI_FUNC(child->devfn)];
 
 		if (pci_pcie_type(child) != PCI_EXP_TYPE_ENDPOINT &&
 		    pci_pcie_type(child) != PCI_EXP_TYPE_LEG_END)
 			continue;
 
-		pcie_capability_read_dword(child, PCI_EXP_DEVCAP, &reg32);
-		/* Calculate endpoint L0s acceptable latency */
-		encoding = (reg32 & PCI_EXP_DEVCAP_L0S) >> 6;
-		acceptable->l0s = calc_l0s_acceptable(encoding);
-		/* Calculate endpoint L1 acceptable latency */
-		encoding = (reg32 & PCI_EXP_DEVCAP_L1) >> 9;
-		acceptable->l1 = calc_l1_acceptable(encoding);
-
 		pcie_aspm_check_latency(child);
 	}
 }
-- 
2.20.1

