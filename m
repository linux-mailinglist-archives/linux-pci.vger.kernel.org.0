Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF57457727
	for <lists+linux-pci@lfdr.de>; Fri, 19 Nov 2021 20:39:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233316AbhKSTmi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Nov 2021 14:42:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235324AbhKSTmf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 Nov 2021 14:42:35 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C173BC061748;
        Fri, 19 Nov 2021 11:39:24 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id l25so30491416eda.11;
        Fri, 19 Nov 2021 11:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lEUVIidb26P1etOScGhyEwiMqag493M5Iw91U7Op3Z4=;
        b=foRvEjkibnTriH+7Du9LiMvshA1zgwBeURU/LzlqpZ980L8ex4A262f36noM3k+zaK
         Jl/vVUgBRywY3TsC2UA5/lxDiClWix2nHehiG05pIVEa69wFBsaMfs89vBVqGLTMIWnN
         t451KY/YrFzfQlGS5T+73Wf0YcYMqKx1rDOL8VVP94Kc7B5X9L33pS1NCS3q0G0/uH7Q
         hG37JM0MaL5QBSBimi6Ieqf60Wnb7qET4THav4HxbVPecModD6nwZees4YsmRTF8OQha
         W3RQCyrLpgvTOzES2PrPGuqlImTdgLeXnJf2YlSyQGjleVcraFmHyoU7Sg0kIZksQ42G
         eOWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lEUVIidb26P1etOScGhyEwiMqag493M5Iw91U7Op3Z4=;
        b=Z2MUWlLk/waliQnf/LLNXhDtOge7e0cJWLOKdmOUJ59njSiqN68Lw2oQMDbJSA3VOt
         PtTy1ZUrYKCpEZYhxerSQXGvnTKprtW6W/ul0n9bz/dAtKhTCYiutvAmKfpPvYNtqcnw
         yk+Zt/viVGErFHSDjdgkpJRNyiy8YhjGoX8MMQ2U0yUdErBdceNBiCo/ngo5hpMZO6Ge
         F17h7lb8k9lDsyM2bNegkfOZMevQ51hNwhIhCH9acmcVydV539Qyi/PdrIi+DHLjmHvQ
         Z+R/jdURMkh6VEZAFX0HWJ6N8IBRmiD1t+pbAyhwm6h9tElsrK0dstaxPCwVXEzAyf03
         KhpA==
X-Gm-Message-State: AOAM532VSppewH4lJvboDKj4/4WYS+U6zo72vAO3k8Io705wQFtg08sq
        6Ig53s5lG0rLvZkssvj9hOg=
X-Google-Smtp-Source: ABdhPJyS+huF4Vf7cuGqBz7aOTYQEzp+lhaEYxjCQo2miCpX+Gj6r874ITLAYBTquAJrs1kAxW1NAA==
X-Received: by 2002:a05:6402:4407:: with SMTP id y7mr28718591eda.140.1637350763365;
        Fri, 19 Nov 2021 11:39:23 -0800 (PST)
Received: from localhost.localdomain (catv-176-63-2-222.catv.broadband.hu. [176.63.2.222])
        by smtp.googlemail.com with ESMTPSA id sb19sm327521ejc.120.2021.11.19.11.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 11:39:23 -0800 (PST)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     helgaas@kernel.org
Cc:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, hch@lst.de
Subject: [RFC PATCH v5 2/4] PCI/ASPM: Do not cache link latencies
Date:   Fri, 19 Nov 2021 20:37:30 +0100
Message-Id: <20211119193732.12343-3-refactormyself@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211119193732.12343-1-refactormyself@gmail.com>
References: <20211119193732.12343-1-refactormyself@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The latencies of the upstream and downstream are calculated within
pcie_aspm_cap_init() and cached in struct pcie_link_state.latency_*
These values are only used in pcie_aspm_check_latency() where they are
compared with the acceptable latencies on the link.

- remove `latency_*` entries from struct pcie_link_state.
- calculate the latencies directly where they are needed.

Signed-off-by: Saheed O. Bolarinwa <refactormyself@gmail.com>
---
 drivers/pci/pcie/aspm.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 6f128b654730..1b8933e0afb2 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -66,9 +66,6 @@ struct pcie_link_state {
 	u32 clkpm_default:1;		/* Default Clock PM state by BIOS */
 	u32 clkpm_disable:1;		/* Clock PM disabled */
 
-	/* Exit latencies */
-	struct aspm_latency latency_up;	/* Upstream direction exit latency */
-	struct aspm_latency latency_dw;	/* Downstream direction exit latency */
 	/*
 	 * Endpoint acceptable latencies. A pcie downstream port only
 	 * has one slot under it, so at most there are 8 functions.
@@ -392,7 +389,8 @@ static void encode_l12_threshold(u32 threshold_us, u32 *scale, u32 *value)
 
 static void pcie_aspm_check_latency(struct pci_dev *endpoint)
 {
-	u32 latency, l1_switch_latency = 0;
+	u32 latency, lnkcap_up, lnkcap_dw, l1_switch_latency = 0;
+	struct aspm_latency latency_up, latency_dw;
 	struct aspm_latency *acceptable;
 	struct pcie_link_state *link;
 
@@ -405,14 +403,29 @@ static void pcie_aspm_check_latency(struct pci_dev *endpoint)
 	acceptable = &link->acceptable[PCI_FUNC(endpoint->devfn)];
 
 	while (link) {
+		struct pci_dev *dev = pci_function_0(
+					link->pdev->subordinate);
+
+		/* Read direction exit latencies */
+		pcie_capability_read_dword(link->pdev,
+					   PCI_EXP_LNKCAP,
+					   &lnkcap_up);
+		pcie_capability_read_dword(dev,
+					   PCI_EXP_LNKCAP,
+					   &lnkcap_dw);
+		latency_up.l0s = calc_l0s_latency(lnkcap_up);
+		latency_up.l1 = calc_l1_latency(lnkcap_up);
+		latency_dw.l0s = calc_l0s_latency(lnkcap_dw);
+		latency_dw.l1 = calc_l1_latency(lnkcap_dw);
+
 		/* Check upstream direction L0s latency */
 		if ((link->aspm_capable & ASPM_STATE_L0S_UP) &&
-		    (link->latency_up.l0s > acceptable->l0s))
+		    (latency_up.l0s > acceptable->l0s))
 			link->aspm_capable &= ~ASPM_STATE_L0S_UP;
 
 		/* Check downstream direction L0s latency */
 		if ((link->aspm_capable & ASPM_STATE_L0S_DW) &&
-		    (link->latency_dw.l0s > acceptable->l0s))
+		    (latency_dw.l0s > acceptable->l0s))
 			link->aspm_capable &= ~ASPM_STATE_L0S_DW;
 		/*
 		 * Check L1 latency.
@@ -427,7 +440,7 @@ static void pcie_aspm_check_latency(struct pci_dev *endpoint)
 		 * L1 exit latencies advertised by a device include L1
 		 * substate latencies (and hence do not do any check).
 		 */
-		latency = max_t(u32, link->latency_up.l1, link->latency_dw.l1);
+		latency = max_t(u32, latency_up.l1, latency_dw.l1);
 		if ((link->aspm_capable & ASPM_STATE_L1) &&
 		    (latency + l1_switch_latency > acceptable->l1))
 			link->aspm_capable &= ~ASPM_STATE_L1;
@@ -593,8 +606,6 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 		link->aspm_enabled |= ASPM_STATE_L0S_UP;
 	if (parent_lnkctl & PCI_EXP_LNKCTL_ASPM_L0S)
 		link->aspm_enabled |= ASPM_STATE_L0S_DW;
-	link->latency_up.l0s = calc_l0s_latency(parent_lnkcap);
-	link->latency_dw.l0s = calc_l0s_latency(child_lnkcap);
 
 	/* Setup L1 state */
 	if (parent_lnkcap & child_lnkcap & PCI_EXP_LNKCAP_ASPM_L1)
@@ -602,8 +613,6 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 
 	if (parent_lnkctl & child_lnkctl & PCI_EXP_LNKCTL_ASPM_L1)
 		link->aspm_enabled |= ASPM_STATE_L1;
-	link->latency_up.l1 = calc_l1_latency(parent_lnkcap);
-	link->latency_dw.l1 = calc_l1_latency(child_lnkcap);
 
 	/* Setup L1 substate */
 	pci_read_config_dword(parent, parent->l1ss + PCI_L1SS_CAP,
-- 
2.20.1

