Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6184F1080E
	for <lists+linux-pci@lfdr.de>; Wed,  1 May 2019 14:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725993AbfEAMze (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 May 2019 08:55:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:54992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725971AbfEAMze (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 1 May 2019 08:55:34 -0400
Received: from localhost (114.sub-174-234-175.myvzw.com [174.234.175.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6913F2054F;
        Wed,  1 May 2019 12:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556715332;
        bh=MN3npVGu6dRJw07wS8Ub5YiRqYPp8LOfgP5MrE/dIJw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MXDStdNl2oByvpBG0yh14g4d3zoUum0uX2caWm5QjeOF3MOLM2PoxXFOJxy/VUddj
         XS58/NDXYWfPpJrnWOcAQ8Kz1Nhe4E+2Hdj6TcJi9XgvXMLCPwseXTTcwnvXuVPWNY
         1g2JoSh8UA14KKCk3v7NCV2NMux2T5n7D1DYi0aU=
Date:   Wed, 1 May 2019 07:55:31 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Srinath Mannam <srinath.mannam@broadcom.com>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>, poza@codeaurora.org,
        Ray Jui <rjui@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/3] PCIe Host request to reserve IOVA
Message-ID: <20190501125530.GA15590@google.com>
References: <1555038815-31916-1-git-send-email-srinath.mannam@broadcom.com>
 <20190501113038.GA7961@e121166-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190501113038.GA7961@e121166-lin.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 01, 2019 at 12:30:38PM +0100, Lorenzo Pieralisi wrote:
> On Fri, Apr 12, 2019 at 08:43:32AM +0530, Srinath Mannam wrote:
> > Few SOCs have limitation that their PCIe host can't allow few inbound
> > address ranges. Allowed inbound address ranges are listed in dma-ranges
> > DT property and this address ranges are required to do IOVA mapping.
> > Remaining address ranges have to be reserved in IOVA mapping.
> > 
> > PCIe Host driver of those SOCs has to list resource entries of allowed
> > address ranges given in dma-ranges DT property in sorted order. This
> > sorted list of resources will be processed and reserve IOVA address for
> > inaccessible address holes while initializing IOMMU domain.
> > 
> > This patch set is based on Linux-5.0-rc2.
> > 
> > Changes from v3:
> >   - Addressed Robin Murphy review comments.
> >     - pcie-iproc: parse dma-ranges and make sorted resource list.
> >     - dma-iommu: process list and reserve gaps between entries
> > 
> > Changes from v2:
> >   - Patch set rebased to Linux-5.0-rc2
> > 
> > Changes from v1:
> >   - Addressed Oza review comments.
> > 
> > Srinath Mannam (3):
> >   PCI: Add dma_ranges window list
> >   iommu/dma: Reserve IOVA for PCIe inaccessible DMA address
> >   PCI: iproc: Add sorted dma ranges resource entries to host bridge
> > 
> >  drivers/iommu/dma-iommu.c           | 19 ++++++++++++++++
> >  drivers/pci/controller/pcie-iproc.c | 44 ++++++++++++++++++++++++++++++++++++-
> >  drivers/pci/probe.c                 |  3 +++
> >  include/linux/pci.h                 |  1 +
> >  4 files changed, 66 insertions(+), 1 deletion(-)
> 
> Bjorn, Joerg,
> 
> this series should not affect anything in the mainline other than its
> consumer (ie patch 3); if that's the case should we consider it for v5.2
> and if yes how are we going to merge it ?

I acked the first one

Robin reviewed the second
(https://lore.kernel.org/lkml/e6c812d6-0cad-4cfd-defd-d7ec427a6538@arm.com)
(though I do agree with his comment about DMA_BIT_MASK()), Joerg was OK
with it if Robin was
(https://lore.kernel.org/lkml/20190423145721.GH29810@8bytes.org).

Eric reviewed the third (and pointed out a typo).

My Kconfiggery never got fully answered -- it looks to me as though it's
possible to build pcie-iproc without the DMA hole support, and I thought
the whole point of this series was to deal with those holes
(https://lore.kernel.org/lkml/20190418234241.GF126710@google.com).  I would
have expected something like making pcie-iproc depend on IOMMU_SUPPORT.
But Srinath didn't respond to that, so maybe it's not an issue and it
should only affect pcie-iproc anyway.

So bottom line, I'm fine with merging it for v5.2.  Do you want to merge
it, Lorenzo, or ...?

Bjorn
