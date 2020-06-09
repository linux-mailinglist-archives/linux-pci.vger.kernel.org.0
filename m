Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 405FE1F36E3
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jun 2020 11:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbgFIJTB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Jun 2020 05:19:01 -0400
Received: from mga17.intel.com ([192.55.52.151]:29612 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728104AbgFIJTB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 9 Jun 2020 05:19:01 -0400
IronPort-SDR: 5AuB9ru6QkibTWZWfg6GK6xvf3XXElVFQ2VOekvlZAlw14+qW0uPe8XzUU5g2tKnhMk0kD4gZD
 Pw3hQEcn15EA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2020 02:19:00 -0700
IronPort-SDR: o4jZ4AQQVIZ8gej6Nqdy/HrrJ+Vd8uxwT+dXiQc+6NCJ8FfWM2l8t07LGWKt+I9RvhE9O7HfOZ
 tsxC3xPFy0Rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,491,1583222400"; 
   d="scan'208";a="306205547"
Received: from gklab-125-110.igk.intel.com ([10.91.125.110])
  by orsmga008.jf.intel.com with ESMTP; 09 Jun 2020 02:18:58 -0700
From:   Piotr Stankiewicz <piotr.stankiewicz@intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     Piotr Stankiewicz <piotr.stankiewicz@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 09/15] media: ddbridge: Use PCI_IRQ_MSI_TYPES where appropriate
Date:   Tue,  9 Jun 2020 11:18:39 +0200
Message-Id: <20200609091841.1430-1-piotr.stankiewicz@intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20200609091148.32749-1-piotr.stankiewicz@intel.com>
References: <20200609091148.32749-1-piotr.stankiewicz@intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Seeing as there is shorthand available to use when asking for any type
of interrupt, or any type of message signalled interrupt, leverage it.

Signed-off-by: Piotr Stankiewicz <piotr.stankiewicz@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---
 drivers/media/pci/ddbridge/ddbridge-main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/pci/ddbridge/ddbridge-main.c b/drivers/media/pci/ddbridge/ddbridge-main.c
index 03dc9924fa2c..ff5c33d7a736 100644
--- a/drivers/media/pci/ddbridge/ddbridge-main.c
+++ b/drivers/media/pci/ddbridge/ddbridge-main.c
@@ -106,7 +106,7 @@ static void ddb_irq_msi(struct ddb *dev, int nr)
 
 	if (msi && pci_msi_enabled()) {
 		stat = pci_alloc_irq_vectors(dev->pdev, 1, nr,
-					     PCI_IRQ_MSI | PCI_IRQ_MSIX);
+					     PCI_IRQ_MSI_TYPES);
 		if (stat >= 1) {
 			dev->msi = stat;
 			dev_info(dev->dev, "using %d MSI interrupt(s)\n",
-- 
2.17.2

