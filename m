Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB8A7200AA
	for <lists+linux-pci@lfdr.de>; Fri,  2 Jun 2023 13:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235010AbjFBLtE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Jun 2023 07:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjFBLs7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Jun 2023 07:48:59 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44FF9E7B;
        Fri,  2 Jun 2023 04:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685706510; x=1717242510;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GYiQUacdfpCaOUMOuUUbytp5bgtwqkFXs7jFdgIpGa0=;
  b=dRsl7VQbR4RXL1A4hSial9N8vJkzkcA55oEl8FPUocQyK+hEiREgigfk
   kNZ09UpBWK5hj39bvkdXT+oqmSF3nx/s/9qoUUJLTIPwllcgWEZNwAclf
   sO9TnFP5eW3uQhnvH1Exx+M/IuQF7svCWlhOiyR5h34QeUPHYpRqGnvyf
   8Ks9r4/d0uzpShCKgPElWCe5buKQfxnjxWDirffQeRxFKrjUbrENdfgHy
   qWA+ix9I0aaWS3KuHlh2gDhfMfMfybP4L24xsbahIlcyeo05f0OK+ocyx
   MelNiouvPkxbu4llGVWyDbW4D3hHDwa1mTVX0xP8pkcKqn5rbvtjsmszb
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="358279620"
X-IronPort-AV: E=Sophos;i="6.00,212,1681196400"; 
   d="scan'208";a="358279620"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 04:48:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="707819419"
X-IronPort-AV: E=Sophos;i="6.00,212,1681196400"; 
   d="scan'208";a="707819419"
Received: from rspatil-mobl3.gar.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.208.112])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 04:48:10 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Lukas Wunner <lukas@wunner.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Nirmal Patel <nirmal.patel@linux.intel.com>,
        Jonathan Derrick <jonathan.derrick@linux.dev>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [RFC PATCH v1 02/13] PCI/ASPM: Rename pci_enable_link_state() to pci_set_default_link_state()
Date:   Fri,  2 Jun 2023 14:47:39 +0300
Message-Id: <20230602114751.19671-3-ilpo.jarvinen@linux.intel.com>
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

pci_enable_link_state() and pci_disable_link_state() are not paired
symmetrically despite their names suggesting otherwise. Also,
pci_enable_link_state() tweaks link state when the "default" policy is
in use rather than exactly "enabling" some link states. Obviously, when
the default policy is in use and the default link state is changed,
some link states may get enabled but that is a secondary effect.

Thus, rename pci_enable_link_state() to pci_set_default_link_state() to
better match what it does. The rename also frees
pci_enable_link_state() name so that a later commit can add a function
that pairs symmetrically with pci_disable_link_state().

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/controller/vmd.c | 2 +-
 drivers/pci/pcie/aspm.c      | 8 ++++----
 include/linux/pci.h          | 4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 990630ec57c6..0e62f4cd5a5f 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -737,7 +737,7 @@ static int vmd_pm_enable_quirk(struct pci_dev *pdev, void *userdata)
 	if (!(features & VMD_FEAT_BIOS_PM_QUIRK))
 		return 0;
 
-	pci_enable_link_state(pdev, PCIE_LINK_STATE_ALL);
+	pci_set_default_link_state(pdev, PCIE_LINK_STATE_ALL);
 
 	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_LTR);
 	if (!pos)
diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 51d6693d7171..9fa8ab6eb7a4 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -1157,8 +1157,8 @@ int pci_disable_link_state(struct pci_dev *pdev, int state)
 EXPORT_SYMBOL(pci_disable_link_state);
 
 /**
- * pci_enable_link_state - Clear and set the default device link state so that
- * the link may be allowed to enter the specified states. Note that if the
+ * pci_set_default_link_state - Clear and set the default device link state so
+ * that the link may be allowed to enter the specified states. Note that if the
  * BIOS didn't grant ASPM control to the OS, this does nothing because we can't
  * touch the LNKCTL register. Also note that this does not enable states
  * disabled by pci_disable_link_state(). Return 0 or a negative errno.
@@ -1166,7 +1166,7 @@ EXPORT_SYMBOL(pci_disable_link_state);
  * @pdev: PCI device
  * @state: Mask of ASPM link states to enable
  */
-int pci_enable_link_state(struct pci_dev *pdev, int state)
+int pci_set_default_link_state(struct pci_dev *pdev, int state)
 {
 	struct pcie_link_state *link = pcie_aspm_get_link(pdev);
 
@@ -1208,7 +1208,7 @@ int pci_enable_link_state(struct pci_dev *pdev, int state)
 
 	return 0;
 }
-EXPORT_SYMBOL(pci_enable_link_state);
+EXPORT_SYMBOL(pci_set_default_link_state);
 
 static int pcie_aspm_set_policy(const char *val,
 				const struct kernel_param *kp)
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 1878f55b2aa6..5597e97a086d 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1777,12 +1777,12 @@ extern bool pcie_ports_native;
 int pci_disable_link_state(struct pci_dev *pdev, int state);
 int pci_disable_link_state_locked(struct pci_dev *pdev, int state);
 #ifdef CONFIG_PCIEASPM
-int pci_enable_link_state(struct pci_dev *pdev, int state);
+int pci_set_default_link_state(struct pci_dev *pdev, int state);
 void pcie_no_aspm(void);
 bool pcie_aspm_support_enabled(void);
 bool pcie_aspm_enabled(struct pci_dev *pdev);
 #else
-static inline int pci_enable_link_state(struct pci_dev *pdev, int state)
+static inline int pci_set_default_link_state(struct pci_dev *pdev, int state)
 { return 0; }
 static inline void pcie_no_aspm(void) { }
 static inline bool pcie_aspm_support_enabled(void) { return false; }
-- 
2.30.2

