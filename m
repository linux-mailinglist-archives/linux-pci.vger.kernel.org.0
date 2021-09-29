Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BBAA41BBDC
	for <lists+linux-pci@lfdr.de>; Wed, 29 Sep 2021 02:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243479AbhI2Apu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Sep 2021 20:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243435AbhI2Aps (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Sep 2021 20:45:48 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B71BEC061746;
        Tue, 28 Sep 2021 17:44:07 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id b26so2139322edt.0;
        Tue, 28 Sep 2021 17:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vqYVhHvmXtg26aIqh8dqosLB/DKB+f5Z7Vmc3mQ1XAk=;
        b=j+zYp2xrNRfjDVqmeFtG+q3Ihp9cyZlzCM16EsaSR+hEiH7r6RjsNxA38dV6daLwS9
         phPjWYQDEdvq0FMzv8KMi0nuTArO5xFvEBcQK0dpWp5AaATPVzjcM+FuGS0h8T1/ZVGE
         16ihtCs5830RVx3R6cgzMsmordMVBHj6MIalNwwI6nbeOoBE68CGpoImsuTmMDiaDwT0
         BvOY2hnSioduFepIy1iOwM2iUpkCsW91XOmxp2JP3k4Ve2B8LGX60TNxO0QD0HBqa9eB
         fw+rR537pKPDxETpBTxPdaLllPHnvpz1Ft3bzuDpphsQdAOLkwjldZtJMqrKyZgF7+dH
         Md3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vqYVhHvmXtg26aIqh8dqosLB/DKB+f5Z7Vmc3mQ1XAk=;
        b=w6Ktn7vZ/dJzr3mU7i/2CNtMevqNmWkxvR+sClQUA4IN0IhCZcOk/aKjcw8CKblkr4
         YpNE48VewFS4Jjy3F27RP5YIQ1JEVhzUE1whGhSsXqjtTainVmwwO8/JoZbF0ol3oQrv
         O1KBsUi3EyG8dKwRRURQ3O4IzJo/n3AHS/Q1mAVPLdiuT/Ed3oo5lkSd0XMitSt9uyEQ
         rTCdByaVyToXYUr1H+ILeC3oEqppd45+u8Lx9bbAP/UMbX3om3brT9rHxLX2kbS3AqoS
         +oKEc6Ol99zQs7Xe27pHG/YGsOwHeM/GJ3Pb5AWDHwvNGcukFwLPTiSq6TUxLJ+Xm6SL
         2bQA==
X-Gm-Message-State: AOAM5312R9bB9EaaG8jvwS3wCPzpJwhgFEeGfuqsOiDP14haHKy0Bv2b
        exjFwdUM2614RSL9gx+CbZ0=
X-Google-Smtp-Source: ABdhPJy1eBXUIOJbBSzr+zaKzRaDJK+jOYrp/5YkObudUYUC0qioXosg+7egQzvubE7QKFPZrQbSWw==
X-Received: by 2002:a50:d903:: with SMTP id t3mr11488782edj.70.1632876246379;
        Tue, 28 Sep 2021 17:44:06 -0700 (PDT)
Received: from localhost.localdomain ([2a02:ab88:10f:c9f0:35c7:3af0:a197:61d0])
        by smtp.googlemail.com with ESMTPSA id r19sm383578edt.54.2021.09.28.17.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 17:44:06 -0700 (PDT)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     helgaas@kernel.org
Cc:     "Bolarinwa O. Saheed" <refactormyself@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 2/4] PCI/ASPM: Remove struct pcie_link_state.clkpm_capable
Date:   Wed, 29 Sep 2021 02:43:58 +0200
Message-Id: <20210929004400.25717-3-refactormyself@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210929004400.25717-1-refactormyself@gmail.com>
References: <20210929004400.25717-1-refactormyself@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: "Bolarinwa O. Saheed" <refactormyself@gmail.com>

The clkpm_capable member of the struct pcie_link_state indicates
if the device is Clock PM capable. This can be calculated when
it is needed.

This patch:
  - removes clkpm_capable from struct pcie_link_state
  - moves the calculation of clkpm_capable into
    pcie_is_clkpm_capable()
  - replaces references to clkpm_capable with a call to
    pcie_is_clkpm_capable()

Signed-off-by: Bolarinwa O. Saheed <refactormyself@gmail.com>
---
 drivers/pci/pcie/aspm.c | 39 ++++++++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index c23da9a4e2fb..9e65da9a22dd 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -61,7 +61,6 @@ struct pcie_link_state {
 	u32 aspm_disable:7;		/* Disabled ASPM state */
 
 	/* Clock PM state */
-	u32 clkpm_capable:1;		/* Clock PM capable? */
 	u32 clkpm_enabled:1;		/* Current Clock PM state */
 	u32 clkpm_disable:1;		/* Clock PM disabled */
 
@@ -146,6 +145,25 @@ static int pcie_get_clkpm_state(struct pci_dev *pdev)
 	return enabled;
 }
 
+static int pcie_is_clkpm_capable(struct pci_dev *pdev)
+{
+	int capable = 1;
+	u32 reg32;
+	struct pci_dev *child;
+	struct pci_bus *linkbus = pdev->subordinate;
+
+	/* All functions should have the same cap state, take the worst */
+	list_for_each_entry(child, &linkbus->devices, bus_list) {
+		pcie_capability_read_dword(child, PCI_EXP_LNKCAP, &reg32);
+		if (!(reg32 & PCI_EXP_LNKCAP_CLKPM)) {
+			capable = 0;
+			break;
+		}
+	}
+
+	return capable;
+}
+
 static int policy_to_clkpm_state(struct pcie_link_state *link)
 {
 	switch (aspm_policy) {
@@ -177,11 +195,12 @@ static void pcie_set_clkpm_nocheck(struct pcie_link_state *link, int enable)
 
 static void pcie_set_clkpm(struct pcie_link_state *link, int enable)
 {
+	int capable = pcie_is_clkpm_capable(link->pdev);
 	/*
 	 * Don't enable Clock PM if the link is not Clock PM capable
 	 * or Clock PM is disabled
 	 */
-	if (!link->clkpm_capable || link->clkpm_disable)
+	if (!capable || link->clkpm_disable)
 		enable = 0;
 	/* Need nothing if the specified equals to current state */
 	if (link->clkpm_enabled == enable)
@@ -191,21 +210,7 @@ static void pcie_set_clkpm(struct pcie_link_state *link, int enable)
 
 static void pcie_clkpm_cap_init(struct pcie_link_state *link, int blacklist)
 {
-	int capable = 1;
-	u32 reg32;
-	struct pci_dev *child;
-	struct pci_bus *linkbus = link->pdev->subordinate;
-
-	/* All functions should have the same cap and state, take the worst */
-	list_for_each_entry(child, &linkbus->devices, bus_list) {
-		pcie_capability_read_dword(child, PCI_EXP_LNKCAP, &reg32);
-		if (!(reg32 & PCI_EXP_LNKCAP_CLKPM)) {
-			capable = 0;
-			break;
-		}
-	}
 	link->clkpm_enabled = pcie_get_clkpm_state(link->pdev);
-	link->clkpm_capable = capable;
 	link->clkpm_disable = blacklist ? 1 : 0;
 }
 
@@ -1346,7 +1351,7 @@ static umode_t aspm_ctrl_attrs_are_visible(struct kobject *kobj,
 		return 0;
 
 	if (n == 0)
-		return link->clkpm_capable ? a->mode : 0;
+		return pcie_is_clkpm_capable(link->pdev) ? a->mode : 0;
 
 	return link->aspm_capable & aspm_state_map[n - 1] ? a->mode : 0;
 }
-- 
2.20.1

