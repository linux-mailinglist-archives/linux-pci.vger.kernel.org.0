Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30B83277531
	for <lists+linux-pci@lfdr.de>; Thu, 24 Sep 2020 17:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728472AbgIXPYS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Sep 2020 11:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728285AbgIXPYS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Sep 2020 11:24:18 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CC28C0613CE
        for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2020 08:24:18 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id i1so3813243edv.2
        for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2020 08:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jnTqkMfg+pF303Rlza2fs/WGjR363sRc72ZJW6h8OKQ=;
        b=t04CsfL6CqOV0vgChqvejovaW8e0Cn9+EYyl5tGe+2bUJAP063LIYx4s7nf6TbW7Mk
         9pJLF50FDkkPFYel2Y26ue50IvbVvYDtO+sZm1wWPPWFIAc1VkwJ5pL+7pj+hiZGAilD
         PWx4vZPS/6YzMrdDl/mm4qzlbRcNUNdVSpcGkid1xK5seWeQphPBd6wHW2aTWyt4Vuz0
         vazBfw7OUFHADm/XcniKMxQui+gsPKGRd+yH/QAWNb/w/kBrA8WpW9vYwB1sGq7NVz7U
         il1XotF5O+r5wGTFPcbl7LgVhhbgJ2gu0HSoLHw0yzAz56VbujHy0BEG7PxwqA1L2Y/d
         yH2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jnTqkMfg+pF303Rlza2fs/WGjR363sRc72ZJW6h8OKQ=;
        b=Uf8kxMYKAu8kPYdRwKava1/7QlPsX99L6eqoA78PcIWd5B+vIntc0x4azL6/SIstbj
         u0D9BYQ8LJ1lzdXgt5HOTVrBu8qg2hEUuxJXfKNJdLNeB63uir29oIYmSdOovl/xjGST
         Cy/qFI3HzQjGLMpEGBOLN25VO16haFcMx0chW15AnBkTNsvPCxQ5APjA9Fw8xS5jiB4w
         7SEzWVsYOlR7ns1dSTechYgFNP9C4pbAHZKoZQnOEp0B16wU3X+OLS39WJ2cJgZQIim2
         7jNjS7z/+ZllXXFgAJvlMgPUq4lJRQuCcD9GviIkTySSme/GROf4uP9T1EOpDL4P9d4J
         /gHg==
X-Gm-Message-State: AOAM530VXBgYHdeXMhleUMzqHXSmrbpV89QwOUe2KTRtW8zN8mbbrAh9
        5FOnFN0Slc3PWtVYygaYSaE=
X-Google-Smtp-Source: ABdhPJzUGOHX6ijc5vd0lkVgvTrvx8RNXvD1Jkf5oX28zV/PrUulWQg5XfGQvYL81Krn+tPossyqSQ==
X-Received: by 2002:a50:9355:: with SMTP id n21mr401286eda.237.1600961056809;
        Thu, 24 Sep 2020 08:24:16 -0700 (PDT)
Received: from net.saheed (5402C65D.dsl.pool.telekom.hu. [84.2.198.93])
        by smtp.gmail.com with ESMTPSA id i7sm2641735ejo.22.2020.09.24.08.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 08:24:16 -0700 (PDT)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     helgaas@kernel.org
Cc:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH v2 4/7] PCI/ASPM: Replace aspm_register_info.l1ss_cap*
Date:   Thu, 24 Sep 2020 16:24:40 +0200
Message-Id: <20200924142443.260861-5-refactormyself@gmail.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20200924142443.260861-1-refactormyself@gmail.com>
References: <20200924142443.260861-1-refactormyself@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

 - Add l1ss_cap and l1ss_cap_ptr to struct pci_dev
 - In pci_configure_ltr(), compute the value of pci_dev.l1ss_cap
   and pci_dev.l1ss_cap_ptr
 - Replace all references to aspm_register_info.(l1ss_cap && l1ss_cap_ptr)
   with pci_dev.(l1ss_cap && l1ss_cap_ptr)
 - Remove the now redundant parameters of aspm_calc_l1ss_info()
 - Change callers of aspm_calc_l1ss_info() to use the new signature
 - In pcie_get_aspm_reg() remove reference to aspm_register_info.l1ss_cap*
 - In pcie_get_aspm_reg() remove reading of l1ss_cap_ptr and l1ss_cap
 - Remove aspm_register_info.(l1ss_cap && l1ss_cap_ptr)

Signed-off-by: Saheed O. Bolarinwa <refactormyself@gmail.com>
---
 drivers/pci/pcie/aspm.c | 62 +++++++++++++----------------------------
 drivers/pci/probe.c     |  6 ++++
 include/linux/pci.h     |  2 ++
 3 files changed, 28 insertions(+), 42 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 321b328347c1..e7bb7d069361 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -386,8 +386,6 @@ struct aspm_register_info {
 	u32 enabled:2;
 
 	/* L1 substates */
-	u32 l1ss_cap_ptr;
-	u32 l1ss_cap;
 	u32 l1ss_ctl1;
 	u32 l1ss_ctl2;
 };
@@ -400,26 +398,6 @@ static void pcie_get_aspm_reg(struct pci_dev *pdev,
 	pcie_capability_read_word(pdev, PCI_EXP_LNKCTL, &ctl);
 	info->enabled = ctl & PCI_EXP_LNKCTL_ASPMC;
 
-	/* Read L1 PM substate capabilities */
-	info->l1ss_cap = info->l1ss_ctl1 = info->l1ss_ctl2 = 0;
-	info->l1ss_cap_ptr = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_L1SS);
-	if (!info->l1ss_cap_ptr)
-		return;
-	pci_read_config_dword(pdev, info->l1ss_cap_ptr + PCI_L1SS_CAP,
-			      &info->l1ss_cap);
-	if (!(info->l1ss_cap & PCI_L1SS_CAP_L1_PM_SS)) {
-		info->l1ss_cap = 0;
-		return;
-	}
-
-	/*
-	 * If we don't have LTR for the entire path from the Root Complex
-	 * to this device, we can't use ASPM L1.2 because it relies on the
-	 * LTR_L1.2_THRESHOLD.  See PCIe r4.0, secs 5.5.4, 6.18.
-	 */
-	if (!pdev->ltr_path)
-		info->l1ss_cap &= ~PCI_L1SS_CAP_ASPM_L1_2;
-
 	pci_read_config_dword(pdev, info->l1ss_cap_ptr + PCI_L1SS_CTL1,
 			      &info->l1ss_ctl1);
 	pci_read_config_dword(pdev, info->l1ss_cap_ptr + PCI_L1SS_CTL2,
@@ -488,38 +466,38 @@ static struct pci_dev *pci_function_0(struct pci_bus *linkbus)
 }
 
 /* Calculate L1.2 PM substate timing parameters */
-static void aspm_calc_l1ss_info(struct pcie_link_state *link,
-				struct aspm_register_info *upreg,
-				struct aspm_register_info *dwreg)
+static void aspm_calc_l1ss_info(struct pcie_link_state *link)
 {
 	u32 val1, val2, scale1, scale2;
 	u32 t_common_mode, t_power_on, l1_2_threshold, scale, value;
+	struct pci_dev *dw_pdev = link->downstream;
+	struct pci_dev *up_pdev = link->pdev;
 
-	link->l1ss.up_cap_ptr = upreg->l1ss_cap_ptr;
-	link->l1ss.dw_cap_ptr = dwreg->l1ss_cap_ptr;
+	link->l1ss.up_cap_ptr = up_pdev->l1ss_cap_ptr;
+	link->l1ss.dw_cap_ptr = dw_pdev->l1ss_cap_ptr;
 	link->l1ss.ctl1 = link->l1ss.ctl2 = 0;
 
 	if (!(link->aspm_support & ASPM_STATE_L1_2_MASK))
 		return;
 
 	/* Choose the greater of the two Port Common_Mode_Restore_Times */
-	val1 = (upreg->l1ss_cap & PCI_L1SS_CAP_CM_RESTORE_TIME) >> 8;
-	val2 = (dwreg->l1ss_cap & PCI_L1SS_CAP_CM_RESTORE_TIME) >> 8;
+	val1 = (up_pdev->l1ss_cap & PCI_L1SS_CAP_CM_RESTORE_TIME) >> 8;
+	val2 = (dw_pdev->l1ss_cap & PCI_L1SS_CAP_CM_RESTORE_TIME) >> 8;
 	t_common_mode = max(val1, val2);
 
 	/* Choose the greater of the two Port T_POWER_ON times */
-	val1   = (upreg->l1ss_cap & PCI_L1SS_CAP_P_PWR_ON_VALUE) >> 19;
-	scale1 = (upreg->l1ss_cap & PCI_L1SS_CAP_P_PWR_ON_SCALE) >> 16;
-	val2   = (dwreg->l1ss_cap & PCI_L1SS_CAP_P_PWR_ON_VALUE) >> 19;
-	scale2 = (dwreg->l1ss_cap & PCI_L1SS_CAP_P_PWR_ON_SCALE) >> 16;
+	val1   = (up_pdev->l1ss_cap & PCI_L1SS_CAP_P_PWR_ON_VALUE) >> 19;
+	scale1 = (up_pdev->l1ss_cap & PCI_L1SS_CAP_P_PWR_ON_SCALE) >> 16;
+	val2   = (dw_pdev->l1ss_cap & PCI_L1SS_CAP_P_PWR_ON_VALUE) >> 19;
+	scale2 = (dw_pdev->l1ss_cap & PCI_L1SS_CAP_P_PWR_ON_SCALE) >> 16;
 
-	if (calc_l1ss_pwron(link->pdev, scale1, val1) >
-	    calc_l1ss_pwron(link->downstream, scale2, val2)) {
+	if (calc_l1ss_pwron(up_pdev, scale1, val1) >
+	    calc_l1ss_pwron(dw_pdev, scale2, val2)) {
 		link->l1ss.ctl2 |= scale1 | (val1 << 3);
-		t_power_on = calc_l1ss_pwron(link->pdev, scale1, val1);
+		t_power_on = calc_l1ss_pwron(up_pdev, scale1, val1);
 	} else {
 		link->l1ss.ctl2 |= scale2 | (val2 << 3);
-		t_power_on = calc_l1ss_pwron(link->downstream, scale2, val2);
+		t_power_on = calc_l1ss_pwron(dw_pdev, scale2, val2);
 	}
 
 	/*
@@ -603,13 +581,13 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 	link->latency_dw.l1 = calc_l1_latency(child);
 
 	/* Setup L1 substate */
-	if (upreg.l1ss_cap & dwreg.l1ss_cap & PCI_L1SS_CAP_ASPM_L1_1)
+	if (parent->l1ss_cap & child->l1ss_cap & PCI_L1SS_CAP_ASPM_L1_1)
 		link->aspm_support |= ASPM_STATE_L1_1;
-	if (upreg.l1ss_cap & dwreg.l1ss_cap & PCI_L1SS_CAP_ASPM_L1_2)
+	if (parent->l1ss_cap & child->l1ss_cap & PCI_L1SS_CAP_ASPM_L1_2)
 		link->aspm_support |= ASPM_STATE_L1_2;
-	if (upreg.l1ss_cap & dwreg.l1ss_cap & PCI_L1SS_CAP_PCIPM_L1_1)
+	if (parent->l1ss_cap & child->l1ss_cap & PCI_L1SS_CAP_PCIPM_L1_1)
 		link->aspm_support |= ASPM_STATE_L1_1_PCIPM;
-	if (upreg.l1ss_cap & dwreg.l1ss_cap & PCI_L1SS_CAP_PCIPM_L1_2)
+	if (parent->l1ss_cap & child->l1ss_cap & PCI_L1SS_CAP_PCIPM_L1_2)
 		link->aspm_support |= ASPM_STATE_L1_2_PCIPM;
 
 	if (upreg.l1ss_ctl1 & dwreg.l1ss_ctl1 & PCI_L1SS_CTL1_ASPM_L1_1)
@@ -622,7 +600,7 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 		link->aspm_enabled |= ASPM_STATE_L1_2_PCIPM;
 
 	if (link->aspm_support & ASPM_STATE_L1SS)
-		aspm_calc_l1ss_info(link, &upreg, &dwreg);
+		aspm_calc_l1ss_info(link);
 
 	/* Save default state */
 	link->aspm_default = link->aspm_enabled;
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 2d5898f05f89..71a714065e14 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2107,6 +2107,12 @@ static void pci_configure_ltr(struct pci_dev *dev)
 	if (!pci_is_pcie(dev))
 		return;
 
+	/* Read L1 PM substate capabilities */
+	dev->l1ss_cap_ptr = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_L1SS);
+	if (dev->l1ss_cap_ptr)
+		pci_read_config_dword(dev, dev->l1ss_cap_ptr + PCI_L1SS_CAP,
+								&dev->l1ss_cap);
+
 	pcie_capability_read_dword(dev, PCI_EXP_DEVCAP2, &cap);
 	if (!(cap & PCI_EXP_DEVCAP2_LTR))
 		return;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 5b305cfeb1dc..60b82e255738 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -381,6 +381,8 @@ struct pci_dev {
 	struct pcie_link_state	*link_state;	/* ASPM link state */
 	unsigned int	ltr_path:1;	/* Latency Tolerance Reporting
 					   supported from root to here */
+	int		l1ss_cap_ptr;	/* L1SS cap ptr, 0 if not supported */
+	u32		l1ss_cap;	/* L1 PM substate Capabilities */
 #endif
 	unsigned int	eetlp_prefix_path:1;	/* End-to-End TLP Prefix */
 
-- 
2.18.4

