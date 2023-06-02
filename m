Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD437200C9
	for <lists+linux-pci@lfdr.de>; Fri,  2 Jun 2023 13:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235481AbjFBLuB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Jun 2023 07:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235589AbjFBLty (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Jun 2023 07:49:54 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C46EE63;
        Fri,  2 Jun 2023 04:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685706566; x=1717242566;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jGXAxasqLUJNCCsewqKuozH1mOZUvPCSOeFXiURbrcI=;
  b=nVjj+tS4Mx7xe20SIiFMGmTsVujt3v+aQDoe/N3sAoHZSPPWDu2HHWFO
   BbZpDf49xgCg6G51JyizgJ+Jt3xNziAf5Hjd+6//LL5TPE+DNzqmm3c0f
   WzdilcyIag8fxY25rbiN7wkEieh4AMw4SqBZO9aXKZgPhGbCfBM7vAZdF
   kmfZPH4X73EUAyIxMbMjW6+toMAvWaCUOb2p6bYqWOxL1YCF8XmUyDu/C
   cFXhOT+RbQv5VXyFgvtOB4UQSkDzMQyIVnJ3W9Yr23WH+neNFWq0ynhcn
   T9Bmcy7Z1vCrGldhX+OeoBBGSlpQ1j/x4LXDQ02T4EwClwYxK9ZEGKOBn
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="358279726"
X-IronPort-AV: E=Sophos;i="6.00,212,1681196400"; 
   d="scan'208";a="358279726"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 04:48:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="707819513"
X-IronPort-AV: E=Sophos;i="6.00,212,1681196400"; 
   d="scan'208";a="707819513"
Received: from rspatil-mobl3.gar.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.208.112])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 04:48:44 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Lukas Wunner <lukas@wunner.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [RFC PATCH v1 08/13] e1000e: Remove unreliable pci_disable_link_state{,_locked}() workaround
Date:   Fri,  2 Jun 2023 14:47:45 +0300
Message-Id: <20230602114751.19671-9-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230602114751.19671-1-ilpo.jarvinen@linux.intel.com>
References: <20230602114751.19671-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

pci_disable_link_state() and pci_disable_link_state_locked() were made
reliable regardless of ASPM CONFIG and OS being disallowed to change
ASPM states to allow drivers to rely on them working.

Remove driver working around unreliable
pci_disable_link_state{,_locked}() from e1000e driver and just call the
functions directly.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 77 +---------------------
 1 file changed, 2 insertions(+), 75 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index bd7ef59b1f2e..d680d059a681 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -6763,79 +6763,6 @@ static int __e1000_shutdown(struct pci_dev *pdev, bool runtime)
 	return 0;
 }
 
-/**
- * __e1000e_disable_aspm - Disable ASPM states
- * @pdev: pointer to PCI device struct
- * @state: bit-mask of ASPM states to disable
- * @locked: indication if this context holds pci_bus_sem locked.
- *
- * Some devices *must* have certain ASPM states disabled per hardware errata.
- **/
-static void __e1000e_disable_aspm(struct pci_dev *pdev, u16 state, int locked)
-{
-	struct pci_dev *parent = pdev->bus->self;
-	u16 aspm_dis_mask = 0;
-	u16 pdev_aspmc, parent_aspmc;
-
-	switch (state) {
-	case PCIE_LINK_STATE_L0S:
-	case PCIE_LINK_STATE_L0S | PCIE_LINK_STATE_L1:
-		aspm_dis_mask |= PCI_EXP_LNKCTL_ASPM_L0S;
-		fallthrough; /* can't have L1 without L0s */
-	case PCIE_LINK_STATE_L1:
-		aspm_dis_mask |= PCI_EXP_LNKCTL_ASPM_L1;
-		break;
-	default:
-		return;
-	}
-
-	pcie_capability_read_word(pdev, PCI_EXP_LNKCTL, &pdev_aspmc);
-	pdev_aspmc &= PCI_EXP_LNKCTL_ASPMC;
-
-	if (parent) {
-		pcie_capability_read_word(parent, PCI_EXP_LNKCTL,
-					  &parent_aspmc);
-		parent_aspmc &= PCI_EXP_LNKCTL_ASPMC;
-	}
-
-	/* Nothing to do if the ASPM states to be disabled already are */
-	if (!(pdev_aspmc & aspm_dis_mask) &&
-	    (!parent || !(parent_aspmc & aspm_dis_mask)))
-		return;
-
-	dev_info(&pdev->dev, "Disabling ASPM %s %s\n",
-		 (aspm_dis_mask & pdev_aspmc & PCI_EXP_LNKCTL_ASPM_L0S) ?
-		 "L0s" : "",
-		 (aspm_dis_mask & pdev_aspmc & PCI_EXP_LNKCTL_ASPM_L1) ?
-		 "L1" : "");
-
-#ifdef CONFIG_PCIEASPM
-	if (locked)
-		pci_disable_link_state_locked(pdev, state);
-	else
-		pci_disable_link_state(pdev, state);
-
-	/* Double-check ASPM control.  If not disabled by the above, the
-	 * BIOS is preventing that from happening (or CONFIG_PCIEASPM is
-	 * not enabled); override by writing PCI config space directly.
-	 */
-	pcie_capability_read_word(pdev, PCI_EXP_LNKCTL, &pdev_aspmc);
-	pdev_aspmc &= PCI_EXP_LNKCTL_ASPMC;
-
-	if (!(aspm_dis_mask & pdev_aspmc))
-		return;
-#endif
-
-	/* Both device and parent should have the same ASPM setting.
-	 * Disable ASPM in downstream component first and then upstream.
-	 */
-	pcie_capability_clear_word(pdev, PCI_EXP_LNKCTL, aspm_dis_mask);
-
-	if (parent)
-		pcie_capability_clear_word(parent, PCI_EXP_LNKCTL,
-					   aspm_dis_mask);
-}
-
 /**
  * e1000e_disable_aspm - Disable ASPM states.
  * @pdev: pointer to PCI device struct
@@ -6846,7 +6773,7 @@ static void __e1000e_disable_aspm(struct pci_dev *pdev, u16 state, int locked)
  **/
 static void e1000e_disable_aspm(struct pci_dev *pdev, u16 state)
 {
-	__e1000e_disable_aspm(pdev, state, 0);
+	pci_disable_link_state(pdev, state);
 }
 
 /**
@@ -6859,7 +6786,7 @@ static void e1000e_disable_aspm(struct pci_dev *pdev, u16 state)
  **/
 static void e1000e_disable_aspm_locked(struct pci_dev *pdev, u16 state)
 {
-	__e1000e_disable_aspm(pdev, state, 1);
+	pci_disable_link_state_locked(pdev, state);
 }
 
 static int e1000e_pm_thaw(struct device *dev)
-- 
2.30.2

