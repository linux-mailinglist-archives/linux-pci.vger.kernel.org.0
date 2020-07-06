Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5D4821559C
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jul 2020 12:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728977AbgGFKcG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Jul 2020 06:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728968AbgGFKcD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Jul 2020 06:32:03 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6CF6C061794;
        Mon,  6 Jul 2020 03:32:02 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id b6so40211865wrs.11;
        Mon, 06 Jul 2020 03:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Xt1YnhbKy4/5TpAyL6iPPAj3fa0SaikOZX3SkNC5/cs=;
        b=co+Hhf/sWoMzEYqwa5Ain3cY7e4KSSiUOmEfwJQb1NeVGFEzn0PQP/JcP5+0va9H50
         xiF1w/ly0NlcJGGE3DckK6xOfj8hhy0xZdK4G1XNW9Fe9qgUtiLuhpc5QZZOxgFVtFi+
         z3IM42d42k5ldCAyVBNNp5Tj4DHavz2lQvTMkCWoqWneqaCGWGJbmOb7FggzrK7NjP8W
         sUDLZ8z5QWsW2Z/pTMGTrrXQ0OtVo12+cgsw6P3ychg1111TvH39V2dom/vdq+VJvfum
         DY+UgOBfPimdsbCrjhkEe36HGDvr+GsxvJIzDxiYkSWNmc8YPr7lwHSXOk5JKFN3uJg0
         R3OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Xt1YnhbKy4/5TpAyL6iPPAj3fa0SaikOZX3SkNC5/cs=;
        b=HKtlXsfD6YU84EWVc3DwUPH0pJHSH8bokYWq2JiHj4udNQT07tTa5Vi8dW8u1DrwIB
         EPNqLFWE0KwVfU7Hm7fI3U0NtAvG3foDbZOEzGhcXkFm147VSwPsorBi+mo6tNsxtXX5
         LmppvGQ2avXbBqnVyeVpJw38xhmOi/XntDEeYDO47DOQl3mA2+I17xLhyy9svlklTVIf
         1+6GKHmGJ5cbXp8l25S0tQokj6XLxXcJPgamNj+rpULgRFC2ZERLrXut/V14lRKyNK2m
         AJoyUSqiYaUTepHQ4Xzdrj19WEouYjjWgtRnptHQ9ewvRLU09oFhAAqfLQM42TXprswO
         O6YA==
X-Gm-Message-State: AOAM531PQd3nX/V/ZpAq/Me0OunARJN2eXnD2gh7l4+RFxob4bmn4xxY
        I4Ff6DGrFkT+6PrM3duKu70nL/taR4QAHw==
X-Google-Smtp-Source: ABdhPJx2eDLSW97bkw4iz1NfiA0Clo5Lgra2iobZdw5mwX70eKnoycMIu5+PnOcB1hjLfGz3+dHG/g==
X-Received: by 2002:adf:f34e:: with SMTP id e14mr47656427wrp.299.1594031521641;
        Mon, 06 Jul 2020 03:32:01 -0700 (PDT)
Received: from net.saheed (51B7C2DF.dsl.pool.telekom.hu. [81.183.194.223])
        by smtp.gmail.com with ESMTPSA id 22sm24216859wmb.11.2020.07.06.03.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 03:32:01 -0700 (PDT)
From:   Saheed Olayemi Bolarinwa <refactormyself@gmail.com>
To:     helgaas@kernel.org
Cc:     Bolarinwa Olayemi Saheed <refactormyself@gmail.com>,
        bjorn@helgaas.com, skhan@linuxfoundation.org,
        linux-pci@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 10/11 RFC] PCI/ASPM: Use error return value from pcie_capability_read_*()
Date:   Mon,  6 Jul 2020 11:31:20 +0200
Message-Id: <20200706093121.9731-11-refactormyself@gmail.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200706093121.9731-1-refactormyself@gmail.com>
References: <20200706093121.9731-1-refactormyself@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>

On failure pcie_capability_read_dword() sets it's last parameter,
val to 0.
However, with Patch 11/11, it is possible that val is set to ~0 on
failure. This would introduce a bug because (x & x) == (~0 & x).

This bug can be avoided if the return value of pcie_capability_read_dword
is checked to confirm success.

Check the return value of pcie_capability_read_dword() to ensure success.

Suggested-by: Bjorn Helgaas <bjorn@helgaas.com>
Signed-off-by: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>
---
 drivers/pci/pcie/aspm.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index b17e5ffd31b1..32aa9d57672a 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -176,7 +176,7 @@ static void pcie_set_clkpm(struct pcie_link_state *link, int enable)
 
 static void pcie_clkpm_cap_init(struct pcie_link_state *link, int blacklist)
 {
-	int capable = 1, enabled = 1;
+	int ret, capable = 1, enabled = 1;
 	u32 reg32;
 	u16 reg16;
 	struct pci_dev *child;
@@ -184,14 +184,14 @@ static void pcie_clkpm_cap_init(struct pcie_link_state *link, int blacklist)
 
 	/* All functions should have the same cap and state, take the worst */
 	list_for_each_entry(child, &linkbus->devices, bus_list) {
-		pcie_capability_read_dword(child, PCI_EXP_LNKCAP, &reg32);
-		if (!(reg32 & PCI_EXP_LNKCAP_CLKPM)) {
+		ret = pcie_capability_read_dword(child, PCI_EXP_LNKCAP, &reg32);
+		if (ret || !(reg32 & PCI_EXP_LNKCAP_CLKPM)) {
 			capable = 0;
 			enabled = 0;
 			break;
 		}
-		pcie_capability_read_word(child, PCI_EXP_LNKCTL, &reg16);
-		if (!(reg16 & PCI_EXP_LNKCTL_CLKREQ_EN))
+		ret = pcie_capability_read_word(child, PCI_EXP_LNKCTL, &reg16);
+		if (ret || !(reg16 & PCI_EXP_LNKCTL_CLKREQ_EN))
 			enabled = 0;
 	}
 	link->clkpm_enabled = enabled;
@@ -205,6 +205,7 @@ static bool pcie_retrain_link(struct pcie_link_state *link)
 	struct pci_dev *parent = link->pdev;
 	unsigned long end_jiffies;
 	u16 reg16;
+	int ret;
 
 	pcie_capability_read_word(parent, PCI_EXP_LNKCTL, &reg16);
 	reg16 |= PCI_EXP_LNKCTL_RL;
@@ -222,8 +223,8 @@ static bool pcie_retrain_link(struct pcie_link_state *link)
 	/* Wait for link training end. Break out after waiting for timeout */
 	end_jiffies = jiffies + LINK_RETRAIN_TIMEOUT;
 	do {
-		pcie_capability_read_word(parent, PCI_EXP_LNKSTA, &reg16);
-		if (!(reg16 & PCI_EXP_LNKSTA_LT))
+		ret = pcie_capability_read_word(parent, PCI_EXP_LNKSTA, &reg16);
+		if (ret || !(reg16 & PCI_EXP_LNKSTA_LT))
 			break;
 		msleep(1);
 	} while (time_before(jiffies, end_jiffies));
@@ -237,7 +238,7 @@ static bool pcie_retrain_link(struct pcie_link_state *link)
  */
 static void pcie_aspm_configure_common_clock(struct pcie_link_state *link)
 {
-	int same_clock = 1;
+	int ret, same_clock = 1;
 	u16 reg16, parent_reg, child_reg[8];
 	struct pci_dev *child, *parent = link->pdev;
 	struct pci_bus *linkbus = parent->subordinate;
@@ -249,24 +250,24 @@ static void pcie_aspm_configure_common_clock(struct pcie_link_state *link)
 	BUG_ON(!pci_is_pcie(child));
 
 	/* Check downstream component if bit Slot Clock Configuration is 1 */
-	pcie_capability_read_word(child, PCI_EXP_LNKSTA, &reg16);
-	if (!(reg16 & PCI_EXP_LNKSTA_SLC))
+	ret = pcie_capability_read_word(child, PCI_EXP_LNKSTA, &reg16);
+	if (ret || !(reg16 & PCI_EXP_LNKSTA_SLC))
 		same_clock = 0;
 
 	/* Check upstream component if bit Slot Clock Configuration is 1 */
-	pcie_capability_read_word(parent, PCI_EXP_LNKSTA, &reg16);
-	if (!(reg16 & PCI_EXP_LNKSTA_SLC))
+	ret = pcie_capability_read_word(parent, PCI_EXP_LNKSTA, &reg16);
+	if (ret || !(reg16 & PCI_EXP_LNKSTA_SLC))
 		same_clock = 0;
 
 	/* Port might be already in common clock mode */
-	pcie_capability_read_word(parent, PCI_EXP_LNKCTL, &reg16);
-	if (same_clock && (reg16 & PCI_EXP_LNKCTL_CCC)) {
+	ret = pcie_capability_read_word(parent, PCI_EXP_LNKCTL, &reg16);
+	if (!ret && same_clock && (reg16 & PCI_EXP_LNKCTL_CCC)) {
 		bool consistent = true;
 
 		list_for_each_entry(child, &linkbus->devices, bus_list) {
-			pcie_capability_read_word(child, PCI_EXP_LNKCTL,
+			ret = pcie_capability_read_word(child, PCI_EXP_LNKCTL,
 						  &reg16);
-			if (!(reg16 & PCI_EXP_LNKCTL_CCC)) {
+			if (ret || !(reg16 & PCI_EXP_LNKCTL_CCC)) {
 				consistent = false;
 				break;
 			}
-- 
2.18.2

