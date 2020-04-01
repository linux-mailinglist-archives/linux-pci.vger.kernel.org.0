Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84F9C19B886
	for <lists+linux-pci@lfdr.de>; Thu,  2 Apr 2020 00:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387413AbgDAWfp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Apr 2020 18:35:45 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:47635 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732669AbgDAWfp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Apr 2020 18:35:45 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1jJlxV-00030u-HX; Wed, 01 Apr 2020 22:35:41 +0000
From:   Colin King <colin.king@canonical.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] PCI: endpoint: functions/pci-epf-test: fix memory leak of buf
Date:   Wed,  1 Apr 2020 23:35:41 +0100
Message-Id: <20200401223541.403438-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

In the case where data cannot be transferred using DMA the allocation
of buf leaked on the error return path. Fix this by jumping to the
label err_dma_map that kfree's buf before the return.

Addresses-Coverity: ("Resource leak")
Fixes: a558357b1b34 ("PCI: endpoint: functions/pci-epf-test: Add DMA support to transfer data")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 3b4cf7e2bc60..60330f3e3751 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -347,7 +347,7 @@ static int pci_epf_test_read(struct pci_epf_test *epf_test)
 		if (!epf_test->dma_supported) {
 			dev_err(dev, "Cannot transfer data using DMA\n");
 			ret = -EINVAL;
-			goto err_map_addr;
+			goto err_dma_map;
 		}
 
 		dst_phys_addr = dma_map_single(dma_dev, buf, reg->size,
-- 
2.25.1

