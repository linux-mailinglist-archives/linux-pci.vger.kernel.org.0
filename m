Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29FAB29DF3F
	for <lists+linux-pci@lfdr.de>; Thu, 29 Oct 2020 02:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731548AbgJ2BAK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Oct 2020 21:00:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:60520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731552AbgJ1WR2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Oct 2020 18:17:28 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2CEBF223AB;
        Wed, 28 Oct 2020 05:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603864720;
        bh=S+T1g/75keSFr0V0daEFLuZRzriMpG3CH6cVm0SyMPM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d+4DS8AfQdxNoQ74BGZqaEhQm/i/vh4zTprBfBIZwGt+kA5PhuG39OXoWomGLeFwH
         XVOpyskothizvsyIdbtG/vZ1g7+FbNr47QqFzJ1iTNW8j7aDhzTD9Ob18K7z/CeQ9Y
         lzKGU2R5K9580h9R5dwjhT0SEL1yGqqJFqGTBJ5k=
Date:   Wed, 28 Oct 2020 06:58:36 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sherry Sun <sherry.sun@nxp.com>
Cc:     hch@infradead.org, vincent.whitchurch@axis.com,
        sudeep.dutt@intel.com, ashutosh.dixit@intel.com, arnd@arndb.de,
        kishon@ti.com, lorenzo.pieralisi@arm.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-imx@nxp.com, fugang.duan@nxp.com
Subject: Re: [PATCH V5 0/2] Change vring space from nomal memory to dma
 coherent memory
Message-ID: <20201028055836.GA244690@kroah.com>
References: <20201028020305.10593-1-sherry.sun@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201028020305.10593-1-sherry.sun@nxp.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 28, 2020 at 10:03:03AM +0800, Sherry Sun wrote:
> Changes in V5:
> 1. Reorganize the vop_mmap function code in patch 1, which is done by Christoph. 
> 2. Completely remove the unnecessary code related to reassign the used ring for
> card in patch 2.
> 
> The original vop driver only supports dma coherent device, as it allocates and
> maps vring by _get_free_pages and dma_map_single, but not use 
> dma_sync_single_for_cpu/device to sync the updates of device_page/vring between
> EP and RC, which will cause memory synchronization problem for device don't
> support hardware dma coherent.
> 
> And allocate vrings use dma_alloc_coherent is a common way in kernel, as the
> memory interacted between two systems should use consistent memory to avoid
> caching effects. So here add noncoherent platform support for vop driver.
> Also add some related dma changes to make sure noncoherent platform works
> well.
> 
> Sherry Sun (2):
>   misc: vop: change the way of allocating vrings and device page
>   misc: vop: do not allocate and reassign the used ring
> 
>  drivers/misc/mic/bus/vop_bus.h     |   2 +
>  drivers/misc/mic/host/mic_boot.c   |   9 ++
>  drivers/misc/mic/host/mic_main.c   |  43 ++------
>  drivers/misc/mic/vop/vop_debugfs.c |   4 -
>  drivers/misc/mic/vop/vop_main.c    |  70 +-----------
>  drivers/misc/mic/vop/vop_vringh.c  | 166 ++++++++++-------------------
>  include/uapi/linux/mic_common.h    |   9 +-
>  7 files changed, 85 insertions(+), 218 deletions(-)

Have you all seen:
	https://lore.kernel.org/r/8c1443136563de34699d2c084df478181c205db4.1603854416.git.sudeep.dutt@intel.com

Looks like this code is asking to just be deleted, is that ok with you?

thanks,

greg k-h
