Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D06213A8CB
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2020 12:56:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728959AbgANL4S (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Jan 2020 06:56:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:59540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728826AbgANL4S (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 14 Jan 2020 06:56:18 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A2B6424672;
        Tue, 14 Jan 2020 11:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579002977;
        bh=ahbXe4hwMQQLlrN5u66UYJDrMHT3NIY/p5dKKof/mlc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OZd5ICnclBnHLWVfm9YUQb5LWnL7oJhvwxZkC88/Qfz/xVf7KUgZ8/ayoCIO7ZVY4
         kzZacU3EMKl9p71FFs2ixfivPi6PsnxWs/K7aKsLkECRQmsPqQyhhtdDdv7bv1Inov
         /MVYLw34ynCIxhIjPlRlKlOz7eRnPqLnOObYNQdM=
Date:   Tue, 14 Jan 2020 11:56:11 +0000
From:   Will Deacon <will@kernel.org>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        iommu@lists.linux-foundation.org, joro@8bytes.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, guohanjun@huawei.com,
        sudeep.holla@arm.com, rjw@rjwysocki.net, lenb@kernel.org,
        robin.murphy@arm.com, bhelgaas@google.com, eric.auger@redhat.com,
        jonathan.cameron@huawei.com, zhangfei.gao@linaro.org
Subject: Re: [PATCH v4 06/13] iommu/arm-smmu-v3: Add context descriptor
 tables allocators
Message-ID: <20200114115611.GB29222@willie-the-truck>
References: <20191219163033.2608177-1-jean-philippe@linaro.org>
 <20191219163033.2608177-7-jean-philippe@linaro.org>
 <20200114110651.GA29222@willie-the-truck>
 <20200114115230.GA1799@myrica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200114115230.GA1799@myrica>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 14, 2020 at 12:52:30PM +0100, Jean-Philippe Brucker wrote:
> On Tue, Jan 14, 2020 at 11:06:52AM +0000, Will Deacon wrote:
> > >  /* Context descriptor manipulation functions */
> > > +static int arm_smmu_alloc_cd_leaf_table(struct arm_smmu_device *smmu,
> > > +					struct arm_smmu_cd_table *table,
> > > +					size_t num_entries)
> > > +{
> > > +	size_t size = num_entries * (CTXDESC_CD_DWORDS << 3);
> > > +
> > > +	table->ptr = dmam_alloc_coherent(smmu->dev, size, &table->ptr_dma,
> > > +					 GFP_KERNEL);
> > > +	if (!table->ptr) {
> > > +		dev_warn(smmu->dev,
> > > +			 "failed to allocate context descriptor table\n");
> > > +		return -ENOMEM;
> > > +	}
> > > +	return 0;
> > > +}
> > > +
> > > +static void arm_smmu_free_cd_leaf_table(struct arm_smmu_device *smmu,
> > > +					struct arm_smmu_cd_table *table,
> > > +					size_t num_entries)
> > > +{
> > > +	size_t size = num_entries * (CTXDESC_CD_DWORDS << 3);
> > > +
> > > +	dmam_free_coherent(smmu->dev, size, table->ptr, table->ptr_dma);
> > > +}
> > 
> > I think we'd be better off taking the 'arm_smmu_s1_cfg' as a parameter here
> > instead of the table pointer and a num_entries value, since the code above
> > implies that we support partial freeing of the context descriptors.
> > 
> > I can do that as a follow-up patch if you agree. Thoughts?
> 
> Do you mean only changing the arguments of arm_smmu_free_cd_leaf_table(),
> or arm_smmu_alloc_cd_leaf_table() as well? For free() I agree, for alloc()
> I'm not sure it would look better.

Yeah, just for free(). I'll spin something on top after I've finished
reviewing the series.

> For my tests I have a debug patch that allocates PASIDs randomly which
> quickly consumes DMA for leaf tables. So I do have to free the leaves
> individually when they aren't used, but it will be easy for me to update.

Cool.

Will
