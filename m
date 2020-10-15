Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03EC728F985
	for <lists+linux-pci@lfdr.de>; Thu, 15 Oct 2020 21:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391669AbgJOTbR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Oct 2020 15:31:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:59232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391652AbgJOTbD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Oct 2020 15:31:03 -0400
Received: from localhost (170.sub-72-107-125.myvzw.com [72.107.125.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EECC3206DC;
        Thu, 15 Oct 2020 19:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602790263;
        bh=Ts9Ogq/knq60d2xJ/wIIS286CrO21aBQp0RqyebmSj0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BazraFT1uzNK04UCUubGrBQYAlwMBEfJgYU5FqpfKBEP0d0V+dwkQTfK8tKrtUnQa
         qjremlj/mxR95JLaYF4UYhiXCfISKW1wQfjUw1pyHdGm2LOYH4rcLKVBaRU0i6+6Ow
         xKYlgbPcXRB3j0exOaUcopHZwhmv+ox6mZTfA9wA=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Saheed O . Bolarinwa" <refactormyself@gmail.com>
Cc:     Puranjay Mohan <puranjay12@gmail.com>,
        Rajat Jain <rajatja@google.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v3 08/12] PCI/ASPM: Remove struct aspm_register_info.l1ss_ctl2 (unused)
Date:   Thu, 15 Oct 2020 14:30:35 -0500
Message-Id: <20201015193039.12585-9-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201015193039.12585-1-helgaas@kernel.org>
References: <20201015193039.12585-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

We never use the aspm_register_info.l1ss_ctl2 value, so remove it.  No
functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/aspm.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 77316262f982..3afa6c418f54 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -386,14 +386,13 @@ struct aspm_register_info {
 	/* L1 substates */
 	u32 l1ss_cap;
 	u32 l1ss_ctl1;
-	u32 l1ss_ctl2;
 };
 
 static void pcie_get_aspm_reg(struct pci_dev *pdev,
 			      struct aspm_register_info *info)
 {
 	/* Read L1 PM substate capabilities */
-	info->l1ss_cap = info->l1ss_ctl1 = info->l1ss_ctl2 = 0;
+	info->l1ss_cap = info->l1ss_ctl1 = 0;
 
 	if (!pdev->l1ss)
 		return;
@@ -407,8 +406,6 @@ static void pcie_get_aspm_reg(struct pci_dev *pdev,
 
 	pci_read_config_dword(pdev, pdev->l1ss + PCI_L1SS_CTL1,
 			      &info->l1ss_ctl1);
-	pci_read_config_dword(pdev, pdev->l1ss + PCI_L1SS_CTL2,
-			      &info->l1ss_ctl2);
 }
 
 static void pcie_aspm_check_latency(struct pci_dev *endpoint)
-- 
2.25.1

