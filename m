Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38E9310A15
	for <lists+linux-pci@lfdr.de>; Wed,  1 May 2019 17:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbfEAPco (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 May 2019 11:32:44 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40909 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbfEAPco (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 May 2019 11:32:44 -0400
Received: by mail-wr1-f68.google.com with SMTP id h4so24985919wre.7
        for <linux-pci@vger.kernel.org>; Wed, 01 May 2019 08:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bc+88LNCGPhcKuTHpLbNRlZ4s3Qvo4tvElVwnp97sOM=;
        b=JsP8JCpFanRtIn2BKY6FRVQJBziPR8jAh6Zm0ODvRcCIKJuyOcAAPKb6kkkv7wY8DV
         isC9TDa1aXCwuCVpCvl0LTOUASYXbdzj9lSMYdFo5U/6FKlmblWNE0RgGREO4aAGX2c3
         A+7NoL02RKVXP4+PsTcOVc56/7DiM0sQMr95Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bc+88LNCGPhcKuTHpLbNRlZ4s3Qvo4tvElVwnp97sOM=;
        b=qy9Ux8XHpc0+Tvr8stnVSsRcSo2wbzswxgobxPz7RmrGSAc++yO3SUB3tpzcMYoBvT
         lUP4i+mqb3B17lccCtguLU21H53ArmRrbuoC+dG+U/yg0Pzn9q/NdSSdEDUUgRueSwaK
         Jgc/RgHGeT0TAaUzmYkjf0AoeDRnMTB6sOLZsif8Mdw/4WmxYnsBg8Ddf623X2Kv67Z1
         42oqgSkcEfFMyBS+5XiiK1cIoAZdA8ISNfE86icuFphjsiLameU2mga2IblHonMkjA9j
         d1zAu2304jD5w5YvvbYLB2sHNKDnB7RFG65+rGdIq9QnSxfH7Dlq4PwxX+zCMDQG4fCh
         M25A==
X-Gm-Message-State: APjAAAXgKWRqgs2004M9g0vwKP47xaKWirSQJlUiQLng2DrWFUL0GGWx
        Xw7K++FIf/7bT9qm00dlGucvU2jg4cECap6TEVgRKw==
X-Google-Smtp-Source: APXvYqwm4dF+ilypzwhJxCFpqR/YdSrKNU6TMcP6g6SaCODNwK+8KyS/sCAdDKibwHfpnUOEbNMevJmVhTKnZxhR+0Y=
X-Received: by 2002:adf:fcc8:: with SMTP id f8mr34845110wrs.250.1556724761543;
 Wed, 01 May 2019 08:32:41 -0700 (PDT)
MIME-Version: 1.0
References: <1555038815-31916-1-git-send-email-srinath.mannam@broadcom.com>
 <20190501113038.GA7961@e121166-lin.cambridge.arm.com> <20190501125530.GA15590@google.com>
 <119be78f-34f5-c19b-d41b-f7279e968b46@arm.com> <20190501135422.GA10726@e121166-lin.cambridge.arm.com>
In-Reply-To: <20190501135422.GA10726@e121166-lin.cambridge.arm.com>
From:   Srinath Mannam <srinath.mannam@broadcom.com>
Date:   Wed, 1 May 2019 21:02:30 +0530
Message-ID: <CABe79T7Oqs4KcX+m3EWXioDHAZ0xnRi+D0riPDDKWA4u1=nu+g@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] PCIe Host request to reserve IOVA
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
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

Hi Lorenzo,

Thanks a lot. Please see my reply below.

On Wed, May 1, 2019 at 7:24 PM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Wed, May 01, 2019 at 02:20:56PM +0100, Robin Murphy wrote:
> > On 2019-05-01 1:55 pm, Bjorn Helgaas wrote:
> > > On Wed, May 01, 2019 at 12:30:38PM +0100, Lorenzo Pieralisi wrote:
> > > > On Fri, Apr 12, 2019 at 08:43:32AM +0530, Srinath Mannam wrote:
> > > > > Few SOCs have limitation that their PCIe host can't allow few inbound
> > > > > address ranges. Allowed inbound address ranges are listed in dma-ranges
> > > > > DT property and this address ranges are required to do IOVA mapping.
> > > > > Remaining address ranges have to be reserved in IOVA mapping.
> > > > >
> > > > > PCIe Host driver of those SOCs has to list resource entries of allowed
> > > > > address ranges given in dma-ranges DT property in sorted order. This
> > > > > sorted list of resources will be processed and reserve IOVA address for
> > > > > inaccessible address holes while initializing IOMMU domain.
> > > > >
> > > > > This patch set is based on Linux-5.0-rc2.
> > > > >
> > > > > Changes from v3:
> > > > >    - Addressed Robin Murphy review comments.
> > > > >      - pcie-iproc: parse dma-ranges and make sorted resource list.
> > > > >      - dma-iommu: process list and reserve gaps between entries
> > > > >
> > > > > Changes from v2:
> > > > >    - Patch set rebased to Linux-5.0-rc2
> > > > >
> > > > > Changes from v1:
> > > > >    - Addressed Oza review comments.
> > > > >
> > > > > Srinath Mannam (3):
> > > > >    PCI: Add dma_ranges window list
> > > > >    iommu/dma: Reserve IOVA for PCIe inaccessible DMA address
> > > > >    PCI: iproc: Add sorted dma ranges resource entries to host bridge
> > > > >
> > > > >   drivers/iommu/dma-iommu.c           | 19 ++++++++++++++++
> > > > >   drivers/pci/controller/pcie-iproc.c | 44 ++++++++++++++++++++++++++++++++++++-
> > > > >   drivers/pci/probe.c                 |  3 +++
> > > > >   include/linux/pci.h                 |  1 +
> > > > >   4 files changed, 66 insertions(+), 1 deletion(-)
> > > >
> > > > Bjorn, Joerg,
> > > >
> > > > this series should not affect anything in the mainline other than its
> > > > consumer (ie patch 3); if that's the case should we consider it for v5.2
> > > > and if yes how are we going to merge it ?
> > >
> > > I acked the first one
> > >
> > > Robin reviewed the second
> > > (https://lore.kernel.org/lkml/e6c812d6-0cad-4cfd-defd-d7ec427a6538@arm.com)
> > > (though I do agree with his comment about DMA_BIT_MASK()), Joerg was OK
> > > with it if Robin was
> > > (https://lore.kernel.org/lkml/20190423145721.GH29810@8bytes.org).
> > >
> > > Eric reviewed the third (and pointed out a typo).
> > >
> > > My Kconfiggery never got fully answered -- it looks to me as though it's
> > > possible to build pcie-iproc without the DMA hole support, and I thought
> > > the whole point of this series was to deal with those holes
> > > (https://lore.kernel.org/lkml/20190418234241.GF126710@google.com).  I would
> > > have expected something like making pcie-iproc depend on IOMMU_SUPPORT.
> > > But Srinath didn't respond to that, so maybe it's not an issue and it
> > > should only affect pcie-iproc anyway.
> >
> > Hmm, I'm sure I had at least half-written a reply on that point, but I
> > can't seem to find it now... anyway, the gist is that these inbound
> > windows are generally set up to cover the physical address ranges of DRAM
> > and anything else that devices might need to DMA to. Thus if you're not
> > using an IOMMU, the fact that devices can't access the gaps in between
> > doesn't matter because there won't be anything there anyway; it only
> > needs mitigating if you do use an IOMMU and start giving arbitrary
> > non-physical addresses to the endpoint.
>
> So basically there is no strict IOMMU_SUPPORT dependency.
Yes, without IOMMU_SUPPORT, all inbound addresses will fall inside dma-ranges.
Issue is only in the case of IOMMU enable, this patch will address by
reserving non-allowed
address (holes of dma-ranges) by reserving them.
>
> > > So bottom line, I'm fine with merging it for v5.2.  Do you want to merge
> > > it, Lorenzo, or ...?
> >
> > This doesn't look like it will conflict with the other DMA ops and MSI
> > mapping changes currently in-flight for iommu-dma, so I have no
> > objection to it going through the PCI tree for 5.2.
>
> I will update the DMA_BIT_MASK() according to your review and fix the
> typo Eric pointed out and push out a branch - we shall see if we can
> include it for v5.2.
I will send new patches with the change DMA_BIT_MASK() and typo along
with Bjorn's comment in PATCH-1.

Regards,
Srinath.
>
> Thanks,
> Lorenzo
