Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB4E126A306
	for <lists+linux-pci@lfdr.de>; Tue, 15 Sep 2020 12:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbgIOKSj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Sep 2020 06:18:39 -0400
Received: from foss.arm.com ([217.140.110.172]:59910 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbgIOKSi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 15 Sep 2020 06:18:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 35E4D1FB;
        Tue, 15 Sep 2020 03:18:37 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F37FC3F68F;
        Tue, 15 Sep 2020 03:18:35 -0700 (PDT)
Date:   Tue, 15 Sep 2020 11:18:31 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, Clint Sbisa <csbisa@amazon.com>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        linux-arm-kernel@lists.infradead.org, will@kernel.org,
        catalin.marinas@arm.com, Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH] arm64: Enable PCI write-combine resources under sysfs
Message-ID: <20200915101831.GA2616@e121166-lin.cambridge.arm.com>
References: <20200910232938.GJ904879@nvidia.com>
 <3110e00a1f4df7b7359ba4f2b7f86a35aa47405e.camel@kernel.crashing.org>
 <20200911214225.hml2wbbq2rofn4re@amazon.com>
 <20200914141726.GA904879@nvidia.com>
 <20200914142406.k44zrnp2wdsandsp@amazon.com>
 <20200914143819.GC904879@nvidia.com>
 <375c478593945a416f3180c3773bcb5240d2e36c.camel@kernel.crashing.org>
 <1d6f2ceb8d3538c906a1fdb8cd3d4c74ccffa42e.camel@kernel.crashing.org>
 <20200914225740.GP904879@nvidia.com>
 <2b539df4c9ec703458e46da2fc879ee3b310b31c.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b539df4c9ec703458e46da2fc879ee3b310b31c.camel@kernel.crashing.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 15, 2020 at 09:25:57AM +1000, Benjamin Herrenschmidt wrote:
> On Mon, 2020-09-14 at 19:57 -0300, Jason Gunthorpe wrote:
> > On Tue, Sep 15, 2020 at 08:00:27AM +1000, Benjamin Herrenschmidt wrote:
> > > On Tue, 2020-09-15 at 07:42 +1000, Benjamin Herrenschmidt wrote:
> > > > 
> > > > > which is back to my original question, how do you do DMA using
> > > > > /sys/xx/resources? Why not use VFIO like everything else?
> > > > 
> > > > Note: All this doesnt' change the fact that sys/xx/resources_wc
> > > > exists
> > > > for other archs and I see no reasons so far not to have it on ARM...
> > > 
> > > Also... it looks like VFIO also doesn't provide a way to do WC yet
> > > unfortunately :-(
> > 
> > Yes, but if the driving reason for this patch is because a VFIO user
> > like EFA DPDK is trying to work around VFIO limitations, then I'd say
> > the VFIO mmap should be amended, and not so much worring about sysfs.
> 
> I don't think the two are exclusive.
> 
> > While there is no reason for ARM to not show the sysfs, it really
> > should never be used. Modern kernels in secure boot don't even show
> > it, for instance.
> 
> It's useful for random things, I've used it quite a bit in a previous
> life for things like in-lab hw testing etc...  There's tooling out
> there, esp. in the more 'embedded' side of thing that uses this, I
> don't see a good reason not to provide the same level of functionality.
> 
> So Lorenzo, imho, we should merge the patch.

To sum it up:

(1) RDMA drivers need a new mapping function/attribute to define their
    message push model. Actually the message model is not necessarily related
    to write combining a la x86, so we should probably come up with a better
    and consistent naming. Enabling this patchset may trigger performance
    regressions on mellanox drivers on arm64 - this ought to be addressed.
(2) User-space/passthrough drivers rely on VFIO for BAR mappings. Since
    it looks relevant, WC message model semantics should be introduced
    there, somehow.
(3) Given the above, the sysfs interface can be enabled. I still don't
    see the advantages (other than saying it is there for other arches, ie
    what can you really do with the sysfs mappings - see Jason's VFIO/DMA
    query) but we can do it. Still, I am not happy about the possible
    mellanox regressions - that should be tested/verified before this
    patch is merged IMHO. Do we really need it for v5.10 ?

Thoughts ?

Lorenzo

> As for fixing VFIO, definitely something to revive. The main contention
> point was which "interface" to use to request write combine.
> 
> Let's restart that conversation with the appropriate folks, the last I
> remember, the question was to figure out what interface to provide
> userspace for the functionality.
> 
> Clint, do you want to drive this as well ?
> 
> Cheers,
> Ben.
> 
