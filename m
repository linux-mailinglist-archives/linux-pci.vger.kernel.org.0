Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C93442642B0
	for <lists+linux-pci@lfdr.de>; Thu, 10 Sep 2020 11:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbgIJJqK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Sep 2020 05:46:10 -0400
Received: from foss.arm.com ([217.140.110.172]:59430 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728443AbgIJJqH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 10 Sep 2020 05:46:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 03F48101E;
        Thu, 10 Sep 2020 02:46:07 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C2AF93F68F;
        Thu, 10 Sep 2020 02:46:05 -0700 (PDT)
Date:   Thu, 10 Sep 2020 10:46:00 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>, jgg@nvidia.com
Cc:     Clint Sbisa <csbisa@amazon.com>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <helgaas@kernel.org>,
        linux-arm-kernel@lists.infradead.org, will@kernel.org,
        catalin.marinas@arm.com, Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH] arm64: Enable PCI write-combine resources under sysfs
Message-ID: <20200910094600.GA22840@e121166-lin.cambridge.arm.com>
References: <20200831151827.pumm2p54fyj7fz5s@amazon.com>
 <20200902113207.GA27676@e121166-lin.cambridge.arm.com>
 <20200902142922.xc4x6m33unkzewuh@amazon.com>
 <20200902164702.GA30611@e121166-lin.cambridge.arm.com>
 <edae1eeb0da578d941cfa5ad550eb0a0eda5f98e.camel@kernel.crashing.org>
 <20200903110844.GB11284@e121166-lin.cambridge.arm.com>
 <28d333afc73bd854390f8c39691a735040ba5b39.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28d333afc73bd854390f8c39691a735040ba5b39.camel@kernel.crashing.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+Jason]

On Tue, Sep 08, 2020 at 09:33:42AM +1000, Benjamin Herrenschmidt wrote:
> On Thu, 2020-09-03 at 12:08 +0100, Lorenzo Pieralisi wrote:
> > > It's been what other architectures have been doing for mroe than a
> > > decade without significant issues... I don't think you should worry
> > > too
> > > much about this.
> > 
> > Minus what I wrote above, I agree with you. I'd still be able to
> > understand what this patch changes in the mellanox driver HW
> > handling though - not sure what they expect from
> > arch_can_pci_mmap_wc()
> > returning 1.
> 
> I don't know enough to get into the finer details but looking a bit it
> seems when this is set, they allow extra ioctls to create buffers
> mapped with pgprot_writecombine().
> 
> I suppose this means faster MMIO backet buffers for small packets (ie,
> non-DMA use case).
> 
> Also note that mlx5_ib_test_wc() only uses arch_can_pci_mmap_wc() for a
> non-ROCE ethernet port on a PF... For anyting else, it just seems to
> actually try to do it and see what happens :-)
> 
> Leon: Can you clarify the use of arch_can_pci_mmap_wc() in mlx5 and
> whether you see an issue with enabling this on arm64 ?

Hi Jason,

I was wondering if you could help us with this question, we are trying
to understand what enabling arch_can_pci_mmap_wc() on arm64 would cause
in mellanox drivers wrt mappings and whether there is an expected
behaviour behind them, in particular whether there is an implicit
reliance on x86 write-combine arch/interconnect details.

Thanks,
Lorenzo
