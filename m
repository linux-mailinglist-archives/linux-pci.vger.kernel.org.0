Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A97825B70C
	for <lists+linux-pci@lfdr.de>; Thu,  3 Sep 2020 01:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbgIBXD6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Sep 2020 19:03:58 -0400
Received: from kernel.crashing.org ([76.164.61.194]:53468 "EHLO
        kernel.crashing.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbgIBXD5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Sep 2020 19:03:57 -0400
Received: from localhost (gate.crashing.org [63.228.1.57])
        (authenticated bits=0)
        by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id 082N3Xne005427
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 2 Sep 2020 18:03:37 -0500
Message-ID: <1fa18cf358eb6570f919c2b03c193e856c72705b.camel@kernel.crashing.org>
Subject: Re: [PATCH] arm64: Enable PCI write-combine resources under sysfs
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Clint Sbisa <csbisa@amazon.com>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <helgaas@kernel.org>,
        linux-arm-kernel@lists.infradead.org, will@kernel.org
Date:   Thu, 03 Sep 2020 09:03:32 +1000
In-Reply-To: <20200902175445.GA31706@e121166-lin.cambridge.arm.com>
References: <20200831151827.pumm2p54fyj7fz5s@amazon.com>
         <20200902113207.GA27676@e121166-lin.cambridge.arm.com>
         <20200902142922.xc4x6m33unkzewuh@amazon.com>
         <20200902164702.GA30611@e121166-lin.cambridge.arm.com>
         <20200902172156.GD16673@gaia>
         <20200902175445.GA31706@e121166-lin.cambridge.arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 2020-09-02 at 18:54 +0100, Lorenzo Pieralisi wrote:
> > > > If that driver is fixed to check what it actually wants to check, would that
> > > > address your concern about the blanket enable? I don't see any other references
> > > > to this in kernel drivers and I think the documentation at
> > > > `filesystems/sysfs-pci.rst` outlines it pretty explicitly:
> > > > 
> > > >    Platforms which support write-combining maps of PCI resources must define
> > > >    arch_can_pci_mmap_wc() which shall evaluate to non-zero at runtime when
> > > >    write-combining is permitted.
> > > 
> > > That's exactly the problem. I am asking you: what does "write-combining
> > > maps of PCI resources" mean ?
> > > 
> > > I understand we do want weak ordering for prefetchable BAR mappings
> > > but my worry is that by exposing the resources as WC to user space
> > > we are giving user space the impression that those mappings mirror
> > > x86 WC mappings behaviour that is not true on ARM64.
> > 
> > Would Device_GRE be close to the x86 WC better? It won't allow unaligned
> > accesses and that can be problematic for the user. OTOH, it doesn't
> > speculate reads, so it's safer from the hardware perspective.
> 
> Thanks Catalin for chiming in, it may yes but I need to figure out
> the precise semantics of WC on x86 first.

We never got to the bottom of that with powerpc... semantics of "WC"
are subtly different all over the archs. They key idea I think is for
us to state that a WC mapping drops all ordering guarantees :-)

That said, the goal here is to expose the sysfs _wc files, without
which, mapping of "no-side-effect" memory such as frame buffers etc...
produces something very very slow.

> Actually *if* I read x86 specs correctly WC mappings allow speculative
> reads, which then would shift the issue on the PCI specs that allow
> marking read side effects BARs as prefetchable;

Yes.

>  in other words if
> an endpoint is designed with a prefetchable BAR that has read side
> effects this is already an issue on x86 in the current kernel.

An powerpc. We remove the "G" bit. Same deal.

> There is that, plus the usage of arch_can_pci_mmap_wc() in mellanox
> drivers which I suspect it is yet another interpretation of x86 write
> combine - I don't know what happens if we let arch_can_pci_mmap_wc() == 1
> on both normalNC or deviceGRE mappings for pgprot_writecombine.
> 
> I think it is worth getting to the bottom of this before applying
> this patch.

I think it basically boils down to mapping things without side effect
and ordering guarantees but that still cannot be cached.

Cheers,
Ben.


