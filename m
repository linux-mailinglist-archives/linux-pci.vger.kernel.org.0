Return-Path: <linux-pci+bounces-13901-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F1D79922F6
	for <lists+linux-pci@lfdr.de>; Mon,  7 Oct 2024 05:29:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FA431C20918
	for <lists+linux-pci@lfdr.de>; Mon,  7 Oct 2024 03:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F472CA8;
	Mon,  7 Oct 2024 03:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1Q3s4t2z"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1ECD1C6A1
	for <linux-pci@vger.kernel.org>; Mon,  7 Oct 2024 03:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728271766; cv=none; b=aNzhN9VIzIgHxXgdFP+UQgvO5Cw1zTBQkVV4nyuEWugiU7aDCFDzOp5CehUktcIrctKCm4CkOC+7sDDM/owYv36e5T9sCoZC2glPWa0b+5vurLMk+ZRnUhVKJk2yTfX4FlzRI8FI/LlH0AuvOYQWFPY3lfJgBceBDQaCt11Bg2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728271766; c=relaxed/simple;
	bh=hm8olSmsctpeaPXcVDemiOPL5FkCHTbR32Wact0WsgM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=isLmbXPpTUioZBfOsIVOstsrhYqFEUm2pso5jjNyspWHbf6DmchQWc9Vvcc1Zs3xYIp3hfJ7V34hvKa/ssr879UX8jAH3sJM6nBWSc6jBCtjCCC+bQt6ZvVTeYw1gE3eIhF9T+n4zc5H7Xt/s0IB8iyJGOkvRaF5372UJeIkhwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ajayagarwal.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1Q3s4t2z; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ajayagarwal.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e278b2a5c4so68430537b3.2
        for <linux-pci@vger.kernel.org>; Sun, 06 Oct 2024 20:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728271764; x=1728876564; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ehkisLRJAELHV3S+3teRI9LlUsx1g0/d9d5bSWoVJrc=;
        b=1Q3s4t2zPHE4Q5LZJRBQYGeo7pmtT3ozcNeauPfnrf4i5V/D2g4chJfVH5yAzphNmp
         UXUahweBAQXuIS6un2buStlPeXRbqNxgy05T4DIiaRemX3lmtDbo2RiGENW2HkIoz9MU
         w9h39FcCkbma0UfSZZ++EQS5+Xjo1+kayCtpLHHWqeDYaSBQyxp61vukFuwPomOiobFE
         cvgfFbm0ToV1ekC051topoV1I7p+13H4Ac6Trc8uNu9a2A6LPFUl2Ayuz2K2pjQKxdrx
         rjo0wdQw6NgMjC87ZkMcZqmz3CCIAhCxB4r0FDODgorac+JX4DYw095fXSO3knNuWNRT
         UQSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728271764; x=1728876564;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ehkisLRJAELHV3S+3teRI9LlUsx1g0/d9d5bSWoVJrc=;
        b=taGQmqE8kLH8UCoJyZh8y6LUQh7yj8PLW8/34wssYY35LxHJmxcgpe314p43cSHwuO
         +awvZDmTozEZeQ+8WK8iWI/e+VkhCdxVRKmPNJwIyJ16d3H2cdGDc/uWrFntUXfaaONk
         ysQeTh5cBEH+HqbiZiD2x510Zpi1Z4lca3rhGjEqovnXkiWtKvE/saQ4bYNdTOSZWs85
         YQRn1S74BqfyKEq9eEovz2ijOquqCgx9kS6P9dij7ucFWNf5bH3AqHNrMEyuB8eTiGUL
         iRUYWkc1JxkpF6rn+MVoUzzCbhXcIZpYj/phIDYFceFgBp5BZIl8dwNVr01U99sbNj69
         gn2w==
X-Gm-Message-State: AOJu0YzL9CU/51a4Cd1l/iNKtcXG+w4A3h3jqEiJj9Q0P1OkDnod7oBF
	zfFXdwLWuDLwnBCN3Htbovqod+HLSK4xGQdCPMaZNs/DRSESjIzx5XEhB/TRpvnK/VHvubvB397
	6wCV4BlPNHmBsRbiAqrP/8Q==
X-Google-Smtp-Source: AGHT+IG2vTPjIpvtvgPfp4TOJoVUs6G0ZwhyZx4qYiJkRhlTq+8Ebd7NxCud6Ilh4qdcCS6vbQDvuZJiJEuQIFoPtA==
X-Received: from ajaya.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:39b5])
 (user=ajayagarwal job=sendgmr) by 2002:a25:fc06:0:b0:e25:ce37:257 with SMTP
 id 3f1490d57ef6-e28936cfc77mr7679276.3.1728271763780; Sun, 06 Oct 2024
 20:29:23 -0700 (PDT)
Date: Mon,  7 Oct 2024 08:59:17 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241007032917.872262-1-ajayagarwal@google.com>
Subject: [PATCH v3] PCI/ASPM: Disable L1 before disabling L1ss
From: Ajay Agarwal <ajayagarwal@google.com>
To: "=?UTF-8?q?Ilpo=20J=C3=A4rvinen?=" <ilpo.jarvinen@linux.intel.com>, 
	"David E. Box" <david.e.box@linux.intel.com>, Johan Hovold <johan+linaro@kernel.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Manu Gautam <manugautam@google.com>, Sajid Dalvi <sdalvi@google.com>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Vidya Sagar <vidyas@nvidia.com>, 
	Shuai Xue <xueshuai@linux.alibaba.com>
Cc: linux-pci@vger.kernel.org, Ajay Agarwal <ajayagarwal@google.com>
Content-Type: text/plain; charset="UTF-8"

The current sequence in the driver for L1ss update is as follows.

Disable L1ss
Disable L1
Enable L1ss as required
Enable L1 if required

With this sequence, a bus hang is observed during the L1ss
disable sequence when the RC CPU attempts to clear the RC L1ss
register after clearing the EP L1ss register. It looks like the
RC attempts to enter L1ss again and at the same time, access to
RC L1ss register fails because aux clk is still not active.

PCIe spec r6.2, section 5.5.4, recommends that setting either
or both of the enable bits for ASPM L1 PM Substates must be done
while ASPM L1 is disabled. My interpretation here is that
clearing L1ss should also be done when L1 is disabled. Thereby,
change the sequence as follows.

Disable L1
Disable L1ss
Enable L1ss as required
Enable L1 if required

Signed-off-by: Ajay Agarwal <ajayagarwal@google.com>
---
Changelog since v2:
 - Add the logic in pcie_aspm_cap_init()

Changelog since v1:
 - Move the L1 disable/enable logic to pcie_config_aspm_link()
 - Add detailed comments including spec version and section number

 drivers/pci/pcie/aspm.c | 66 +++++++++++++++++++++++++----------------
 1 file changed, 40 insertions(+), 26 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index cee2365e54b8..50997e378631 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -805,6 +805,15 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 	pcie_capability_read_word(parent, PCI_EXP_LNKCTL, &parent_lnkctl);
 	pcie_capability_read_word(child, PCI_EXP_LNKCTL, &child_lnkctl);
 
+	/* Make sure L0s/L1 are disabled before updating L1SS config */
+	if (FIELD_GET(PCI_EXP_LNKCTL_ASPMC, child_lnkctl) ||
+	    FIELD_GET(PCI_EXP_LNKCTL_ASPMC, parent_lnkctl)) {
+		pcie_capability_write_word(child, PCI_EXP_LNKCTL,
+					   child_lnkctl & ~PCI_EXP_LNKCTL_ASPMC);
+		pcie_capability_write_word(parent, PCI_EXP_LNKCTL,
+					   parent_lnkctl & ~PCI_EXP_LNKCTL_ASPMC);
+	}
+
 	/*
 	 * Setup L0s state
 	 *
@@ -829,6 +838,13 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 
 	aspm_l1ss_init(link);
 
+	/* Restore L0s/L1 if they were enabled */
+	if (FIELD_GET(PCI_EXP_LNKCTL_ASPMC, child_lnkctl) ||
+	    FIELD_GET(PCI_EXP_LNKCTL_ASPMC, parent_lnkctl)) {
+		pcie_capability_write_word(parent, PCI_EXP_LNKCTL, parent_lnkctl);
+		pcie_capability_write_word(child, PCI_EXP_LNKCTL, child_lnkctl);
+	}
+
 	/* Save default state */
 	link->aspm_default = link->aspm_enabled;
 
@@ -848,17 +864,13 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 /* Configure the ASPM L1 substates */
 static void pcie_config_aspm_l1ss(struct pcie_link_state *link, u32 state)
 {
-	u32 val, enable_req;
+	u32 val;
 	struct pci_dev *child = link->downstream, *parent = link->pdev;
 
-	enable_req = (link->aspm_enabled ^ state) & state;
-
 	/*
-	 * Here are the rules specified in the PCIe spec for enabling L1SS:
+	 * Spec r6.2, section 5.5.4, mentions the rules for enabling L1SS:
 	 * - When enabling L1.x, enable bit at parent first, then at child
 	 * - When disabling L1.x, disable bit at child first, then at parent
-	 * - When enabling ASPM L1.x, need to disable L1
-	 *   (at child followed by parent).
 	 * - The ASPM/PCIPM L1.2 must be disabled while programming timing
 	 *   parameters
 	 *
@@ -871,16 +883,6 @@ static void pcie_config_aspm_l1ss(struct pcie_link_state *link, u32 state)
 				       PCI_L1SS_CTL1_L1SS_MASK, 0);
 	pci_clear_and_set_config_dword(parent, parent->l1ss + PCI_L1SS_CTL1,
 				       PCI_L1SS_CTL1_L1SS_MASK, 0);
-	/*
-	 * If needed, disable L1, and it gets enabled later
-	 * in pcie_config_aspm_link().
-	 */
-	if (enable_req & (PCIE_LINK_STATE_L1_1 | PCIE_LINK_STATE_L1_2)) {
-		pcie_capability_clear_word(child, PCI_EXP_LNKCTL,
-					   PCI_EXP_LNKCTL_ASPM_L1);
-		pcie_capability_clear_word(parent, PCI_EXP_LNKCTL,
-					   PCI_EXP_LNKCTL_ASPM_L1);
-	}
 
 	val = 0;
 	if (state & PCIE_LINK_STATE_L1_1)
@@ -937,21 +939,33 @@ static void pcie_config_aspm_link(struct pcie_link_state *link, u32 state)
 		dwstream |= PCI_EXP_LNKCTL_ASPM_L1;
 	}
 
+	/*
+	 * Spec r6.2, section 5.5.4, recommends that setting either or both of
+	 * the enable bits for ASPM L1 PM Substates must be done while ASPM L1
+	 * is disabled. So disable L1 here, and it gets enabled later after the
+	 * L1ss configuration has been completed.
+	 *
+	 * Spec r6.2, section 7.5.3.7, mentions that ASPM L1 must be enabled by
+	 * software in the Upstream component on a Link prior to enabling ASPM
+	 * L1 in the Downstream component on the Link. When disabling L1,
+	 * software must disable ASPM L1 in the Downstream component on a Link
+	 * prior to disabling ASPM L1 in the Upstream component on that Link.
+	 *
+	 * Spec doesn't mention L0s.
+	 *
+	 * Disable L1 and L0s here, and they get enabled later after the L1ss
+	 * configuration has been completed.
+	 */
+	list_for_each_entry(child, &linkbus->devices, bus_list)
+		pcie_config_aspm_dev(child, 0);
+	pcie_config_aspm_dev(parent, 0);
+
 	if (link->aspm_capable & PCIE_LINK_STATE_L1SS)
 		pcie_config_aspm_l1ss(link, state);
 
-	/*
-	 * Spec 2.0 suggests all functions should be configured the
-	 * same setting for ASPM. Enabling ASPM L1 should be done in
-	 * upstream component first and then downstream, and vice
-	 * versa for disabling ASPM L1. Spec doesn't mention L0S.
-	 */
-	if (state & PCIE_LINK_STATE_L1)
-		pcie_config_aspm_dev(parent, upstream);
+	pcie_config_aspm_dev(parent, upstream);
 	list_for_each_entry(child, &linkbus->devices, bus_list)
 		pcie_config_aspm_dev(child, dwstream);
-	if (!(state & PCIE_LINK_STATE_L1))
-		pcie_config_aspm_dev(parent, upstream);
 
 	link->aspm_enabled = state;
 
-- 
2.47.0.rc0.187.ge670bccf7e-goog


