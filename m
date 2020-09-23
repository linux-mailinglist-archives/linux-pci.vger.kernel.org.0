Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 085312764EE
	for <lists+linux-pci@lfdr.de>; Thu, 24 Sep 2020 02:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgIXAOx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Sep 2020 20:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbgIXAOw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Sep 2020 20:14:52 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85799C0613CE
        for <linux-pci@vger.kernel.org>; Wed, 23 Sep 2020 17:14:52 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id g4so1615104edk.0
        for <linux-pci@vger.kernel.org>; Wed, 23 Sep 2020 17:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=avYflrEIwbhH8rFwntiZPPaA0Uaq3GfuFh1DgQVMGyA=;
        b=bViPTjYGohP3TkXs0XHXvYKjAbzGCgNpFCb9T2+UqfqV125TP2o8NzpbFNkgJNfVzR
         KP26tlLOK4MqzbU40ct5Dt/hqzrIBInjpIBPWyaAtnejRuUxxXK2ZzV6kSxEZdYyjB2R
         dhbZsY1wz3d74AG3V9uu00C5u0ZZ1/LMZUNx7Z6ExN3PdZMqHwUra1rc7dI8L0u/MBYi
         7yh/WqzFThF4ozOr4FGf4fW7niqLIwMnJGYToDJ3M55QfudFw3FC/HxKErEpOGvNzmyd
         hLZi9GeI7uzw2OA3UqYlcVf5gwwpCeYKjWRi6Uh6YurehBDW2x6i+hxQeuKr+tU367+9
         /pUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=avYflrEIwbhH8rFwntiZPPaA0Uaq3GfuFh1DgQVMGyA=;
        b=MTSshsPdv7pNn6yHqLIT5uIt55k/bh2wbt5N0N6AeB7Wz/oRgkfjrzzb8FQtFfSDxF
         txdsFJIUbDJ7gN0c2Ulbld9t++Tk8VSCRT5vW1S4TyLRjt3Rz6M5+y60Y9OGkloUS9Ns
         I1yuy2yKG9gqtueJFLoM9nkHCen+7CdeTHVJea19kjuBSzWE0km87GQQeSNjRCEzzRs8
         TBmcF/3ycwOzn6Birs7eXo54Ej4wZUuR01T780vnwwN2HG5Ea+MLJkaa+Y0srWMwXH76
         vi0Tx9NsynQh9R31b5a7PrSbx0n5/o+E+KewXONf0B8nDTmWMYrv3nDkcJDZbfWu4SMV
         LdwA==
X-Gm-Message-State: AOAM530OtMjopHevab9Fz0L6xMoes3vJ80HbGJnCeJdQVewxO9lIIQk8
        VojJzVdpWDHqrdNkRrdJeQA=
X-Google-Smtp-Source: ABdhPJyuU611U2J2wVPyfP4BwFcuCSceoZ0GRUlVHyqhYV2EmXtfaelObsGZOpZUqCsku0di9uH4wQ==
X-Received: by 2002:a05:6402:10c9:: with SMTP id p9mr1983528edu.156.1600906491248;
        Wed, 23 Sep 2020 17:14:51 -0700 (PDT)
Received: from net.saheed (5402C65D.dsl.pool.telekom.hu. [84.2.198.93])
        by smtp.gmail.com with ESMTPSA id r9sm1026559ejc.102.2020.09.23.17.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 17:14:50 -0700 (PDT)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     helgaas@kernel.org
Cc:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH 2/8] PCI/ASPM: Rework calc_l*_latency() to take a struct pci_dev
Date:   Thu, 24 Sep 2020 01:15:11 +0200
Message-Id: <20200923231517.221310-3-refactormyself@gmail.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20200923231517.221310-1-refactormyself@gmail.com>
References: <20200923231517.221310-1-refactormyself@gmail.com>
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

