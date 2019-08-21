Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA6897A80
	for <lists+linux-pci@lfdr.de>; Wed, 21 Aug 2019 15:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728112AbfHUNQw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 21 Aug 2019 09:16:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:53616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726372AbfHUNQv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 21 Aug 2019 09:16:51 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7CDF22CF7;
        Wed, 21 Aug 2019 13:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566393411;
        bh=Riq3+i7XmC+qkfYNb79gSocHjoilNp2cpM1n18oFxN8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AB1f+oiH0cYZQAlS6BhnBmj6xmApLbE2/6+kHCPvoyUhbbw3/38sHOasaPzpGDnLz
         9+rp2ITpYNnrz9cmaB74ijl2Od67FMbtcRv+QvUaTOBWSecMxuwL8cIiqAVO74CAJy
         euFb+EK1L4wHec1BMcaFJ2Bni3a3i7V8khmBH0W4=
Date:   Wed, 21 Aug 2019 08:16:48 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 0/3] Cleanup resource_alignment parameter
Message-ID: <20190821131648.GG14450@google.com>
References: <20190524201610.8039-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190524201610.8039-1-logang@deltatee.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 24, 2019 at 02:16:07PM -0600, Logan Gunthorpe wrote:
> This is a follow up to the cleanup I started last cycle on the
> resource_alignment parameter after finding an improved way to do handle
> the static buffer for the disable_acs_redir parameter. So this patchset
> allows us to drop a significant chunk of static data.
> 
> Per the discussion last cycle, this version keeps the spin locks
> (instead of the RCU implementation) and splits the change into a
> couple different patches.

Hi Logan,

This series doesn't apply cleanly to either v5.3-rc1 or v5.2-rc1.
Would you mind refreshing it?

> Logan Gunthorpe (3):
>   PCI: Clean up resource_alignment parameter to not require static
>     buffer
>   PCI: Move pci_[get|set]_resource_alignment_param() into their callers
>   PCI: Force trailing new line to resource_alignment_param in sysfs
> 
>  drivers/pci/pci.c | 65 +++++++++++++++++++++++++----------------------
>  1 file changed, 35 insertions(+), 30 deletions(-)
> 
> --
> 2.20.1
