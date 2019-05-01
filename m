Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C74E9109FE
	for <lists+linux-pci@lfdr.de>; Wed,  1 May 2019 17:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbfEAPZF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 May 2019 11:25:05 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33055 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbfEAPZF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 May 2019 11:25:05 -0400
Received: by mail-wr1-f68.google.com with SMTP id e28so1903935wra.0
        for <linux-pci@vger.kernel.org>; Wed, 01 May 2019 08:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dnCVASXEPfC7FII5Fy/nSbQ8uR8+Ly3wRUufo71BHro=;
        b=Fz4lDrO5EOlduWF6uAcUY+gytq80mhcFdo73iBEaoTB6srVo+auLCcCsKbP+FWG+h3
         OD+QhT3HlUehrs2VNoPfaTDXuKHBlVpsK1aqNlhrDic8rNO47IFCbSqrS4L6p8an5uvi
         LXmnSs7ygFZrHEaL6G9cu/rrBu91h/00Q5kz4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dnCVASXEPfC7FII5Fy/nSbQ8uR8+Ly3wRUufo71BHro=;
        b=CvLhBXFWLdork0lEOPTmaL1MGDaTMsxdg9fKGUx+I1DDDy9bo+im6BgMhCJBvSTRyl
         0he99f3Nrc1jmXGNUL3ogsdq1nv+MKxJ0JLk10g5JirPhXpUL7hnTU8GZsPvZu/A0uaG
         uxShx1fOKFcZYlYIHqzYMtZFs9rnEqLnFJLkCf7rsQ+fiWdpvvQ6jQkvu5MaerE/9gTx
         YPUi341C12zMH9edjCfpnljXDHOILrkoIM0+KXH2IYmIEjVQdFpQqZCtLKrPr9b7cVYc
         cM6pfQKcwvabB3NFRx33ng/RQNM+ygtyFtyphvP17CPQO5XVYvkIazLpLF8AR4awXmWr
         V3vg==
X-Gm-Message-State: APjAAAXkeKvccSTOj93UJDYOO2ZgrCEJdroQwZC956HwiB4Tyu78YEbp
        SeJsHGBu0e44LasZKpwiWORmgPfrUTHYRyxfyAwXVA==
X-Google-Smtp-Source: APXvYqzwe5ifWXo+JysSH/l2XXvlDOPp4yfZ8GaGFKMc+ujM+MUFItj0lA+eEOUSuKWPR901Bj+uu2EqlirmPq6I9qQ=
X-Received: by 2002:adf:fcc8:: with SMTP id f8mr34825124wrs.250.1556724303574;
 Wed, 01 May 2019 08:25:03 -0700 (PDT)
MIME-Version: 1.0
References: <1555038815-31916-1-git-send-email-srinath.mannam@broadcom.com>
 <20190501113038.GA7961@e121166-lin.cambridge.arm.com> <20190501125530.GA15590@google.com>
 <119be78f-34f5-c19b-d41b-f7279e968b46@arm.com>
In-Reply-To: <119be78f-34f5-c19b-d41b-f7279e968b46@arm.com>
From:   Srinath Mannam <srinath.mannam@broadcom.com>
Date:   Wed, 1 May 2019 20:54:51 +0530
Message-ID: <CABe79T4TM555y5ePpvoT3OcgVDbRzQUjTQmqeJWNbHT-8FTnaQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] PCIe Host request to reserve IOVA
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Joerg Roedel <joro@8bytes.org>, poza@codeaurora.org,
        Ray Jui <rjui@broadcom.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Robin,

Thank you so much for all the information.

Regards,
Srinath.

On Wed, May 1, 2019 at 6:51 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2019-05-01 1:55 pm, Bjorn Helgaas wrote:
> > On Wed, May 01, 2019 at 12:30:38PM +0100, Lorenzo Pieralisi wrote:
> >> On Fri, Apr 12, 2019 at 08:43:32AM +0530, Srinath Mannam wrote:
> >>> Few SOCs have limitation that their PCIe host can't allow few inbound
> >>> address ranges. Allowed inbound address ranges are listed in dma-ranges
> >>> DT property and this address ranges are required to do IOVA mapping.
> >>> Remaining address ranges have to be reserved in IOVA mapping.
> >>>
> >>> PCIe Host driver of those SOCs has to list resource entries of allowed
> >>> address ranges given in dma-ranges DT property in sorted order. This
> >>> sorted list of resources will be processed and reserve IOVA address for
> >>> inaccessible address holes while initializing IOMMU domain.
> >>>
> >>> This patch set is based on Linux-5.0-rc2.
> >>>
> >>> Changes from v3:
> >>>    - Addressed Robin Murphy review comments.
> >>>      - pcie-iproc: parse dma-ranges and make sorted resource list.
> >>>      - dma-iommu: process list and reserve gaps between entries
> >>>
> >>> Changes from v2:
> >>>    - Patch set rebased to Linux-5.0-rc2
> >>>
> >>> Changes from v1:
> >>>    - Addressed Oza review comments.
> >>>
> >>> Srinath Mannam (3):
> >>>    PCI: Add dma_ranges window list
> >>>    iommu/dma: Reserve IOVA for PCIe inaccessible DMA address
> >>>    PCI: iproc: Add sorted dma ranges resource entries to host bridge
> >>>
> >>>   drivers/iommu/dma-iommu.c           | 19 ++++++++++++++++
> >>>   drivers/pci/controller/pcie-iproc.c | 44 ++++++++++++++++++++++++++++++++++++-
> >>>   drivers/pci/probe.c                 |  3 +++
> >>>   include/linux/pci.h                 |  1 +
> >>>   4 files changed, 66 insertions(+), 1 deletion(-)
> >>
> >> Bjorn, Joerg,
> >>
> >> this series should not affect anything in the mainline other than its
> >> consumer (ie patch 3); if that's the case should we consider it for v5.2
> >> and if yes how are we going to merge it ?
> >
> > I acked the first one
> >
> > Robin reviewed the second
> > (https://lore.kernel.org/lkml/e6c812d6-0cad-4cfd-defd-d7ec427a6538@arm.com)
> > (though I do agree with his comment about DMA_BIT_MASK()), Joerg was OK
> > with it if Robin was
> > (https://lore.kernel.org/lkml/20190423145721.GH29810@8bytes.org).
> >
> > Eric reviewed the third (and pointed out a typo).
> >
> > My Kconfiggery never got fully answered -- it looks to me as though it's
> > possible to build pcie-iproc without the DMA hole support, and I thought
> > the whole point of this series was to deal with those holes
> > (https://lore.kernel.org/lkml/20190418234241.GF126710@google.com).  I would
> > have expected something like making pcie-iproc depend on IOMMU_SUPPORT.
> > But Srinath didn't respond to that, so maybe it's not an issue and it
> > should only affect pcie-iproc anyway.
>
> Hmm, I'm sure I had at least half-written a reply on that point, but I
> can't seem to find it now... anyway, the gist is that these inbound
> windows are generally set up to cover the physical address ranges of
> DRAM and anything else that devices might need to DMA to. Thus if you're
> not using an IOMMU, the fact that devices can't access the gaps in
> between doesn't matter because there won't be anything there anyway; it
> only needs mitigating if you do use an IOMMU and start giving arbitrary
> non-physical addresses to the endpoint.
>
> > So bottom line, I'm fine with merging it for v5.2.  Do you want to merge
> > it, Lorenzo, or ...?
>
> This doesn't look like it will conflict with the other DMA ops and MSI
> mapping changes currently in-flight for iommu-dma, so I have no
> objection to it going through the PCI tree for 5.2.
>
> Robin.
