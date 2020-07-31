Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8DA2345FD
	for <lists+linux-pci@lfdr.de>; Fri, 31 Jul 2020 14:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733153AbgGaMnL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 31 Jul 2020 08:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733101AbgGaMnL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 31 Jul 2020 08:43:11 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFAE3C061574;
        Fri, 31 Jul 2020 05:43:10 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id i26so18944731edv.4;
        Fri, 31 Jul 2020 05:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=kTEKWlV4nOSheNgHEWqv/22qBE+Vx8ikH8s2qmj4c7s=;
        b=t0dpG410UoQ/AaCrJfLmpl35pb7gf3W1ueoUC8Kx/JGEDzX7QhXn5oMP733MHTQBAs
         4LHic3AIM6xJiSRqq86G0JWPXwCyYpMFkw1J37Hgzea7FX23P8viHUNdV3GNCMT2+KyH
         30SP4kpBZIQ7kkMIRQBBtv/0a0tqGNdn7OGEPahzFad8ybt4zUqY/+DIhgIkc4MH7WBE
         Ipg+7wJV93OZWFJfr80g3CHPMHWQlOpprwu9VAiS83J2a5O9VqKZzPcK9J7TRQ4wD5Eh
         ClijEVwOSSt5Ab03vnsaD5eKXzsZszfeQxc31WMyDT2QiXIB5oa54S3zN/3m8F1OluCA
         +QkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kTEKWlV4nOSheNgHEWqv/22qBE+Vx8ikH8s2qmj4c7s=;
        b=nwYo8B/lD+q4CkN1IQMnYPdG0Mx6EH6sKJnoyC95KIMzeN0l/0aulw7FtVi6nJOwS9
         q+Eq3Koew9N5/yvDH2/Kh/kLVJCAMkUSO8CIIyEn3V7HVrDeqSnWZaECYfJ8VLl06VX2
         EddxUqXX9f4qFTOVidds5h0g9/pRuH7Lpmqfe3Ml28P00vjqat+6FL5+3ZhMX6v92v5v
         CMRTGTXB8qH6lXeUj+F5mu1itapJbtbrTso7ZaSE77n/V/aN0kcQP1J1XYfopdbGXSxC
         aqjeTVfXue7/n8n4Z6HvP8HDRTzjPmA31uYRwD2VGPBXamHNPbuMaTHZxEwG/TOzcNNJ
         dtwA==
X-Gm-Message-State: AOAM5314rgExP9jC4NxyxKdpJOYUfyyrhSM5VxiGrlRVA+AkuXs+E6Un
        rW8eFpETwgxvrlhnV5/UeDs=
X-Google-Smtp-Source: ABdhPJx87fnYc/ryc1eaPTpKu9cM5/FUxmCOhynUIBbPcaF0NGu/M6CJK7gWLKoZuQT408yhWdXUOA==
X-Received: by 2002:aa7:c45a:: with SMTP id n26mr3749694edr.45.1596199389154;
        Fri, 31 Jul 2020 05:43:09 -0700 (PDT)
Received: from net.saheed (95C84E0A.dsl.pool.telekom.hu. [149.200.78.10])
        by smtp.gmail.com with ESMTPSA id g23sm8668514ejb.24.2020.07.31.05.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 05:43:08 -0700 (PDT)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     helgaas@kernel.org
Cc:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        bjorn@helgaas.com, skhan@linuxfoundation.org,
        linux-pci@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 08/12] PCI: Check if pcie_capability_read_*() reads ~0
Date:   Fri, 31 Jul 2020 13:43:25 +0200
Message-Id: <20200731114329.100848-1-refactormyself@gmail.com>
X-Mailer: git-send-email 2.18.4
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On failure pcie_capability_read_*() sets it's last parameter, val
to 0. However, with Patch 12/12, it is possible that val is set
to ~0 on failure. This would introduce a bug because
(x & x) == (~0 & x).

Since ~0 is an invalid value in here,

Add extra check for ~0 in the if condition to ensure success or
failure.

Suggested-by: Bjorn Helgaas <bjorn@helgaas.com>
Signed-off-by: Saheed O. Bolarinwa <refactormyself@gmail.com>
---
 drivers/pci/probe.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 2f66988cea25..af95f67c19a7 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1124,7 +1124,7 @@ static void pci_enable_crs(struct pci_dev *pdev)
 
 	/* Enable CRS Software Visibility if supported */
 	pcie_capability_read_word(pdev, PCI_EXP_RTCAP, &root_cap);
-	if (root_cap & PCI_EXP_RTCAP_CRSVIS)
+	if ((root_cap != (u16)~0) && (root_cap & PCI_EXP_RTCAP_CRSVIS))
 		pcie_capability_set_word(pdev, PCI_EXP_RTCTL,
 					 PCI_EXP_RTCTL_CRSSVE);
 }
@@ -1521,7 +1521,7 @@ void set_pcie_hotplug_bridge(struct pci_dev *pdev)
 	u32 reg32;
 
 	pcie_capability_read_dword(pdev, PCI_EXP_SLTCAP, &reg32);
-	if (reg32 & PCI_EXP_SLTCAP_HPC)
+	if ((reg32 != (u32)~0) && (reg32 & PCI_EXP_SLTCAP_HPC))
 		pdev->is_hotplug_bridge = 1;
 }
 
@@ -2060,7 +2060,7 @@ bool pcie_relaxed_ordering_enabled(struct pci_dev *dev)
 
 	pcie_capability_read_word(dev, PCI_EXP_DEVCTL, &v);
 
-	return !!(v & PCI_EXP_DEVCTL_RELAX_EN);
+	return ((v != (u16)~0) && (v & PCI_EXP_DEVCTL_RELAX_EN));
 }
 EXPORT_SYMBOL(pcie_relaxed_ordering_enabled);
 
@@ -2101,11 +2101,11 @@ static void pci_configure_ltr(struct pci_dev *dev)
 		return;
 
 	pcie_capability_read_dword(dev, PCI_EXP_DEVCAP2, &cap);
-	if (!(cap & PCI_EXP_DEVCAP2_LTR))
+	if ((cap == (u32)~0) || !(cap & PCI_EXP_DEVCAP2_LTR))
 		return;
 
 	pcie_capability_read_dword(dev, PCI_EXP_DEVCTL2, &ctl);
-	if (ctl & PCI_EXP_DEVCTL2_LTR_EN) {
+	if ((ctl != (u32)~0) && (ctl & PCI_EXP_DEVCTL2_LTR_EN)) {
 		if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT) {
 			dev->ltr_path = 1;
 			return;
@@ -2147,7 +2147,7 @@ static void pci_configure_eetlp_prefix(struct pci_dev *dev)
 		return;
 
 	pcie_capability_read_dword(dev, PCI_EXP_DEVCAP2, &cap);
-	if (!(cap & PCI_EXP_DEVCAP2_EE_PREFIX))
+	if ((cap == (u32)~0) || !(cap & PCI_EXP_DEVCAP2_EE_PREFIX))
 		return;
 
 	pcie_type = pci_pcie_type(dev);
-- 
2.18.4

