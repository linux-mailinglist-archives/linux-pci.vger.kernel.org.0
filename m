Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89961277530
	for <lists+linux-pci@lfdr.de>; Thu, 24 Sep 2020 17:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728465AbgIXPYR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Sep 2020 11:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728285AbgIXPYR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Sep 2020 11:24:17 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B24C0613CE
        for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2020 08:24:17 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id z22so5041268ejl.7
        for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2020 08:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gqOo9sRKsu8OklEdZbxfDsKXZHiV2LQufDSEO7PGLPM=;
        b=ZLbKpdujpsyuwlg3VvHrMe5dseLSbvSLOuFoF+mPsRr7sm59RyPtI2arMz7XfihkEL
         KzACRGtJNUuWwUCQX3ejN/qe4Qq5vPq6QaOYKrgSrsBDw/xSRUfxwuprhPmIgeOcjeUV
         pbYyeXitK1Fk934gvybAw5vK8KARG1MdBKoOKjeOPhFVqKkRErfIS8+rX3QI7dMK7yyb
         PuirOvqjzrr4FHnCsZPKP41nXD3k6r69BeioENXZRBpJ9AgUHJBmbOFDVZtjRS1kk+Yy
         kmfrnNYCxW9ZuIAyvCR4iimLe6zLI9VHldWjLtuCI1bp71enx/nTIAxOAlNQTfMs8Cx/
         WRFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gqOo9sRKsu8OklEdZbxfDsKXZHiV2LQufDSEO7PGLPM=;
        b=RscjomifTa1IXalXMPf4NnX3E8srRtrVpGJsIm+pOzTry/Y0UxyWDQEPl2GY42g0nE
         IvSx3YeVbsadvzsku0unkqmX8s9qO+FKIDpXmM956Jz5NXBIOwcEimDM/xvnhwi06Ut6
         i/J9rXRh6KHsuYJCAB2SKG5dr3qYX1pA+UqyCVGIIgkaip6iXPW/sofvikhEyyrQJe8G
         HlsghE4+krl55SaB5oiBehSDgyP8eL0EqKRPPAzjdmn944/LUs+2hpvejM+VMtakUVPI
         LklkrNUy4I1mQNopF3g9VTO7EheoO+s2DEJrblBLYZm+FnRnyd/tUT0223lKbIPlSzwN
         hwfQ==
X-Gm-Message-State: AOAM5329+bZn4FtfDErIoXzki7NmLTGISnA+cYFHRDUlxaW/tQDdbU/R
        fl8KqYLNaJArG2c8Ton7Tfc=
X-Google-Smtp-Source: ABdhPJxYZ4U5br55orZCpnApMVEk0NxOgpjlpNQk+4fYXYhcnsUiE6L1KaDgakj1tQWN84GzELx+9Q==
X-Received: by 2002:a17:906:17c6:: with SMTP id u6mr418428eje.95.1600961055606;
        Thu, 24 Sep 2020 08:24:15 -0700 (PDT)
Received: from net.saheed (5402C65D.dsl.pool.telekom.hu. [84.2.198.93])
        by smtp.gmail.com with ESMTPSA id i7sm2641735ejo.22.2020.09.24.08.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 08:24:15 -0700 (PDT)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     helgaas@kernel.org
Cc:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH v2 3/7] PCI/ASPM: Compute the value of aspm_register_info.support directly
Date:   Thu, 24 Sep 2020 16:24:39 +0200
Message-Id: <20200924142443.260861-4-refactormyself@gmail.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20200924142443.260861-1-refactormyself@gmail.com>
References: <20200924142443.260861-1-refactormyself@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

 - Calculate aspm_register_info.support inside aspm_support()
 - Replace references to aspm_register_info.support with aspm_support().
 - In pcie_get_aspm_reg() remove assignment to aspm_register_info.support
 - Remove aspm_register_info.support

Signed-off-by: Saheed O. Bolarinwa <refactormyself@gmail.com>
---
 drivers/pci/pcie/aspm.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 5f7cf47b6a40..321b328347c1 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -383,7 +383,6 @@ static void encode_l12_threshold(u32 threshold_us, u32 *scale, u32 *value)
 }
 
 struct aspm_register_info {
-	u32 support:2;
 	u32 enabled:2;
 
 	/* L1 substates */
@@ -396,12 +395,10 @@ struct aspm_register_info {
 static void pcie_get_aspm_reg(struct pci_dev *pdev,
 			      struct aspm_register_info *info)
 {
-	u16 reg16;
-	u32 reg32 = pdev->lnkcap;
+	u16 ctl;
 
-	info->support = (reg32 & PCI_EXP_LNKCAP_ASPMS) >> 10;
-	pcie_capability_read_word(pdev, PCI_EXP_LNKCTL, &reg16);
-	info->enabled = reg16 & PCI_EXP_LNKCTL_ASPMC;
+	pcie_capability_read_word(pdev, PCI_EXP_LNKCTL, &ctl);
+	info->enabled = ctl & PCI_EXP_LNKCTL_ASPMC;
 
 	/* Read L1 PM substate capabilities */
 	info->l1ss_cap = info->l1ss_ctl1 = info->l1ss_ctl2 = 0;
@@ -540,6 +537,11 @@ static void aspm_calc_l1ss_info(struct pcie_link_state *link,
 	link->l1ss.ctl1 |= t_common_mode << 8 | scale << 29 | value << 16;
 }
 
+static void aspm_support(struct pci_dev *pdev)
+{
+	return (pdev->lnkcap & PCI_EXP_LNKCAP_ASPMS) >> 10;
+}
+
 static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 {
 	struct pci_dev *child = link->downstream, *parent = link->pdev;
@@ -561,7 +563,7 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 	 * If ASPM not supported, don't mess with the clocks and link,
 	 * bail out now.
 	 */
-	if (!(upreg.support & dwreg.support))
+	if (!(aspm_support(parent) & aspm_support(child)))
 		return;
 
 	/* Configure common clock before checking latencies */
@@ -581,8 +583,9 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 	 * given link unless components on both sides of the link each
 	 * support L0s.
 	 */
-	if (dwreg.support & upreg.support & PCIE_LINK_STATE_L0S)
+	if (aspm_support(parent) & aspm_support(child) & PCIE_LINK_STATE_L0S)
 		link->aspm_support |= ASPM_STATE_L0S;
+
 	if (dwreg.enabled & PCIE_LINK_STATE_L0S)
 		link->aspm_enabled |= ASPM_STATE_L0S_UP;
 	if (upreg.enabled & PCIE_LINK_STATE_L0S)
@@ -591,8 +594,9 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 	link->latency_dw.l0s = calc_l0s_latency(child);
 
 	/* Setup L1 state */
-	if (upreg.support & dwreg.support & PCIE_LINK_STATE_L1)
+	if (aspm_support(parent) & aspm_support(child) & PCIE_LINK_STATE_L1)
 		link->aspm_support |= ASPM_STATE_L1;
+
 	if (upreg.enabled & dwreg.enabled & PCIE_LINK_STATE_L1)
 		link->aspm_enabled |= ASPM_STATE_L1;
 	link->latency_up.l1 = calc_l1_latency(parent);
-- 
2.18.4

