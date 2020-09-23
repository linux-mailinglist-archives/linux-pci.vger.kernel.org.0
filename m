Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4F072764EF
	for <lists+linux-pci@lfdr.de>; Thu, 24 Sep 2020 02:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgIXAOy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Sep 2020 20:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbgIXAOy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Sep 2020 20:14:54 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB6DCC0613CE
        for <linux-pci@vger.kernel.org>; Wed, 23 Sep 2020 17:14:53 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id k14so1605374edo.1
        for <linux-pci@vger.kernel.org>; Wed, 23 Sep 2020 17:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gqOo9sRKsu8OklEdZbxfDsKXZHiV2LQufDSEO7PGLPM=;
        b=qwMu1d9cN2u3F4Vq1BCz/BrY+tG0KkT+iBJwkq5tkHnOjeFVSQ4YiYTHdQ295mgFBw
         l66p8OOPjrDA+YWosty+8eGZjlVCfAE2PiL8ZO7HoGZ5ejgQ6b6kOZAZwP7Xm1YebOy5
         e8WYDVoXPweMqskM3s0XwNjL7Pq+MZyKn38iOL93Y/1knUX2AiJ8m0dM9oB4CBgSYXF5
         n4L3fDCis6UGKkh6k1g59LaMSRqSftCmHlYNHVR5pzRdus5cdhs7ZIos+N+3lKhsKsaq
         uTr2vJd3PoShty0naEFEKV3Tj9RZR7fv5GF9ikIPcbkWUCyZr8uhNMNqQv4jLSUy0BKa
         LpNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gqOo9sRKsu8OklEdZbxfDsKXZHiV2LQufDSEO7PGLPM=;
        b=RPjCfYsxgnXSW/W1SXj/4IEQF52AfT46dL48QYoOaCEL+8Vavouvktf3CTYCDOvrYn
         zceoGqFAjKBdt7viogyVD8n/Wc8RY8u+KUuvfIRlIvo18mclWihqkfPDRxEZWFfb66vP
         pjkW/vmLTKB/VM6D0t3hwULpa2ddRghuSviHIccoV2dSnaj0nrqdk/wG0bIB2breEGcF
         yir9As3MzSpKNvTuNJeENR3uu/+w4myFsKiaK4XJ7njnA5tsPHCgnDw7FEPlSnjN34kq
         l3s6SLJd8m3pIusatxfjo8sA4bkK4Q1ItxnM7tBUifRQNFnnUi9JU438SJ3LLwkG1ed5
         wAfQ==
X-Gm-Message-State: AOAM532IXLIqLYz6wy/MDm3JQxhB0SJnMNjzPMMgnqEA188k7GrahWs6
        jKK0q295uQu1io4CcLJDhTw=
X-Google-Smtp-Source: ABdhPJzrtfxhKIlDd4w8QsFQYW1taNVNZGl6pcPKDb+S5nGtYmd3ea3tJRhOXc4SluOrIRNUC0za7w==
X-Received: by 2002:aa7:db02:: with SMTP id t2mr1866598eds.95.1600906492342;
        Wed, 23 Sep 2020 17:14:52 -0700 (PDT)
Received: from net.saheed (5402C65D.dsl.pool.telekom.hu. [84.2.198.93])
        by smtp.gmail.com with ESMTPSA id r9sm1026559ejc.102.2020.09.23.17.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 17:14:51 -0700 (PDT)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     helgaas@kernel.org
Cc:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH 3/8] PCI/ASPM: Compute the value of aspm_register_info.support directly
Date:   Thu, 24 Sep 2020 01:15:12 +0200
Message-Id: <20200923231517.221310-4-refactormyself@gmail.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20200923231517.221310-1-refactormyself@gmail.com>
References: <20200923231517.221310-1-refactormyself@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

 - Calculate aspm_register_info.support inside aspm_support()
 - Replace references to aspm_register_info.support with aspm_support().
 - In pcie_get_aspm_reg() remove assignment to aspm_register_info.support
 - Remove aspm_register_info.support

Signed-off-by: Saheed O. Bolarinwa <refactormyself@gmail.com>
---
 drivers/pci/pcie/aspm.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 5f7cf47b6a40..321b328347c1 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -383,7 +383,6 @@ static void encode_l12_threshold(u32 threshold_us, u32 *scale, u32 *value)
 }
 
 struct aspm_register_info {
-	u32 support:2;
 	u32 enabled:2;
 
 	/* L1 substates */
@@ -396,12 +395,10 @@ struct aspm_register_info {
 static void pcie_get_aspm_reg(struct pci_dev *pdev,
 			      struct aspm_register_info *info)
 {
-	u16 reg16;
-	u32 reg32 = pdev->lnkcap;
+	u16 ctl;
 
-	info->support = (reg32 & PCI_EXP_LNKCAP_ASPMS) >> 10;
-	pcie_capability_read_word(pdev, PCI_EXP_LNKCTL, &reg16);
-	info->enabled = reg16 & PCI_EXP_LNKCTL_ASPMC;
+	pcie_capability_read_word(pdev, PCI_EXP_LNKCTL, &ctl);
+	info->enabled = ctl & PCI_EXP_LNKCTL_ASPMC;
 
 	/* Read L1 PM substate capabilities */
 	info->l1ss_cap = info->l1ss_ctl1 = info->l1ss_ctl2 = 0;
@@ -540,6 +537,11 @@ static void aspm_calc_l1ss_info(struct pcie_link_state *link,
 	link->l1ss.ctl1 |= t_common_mode << 8 | scale << 29 | value << 16;
 }
 
+static void aspm_support(struct pci_dev *pdev)
+{
+	return (pdev->lnkcap & PCI_EXP_LNKCAP_ASPMS) >> 10;
+}
+
 static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 {
 	struct pci_dev *child = link->downstream, *parent = link->pdev;
@@ -561,7 +563,7 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 	 * If ASPM not supported, don't mess with the clocks and link,
 	 * bail out now.
 	 */
-	if (!(upreg.support & dwreg.support))
+	if (!(aspm_support(parent) & aspm_support(child)))
 		return;
 
 	/* Configure common clock before checking latencies */
@@ -581,8 +583,9 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 	 * given link unless components on both sides of the link each
 	 * support L0s.
 	 */
-	if (dwreg.support & upreg.support & PCIE_LINK_STATE_L0S)
+	if (aspm_support(parent) & aspm_support(child) & PCIE_LINK_STATE_L0S)
 		link->aspm_support |= ASPM_STATE_L0S;
+
 	if (dwreg.enabled & PCIE_LINK_STATE_L0S)
 		link->aspm_enabled |= ASPM_STATE_L0S_UP;
 	if (upreg.enabled & PCIE_LINK_STATE_L0S)
@@ -591,8 +594,9 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 	link->latency_dw.l0s = calc_l0s_latency(child);
 
 	/* Setup L1 state */
-	if (upreg.support & dwreg.support & PCIE_LINK_STATE_L1)
+	if (aspm_support(parent) & aspm_support(child) & PCIE_LINK_STATE_L1)
 		link->aspm_support |= ASPM_STATE_L1;
+
 	if (upreg.enabled & dwreg.enabled & PCIE_LINK_STATE_L1)
 		link->aspm_enabled |= ASPM_STATE_L1;
 	link->latency_up.l1 = calc_l1_latency(parent);
-- 
2.18.4

