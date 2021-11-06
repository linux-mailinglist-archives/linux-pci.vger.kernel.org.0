Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8A40446F79
	for <lists+linux-pci@lfdr.de>; Sat,  6 Nov 2021 18:53:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234719AbhKFRz6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 6 Nov 2021 13:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234714AbhKFRz6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 6 Nov 2021 13:55:58 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FEF8C061570;
        Sat,  6 Nov 2021 10:53:16 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id ee33so44968757edb.8;
        Sat, 06 Nov 2021 10:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=epBvfuJRJhoeaojCSsux12nzywNe4SCEfxE39DKnyw4=;
        b=OJNiSuoyuoUidRHOQZMYZXambmieMz/7N9aL8QVwCQKORvHcqwqb8eXIgze6AXC5vo
         6srnYlKfnyo7+nVqMkkl7kNnwgnd+097+T5BPeKciANXtMfqHMp5mGtYKb7ynuj4b9/4
         AfSRE3T53BlXqfn/W7hD0HMDzbAd6p1VDCH27oTXCCLZj+nPGzQ9AQWNSmixlpfh7hC5
         0LDeioT6i5OA802JgU6GO+mbQbyBIs6FIXzHeZ+hGK9P7ifWqb+Fz5EOLuZLJIEA3Jpz
         UMuCyLj657fEv+cSvfYykCKlZ7tzxIT9abQfp9ywlny4LINZT4npLmD7hQezQJzxvnbs
         AVlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=epBvfuJRJhoeaojCSsux12nzywNe4SCEfxE39DKnyw4=;
        b=Vd5A9elHTy19oekM3eYvmV8bXicCLPOF2g1SWuVroXn15HnGEp5KzSACy0YXZ+x5PZ
         25gqWxLMhOEL13uY/sCGVPhPxckG02J6eCSeaaeak+GCwWeukYr25j6If6lMht/45t28
         SU5YZI93Qt1wAV95iJygF7wHQHwqRv6wySig13/ZXBR0gC8KUdv267tiqdWVF1SkdETe
         awTQCKjoaEuREPy83+qtB6LLt+t1VzvX0Dky/VPtNyH2sreMBEH/7jozHXwbfBcb2G/t
         Ld33zw4Xv3jvSGi0UEzvv9DrTAvw5pkNmJub2BkBpwAZNkEH0MtxQSl2xjFx4kUmZ4ZS
         X4nA==
X-Gm-Message-State: AOAM533WA6rIFZX5xE0RJbso5b/NrJt0IbH1boEWqNZFu+oSRKTvxA5g
        qCHrKNWk4yVfb5j//9SIXm68+QpNrtM=
X-Google-Smtp-Source: ABdhPJzHpDHygLa3rd75XeOu0tyX9GrGSGn3fft8/9KEzpaXdzE1FoPU0y1JrlPbVA69Vvx/jbcNig==
X-Received: by 2002:a17:906:a08c:: with SMTP id q12mr81899590ejy.443.1636221194400;
        Sat, 06 Nov 2021 10:53:14 -0700 (PDT)
Received: from localhost.localdomain ([2a02:ab88:109:9f0:f6a6:7fbe:807a:e1cc])
        by smtp.googlemail.com with ESMTPSA id g10sm6364857edr.56.2021.11.06.10.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Nov 2021 10:53:14 -0700 (PDT)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     helgaas@kernel.org
Cc:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v4 2/4] PCI/ASPM: Do not cache link latencies
Date:   Sat,  6 Nov 2021 18:53:03 +0100
Message-Id: <20211106175305.25565-3-refactormyself@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211106175305.25565-1-refactormyself@gmail.com>
References: <20211106175305.25565-1-refactormyself@gmail.com>
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
 drivers/pci/pcie/aspm.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index a6d89c2c5b60..9e74df7b9dc0 100644
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
 
@@ -405,14 +403,23 @@ static void pcie_aspm_check_latency(struct pci_dev *endpoint)
 	acceptable = &link->acceptable[PCI_FUNC(endpoint->devfn)];
 
 	while (link) {
+		/* Read direction exit latencies */
+		pcie_capability_read_dword(link->pdev, PCI_EXP_LNKCAP, &lnkcap_up);
+		pcie_capability_read_dword(pci_function_0(link->pdev->subordinate),
+					   PCI_EXP_LNKCAP, &lnkcap_dw);
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
@@ -427,7 +434,7 @@ static void pcie_aspm_check_latency(struct pci_dev *endpoint)
 		 * L1 exit latencies advertised by a device include L1
 		 * substate latencies (and hence do not do any check).
 		 */
-		latency = max_t(u32, link->latency_up.l1, link->latency_dw.l1);
+		latency = max_t(u32, latency_up.l1, latency_dw.l1);
 		if ((link->aspm_capable & ASPM_STATE_L1) &&
 		    (latency + l1_switch_latency > acceptable->l1))
 			link->aspm_capable &= ~ASPM_STATE_L1;
@@ -593,8 +600,6 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 		link->aspm_enabled |= ASPM_STATE_L0S_UP;
 	if (parent_lnkctl & PCI_EXP_LNKCTL_ASPM_L0S)
 		link->aspm_enabled |= ASPM_STATE_L0S_DW;
-	link->latency_up.l0s = calc_l0s_latency(parent_lnkcap);
-	link->latency_dw.l0s = calc_l0s_latency(child_lnkcap);
 
 	/* Setup L1 state */
 	if (parent_lnkcap & child_lnkcap & PCI_EXP_LNKCAP_ASPM_L1)
@@ -602,8 +607,6 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 
 	if (parent_lnkctl & child_lnkctl & PCI_EXP_LNKCTL_ASPM_L1)
 		link->aspm_enabled |= ASPM_STATE_L1;
-	link->latency_up.l1 = calc_l1_latency(parent_lnkcap);
-	link->latency_dw.l1 = calc_l1_latency(child_lnkcap);
 
 	/* Setup L1 substate */
 	pci_read_config_dword(parent, parent->l1ss + PCI_L1SS_CAP,
-- 
2.20.1

