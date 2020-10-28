Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E49B29DF07
	for <lists+linux-pci@lfdr.de>; Thu, 29 Oct 2020 01:58:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728216AbgJ2A6q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Oct 2020 20:58:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:60508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731592AbgJ1WRd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Oct 2020 18:17:33 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2E0F22258;
        Wed, 28 Oct 2020 07:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603868780;
        bh=YChEHz/HMIZXFgJlC5N7Fzlzj7gCzimRk6RkLGlPpUo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IANYRRmHlPy3bhAs1Hh2qZjQG6VQMppaQETQCro/w3g91t/KxQHsTcQVJbN+VbbZE
         XSrR+E9z17g2oZ7bRdkvybjHxVqKIflDh50Hi9D7MQGouEwvRhhNhmoYj9BuoXhAiW
         WhMAnO1UprkB/vEiW+MXOJfC/vxYwtO9s1v1WS5U=
Date:   Wed, 28 Oct 2020 08:07:12 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sherry Sun <sherry.sun@nxp.com>
Cc:     "hch@infradead.org" <hch@infradead.org>,
        "vincent.whitchurch@axis.com" <vincent.whitchurch@axis.com>,
        "sudeep.dutt@intel.com" <sudeep.dutt@intel.com>,
        "ashutosh.dixit@intel.com" <ashutosh.dixit@intel.com>,
        "arnd@arndb.de" <arnd@arndb.de>, "kishon@ti.com" <kishon@ti.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>, Andy Duan <fugang.duan@nxp.com>
Subject: Re: [PATCH V5 0/2] Change vring space from nomal memory to dma
 coherent memory
Message-ID: <20201028070712.GA1649838@kroah.com>
References: <20201028020305.10593-1-sherry.sun@nxp.com>
 <20201028055836.GA244690@kroah.com>
 <AM0PR04MB4947032368486CC9874C812692170@AM0PR04MB4947.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM0PR04MB4947032368486CC9874C812692170@AM0PR04MB4947.eurprd04.prod.outlook.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 28, 2020 at 06:05:28AM +0000, Sherry Sun wrote:
> Hi Greg,
> 
> > Subject: Re: [PATCH V5 0/2] Change vring space from nomal memory to dma
> > coherent memory
> > 
> > On Wed, Oct 28, 2020 at 10:03:03AM +0800, Sherry Sun wrote:
> > > Changes in V5:
> > > 1. Reorganize the vop_mmap function code in patch 1, which is done by
> > Christoph.
> > > 2. Completely remove the unnecessary code related to reassign the used
> > > ring for card in patch 2.
> > >
> > > The original vop driver only supports dma coherent device, as it
> > > allocates and maps vring by _get_free_pages and dma_map_single, but
> > > not use dma_sync_single_for_cpu/device to sync the updates of
> > > device_page/vring between EP and RC, which will cause memory
> > > synchronization problem for device don't support hardware dma coherent.
> > >
> > > And allocate vrings use dma_alloc_coherent is a common way in kernel,
> > > as the memory interacted between two systems should use consistent
> > > memory to avoid caching effects. So here add noncoherent platform
> > support for vop driver.
> > > Also add some related dma changes to make sure noncoherent platform
> > > works well.
> > >
> > > Sherry Sun (2):
> > >   misc: vop: change the way of allocating vrings and device page
> > >   misc: vop: do not allocate and reassign the used ring
> > >
> > >  drivers/misc/mic/bus/vop_bus.h     |   2 +
> > >  drivers/misc/mic/host/mic_boot.c   |   9 ++
> > >  drivers/misc/mic/host/mic_main.c   |  43 ++------
> > >  drivers/misc/mic/vop/vop_debugfs.c |   4 -
> > >  drivers/misc/mic/vop/vop_main.c    |  70 +-----------
> > >  drivers/misc/mic/vop/vop_vringh.c  | 166 ++++++++++-------------------
> > >  include/uapi/linux/mic_common.h    |   9 +-
> > >  7 files changed, 85 insertions(+), 218 deletions(-)
> > 
> > Have you all seen:
> > 	https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%
> > 2Flore.kernel.org%2Fr%2F8c1443136563de34699d2c084df478181c205db4.16
> > 03854416.git.sudeep.dutt%40intel.com&amp;data=04%7C01%7Csherry.sun%
> > 40nxp.com%7Cc19c987667434969847e08d87b0685e8%7C686ea1d3bc2b4c6f
> > a92cd99c5c301635%7C0%7C0%7C637394615238940323%7CUnknown%7CTW
> > FpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJX
> > VCI6Mn0%3D%7C1000&amp;sdata=Zq%2FtHWTq%2BuIVBYXFGoeBmq0JJzYd
> > 9zDyv4NVN4TpC%2FU%3D&amp;reserved=0
> > 
> > Looks like this code is asking to just be deleted, is that ok with you?
> 
> Yes, I saw that patch. I'm ok with it.

Great, can you please provide a "Reviewed-by:" or "Acked-by:" for it?

thanks,

greg k-h
