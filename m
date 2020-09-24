Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33D23277532
	for <lists+linux-pci@lfdr.de>; Thu, 24 Sep 2020 17:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728474AbgIXPYT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Sep 2020 11:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728285AbgIXPYT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Sep 2020 11:24:19 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46682C0613CE
        for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2020 08:24:19 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id z22so5041450ejl.7
        for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2020 08:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vcc0BYnocUTKGJbOFWpRFtp+y0ZbkIBTKk3LLhU83hU=;
        b=a8a9zxl6ALelKDlciaXgXi0krqYPQ6uS1ixXsydbgTyRARo8dATmjkouXuksyKz5cm
         4M3KyTkLbodaYaYPS99zNgSrxm+bfHCBHnYdpBTTrU+HB5pAESkj/AhOzm7ST3pwtqcJ
         8IUAjpheSjeyeF4eMszoqGdmCbfDwuvWnVqvTJnQOUfc8h/5KNuFmGcRzcHKAxREoGuM
         8RUhqP03xeNC5NmdDAlhfBpqrSzrBlxruDlzkjqiWTrKr9vP55iKkegercICcQjieXjh
         PLRObKeNaCDu7uygRuMpDJLNZDXO8mpOr48c6aBIWtPD/KhiUnFUeEWqbRNl51kfGYe/
         mWLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vcc0BYnocUTKGJbOFWpRFtp+y0ZbkIBTKk3LLhU83hU=;
        b=BESoVMAX8l/9IZUFAzjXYGTYrvyTXIDj2lQmsKUb4v6p5uKXRV6VuAlOCTfPgzbJcj
         1IocqldmyKlpjkQ63OIsbpy+iqVpiczXrXjCXYPRnFf9O9GXP06EytPRSVfPzj/lmWKa
         pDOmfR/ZLhuXQagpxVRJEX30BuL2WXv+UbPRTAd+AqwrlijgUxHpGzzem7MvGkU9m0WZ
         5WpAnKzgjQQdtkPlyMLawlIFg8mWsyzg3H7imQK2E9WWwYumeLbOJAhV9fxl0PltxT8x
         imMyBg0UxCcbCcZDVGDGrquhvr8INeVGEr7rde5STsI72IlmJSo+7YhJM2Imv/qBL+g1
         SFyw==
X-Gm-Message-State: AOAM5313QuMUlt2mtlFNGCrr4TUAHSCe3bIlEAPXlgNLx8g6BqvOoxl0
        H3ZDOrjycmMEBf28QF0UtMU=
X-Google-Smtp-Source: ABdhPJypogfPGDUFMLIIH6QK+erQGezPk6nReuceQ+TnADEc3hBET57fzS9Wt5XkIQrszQpbUBcvXQ==
X-Received: by 2002:a17:906:1909:: with SMTP id a9mr402218eje.127.1600961058004;
        Thu, 24 Sep 2020 08:24:18 -0700 (PDT)
Received: from net.saheed (5402C65D.dsl.pool.telekom.hu. [84.2.198.93])
        by smtp.gmail.com with ESMTPSA id i7sm2641735ejo.22.2020.09.24.08.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 08:24:17 -0700 (PDT)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     helgaas@kernel.org
Cc:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH v2 5/7] PCI/ASPM: Remove aspm_register_info.l1ss_ctl*
Date:   Thu, 24 Sep 2020 16:24:41 +0200
Message-Id: <20200924142443.260861-6-refactormyself@gmail.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20200924142443.260861-1-refactormyself@gmail.com>
References: <20200924142443.260861-1-refactormyself@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

 - Read the value of PCI_L1SS_CTL1 directly and cache in local variables.
 - Replace references to aspm_register_info.l1ss_ctl1 with the variables.
 - In pcie_get_aspm_reg() remove reference to aspm_register_info.l1ss_ctl*
 - In pcie_get_aspm_reg() remove reading PCI_L1SS_CTL1 and PCI_L1SS_CTL2
 - Remove aspm_register_info.(l1ss_ctl1 && l1ss_ctl2)

Note that aspm_register_info.l1ss_ctl2 is eliminated totally since it is
not used.

Signed-off-by: Saheed O. Bolarinwa <refactormyself@gmail.com>
---
 drivers/pci/pcie/aspm.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index e7bb7d069361..cec8acad6363 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -384,10 +384,6 @@ static void encode_l12_threshold(u32 threshold_us, u32 *scale, u32 *value)
 
 struct aspm_register_info {
 	u32 enabled:2;
-
-	/* L1 substates */
-	u32 l1ss_ctl1;
-	u32 l1ss_ctl2;
 };
 
 static void pcie_get_aspm_reg(struct pci_dev *pdev,
@@ -397,11 +393,6 @@ static void pcie_get_aspm_reg(struct pci_dev *pdev,
 
 	pcie_capability_read_word(pdev, PCI_EXP_LNKCTL, &ctl);
 	info->enabled = ctl & PCI_EXP_LNKCTL_ASPMC;
-
-	pci_read_config_dword(pdev, info->l1ss_cap_ptr + PCI_L1SS_CTL1,
-			      &info->l1ss_ctl1);
-	pci_read_config_dword(pdev, info->l1ss_cap_ptr + PCI_L1SS_CTL2,
-			      &info->l1ss_ctl2);
 }
 
 static void pcie_aspm_check_latency(struct pci_dev *endpoint)
@@ -525,6 +516,7 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 	struct pci_dev *child = link->downstream, *parent = link->pdev;
 	struct pci_bus *linkbus = parent->subordinate;
 	struct aspm_register_info upreg, dwreg;
+	u32 up_l1ss_ctl1, dw_l1ss_ctl1;
 
 	if (blacklist) {
 		/* Set enabled/disable so that we will disable ASPM later */
@@ -547,6 +539,11 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 	/* Configure common clock before checking latencies */
 	pcie_aspm_configure_common_clock(link);
 
+	pci_read_config_dword(parent, parent->l1ss_cap_ptr + PCI_L1SS_CTL1,
+				&up_l1ss_ctl1);
+	pci_read_config_dword(child, child->l1ss_cap_ptr + PCI_L1SS_CTL1,
+				&dw_l1ss_ctl1);
+
 	/*
 	 * Re-read upstream/downstream components' register state
 	 * after clock configuration
@@ -590,13 +587,13 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 	if (parent->l1ss_cap & child->l1ss_cap & PCI_L1SS_CAP_PCIPM_L1_2)
 		link->aspm_support |= ASPM_STATE_L1_2_PCIPM;
 
-	if (upreg.l1ss_ctl1 & dwreg.l1ss_ctl1 & PCI_L1SS_CTL1_ASPM_L1_1)
+	if (up_l1ss_ctl1 & dw_l1ss_ctl1 & PCI_L1SS_CTL1_ASPM_L1_1)
 		link->aspm_enabled |= ASPM_STATE_L1_1;
-	if (upreg.l1ss_ctl1 & dwreg.l1ss_ctl1 & PCI_L1SS_CTL1_ASPM_L1_2)
+	if (up_l1ss_ctl1 & dw_l1ss_ctl1 & PCI_L1SS_CTL1_ASPM_L1_2)
 		link->aspm_enabled |= ASPM_STATE_L1_2;
-	if (upreg.l1ss_ctl1 & dwreg.l1ss_ctl1 & PCI_L1SS_CTL1_PCIPM_L1_1)
+	if (up_l1ss_ctl1 & dw_l1ss_ctl1 & PCI_L1SS_CTL1_PCIPM_L1_1)
 		link->aspm_enabled |= ASPM_STATE_L1_1_PCIPM;
-	if (upreg.l1ss_ctl1 & dwreg.l1ss_ctl1 & PCI_L1SS_CTL1_PCIPM_L1_2)
+	if (up_l1ss_ctl1 & dw_l1ss_ctl1 & PCI_L1SS_CTL1_PCIPM_L1_2)
 		link->aspm_enabled |= ASPM_STATE_L1_2_PCIPM;
 
 	if (link->aspm_support & ASPM_STATE_L1SS)
-- 
2.18.4

