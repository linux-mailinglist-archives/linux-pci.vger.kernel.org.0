Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 230AF6DBE3
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jul 2019 06:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388661AbfGSEMG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Jul 2019 00:12:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:47236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388647AbfGSEME (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 19 Jul 2019 00:12:04 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8E89218B6;
        Fri, 19 Jul 2019 04:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563509523;
        bh=zhlLWZ2Hxk6oSiOgWU6RwBxBIm9D6CH3aKTWrl5nj0Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xvSicy+tOk6USViDyGn8EPDo0nZUiGILbV9f+Q/SLIYgvwNkw6SZWHDpkDaQRNX1z
         mr9Yr0k9quqnrqdbPuRB76MvFwzRH7qdFPWTRRGxxbTV2HL9hrvB+iGtO8KwiX0uc9
         AqDBdGYaaRyqwfrULF7Qo0pyzpiWDmyGaV3HjlJc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sasha Levin <sashal@kernel.org>, linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 29/60] PCI: xilinx-nwl: Fix Multi MSI data programming
Date:   Fri, 19 Jul 2019 00:10:38 -0400
Message-Id: <20190719041109.18262-29-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190719041109.18262-1-sashal@kernel.org>
References: <20190719041109.18262-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>

[ Upstream commit 181fa434d0514e40ebf6e9721f2b72700287b6e2 ]

According to the PCI Local Bus specification Revision 3.0,
section 6.8.1.3 (Message Control for MSI), endpoints that
are Multiple Message Capable as defined by bits [3:1] in
the Message Control for MSI can request a number of vectors
that is power of two aligned.

As specified in section 6.8.1.6 "Message data for MSI", the Multiple
Message Enable field (bits [6:4] of the Message Control register)
defines the number of low order message data bits the function is
permitted to modify to generate its system software allocated
vectors.

The MSI controller in the Xilinx NWL PCIe controller supports a number
of MSI vectors specified through a bitmap and the hwirq number for an
MSI, that is the value written in the MSI data TLP is determined by
the bitmap allocation.

For instance, in a situation where two endpoints sitting on
the PCI bus request the following MSI configuration, with
the current PCI Xilinx bitmap allocation code (that does not
align MSI vector allocation on a power of two boundary):

Endpoint #1: Requesting 1 MSI vector - allocated bitmap bits 0
Endpoint #2: Requesting 2 MSI vectors - allocated bitmap bits [1,2]

The bitmap value(s) corresponds to the hwirq number that is programmed
into the Message Data for MSI field in the endpoint MSI capability
and is detected by the root complex to fire the corresponding
MSI irqs. The value written in Message Data for MSI field corresponds
to the first bit allocated in the bitmap for Multi MSI vectors.

The current Xilinx NWL MSI allocation code allows a bitmap allocation
that is not a power of two boundaries, so endpoint #2, is allowed to
toggle Message Data bit[0] to differentiate between its two vectors
(meaning that the MSI data will be respectively 0x0 and 0x1 for the two
vectors allocated to endpoint #2).

This clearly aliases with the Endpoint #1 vector allocation, resulting
in a broken Multi MSI implementation.

Update the code to allocate MSI bitmap ranges with a power of two
alignment, fixing the bug.

Fixes: ab597d35ef11 ("PCI: xilinx-nwl: Add support for Xilinx NWL PCIe Host Controller")
Suggested-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
[lorenzo.pieralisi@arm.com: updated commit log]
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/host/pcie-xilinx-nwl.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/host/pcie-xilinx-nwl.c b/drivers/pci/host/pcie-xilinx-nwl.c
index dd527ea558d7..981a5195686f 100644
--- a/drivers/pci/host/pcie-xilinx-nwl.c
+++ b/drivers/pci/host/pcie-xilinx-nwl.c
@@ -485,15 +485,13 @@ static int nwl_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 	int i;
 
 	mutex_lock(&msi->lock);
-	bit = bitmap_find_next_zero_area(msi->bitmap, INT_PCI_MSI_NR, 0,
-					 nr_irqs, 0);
-	if (bit >= INT_PCI_MSI_NR) {
+	bit = bitmap_find_free_region(msi->bitmap, INT_PCI_MSI_NR,
+				      get_count_order(nr_irqs));
+	if (bit < 0) {
 		mutex_unlock(&msi->lock);
 		return -ENOSPC;
 	}
 
-	bitmap_set(msi->bitmap, bit, nr_irqs);
-
 	for (i = 0; i < nr_irqs; i++) {
 		irq_domain_set_info(domain, virq + i, bit + i, &nwl_irq_chip,
 				domain->host_data, handle_simple_irq,
@@ -511,7 +509,8 @@ static void nwl_irq_domain_free(struct irq_domain *domain, unsigned int virq,
 	struct nwl_msi *msi = &pcie->msi;
 
 	mutex_lock(&msi->lock);
-	bitmap_clear(msi->bitmap, data->hwirq, nr_irqs);
+	bitmap_release_region(msi->bitmap, data->hwirq,
+			      get_count_order(nr_irqs));
 	mutex_unlock(&msi->lock);
 }
 
-- 
2.20.1

