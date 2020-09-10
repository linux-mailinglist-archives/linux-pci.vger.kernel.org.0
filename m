Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 045B926452C
	for <lists+linux-pci@lfdr.de>; Thu, 10 Sep 2020 13:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730649AbgIJLKV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Sep 2020 07:10:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:47368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730469AbgIJKyY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 10 Sep 2020 06:54:24 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AEB5820872;
        Thu, 10 Sep 2020 10:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599735263;
        bh=B49DuGNOigMrDqW7bKVyAZLBmxoG0fJF+8dh7POpkWc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ybqq+kR+57x8buVBMHY+SZDNgtFiP6kk+LkLLE2kCUEj9IO5PlLoPSS5g6vtRzurX
         bwwKjMvZPhlZ4pj8KZHauSZ1cYsMgzo22lWd8NKHj3P3BxrdEu1a45zWH+3JL0bdoH
         axjJEWhiA1Zom7Mx1exJ3fUVqaygRZRIYKabrXjQ=
Date:   Thu, 10 Sep 2020 13:54:19 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>, jgg@nvidia.com,
        Clint Sbisa <csbisa@amazon.com>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <helgaas@kernel.org>,
        linux-arm-kernel@lists.infradead.org, will@kernel.org,
        catalin.marinas@arm.com
Subject: Re: [PATCH] arm64: Enable PCI write-combine resources under sysfs
Message-ID: <20200910105419.GH421756@unreal>
References: <20200831151827.pumm2p54fyj7fz5s@amazon.com>
 <20200902113207.GA27676@e121166-lin.cambridge.arm.com>
 <20200902142922.xc4x6m33unkzewuh@amazon.com>
 <20200902164702.GA30611@e121166-lin.cambridge.arm.com>
 <edae1eeb0da578d941cfa5ad550eb0a0eda5f98e.camel@kernel.crashing.org>
 <20200903110844.GB11284@e121166-lin.cambridge.arm.com>
 <28d333afc73bd854390f8c39691a735040ba5b39.camel@kernel.crashing.org>
 <20200910094600.GA22840@e121166-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200910094600.GA22840@e121166-lin.cambridge.arm.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 10, 2020 at 10:46:00AM +0100, Lorenzo Pieralisi wrote:
> [+Jason]
>
> On Tue, Sep 08, 2020 at 09:33:42AM +1000, Benjamin Herrenschmidt wrote:
> > On Thu, 2020-09-03 at 12:08 +0100, Lorenzo Pieralisi wrote:
> > > > It's been what other architectures have been doing for mroe than a
> > > > decade without significant issues... I don't think you should worry
> > > > too
> > > > much about this.
> > >
> > > Minus what I wrote above, I agree with you. I'd still be able to
> > > understand what this patch changes in the mellanox driver HW
> > > handling though - not sure what they expect from
> > > arch_can_pci_mmap_wc()
> > > returning 1.
> >
> > I don't know enough to get into the finer details but looking a bit it
> > seems when this is set, they allow extra ioctls to create buffers
> > mapped with pgprot_writecombine().
> >
> > I suppose this means faster MMIO backet buffers for small packets (ie,
> > non-DMA use case).
> >
> > Also note that mlx5_ib_test_wc() only uses arch_can_pci_mmap_wc() for a
> > non-ROCE ethernet port on a PF... For anyting else, it just seems to
> > actually try to do it and see what happens :-)
> >
> > Leon: Can you clarify the use of arch_can_pci_mmap_wc() in mlx5 and
> > whether you see an issue with enabling this on arm64 ?
>
> Hi Jason,
>
> I was wondering if you could help us with this question, we are trying
> to understand what enabling arch_can_pci_mmap_wc() on arm64 would cause
> in mellanox drivers wrt mappings and whether there is an expected
> behaviour behind them, in particular whether there is an implicit
> reliance on x86 write-combine arch/interconnect details.

Sorry, somehow I missed this email.

The arch_can_pci_mmap_wc() used in IB representors, special mode where
we can't perform write-combine test below.

The commit 1f3db161881b ("IB/mlx5: Generally use the WC auto detection test result")
describes it.

I don't see any problem with enabling arch_can_pci_mmap_wc() on ARM.

Thanks

>
> Thanks,
> Lorenzo
