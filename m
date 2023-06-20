Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5169E736DB6
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jun 2023 15:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233108AbjFTNrL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Jun 2023 09:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233119AbjFTNrF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Jun 2023 09:47:05 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 253E610DA;
        Tue, 20 Jun 2023 06:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687268824; x=1718804824;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UMIoWsdWQzGe176WOqbLzmgkyd8+D96MIeaVPsulAxo=;
  b=V5C0dWb+giCXNOgy5bGtNN/R50CTz7QSbFYKiup//HLO1BVIpINSSDIE
   gN1jASqAD228MxD8mFTG32HPXe/+ni01+Vw2ndHuhs2yrzyOfMRq2t0Go
   qFhcTskzP0NPKuAfnAB7q4GULAa4EySlVX4GYHk4ZnO3QUgTTuidPXD1z
   PAqnL3jNzuyRxTq/BbgI5xMK/QqnjHFEZWMlyFg4ffF278IluXyqAw4mG
   O3/YWg09ykFKrY3fvnNotPZdxfD10EG+BKwbpT9549vOPH2yIvoaWbNjx
   5xVZwHcK+kSnJ2tKzv3x2/fXftvBDUaWRDnzrBAV1z4Raqdozlo9b310g
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="362401367"
X-IronPort-AV: E=Sophos;i="6.00,257,1681196400"; 
   d="scan'208";a="362401367"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 06:47:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="827006702"
X-IronPort-AV: E=Sophos;i="6.00,257,1681196400"; 
   d="scan'208";a="827006702"
Received: from eshaanan-mobl.ger.corp.intel.com (HELO ijarvine-mobl2.ger.corp.intel.com) ([10.252.61.137])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 06:46:59 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        Jesse Barnes <jbarnes@virtuousgeek.org>,
        Yinghai Lu <yinghai@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Dean Luick <dean.luick@cornelisnetworks.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        stable@vger.kernel.org
Subject: [PATCH v3 03/10] PCI: pciehp: Use RMW accessors for changing LNKCTL
Date:   Tue, 20 Jun 2023 16:46:17 +0300
Message-Id: <20230620134624.99688-4-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230620134624.99688-1-ilpo.jarvinen@linux.intel.com>
References: <20230620134624.99688-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

As hotplug is not the only driver touching LNKCTL, use the RMW
capability accessor which handles concurrent changes correctly.

Fixes: 7f822999e12a ("PCI: pciehp: Add Disable/enable link functions")
Suggested-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Acked-by: Rafael J. Wysocki <rafael@kernel.org>
Cc: stable@vger.kernel.org
---
 drivers/pci/hotplug/pciehp_hpc.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index f8c70115b691..26623e2884a3 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -332,17 +332,11 @@ int pciehp_check_link_status(struct controller *ctrl)
 static int __pciehp_link_set(struct controller *ctrl, bool enable)
 {
 	struct pci_dev *pdev = ctrl_dev(ctrl);
-	u16 lnk_ctrl;
 
-	pcie_capability_read_word(pdev, PCI_EXP_LNKCTL, &lnk_ctrl);
+	pcie_capability_clear_and_set_word(pdev, PCI_EXP_LNKCTL,
+					   PCI_EXP_LNKCTL_LD,
+					   !enable ? PCI_EXP_LNKCTL_LD : 0);
 
-	if (enable)
-		lnk_ctrl &= ~PCI_EXP_LNKCTL_LD;
-	else
-		lnk_ctrl |= PCI_EXP_LNKCTL_LD;
-
-	pcie_capability_write_word(pdev, PCI_EXP_LNKCTL, lnk_ctrl);
-	ctrl_dbg(ctrl, "%s: lnk_ctrl = %x\n", __func__, lnk_ctrl);
 	return 0;
 }
 
-- 
2.30.2

