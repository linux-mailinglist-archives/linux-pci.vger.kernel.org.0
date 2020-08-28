Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7369A255948
	for <lists+linux-pci@lfdr.de>; Fri, 28 Aug 2020 13:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729217AbgH1LXl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Aug 2020 07:23:41 -0400
Received: from mga07.intel.com ([134.134.136.100]:40222 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729203AbgH1LWs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 28 Aug 2020 07:22:48 -0400
IronPort-SDR: n3tQ9ve7AxNvtZCQocEVVrW2CumIFdGcHjd9V5x+IyhUbQ3t6pwPtyfLnTyK1kmaVOYcRYEtEn
 RdQSreZjmftA==
X-IronPort-AV: E=McAfee;i="6000,8403,9726"; a="220894136"
X-IronPort-AV: E=Sophos;i="5.76,363,1592895600"; 
   d="scan'208";a="220894136"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2020 04:12:01 -0700
IronPort-SDR: vXF/0/Zlv+Ee078JR3eC2cyrbmH5v7cQZ9J1BNr+a7rnZXR6+gkR4We4qTLWzeqfmP2XFRLqAz
 a8PjVvGOkUFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,363,1592895600"; 
   d="scan'208";a="374032988"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 28 Aug 2020 04:12:00 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 9FE621B4; Fri, 28 Aug 2020 14:11:59 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] PCI/P2PDMA: Use DMA ops setter instead of direct assignment
Date:   Fri, 28 Aug 2020 14:11:57 +0300
Message-Id: <20200828111157.7639-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Use DMA ops setter instead of direct assignment. Even we know that
this module doesn't perform access to the dma_ops member of struct device,
it's better to use setter to avoid potential problems in the future.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pci/p2pdma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 9d53c16b7329..2176223f972e 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -557,7 +557,7 @@ int pci_p2pdma_distance_many(struct pci_dev *provider, struct device **clients,
 
 	for (i = 0; i < num_clients; i++) {
 #ifdef CONFIG_DMA_VIRT_OPS
-		if (clients[i]->dma_ops == &dma_virt_ops) {
+		if (get_dma_ops(clients[i]) == &dma_virt_ops) {
 			if (verbose)
 				dev_warn(clients[i],
 					 "cannot be used for peer-to-peer DMA because the driver makes use of dma_virt_ops\n");
@@ -844,7 +844,7 @@ static int __pci_p2pdma_map_sg(struct pci_p2pdma_pagemap *p2p_pgmap,
 	 * by the check in pci_p2pdma_distance_many()
 	 */
 #ifdef CONFIG_DMA_VIRT_OPS
-	if (WARN_ON_ONCE(dev->dma_ops == &dma_virt_ops))
+	if (WARN_ON_ONCE(get_dma_ops(dev) == &dma_virt_ops))
 		return 0;
 #endif
 
-- 
2.28.0

