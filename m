Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC84F3ACF23
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jun 2021 17:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235543AbhFRPfL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Jun 2021 11:35:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:59414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235710AbhFRPfF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 18 Jun 2021 11:35:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 00BEB6120A;
        Fri, 18 Jun 2021 15:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624030376;
        bh=+FFSC0zj5RwLkGI3nedO+OdvNVE7P5xcolwUD5+csdM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=a91Z9QyM5lf3pO3gumqpUQpzlBcimPsoRvNl9xcT/OkC/UwBLxXD1c2HHJxzwS6xY
         oyhw7cWJm5svXcpzDDP7gB8cd4Z1XkW1yFeBwK2lRKnqhYGuW6yC4ShbtIqwHNv78k
         NIqH09prr5+xFH1y2bEE86cnH+yhGXsQjbmauGK/zGjq1HGc/HznLjRKpGs+01bk2n
         ZHYA40H5k3Fbt+2IDg9Zx0Na1cyUJoBKIqfhtaGu4lPDIzzVnX6brbvkHd8o95WcID
         9m00zajpridHKyryJhnyqyDcXMgM3bolfInXjD7PR2zcQgEPf4AeW3Onlur4/KDV/d
         bPC6DHtn3Fxag==
Date:   Fri, 18 Jun 2021 10:32:54 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Domenico Andreoli <domenico.andreoli@linux.com>
Cc:     Punit Agrawal <punitagrawal@gmail.com>, robh+dt@kernel.org,
        maz@kernel.org, leobras.c@gmail.com,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, alexandru.elisei@arm.com, wqu@suse.com,
        robin.murphy@arm.com, pgwipeout@gmail.com, ardb@kernel.org,
        briannorris@chromium.org, shawn.lin@rock-chips.com,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v4] PCI: of: Clear 64-bit flag for non-prefetchable
 memory below 4GB
Message-ID: <20210618153254.GA3191723@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMyl31ERhGDE1yGh@m4>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 18, 2021 at 03:55:43PM +0200, Domenico Andreoli wrote:
> On Wed, Jun 16, 2021 at 06:12:34PM -0500, Bjorn Helgaas wrote:
> > On Tue, Jun 15, 2021 at 08:04:57AM +0900, Punit Agrawal wrote:
> > > Alexandru and Qu reported this resource allocation failure on
> > > ROCKPro64 v2 and ROCK Pi 4B, both based on the RK3399:
> > > 
> > >   pci_bus 0000:00: root bus resource [mem 0xfa000000-0xfbdfffff 64bit]
> > >   pci 0000:00:00.0: PCI bridge to [bus 01]
> > >   pci 0000:00:00.0: BAR 14: no space for [mem size 0x00100000]
> > >   pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x00003fff 64bit]
> > > 
> > > "BAR 14" is the PCI bridge's 32-bit non-prefetchable window, and our
> > > PCI allocation code isn't smart enough to allocate it in a host
> > > bridge window marked as 64-bit, even though this should work fine.
> > > 
> > > A DT host bridge description includes the windows from the CPU
> > > address space to the PCI bus space.  On a few architectures
> > > (microblaze, powerpc, sparc), the DT may also describe PCI devices
> > > themselves, including their BARs.
> > > 
> > > Before 9d57e61bf723 ("of/pci: Add IORESOURCE_MEM_64 to resource
> > > flags for 64-bit memory addresses"), of_bus_pci_get_flags() ignored
> > > the fact that some DT addresses described 64-bit windows and BARs.
> > > That was a problem because the virtio virtual NIC has a 32-bit BAR
> > > and a 64-bit BAR, and the driver couldn't distinguish them.
> > > 
> > > 9d57e61bf723 set IORESOURCE_MEM_64 for those 64-bit DT ranges, which
> > > fixed the virtio driver.  But it also set IORESOURCE_MEM_64 for host
> > > bridge windows, which exposed the fact that the PCI allocator isn't
> > > smart enough to put 32-bit resources in those 64-bit windows.
> > > 
> > > Clear IORESOURCE_MEM_64 from host bridge windows since we don't need
> > > that information.
> > > 
> > > Fixes: 9d57e61bf723 ("of/pci: Add IORESOURCE_MEM_64 to resource flags for 64-bit memory addresses")
> > > Reported-at: https://lore.kernel.org/lkml/7a1e2ebc-f7d8-8431-d844-41a9c36a8911@arm.com/
> > > Reported-by: Alexandru Elisei <alexandru.elisei@arm.com>
> > > Reported-by: Qu Wenruo <wqu@suse.com>
> > > Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
> > > Signed-off-by: Punit Agrawal <punitagrawal@gmail.com>
> > > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > > Cc: Rob Herring <robh+dt@kernel.org>
> > 
> > Applied with:
> > 
> >     Tested-by: Alexandru Elisei <alexandru.elisei@arm.com>
> >     Reviewed-by: Rob Herring <robh@kernel.org>
> >     Acked-by: Ard Biesheuvel <ardb@kernel.org>
> > 
> > to for-linus for v5.13, thanks a lot!
> 
> Late-tested-by: Domenico Andreoli <domenico.andreoli@linux.com>
> 
> See https://lore.kernel.org/lkml/YMyTUv7Jsd89PGci@m4/T/#u

I updated the commit to add your report and tested-by, thanks!
