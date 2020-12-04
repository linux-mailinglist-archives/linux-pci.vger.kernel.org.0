Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFCEA2CF042
	for <lists+linux-pci@lfdr.de>; Fri,  4 Dec 2020 16:04:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730430AbgLDPBf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Dec 2020 10:01:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:60416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730420AbgLDPBe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 4 Dec 2020 10:01:34 -0500
Date:   Fri, 4 Dec 2020 16:02:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1607094054;
        bh=r/FRTTah1QcRTa4v/loAf9+zj5pTNfpEuX9XO3neHq8=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=kHTVuwxbCS+OL5mI6RZqzn8irwACv5nQYAwOirdFlDGcckh/dkyT+iN/E+Vf+XcW0
         19p7JxayNWBxcEHgZJy4fwFxzEurErLiavI2jKXQXlOrjzDGbmq7v3UH3tAqpPp27W
         EuKMAq9YEwl46XuY9MaCGk6aB9/2E+pLL8/N0oGU=
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Tom Yan <tom.ty89@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Christoph Hellwig <hch@lst.de>,
        linux-usb <linux-usb@vger.kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 2/2] usb-storage: revert from scsi_add_host_with_dma() to
 scsi_add_host()
Message-ID: <X8pPau40cCVDSyIt@kroah.com>
References: <09992cec-65e4-2757-aae6-8fb02a42f961@redhat.com>
 <20201128154849.3193-1-tom.ty89@gmail.com>
 <20201128154849.3193-2-tom.ty89@gmail.com>
 <5e62c383-22ea-6df6-5acc-5e9f381d4632@redhat.com>
 <CAGnHSEnetAJNqUEW-iuq7eVyU6VnP84cv9+OVL4C5Z2ZK_eM0A@mail.gmail.com>
 <186eb035-4bc4-ff72-ee41-aeb6d81888e3@redhat.com>
 <X8T0E2qvF2cgADl+@kroah.com>
 <dd557c38-a919-5e5e-ab3b-17a235f17139@redhat.com>
 <X8T5bimon2oaUUqI@kroah.com>
 <70ca74c2-4a80-e25b-eca9-a63a75516673@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70ca74c2-4a80-e25b-eca9-a63a75516673@redhat.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 30, 2020 at 02:55:45PM +0100, Hans de Goede wrote:
> Hi,
> 
> On 11/30/20 2:53 PM, Greg KH wrote:
> > On Mon, Nov 30, 2020 at 02:36:38PM +0100, Hans de Goede wrote:
> >> Hi,
> >>
> >> On 11/30/20 2:30 PM, Greg KH wrote:
> >>> On Mon, Nov 30, 2020 at 02:23:48PM +0100, Hans de Goede wrote:
> >>>> Hi,
> >>>>
> >>>> On 11/30/20 1:58 PM, Tom Yan wrote:
> >>>>> It's merely a moving of comment moving for/and a no-behavioral-change
> >>>>> adaptation for the reversion.>
> >>>>
> >>>> IMHO the revert of the troublesome commit and the other/new changes really
> >>>> should be 2 separate commits. But I will let Alan and Greg have the final
> >>>> verdict on this.
> >>>
> >>> I would prefer to just revert the commits and not do anything
> >>> different/special here so late in the release cycle.
> >>>
> >>> So, if Alan agrees, I'll be glad to do them on my end, I just need the
> >>> commit ids for them.
> >>
> >> The troublesome commit are (in reverse, so revert, order):
> >>
> >> 5df7ef7d32fe ("uas: bump hw_max_sectors to 2048 blocks for SS or faster drives")
> >> 558033c2828f ("uas: fix sdev->host->dma_dev")
> >> 0154012f8018 ("usb-storage: fix sdev->host->dma_dev")
> >>
> >> Alan, the reason for reverting these is that using scsi_add_host_with_dma() as the
> >> last 2 patches do, with the dmadev argument of that call pointing to the device
> >> for the XHCI controller is causing changes to the DMA settings of the XHCI controller
> >> itself which is causing regressions in 5.10, see this email thread:
> >>
> >> https://lore.kernel.org/linux-usb/fde7e11f-5dfc-8348-c134-a21cb1116285@redhat.com/T/#t
> > 
> > Thanks, I'll wait for Alan to respond, but I think just reverting these
> > is the best solution at this point in time.  You have tested those
> > reverts, solve this, right?  If so, can I get a "Tested-by:"? 
> 
> Yes that was my first solution to this problem and I can confirm that that fixes
> the regression:
> 
> Tested-by: Hans de Goede <hdegoede@redhat.com>

All now reverted.

thanks,

greg k-h
