Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2125B7065BE
	for <lists+linux-pci@lfdr.de>; Wed, 17 May 2023 12:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbjEQK42 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 May 2023 06:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjEQK4P (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 May 2023 06:56:15 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B07485FF2;
        Wed, 17 May 2023 03:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684320950; x=1715856950;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oQGiwha8nBCPw0dYXTKDHb6UO5GBkLH0JbFNx1k4Cvs=;
  b=m2zTcw8NyCBr8hNlIB1D4j0yecK3BpXycUzEUhvWV+AfIaIIsVvtnSAu
   0KHmRPu45vlw6FQRsq7pyYqvOD6QUBFBbyq+NQg5eVD+8zXamlKRj210W
   FJuWSu3dL7dMNEvtS+4sRGg2CURMU5g5U8xiqCK08j/6rZ1mT+kRuoVBZ
   ShTmBDmpOSOdV7HNxM7LfxgwEv5PO6xDbJvbEUuo2zl9UYVm4eI8P0jzO
   5b07d4rbYbH4W8vzETG1TR0Cl6/sQSOcVeVVejIpHG2Is/l4u7JXbpkwg
   u2bQJ/W3YPtewXQaOaps0oM2EcRxgfyjDgu1vSXeF0J4F0Wo//uLn0MZf
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="438071615"
X-IronPort-AV: E=Sophos;i="5.99,281,1677571200"; 
   d="scan'208";a="438071615"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 03:53:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="734650929"
X-IronPort-AV: E=Sophos;i="5.99,281,1677571200"; 
   d="scan'208";a="734650929"
Received: from lnstern-mobl1.amr.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.221.185])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 03:53:01 -0700
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
Subject: [PATCH v2 2/9] PCI: pciehp: Use RMW accessors for changing LNKCTL
Date:   Wed, 17 May 2023 13:52:28 +0300
Message-Id: <20230517105235.29176-3-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230517105235.29176-1-ilpo.jarvinen@linux.intel.com>
References: <20230517105235.29176-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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

