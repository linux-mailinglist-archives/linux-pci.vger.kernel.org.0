Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3611B26561C
	for <lists+linux-pci@lfdr.de>; Fri, 11 Sep 2020 02:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725290AbgIKAjs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Sep 2020 20:39:48 -0400
Received: from kernel.crashing.org ([76.164.61.194]:33210 "EHLO
        kernel.crashing.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725280AbgIKAjs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Sep 2020 20:39:48 -0400
Received: from localhost (gate.crashing.org [63.228.1.57])
        (authenticated bits=0)
        by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id 08B0dHsf000993
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 10 Sep 2020 19:39:21 -0500
Message-ID: <3110e00a1f4df7b7359ba4f2b7f86a35aa47405e.camel@kernel.crashing.org>
Subject: Re: [PATCH] arm64: Enable PCI write-combine resources under sysfs
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Clint Sbisa <csbisa@amazon.com>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <helgaas@kernel.org>,
        linux-arm-kernel@lists.infradead.org, will@kernel.org,
        catalin.marinas@arm.com, Leon Romanovsky <leon@kernel.org>
Date:   Fri, 11 Sep 2020 10:39:16 +1000
In-Reply-To: <20200910232938.GJ904879@nvidia.com>
References: <20200902142922.xc4x6m33unkzewuh@amazon.com>
         <20200902164702.GA30611@e121166-lin.cambridge.arm.com>
         <edae1eeb0da578d941cfa5ad550eb0a0eda5f98e.camel@kernel.crashing.org>
         <20200903110844.GB11284@e121166-lin.cambridge.arm.com>
         <28d333afc73bd854390f8c39691a735040ba5b39.camel@kernel.crashing.org>
         <20200910094600.GA22840@e121166-lin.cambridge.arm.com>
         <20200910123758.GC904879@nvidia.com>
         <20200910151721.GA25809@e121166-lin.cambridge.arm.com>
         <20200910171033.GG904879@nvidia.com>
         <44acc22377958a57c738f5139c5b5df2841c2544.camel@kernel.crashing.org>
         <20200910232938.GJ904879@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 2020-09-10 at 20:29 -0300, Jason Gunthorpe wrote:
> > Probably, at least on powerpc you will as well, that's the only way to
> > get write combine.
> 
> If I remove the PROT_READ in the user space mmap will it block it?

No. powerpc at least doesn't have write-only mappings.

> Read TLPs are not harmful but I suspect they would cause an
> undesirable random performance anomaly.

I suspect in practice you wont get them esp. if the code has barriers
but ... it's allowed by the architecture.

> > > Does it/could it "combine writes"?
> > 
> > I assume so for ARM, definitely for powerpc.
> 
> Various IBM PPC chips I know work, we do test that.
> 
> > > > That's why I looped you in - that's what worries me about
> > > > "enabling"
> > > > arch_can_pci_mmap_wc() on arm64. If we enable it and we have perf
> > > > regressions that's not OK.
> > > > 
> > > > Or we *can* enable arch_can_pci_mmap_wc() but force the mellanox
> > > > driver (or more broadly all drivers following this message push
> > > > semantics) to use "something else" for WC detection.
> > > 
> > > arch_can_pci_mmap_wc() really only controls the sysfs resource file
> > > and it seems very unclear who in userspace uses that these days.
> > 
> > dpdk under some circumstances afaik.
> 
> And something gross for DMA then? Not sure dpdk is useful without
> DMA. Why not use CONFIG_VFIO_NOIOMMU for such a non-secure thing?

Clint, can you elaborate on the use case ?

> > > vfio is now the right way to do that stuff. I don't see an obvious
> > > way to get WC memory in VFIO though...
> > 
> > Which would be a performance issue on a number of things I suppose...
> 
> Almost nothing uses pci_iomap_wc(), so I'd be surpried if userspace
> DPDK was an important user when an in-kernel driver for the same HW
> doesn't use it?

Hard to know how uses those files out there but I don't like arm not
providing what pretty much all relevant archs do provide since the
semantics afaik aren't that different.

Yes, "write combine" isn't a good name.... The goal is to get WC but it
comes with the whole package on several archs. We don't even have a
reasonnable definition of the semantics of readl/writel on a WC mapping
(hint: on powerpc the barriers in them will prevent WC even on a WC
mapping) nor of what barriers might work  and how on such a mapping.

I tried a while ago and ... ugh.

Cheers,
Ben.

