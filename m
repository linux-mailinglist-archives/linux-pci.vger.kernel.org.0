Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38E6826CCA9
	for <lists+linux-pci@lfdr.de>; Wed, 16 Sep 2020 22:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgIPUr4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Sep 2020 16:47:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:55916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726697AbgIPRBR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 16 Sep 2020 13:01:17 -0400
Received: from gaia (unknown [46.69.195.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2BD39223EA;
        Wed, 16 Sep 2020 17:01:02 +0000 (UTC)
Date:   Wed, 16 Sep 2020 18:00:59 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Clint Sbisa <csbisa@amazon.com>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <helgaas@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH] arm64: Enable PCI write-combine resources under sysfs
Message-ID: <20200916170058.GD3122@gaia>
References: <1d6f2ceb8d3538c906a1fdb8cd3d4c74ccffa42e.camel@kernel.crashing.org>
 <20200914225740.GP904879@nvidia.com>
 <2b539df4c9ec703458e46da2fc879ee3b310b31c.camel@kernel.crashing.org>
 <20200915101831.GA2616@e121166-lin.cambridge.arm.com>
 <20200915110511.GQ904879@nvidia.com>
 <bcb95faafa72734478b942084a9d24a61ae9887f.camel@kernel.crashing.org>
 <20200915234006.GI1573713@nvidia.com>
 <20200916083315.GC27496@willie-the-truck>
 <20200916084851.GA3122@gaia>
 <20200916141502.GB20770@e121166-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916141502.GB20770@e121166-lin.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 16, 2020 at 03:15:02PM +0100, Lorenzo Pieralisi wrote:
> On Wed, Sep 16, 2020 at 09:48:52AM +0100, Catalin Marinas wrote:
> > On Wed, Sep 16, 2020 at 09:33:16AM +0100, Will Deacon wrote:
> > > On Tue, Sep 15, 2020 at 08:40:06PM -0300, Jason Gunthorpe wrote:
> > > > On Wed, Sep 16, 2020 at 09:17:38AM +1000, Benjamin Herrenschmidt wrote:
> > > > > With the patch, those device will now use MT_DEVICE_NC.
> > > > 
> > > > Which doesn't do WC at all on some ARM implementations.
> > > 
> > > Is that just TX2? I remember that thing being weird where GRE performed
> > > better than NC, but I thought that was a one off (and the thing is dead).
> > 
> > I recall something along these lines. Hopefully ARM updated the guidance
> > to licensees.
> > 
> > > NC is more permissive than GRE, so I think that's the right one to use; i.e.
> > > we go for the fewest number of restrictions on the hardware. If somebody
> > > screws up the uarch, that's up to them.
> > 
> > I agree, Normal NC is better as long as the BAR can tolerate read
> > side-effects.
> 
> That we don't know but if a prefetchable BAR can't tolerate read
> side effects this would be already a problem on eg x86 - that's
> the best we can hope for given the current PCI specs.
> 
> +1 on normal NC. The only open point is whether we should make
> arch_can_pci_mmap_wc() return false on platforms like TX2.

I lost track in this thread whether it matters. TX2 would need Device
GRE for optimal performance but the kernel doesn't currently provide it
anyway. We could expose a new memory type, aligned_wc ;).

-- 
Catalin
