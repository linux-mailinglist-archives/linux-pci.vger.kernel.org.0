Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1561D344E
	for <lists+linux-pci@lfdr.de>; Thu, 14 May 2020 17:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728439AbgENPCT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 May 2020 11:02:19 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:47426 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbgENPCR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 May 2020 11:02:17 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04EF1I8J000696;
        Thu, 14 May 2020 10:01:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1589468478;
        bh=4C0TWTfTSDRj2w7qQ6T4h7AbzhbqZ2/D2YKSd7EQANY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=KG8A1qVYr8Sx0FqQY3Y0xB251hbSAtYSeTEbT3dgOYfs909oQrC/sEkV8Cg6jNdGu
         sy80oRXNcAeaS6DU5I3LFSdk8ZjqMwrtH5VMNTVOsnCkhZVI4PxrXx5gnBh6LiZBvx
         rHKE4dxj8+XJXbAScJI73AjZszolEnLfhG/2Jtf0=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04EF1IQG104549
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 14 May 2020 10:01:18 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 14
 May 2020 10:01:17 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 14 May 2020 10:01:17 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04EExgB3019279;
        Thu, 14 May 2020 10:01:13 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>, <linux-pci@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-ntb@googlegroups.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 19/19] NTB: ntb_perf/ntb_tool: Use PCI device for dma_alloc_coherent()
Date:   Thu, 14 May 2020 20:29:27 +0530
Message-ID: <20200514145927.17555-20-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200514145927.17555-1-kishon@ti.com>
References: <20200514145927.17555-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

NTB device is not a real device and the piece of hardware actually
doing the DMA is the PCI device itself. Fix ntb_perf.c and ntb_tool.c
to use PCI device for dma_alloc_coherent() instead of NTB device.
ntb_transport.c already uses PCI device for dma_alloc_coherent().

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/ntb/test/ntb_perf.c | 3 ++-
 drivers/ntb/test/ntb_tool.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
index 972f6d984f6d..7f830a3e5b14 100644
--- a/drivers/ntb/test/ntb_perf.c
+++ b/drivers/ntb/test/ntb_perf.c
@@ -566,6 +566,7 @@ static int perf_setup_inbuf(struct perf_peer *peer)
 {
 	resource_size_t xlat_align, size_align, size_max;
 	struct perf_ctx *perf = peer->perf;
+	struct pci_dev *pdev = perf->ntb->pdev;
 	int ret;
 
 	/* Get inbound MW parameters */
@@ -586,7 +587,7 @@ static int perf_setup_inbuf(struct perf_peer *peer)
 
 	perf_free_inbuf(peer);
 
-	peer->inbuf = dma_alloc_coherent(&perf->ntb->dev, peer->inbuf_size,
+	peer->inbuf = dma_alloc_coherent(&pdev->dev, peer->inbuf_size,
 					 &peer->inbuf_xlat, GFP_KERNEL);
 	if (!peer->inbuf) {
 		dev_err(&perf->ntb->dev, "Failed to alloc inbuf of %pa\n",
diff --git a/drivers/ntb/test/ntb_tool.c b/drivers/ntb/test/ntb_tool.c
index 4b4f9e2a2c43..5c9f034122b7 100644
--- a/drivers/ntb/test/ntb_tool.c
+++ b/drivers/ntb/test/ntb_tool.c
@@ -576,6 +576,7 @@ static int tool_setup_mw(struct tool_ctx *tc, int pidx, int widx,
 {
 	resource_size_t size, addr_align, size_align;
 	struct tool_mw *inmw = &tc->peers[pidx].inmws[widx];
+	struct pci_dev *pdev = tc->ntb->pdev;
 	char buf[TOOL_BUF_LEN];
 	int ret;
 
@@ -590,7 +591,7 @@ static int tool_setup_mw(struct tool_ctx *tc, int pidx, int widx,
 	inmw->size = min_t(resource_size_t, req_size, size);
 	inmw->size = round_up(inmw->size, addr_align);
 	inmw->size = round_up(inmw->size, size_align);
-	inmw->mm_base = dma_alloc_coherent(&tc->ntb->dev, inmw->size,
+	inmw->mm_base = dma_alloc_coherent(&pdev->dev, inmw->size,
 					   &inmw->dma_base, GFP_KERNEL);
 	if (!inmw->mm_base)
 		return -ENOMEM;
-- 
2.17.1

