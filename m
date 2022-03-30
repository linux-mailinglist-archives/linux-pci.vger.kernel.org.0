Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99FEF4EBA28
	for <lists+linux-pci@lfdr.de>; Wed, 30 Mar 2022 07:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243131AbiC3F2j (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Mar 2022 01:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242977AbiC3F1v (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Mar 2022 01:27:51 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C1E1AF7F3
        for <linux-pci@vger.kernel.org>; Tue, 29 Mar 2022 22:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=aa5ivgVdBM+Msc2FXrDriSwsnOvjUsNGOkstSfxDCW8=; b=xtg2XJbSexHtK3TD8+Z767CWX+
        a3frHy/nTtFzRbfzpbuxMwfNJaGEZkS5ZeH5twKXB7gWbGAjji9QbyfLybw6Tl08gN3NiedgBY5ty
        rChrH2X8/pWzrMeBMxvGtscKbpiYNIXuERfsSbxkTTdSTuKtE5RTfrxGTlMofeIN7VM2wBPa+hw1c
        0k6nW1sYKNCD1UAdeiyPaANxi26UYU/zZ5VBpwDPr3JsYth2kE2Dm5//4u9aks0H99xhWFTqMtJpM
        AKhkyRItHw8kMLnNUDMf7l7EvMFG/IN3bz2/qYR0EPZGp3dSC7ZT3IMbIvyICUSTG2FqJK/DEC70O
        2wKu0xnA==;
Received: from 213-225-15-62.nat.highway.a1.net ([213.225.15.62] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nZQqG-00EJwo-EW; Wed, 30 Mar 2022 05:26:01 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     helgaas@kernel.org
Cc:     christophe.jaillet@wanadoo.fr, linux-pci@vger.kernel.org
Subject: [PATCH] PCI/doc: cleanup references to the legacy PCI DMA API
Date:   Wed, 30 Mar 2022 07:25:56 +0200
Message-Id: <20220330052556.2566388-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Mention the regular DMA API calls instead of the now removed PCI DMA API.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---

I'd plan to queue this up ASAP together with the pci-dma-compat.h
removal.

 Documentation/PCI/pci.rst | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/PCI/pci.rst b/Documentation/PCI/pci.rst
index 87c6f4a6ca32b..67a850b556173 100644
--- a/Documentation/PCI/pci.rst
+++ b/Documentation/PCI/pci.rst
@@ -278,20 +278,20 @@ appropriate parameters.  In general this allows more efficient DMA
 on systems where System RAM exists above 4G _physical_ address.
 
 Drivers for all PCI-X and PCIe compliant devices must call
-pci_set_dma_mask() as they are 64-bit DMA devices.
+set_dma_mask() as they are 64-bit DMA devices.
 
 Similarly, drivers must also "register" this capability if the device
-can directly address "consistent memory" in System RAM above 4G physical
-address by calling pci_set_consistent_dma_mask().
+can directly address "coherent memory" in System RAM above 4G physical
+address by calling dma_set_coherent_mask().
 Again, this includes drivers for all PCI-X and PCIe compliant devices.
 Many 64-bit "PCI" devices (before PCI-X) and some PCI-X devices are
 64-bit DMA capable for payload ("streaming") data but not control
-("consistent") data.
+("coherent") data.
 
 
 Setup shared control data
 -------------------------
-Once the DMA masks are set, the driver can allocate "consistent" (a.k.a. shared)
+Once the DMA masks are set, the driver can allocate "coherent" (a.k.a. shared)
 memory.  See Documentation/core-api/dma-api.rst for a full description of
 the DMA APIs. This section is just a reminder that it needs to be done
 before enabling DMA on the device.
@@ -367,7 +367,7 @@ steps need to be performed:
   - Disable the device from generating IRQs
   - Release the IRQ (free_irq())
   - Stop all DMA activity
-  - Release DMA buffers (both streaming and consistent)
+  - Release DMA buffers (both streaming and coherent)
   - Unregister from other subsystems (e.g. scsi or netdev)
   - Disable device from responding to MMIO/IO Port addresses
   - Release MMIO/IO Port resource(s)
@@ -420,7 +420,7 @@ Once DMA is stopped, clean up streaming DMA first.
 I.e. unmap data buffers and return buffers to "upstream"
 owners if there is one.
 
-Then clean up "consistent" buffers which contain the control data.
+Then clean up "coherent" buffers which contain the control data.
 
 See Documentation/core-api/dma-api.rst for details on unmapping interfaces.
 
-- 
2.30.2

