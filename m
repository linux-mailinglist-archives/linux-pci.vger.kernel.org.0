Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F507268685
	for <lists+linux-pci@lfdr.de>; Mon, 14 Sep 2020 09:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbgINHvp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Sep 2020 03:51:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:48106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726023AbgINHvl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 14 Sep 2020 03:51:41 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC8C720829;
        Mon, 14 Sep 2020 07:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600069900;
        bh=sLEmFEgLgQ6VIFDmYtTYiby9H19HNBdE2pb0auPAfNs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MUh+xMZ+3cK9OUG8yLvWphyyGhj7Or4v1gE0rD6UnExgdRYqIRszoy75p+Ht77soV
         dBzl7yjyDdoIBZvIAv/a8hHLpP7ud29rOK5ermxXFAxrIPMqc1KVs5mSVKaY1fISmm
         jyLnRqaaow9iBmMY+4C7qFm71KH/+bqz89eLJRHQ=
Date:   Mon, 14 Sep 2020 09:51:40 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     iommu@lists.linux-foundation.org,
        Russell King <linux@armlinux.org.uk>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Jim Quinlan <james.quinlan@broadcom.com>,
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
Subject: Re: [PATCH 5/6] usb: don't inherity DMA properties for USB devices
Message-ID: <20200914075140.GA1033580@kroah.com>
References: <20200914073343.1579578-1-hch@lst.de>
 <20200914073343.1579578-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200914073343.1579578-6-hch@lst.de>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 14, 2020 at 09:33:42AM +0200, Christoph Hellwig wrote:
> As the comment in usb_alloc_dev correctly states, drivers can't use
> the DMA API on usb device, and at least calling dma_set_mask on them
> is highly dangerous.  Unlike what the comment states upper level drivers
> also can't really use the presence of a dma mask to check for DMA
> support, as the dma_mask is set by default for most busses.
> 
> Setting the dma_mask comes from "[PATCH] usbcore dma updates (and doc)"
> in BitKeeper times, as it seems like it was primarily for setting the
> NETIF_F_HIGHDMA flag in USB drivers, something that has long been
> fixed up since.
> 
> Setting the dma_pfn_offset comes from commit b44bbc46a8bb
> ("usb: core: setup dma_pfn_offset for USB devices and, interfaces"),
> which worked around the fact that the scsi_calculate_bounce_limits
> functions wasn't going through the proper driver interface to query
> DMA information, but that function was removed in commit 21e07dba9fb1
> ("scsi: reduce use of block bounce buffers") years ago.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
