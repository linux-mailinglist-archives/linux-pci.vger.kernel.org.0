Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58625234A47
	for <lists+linux-pci@lfdr.de>; Fri, 31 Jul 2020 19:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733019AbgGaReI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 31 Jul 2020 13:34:08 -0400
Received: from mga04.intel.com ([192.55.52.120]:5939 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732970AbgGaReI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 31 Jul 2020 13:34:08 -0400
IronPort-SDR: 5UDO8LdPeLhmBKksP56unQ0X6IXEXE8LTgOAhcv6RNmMIrT+EpQBYhsAREKa8QvMO1d5BPVST+
 Xg7ldK6fO6CQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9698"; a="149292515"
X-IronPort-AV: E=Sophos;i="5.75,419,1589266800"; 
   d="scan'208";a="149292515"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2020 10:34:07 -0700
IronPort-SDR: xbHDAbJ7njvQZsADBwYKoE+HxkJVW9wmMyUnuSfpUDnbmau7lvk4D7OqhJ+fAbpE+dVLaeG3ip
 emLjcAaqfw1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,419,1589266800"; 
   d="scan'208";a="313865024"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.116.74])
  by fmsmga004.fm.intel.com with ESMTP; 31 Jul 2020 10:34:07 -0700
From:   Jon Derrick <jonathan.derrick@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        <linux-pci@vger.kernel.org>,
        Jon Derrick <jonathan.derrick@intel.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        You-Sheng Yang <vicamo.yang@canonical.com>
Subject: [PATCH] PCI: vmd: Allow VMD PM to use PCI core PM code
Date:   Fri, 31 Jul 2020 13:15:44 -0400
Message-Id: <20200731171544.6155-1-jonathan.derrick@intel.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pci_save_state call in vmd_suspend can be performed by
pci_pm_suspend_irq. This allows the call to pci_prepare_to_sleep into
ASPM flow.

The pci_restore_state call in vmd_resume was restoring state after
pci_pm_resume->pci_restore_standard_config had already restored state.
It's also been suspected that the config state should be restored before
re-requesting IRQs.

Remove the pci_{save,restore}_state calls in vmd_{suspend,resume} in
order to allow proper flow through PCI core power management ASPM code.

Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: You-Sheng Yang <vicamo.yang@canonical.com>
Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 drivers/pci/controller/vmd.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 76d8acbee7d5..15c1d85d8780 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -719,7 +719,6 @@ static int vmd_suspend(struct device *dev)
 	for (i = 0; i < vmd->msix_count; i++)
 		devm_free_irq(dev, pci_irq_vector(pdev, i), &vmd->irqs[i]);
 
-	pci_save_state(pdev);
 	return 0;
 }
 
@@ -737,7 +736,6 @@ static int vmd_resume(struct device *dev)
 			return err;
 	}
 
-	pci_restore_state(pdev);
 	return 0;
 }
 #endif
-- 
2.18.1

