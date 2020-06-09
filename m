Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 261021F36D0
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jun 2020 11:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728400AbgFIJRf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Jun 2020 05:17:35 -0400
Received: from mga17.intel.com ([192.55.52.151]:29500 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728247AbgFIJRd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 9 Jun 2020 05:17:33 -0400
IronPort-SDR: 3kmh86Nis7upl5xLjq5xZ7RDbyoEcoIJHjKsxU8UE2VZSJDQLDlvv5VpXj/fNkjmaPhD/c0YQt
 f8/HPzCjvocw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2020 02:17:32 -0700
IronPort-SDR: JfF7AGgMn2eedLms7XY99tHf3FYV0HFR3OP3C7FYUcBk0W9FdhdfYKzuJ3kUbU+pIKYdq4plft
 gPeMTJ2fvskg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,491,1583222400"; 
   d="scan'208";a="379686682"
Received: from gklab-125-110.igk.intel.com ([10.91.125.110])
  by fmsmga001.fm.intel.com with ESMTP; 09 Jun 2020 02:17:30 -0700
From:   Piotr Stankiewicz <piotr.stankiewicz@intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     Piotr Stankiewicz <piotr.stankiewicz@intel.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Pascal van Leeuwen <pascalvanl@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 05/15] crypto: inside-secure - Use PCI_IRQ_MSI_TYPES where appropriate
Date:   Tue,  9 Jun 2020 11:17:26 +0200
Message-Id: <20200609091728.973-1-piotr.stankiewicz@intel.com>
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
Reviewed-by: Antoine Tenart <antoine.tenart@bootlin.com>
Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
---
 drivers/crypto/inside-secure/safexcel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/inside-secure/safexcel.c b/drivers/crypto/inside-secure/safexcel.c
index 2cb53fbae841..1b2faa2a6ab0 100644
--- a/drivers/crypto/inside-secure/safexcel.c
+++ b/drivers/crypto/inside-secure/safexcel.c
@@ -1567,7 +1567,7 @@ static int safexcel_probe_generic(void *pdev,
 		ret = pci_alloc_irq_vectors(pci_pdev,
 					    priv->config.rings + 1,
 					    priv->config.rings + 1,
-					    PCI_IRQ_MSI | PCI_IRQ_MSIX);
+					    PCI_IRQ_MSI_TYPES);
 		if (ret < 0) {
 			dev_err(dev, "Failed to allocate PCI MSI interrupts\n");
 			return ret;
-- 
2.17.2

