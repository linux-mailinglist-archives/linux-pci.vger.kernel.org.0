Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 035663A379C
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jun 2021 01:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbhFJXGX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Jun 2021 19:06:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:46170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231158AbhFJXGW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 10 Jun 2021 19:06:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8597C613D9;
        Thu, 10 Jun 2021 23:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623366265;
        bh=YiMzLln/KGaA2CDeQfkZ0cx2ivCi8D7ujNBrsZB2MF0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=mfXtI71H1KIcfu1YbIj4XUI3FPHSx/j7tE3GuLawZD6OGK89jA4m0TUt/Xx69lzSW
         fKniEBOYvZZdYGAu+HxcPMZ8MvJf/BsVpHRdULWAfMYtivx590g8j+OJVV0pYzVV0U
         IPgMW8kuM+eJC+T4bZbCXaozlHhV+dAT7SXdmq91SEj8ECHY6QgKW9+/anOYLpMLhP
         gZzM2vydAAyZUHOt5XEnRe1J3Jw9X9TkiO0br46L71tJT2gWLPv7YLoJ9SxgV+VqgI
         Bk0UEEDJ4x0MXfhWmlfTO9t6VOe5C5Ck9aM1w/iG6iNRSwukJLeq7sH6UKMvv4P4mL
         QatIdGOx2AU1Q==
Date:   Thu, 10 Jun 2021 18:04:24 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Don Dutile <ddutile@redhat.com>
Subject: Re: [PATCH v1 0/6] P2PDMA Cleanup
Message-ID: <20210610230424.GA2791113@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210610160609.28447-1-logang@deltatee.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 10, 2021 at 10:06:03AM -0600, Logan Gunthorpe wrote:
> Hi Bjorn,
> 
> This patch series consists of the P2PDMA cleanup and prep patches based
> on feedback from  my P2PDMA mapping operations series (most recently
> posted at [1]). I've reduced the recipient list of this series to those
> that I thought would be interested or have provided the feedback that
> inspired these patches.
> 
> Please consider taking these patches in the near term ahead of my mapping
> ops series. These patches are largely cleanup and other minor fixes. The only
> functional change is Patch 4 which adds a new warning that was suggested by
> Don.
> 
> Patch 6 arguably isn't necessary yet as we don't care about sleeping
> yet -- but it'd be a nice to have to reduce the number of prep patches for my
> other series. However, if you don't want to take this patch now, I can
> carry it in my other series.
> 
> I'm happy to make further fixes and update this series if anyone finds any
> additional issues on review.
> 
> Thanks,
> 
> Logan
> 
> [1] https://lore.kernel.org/linux-block/20210513223203.5542-1-logang@deltatee.com/
> 
> --
> 
> Logan Gunthorpe (6):
>   PCI/P2PDMA: Rename upstream_bridge_distance() and rework documentation
>   PCI/P2PDMA: Use a buffer on the stack for collecting the acs list
>   PCI/P2PDMA: Cleanup type for return value of calc_map_type_and_dist()
>   PCI/P2PDMA: Print a warning if the host bridge is not in the whitelist
>   PCI/P2PDMA: Refactor pci_p2pdma_map_type() to take pagemap and device
>   PCI/P2PDMA: Avoid pci_get_slot() which sleeps
> 
>  drivers/pci/p2pdma.c | 157 +++++++++++++++++++++++++------------------
>  1 file changed, 92 insertions(+), 65 deletions(-)

Applied all 6 to pci/p2pdma for v5.14, thanks!

  6389d4374522 ("PCI/P2PDMA: Rename upstream_bridge_distance() and rework doc")
  e4ece59abd70 ("PCI/P2PDMA: Collect acs list in stack buffer to avoid sleeping")
  f9c125b9eb30 ("PCI/P2PDMA: Use correct calc_map_type_and_dist() return type")
  cf201bfe8cdc ("PCI/P2PDMA: Warn if host bridge not in whitelist")
  7e2faa1710c4 ("PCI/P2PDMA: Refactor pci_p2pdma_map_type()")
  3ec0c3ec2d92 ("PCI/P2PDMA: Avoid pci_get_slot(), which may sleep")
