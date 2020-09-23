Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8A222764F4
	for <lists+linux-pci@lfdr.de>; Thu, 24 Sep 2020 02:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbgIXAPA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Sep 2020 20:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbgIXAPA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Sep 2020 20:15:00 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0968C0613CE
        for <linux-pci@vger.kernel.org>; Wed, 23 Sep 2020 17:14:59 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id gr14so2069225ejb.1
        for <linux-pci@vger.kernel.org>; Wed, 23 Sep 2020 17:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xMJO2Jcr81Kz6dNqWOWrAXyKpzQnQDDmiKEkvmDCFHs=;
        b=itAKrwDR7THUW5vb1fATAqPjIcciWQgvUdDbLWtiMxugPCGaqoklMz4l5vL5iAkJS8
         TAm6XOAvfXme6OwnipDWtroxYetRmJByQlBtYMlNaAf99pCO2Vq31WdORfsn+QO/Rwym
         tBfvpgbbNZ/I8QgTWxnrjH4GjKENr9B5tjm5bl4u/TlA4yWVEKGyq3/IY1QvifNM6khk
         b+N8GuRTnmFpILNRR1d/QD0xP3Rm9srxVQDtGdxNZXLK2GvdH4toWwAtVRo5mIEIao9x
         3K7zAatoM9kx1qA36EcEQ2vQjN++Xnzk94zmQ7JYqZway3QCZ2B4vqnwAnMfOZOClsoG
         7xoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xMJO2Jcr81Kz6dNqWOWrAXyKpzQnQDDmiKEkvmDCFHs=;
        b=gTbAyrFOE0/iURkHbYSG88eAxzHw43G5nGNN8D8t9yGFALQRfJaoqGG+4timDv8UNP
         AW7ZOzzS//YbwCTpv3vXhM9VhDTHizDEdul0ztXxyF176FCiJA5m8nbVxCwQ6cYigOjM
         fa0rtzsXk4VLWVC/MpcccBo7ULzW/gbABAuK7x4wNHDw7hmD99AO+Rmcstl+v2UxCHjF
         C7vix19gC1AluxiagM6sfwIQoMqOSGuwtDl/ff5U+rtjzEy6UlRn/eluhP5WGXqfzoyL
         kSeui324z5jhBykeuIFkjAa0IzAJmUZZ3lMAnmxDzbIS5+QZraV7NcF54iffC+eku5VQ
         sI4g==
X-Gm-Message-State: AOAM531dtND7uq0majrYtDFObbzFoqFNHOc7LLOEw8XB21hGB1izZiMm
        wWZIcplthiLwf5L/TG603iA=
X-Google-Smtp-Source: ABdhPJyL5fy5D0ORVZQiYxifw7L5iZjWhHi9DLAuojzfSwn2CIZ6UTP1Bh2/AiQU76IDgHpMqLCKUA==
X-Received: by 2002:a17:906:24d6:: with SMTP id f22mr2017448ejb.85.1600906498290;
        Wed, 23 Sep 2020 17:14:58 -0700 (PDT)
Received: from net.saheed (5402C65D.dsl.pool.telekom.hu. [84.2.198.93])
        by smtp.gmail.com with ESMTPSA id r9sm1026559ejc.102.2020.09.23.17.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 17:14:57 -0700 (PDT)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     helgaas@kernel.org
Cc:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH 8/8] PCI/ASPM: Remove struct pcie_link_state.l1ss
Date:   Thu, 24 Sep 2020 01:15:17 +0200
Message-Id: <20200923231517.221310-9-refactormyself@gmail.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20200923231517.221310-1-refactormyself@gmail.com>
References: <20200923231517.221310-1-refactormyself@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

pcie_link_state.l1ss.{up_cap_ptr, dw_cap_ptr} are used to cache the value
of l1ss_cap_ptr for upstream and downstream respectively. This value can
now be obtained directly from struct pci_dev, it is no longer useful to
cache it. So, aspm_calc_l1ss_info() will only be computing the values for
ctl1 and ctl2. The addresses of these can also be passed in.

Then if aspm_calc_l1ss_info() calculates pcie_link_state.l1ss.{ctl1, ctl2}
which are only used inside pcie_config_aspm_l1ss(). Calling the function
where it is needed will remove the need to cache the values in the struct.

 - Move call to aspm_calc_l1ss_info() from pcie_aspm_cap_init() to
   pcie_config_aspm_l1ss().
 - Rename aspm_calc_l1ss_info() to aspm_calc_l1ss_ctl_values().
 - Rework the function to take a pci_dev and pointers to ctl1 and ctl2.
 - Change calls to aspm_calc_l1ss_info() into new function.
 - Replace l1ss.{up,dw}_cap_ptr with pci_dev->l1ss_cap_ptr
 - Replace pcie_link_state.l1ss.{ctl1, ctl2} with local variables.
 - No more reference to struct pcie_link_state.l1ss, so remove it.
 - Remove pcie_link_state.l1ss

Signed-off-by: Saheed O. Bolarinwa <refactormyself@gmail.com>
---
 drivers/pci/pcie/aspm.c | 45 ++++++++++++++---------------------------
 1 file changed, 15 insertions(+), 30 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index f4fc2d65240c..b9bacdef8c80 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -74,14 +74,6 @@ struct pcie_link_state {
 	 * has one slot under it, so at most there are 8 functions.
 	 */
 	struct aspm_latency acceptable[8];
-
-	/* L1 PM Substate info */
-	struct {
-		u32 up_cap_ptr;		/* L1SS cap ptr in upstream dev */
-		u32 dw_cap_ptr;		/* L1SS cap ptr in downstream dev */
-		u32 ctl1;		/* value to be programmed in ctl1 */
-		u32 ctl2;		/* value to be programmed in ctl2 */
-	} l1ss;
 };
 
 static int aspm_disabled, aspm_force;
@@ -444,17 +436,15 @@ static struct pci_dev *pci_function_0(struct pci_bus *linkbus)
 }
 
 /* Calculate L1.2 PM substate timing parameters */
-static void aspm_calc_l1ss_info(struct pcie_link_state *link)
+static void aspm_calc_l1ss_ctl_values(struct pci_dev *pdev,
+					u32 *ctl1, u32 *ctl2)
 {
+	struct pcie_link_state *link = pdev->link_state;
 	u32 val1, val2, scale1, scale2;
 	u32 t_common_mode, t_power_on, l1_2_threshold, scale, value;
 	struct pci_dev *dw_pdev = link->downstream;
 	struct pci_dev *up_pdev = link->pdev;
 
-	link->l1ss.up_cap_ptr = up_pdev->l1ss_cap_ptr;
-	link->l1ss.dw_cap_ptr = dw_pdev->l1ss_cap_ptr;
-	link->l1ss.ctl1 = link->l1ss.ctl2 = 0;
-
 	if (!(link->aspm_support & ASPM_STATE_L1_2_MASK))
 		return;
 
@@ -471,10 +461,10 @@ static void aspm_calc_l1ss_info(struct pcie_link_state *link)
 
 	if (calc_l1ss_pwron(up_pdev, scale1, val1) >
 	    calc_l1ss_pwron(dw_pdev, scale2, val2)) {
-		link->l1ss.ctl2 |= scale1 | (val1 << 3);
+		*ctl2 |= scale1 | (val1 << 3);
 		t_power_on = calc_l1ss_pwron(up_pdev, scale1, val1);
 	} else {
-		link->l1ss.ctl2 |= scale2 | (val2 << 3);
+		*ctl2 |= scale2 | (val2 << 3);
 		t_power_on = calc_l1ss_pwron(dw_pdev, scale2, val2);
 	}
 
@@ -490,7 +480,7 @@ static void aspm_calc_l1ss_info(struct pcie_link_state *link)
 	 */
 	l1_2_threshold = 2 + 4 + t_common_mode + t_power_on;
 	encode_l12_threshold(l1_2_threshold, &scale, &value);
-	link->l1ss.ctl1 |= t_common_mode << 8 | scale << 29 | value << 16;
+	*ctl1 |= t_common_mode << 8 | scale << 29 | value << 16;
 }
 
 static void aspm_support(struct pci_dev *pdev)
@@ -580,9 +570,6 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 	if (up_l1ss_ctl1 & dw_l1ss_ctl1 & PCI_L1SS_CTL1_PCIPM_L1_2)
 		link->aspm_enabled |= ASPM_STATE_L1_2_PCIPM;
 
-	if (link->aspm_support & ASPM_STATE_L1SS)
-		aspm_calc_l1ss_info(link);
-
 	/* Save default state */
 	link->aspm_default = link->aspm_enabled;
 
@@ -625,12 +612,13 @@ static void pci_clear_and_set_dword(struct pci_dev *pdev, int pos,
 /* Configure the ASPM L1 substates */
 static void pcie_config_aspm_l1ss(struct pcie_link_state *link, u32 state)
 {
-	u32 val, enable_req;
+	u32 val, enable_req, ctl1, ctl2;
 	struct pci_dev *child = link->downstream, *parent = link->pdev;
-	u32 up_cap_ptr = link->l1ss.up_cap_ptr;
-	u32 dw_cap_ptr = link->l1ss.dw_cap_ptr;
+	int up_cap_ptr = parent->l1ss_cap_ptr;
+	int dw_cap_ptr = child->l1ss_cap_ptr;
 
 	enable_req = (link->aspm_enabled ^ state) & state;
+	aspm_calc_l1ss_ctl_values(parent, &ctl1, &ctl2);
 
 	/*
 	 * Here are the rules specified in the PCIe spec for enabling L1SS:
@@ -665,24 +653,21 @@ static void pcie_config_aspm_l1ss(struct pcie_link_state *link, u32 state)
 
 		/* Program T_POWER_ON times in both ports */
 		pci_write_config_dword(parent, up_cap_ptr + PCI_L1SS_CTL2,
-				       link->l1ss.ctl2);
+								ctl2);
 		pci_write_config_dword(child, dw_cap_ptr + PCI_L1SS_CTL2,
-				       link->l1ss.ctl2);
+								ctl2);
 
 		/* Program Common_Mode_Restore_Time in upstream device */
 		pci_clear_and_set_dword(parent, up_cap_ptr + PCI_L1SS_CTL1,
-					PCI_L1SS_CTL1_CM_RESTORE_TIME,
-					link->l1ss.ctl1);
+					PCI_L1SS_CTL1_CM_RESTORE_TIME, ctl1);
 
 		/* Program LTR_L1.2_THRESHOLD time in both ports */
 		pci_clear_and_set_dword(parent,	up_cap_ptr + PCI_L1SS_CTL1,
 					PCI_L1SS_CTL1_LTR_L12_TH_VALUE |
-					PCI_L1SS_CTL1_LTR_L12_TH_SCALE,
-					link->l1ss.ctl1);
+					PCI_L1SS_CTL1_LTR_L12_TH_SCALE, ctl1);
 		pci_clear_and_set_dword(child, dw_cap_ptr + PCI_L1SS_CTL1,
 					PCI_L1SS_CTL1_LTR_L12_TH_VALUE |
-					PCI_L1SS_CTL1_LTR_L12_TH_SCALE,
-					link->l1ss.ctl1);
+					PCI_L1SS_CTL1_LTR_L12_TH_SCALE, ctl1);
 	}
 
 	val = 0;
-- 
2.18.4

