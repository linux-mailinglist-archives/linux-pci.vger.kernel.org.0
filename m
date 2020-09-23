Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 754D02764F2
	for <lists+linux-pci@lfdr.de>; Thu, 24 Sep 2020 02:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbgIXAO6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Sep 2020 20:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbgIXAO5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Sep 2020 20:14:57 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B042C0613CE
        for <linux-pci@vger.kernel.org>; Wed, 23 Sep 2020 17:14:57 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id i1so1604309edv.2
        for <linux-pci@vger.kernel.org>; Wed, 23 Sep 2020 17:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3opejunV380zsaSYNb96dESI67v7H1F5KotXWkdJHno=;
        b=BygXBvxBdqtluFCX5vT1AobkCw7BE0fvzPA3CAwfW8odSDEyEsCwGj9LRB++8C0yyt
         jocGJHRXJ2PZ6aqYXyp248SiGF4HWsRaJ3vDyAXOcFv18BOkR2NWjIO+96RJy7aJnsV9
         0XVPZaGVl7naE2vTa8qMBiT6XDB2kLmpBiSHZxgqpTY808d3238VAl7VHrhv2O9jignO
         QS4MFMiQD+JuUz7fEH5zFBFp+Atk8kk9+5Iuk+kUW0HTXVAJnWI/WvemIdtP5C19VJ/S
         QgUw3+7nzy7I8+hWmypOXMOPh/Kr9707UkuHrItdGZvXFFQ2JNmiiqTSU2zq1486o2Gh
         rDtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3opejunV380zsaSYNb96dESI67v7H1F5KotXWkdJHno=;
        b=cGkmqeNEHx+9hSRX5B8ekBgLiz4mgk+jUg1Box9fkMJ/4+Lck9eKPMPYyYXT4Np8aQ
         C+BimvUSotyym492Ftj1a7RX4GBk2M/ncSDwsJGdUr4Yut0w7eo++VtK8HDHZFV2neqh
         HaOkniTnVk2a/hF8pexeCSooLtam2zCa0Lx1iKeERMN7bcxWlwGM7ntKOUPTYcvypUKd
         a7XmAgpdnE2QAXMGLuAZ9IriQk+u0pVwS2wwiYIr4E+TOyu5yTb7BxHFZJxk4+UJrrgy
         Ub7nBjXE+/cfKYkQ13wZ+EAjpYfhAJjBwcv+BxUO7jgJ2JZDCqwGS4WBmsldsTGSrEAb
         RIMA==
X-Gm-Message-State: AOAM5328mxHbqVFeA6/rf/lhfJ/7ZjvLgGQKAD8ySx0xd2VTFKfTaZm5
        FSa/BYNNC1lIA/0kR+6Gzkg=
X-Google-Smtp-Source: ABdhPJwRpF49GdIaC8djfceQhTgQIfO88FOJMdRbouW8JaAQdbizsK6dSh86KCWkpVCeodrPuIflfA==
X-Received: by 2002:aa7:d991:: with SMTP id u17mr1934719eds.11.1600906496155;
        Wed, 23 Sep 2020 17:14:56 -0700 (PDT)
Received: from net.saheed (5402C65D.dsl.pool.telekom.hu. [84.2.198.93])
        by smtp.gmail.com with ESMTPSA id r9sm1026559ejc.102.2020.09.23.17.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 17:14:55 -0700 (PDT)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     helgaas@kernel.org
Cc:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH 6/8] PCI/ASPM: Remove aspm_register_info.enable
Date:   Thu, 24 Sep 2020 01:15:15 +0200
Message-Id: <20200923231517.221310-7-refactormyself@gmail.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20200923231517.221310-1-refactormyself@gmail.com>
References: <20200923231517.221310-1-refactormyself@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

 - Create get_aspm_enable() to compute aspm_register_info.enable directly
 - Replace all aspm_register_info.enable references with get_aspm_enable()
 - In pcie_get_aspm_reg() remove reference to aspm_register_info.l1ss_cap*
 - Remove aspm_register_info.enabled
 - In pcie_aspm_cap_init() remove all calls to pcie_get_aspm_reg(), since
   it now does nothing. All the values are calculated elsewhere.

Signed-off-by: Saheed O. Bolarinwa <refactormyself@gmail.com>
---
NOTE: To avoid messing up this patch, the struct aspm_register_info is 
removed in the next patch. I am not sure if it is better to merge them.

 drivers/pci/pcie/aspm.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index f89d3b2be1c7..e43fdf0cd08c 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -383,7 +383,6 @@ static void encode_l12_threshold(u32 threshold_us, u32 *scale, u32 *value)
 }
 
 struct aspm_register_info {
-	u32 enabled:2;
 };
 
 static void pcie_get_aspm_reg(struct pci_dev *pdev,
@@ -392,7 +391,6 @@ static void pcie_get_aspm_reg(struct pci_dev *pdev,
 	u16 ctl;
 
 	pcie_capability_read_word(pdev, PCI_EXP_LNKCTL, &ctl);
-	info->enabled = ctl & PCI_EXP_LNKCTL_ASPMC;
 }
 
 static void pcie_aspm_check_latency(struct pci_dev *endpoint)
@@ -513,6 +511,14 @@ static void aspm_support(struct pci_dev *pdev)
 	return (pdev->lnkcap & PCI_EXP_LNKCAP_ASPMS) >> 10;
 }
 
+static u32 get_aspm_enable(struct pci_dev *pdev)
+{
+	u16 ctl;
+
+	pcie_capability_read_word(pdev, PCI_EXP_LNKCTL, &ctl);
+	return (ctl & PCI_EXP_LNKCTL_ASPMC);
+}
+
 static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 {
 	struct pci_dev *child = link->downstream, *parent = link->pdev;
@@ -527,10 +533,6 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 		return;
 	}
 
-	/* Get upstream/downstream components' register state */
-	pcie_get_aspm_reg(parent, &upreg);
-	pcie_get_aspm_reg(child, &dwreg);
-
 	/*
 	 * If ASPM not supported, don't mess with the clocks and link,
 	 * bail out now.
@@ -546,13 +548,6 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 	pci_read_config_dword(child, child->l1ss_cap_ptr + PCI_L1SS_CTL1,
 				&dw_l1ss_ctl1);
 
-	/*
-	 * Re-read upstream/downstream components' register state
-	 * after clock configuration
-	 */
-	pcie_get_aspm_reg(parent, &upreg);
-	pcie_get_aspm_reg(child, &dwreg);
-
 	/*
 	 * Setup L0s state
 	 *
@@ -563,9 +558,9 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 	if (aspm_support(parent) & aspm_support(child) & PCIE_LINK_STATE_L0S)
 		link->aspm_support |= ASPM_STATE_L0S;
 
-	if (dwreg.enabled & PCIE_LINK_STATE_L0S)
+	if (get_aspm_enable(child) & PCIE_LINK_STATE_L0S)
 		link->aspm_enabled |= ASPM_STATE_L0S_UP;
-	if (upreg.enabled & PCIE_LINK_STATE_L0S)
+	if (get_aspm_enable(parent) & PCIE_LINK_STATE_L0S)
 		link->aspm_enabled |= ASPM_STATE_L0S_DW;
 	link->latency_up.l0s = calc_l0s_latency(parent);
 	link->latency_dw.l0s = calc_l0s_latency(child);
@@ -574,7 +569,8 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 	if (aspm_support(parent) & aspm_support(child) & PCIE_LINK_STATE_L1)
 		link->aspm_support |= ASPM_STATE_L1;
 
-	if (upreg.enabled & dwreg.enabled & PCIE_LINK_STATE_L1)
+	if (get_aspm_enable(parent) & get_aspm_enable(child)
+				    & PCIE_LINK_STATE_L1)
 		link->aspm_enabled |= ASPM_STATE_L1;
 	link->latency_up.l1 = calc_l1_latency(parent);
 	link->latency_dw.l1 = calc_l1_latency(child);
-- 
2.18.4

