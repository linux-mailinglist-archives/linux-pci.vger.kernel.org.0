Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F061223E376
	for <lists+linux-pci@lfdr.de>; Thu,  6 Aug 2020 23:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbgHFVSy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Aug 2020 17:18:54 -0400
Received: from mga02.intel.com ([134.134.136.20]:39753 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726013AbgHFVSx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 6 Aug 2020 17:18:53 -0400
IronPort-SDR: Sbbl4/x5erwobQe/Y9bhMnoXyzfFxMGWswJfgCSkdaYYxWbj0gvT6bOxInZwcEWqKz8eAFutGb
 SKwQjd//vwXw==
X-IronPort-AV: E=McAfee;i="6000,8403,9705"; a="140810072"
X-IronPort-AV: E=Sophos;i="5.75,443,1589266800"; 
   d="scan'208";a="140810072"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2020 14:18:53 -0700
IronPort-SDR: A+dm4MzZl6nLz3A4kLJMQb3vW0FIEhdqTPFCqK/MFtm3fouSiX2NWfzHj+7Es5UXrQKwku8Q2e
 TexprT6oH+bQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,443,1589266800"; 
   d="scan'208";a="468001477"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.116.74])
  by orsmga005.jf.intel.com with ESMTP; 06 Aug 2020 14:18:52 -0700
From:   Jon Derrick <jonathan.derrick@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        <linux-pci@vger.kernel.org>,
        Jon Derrick <jonathan.derrick@intel.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        You-Sheng Yang <vicamo.yang@canonical.com>
Subject: [PATCH v2] PCI: vmd: Update VMD PM to correctly use generic PCI PM
Date:   Thu,  6 Aug 2020 17:00:17 -0400
Message-Id: <20200806210017.5654-1-jonathan.derrick@intel.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pci_save_state() call in vmd_suspend() can be performed by
pci_pm_suspend_irq(). This also allows VMD to benefit from the call into
pci_prepare_to_sleep().

The pci_restore_state() call in vmd_resume() was restoring state after
pci_pm_resume()::pci_restore_standard_config() had already restored
state. It's also been suspected that the config state should have been
restored before re-requesting IRQs instead of afterwards.

This patch removes the pci_save_state()/pci_restore_state() calls in
vmd_suspend()/vmd_resume() in order to allow proper flow through generic
PCI core Power Management code.

Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: You-Sheng Yang <vicamo.yang@canonical.com>
Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
v1->v2: Commit message cleanup

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

