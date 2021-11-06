Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B70F446F85
	for <lists+linux-pci@lfdr.de>; Sat,  6 Nov 2021 18:54:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234741AbhKFR4m (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 6 Nov 2021 13:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234716AbhKFR4l (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 6 Nov 2021 13:56:41 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42011C061570;
        Sat,  6 Nov 2021 10:54:00 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id v11so42170428edc.9;
        Sat, 06 Nov 2021 10:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+AmIfT2U8zaxI4/8+Onr8HNn9TQ7SRU0ccQVrxGOsI0=;
        b=Jm5JzxB22xE3gjz5poX7ZGPbpgZi7v8ejFMyV/QTrYo97vKYACgfGzbE7sxIz3Y+/j
         E23VqlIziB8y18C7gWEI1T5ydmUdyDKv4bD6ZgZeD3diDRzJ4Bno2Gacq+tB4zg5zMte
         CwidWkBH/BDemsS8CG7s8CMzRuIqIfwIE5tT7jHp5CRwTHJ9DfDyS+1eYe8sWJMWWWVW
         R7YWIm5SPmvmsYmP6bT5VX7Ln+Apw/0iGRTdJJn7lZndO/l2FRjgiptMyQVOcW10Zblv
         YY7mm9n+E++8mQSfbqZ43J7BIGj6TqgzR2sBjrh6bOaC2ru8OhMYia5FxtHudAwVarud
         HyNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+AmIfT2U8zaxI4/8+Onr8HNn9TQ7SRU0ccQVrxGOsI0=;
        b=VrDdanqX9Amj7zGFnes0iWR1n539DgBRY1tCNyya4lC3j4MeA+5uzlNlDRuMVNH+Ay
         ENP4cqq40MQlxhNA8jIwelonCMpzrgimZa0wCWvUK+qm82VX9yhc3IYW6YbcHjYXhgrU
         sd5JkXRnYUpum/Nxd4p6166oTU0cfI0zCGYAcDUs8z59bb15Y2QUbuWjkMOTrCWovlqJ
         73fXoSHjNeI5jnT30FIcDmd0VyKDhkiPWokapbLuPGT+mdJQQ35Xxi1v74B74GVDMNSd
         c+4mo7ChszdYpHWS3Esevio8UJi4Tp7SoCNSbxIYsQx2tbZkizEoS2GuTI0wZfQrVuGf
         Dm/A==
X-Gm-Message-State: AOAM533YC+0pYd8TFSZdw1CQzSrD9C/Dg56Cf0ZQ4yCtMh5UXtXLOxZ7
        HhnbfHv6sLUJFF9rdh1eXHQ=
X-Google-Smtp-Source: ABdhPJy5sQI8KXzuOpcgUb6bH+YKrtAotFx+6RaJnOsvXvEG98nTOBSymzzgvSs/P6Hn69poPxiEDg==
X-Received: by 2002:a50:da42:: with SMTP id a2mr86768450edk.361.1636221238641;
        Sat, 06 Nov 2021 10:53:58 -0700 (PDT)
Received: from localhost.localdomain ([2a02:ab88:109:9f0:f6a6:7fbe:807a:e1cc])
        by smtp.googlemail.com with ESMTPSA id m12sm5753494ejj.63.2021.11.06.10.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Nov 2021 10:53:58 -0700 (PDT)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     helgaas@kernel.org
Cc:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 2/6] PCI/ASPM: Extract the calculation of link->aspm_support
Date:   Sat,  6 Nov 2021 18:53:49 +0100
Message-Id: <20211106175353.26248-3-refactormyself@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211106175353.26248-1-refactormyself@gmail.com>
References: <20211106175353.26248-1-refactormyself@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

struct pcie_link_state->aspm_support hold the initial capable
state of the link. This value is calculated inside
pcie_aspm_init_cap(). Isolating this calculation will simplify
pcie_aspm_init_cap().

Extract the calculation of link->aspm_support into
aspm_calc_init_linkcap().

Signed-off-by: Saheed O. Bolarinwa <refactormyself@gmail.com>
---
 drivers/pci/pcie/aspm.c | 60 ++++++++++++++++++++++++-----------------
 1 file changed, 35 insertions(+), 25 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 057c6768fb7b..23441a32f604 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -564,6 +564,33 @@ static void aspm_calc_both_l1ss_caps(struct pcie_link_state *link,
 		*dwn_l1ss_cap &= ~PCI_L1SS_CAP_ASPM_L1_2;
 }
 
+static u32 aspm_calc_init_linkcap(u32 up_lnkcap, u32 dwn_lnkcap,
+				  u32 up_l1ss_cap, u32 dwn_l1ss_cap)
+{
+	u32 link_cap = 0;
+
+	/*
+	 * Note that we must not enable L0s in either direction on a
+	 * given link unless components on both sides of the link each
+	 * support L0s.
+	 */
+	if (up_lnkcap & dwn_lnkcap & PCI_EXP_LNKCAP_ASPM_L0S)
+		link_cap |= ASPM_STATE_L0S;
+
+	if (up_lnkcap & dwn_lnkcap & PCI_EXP_LNKCAP_ASPM_L1)
+		link_cap |= ASPM_STATE_L1;
+	if (up_l1ss_cap & dwn_l1ss_cap & PCI_L1SS_CAP_ASPM_L1_1)
+		link_cap |= ASPM_STATE_L1_1;
+	if (up_l1ss_cap & dwn_l1ss_cap & PCI_L1SS_CAP_ASPM_L1_2)
+		link_cap |= ASPM_STATE_L1_2;
+	if (up_l1ss_cap & dwn_l1ss_cap & PCI_L1SS_CAP_PCIPM_L1_1)
+		link_cap |= ASPM_STATE_L1_1_PCIPM;
+	if (up_l1ss_cap & dwn_l1ss_cap & PCI_L1SS_CAP_PCIPM_L1_2)
+		link_cap |= ASPM_STATE_L1_2_PCIPM;
+
+	return link_cap;
+}
+
 static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 {
 	struct pci_dev *child = link->downstream, *parent = link->pdev;
@@ -603,16 +630,7 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 	pcie_capability_read_word(parent, PCI_EXP_LNKCTL, &parent_lnkctl);
 	pcie_capability_read_word(child, PCI_EXP_LNKCTL, &child_lnkctl);
 
-	/*
-	 * Setup L0s state
-	 *
-	 * Note that we must not enable L0s in either direction on a
-	 * given link unless components on both sides of the link each
-	 * support L0s.
-	 */
-	if (parent_lnkcap & child_lnkcap & PCI_EXP_LNKCAP_ASPM_L0S)
-		link->aspm_support |= ASPM_STATE_L0S;
-
+	/* Setup L0s state */
 	if (child_lnkctl & PCI_EXP_LNKCTL_ASPM_L0S)
 		link->aspm_enabled |= ASPM_STATE_L0S_UP;
 	if (parent_lnkctl & PCI_EXP_LNKCTL_ASPM_L0S)
@@ -621,9 +639,6 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 	link->latency_dw.l0s = calc_l0s_latency(child_lnkcap);
 
 	/* Setup L1 state */
-	if (parent_lnkcap & child_lnkcap & PCI_EXP_LNKCAP_ASPM_L1)
-		link->aspm_support |= ASPM_STATE_L1;
-
 	if (parent_lnkctl & child_lnkctl & PCI_EXP_LNKCTL_ASPM_L1)
 		link->aspm_enabled |= ASPM_STATE_L1;
 	link->latency_up.l1 = calc_l1_latency(parent_lnkcap);
@@ -632,15 +647,6 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 	/* Setup L1 substate */
 	aspm_calc_both_l1ss_caps(link, &parent_l1ss_cap, &child_l1ss_cap);
 
-	if (parent_l1ss_cap & child_l1ss_cap & PCI_L1SS_CAP_ASPM_L1_1)
-		link->aspm_support |= ASPM_STATE_L1_1;
-	if (parent_l1ss_cap & child_l1ss_cap & PCI_L1SS_CAP_ASPM_L1_2)
-		link->aspm_support |= ASPM_STATE_L1_2;
-	if (parent_l1ss_cap & child_l1ss_cap & PCI_L1SS_CAP_PCIPM_L1_1)
-		link->aspm_support |= ASPM_STATE_L1_1_PCIPM;
-	if (parent_l1ss_cap & child_l1ss_cap & PCI_L1SS_CAP_PCIPM_L1_2)
-		link->aspm_support |= ASPM_STATE_L1_2_PCIPM;
-
 	if (parent_l1ss_cap)
 		pci_read_config_dword(parent, parent->l1ss + PCI_L1SS_CTL1,
 				      &parent_l1ss_ctl1);
@@ -657,12 +663,16 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 	if (parent_l1ss_ctl1 & child_l1ss_ctl1 & PCI_L1SS_CTL1_PCIPM_L1_2)
 		link->aspm_enabled |= ASPM_STATE_L1_2_PCIPM;
 
-	if (link->aspm_support & ASPM_STATE_L1SS)
-		aspm_calc_l1ss_info(link, parent_l1ss_cap, child_l1ss_cap);
-
 	/* Save default state */
 	link->aspm_default = link->aspm_enabled;
 
+	link->aspm_support = aspm_calc_init_linkcap(parent_lnkcap,
+						    child_lnkcap,
+						    parent_l1ss_cap,
+						    child_l1ss_cap);
+	if (link->aspm_support & ASPM_STATE_L1SS)
+		aspm_calc_l1ss_info(link, parent_l1ss_cap, child_l1ss_cap);
+
 	/* Setup initial capable state. Will be updated later */
 	link->aspm_capable = link->aspm_support;
 
-- 
2.20.1

