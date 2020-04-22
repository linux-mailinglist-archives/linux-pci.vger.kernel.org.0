Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1BA1B38DD
	for <lists+linux-pci@lfdr.de>; Wed, 22 Apr 2020 09:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725907AbgDVHZI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Apr 2020 03:25:08 -0400
Received: from mx.socionext.com ([202.248.49.38]:11042 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725835AbgDVHZI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 22 Apr 2020 03:25:08 -0400
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 22 Apr 2020 16:25:06 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id C64DD60057;
        Wed, 22 Apr 2020 16:25:06 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Wed, 22 Apr 2020 16:25:06 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
        by kinkan.css.socionext.com (Postfix) with ESMTP id 30EE51A12D0;
        Wed, 22 Apr 2020 16:25:06 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v2] PCI: endpoint: functions/pci-epf-test: Avoid DMA release when DMA is unsupported
Date:   Wed, 22 Apr 2020 16:24:47 +0900
Message-Id: <1587540287-10458-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When unbinding pci_epf_test, pci_epf_test_clean_dma_chan() is called in
pci_epf_test_unbind() even though epf_test->dma_supported is false.
As a result, dma_release_channel() will occur null pointer access because
dma_chan isn't set.

This avoids calling dma_release_channel() if epf_test->dma_supported
is false.

Fixes: a1d105d4ab8e ("PCI: endpoint: functions/pci-epf-test: Add DMA support to transfer data")
Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 60330f3e..c89a956 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -187,6 +187,9 @@ static int pci_epf_test_init_dma_chan(struct pci_epf_test *epf_test)
  */
 static void pci_epf_test_clean_dma_chan(struct pci_epf_test *epf_test)
 {
+	if (!epf_test->dma_supported)
+		return;
+
 	dma_release_channel(epf_test->dma_chan);
 	epf_test->dma_chan = NULL;
 }
-- 
2.7.4

