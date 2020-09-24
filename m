Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4EC6277534
	for <lists+linux-pci@lfdr.de>; Thu, 24 Sep 2020 17:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728477AbgIXPYW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Sep 2020 11:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728285AbgIXPYV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Sep 2020 11:24:21 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95BD2C0613CE
        for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2020 08:24:21 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id i26so4992519ejb.12
        for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2020 08:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xMJO2Jcr81Kz6dNqWOWrAXyKpzQnQDDmiKEkvmDCFHs=;
        b=Ai+qomzHryUak3qCEKjPhRTmdAZzCRHmAS9fwQb//1U/R6bgpREkF7WjbcfBqC7mIm
         D3IjdTFb8N1xqD6wJjmHuydHeYll5gUubapCDz2U4lAEBGhaEH/eq/Z+DgFKZIiFRYMd
         BQJXsCn7w2Zmpg1IGYFqqopAZdw4To+0LxWeZ+PUr4NKuvwjgNj8hhFa3U3Q4hvF5t6x
         GZSD9nP+yvrEZbOsWyKlazy5l5wZPnBx+oBANlN6lFZefV/Mj5Z1FZDIoNyFjE13+mrL
         tKBtHnOSP+1lTgluVMoxVwluAQN1ZCJ6pULv63xw5GaRlsCDv7Du/GJ3mb0qUUVEpFMv
         8IsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xMJO2Jcr81Kz6dNqWOWrAXyKpzQnQDDmiKEkvmDCFHs=;
        b=GxQaqrtBNqFrHbfFQhcC8ZO8Xoi2qvKl7mJciRoeILOSHVUOieDP5DITQ2muHbJ/PW
         cOD/jcIazc/HbbKYoQRvuvaFGwdBhUfreiKqgP5BmadschuHy8r5qV16IePVx/gjQ5eh
         8sw6KSWc2U6gV9V9ZCTKtev6tHTO8lWXkKGTNlyn0yQxh2ECfJ4M+Me8FHm8+kAH4JUq
         mwLd8TF3Ue7mIJOXBoouN7gYLp5tSa0cwQvrJy+b/A2sceEQ5SexYFJLmT/u0gRCyahr
         z3xdNDuujGVCP6cKuT0gmR3CEpit0Aqoq7FtveTcEga373qo7csnq73btt6+9VGw30em
         m48g==
X-Gm-Message-State: AOAM533df+ViFkwbQddU3qG15d3R05MNjl5oatdgZVUraKzXcjP2ONcz
        dMdlN3YUlDOckcyB0rAUfwo=
X-Google-Smtp-Source: ABdhPJyr3o70yaaIRhFU/Bf1wEyoZ0FvkhavhFsy6hlE1QJCaOtoUJzirg2aGjZtU/82omUgheJSdg==
X-Received: by 2002:a17:906:30c7:: with SMTP id b7mr427048ejb.7.1600961060229;
        Thu, 24 Sep 2020 08:24:20 -0700 (PDT)
Received: from net.saheed (5402C65D.dsl.pool.telekom.hu. [84.2.198.93])
        by smtp.gmail.com with ESMTPSA id i7sm2641735ejo.22.2020.09.24.08.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 08:24:19 -0700 (PDT)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     helgaas@kernel.org
Cc:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH v2 7/7] PCI/ASPM: Remove struct pcie_link_state.l1ss
Date:   Thu, 24 Sep 2020 16:24:43 +0200
Message-Id: <20200924142443.260861-8-refactormyself@gmail.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20200924142443.260861-1-refactormyself@gmail.com>
References: <20200924142443.260861-1-refactormyself@gmail.com>
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

