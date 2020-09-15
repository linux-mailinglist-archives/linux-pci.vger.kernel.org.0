Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E95926B322
	for <lists+linux-pci@lfdr.de>; Wed, 16 Sep 2020 01:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbgIOXA6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Sep 2020 19:00:58 -0400
Received: from kernel.crashing.org ([76.164.61.194]:38850 "EHLO
        kernel.crashing.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727081AbgIOXAs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Sep 2020 19:00:48 -0400
Received: from localhost (gate.crashing.org [63.228.1.57])
        (authenticated bits=0)
        by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id 08FN0AAr012347
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 15 Sep 2020 18:00:14 -0500
Message-ID: <28c9039eba4bc288abb8ab1b82b51c16023fcb3c.camel@kernel.crashing.org>
Subject: Re: [PATCH] arm64: Enable PCI write-combine resources under sysfs
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, Clint Sbisa <csbisa@amazon.com>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        linux-arm-kernel@lists.infradead.org, will@kernel.org,
        catalin.marinas@arm.com, Leon Romanovsky <leon@kernel.org>
Date:   Wed, 16 Sep 2020 09:00:09 +1000
In-Reply-To: <20200915101831.GA2616@e121166-lin.cambridge.arm.com>
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
         <20200915101831.GA2616@e121166-lin.cambridge.arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 2020-09-15 at 11:18 +0100, Lorenzo Pieralisi wrote:
> > It's useful for random things, I've used it quite a bit in a previous
> > life for things like in-lab hw testing etc...  There's tooling out
> > there, esp. in the more 'embedded' side of thing that uses this, I
> > don't see a good reason not to provide the same level of functionality.
> > 
> > So Lorenzo, imho, we should merge the patch.
> 
> To sum it up:
> 
> (1) RDMA drivers need a new mapping function/attribute to define their
>     message push model. Actually the message model is not necessarily related
>     to write combining a la x86, so we should probably come up with a better
>     and consistent naming. Enabling this patchset may trigger performance
>     regressions on mellanox drivers on arm64 - this ought to be addressed.

I doubt it. Besides Mellanox will probably enable WC already through
the other code path (the use of this accessor is only one of the path
that enables the driver to do WC).

I don't think we need to solve the RDMA semantics issue that urgently
TBH, and it's definitely an orthogonal issue to that at hand.

> (2) User-space/passthrough drivers rely on VFIO for BAR mappings. Since
>     it looks relevant, WC message model semantics should be introduced
>     there, somehow.

Yes.

> (3) Given the above, the sysfs interface can be enabled. I still don't
>     see the advantages (other than saying it is there for other arches, ie
>     what can you really do with the sysfs mappings - see Jason's VFIO/DMA
>     query) but we can do it. Still, I am not happy about the possible
>     mellanox regressions - that should be tested/verified before this
>     patch is merged IMHO. Do we really need it for v5.10 ?

I don't think there's a significant risk of regression, but then I also
dont' have a way to test :-)

Cheers,
Ben.


