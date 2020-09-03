Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5368025C010
	for <lists+linux-pci@lfdr.de>; Thu,  3 Sep 2020 13:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbgICLVo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Sep 2020 07:21:44 -0400
Received: from foss.arm.com ([217.140.110.172]:59190 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728412AbgICLPg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 Sep 2020 07:15:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0F1AE101E;
        Thu,  3 Sep 2020 04:08:48 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0F5013F66F;
        Thu,  3 Sep 2020 04:08:46 -0700 (PDT)
Date:   Thu, 3 Sep 2020 12:08:44 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Clint Sbisa <csbisa@amazon.com>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <helgaas@kernel.org>,
        linux-arm-kernel@lists.infradead.org, will@kernel.org,
        catalin.marinas@arm.com
Subject: Re: [PATCH] arm64: Enable PCI write-combine resources under sysfs
Message-ID: <20200903110844.GB11284@e121166-lin.cambridge.arm.com>
References: <20200831151827.pumm2p54fyj7fz5s@amazon.com>
 <20200902113207.GA27676@e121166-lin.cambridge.arm.com>
 <20200902142922.xc4x6m33unkzewuh@amazon.com>
 <20200902164702.GA30611@e121166-lin.cambridge.arm.com>
 <edae1eeb0da578d941cfa5ad550eb0a0eda5f98e.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <edae1eeb0da578d941cfa5ad550eb0a0eda5f98e.camel@kernel.crashing.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 03, 2020 at 09:07:00AM +1000, Benjamin Herrenschmidt wrote:
> On Wed, 2020-09-02 at 17:47 +0100, Lorenzo Pieralisi wrote:
> > Yes I do and I expressed them.
> > 
> > The first concern is the WC ambiguity on non-x86 systems, it looks
> > like write combinining means everything and nothing at the same time
> > on != x86 arches.
> > 
> > On x86 prefetchable BAR == WC mapping (still conditional on arch
> > features ie PAT, not a blanket enable). On ARM64 WC mapping currently
> > corresponds to normal NC memory and the PCIe specs allow read
> > side-effects BAR to be marked as prefetchable, I need to force PCI
> > sig
> > to remove the section I mentioned from the specifications because
> > there
> > is NO way it can be detected if a prefetchable BAR maps to read
> > side-effects memory.
> 
> Im not sure I understand your sentence. It's been a long accepted rule
> in PCI land that "prefetchable" BARs means "no side effects" and in
> fact allows much more than just prefetching :-)

I am referring to the nefarious:

"Additional Guidance on the Prefetchable Bit in Memory Space BARs"

I read it 100 times and I still have no idea how it can be implemented,
it sorts of acknowledges that read side-effects memory can be marked
as a prefetchable BAR *if* the system meets some criteria.

As if endpoint designers knew the system where their endpoint is
plugged into (+ bit (3) in a BAR is read-only).

I think that that implementation note must be removed from the
specifications - if anyone dares to follow it this whole
WC resource mapping can trigger trouble.

Good news is that it would be trouble for all arches :)

> > A kernel device driver would (hopefully) know, sysfs code that just
> > checks the prefetchable attribute and exports resource_WC does not.
> >
> > As I mentioned, if the mapping is done in a device specific driver it
> > can be vetted and there are not many drivers mapping BARs as
> > ioremap_wc().
> 
> It's been what other architectures have been doing for mroe than a
> decade without significant issues... I don't think you should worry too
> much about this.

Minus what I wrote above, I agree with you. I'd still be able to
understand what this patch changes in the mellanox driver HW
handling though - not sure what they expect from arch_can_pci_mmap_wc()
returning 1.

Thanks,
Lorenzo
