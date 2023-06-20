Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74B8C736DB3
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jun 2023 15:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233142AbjFTNrI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Jun 2023 09:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233113AbjFTNrB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Jun 2023 09:47:01 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 328081718;
        Tue, 20 Jun 2023 06:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687268820; x=1718804820;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KdmhiibePV/4HK2zA0Ez8F9OGPcYXPdUzaI7QpnJGNs=;
  b=P4/FsBZlHyVOaEJtgqAg4UNZ4xqE8j1jZRIR54NTfLKppB1T9eUlOqnJ
   oG97zokji7wSHQrygYrqaDA6uURyegJqi+mHRDD9ZgjIL3WQPZ771BVnr
   8Rcc1QTcfsNFtHWNgXGgczWzc/YcArkRoK5r8PK2uPQd2wdPv1YT1psWN
   IFYGPU5jaxc9a4SfTFV6yRCvPwzn3Gua9mlm/puQGHbPTBffMuuYXzVm6
   uqSufbws1T11rGSUcS7bpjPr579oODsRGUw/EXZCNkg6OzT/BZLtkTOWC
   ARUHJojnerEMq9YD7xGXnLmvQiNv+vz0mz6WGXaFeelPeVeUfGcaUfE3V
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="362401341"
X-IronPort-AV: E=Sophos;i="6.00,257,1681196400"; 
   d="scan'208";a="362401341"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 06:46:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="827006663"
X-IronPort-AV: E=Sophos;i="6.00,257,1681196400"; 
   d="scan'208";a="827006663"
Received: from eshaanan-mobl.ger.corp.intel.com (HELO ijarvine-mobl2.ger.corp.intel.com) ([10.252.61.137])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 06:46:54 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Stefan=20M=C3=A4tje?= <stefan.maetje@esd.eu>,
        Shaohua Li <shaohua.li@intel.com>,
        Greg Kroah-Hartman <gregkh@suse.de>,
        linux-kernel@vger.kernel.org
Cc:     Dean Luick <dean.luick@cornelisnetworks.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        stable@vger.kernel.org
Subject: [PATCH v3 02/10] PCI: Make link retraining use RMW accessors for changing LNKCTL
Date:   Tue, 20 Jun 2023 16:46:16 +0300
Message-Id: <20230620134624.99688-3-ilpo.jarvinen@linux.intel.com>
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

Don't assume that the device is fully under the control of PCI core.
Use RMW capability accessors in link retraining which do proper locking
to avoid losing concurrent updates to the register values.

Fixes: 4ec73791a64b ("PCI: Work around Pericom PCIe-to-PCI bridge Retrain Link erratum")
Fixes: 7d715a6c1ae5 ("PCI: add PCI Express ASPM support")
Suggested-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Acked-by: Rafael J. Wysocki <rafael@kernel.org>
Cc: stable@vger.kernel.org
---

pci/enumeration branch moves the link retraining code into PCI core and
also conflicts with a link retraining fix in pci/aspm. The changelog
(and patch splitting) takes the move into account by not referring to
ASPM while the change itself is not based on pci/enumeration (as per
Bjorn's preference).

---
 drivers/pci/pcie/aspm.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 66d7514ca111..50e32bda4656 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -199,17 +199,14 @@ static bool pcie_retrain_link(struct pcie_link_state *link)
 	unsigned long end_jiffies;
 	u16 reg16;
 
-	pcie_capability_read_word(parent, PCI_EXP_LNKCTL, &reg16);
-	reg16 |= PCI_EXP_LNKCTL_RL;
-	pcie_capability_write_word(parent, PCI_EXP_LNKCTL, reg16);
+	pcie_capability_set_word(parent, PCI_EXP_LNKCTL, PCI_EXP_LNKCTL_RL);
 	if (parent->clear_retrain_link) {
 		/*
 		 * Due to an erratum in some devices the Retrain Link bit
 		 * needs to be cleared again manually to allow the link
 		 * training to succeed.
 		 */
-		reg16 &= ~PCI_EXP_LNKCTL_RL;
-		pcie_capability_write_word(parent, PCI_EXP_LNKCTL, reg16);
+		pcie_capability_clear_word(parent, PCI_EXP_LNKCTL, PCI_EXP_LNKCTL_RL);
 	}
 
 	/* Wait for link training end. Break out after waiting for timeout */
-- 
2.30.2

