Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C13C26BF5E
	for <lists+linux-pci@lfdr.de>; Wed, 16 Sep 2020 10:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbgIPIdW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Sep 2020 04:33:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:35888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725840AbgIPIdV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 16 Sep 2020 04:33:21 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 11A12206DC;
        Wed, 16 Sep 2020 08:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600245200;
        bh=hZD6Zy7WdDq71T8XLF+vpP+BlqkstySbFXt4pCl8CIU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RyMJhFWOsymi1JLqBzFr0sWwBETAFEFcwU6V6gU/zpoU9wx0iiDJwKRta9VIj/Ly6
         HC1uECiMfvQ/om/DldYAJbAUgHzg3C8Zz6bAt4dP8oPHkblcshPd2QCqt40TJiNXip
         HHlH17B2Gax3zyMo+/SVJjD9cmSVT9f+8VrGICJA=
Date:   Wed, 16 Sep 2020 09:33:16 +0100
From:   Will Deacon <will@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Clint Sbisa <csbisa@amazon.com>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <helgaas@kernel.org>,
        linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH] arm64: Enable PCI write-combine resources under sysfs
Message-ID: <20200916083315.GC27496@willie-the-truck>
References: <20200914142406.k44zrnp2wdsandsp@amazon.com>
 <20200914143819.GC904879@nvidia.com>
 <375c478593945a416f3180c3773bcb5240d2e36c.camel@kernel.crashing.org>
 <1d6f2ceb8d3538c906a1fdb8cd3d4c74ccffa42e.camel@kernel.crashing.org>
 <20200914225740.GP904879@nvidia.com>
 <2b539df4c9ec703458e46da2fc879ee3b310b31c.camel@kernel.crashing.org>
 <20200915101831.GA2616@e121166-lin.cambridge.arm.com>
 <20200915110511.GQ904879@nvidia.com>
 <bcb95faafa72734478b942084a9d24a61ae9887f.camel@kernel.crashing.org>
 <20200915234006.GI1573713@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915234006.GI1573713@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 15, 2020 at 08:40:06PM -0300, Jason Gunthorpe wrote:
> On Wed, Sep 16, 2020 at 09:17:38AM +1000, Benjamin Herrenschmidt wrote:
> > On Tue, 2020-09-15 at 08:05 -0300, Jason Gunthorpe wrote:
> > > > To sum it up:
> > > > 
> > > > (1) RDMA drivers need a new mapping function/attribute to define their
> > > >      message push model. Actually the message model is not necessarily related
> > > >      to write combining a la x86, so we should probably come up with a better
> > > >      and consistent naming. Enabling this patchset may trigger performance
> > > >      regressions on mellanox drivers on arm64 - this ought to be
> > > >      addressed.
> > > 
> > > It is pretty clear now that the certain ARM chips that don't do write
> > > combining with pgprot_writecombine will performance regress if they
> > > are running a certain uncommon Mellanox configuration. I suspect these
> > > deployments are all running the out of tree patch for DEVICE_GRE
> > > though.
> > 
> > I'm not sure I understand...
> > 
> > Today those ARM chips will not use pgprot_writecombine (at least not
> > using that code path, they might still use it as the result of the
> > other path in the driver that can enable it). 
> 
> Not quite, upstream kernel will never use WC on those
> devices. DEVICE_GRE is not supported in upstream,
> arch_can_pci_mmap_wc() is always false and the WC tester will always
> fail.
> 
> > With the patch, those device will now use MT_DEVICE_NC.
> 
> Which doesn't do WC at all on some ARM implementations.

Is that just TX2? I remember that thing being weird where GRE performed
better than NC, but I thought that was a one off (and the thing is dead).

NC is more permissive than GRE, so I think that's the right one to use; i.e.
we go for the fewest number of restrictions on the hardware. If somebody
screws up the uarch, that's up to them.

Will
