Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60DC326BEA6
	for <lists+linux-pci@lfdr.de>; Wed, 16 Sep 2020 09:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbgIPH7y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Sep 2020 03:59:54 -0400
Received: from kernel.crashing.org ([76.164.61.194]:39618 "EHLO
        kernel.crashing.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbgIPH7x (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Sep 2020 03:59:53 -0400
Received: from localhost (gate.crashing.org [63.228.1.57])
        (authenticated bits=0)
        by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id 08G7xPbq020075
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 16 Sep 2020 02:59:29 -0500
Message-ID: <701012f288231d0d0733bf1c2c8fdbd9caa074fd.camel@kernel.crashing.org>
Subject: Re: [PATCH] arm64: Enable PCI write-combine resources under sysfs
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Clint Sbisa <csbisa@amazon.com>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <helgaas@kernel.org>,
        linux-arm-kernel@lists.infradead.org, will@kernel.org,
        catalin.marinas@arm.com, Leon Romanovsky <leon@kernel.org>
Date:   Wed, 16 Sep 2020 17:59:24 +1000
In-Reply-To: <20200915234006.GI1573713@nvidia.com>
References: <20200914141726.GA904879@nvidia.com>
         <20200914142406.k44zrnp2wdsandsp@amazon.com>
         <20200914143819.GC904879@nvidia.com>
         <375c478593945a416f3180c3773bcb5240d2e36c.camel@kernel.crashing.org>
         <1d6f2ceb8d3538c906a1fdb8cd3d4c74ccffa42e.camel@kernel.crashing.org>
         <20200914225740.GP904879@nvidia.com>
         <2b539df4c9ec703458e46da2fc879ee3b310b31c.camel@kernel.crashing.org>
         <20200915101831.GA2616@e121166-lin.cambridge.arm.com>
         <20200915110511.GQ904879@nvidia.com>
         <bcb95faafa72734478b942084a9d24a61ae9887f.camel@kernel.crashing.org>
         <20200915234006.GI1573713@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 2020-09-15 at 20:40 -0300, Jason Gunthorpe wrote:
> Not quite, upstream kernel will never use WC on those
> devices. DEVICE_GRE is not supported in upstream,
> arch_can_pci_mmap_wc() is always false and the WC tester will always
> fail.
> 
> > With the patch, those device will now use MT_DEVICE_NC.
> 
> Which doesn't do WC at all on some ARM implementations.

Lovely... this is arm64 btw, still the case ?

Also we could make this a variable rather than a constant and choose
a more appropriate set of flags at boot time....

> > Why would that be a regression ? 
> 
> Using the WC submission flow when it doesn't work costs something like
> 10% performance vs using the non-WC flow.

You mean the driver uses a different path to the HW which ahs that
overhead, not that MMIOs have that overhead right ?

> Like I said, the case where the driver can't self test probably
> doesn't intersect with the ARM implementations that can't do write
> combining, and if it did, the users probably run the out of tree
> driver that has the hacky stuff to make it use DEVICE_GRE.

Ok. So you are saying to go for it and ignore that Mellanox case then ?
:-)

> > BTW. Lorenzo, why don't we use MT_DEVICE_GRE for pgprot_writecombine ?
> > Its not supported on some chips ?
> 
> It has alignment requirements drivers don't meet. We need a new
> concept of "write combining and I promise to do aligned access"

Ah yes, I remember. Right, we would need to provide new/better
accessors for these kind of things. It's going to be a mess to find a
common set that works for all archs.

> > What on earth is pgprot_device() ? This is new ? On ARM it will be
> > MT_DEVICE_nGnRE, so it allows posted write. It seems to match what
> > ioremap does. Should then ioremap use it as well ?
> > 
> > But it's only ever used for PCI mmap. Why is it different from
> > pgprot_noncached() which disables posted writes (nE) ?
> > 
> > Because a whole lot of drivers will use pgprot_noncached() explicitly
> > in either mmap or vmap, with the expectation that it's somewhat the
> > same as what ioremap does...
> 
> *boggle*
> 
> Only sysfs uses pci_mmap_resource_range() any other driver exposing
> BAR pages, like VFIO dies not. Makes no sense at all it is different.
> 
> Delete the ill defined pgprot_device() ? Nobody has complained
> something is wrong with VFIO in the 6 years since it was added...

I was wondering what it was, that's it ... 

Cheers,
Ben.


