Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1753EBE4F
	for <lists+linux-pci@lfdr.de>; Sat, 14 Aug 2021 00:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235305AbhHMWgt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Aug 2021 18:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235079AbhHMWgp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Aug 2021 18:36:45 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55AB4C061756
        for <linux-pci@vger.kernel.org>; Fri, 13 Aug 2021 15:36:18 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id z9so15115620wrh.10
        for <linux-pci@vger.kernel.org>; Fri, 13 Aug 2021 15:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cGRy8+2gpcfbwlJlqEryHppKLbj1FR/g/l5DIPPEnkQ=;
        b=PHssimngDwlKLwQ8u9BVi7cVqg+qLyStl6s64yKFhto01dp5UhO6OOioGzfTikEUI2
         gKmmplN+N7KDSohTuXrfhVKo21JwiAPlqiIk3n2BePRhHq1q1eZfUhKYi9/Nxi73S1QN
         2iPL9dQvvdNpQ0UmxQAZVOj/zkrR36TANvGCC13w4Huylb0Ay6nRUAS2wKFBLy/LR3YM
         YiroFLVIsDl10EbH1fsRFCqxewf/2BuJLkZkTGtvwvI87soQBP0p9bQQQsfmvKBc9iok
         2M3cgftpkozVy0MNHwAYJgJrWX9pg9tJDdBPEEaxq/gqCHlB63YDO2CroCAn5R1h+xR9
         hl+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cGRy8+2gpcfbwlJlqEryHppKLbj1FR/g/l5DIPPEnkQ=;
        b=HOA8ipAwoD2OLwAE6H+xymy3Qx0alzjras+PnN77nMbR3eXHMLRhs1H2es5sly/Xi5
         GRL1g+PCruRV6w1mjDNjH5dORnfmfQTv43kYN7fhxhf2KW968aWRLjmsXMjg05/anZHk
         35Jw3d63ljPgwHoVF4rpd6IZtuqwONvS5UcTWjQltcopqRvTsFDM/GEYbDBZH7jLS/Ii
         KKL1g1Eq+tAMV45a8j5j9DfPB/8n3h764CBh0McRy/xa3KkziW9K4TL7QmmC1QVE9+60
         Y6cPJt0Awt5p+jtR3LBhR3KC6VNHs7LIuQTFcVC7Ci0nPWwsW3GUOkF84WzdY1sPs6cF
         AODg==
X-Gm-Message-State: AOAM533t+dsb2o2A8lBbr/o0StHCEyMLZBrPzLcRt9w91C2PWcmSBDVX
        NV3S/914PQ5cy4g9Mj78HReDDveeJFFldA==
X-Google-Smtp-Source: ABdhPJwaqJMAqhWIgeljzFbzAqkMv0prMSDuOeLuvmC/6EHaUtHldV8oLK5RXPHCA1YIdPRDauSgrw==
X-Received: by 2002:a5d:49c5:: with SMTP id t5mr71399wrs.161.1628894176719;
        Fri, 13 Aug 2021 15:36:16 -0700 (PDT)
Received: from localhost.localdomain ([2a02:ab88:144:f570:b509:5224:f519:ca15])
        by smtp.googlemail.com with ESMTPSA id 6sm2621028wmk.20.2021.08.13.15.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 15:36:16 -0700 (PDT)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     linux-pci@vger.kernel.org
Cc:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>
Subject: [RFC PATCH 2/3] PCI/ASPM: Remove struct pcie_link_state.acceptable
Date:   Sat, 14 Aug 2021 00:36:08 +0200
Message-Id: <20210813223610.8687-3-refactormyself@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210813223610.8687-1-refactormyself@gmail.com>
References: <20210813223610.8687-1-refactormyself@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Inside pcie_aspm_cap_init() the acceptable latencies for each device on
the bus_list are calculated and cached in pcie_link_state->acceptable.
These cached latencies are only used inside pcie_aspm_check_latency()
which is called right after computing them.

Computing these latencies right inside pcie_aspm_check_latency() where
they are needed will remove the need for caching them without making
any functional change.

 - Calculate the acceptable latency for each device directly inside
   pcie_aspm_check_latency()
 - Remove pcie_link_state->acceptable

Signed-off-by: Saheed O. Bolarinwa <refactormyself@gmail.com>
---
 drivers/pci/pcie/aspm.c | 27 ++++++++-------------------
 1 file changed, 8 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 4c437b1345b2..b713a2c8040f 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -65,12 +65,6 @@ struct pcie_link_state {
 	u32 clkpm_enabled:1;		/* Current Clock PM state */
 	u32 clkpm_default:1;		/* Default Clock PM state by BIOS */
 	u32 clkpm_disable:1;		/* Clock PM disabled */
-
-	/*
-	 * Endpoint acceptable latencies. A pcie downstream port only
-	 * has one slot under it, so at most there are 8 functions.
-	 */
-	struct aspm_latency acceptable[8];
 };
 
 static int aspm_disabled, aspm_force;
@@ -375,7 +369,7 @@ static void encode_l12_threshold(u32 threshold_us, u32 *scale, u32 *value)
 
 static void pcie_aspm_check_latency(struct pci_dev *endpoint)
 {
-	u32 latency, lnkcap_up, lnkcap_dw, l1_switch_latency = 0;
+	u32 reg32, latency, encoding, lnkcap_up, lnkcap_dw, l1_switch_latency = 0;
 	struct aspm_latency latency_up, latency_dw;
 	struct aspm_latency *acceptable;
 	struct pcie_link_state *link;
@@ -386,7 +380,13 @@ static void pcie_aspm_check_latency(struct pci_dev *endpoint)
 		return;
 
 	link = endpoint->bus->self->link_state;
-	acceptable = &link->acceptable[PCI_FUNC(endpoint->devfn)];
+	pcie_capability_read_dword(endpoint, PCI_EXP_DEVCAP, &reg32);
+	/* Calculate endpoint L0s acceptable latency */
+	encoding = (reg32 & PCI_EXP_DEVCAP_L0S) >> 6;
+	acceptable->l0s = calc_l0s_acceptable(encoding);
+	/* Calculate endpoint L1 acceptable latency */
+	encoding = (reg32 & PCI_EXP_DEVCAP_L1) >> 9;
+	acceptable->l1 = calc_l1_acceptable(encoding);
 
 	while (link) {
 		/* Read direction exit latencies */
@@ -662,22 +662,11 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 
 	/* Get and check endpoint acceptable latencies */
 	list_for_each_entry(child, &linkbus->devices, bus_list) {
-		u32 reg32, encoding;
-		struct aspm_latency *acceptable =
-			&link->acceptable[PCI_FUNC(child->devfn)];
 
 		if (pci_pcie_type(child) != PCI_EXP_TYPE_ENDPOINT &&
 		    pci_pcie_type(child) != PCI_EXP_TYPE_LEG_END)
 			continue;
 
-		pcie_capability_read_dword(child, PCI_EXP_DEVCAP, &reg32);
-		/* Calculate endpoint L0s acceptable latency */
-		encoding = (reg32 & PCI_EXP_DEVCAP_L0S) >> 6;
-		acceptable->l0s = calc_l0s_acceptable(encoding);
-		/* Calculate endpoint L1 acceptable latency */
-		encoding = (reg32 & PCI_EXP_DEVCAP_L1) >> 9;
-		acceptable->l1 = calc_l1_acceptable(encoding);
-
 		pcie_aspm_check_latency(child);
 	}
 }
-- 
2.20.1

