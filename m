Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FFC526B42A
	for <lists+linux-pci@lfdr.de>; Wed, 16 Sep 2020 01:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbgIOXSc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Sep 2020 19:18:32 -0400
Received: from kernel.crashing.org ([76.164.61.194]:38916 "EHLO
        kernel.crashing.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727298AbgIOXSO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Sep 2020 19:18:14 -0400
Received: from localhost (gate.crashing.org [63.228.1.57])
        (authenticated bits=0)
        by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id 08FNHd9O012611
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 15 Sep 2020 18:17:42 -0500
Message-ID: <bcb95faafa72734478b942084a9d24a61ae9887f.camel@kernel.crashing.org>
Subject: Re: [PATCH] arm64: Enable PCI write-combine resources under sysfs
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Clint Sbisa <csbisa@amazon.com>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <helgaas@kernel.org>,
        linux-arm-kernel@lists.infradead.org, will@kernel.org,
        catalin.marinas@arm.com, Leon Romanovsky <leon@kernel.org>
Date:   Wed, 16 Sep 2020 09:17:38 +1000
In-Reply-To: <20200915110511.GQ904879@nvidia.com>
References: <3110e00a1f4df7b7359ba4f2b7f86a35aa47405e.camel@kernel.crashing.org>
         <20200911214225.hml2wbbq2rofn4re@amazon.com>
         <20200914141726.GA904879@nvidia.com>
         <20200914142406.k44zrnp2wdsandsp@amazon.com>
         <20200914143819.GC904879@nvidia.com>
         <375c478593945a416f3180c3773bcb5240d2e36c.camel@kernel.crashing.org>
         <1d6f2ceb8d3538c906a1fdb8cd3d4c74ccffa42e.camel@kernel.crashing.org>
         <20200914225740.GP904879@nvidia.com>
         <2b539df4c9ec703458e46da2fc879ee3b310b31c.camel@kernel.crashing.org>
         <20200915101831.GA2616@e121166-lin.cambridge.arm.com>
         <20200915110511.GQ904879@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 2020-09-15 at 08:05 -0300, Jason Gunthorpe wrote:
> > To sum it up:
> > 
> > (1) RDMA drivers need a new mapping function/attribute to define their
> >      message push model. Actually the message model is not necessarily related
> >      to write combining a la x86, so we should probably come up with a better
> >      and consistent naming. Enabling this patchset may trigger performance
> >      regressions on mellanox drivers on arm64 - this ought to be
> >      addressed.
> 
> It is pretty clear now that the certain ARM chips that don't do write
> combining with pgprot_writecombine will performance regress if they
> are running a certain uncommon Mellanox configuration. I suspect these
> deployments are all running the out of tree patch for DEVICE_GRE
> though.

I'm not sure I understand...

Today those ARM chips will not use pgprot_writecombine (at least not
using that code path, they might still use it as the result of the
other path in the driver that can enable it). So they get
MT_DEVICE_nGnRnE (unless I missed something here).

So they will not combine.

With the patch, those device will now use MT_DEVICE_NC.

Why would that be a regression ? It will allow speculation, that
doesn't necessarily mean that the CPU will cause spurrious accesses, it
probably won't in most case... And it should allow combining, no ?

BTW. Lorenzo, why don't we use MT_DEVICE_GRE for pgprot_writecombine ?
Its not supported on some chips ?

Not that this lead me to discover annother weird thing ...

What on earth is pgprot_device() ? This is new ? On ARM it will be
MT_DEVICE_nGnRE, so it allows posted write. It seems to match what
ioremap does. Should then ioremap use it as well ?

But it's only ever used for PCI mmap. Why is it different from
pgprot_noncached() which disables posted writes (nE) ?

Because a whole lot of drivers will use pgprot_noncached() explicitly
in either mmap or vmap, with the expectation that it's somewhat the
same as what ioremap does...

Cheers,
Ben.


