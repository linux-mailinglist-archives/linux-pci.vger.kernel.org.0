Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01C175A6115
	for <lists+linux-pci@lfdr.de>; Tue, 30 Aug 2022 12:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbiH3KtT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Aug 2022 06:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbiH3KtS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Aug 2022 06:49:18 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEDB4DF4C2;
        Tue, 30 Aug 2022 03:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661856556; x=1693392556;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TUQ7avMuLxhf37gvjWMg7acpWzikzJL0j5/UqprSQsU=;
  b=asj4GmMeODMHhG6VJQAf4xzI3RmH/Temr/drCTi9YVraDXsfpENwcKCq
   JTKkvi+XpqXTJH80gVCtLU11WWCGb3I9tWzX4UhKkmZHpR9R98APbqmJo
   3wM0bvAfbbgierXJPl+tb4FXQUHKJJV7hn4ccQB/TCj28IKzN1B1D8XMf
   KqfxHcXIkikK8hSdA+09prU7HUGpRYMKDKVIvwAFXsfP2behE+jSBAtwC
   j3sJjnBPHtHd2AWvLdxarfIrNbT8EgV4AFlbfbdCFYas6cUcywo69ACDL
   DBRcVLdemPKOKnvlYfsX9uLv/QPlLnZYMB199hWQmNGQcKMJaR3UU9R6V
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10454"; a="278160876"
X-IronPort-AV: E=Sophos;i="5.93,274,1654585200"; 
   d="scan'208";a="278160876"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 03:49:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,274,1654585200"; 
   d="scan'208";a="607795711"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP; 30 Aug 2022 03:49:16 -0700
Received: from rjingar-desk5.amr.corp.intel.com (bdsebast-mobl2.amr.corp.intel.com [10.209.149.131])
        by linux.intel.com (Postfix) with ESMTP id 0BBCF5808F0;
        Tue, 30 Aug 2022 03:49:16 -0700 (PDT)
From:   Rajvi Jingar <rajvi.jingar@linux.intel.com>
To:     rafael.j.wysocki@intel.com, bhelgaas@google.com
Cc:     rajvi.jingar@linux.intel.com, david.e.box@linux.intel.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [RESEND PATCH v3 2/2] PCI/PTM: fix to maintain pci_dev->ptm_enabled
Date:   Tue, 30 Aug 2022 03:49:13 -0700
Message-Id: <20220830104913.1620539-2-rajvi.jingar@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220830104913.1620539-1-rajvi.jingar@linux.intel.com>
References: <20220830104913.1620539-1-rajvi.jingar@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

pci_dev->ptm_enabled needs to be maintained to reflect the current PTM
state of the device. In pci_ptm_disable(), clear ptm_enabled from
'struct pci_dev' on disabling PTM state for the device.
In pci_restore_ptm_state(), set dev->ptm_enabled based on the restored
PTM state of the device.

In pci_ptm_disable(), perform ptm_enabled check to avoid config space
access in case if PTM is already disabled for the device. ptm_enabled
won't be set for non-PCIe devices so pci_is_pcie(dev) check is not
needed anymore.

Signed-off-by: Rajvi Jingar <rajvi.jingar@linux.intel.com>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 v1->v2:
   - add ptm_enabled check in pci_ptm_disable().
   - set the dev->ptm_enabled value in pci_restore_ptm_state().
 v2->v3:
   - remove pci_is_pcie(dev) check in pci_ptm_disable().
   - add Reviewed-by tag in commit message
---
 drivers/pci/pcie/ptm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/ptm.c b/drivers/pci/pcie/ptm.c
index 368a254e3124..1ce241d4538f 100644
--- a/drivers/pci/pcie/ptm.c
+++ b/drivers/pci/pcie/ptm.c
@@ -34,7 +34,7 @@ void pci_disable_ptm(struct pci_dev *dev)
 	int ptm;
 	u16 ctrl;
 
-	if (!pci_is_pcie(dev))
+	if (!dev->ptm_enabled)
 		return;
 
 	ptm = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_PTM);
@@ -44,6 +44,7 @@ void pci_disable_ptm(struct pci_dev *dev)
 	pci_read_config_word(dev, ptm + PCI_PTM_CTRL, &ctrl);
 	ctrl &= ~(PCI_PTM_CTRL_ENABLE | PCI_PTM_CTRL_ROOT);
 	pci_write_config_word(dev, ptm + PCI_PTM_CTRL, ctrl);
+	dev->ptm_enabled = 0;
 }
 
 void pci_save_ptm_state(struct pci_dev *dev)
@@ -83,6 +84,7 @@ void pci_restore_ptm_state(struct pci_dev *dev)
 
 	cap = (u16 *)&save_state->cap.data[0];
 	pci_write_config_word(dev, ptm + PCI_PTM_CTRL, *cap);
+	dev->ptm_enabled = !!(*cap & PCI_PTM_CTRL_ENABLE);
 }
 
 void pci_ptm_init(struct pci_dev *dev)
-- 
2.25.1

