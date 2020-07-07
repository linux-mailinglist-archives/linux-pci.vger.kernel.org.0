Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD874217B89
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jul 2020 01:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729222AbgGGXD7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Jul 2020 19:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729241AbgGGXD7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Jul 2020 19:03:59 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57743C061755;
        Tue,  7 Jul 2020 16:03:58 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id l12so48402198ejn.10;
        Tue, 07 Jul 2020 16:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zyI7dGHcWxL5eZIzek4DRLHDe+LxmqM1HBHRwkB+vBg=;
        b=rNi1QyIDolFeJ+HB/5i2r5Ow1H+/X0si1NXLlguXjKTpjIsvtYuEqCtqlJVRguOwts
         ticG98sWnx9Yk1/KwQJ3u7AIigR5PQlFM9zK6Vcsz6WCa83C5F2rUV0sdXMYQnhLi7A5
         nBLzHhvevGRqwmxIudv88KU94WRM7IlYsg4P3EOeCT6ym8ON3WgN2jVm1JokL0peKAKu
         rF4SM2+AHa6PmGAv6wrEV6Lrdm/RnBBD1bWQaos7sKt20c3Jah6yp+psTLOF4jVGD2Hi
         zyzlFXH5de2Ve84dDuMJIUuGcDt57/Lj1rX/eqzVKx+U9TYGt/MiQP+xJzh118a//Jfo
         9pWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zyI7dGHcWxL5eZIzek4DRLHDe+LxmqM1HBHRwkB+vBg=;
        b=OmOj8KMgV3xLOEqnNhOjmFStFU3PiQlSaDZa+vv4DaOWSRO+HeE8HdnwE3mChgVQ/n
         /ggUcevI1GHOxyEcT7QQZaQ1zAqwgnI8SZMAYqjlGE+QtsMfiaU6wXVbcC/DuSVyVhiU
         KGx5NuQFOwQU8mbdCQwT8jTQxcwMl8JgvDeiiwUD7pm34oSeV19sLf26Lx9eyJVCNI2o
         YC1dqOl2/MDxved9/a1raETtsKFbu6Frj8MjMJilaQ4o3r/CSohxxSb78NIl0Onw1BY0
         6nx5lm1WlnF+NfWUCdmHUNZu3deKFg2G7tXSlGrULfeRyZ51Q6G2MKN5pFayBzmTx8wC
         odGw==
X-Gm-Message-State: AOAM533zeTle2wfxKaL1bWFQkwVkfxvZz+HmeYwIpCtpuW63Lq53o35Q
        HEjut4+7kuCe4aB79orelio=
X-Google-Smtp-Source: ABdhPJwzZujteTN89D0kqoJsaDiQFM33Fe+QmfkWVcFnVysbzBmCcMO7m6PMyYuLx1B0xhAQ5RZhrQ==
X-Received: by 2002:a17:906:1491:: with SMTP id x17mr50675187ejc.416.1594163037117;
        Tue, 07 Jul 2020 16:03:57 -0700 (PDT)
Received: from net.saheed (54007186.dsl.pool.telekom.hu. [84.0.113.134])
        by smtp.gmail.com with ESMTPSA id f10sm27096310edx.5.2020.07.07.16.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 16:03:56 -0700 (PDT)
From:   Saheed Olayemi Bolarinwa <refactormyself@gmail.com>
To:     helgaas@kernel.org
Cc:     Bolarinwa Olayemi Saheed <refactormyself@gmail.com>,
        bjorn@helgaas.com, skhan@linuxfoundation.org,
        linux-pci@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 12/13] PCI/ASPM: Check the return value of pcie_capability_read_*()
Date:   Wed,  8 Jul 2020 00:03:23 +0200
Message-Id: <20200707220324.8425-13-refactormyself@gmail.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200707220324.8425-1-refactormyself@gmail.com>
References: <20200707220324.8425-1-refactormyself@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>

On failure pcie_capability_read_dword() sets it's last parameter,
val to 0.
However, with Patch 13/13, it is possible that val is set to ~0 on
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

