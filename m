Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A255C2764F1
	for <lists+linux-pci@lfdr.de>; Thu, 24 Sep 2020 02:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbgIXAO4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Sep 2020 20:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbgIXAO4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Sep 2020 20:14:56 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FCD9C0613CE
        for <linux-pci@vger.kernel.org>; Wed, 23 Sep 2020 17:14:56 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id c8so1573385edv.5
        for <linux-pci@vger.kernel.org>; Wed, 23 Sep 2020 17:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=O+0gCUfQpKBUTZFJZ24lqInCxl7vB/u2IOYQOf88Jsc=;
        b=YkeTw4l2Jzj7Y+mdMx3atKr87ltA0i3jawk+/mzTnbNO4Y/+4ByxH/qOGx4qqTXHt4
         Mf2qy6Jp8obd6pjmGUV9DW/QZvR8r8imVXV+vvIoFqYHH0VdfEDY02tug1kZ+NS0Dwxd
         0ysD27FBC86BXf76LQ3B6rVRsFy+9bRMGtJc8bIUC+sSsSL+Z5LYfGxDKK1zFsV2pTas
         NIelwBS4RE4QA6NU5nZfbuKN2hg43eEN7szEJCnQqdkTIYfP82ysG/g4ZxxNiZRYtRR9
         vHREFdLaIliYRiotfh39GlMPMu1qQGv3DsVvNb3z397ckZHabQgBc0FxW/fxoqdZ33wv
         1W1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=O+0gCUfQpKBUTZFJZ24lqInCxl7vB/u2IOYQOf88Jsc=;
        b=Xag0y7pzmbsXzHnmxcsBUTDgEuv3c1aaQc2RRaqJvKrgmgiy31RJquMS7FnILEFqSV
         zgDoT1B13UQDFS07TCx9zXOTxVlzH1Y4/Tu5DpC9+CjG+xy4r8u+YvpU6NjGCkMvSiao
         uOX3L9WsmUFwdEqzfybJ+ioScFC6j+Mx3ZctEQVl+IPW6OraE6IOh3tkCxScVfAUmUIP
         2SRYe6LawGeL9E4p0/VDvZDdcfrPJSWdXAfubif8DIDkgS5U7PN1onbJpojrTkVES6TH
         +B5C638Q+cORvr3uqg7+FBN9bP7+1uFSTzMZ9j312DEEpLz4NyJsT+ZwzDJxX0ypNKEp
         UN7Q==
X-Gm-Message-State: AOAM531U6vQ1D28F2GobKOpp6VWTfs3zhmFuEu5lihIJoSvSvEfDGtu5
        6dKoxQ0VM3XV7M+BEtRSC/c=
X-Google-Smtp-Source: ABdhPJybcPeoGa/wiD3AQmA9+zk9TM9JHF4dPs0DOhEn3WOZpcAhoDJ8NXySsSssOifcQ33UIExwXw==
X-Received: by 2002:a05:6402:a51:: with SMTP id bt17mr1975328edb.186.1600906494843;
        Wed, 23 Sep 2020 17:14:54 -0700 (PDT)
Received: from net.saheed (5402C65D.dsl.pool.telekom.hu. [84.2.198.93])
        by smtp.gmail.com with ESMTPSA id r9sm1026559ejc.102.2020.09.23.17.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 17:14:54 -0700 (PDT)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     helgaas@kernel.org
Cc:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH 5/8] PCI/ASPM: Remove aspm_register_info.l1ss_ctl*
Date:   Thu, 24 Sep 2020 01:15:14 +0200
Message-Id: <20200923231517.221310-6-refactormyself@gmail.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20200923231517.221310-1-refactormyself@gmail.com>
References: <20200923231517.221310-1-refactormyself@gmail.com>
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
index d3ad31a230b5..f89d3b2be1c7 100644
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
@@ -527,6 +518,7 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 	struct pci_dev *child = link->downstream, *parent = link->pdev;
 	struct pci_bus *linkbus = parent->subordinate;
 	struct aspm_register_info upreg, dwreg;
+	u32 up_l1ss_ctl1, dw_l1ss_ctl1;
 
 	if (blacklist) {
 		/* Set enabled/disable so that we will disable ASPM later */
@@ -549,6 +541,11 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
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
@@ -592,13 +589,13 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
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

