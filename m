Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF8229DE66
	for <lists+linux-pci@lfdr.de>; Thu, 29 Oct 2020 01:54:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732312AbgJ1WTJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Oct 2020 18:19:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:60510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731783AbgJ1WRp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Oct 2020 18:17:45 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4ABF246B1;
        Wed, 28 Oct 2020 11:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603883579;
        bh=RJ9ykVp5/VBMVYU2UaC4tSf7S71M609QGWBo1zd6fvU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fJtEWKRDcVR3PZzvaXM6+dpyvhhGPlwT5TeHV8luPiDQWAA3aI6KJ21c1c4U4wSRu
         NjJNY5iYrVHN0iOpdRtyRyvQtkpDyovYKl4TVqWJmC/9be1nLEmgZ0mp7PpDpO3xe5
         1WFpwyaAZ7KgaLhktVRT9qtImxzQIEEcLs92iTQs=
Date:   Wed, 28 Oct 2020 12:13:51 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Andy Duan <fugang.duan@nxp.com>
Cc:     Sherry Sun <sherry.sun@nxp.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "vincent.whitchurch@axis.com" <vincent.whitchurch@axis.com>,
        "sudeep.dutt@intel.com" <sudeep.dutt@intel.com>,
        "ashutosh.dixit@intel.com" <ashutosh.dixit@intel.com>,
        "arnd@arndb.de" <arnd@arndb.de>, "kishon@ti.com" <kishon@ti.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [EXT] Re: [PATCH V5 0/2] Change vring space from nomal memory to
 dma coherent memory
Message-ID: <20201028111351.GA1964851@kroah.com>
References: <20201028020305.10593-1-sherry.sun@nxp.com>
 <20201028055836.GA244690@kroah.com>
 <AM0PR04MB4947032368486CC9874C812692170@AM0PR04MB4947.eurprd04.prod.outlook.com>
 <20201028070712.GA1649838@kroah.com>
 <AM8PR04MB7315D583A9490E642ED13071FF170@AM8PR04MB7315.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM8PR04MB7315D583A9490E642ED13071FF170@AM8PR04MB7315.eurprd04.prod.outlook.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 28, 2020 at 10:17:39AM +0000, Andy Duan wrote:
> From: Greg KH <gregkh@linuxfoundation.org> Sent: Wednesday, October 28, 2020 3:07 PM
> > On Wed, Oct 28, 2020 at 06:05:28AM +0000, Sherry Sun wrote:
> > > Hi Greg,
> > >
> > > > Subject: Re: [PATCH V5 0/2] Change vring space from nomal memory to
> > > > dma coherent memory
> > > >
> > > > On Wed, Oct 28, 2020 at 10:03:03AM +0800, Sherry Sun wrote:
> > > > > Changes in V5:
> > > > > 1. Reorganize the vop_mmap function code in patch 1, which is done
> > > > > by
> > > > Christoph.
> > > > > 2. Completely remove the unnecessary code related to reassign the
> > > > > used ring for card in patch 2.
> > > > >
> > > > > The original vop driver only supports dma coherent device, as it
> > > > > allocates and maps vring by _get_free_pages and dma_map_single,
> > > > > but not use dma_sync_single_for_cpu/device to sync the updates of
> > > > > device_page/vring between EP and RC, which will cause memory
> > > > > synchronization problem for device don't support hardware dma coherent.
> > > > >
> > > > > And allocate vrings use dma_alloc_coherent is a common way in
> > > > > kernel, as the memory interacted between two systems should use
> > > > > consistent memory to avoid caching effects. So here add
> > > > > noncoherent platform
> > > > support for vop driver.
> > > > > Also add some related dma changes to make sure noncoherent
> > > > > platform works well.
> > > > >
> > > > > Sherry Sun (2):
> > > > >   misc: vop: change the way of allocating vrings and device page
> > > > >   misc: vop: do not allocate and reassign the used ring
> > > > >
> > > > >  drivers/misc/mic/bus/vop_bus.h     |   2 +
> > > > >  drivers/misc/mic/host/mic_boot.c   |   9 ++
> > > > >  drivers/misc/mic/host/mic_main.c   |  43 ++------
> > > > >  drivers/misc/mic/vop/vop_debugfs.c |   4 -
> > > > >  drivers/misc/mic/vop/vop_main.c    |  70 +-----------
> > > > >  drivers/misc/mic/vop/vop_vringh.c  | 166 ++++++++++-------------------
> > > > >  include/uapi/linux/mic_common.h    |   9 +-
> > > > >  7 files changed, 85 insertions(+), 218 deletions(-)
> > > >
> > > > Have you all seen:
> > > >
> > > > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%25
> > > >
> > 2Flore.kernel.org%2Fr%2F8c1443136563de34699d2c084df478181c205db4.16
> > > >
> > 03854416.git.sudeep.dutt%40intel.com&amp;data=04%7C01%7Csherry.sun%
> > > >
> > 40nxp.com%7Cc19c987667434969847e08d87b0685e8%7C686ea1d3bc2b4c6f
> > > >
> > a92cd99c5c301635%7C0%7C0%7C637394615238940323%7CUnknown%7CTW
> > > >
> > FpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJX
> > > >
> > VCI6Mn0%3D%7C1000&amp;sdata=Zq%2FtHWTq%2BuIVBYXFGoeBmq0JJzYd
> > > > 9zDyv4NVN4TpC%2FU%3D&amp;reserved=0
> > > >
> > > > Looks like this code is asking to just be deleted, is that ok with you?
> > >
> > > Yes, I saw that patch. I'm ok with it.
> > 
> > Great, can you please provide a "Reviewed-by:" or "Acked-by:" for it?
> > 
> > thanks,
> > 
> > greg k-h
> 
> Sherry took much effort on the features support on i.MX series like i.MX8QM/i.MX8QXP/i.MX8MM.
> 
> Now it is a pity to delete the vop code.
> 
> One question, 
> can we resubmit vop code by clean up, now only for i.MX series as Dutt's suggestion ?
> Or we have to drop the design and switch to select other solutions ?

If this whole subsystem is being deleted because it is not used and
never shipped, yes, please use a different solution.

I don't understand why you were trying to piggy-back on this codebase if
the hardware was totally different, for some reason I thought this was
the same hardware.  What exactly is this?

thanks,

greg k-h
