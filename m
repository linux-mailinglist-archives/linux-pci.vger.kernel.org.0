Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AEEF1ECED8
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jun 2020 13:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbgFCLrV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Jun 2020 07:47:21 -0400
Received: from mga05.intel.com ([192.55.52.43]:60751 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725854AbgFCLrU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 3 Jun 2020 07:47:20 -0400
IronPort-SDR: MKxkAxD3XykytlTqm810rKPAJMV6knOvt5K2JLL4ESFp1C2OMIM+ZBaoA5Cu1QP7Zmy43x7gFk
 EMJFJhW5HxRQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2020 04:47:20 -0700
IronPort-SDR: zB41BdG8mCEi/7j4IuUj2llU7Aksb7dhobJF88ciBtTmwkQ48Xl0domTtdNlJp4iSApcb6XQyX
 Q+EnC807ZUug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,467,1583222400"; 
   d="scan'208";a="347743599"
Received: from gklab-125-110.igk.intel.com ([10.91.125.110])
  by orsmga001.jf.intel.com with ESMTP; 03 Jun 2020 04:47:17 -0700
From:   Piotr Stankiewicz <piotr.stankiewicz@intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     Piotr Stankiewicz <piotr.stankiewicz@intel.com>,
        Jens Axboe <axboe@kernel.dk>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jian-Hong Pan <jian-hong@endlessm.com>,
        Prabhakar Kushwaha <pkushwaha@marvell.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Hanna Hawa <hhhawa@amazon.com>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/15] ahci: Use PCI_IRQ_MSI_TYPES where appropriate
Date:   Wed,  3 Jun 2020 13:47:14 +0200
Message-Id: <20200603114715.13040-1-piotr.stankiewicz@intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20200603114212.12525-1-piotr.stankiewicz@intel.com>
References: <20200603114212.12525-1-piotr.stankiewicz@intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Seeing as there is shorthand available to use when asking for any type
of interrupt, or any type of message signalled interrupt, leverage it.

Signed-off-by: Piotr Stankiewicz <piotr.stankiewicz@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---
 drivers/ata/ahci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 0c0a736eb861..ca1bf4ef0f17 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1556,7 +1556,7 @@ static int ahci_init_msi(struct pci_dev *pdev, unsigned int n_ports,
 	 */
 	if (n_ports > 1) {
 		nvec = pci_alloc_irq_vectors(pdev, n_ports, INT_MAX,
-				PCI_IRQ_MSIX | PCI_IRQ_MSI);
+				PCI_IRQ_MSI_TYPES);
 		if (nvec > 0) {
 			if (!(readl(hpriv->mmio + HOST_CTL) & HOST_MRSM)) {
 				hpriv->get_irq_vector = ahci_get_irq_vector;
-- 
2.17.2

