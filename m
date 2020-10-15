Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB46328F978
	for <lists+linux-pci@lfdr.de>; Thu, 15 Oct 2020 21:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391541AbgJOTaw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Oct 2020 15:30:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:58848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391629AbgJOTaw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Oct 2020 15:30:52 -0400
Received: from localhost (170.sub-72-107-125.myvzw.com [72.107.125.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F245206E5;
        Thu, 15 Oct 2020 19:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602790251;
        bh=p2j/WDrrVUQ9hJ1Htvj6Dt6Xf3cMJEzNnG/RuqjHYO4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lDIdOmKg1go4ppMTJ/ex8NrHpS5zaonqKw2pOCn2CDz5AXy3FRVhhUzkLItONk4eZ
         0S+r9EHHyEn6qCk7RLn1CKyYzuepKpkm4lTz/PMQjBQI9PoghA7cqGSDtLP+hskTVX
         N0Erd53tDnCPNhOJASz4uTDMQUPWK4S0apZbzhmg=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Saheed O . Bolarinwa" <refactormyself@gmail.com>
Cc:     Puranjay Mohan <puranjay12@gmail.com>,
        Rajat Jain <rajatja@google.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v3 02/12] PCI/ASPM: Move LTR path check to where it's used
Date:   Thu, 15 Oct 2020 14:30:29 -0500
Message-Id: <20201015193039.12585-3-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201015193039.12585-1-helgaas@kernel.org>
References: <20201015193039.12585-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

pcie_get_aspm_reg() mostly reads ASPM-related registers, but in some cases
it also updates the value read from PCI_L1SS_CAP based on LTR properties.

Move this update to the point where the value is used to make the code more
readable.

No functional change intended, although previously we could clear
PCI_L1SS_CAP_ASPM_L1_2 for both ends of the link, and now we'll only do it
for the downstream end of a link.  This shouldn't matter because we always
test that bit by ANDing l1ss_cap for the upstream and downstream ends.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/aspm.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 237a423e53ae..386b45eb79ba 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -418,14 +418,6 @@ static void pcie_get_aspm_reg(struct pci_dev *pdev,
 		return;
 	}
 
-	/*
-	 * If we don't have LTR for the entire path from the Root Complex
-	 * to this device, we can't use ASPM L1.2 because it relies on the
-	 * LTR_L1.2_THRESHOLD.  See PCIe r4.0, secs 5.5.4, 6.18.
-	 */
-	if (!pdev->ltr_path)
-		info->l1ss_cap &= ~PCI_L1SS_CAP_ASPM_L1_2;
-
 	pci_read_config_dword(pdev, info->l1ss_cap_ptr + PCI_L1SS_CTL1,
 			      &info->l1ss_ctl1);
 	pci_read_config_dword(pdev, info->l1ss_cap_ptr + PCI_L1SS_CTL2,
@@ -612,7 +604,14 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 	link->latency_up.l1 = calc_l1_latency(upreg.latency_encoding_l1);
 	link->latency_dw.l1 = calc_l1_latency(dwreg.latency_encoding_l1);
 
-	/* Setup L1 substate */
+	/* Setup L1 substate
+	 * If we don't have LTR for the entire path from the Root Complex
+	 * to this device, we can't use ASPM L1.2 because it relies on the
+	 * LTR_L1.2_THRESHOLD.  See PCIe r4.0, secs 5.5.4, 6.18.
+	 */
+	if (!child->ltr_path)
+		dwreg.l1ss_cap &= ~PCI_L1SS_CAP_ASPM_L1_2;
+
 	if (upreg.l1ss_cap & dwreg.l1ss_cap & PCI_L1SS_CAP_ASPM_L1_1)
 		link->aspm_support |= ASPM_STATE_L1_1;
 	if (upreg.l1ss_cap & dwreg.l1ss_cap & PCI_L1SS_CAP_ASPM_L1_2)
-- 
2.25.1

