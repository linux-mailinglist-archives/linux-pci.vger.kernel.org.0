Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC1EF28F979
	for <lists+linux-pci@lfdr.de>; Thu, 15 Oct 2020 21:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391638AbgJOTa7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Oct 2020 15:30:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:58938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391630AbgJOTay (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Oct 2020 15:30:54 -0400
Received: from localhost (170.sub-72-107-125.myvzw.com [72.107.125.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26C60206DC;
        Thu, 15 Oct 2020 19:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602790253;
        bh=A6GOy1297OFSjOFxP8sRZqYqoBjX7BnzTmvMbvnJmaM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rYha7sjs8IzJX4w2g7ssdZjmCDjXsmJ2w3mI7j/frN31c9O3L4QxRHqEfbhjy1K2i
         0koYM0dZM/ESxtspNOqFiZJs5ySbHT81bTVkbAdBEXuXzKed/2maSP/lGjvieV2Go1
         nF4Eoax9OqkO8WGT+fmw30kwO6fhGAxTu1P30ogE=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Saheed O . Bolarinwa" <refactormyself@gmail.com>
Cc:     Puranjay Mohan <puranjay12@gmail.com>,
        Rajat Jain <rajatja@google.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v3 03/12] PCI/ASPM: Use 'parent' and 'child' for readability
Date:   Thu, 15 Oct 2020 14:30:30 -0500
Message-Id: <20201015193039.12585-4-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201015193039.12585-1-helgaas@kernel.org>
References: <20201015193039.12585-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Other users of link->pdev and link->downstream, e.g., pcie_aspm_cap_init(),
pcie_config_aspm_l1ss(), and pcie_config_aspm_link(), use "parent" and
"child" as local names.

Do the same in aspm_calc_l1ss_info() for readability.  No functional change
intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/aspm.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 386b45eb79ba..0725511cbeb5 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -501,6 +501,7 @@ static void aspm_calc_l1ss_info(struct pcie_link_state *link,
 				struct aspm_register_info *upreg,
 				struct aspm_register_info *dwreg)
 {
+	struct pci_dev *child = link->downstream, *parent = link->pdev;
 	u32 val1, val2, scale1, scale2;
 	u32 t_common_mode, t_power_on, l1_2_threshold, scale, value;
 
@@ -522,13 +523,13 @@ static void aspm_calc_l1ss_info(struct pcie_link_state *link,
 	val2   = (dwreg->l1ss_cap & PCI_L1SS_CAP_P_PWR_ON_VALUE) >> 19;
 	scale2 = (dwreg->l1ss_cap & PCI_L1SS_CAP_P_PWR_ON_SCALE) >> 16;
 
-	if (calc_l1ss_pwron(link->pdev, scale1, val1) >
-	    calc_l1ss_pwron(link->downstream, scale2, val2)) {
+	if (calc_l1ss_pwron(parent, scale1, val1) >
+	    calc_l1ss_pwron(child, scale2, val2)) {
 		link->l1ss.ctl2 |= scale1 | (val1 << 3);
-		t_power_on = calc_l1ss_pwron(link->pdev, scale1, val1);
+		t_power_on = calc_l1ss_pwron(parent, scale1, val1);
 	} else {
 		link->l1ss.ctl2 |= scale2 | (val2 << 3);
-		t_power_on = calc_l1ss_pwron(link->downstream, scale2, val2);
+		t_power_on = calc_l1ss_pwron(child, scale2, val2);
 	}
 
 	/*
-- 
2.25.1

