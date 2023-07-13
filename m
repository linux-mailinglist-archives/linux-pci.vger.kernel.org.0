Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46889752178
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jul 2023 14:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234333AbjGMMpq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Jul 2023 08:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234370AbjGMMpo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Jul 2023 08:45:44 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D6D826A0;
        Thu, 13 Jul 2023 05:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689252339; x=1720788339;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=w9fmnbavpFPn2k6FB22LLTiMoKztUNTZBdmD34m58vg=;
  b=WwG/V6emJCh39Z63eFxqFFMQ2GXsAMKJBOdLspWd0AOI34JzLOkWxs7N
   /0QcCwp9Z5uQmlYIOqUyIT3ulLI/tRDBWr5sbbVTlTeuhZiM6dm1VyWFO
   Ll0dY8tTrRVh8Zx5dsJkwv3ZQ5j/DIvnjf7Ogi7MoABzq6lCYlHIbuPSZ
   TD0MmjOIs0r0gghfkcPzIDlieLSsT+pEDjcsNYaUCEMi3kusUdIAg337P
   s+9crGe/Q6jvTeCPp58QBEbsCcFsk5CMCG4vI2i3jJ+g8s33hYjtERqyg
   gTVnheD43xPjyhZBwkxD56cFskMbVfZkz9GJKiGDvnfVN51udSXrkIMYg
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="367796797"
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="367796797"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 05:45:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="757144396"
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="757144396"
Received: from ijarvine-mobl2.ger.corp.intel.com ([10.251.222.39])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 05:45:33 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        =?UTF-8?q?Stefan=20M=C3=A4tje?= <stefan.maetje@esd.eu>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Shaohua Li <shaohua.li@intel.com>,
        Greg Kroah-Hartman <gregkh@suse.de>,
        linux-kernel@vger.kernel.org
Cc:     Dean Luick <dean.luick@cornelisnetworks.com>,
        =?UTF-8?q?Jonas=20Dre=C3=9Fler?= <verdre@v0yd.nl>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        stable@vger.kernel.org
Subject: [PATCH v4 02/11] PCI: Make link retraining use RMW accessors for changing LNKCTL
Date:   Thu, 13 Jul 2023 15:44:56 +0300
Message-Id: <20230713124505.94866-3-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230713124505.94866-1-ilpo.jarvinen@linux.intel.com>
References: <20230713124505.94866-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/pci/pci.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 60230da957e0..f7315b13bb82 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4927,7 +4927,6 @@ static int pcie_wait_for_link_status(struct pci_dev *pdev,
 int pcie_retrain_link(struct pci_dev *pdev, bool use_lt)
 {
 	int rc;
-	u16 lnkctl;
 
 	/*
 	 * Ensure the updated LNKCTL parameters are used during link
@@ -4939,17 +4938,14 @@ int pcie_retrain_link(struct pci_dev *pdev, bool use_lt)
 	if (rc)
 		return rc;
 
-	pcie_capability_read_word(pdev, PCI_EXP_LNKCTL, &lnkctl);
-	lnkctl |= PCI_EXP_LNKCTL_RL;
-	pcie_capability_write_word(pdev, PCI_EXP_LNKCTL, lnkctl);
+	pcie_capability_set_word(pdev, PCI_EXP_LNKCTL, PCI_EXP_LNKCTL_RL);
 	if (pdev->clear_retrain_link) {
 		/*
 		 * Due to an erratum in some devices the Retrain Link bit
 		 * needs to be cleared again manually to allow the link
 		 * training to succeed.
 		 */
-		lnkctl &= ~PCI_EXP_LNKCTL_RL;
-		pcie_capability_write_word(pdev, PCI_EXP_LNKCTL, lnkctl);
+		pcie_capability_clear_word(pdev, PCI_EXP_LNKCTL, PCI_EXP_LNKCTL_RL);
 	}
 
 	return pcie_wait_for_link_status(pdev, use_lt, !use_lt);
-- 
2.30.2

