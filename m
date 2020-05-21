Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6A31DCF54
	for <lists+linux-pci@lfdr.de>; Thu, 21 May 2020 16:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729493AbgEUOQ7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 May 2020 10:16:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:35184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727909AbgEUOQ7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 21 May 2020 10:16:59 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC33920721;
        Thu, 21 May 2020 14:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590070618;
        bh=YEpYYTkp5Epc3I02PSQwVAAWySjqR5HmPWamm+n+yqk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=emfD5+Td4JkWFa9nx6iu3NhZWqXHy0Cul4uBIz9eMW1m5pPlTHa3MQ1L5tweReNSI
         +nzqkI81I9u0yvHl2QuuuCSWQWBHWnNeJWjSyn9PN2T9MFAPEf2DHjH906FGfDBG7N
         BL2C2n3EL7yfzDXZBJ3cF8uo2pvDC11Gd/AuJzgo=
Date:   Thu, 21 May 2020 15:16:52 +0100
From:   Will Deacon <will@kernel.org>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, joro@8bytes.org, catalin.marinas@arm.com,
        robin.murphy@arm.com, kevin.tian@intel.com,
        baolu.lu@linux.intel.com, Jonathan.Cameron@huawei.com,
        jacob.jun.pan@linux.intel.com, christian.koenig@amd.com,
        felix.kuehling@amd.com, zhangfei.gao@linaro.org, jgg@ziepe.ca,
        xuzaibo@huawei.com, fenghua.yu@intel.com, hch@infradead.org
Subject: Re: [PATCH v7 12/24] iommu/arm-smmu-v3: Add support for VHE
Message-ID: <20200521141652.GG6608@willie-the-truck>
References: <20200519175502.2504091-1-jean-philippe@linaro.org>
 <20200519175502.2504091-13-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519175502.2504091-13-jean-philippe@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 19, 2020 at 07:54:50PM +0200, Jean-Philippe Brucker wrote:
> ARMv8.1 extensions added Virtualization Host Extensions (VHE), which allow
> to run a host kernel at EL2. When using normal DMA, Device and CPU address
> spaces are dissociated, and do not need to implement the same
> capabilities, so VHE hasn't been used in the SMMU until now.
> 
> With shared address spaces however, ASIDs are shared between MMU and SMMU,
> and broadcast TLB invalidations issued by a CPU are taken into account by
> the SMMU. TLB entries on both sides need to have identical exception level
> in order to be cleared with a single invalidation.
> 
> When the CPU is using VHE, enable VHE in the SMMU for all STEs. Normal DMA
> mappings will need to use TLBI_EL2 commands instead of TLBI_NH, but
> shouldn't be otherwise affected by this change.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
>  drivers/iommu/arm-smmu-v3.c | 31 ++++++++++++++++++++++++++-----
>  1 file changed, 26 insertions(+), 5 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

Will
