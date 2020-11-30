Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D02F32C85F6
	for <lists+linux-pci@lfdr.de>; Mon, 30 Nov 2020 14:54:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbgK3Nyg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Nov 2020 08:54:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:34436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726669AbgK3Nyg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 30 Nov 2020 08:54:36 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C92012067D;
        Mon, 30 Nov 2020 13:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1606744435;
        bh=mzcrewT5KlblZ1Fel9HIaLOCygpQZ1nOoc+X07P1R/s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oHbrHjTqyVRo/UtZ4G7ShB8078NjIHt7qo2G7L9N0CE1cPVzqtK7+DNdY6rHG1OSL
         itPTLRltXPQB1hTi90KuFQezqUKQVCWc+xbFAuhFyezH55938bJ/+3theBRcRp68GT
         +ImsW9IwuXTeWQPv0YOYWIo0eoIDEijEPViXWqWM=
Date:   Mon, 30 Nov 2020 14:53:50 +0100
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
Message-ID: <X8T5bimon2oaUUqI@kroah.com>
References: <09992cec-65e4-2757-aae6-8fb02a42f961@redhat.com>
 <20201128154849.3193-1-tom.ty89@gmail.com>
 <20201128154849.3193-2-tom.ty89@gmail.com>
 <5e62c383-22ea-6df6-5acc-5e9f381d4632@redhat.com>
 <CAGnHSEnetAJNqUEW-iuq7eVyU6VnP84cv9+OVL4C5Z2ZK_eM0A@mail.gmail.com>
 <186eb035-4bc4-ff72-ee41-aeb6d81888e3@redhat.com>
 <X8T0E2qvF2cgADl+@kroah.com>
 <dd557c38-a919-5e5e-ab3b-17a235f17139@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd557c38-a919-5e5e-ab3b-17a235f17139@redhat.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 30, 2020 at 02:36:38PM +0100, Hans de Goede wrote:
> Hi,
> 
> On 11/30/20 2:30 PM, Greg KH wrote:
> > On Mon, Nov 30, 2020 at 02:23:48PM +0100, Hans de Goede wrote:
> >> Hi,
> >>
> >> On 11/30/20 1:58 PM, Tom Yan wrote:
> >>> It's merely a moving of comment moving for/and a no-behavioral-change
> >>> adaptation for the reversion.>
> >>
> >> IMHO the revert of the troublesome commit and the other/new changes really
> >> should be 2 separate commits. But I will let Alan and Greg have the final
> >> verdict on this.
> > 
> > I would prefer to just revert the commits and not do anything
> > different/special here so late in the release cycle.
> > 
> > So, if Alan agrees, I'll be glad to do them on my end, I just need the
> > commit ids for them.
> 
> The troublesome commit are (in reverse, so revert, order):
> 
> 5df7ef7d32fe ("uas: bump hw_max_sectors to 2048 blocks for SS or faster drives")
> 558033c2828f ("uas: fix sdev->host->dma_dev")
> 0154012f8018 ("usb-storage: fix sdev->host->dma_dev")
> 
> Alan, the reason for reverting these is that using scsi_add_host_with_dma() as the
> last 2 patches do, with the dmadev argument of that call pointing to the device
> for the XHCI controller is causing changes to the DMA settings of the XHCI controller
> itself which is causing regressions in 5.10, see this email thread:
> 
> https://lore.kernel.org/linux-usb/fde7e11f-5dfc-8348-c134-a21cb1116285@redhat.com/T/#t

Thanks, I'll wait for Alan to respond, but I think just reverting these
is the best solution at this point in time.  You have tested those
reverts, solve this, right?  If so, can I get a "Tested-by:"? 

thanks,

greg k-h
