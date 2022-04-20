Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7FE0509193
	for <lists+linux-pci@lfdr.de>; Wed, 20 Apr 2022 22:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344250AbiDTUsR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Apr 2022 16:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382263AbiDTUsL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Apr 2022 16:48:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E005E63C8
        for <linux-pci@vger.kernel.org>; Wed, 20 Apr 2022 13:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650487507;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=nB/D40tzkCvrnFpbkr4TpYhGVANC08tNY4WBcS7WESA=;
        b=ge+MGyIq5w5pr2ORsnajCTo5e+p9fyb4xY7SQg8eMVueVXb8jpIty4TkrfL0/l4Dpf3p3Q
        +Q9zS+tLxqBPeNZAv0+H+mEGRgWjAArrGPgjNFiMrrj24Zbyq5CN2NrbxP+3khww5+Fyrv
        YFrJ+sjm0TlHBn+H/Kq8o//mbuPZExo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-632-vw_y58wnOE2pPRz7x_rj1g-1; Wed, 20 Apr 2022 16:45:06 -0400
X-MC-Unique: vw_y58wnOE2pPRz7x_rj1g-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F19461C0BF0E;
        Wed, 20 Apr 2022 20:45:05 +0000 (UTC)
Received: from [172.30.41.16] (unknown [10.2.17.131])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A4EFB552AB7;
        Wed, 20 Apr 2022 20:45:05 +0000 (UTC)
Subject: [PATCH] PCI/docs: Fix references to DMA set mask function
From:   Alex Williamson <alex.williamson@redhat.com>
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, hch@lst.de
Date:   Wed, 20 Apr 2022 14:45:05 -0600
Message-ID: <165048747271.2959320.13475081883467312497.stgit@omen>
User-Agent: StGit/1.0-8-g6af9-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The function is dma_set_mask(), fix a missed instance of the old
pci_set_dma_mask() and a reference to a function that doesn't exist.

Fixes: 05b0ebd06ae6 ("PCI/doc: cleanup references to the legacy PCI DMA API")
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 Documentation/PCI/pci.rst |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/PCI/pci.rst b/Documentation/PCI/pci.rst
index 67a850b55617..cced568d78e9 100644
--- a/Documentation/PCI/pci.rst
+++ b/Documentation/PCI/pci.rst
@@ -273,12 +273,12 @@ Set the DMA mask size
 While all drivers should explicitly indicate the DMA capability
 (e.g. 32 or 64 bit) of the PCI bus master, devices with more than
 32-bit bus master capability for streaming data need the driver
-to "register" this capability by calling pci_set_dma_mask() with
+to "register" this capability by calling dma_set_mask() with
 appropriate parameters.  In general this allows more efficient DMA
 on systems where System RAM exists above 4G _physical_ address.
 
 Drivers for all PCI-X and PCIe compliant devices must call
-set_dma_mask() as they are 64-bit DMA devices.
+dma_set_mask() as they are 64-bit DMA devices.
 
 Similarly, drivers must also "register" this capability if the device
 can directly address "coherent memory" in System RAM above 4G physical


