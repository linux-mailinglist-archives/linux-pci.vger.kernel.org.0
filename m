Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CBDA26B3E8
	for <lists+linux-pci@lfdr.de>; Wed, 16 Sep 2020 01:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727465AbgIOXMZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Sep 2020 19:12:25 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:61030 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727139AbgIOXMU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Sep 2020 19:12:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1600211540; x=1631747540;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/cVEHufwAE8Pz5l6vDgyGmqUjuh+y4B65zCp+5zWJdA=;
  b=D06KEDCVdwmMJ6DI3TGkQWQMS/7iyMAHLtwsO+yzs0bAJMa7HMUJzAIv
   REEftxGzQ0oQlRAlGHBegQqypbvs20l9OU/Bc+Sa07L7Wyke7CiGpl+cX
   lmovlLB2udP2F7qSPjGK8w1Djhgjq6RTW3/XMu+btIz0tRguy02iBjiuj
   I=;
X-IronPort-AV: E=Sophos;i="5.76,430,1592870400"; 
   d="scan'208";a="76467983"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1d-5dd976cd.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 15 Sep 2020 23:12:16 +0000
Received: from EX13MTAUEE001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-1d-5dd976cd.us-east-1.amazon.com (Postfix) with ESMTPS id 49F02A21FC;
        Tue, 15 Sep 2020 23:12:15 +0000 (UTC)
Received: from EX13D33UEE002.ant.amazon.com (10.43.62.233) by
 EX13MTAUEE001.ant.amazon.com (10.43.62.226) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 15 Sep 2020 23:12:14 +0000
Received: from EX13MTAUEE002.ant.amazon.com (10.43.62.24) by
 EX13D33UEE002.ant.amazon.com (10.43.62.233) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 15 Sep 2020 23:12:14 +0000
Received: from dev-dsk-csbisa-2a-37939146.us-west-2.amazon.com (172.19.34.216)
 by mail-relay.amazon.com (10.43.62.224) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Tue, 15 Sep 2020 23:12:14 +0000
Received: by dev-dsk-csbisa-2a-37939146.us-west-2.amazon.com (Postfix, from userid 800212)
        id 44DF4258; Tue, 15 Sep 2020 23:12:13 +0000 (UTC)
Date:   Tue, 15 Sep 2020 23:12:13 +0000
From:   Clint Sbisa <csbisa@amazon.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jason Gunthorpe <jgg@nvidia.com>, <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <will@kernel.org>,
        <catalin.marinas@arm.com>, Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH] arm64: Enable PCI write-combine resources under sysfs
Message-ID: <20200915231213.7bjywegoccohpcop@amazon.com>
References: <20200911214225.hml2wbbq2rofn4re@amazon.com>
 <20200914141726.GA904879@nvidia.com>
 <20200914142406.k44zrnp2wdsandsp@amazon.com>
 <20200914143819.GC904879@nvidia.com>
 <375c478593945a416f3180c3773bcb5240d2e36c.camel@kernel.crashing.org>
 <1d6f2ceb8d3538c906a1fdb8cd3d4c74ccffa42e.camel@kernel.crashing.org>
 <20200914225740.GP904879@nvidia.com>
 <2b539df4c9ec703458e46da2fc879ee3b310b31c.camel@kernel.crashing.org>
 <20200915101831.GA2616@e121166-lin.cambridge.arm.com>
 <28c9039eba4bc288abb8ab1b82b51c16023fcb3c.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <28c9039eba4bc288abb8ab1b82b51c16023fcb3c.camel@kernel.crashing.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 16, 2020 at 09:00:09AM +1000, Benjamin Herrenschmidt wrote:
> On Tue, 2020-09-15 at 11:18 +0100, Lorenzo Pieralisi wrote:
> > To sum it up:
> >
> > (1) RDMA drivers need a new mapping function/attribute to define their
> >     message push model. Actually the message model is not necessarily related
> >     to write combining a la x86, so we should probably come up with a better
> >     and consistent naming. Enabling this patchset may trigger performance
> >     regressions on mellanox drivers on arm64 - this ought to be addressed.
> 
> I doubt it. Besides Mellanox will probably enable WC already through
> the other code path (the use of this accessor is only one of the path
> that enables the driver to do WC).
> 
> I don't think we need to solve the RDMA semantics issue that urgently
> TBH, and it's definitely an orthogonal issue to that at hand.
> 
> > (2) User-space/passthrough drivers rely on VFIO for BAR mappings. Since
> >     it looks relevant, WC message model semantics should be introduced
> >     there, somehow.
> 
> Yes.

I will ping some folks on the VFIO patch to see if we can get the ball rolling
there again.

> 
> > (3) Given the above, the sysfs interface can be enabled. I still don't
> >     see the advantages (other than saying it is there for other arches, ie
> >     what can you really do with the sysfs mappings - see Jason's VFIO/DMA
> >     query) but we can do it. Still, I am not happy about the possible
> >     mellanox regressions - that should be tested/verified before this
> >     patch is merged IMHO. Do we really need it for v5.10 ?
> 
> I don't think there's a significant risk of regression, but then I also
> dont' have a way to test :-)

I'm going to re-submit this patch to Catalin and Will with an updated commit
message capturing the context from this discussion (and cc everyone involved).

As for the whole device GRE / new naming context-- I'll have to defer to
Lorenzo on suggested next steps on this front.

Thanks,
Clint
