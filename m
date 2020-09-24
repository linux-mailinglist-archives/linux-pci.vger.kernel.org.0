Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4D627752F
	for <lists+linux-pci@lfdr.de>; Thu, 24 Sep 2020 17:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728434AbgIXPYQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Sep 2020 11:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728285AbgIXPYQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Sep 2020 11:24:16 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3A46C0613CE
        for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2020 08:24:15 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id q13so5013741ejo.9
        for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2020 08:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=avYflrEIwbhH8rFwntiZPPaA0Uaq3GfuFh1DgQVMGyA=;
        b=XIvFWIgZBWyNZUkBfc2w/RllzBf6qyCAhpJJ+GV0SOqJwljpEP755cERzLLkV88jc4
         jLPeSRpxL08ldJVwiaQuc5METfOcB0sd84kS1e9VPBX1B9bqMd+Gi+1rm3Xd1QzrioQm
         gaUjs2xaoL0I51k7QcmLnMcxCNcubQ5fszwmU8DJNtssUBtt5WGqsND/FUUQDjMVAX8e
         hhh30k7Q9Vzl/2veiiTqgp7go7GknGRsXRXIvFDzBQpk8VpeE3bSy0aB7pFTqar+zGIq
         GtcS/5vRLjkDVhhJ7rXF3GRB8f9FsDEmUWfnQrvloiLBXwJjD623gt/BPXURQsFEjCQj
         9zCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=avYflrEIwbhH8rFwntiZPPaA0Uaq3GfuFh1DgQVMGyA=;
        b=iqxSywImfNott6mmKy/UAWY5JpYDG0x9gTySTKqUEPs+s0e7MT0Ll1ZdGPZvlZWKwU
         O7AR5TcusJXnus1nJEaVBAxTM6k63E06/K7EJTBMwMjL4/UUoAnItt3LdF7iTh2nBqHp
         Xw8sl99Ujs78yRn3bTkXtw4FwCkrclYyqJy0nXjny+6uQ4bs8/ezTHEdP5QnfqeltGoq
         5dDSGpW3tPQxuEN/xvECLC2/CivA8GJmspqZ0Idws4yIwhHBsUioqPLVYT5aNyJ7AH3V
         8VJWTC52aXZ5dJ0O7wrlWgtOdzN4xC0Hi6Gy7UyqedrShF7B9CijphT3EWfhtfAke7vu
         bifQ==
X-Gm-Message-State: AOAM533adDsYiNCWFEjl0DeVm8Be2jPiKoTMnAsRcqQaPOOJ732Sah8e
        R+3XEf+71lJZn3B9dEOOFEgMPd90UBX7hg==
X-Google-Smtp-Source: ABdhPJxNO0zSRK57nZRgxmDoeCO3EdntHuEtrUNmcHzEbiM0RV369GE8ehUpcFwQ0I3ukJkcaCAWxQ==
X-Received: by 2002:a17:906:841a:: with SMTP id n26mr401568ejx.213.1600961054450;
        Thu, 24 Sep 2020 08:24:14 -0700 (PDT)
Received: from net.saheed (5402C65D.dsl.pool.telekom.hu. [84.2.198.93])
        by smtp.gmail.com with ESMTPSA id i7sm2641735ejo.22.2020.09.24.08.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 08:24:13 -0700 (PDT)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     helgaas@kernel.org
Cc:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH v2 2/7] PCI/ASPM: Rework calc_l*_latency() to take a struct pci_dev
Date:   Thu, 24 Sep 2020 16:24:38 +0200
Message-Id: <20200924142443.260861-3-refactormyself@gmail.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20200924142443.260861-1-refactormyself@gmail.com>
References: <20200924142443.260861-1-refactormyself@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

 - Change the argument of calc_l0s_latency() to  pci_dev *,
 - Compute latency_encoding_l0s encoding inside calc_l0s_latency()
 - Compute latency_encoding_l1 encoding inside calc_l1_latency()
 - Make calc_l*_latency() take only pci_dev *,
 - Make callers to calc_l0s_latency() and calc_l1_latency() pass
   in struct pci_dev
 - In pcie_get_aspm_reg() remove assignments to the latency encodings
 - Remove aspm_register_info.latency_encoding_l1
 - Remove aspm_register_info.latency_encoding_l0s

Signed-off-by: Saheed O. Bolarinwa <refactormyself@gmail.com>
---
 drivers/pci/pcie/aspm.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index d7e69b3595a0..5f7cf47b6a40 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -306,8 +306,10 @@ static void pcie_aspm_configure_common_clock(struct pcie_link_state *link)
 }
 
 /* Convert L0s latency encoding to ns */
-static u32 calc_l0s_latency(u32 encoding)
+static u32 calc_l0s_latency(struct pci_dev *pdev)
 {
+	u32 encoding = (pdev->lnkcap & PCI_EXP_LNKCAP_L0SEL) >> 12;
+
 	if (encoding == 0x7)
 		return (5 * 1000);	/* > 4us */
 	return (64 << encoding);
@@ -322,8 +324,10 @@ static u32 calc_l0s_acceptable(u32 encoding)
 }
 
 /* Convert L1 latency encoding to ns */
-static u32 calc_l1_latency(u32 encoding)
+static u32 calc_l1_latency(struct pci_dev *pdev)
 {
+	u32 encoding = (pdev->lnkcap & PCI_EXP_LNKCAP_L1EL) >> 15;
+
 	if (encoding == 0x7)
 		return (65 * 1000);	/* > 64us */
 	return (1000 << encoding);
@@ -381,8 +385,6 @@ static void encode_l12_threshold(u32 threshold_us, u32 *scale, u32 *value)
 struct aspm_register_info {
 	u32 support:2;
 	u32 enabled:2;
-	u32 latency_encoding_l0s;
-	u32 latency_encoding_l1;
 
 	/* L1 substates */
 	u32 l1ss_cap_ptr;
@@ -398,8 +400,6 @@ static void pcie_get_aspm_reg(struct pci_dev *pdev,
 	u32 reg32 = pdev->lnkcap;
 
 	info->support = (reg32 & PCI_EXP_LNKCAP_ASPMS) >> 10;
-	info->latency_encoding_l0s = (reg32 & PCI_EXP_LNKCAP_L0SEL) >> 12;
-	info->latency_encoding_l1  = (reg32 & PCI_EXP_LNKCAP_L1EL) >> 15;
 	pcie_capability_read_word(pdev, PCI_EXP_LNKCTL, &reg16);
 	info->enabled = reg16 & PCI_EXP_LNKCTL_ASPMC;
 
@@ -587,16 +587,16 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 		link->aspm_enabled |= ASPM_STATE_L0S_UP;
 	if (upreg.enabled & PCIE_LINK_STATE_L0S)
 		link->aspm_enabled |= ASPM_STATE_L0S_DW;
-	link->latency_up.l0s = calc_l0s_latency(upreg.latency_encoding_l0s);
-	link->latency_dw.l0s = calc_l0s_latency(dwreg.latency_encoding_l0s);
+	link->latency_up.l0s = calc_l0s_latency(parent);
+	link->latency_dw.l0s = calc_l0s_latency(child);
 
 	/* Setup L1 state */
 	if (upreg.support & dwreg.support & PCIE_LINK_STATE_L1)
 		link->aspm_support |= ASPM_STATE_L1;
 	if (upreg.enabled & dwreg.enabled & PCIE_LINK_STATE_L1)
 		link->aspm_enabled |= ASPM_STATE_L1;
-	link->latency_up.l1 = calc_l1_latency(upreg.latency_encoding_l1);
-	link->latency_dw.l1 = calc_l1_latency(dwreg.latency_encoding_l1);
+	link->latency_up.l1 = calc_l1_latency(parent);
+	link->latency_dw.l1 = calc_l1_latency(child);
 
 	/* Setup L1 substate */
 	if (upreg.l1ss_cap & dwreg.l1ss_cap & PCI_L1SS_CAP_ASPM_L1_1)
-- 
2.18.4

