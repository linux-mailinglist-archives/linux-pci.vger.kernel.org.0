Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 775AAA0BE1
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2019 22:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfH1Uwz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Aug 2019 16:52:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:57942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726618AbfH1Uwz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Aug 2019 16:52:55 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1914F217F5;
        Wed, 28 Aug 2019 20:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567025574;
        bh=MxTUwvguZO0iDTfR/W0BUhqZMLEuD0P6DX4yPt254ss=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2owBKQd5EHl+vrpuDZl7Puk+Tsy+UUt72HaLYwdKYqk77pXKIwBikn+hizWKD9NGw
         mj0h5qgs2oVfaDVovVOLOrNX6dHgnITZ2QtaHO9vzxVMkTgq3+5k0fi+HMeg66jRzX
         y8vHGjBmjPkG2CDRdjVLGvaFvml1FdyYj7gS7iZ4=
Date:   Wed, 28 Aug 2019 15:52:27 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Cleanup resource_alignment parameter
Message-ID: <20190828205227.GD7013@google.com>
References: <20190822161013.5481-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190822161013.5481-1-logang@deltatee.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 22, 2019 at 10:10:10AM -0600, Logan Gunthorpe wrote:
> As requested, this is a refresh of this series. I rebased it on v5.3-rc5
> without any other changes.
> 
> This is a cleanup of the resource_alignment parameter after finding
> an improved way to handle the static buffer for the disable_acs_redir
> parameter. So this patchset allows us to drop a significant chunk
> of static data.
> 
> Thanks,
> 
> Logan
> 
> --
> 
> Logan Gunthorpe (3):
>   PCI: Clean up resource_alignment parameter to not require static
>     buffer
>   PCI: Move pci_[get|set]_resource_alignment_param() into their callers
>   PCI: Force trailing new line to resource_alignment_param in sysfs
> 
>  drivers/pci/pci.c | 65 +++++++++++++++++++++++++----------------------
>  1 file changed, 35 insertions(+), 30 deletions(-)

Applied to pci/misc for v5.4, thanks!
