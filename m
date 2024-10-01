Return-Path: <linux-pci+bounces-13685-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7580E98BDDF
	for <lists+linux-pci@lfdr.de>; Tue,  1 Oct 2024 15:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFA2C284E84
	for <lists+linux-pci@lfdr.de>; Tue,  1 Oct 2024 13:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F9C1C3F3E;
	Tue,  1 Oct 2024 13:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gjZ4AFUQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A057D1BFE02
	for <linux-pci@vger.kernel.org>; Tue,  1 Oct 2024 13:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727789730; cv=none; b=c8sjwM8S0Hv76tF3dQMpxSSo8rpSaeBz6/ou/mSoneSq84TOQIRiw69JoiYgIaouUpvQ+Qe0I8TAf+PH1KWgw3VWSMyWQDX2LX6rcEIIJVuTOHq4EtlmMzbTKsmY40eNAQCpK2N19t55XqPcg0/z0EPmFoNqoJVnPe8lvEM9Va4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727789730; c=relaxed/simple;
	bh=FK/qxSXFYWKosQk0lYk1fxKQ9FBzfdLOLv4ik6/Y7Ws=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=njOmKEt9Cc9be7l0uqDaflnhllO5gmMCvzdaVsudZDYcvS8XwAck2j6q6hViTGNnC8VqZoXHWwCU5SaBNCnOzo4NTZxRdVALKLmeDjJnuQvoVBgJlu09YFW4OYk4PTrsbBmmWpBBqcFurebarCTmVeNMHjMZ/Y6/VEjdB2yM5d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ajayagarwal.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gjZ4AFUQ; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ajayagarwal.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e2261adfdeso81446547b3.2
        for <linux-pci@vger.kernel.org>; Tue, 01 Oct 2024 06:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727789727; x=1728394527; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ANq+ECA+IvHgfg6kZ4ZUsRIsZPn8tej582mOso2TjVw=;
        b=gjZ4AFUQgaq8sigWrY4haamIKMU19TRjjcbYsh7kQddXv1qPjZ7mo0L8qngA2Q0j7W
         sAZtYpIjkPZ7HdDilqNFxiGvyiFTjWzCD+35j3PHSd5bHrSWJpEqKOm3+ARSPYb/RDvT
         eVCliL1i67yyMrGpKlK6bw/BR9lEDtSPTqkN0bYB4h+HE2wX47teQA5WyUPXT1YHMQOD
         5chOftUeHN1tgGH4x8o+fmknRy4IIgJ2nm/V3dyVV9lyjDnD2QAsOda+txqJ6jxtPg7L
         MZphVDFIH810/orQnA7rCB0K7eBmyf2Zdeb/sTMsuUC111KYLZUb98AphfBUd7dJ4Dwv
         H8gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727789727; x=1728394527;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ANq+ECA+IvHgfg6kZ4ZUsRIsZPn8tej582mOso2TjVw=;
        b=YqzIE0DpCZqEVPPtzYJQK65cWMmoyU/Ifl9fKH9SPIivttdM/roRcsKKuHRz20g9ya
         p+SevPoiMK139iQPTgvMyvuXOIuiDvRxMiY4PvgrLkAP1NzaSzfPLjGDZvOpP2uP0yMF
         C43nJ3+nbBas07nOxiVBXkkCo19LJVkFH8/aBS1nFyFnN/OkXKpkwfkFyKCtWPLRur+b
         VXLV0fHwnXzMvYRju465B/KTcidbKHCepZFKEzju4K9TNyu8YiOkKCeoF4WW/qRsasv0
         gDDo6K/kTFS93Iz4vtngUOVPftA6QtcadfJs6GuZbJLRvnhGw37SrU7bjOO0QGI2zQFv
         a11g==
X-Gm-Message-State: AOJu0YxmVr45fqxqBbGwYrU6+RddoeGmc8UNUxMJP7Mp3ZkSLUi/YCcv
	9dNyr62w9r2rJEFNst/Wj2PctNh7rAt5fT72esSMf5YwXBO2+XMeDneVJOzRdEmKrRxXZ6q3OWt
	V1t/TopvYzM7No6kInR8Hgg==
X-Google-Smtp-Source: AGHT+IFSKycEdIDMTFqMuEM2dGdxN7sbM+Y2EWdRRETRWWmtMWi1kkO+1rjs2DvIecOjdUS6Z6aaRsQ/aHj2M94zcA==
X-Received: from ajaya.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:39b5])
 (user=ajayagarwal job=sendgmr) by 2002:a05:690c:3708:b0:6db:afa4:75d3 with
 SMTP id 00721157ae682-6e2475a7f21mr5766997b3.3.1727789727554; Tue, 01 Oct
 2024 06:35:27 -0700 (PDT)
Date: Tue,  1 Oct 2024 19:05:18 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Message-ID: <20241001133519.2743673-1-ajayagarwal@google.com>
Subject: [PATCH] PCI/ASPM: Disable L1 before disabling L1ss
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
 drivers/pci/pcie/aspm.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index cee2365e54b8..d37f66f9e9c8 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -848,16 +848,14 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 /* Configure the ASPM L1 substates */
 static void pcie_config_aspm_l1ss(struct pcie_link_state *link, u32 state)
 {
-	u32 val, enable_req;
+	u32 val;
 	struct pci_dev *child = link->downstream, *parent = link->pdev;
 
-	enable_req = (link->aspm_enabled ^ state) & state;
-
 	/*
 	 * Here are the rules specified in the PCIe spec for enabling L1SS:
 	 * - When enabling L1.x, enable bit at parent first, then at child
 	 * - When disabling L1.x, disable bit at child first, then at parent
-	 * - When enabling ASPM L1.x, need to disable L1
+	 * - When enabling/disabling ASPM L1.x, need to disable L1
 	 *   (at child followed by parent).
 	 * - The ASPM/PCIPM L1.2 must be disabled while programming timing
 	 *   parameters
@@ -866,21 +864,17 @@ static void pcie_config_aspm_l1ss(struct pcie_link_state *link, u32 state)
 	 * what is needed.
 	 */
 
+	/* Disable L1, and it gets enabled later in pcie_config_aspm_link() */
+	pcie_capability_clear_word(child, PCI_EXP_LNKCTL,
+				   PCI_EXP_LNKCTL_ASPM_L1);
+	pcie_capability_clear_word(parent, PCI_EXP_LNKCTL,
+				   PCI_EXP_LNKCTL_ASPM_L1);
+
 	/* Disable all L1 substates */
 	pci_clear_and_set_config_dword(child, child->l1ss + PCI_L1SS_CTL1,
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
-- 
2.46.1.824.gd892dcdcdd-goog


