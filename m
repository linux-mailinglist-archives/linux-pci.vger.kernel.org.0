Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7A0D26D904
	for <lists+linux-pci@lfdr.de>; Thu, 17 Sep 2020 12:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgIQK23 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Sep 2020 06:28:29 -0400
Received: from foss.arm.com ([217.140.110.172]:44154 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726410AbgIQK22 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 17 Sep 2020 06:28:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4AC9812FC;
        Thu, 17 Sep 2020 03:28:26 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 15F243F68F;
        Thu, 17 Sep 2020 03:28:24 -0700 (PDT)
Date:   Thu, 17 Sep 2020 11:28:19 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, Clint Sbisa <csbisa@amazon.com>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        linux-arm-kernel@lists.infradead.org, will@kernel.org,
        catalin.marinas@arm.com, Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH] arm64: Enable PCI write-combine resources under sysfs
Message-ID: <20200917102819.GA2284@e121166-lin.cambridge.arm.com>
References: <1d6f2ceb8d3538c906a1fdb8cd3d4c74ccffa42e.camel@kernel.crashing.org>
 <20200914225740.GP904879@nvidia.com>
 <2b539df4c9ec703458e46da2fc879ee3b310b31c.camel@kernel.crashing.org>
 <20200915101831.GA2616@e121166-lin.cambridge.arm.com>
 <20200915110511.GQ904879@nvidia.com>
 <bcb95faafa72734478b942084a9d24a61ae9887f.camel@kernel.crashing.org>
 <20200915234006.GI1573713@nvidia.com>
 <701012f288231d0d0733bf1c2c8fdbd9caa074fd.camel@kernel.crashing.org>
 <20200916121226.GN1573713@nvidia.com>
 <28082ccc715a9fba349ae6052d5c917ae02d40fa.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28082ccc715a9fba349ae6052d5c917ae02d40fa.camel@kernel.crashing.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 17, 2020 at 09:59:28AM +1000, Benjamin Herrenschmidt wrote:
> On Wed, 2020-09-16 at 09:12 -0300, Jason Gunthorpe wrote:
> > > Also we could make this a variable rather than a constant and
> > > choose
> > > a more appropriate set of flags at boot time....
> > 
> > It is a function, so it could check the CPU ID for the known broken
> > devices and block them.
> 
> Sure, I meant in the abstract way. It's not a hot path so it doesnt
> have to be a static key.
> 
> > > > > Why would that be a regression ? 
> > > > 
> > > > Using the WC submission flow when it doesn't work costs something
> > > > like
> > > > 10% performance vs using the non-WC flow.
> > > 
> > > You mean the driver uses a different path to the HW which ahs that
> > > overhead, not that MMIOs have that overhead right ?
> > 
> > The different path has overhead of doing extra useless MMIOs because
> > they don't combine
> 
> I see. This might have to end up being a TX2 specific hack until the
> end of times...

True - hopefully on platforms that implement normal NC the architectural
way will not trigger user space performance regressions.

Unfortunately if we merge this patch we _do_ know from this thread
that userspace will suffer from a perf regression on TX2.

Either we ignore it or we write some code to prevent it
(ie first step make arch_can_pci_mmap_wc() return 0 on TX2 -
possibly using the arm64 errata detection mechanism).

Adding a new IO mapping API and use it in IB drivers won't solve the TX2
problem - since we still prefer normal NC over device GRE for "WC"
mappings and we would have to "downgrade" TX2 somehow.

Lorenzo
