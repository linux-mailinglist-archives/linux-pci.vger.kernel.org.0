Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33DDF2699A3
	for <lists+linux-pci@lfdr.de>; Tue, 15 Sep 2020 01:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725997AbgINX0c (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Sep 2020 19:26:32 -0400
Received: from kernel.crashing.org ([76.164.61.194]:36784 "EHLO
        kernel.crashing.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbgINX0b (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Sep 2020 19:26:31 -0400
Received: from localhost (gate.crashing.org [63.228.1.57])
        (authenticated bits=0)
        by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id 08ENPwuf006195
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 14 Sep 2020 18:26:01 -0500
Message-ID: <2b539df4c9ec703458e46da2fc879ee3b310b31c.camel@kernel.crashing.org>
Subject: Re: [PATCH] arm64: Enable PCI write-combine resources under sysfs
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Clint Sbisa <csbisa@amazon.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        linux-arm-kernel@lists.infradead.org, will@kernel.org,
        catalin.marinas@arm.com, Leon Romanovsky <leon@kernel.org>
Date:   Tue, 15 Sep 2020 09:25:57 +1000
In-Reply-To: <20200914225740.GP904879@nvidia.com>
References: <20200910171033.GG904879@nvidia.com>
         <44acc22377958a57c738f5139c5b5df2841c2544.camel@kernel.crashing.org>
         <20200910232938.GJ904879@nvidia.com>
         <3110e00a1f4df7b7359ba4f2b7f86a35aa47405e.camel@kernel.crashing.org>
         <20200911214225.hml2wbbq2rofn4re@amazon.com>
         <20200914141726.GA904879@nvidia.com>
         <20200914142406.k44zrnp2wdsandsp@amazon.com>
         <20200914143819.GC904879@nvidia.com>
         <375c478593945a416f3180c3773bcb5240d2e36c.camel@kernel.crashing.org>
         <1d6f2ceb8d3538c906a1fdb8cd3d4c74ccffa42e.camel@kernel.crashing.org>
         <20200914225740.GP904879@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 2020-09-14 at 19:57 -0300, Jason Gunthorpe wrote:
> On Tue, Sep 15, 2020 at 08:00:27AM +1000, Benjamin Herrenschmidt wrote:
> > On Tue, 2020-09-15 at 07:42 +1000, Benjamin Herrenschmidt wrote:
> > > 
> > > > which is back to my original question, how do you do DMA using
> > > > /sys/xx/resources? Why not use VFIO like everything else?
> > > 
> > > Note: All this doesnt' change the fact that sys/xx/resources_wc
> > > exists
> > > for other archs and I see no reasons so far not to have it on ARM...
> > 
> > Also... it looks like VFIO also doesn't provide a way to do WC yet
> > unfortunately :-(
> 
> Yes, but if the driving reason for this patch is because a VFIO user
> like EFA DPDK is trying to work around VFIO limitations, then I'd say
> the VFIO mmap should be amended, and not so much worring about sysfs.

I don't think the two are exclusive.

> While there is no reason for ARM to not show the sysfs, it really
> should never be used. Modern kernels in secure boot don't even show
> it, for instance.

It's useful for random things, I've used it quite a bit in a previous
life for things like in-lab hw testing etc...  There's tooling out
there, esp. in the more 'embedded' side of thing that uses this, I
don't see a good reason not to provide the same level of functionality.

So Lorenzo, imho, we should merge the patch.

As for fixing VFIO, definitely something to revive. The main contention
point was which "interface" to use to request write combine.

Let's restart that conversation with the appropriate folks, the last I
remember, the question was to figure out what interface to provide
userspace for the functionality.

Clint, do you want to drive this as well ?

Cheers,
Ben.

