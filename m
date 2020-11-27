Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD11D2C694E
	for <lists+linux-pci@lfdr.de>; Fri, 27 Nov 2020 17:22:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731440AbgK0QTE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 Nov 2020 11:19:04 -0500
Received: from verein.lst.de ([213.95.11.211]:38050 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731437AbgK0QTE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 27 Nov 2020 11:19:04 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3D1E668B05; Fri, 27 Nov 2020 17:19:00 +0100 (CET)
Date:   Fri, 27 Nov 2020 17:19:00 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Tom Yan <tom.ty89@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: 5.10 regression caused by: "uas: fix sdev->host->dma_dev":
 many XHCI swiotlb buffer is full / DMAR: Device bounce map failed
 errors on thunderbolt connected XHCI controller
Message-ID: <20201127161900.GA10986@lst.de>
References: <b046dd04-ac4f-3c69-0602-af810fb1b365@redhat.com> <be031d15-201f-0e5c-8b0f-be030077141f@redhat.com> <20201124102715.GA16983@lst.de> <fde7e11f-5dfc-8348-c134-a21cb1116285@redhat.com> <8a52e868-0ca1-55b7-5ad2-ddb0cbb5e45d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a52e868-0ca1-55b7-5ad2-ddb0cbb5e45d@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 27, 2020 at 01:32:16PM +0100, Hans de Goede wrote:
> I ran some more tests, I can confirm that reverting:
> 
> 5df7ef7d32fe "uas: bump hw_max_sectors to 2048 blocks for SS or faster drives"
> 558033c2828f "uas: fix sdev->host->dma_dev"
> 
> Makes the problem go away while running a 5.10 kernel. I also tried doubling
> the swiotlb size by adding: swiotlb=65536 to the kernel commandline but that
> does not help.
> 
> Some more observations:
> 
> 1. The usb-storage driver does not cause this issue, even though it has a
> very similar change.
> 
> 2. The problem does not happen until I plug an UAS decvice into the dock.
> 
> 3. The problem continues to happen even after I unplug the UAS device and
> rmmod the uas module
> 
> 3. made me take a bit closer look to the troublesome commit, it passes:
> udev->bus->sysdev, which I assume is the XHCI controller itself as device
> to scsi_add_host_with_dma, which in turn seems to cause permanent changes
> to the dma settings for the XHCI controller. I'm not all that familiar with
> the DMA APIs but I'm getting the feeling that passing the actual XHCI-controller's
> device as dma-device to scsi_add_host_with_dma is simply the wrong thing to
> do; and that the intended effects (honor XHCI dma limits, but do not cause
> any changes the XHCI dma settings) should be achieved differently.
> 
> Note that if this is indeed wrong, the matching usb-storage change should
> likely also be dropped.

One problem in this area is that the clamping of the DMA size through
dma_max_mapping_size mentioned in the commit log doesn't work when
swiotlb is called from intel-iommu. I think we need to wire up those
calls there as well.
