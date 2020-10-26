Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF2B29911B
	for <lists+linux-pci@lfdr.de>; Mon, 26 Oct 2020 16:35:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1783974AbgJZPfX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Oct 2020 11:35:23 -0400
Received: from newton.telenet-ops.be ([195.130.132.45]:35982 "EHLO
        newton.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1783987AbgJZPfW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Oct 2020 11:35:22 -0400
X-Greylist: delayed 441 seconds by postgrey-1.27 at vger.kernel.org; Mon, 26 Oct 2020 11:35:22 EDT
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by newton.telenet-ops.be (Postfix) with ESMTPS id 4CKdy607xVzMs9s5
        for <linux-pci@vger.kernel.org>; Mon, 26 Oct 2020 16:27:58 +0100 (CET)
Received: from ramsan.of.borg ([84.195.186.194])
        by andre.telenet-ops.be with bizsmtp
        id kfTx2300b4C55Sk01fTxgR; Mon, 26 Oct 2020 16:27:57 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1kX4Pd-000MHX-6d; Mon, 26 Oct 2020 16:27:57 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1kX4Pc-00FgVo-P7; Mon, 26 Oct 2020 16:27:56 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Jim Quinlan <james.quinlan@broadcom.com>,
        Christoph Hellwig <hch@lst.de>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] dma-mapping: Fix 32-bit overflow with CONFIG_ARM_LPAE=n
Date:   Mon, 26 Oct 2020 16:27:55 +0100
Message-Id: <20201026152755.3738293-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On r8a7791/koelsch and shmobile_defconfig, PCIe probing fails with:

    rcar-pcie fe000000.pcie: Adjusted size 0x0 invalid
    rcar-pcie: probe of fe000000.pcie failed with error -22

of_dma_get_range() returns the following map:

    cpu_start 0x40000000 dma_start 0x40000000 size 0x080000000 offset 0
    cpu_start 0x00000000 dma_start 0x00000000 size 0x100000000 offset 0

If CONFIG_ARM_LPAE=n, dma_addr_t is 32-bit.  Hence when assigning
r->dma_start + r->size to dma_end, this value will be truncated to
32-bit, yielding zero when processing the second table entry.
Consequently, both dma_start and dma_end will be zero, leading to a zero
size.

Fix this by changing the dma_start and dma_end variables from dma_addr_t
to u64.

Fixes: e0d072782c734d27 ("dma-mapping: introduce DMA range map, supplanting dma_pfn_offset")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/of/device.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/of/device.c b/drivers/of/device.c
index 655dee422563f05f..3a469c79e6b05de4 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -93,7 +93,7 @@ int of_dma_configure_id(struct device *dev, struct device_node *np,
 {
 	const struct iommu_ops *iommu;
 	const struct bus_dma_region *map = NULL;
-	dma_addr_t dma_start = 0;
+	u64 dma_start = 0;
 	u64 mask, end, size = 0;
 	bool coherent;
 	int ret;
@@ -109,10 +109,10 @@ int of_dma_configure_id(struct device *dev, struct device_node *np,
 			return ret == -ENODEV ? 0 : ret;
 	} else {
 		const struct bus_dma_region *r = map;
-		dma_addr_t dma_end = 0;
+		u64 dma_end = 0;
 
 		/* Determine the overall bounds of all DMA regions */
-		for (dma_start = ~(dma_addr_t)0; r->size; r++) {
+		for (dma_start = ~0ULL; r->size; r++) {
 			/* Take lower and upper limits */
 			if (r->dma_start < dma_start)
 				dma_start = r->dma_start;
-- 
2.25.1

