Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86B0326866E
	for <lists+linux-pci@lfdr.de>; Mon, 14 Sep 2020 09:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbgINHro (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Sep 2020 03:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbgINHq4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Sep 2020 03:46:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C39C06174A;
        Mon, 14 Sep 2020 00:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=cPqBYq5povPLhzEYOyx5GvOLRCGW66TTAZJ+daEl52w=; b=iYglZJwLzk6QChePoSrmhAvdyb
        l78kJNSRO4PN+2+9URpPa8neGWWEj7PxXZ/bHrsB+MsIqClcOch1s/2XUgxIGUtH5LvyKkrFwDUEP
        +0sFvvHDKcLTp5piUcWx6pOtDO23awiYO28M27zgm9fpp5ooxb6sqXJQ0YpXVMfu23lBBXBDLZSzz
        mdGXvTHW146h81v/e/y2f0jZ3u2B6l2Kkvwni1Ib51JpQuUL5o4ERZ1jFtaF6HPLhhVnR7bbySC2K
        3Ach0o1ngE2FF91LbR/lApduf2NtE5av39CaFEMyb0KdHTNoL6OYRuQq0zSxAv3N5oVDl2sMf+pxq
        GVApXDgg==;
Received: from 089144214092.atnat0023.highway.a1.net ([89.144.214.92] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kHjCL-0000c0-Hb; Mon, 14 Sep 2020 07:46:49 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org,
        Russell King <linux@armlinux.org.uk>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jim Quinlan <james.quinlan@broadcom.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-remoteproc@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 5/6] usb: don't inherity DMA properties for USB devices
Date:   Mon, 14 Sep 2020 09:33:42 +0200
Message-Id: <20200914073343.1579578-6-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200914073343.1579578-1-hch@lst.de>
References: <20200914073343.1579578-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

As the comment in usb_alloc_dev correctly states, drivers can't use
the DMA API on usb device, and at least calling dma_set_mask on them
is highly dangerous.  Unlike what the comment states upper level drivers
also can't really use the presence of a dma mask to check for DMA
support, as the dma_mask is set by default for most busses.

Setting the dma_mask comes from "[PATCH] usbcore dma updates (and doc)"
in BitKeeper times, as it seems like it was primarily for setting the
NETIF_F_HIGHDMA flag in USB drivers, something that has long been
fixed up since.

Setting the dma_pfn_offset comes from commit b44bbc46a8bb
("usb: core: setup dma_pfn_offset for USB devices and, interfaces"),
which worked around the fact that the scsi_calculate_bounce_limits
functions wasn't going through the proper driver interface to query
DMA information, but that function was removed in commit 21e07dba9fb1
("scsi: reduce use of block bounce buffers") years ago.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/usb/core/message.c |  6 ------
 drivers/usb/core/usb.c     | 12 ------------
 2 files changed, 18 deletions(-)

diff --git a/drivers/usb/core/message.c b/drivers/usb/core/message.c
index 6197938dcc2d8f..9e45732dc1d1d1 100644
--- a/drivers/usb/core/message.c
+++ b/drivers/usb/core/message.c
@@ -1954,12 +1954,6 @@ int usb_set_configuration(struct usb_device *dev, int configuration)
 		intf->dev.bus = &usb_bus_type;
 		intf->dev.type = &usb_if_device_type;
 		intf->dev.groups = usb_interface_groups;
-		/*
-		 * Please refer to usb_alloc_dev() to see why we set
-		 * dma_mask and dma_pfn_offset.
-		 */
-		intf->dev.dma_mask = dev->dev.dma_mask;
-		intf->dev.dma_pfn_offset = dev->dev.dma_pfn_offset;
 		INIT_WORK(&intf->reset_ws, __usb_queue_reset_device);
 		intf->minor = -1;
 		device_initialize(&intf->dev);
diff --git a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
index bafc113f2b3ef3..9b4ac4415f1a47 100644
--- a/drivers/usb/core/usb.c
+++ b/drivers/usb/core/usb.c
@@ -599,18 +599,6 @@ struct usb_device *usb_alloc_dev(struct usb_device *parent,
 	dev->dev.bus = &usb_bus_type;
 	dev->dev.type = &usb_device_type;
 	dev->dev.groups = usb_device_groups;
-	/*
-	 * Fake a dma_mask/offset for the USB device:
-	 * We cannot really use the dma-mapping API (dma_alloc_* and
-	 * dma_map_*) for USB devices but instead need to use
-	 * usb_alloc_coherent and pass data in 'urb's, but some subsystems
-	 * manually look into the mask/offset pair to determine whether
-	 * they need bounce buffers.
-	 * Note: calling dma_set_mask() on a USB device would set the
-	 * mask for the entire HCD, so don't do that.
-	 */
-	dev->dev.dma_mask = bus->sysdev->dma_mask;
-	dev->dev.dma_pfn_offset = bus->sysdev->dma_pfn_offset;
 	set_dev_node(&dev->dev, dev_to_node(bus->sysdev));
 	dev->state = USB_STATE_ATTACHED;
 	dev->lpm_disable_count = 1;
-- 
2.28.0

