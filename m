Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0BD325C2DD
	for <lists+linux-pci@lfdr.de>; Thu,  3 Sep 2020 16:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729299AbgICOiL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Sep 2020 10:38:11 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:23067 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729276AbgICOgP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Sep 2020 10:36:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1599143774; x=1630679774;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8yBGan8tgMpccZ4nTZypCZpwCtDtVD3XMtqoNCEo9E4=;
  b=eyGpTByj9ItSu3hho0hy4qHp7aZEoGWUR95DkdPZVZ9EfK/U5BahLYv1
   U3FS9gHsmF86Lcn1oti+vQajZ5uULMQCgRaHtI/srUQQ4VzbkdKOeTdoW
   JY5FRGqAUbROHnnbW2mrafHMg4yzaa7UbMeef2fZX0oE2wvZblE2utZiE
   0=;
X-IronPort-AV: E=Sophos;i="5.76,387,1592870400"; 
   d="scan'208";a="53246111"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-27fb8269.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 03 Sep 2020 14:36:13 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1e-27fb8269.us-east-1.amazon.com (Postfix) with ESMTPS id AB8C2A21B4;
        Thu,  3 Sep 2020 14:36:10 +0000 (UTC)
Received: from EX13D07UWA003.ant.amazon.com (10.43.160.35) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.58) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 3 Sep 2020 14:36:09 +0000
Received: from EX13MTAUWA001.ant.amazon.com (10.43.160.58) by
 EX13D07UWA003.ant.amazon.com (10.43.160.35) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 3 Sep 2020 14:36:09 +0000
Received: from dev-dsk-csbisa-2a-37939146.us-west-2.amazon.com (172.19.34.216)
 by mail-relay.amazon.com (10.43.160.118) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Thu, 3 Sep 2020 14:36:09 +0000
Received: by dev-dsk-csbisa-2a-37939146.us-west-2.amazon.com (Postfix, from userid 800212)
        id B5DBA1AD; Thu,  3 Sep 2020 14:36:09 +0000 (UTC)
Date:   Thu, 3 Sep 2020 14:36:09 +0000
From:   Clint Sbisa <csbisa@amazon.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        Guy Levy <guyle@mellanox.com>
CC:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <will@kernel.org>,
        <catalin.marinas@arm.com>
Subject: Re: [PATCH] arm64: Enable PCI write-combine resources under sysfs
Message-ID: <20200903143609.didfh6jwt7etm7he@amazon.com>
References: <20200831151827.pumm2p54fyj7fz5s@amazon.com>
 <20200902113207.GA27676@e121166-lin.cambridge.arm.com>
 <20200902142922.xc4x6m33unkzewuh@amazon.com>
 <20200902164702.GA30611@e121166-lin.cambridge.arm.com>
 <edae1eeb0da578d941cfa5ad550eb0a0eda5f98e.camel@kernel.crashing.org>
 <20200903110844.GB11284@e121166-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200903110844.GB11284@e121166-lin.cambridge.arm.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Adding some Mellanox folks to comment on their usage of arch_can_pci_mmap_wc().

On Thu, Sep 03, 2020 at 12:08:44PM +0100, Lorenzo Pieralisi wrote:
> On Thu, Sep 03, 2020 at 09:07:00AM +1000, Benjamin Herrenschmidt wrote:
> > On Wed, 2020-09-02 at 17:47 +0100, Lorenzo Pieralisi wrote:
> > > Yes I do and I expressed them.
> > >
> > > The first concern is the WC ambiguity on non-x86 systems, it looks
> > > like write combinining means everything and nothing at the same time
> > > on != x86 arches.
> > >
> > > On x86 prefetchable BAR == WC mapping (still conditional on arch
> > > features ie PAT, not a blanket enable). On ARM64 WC mapping currently
> > > corresponds to normal NC memory and the PCIe specs allow read
> > > side-effects BAR to be marked as prefetchable, I need to force PCI
> > > sig
> > > to remove the section I mentioned from the specifications because
> > > there
> > > is NO way it can be detected if a prefetchable BAR maps to read
> > > side-effects memory.
> >
> > Im not sure I understand your sentence. It's been a long accepted rule
> > in PCI land that "prefetchable" BARs means "no side effects" and in
> > fact allows much more than just prefetching :-)
> 
> I am referring to the nefarious:
> 
> "Additional Guidance on the Prefetchable Bit in Memory Space BARs"
> 
> I read it 100 times and I still have no idea how it can be implemented,
> it sorts of acknowledges that read side-effects memory can be marked
> as a prefetchable BAR *if* the system meets some criteria.
> 
> As if endpoint designers knew the system where their endpoint is
> plugged into (+ bit (3) in a BAR is read-only).
> 
> I think that that implementation note must be removed from the
> specifications - if anyone dares to follow it this whole
> WC resource mapping can trigger trouble.
> 
> Good news is that it would be trouble for all arches :)
> 
> > > A kernel device driver would (hopefully) know, sysfs code that just
> > > checks the prefetchable attribute and exports resource_WC does not.
> > >
> > > As I mentioned, if the mapping is done in a device specific driver it
> > > can be vetted and there are not many drivers mapping BARs as
> > > ioremap_wc().
> >
> > It's been what other architectures have been doing for mroe than a
> > decade without significant issues... I don't think you should worry too
> > much about this.
> 
> Minus what I wrote above, I agree with you. I'd still be able to
> understand what this patch changes in the mellanox driver HW
> handling though - not sure what they expect from arch_can_pci_mmap_wc()
> returning 1.

This seems to have been added broadly for x86, PPC, and ARM as part of initial
WC support in the driver (37aa5c36 "IB/mlx5: Add UARs write-combining and
non-cached mapping"). It was updated to use `arch_can_pci_mmap_wc()` later
(1f3db161 "IB/mlx5: Generally use the WC auto detection test result").

Guy, Yishai, there are some concerns about difference the technical definition
of WC and how WC is actually used. Can you comment on the usage of WC in mlx5
and which definition of WC the driver utilizes? We're unsure if a blanket
enable for arm64 is safe in light of the driver's use of this function.

Thanks,
Clint

> 
> Thanks,
> Lorenzo
