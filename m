Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE2C3EBE4E
	for <lists+linux-pci@lfdr.de>; Sat, 14 Aug 2021 00:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235144AbhHMWgp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Aug 2021 18:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235079AbhHMWgo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Aug 2021 18:36:44 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7091AC061756
        for <linux-pci@vger.kernel.org>; Fri, 13 Aug 2021 15:36:17 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id h13so15251547wrp.1
        for <linux-pci@vger.kernel.org>; Fri, 13 Aug 2021 15:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m3kDMwKP69zOvwkQZW9XgztPfTldaAcehTU8PH2NsKI=;
        b=gcyLW+eyOMitsFZun0C3KEvvR9YYt3nK+zu633vtrBb5Fb9t8Vo+4X3JQmCUctxJeu
         3diLex3KReK+NmgPpFxVfrCrczrBcX8GiSVen9pMi2Ww83OgWi8hdFP4aVdV2nyIM4Gg
         UJD58Jz58Ue9NRMxLH3+UIiM0ffyzyjeJn/u4RDA1TM7kXQ3Lfu0X6gzJa8wDOxKSfgW
         HCdZgeUqTEUDGSZ2Lgne8RkmLVMu9BjEZFTlgKyXTdiKfPbaW8mi4TRmuMz9LDGNQzN7
         FhCcLeiim1EFaH6XH+U4GcFnJLG6XVWZtkZcX3WJY+J0ZhouQKdIste2Yssfo+JRZpFW
         LxeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m3kDMwKP69zOvwkQZW9XgztPfTldaAcehTU8PH2NsKI=;
        b=F1TCiHf9KzEkNOqge1sVxGsW1ywaRI1uPPjup5HGRZ0jIX4Ex8fsduXxCXZThBXeyD
         uCiZVkGkCwTmPhkJogVr7d3oKHHnZEKVl/bQrXw5rR+hyF7UOdFr9QzdOsRVGr+NCS/V
         tYqVV6GYgSvF3xe7LvjT8VJ/2HbeWguPG9r7Ymor8W4Rf5vMwEt4k8dZQTc+OKDAXF6y
         4AKCuA4DF4zMOOazqvCoJX9FuHB+05zEND+07kb+8eexc94lRoAfsO+Xm3IN9SZh6ag5
         Yqa/v8XB4KGoqEX2tR+iBSBAkL50bJPdun932PQRhaU6Z3NOYQRTeH4cmdIEPZonWWuz
         T+RA==
X-Gm-Message-State: AOAM532A8yeRNhZt/vjZwur5aFqupi9sU2DSR/6gREjRPwKJNMxbYpFh
        iX334gLOgRcrH1YBULmAndrE4oATd7MdCw==
X-Google-Smtp-Source: ABdhPJwGoO40QQun2536mJDx+/SegYyRPV+jj4515P5uBdjtj4u86mu+eRiKfM6ys9qz6VdlazQ83g==
X-Received: by 2002:a05:6000:18c8:: with SMTP id w8mr5402969wrq.90.1628894175830;
        Fri, 13 Aug 2021 15:36:15 -0700 (PDT)
Received: from localhost.localdomain ([2a02:ab88:144:f570:b509:5224:f519:ca15])
        by smtp.googlemail.com with ESMTPSA id 6sm2621028wmk.20.2021.08.13.15.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 15:36:15 -0700 (PDT)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     linux-pci@vger.kernel.org
Cc:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>
Subject: [RFC PATCH 1/3] PCI/ASPM: Remove struct pcie_link_state.latency_*
Date:   Sat, 14 Aug 2021 00:36:07 +0200
Message-Id: <20210813223610.8687-2-refactormyself@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210813223610.8687-1-refactormyself@gmail.com>
References: <20210813223610.8687-1-refactormyself@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Inside pcie_aspm_cap_init() the exit latencies on both upstream and
downstream are calculated and cached in struct pcie_link_state.latency_*
These values are only used in pcie_aspm_check_latency() where they are
compared with the acceptable latencies on the link.

Computing these latencies right inside pcie_aspm_check_latency() where
they are only needed will remove the need for caching them. This will
not make any functional change.

 - Calculate the exit latencies inside pcie_aspm_check_latency()
 - Remove struct pcie_link_state.latency_{up,dw}
 - Replace references with local variables of struct aspm_latency

Signed-off-by: Saheed O. Bolarinwa <refactormyself@gmail.com>
---
 drivers/pci/pcie/aspm.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 013a47f587ce..4c437b1345b2 100644
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
@@ -378,7 +375,8 @@ static void encode_l12_threshold(u32 threshold_us, u32 *scale, u32 *value)
 
 static void pcie_aspm_check_latency(struct pci_dev *endpoint)
 {
-	u32 latency, l1_switch_latency = 0;
+	u32 latency, lnkcap_up, lnkcap_dw, l1_switch_latency = 0;
+	struct aspm_latency latency_up, latency_dw;
 	struct aspm_latency *acceptable;
 	struct pcie_link_state *link;
 
@@ -391,14 +389,22 @@ static void pcie_aspm_check_latency(struct pci_dev *endpoint)
 	acceptable = &link->acceptable[PCI_FUNC(endpoint->devfn)];
 
 	while (link) {
+		/* Read direction exit latencies */
+		pcie_capability_read_dword(link->pdev, PCI_EXP_LNKCAP, &lnkcap_up);
+		pcie_capability_read_dword(link->downstream, PCI_EXP_LNKCAP, &lnkcap_dw);
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
@@ -413,7 +419,7 @@ static void pcie_aspm_check_latency(struct pci_dev *endpoint)
 		 * L1 exit latencies advertised by a device include L1
 		 * substate latencies (and hence do not do any check).
 		 */
-		latency = max_t(u32, link->latency_up.l1, link->latency_dw.l1);
+		latency = max_t(u32, latency_up.l1, latency_dw.l1);
 		if ((link->aspm_capable & ASPM_STATE_L1) &&
 		    (latency + l1_switch_latency > acceptable->l1))
 			link->aspm_capable &= ~ASPM_STATE_L1;
@@ -593,8 +599,6 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 		link->aspm_enabled |= ASPM_STATE_L0S_UP;
 	if (parent_lnkctl & PCI_EXP_LNKCTL_ASPM_L0S)
 		link->aspm_enabled |= ASPM_STATE_L0S_DW;
-	link->latency_up.l0s = calc_l0s_latency(parent_lnkcap);
-	link->latency_dw.l0s = calc_l0s_latency(child_lnkcap);
 
 	/* Setup L1 state */
 	if (parent_lnkcap & child_lnkcap & PCI_EXP_LNKCAP_ASPM_L1)
@@ -602,8 +606,6 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 
 	if (parent_lnkctl & child_lnkctl & PCI_EXP_LNKCTL_ASPM_L1)
 		link->aspm_enabled |= ASPM_STATE_L1;
-	link->latency_up.l1 = calc_l1_latency(parent_lnkcap);
-	link->latency_dw.l1 = calc_l1_latency(child_lnkcap);
 
 	/* Setup L1 substate */
 	pci_read_config_dword(parent, parent->l1ss + PCI_L1SS_CAP,
-- 
2.20.1

