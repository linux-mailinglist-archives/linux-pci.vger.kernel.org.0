Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 624D9446F86
	for <lists+linux-pci@lfdr.de>; Sat,  6 Nov 2021 18:54:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234750AbhKFR4n (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 6 Nov 2021 13:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234742AbhKFR4m (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 6 Nov 2021 13:56:42 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0722EC061570;
        Sat,  6 Nov 2021 10:54:01 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id j21so44583887edt.11;
        Sat, 06 Nov 2021 10:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fPpPXmTwNV5yeXl9702tcKFhNJGs8yk4TK4+l6VNXCw=;
        b=dlsKjMuLS69SncKp3BJ3M22AhATZyhxpd2o5sSXh+RjJQih4/pk6oOkavdaeRpiHYC
         V8Ev1N0lWy6xUkI8xnvd9WJ3iAcScy/NejXe7QQc5SAA8soDKk0ZFAVUo5twy+m8Ay0c
         Ng7Qgvola0FoZNrtGhHQoKp2YUm6dY/evSSKrm43z97N9hV2Es+ZWr3uos21/WJ475my
         k/sJkFpnf/QQufAgS8ljMBiCdX9Rll/KjpexWwEzCLz7SLh/YXyqo303bvIiSfYZlMkB
         K+xwOB36sOPu3eL6T5FY4Q47MCGzadH4wyjz9IViK4v398AgRDBchMM2LRFOtB5EvdsS
         TJDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fPpPXmTwNV5yeXl9702tcKFhNJGs8yk4TK4+l6VNXCw=;
        b=BEEsC9IqvQAyb7peW0j7aBUEtx37HcuoMTqqnCMGraZsHUiDwIDOPDNQkt9w+9boEr
         klMHgKamCiub92w+yUM3DV1mj9ovxffgDQob73QTLGLe4W8f8bQKwoP7eLFrfCbGgyGP
         xJVf/b60yKRSPyeyt6UrHdkuiZhjxEblgggN0vKzmoPzv+Hvcugkb5j/9kkDKoFUcYkk
         rPmRxKE0tNRqjIMgPSqVCBmxliDawGhi8mvwath4djzGbQ/aatEBmGA/MaXgve4510dP
         7e24IB5rnk0zWRkw4tqCsB5Nm0ugNOcWqvgvVE9MTtQgP+lehbzX5yYt9cmMoh505hgO
         7gfg==
X-Gm-Message-State: AOAM531hL5wDXq0yLnLPMxTjnf8U3ttW4Yrc/k7oTHAJi+mgve6TCNYZ
        PyM97PbCWBwAvOYRVlRUKB8VEXGMVnA=
X-Google-Smtp-Source: ABdhPJx6X8EKzVJj7H0tuECDEo0xWYPm+2J1fCNVay+kc/fGBL/143iwNuAzBOOrfV0LH+lgmknhow==
X-Received: by 2002:a17:906:b884:: with SMTP id hb4mr79591932ejb.376.1636221239481;
        Sat, 06 Nov 2021 10:53:59 -0700 (PDT)
Received: from localhost.localdomain ([2a02:ab88:109:9f0:f6a6:7fbe:807a:e1cc])
        by smtp.googlemail.com with ESMTPSA id m12sm5753494ejj.63.2021.11.06.10.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Nov 2021 10:53:59 -0700 (PDT)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     helgaas@kernel.org
Cc:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 3/6] PCI/ASPM: Extract the calculation of link->aspm_enabled
Date:   Sat,  6 Nov 2021 18:53:50 +0100
Message-Id: <20211106175353.26248-4-refactormyself@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211106175353.26248-1-refactormyself@gmail.com>
References: <20211106175353.26248-1-refactormyself@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Inside pcie_aspm_init_cap() the initial enabled state is read
from the firmware and calculated. It is stored in
struct pcie_link_state->aspm_enabled and also backed up in
struct pcie_link_state->aspm_default. pcie_aspm_init_cap() can
be simplified by isolation this calculation.

Extract the calculation of struct pcie_link_state->aspm_enabled
into aspm_calc_enabled_states().

Signed-off-by: Saheed O. Bolarinwa <refactormyself@gmail.com>
---
 drivers/pci/pcie/aspm.c | 66 ++++++++++++++++++++++++-----------------
 1 file changed, 38 insertions(+), 28 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 23441a32f604..5e8613cb5db6 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -591,13 +591,47 @@ static u32 aspm_calc_init_linkcap(u32 up_lnkcap, u32 dwn_lnkcap,
 	return link_cap;
 }
 
+static u32 aspm_calc_enabled_states(struct pcie_link_state *link,
+				    u32 up_l1ss_cap, u32 dwn_l1ss_cap)
+{
+	struct pci_dev *child = link->downstream, *parent = link->pdev;
+	u16 parent_lnkctl, child_lnkctl;
+	u32 aspm_enabled = 0, parent_l1ss_ctl1 = 0, child_l1ss_ctl1 = 0;
+
+	pcie_capability_read_word(parent, PCI_EXP_LNKCTL, &parent_lnkctl);
+	pcie_capability_read_word(child, PCI_EXP_LNKCTL, &child_lnkctl);
+
+	if (child_lnkctl & PCI_EXP_LNKCTL_ASPM_L0S)
+		aspm_enabled |= ASPM_STATE_L0S_UP;
+	if (parent_lnkctl & PCI_EXP_LNKCTL_ASPM_L0S)
+		aspm_enabled |= ASPM_STATE_L0S_DW;
+	if (parent_lnkctl & child_lnkctl & PCI_EXP_LNKCTL_ASPM_L1)
+		aspm_enabled |= ASPM_STATE_L1;
+
+	if (up_l1ss_cap)
+		pci_read_config_dword(parent, parent->l1ss + PCI_L1SS_CTL1,
+				      &parent_l1ss_ctl1);
+	if (dwn_l1ss_cap)
+		pci_read_config_dword(child, child->l1ss + PCI_L1SS_CTL1,
+				      &child_l1ss_ctl1);
+
+	if (parent_l1ss_ctl1 & child_l1ss_ctl1 & PCI_L1SS_CTL1_ASPM_L1_1)
+		aspm_enabled |= ASPM_STATE_L1_1;
+	if (parent_l1ss_ctl1 & child_l1ss_ctl1 & PCI_L1SS_CTL1_ASPM_L1_2)
+		aspm_enabled |= ASPM_STATE_L1_2;
+	if (parent_l1ss_ctl1 & child_l1ss_ctl1 & PCI_L1SS_CTL1_PCIPM_L1_1)
+		aspm_enabled |= ASPM_STATE_L1_1_PCIPM;
+	if (parent_l1ss_ctl1 & child_l1ss_ctl1 & PCI_L1SS_CTL1_PCIPM_L1_2)
+		aspm_enabled |= ASPM_STATE_L1_2_PCIPM;
+
+	return aspm_enabled;
+}
+
 static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 {
 	struct pci_dev *child = link->downstream, *parent = link->pdev;
 	u32 parent_lnkcap, child_lnkcap;
-	u16 parent_lnkctl, child_lnkctl;
 	u32 parent_l1ss_cap, child_l1ss_cap;
-	u32 parent_l1ss_ctl1 = 0, child_l1ss_ctl1 = 0;
 	struct pci_bus *linkbus = parent->subordinate;
 
 	if (blacklist) {
@@ -627,41 +661,17 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 	 */
 	pcie_capability_read_dword(parent, PCI_EXP_LNKCAP, &parent_lnkcap);
 	pcie_capability_read_dword(child, PCI_EXP_LNKCAP, &child_lnkcap);
-	pcie_capability_read_word(parent, PCI_EXP_LNKCTL, &parent_lnkctl);
-	pcie_capability_read_word(child, PCI_EXP_LNKCTL, &child_lnkctl);
 
-	/* Setup L0s state */
-	if (child_lnkctl & PCI_EXP_LNKCTL_ASPM_L0S)
-		link->aspm_enabled |= ASPM_STATE_L0S_UP;
-	if (parent_lnkctl & PCI_EXP_LNKCTL_ASPM_L0S)
-		link->aspm_enabled |= ASPM_STATE_L0S_DW;
 	link->latency_up.l0s = calc_l0s_latency(parent_lnkcap);
 	link->latency_dw.l0s = calc_l0s_latency(child_lnkcap);
-
-	/* Setup L1 state */
-	if (parent_lnkctl & child_lnkctl & PCI_EXP_LNKCTL_ASPM_L1)
-		link->aspm_enabled |= ASPM_STATE_L1;
 	link->latency_up.l1 = calc_l1_latency(parent_lnkcap);
 	link->latency_dw.l1 = calc_l1_latency(child_lnkcap);
 
 	/* Setup L1 substate */
 	aspm_calc_both_l1ss_caps(link, &parent_l1ss_cap, &child_l1ss_cap);
 
-	if (parent_l1ss_cap)
-		pci_read_config_dword(parent, parent->l1ss + PCI_L1SS_CTL1,
-				      &parent_l1ss_ctl1);
-	if (child_l1ss_cap)
-		pci_read_config_dword(child, child->l1ss + PCI_L1SS_CTL1,
-				      &child_l1ss_ctl1);
-
-	if (parent_l1ss_ctl1 & child_l1ss_ctl1 & PCI_L1SS_CTL1_ASPM_L1_1)
-		link->aspm_enabled |= ASPM_STATE_L1_1;
-	if (parent_l1ss_ctl1 & child_l1ss_ctl1 & PCI_L1SS_CTL1_ASPM_L1_2)
-		link->aspm_enabled |= ASPM_STATE_L1_2;
-	if (parent_l1ss_ctl1 & child_l1ss_ctl1 & PCI_L1SS_CTL1_PCIPM_L1_1)
-		link->aspm_enabled |= ASPM_STATE_L1_1_PCIPM;
-	if (parent_l1ss_ctl1 & child_l1ss_ctl1 & PCI_L1SS_CTL1_PCIPM_L1_2)
-		link->aspm_enabled |= ASPM_STATE_L1_2_PCIPM;
+	link->aspm_enabled = aspm_calc_enabled_states(link, parent_l1ss_cap,
+						      child_l1ss_cap);
 
 	/* Save default state */
 	link->aspm_default = link->aspm_enabled;
-- 
2.20.1

