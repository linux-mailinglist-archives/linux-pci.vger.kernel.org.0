Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 576642654B0
	for <lists+linux-pci@lfdr.de>; Fri, 11 Sep 2020 00:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725562AbgIJWA2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Sep 2020 18:00:28 -0400
Received: from kernel.crashing.org ([76.164.61.194]:33120 "EHLO
        kernel.crashing.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbgIJWAZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Sep 2020 18:00:25 -0400
Received: from localhost (gate.crashing.org [63.228.1.57])
        (authenticated bits=0)
        by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id 08ALknRT031996
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 10 Sep 2020 16:46:53 -0500
Message-ID: <44acc22377958a57c738f5139c5b5df2841c2544.camel@kernel.crashing.org>
Subject: Re: [PATCH] arm64: Enable PCI write-combine resources under sysfs
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Clint Sbisa <csbisa@amazon.com>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <helgaas@kernel.org>,
        linux-arm-kernel@lists.infradead.org, will@kernel.org,
        catalin.marinas@arm.com, Leon Romanovsky <leon@kernel.org>
Date:   Fri, 11 Sep 2020 07:46:47 +1000
In-Reply-To: <20200910171033.GG904879@nvidia.com>
References: <20200831151827.pumm2p54fyj7fz5s@amazon.com>
         <20200902113207.GA27676@e121166-lin.cambridge.arm.com>
         <20200902142922.xc4x6m33unkzewuh@amazon.com>
         <20200902164702.GA30611@e121166-lin.cambridge.arm.com>
         <edae1eeb0da578d941cfa5ad550eb0a0eda5f98e.camel@kernel.crashing.org>
         <20200903110844.GB11284@e121166-lin.cambridge.arm.com>
         <28d333afc73bd854390f8c39691a735040ba5b39.camel@kernel.crashing.org>
         <20200910094600.GA22840@e121166-lin.cambridge.arm.com>
         <20200910123758.GC904879@nvidia.com>
         <20200910151721.GA25809@e121166-lin.cambridge.arm.com>
         <20200910171033.GG904879@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 2020-09-10 at 14:10 -0300, Jason Gunthorpe wrote:
> Can you explain what this actually does on ARM? 
> 
> Can it ever speculate loads across page boundaries, or speculate
> loads
> that never exist in the program? ie will we get random unpredicable
> MemRds?

Probably, at least on powerpc you will as well, that's the only way to
get write combine.

> Does it/could it "combine writes"?

I assume so for ARM, definitely for powerpc.

> > > If the CPU fails to generate a 64 byte TLP then the device will
> > > still
> > > operate correctly but does a different, slower, flow.
> > 
> > Side note: on ARM that TLP is not a native interconnect
> > transaction,
> > reworded, it depends on what the system-bus->PCI logic does in
> > this respect.
> 
> I think the issue is that ARM never defined what the bits set by
> pgprot_writecombine() do at a system level so we see implementations
> that do not cause write combining at the PCI-E interface for those
> bits. (I assume from what I've heard)

Nobody did. I think only x86 has a real "write combine" attribute. I
tried to untangled that mess years ago and didnt' get to the bottom of
it, but basically, on non-x86 archs, pgprot_writecombine will give you
what you asked ... and more.

> > That's why I looped you in - that's what worries me about
> > "enabling"
> > arch_can_pci_mmap_wc() on arm64. If we enable it and we have perf
> > regressions that's not OK.
> > 
> > Or we *can* enable arch_can_pci_mmap_wc() but force the mellanox
> > driver (or more broadly all drivers following this message push
> > semantics) to use "something else" for WC detection.
> 
> arch_can_pci_mmap_wc() really only controls the sysfs resource file
> and it seems very unclear who in userspace uses that these days.

dpdk under some circumstances afaik.

> vfio is now the right way to do that stuff. I don't see an obvious
> way to get WC memory in VFIO though...

Which would be a performance issue on a number of things I suppose...

Cheers,
Ben.


