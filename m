Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5896D5766A3
	for <lists+linux-pci@lfdr.de>; Fri, 15 Jul 2022 20:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbiGOSSY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Jul 2022 14:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbiGOSSX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Jul 2022 14:18:23 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 187175C34D;
        Fri, 15 Jul 2022 11:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657909102; x=1689445102;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TUQ7avMuLxhf37gvjWMg7acpWzikzJL0j5/UqprSQsU=;
  b=VLY+ZEqYYlBuqI9K36GnEjSd5+TQlc0/aS8oLYwbmKCpkCg7Xn2oGzDN
   1BmBS/wICldkzQQXpAFAy/pTFcMoZttRJ9jwsDYVU3FOy8ojbzdCqZZpR
   ipZDExGamnghdGeFO6OioVUy/U6MOpCOZdgZUiZ9TjAAMLHZoA2Nknufc
   vB7qt1s/9xleRDdssPLi6SNhECYudSbPhLsp2DFbQTUIdJvrWpS8MkWTJ
   T/pzxJt91d6BJR65CqQ2vggcGiWMc6Xil3TcyH+fCFxV3emYlBCxsZFoZ
   iUuuX2RaZ3CdXf9nkmcBLgcDF8IjAqXD3UQEJPokyH8/9Rjw/YjftGTvE
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10409"; a="266280341"
X-IronPort-AV: E=Sophos;i="5.92,274,1650956400"; 
   d="scan'208";a="266280341"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2022 11:18:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,274,1650956400"; 
   d="scan'208";a="571621269"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 15 Jul 2022 11:18:21 -0700
Received: from rjingar-desk5.amr.corp.intel.com (unknown [10.213.176.154])
        by linux.intel.com (Postfix) with ESMTP id 4C168580BDB;
        Fri, 15 Jul 2022 11:18:21 -0700 (PDT)
From:   Rajvi Jingar <rajvi.jingar@linux.intel.com>
To:     rafael.j.wysocki@intel.com, bhelgaas@google.com
Cc:     rajvi.jingar@linux.intel.com, david.e.box@linux.intel.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v3 2/2] PCI/PTM: fix to maintain pci_dev->ptm_enabled
Date:   Fri, 15 Jul 2022 11:18:09 -0700
Message-Id: <20220715181809.232147-2-rajvi.jingar@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220715181809.232147-1-rajvi.jingar@linux.intel.com>
References: <20220715181809.232147-1-rajvi.jingar@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

