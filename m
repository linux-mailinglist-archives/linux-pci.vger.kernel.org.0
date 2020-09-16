Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1641C26CCDA
	for <lists+linux-pci@lfdr.de>; Wed, 16 Sep 2020 22:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgIPUuP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Sep 2020 16:50:15 -0400
Received: from foss.arm.com ([217.140.110.172]:33976 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726552AbgIPQ4A (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 16 Sep 2020 12:56:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2B8E91509;
        Wed, 16 Sep 2020 07:15:06 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E951A3F68F;
        Wed, 16 Sep 2020 07:15:04 -0700 (PDT)
Date:   Wed, 16 Sep 2020 15:15:02 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Clint Sbisa <csbisa@amazon.com>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <helgaas@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH] arm64: Enable PCI write-combine resources under sysfs
Message-ID: <20200916141502.GB20770@e121166-lin.cambridge.arm.com>
References: <375c478593945a416f3180c3773bcb5240d2e36c.camel@kernel.crashing.org>
 <1d6f2ceb8d3538c906a1fdb8cd3d4c74ccffa42e.camel@kernel.crashing.org>
 <20200914225740.GP904879@nvidia.com>
 <2b539df4c9ec703458e46da2fc879ee3b310b31c.camel@kernel.crashing.org>
 <20200915101831.GA2616@e121166-lin.cambridge.arm.com>
 <20200915110511.GQ904879@nvidia.com>
 <bcb95faafa72734478b942084a9d24a61ae9887f.camel@kernel.crashing.org>
 <20200915234006.GI1573713@nvidia.com>
 <20200916083315.GC27496@willie-the-truck>
 <20200916084851.GA3122@gaia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916084851.GA3122@gaia>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 16, 2020 at 09:48:52AM +0100, Catalin Marinas wrote:
> On Wed, Sep 16, 2020 at 09:33:16AM +0100, Will Deacon wrote:
> > On Tue, Sep 15, 2020 at 08:40:06PM -0300, Jason Gunthorpe wrote:
> > > On Wed, Sep 16, 2020 at 09:17:38AM +1000, Benjamin Herrenschmidt wrote:
> > > > On Tue, 2020-09-15 at 08:05 -0300, Jason Gunthorpe wrote:
> > > > > > To sum it up:
> > > > > > 
> > > > > > (1) RDMA drivers need a new mapping function/attribute to define their
> > > > > >      message push model. Actually the message model is not necessarily related
> > > > > >      to write combining a la x86, so we should probably come up with a better
> > > > > >      and consistent naming. Enabling this patchset may trigger performance
> > > > > >      regressions on mellanox drivers on arm64 - this ought to be
> > > > > >      addressed.
> > > > > 
> > > > > It is pretty clear now that the certain ARM chips that don't do write
> > > > > combining with pgprot_writecombine will performance regress if they
> > > > > are running a certain uncommon Mellanox configuration. I suspect these
> > > > > deployments are all running the out of tree patch for DEVICE_GRE
> > > > > though.
> > > > 
> > > > I'm not sure I understand...
> > > > 
> > > > Today those ARM chips will not use pgprot_writecombine (at least not
> > > > using that code path, they might still use it as the result of the
> > > > other path in the driver that can enable it). 
> > > 
> > > Not quite, upstream kernel will never use WC on those
> > > devices. DEVICE_GRE is not supported in upstream,
> > > arch_can_pci_mmap_wc() is always false and the WC tester will always
> > > fail.
> > > 
> > > > With the patch, those device will now use MT_DEVICE_NC.
> > > 
> > > Which doesn't do WC at all on some ARM implementations.
> > 
> > Is that just TX2? I remember that thing being weird where GRE performed
> > better than NC, but I thought that was a one off (and the thing is dead).
> 
> I recall something along these lines. Hopefully ARM updated the guidance
> to licensees.
> 
> > NC is more permissive than GRE, so I think that's the right one to use; i.e.
> > we go for the fewest number of restrictions on the hardware. If somebody
> > screws up the uarch, that's up to them.
> 
> I agree, Normal NC is better as long as the BAR can tolerate read
> side-effects.

That we don't know but if a prefetchable BAR can't tolerate read
side effects this would be already a problem on eg x86 - that's
the best we can hope for given the current PCI specs.

+1 on normal NC. The only open point is whether we should make
arch_can_pci_mmap_wc() return false on platforms like TX2.

Thanks,
Lorenzo
