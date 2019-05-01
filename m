Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A192109F6
	for <lists+linux-pci@lfdr.de>; Wed,  1 May 2019 17:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfEAPXN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 May 2019 11:23:13 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34552 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726700AbfEAPXM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 May 2019 11:23:12 -0400
Received: by mail-wm1-f65.google.com with SMTP id b67so4641715wmg.1
        for <linux-pci@vger.kernel.org>; Wed, 01 May 2019 08:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C2dDHqb44ARX3Yztd2XOkkIcS57EqAJiduKSA+40hqY=;
        b=B4H7Slgo13GVtTdhXOvblWdA307ca2M2Vc9PW/+6I7Zb/SHqGJQat3r7KGswaHwLas
         +eCx2KBktEsNdXzKYy7NfvvWYZm4BrloOVMeFW3udHFlHW6v6brccesj/0F5QUCmin9Z
         0po7SPRn1hOGjc0I3RN2zIgYDn/2Y8OJDjwFU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C2dDHqb44ARX3Yztd2XOkkIcS57EqAJiduKSA+40hqY=;
        b=U/WG3lqcK3Q0KHDBjWfPonM91BIWoxpag3W5SERfKyvW2r6/oV5tVP4FTwrqT1CtgG
         ugdvGz3rmwMech5jswkPLQuciuSgQlwQH+k38FTt5z4aLVjefphoFRw6VT6iumFLnbSR
         wcs4HXTNA52oqNY+xLkzP6pXuuOpLz8i3L5HUMqi7YYU/YSn6la1eTiFN+bZQq0Sc6Al
         N1ntcOt8cTrQsL1U15tMqXlltXkZXcMnBQIRZuGCieI3BA5PQrWZ4kCmliFyhA+xxFS7
         0KdWO4oPTNYZ3XZXEwZbVs1Iyvq814fzVyGjwQGatI8l+L/KYp+xtWSrBJBIFARBa1u8
         /QGA==
X-Gm-Message-State: APjAAAVdjzaCQ/xng41bZz14fW1QtuKbR0BgKccPuV5ckdi5g0AHXGfJ
        9zNRSPu8EBq88lHuTgMEah/CypUvQ+AYwbrnwTJ4SQ==
X-Google-Smtp-Source: APXvYqyobNQXTfJQ0szO4X40p9tWtHXtsWsksB9cI2BnsZ+fws67LQdUFK01DCztjM7BkmaLesBSpswNH3CLX+lXMIQ=
X-Received: by 2002:a1c:a843:: with SMTP id r64mr4785280wme.45.1556724190405;
 Wed, 01 May 2019 08:23:10 -0700 (PDT)
MIME-Version: 1.0
References: <1555038815-31916-1-git-send-email-srinath.mannam@broadcom.com>
 <20190501113038.GA7961@e121166-lin.cambridge.arm.com> <20190501125530.GA15590@google.com>
In-Reply-To: <20190501125530.GA15590@google.com>
From:   Srinath Mannam <srinath.mannam@broadcom.com>
Date:   Wed, 1 May 2019 20:52:58 +0530
Message-ID: <CABe79T5w4hb572KHUhyrwAN7+Xxnz2jF9OGLpfTmAdHuLuO2Fw@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] PCIe Host request to reserve IOVA
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>, poza@codeaurora.org,
        Ray Jui <rjui@broadcom.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

Thank you. Please find my reply below.

On Wed, May 1, 2019 at 6:25 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Wed, May 01, 2019 at 12:30:38PM +0100, Lorenzo Pieralisi wrote:
> > On Fri, Apr 12, 2019 at 08:43:32AM +0530, Srinath Mannam wrote:
> > > Few SOCs have limitation that their PCIe host can't allow few inbound
> > > address ranges. Allowed inbound address ranges are listed in dma-ranges
> > > DT property and this address ranges are required to do IOVA mapping.
> > > Remaining address ranges have to be reserved in IOVA mapping.
> > >
> > > PCIe Host driver of those SOCs has to list resource entries of allowed
> > > address ranges given in dma-ranges DT property in sorted order. This
> > > sorted list of resources will be processed and reserve IOVA address for
> > > inaccessible address holes while initializing IOMMU domain.
> > >
> > > This patch set is based on Linux-5.0-rc2.
> > >
> > > Changes from v3:
> > >   - Addressed Robin Murphy review comments.
> > >     - pcie-iproc: parse dma-ranges and make sorted resource list.
> > >     - dma-iommu: process list and reserve gaps between entries
> > >
> > > Changes from v2:
> > >   - Patch set rebased to Linux-5.0-rc2
> > >
> > > Changes from v1:
> > >   - Addressed Oza review comments.
> > >
> > > Srinath Mannam (3):
> > >   PCI: Add dma_ranges window list
> > >   iommu/dma: Reserve IOVA for PCIe inaccessible DMA address
> > >   PCI: iproc: Add sorted dma ranges resource entries to host bridge
> > >
> > >  drivers/iommu/dma-iommu.c           | 19 ++++++++++++++++
> > >  drivers/pci/controller/pcie-iproc.c | 44 ++++++++++++++++++++++++++++++++++++-
> > >  drivers/pci/probe.c                 |  3 +++
> > >  include/linux/pci.h                 |  1 +
> > >  4 files changed, 66 insertions(+), 1 deletion(-)
> >
> > Bjorn, Joerg,
> >
> > this series should not affect anything in the mainline other than its
> > consumer (ie patch 3); if that's the case should we consider it for v5.2
> > and if yes how are we going to merge it ?
>
> I acked the first one
I will send new patch with change in commit message as per your comment.
"s/bridge This list/bridge, this list/"

>
> Robin reviewed the second
> (https://lore.kernel.org/lkml/e6c812d6-0cad-4cfd-defd-d7ec427a6538@arm.com)
> (though I do agree with his comment about DMA_BIT_MASK()), Joerg was OK
> with it if Robin was
> (https://lore.kernel.org/lkml/20190423145721.GH29810@8bytes.org).
>
I will send patch, for "DMA_BIT_MASK(sizeof(dma_addr_t) *
BITS_PER_BYTE)" change to "~(dma_addr_t)0".
> Eric reviewed the third (and pointed out a typo).
I will send a new patch to address this typo.
>
> My Kconfiggery never got fully answered -- it looks to me as though it's
> possible to build pcie-iproc without the DMA hole support, and I thought
> the whole point of this series was to deal with those holes
> (https://lore.kernel.org/lkml/20190418234241.GF126710@google.com).  I would
> have expected something like making pcie-iproc depend on IOMMU_SUPPORT.
> But Srinath didn't respond to that, so maybe it's not an issue and it
> should only affect pcie-iproc anyway.
I am sorry to miss to respond..
In NO-IOMMU case, All inbound addresses allocated from dma APIs are
physical addresses of DDR.
All DDR physical addresses are fall inside given dma-ranges. so that,
without IOMMU_SUPPORT, will not
be any issue.

Regards,
Srinath.
>
> So bottom line, I'm fine with merging it for v5.2.  Do you want to merge
> it, Lorenzo, or ...?
>
> Bjorn
