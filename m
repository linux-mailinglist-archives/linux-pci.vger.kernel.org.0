Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C104413A98C
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2020 13:42:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbgANMmy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Jan 2020 07:42:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:41500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726106AbgANMmy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 14 Jan 2020 07:42:54 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A41E12072B;
        Tue, 14 Jan 2020 12:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579005773;
        bh=EqGlPOQVjDwFdU3xKCH6PmzQ7/ovsT61O4x/R8FJr0M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xstpOZpYaauuDO7rrBvagRtD5xotb6YaNsJ3bGzP45QIu7rDnCEgguFTiL2Kb7JOm
         f8rRQe68B+s3Z0VF1eMWatZycY80kQJmaPrykY3dX9iwp2WIX9vSMlXowT4YjkO30q
         i+WQTgjqrCUOu4uB7Ngo8LL8ZZ0SYYSt2ZTQ9/1A=
Date:   Tue, 14 Jan 2020 12:42:47 +0000
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
Subject: Re: [PATCH v4 09/13] iommu/arm-smmu-v3: Prepare for handling
 arm_smmu_write_ctx_desc() failure
Message-ID: <20200114124247.GD29222@willie-the-truck>
References: <20191219163033.2608177-1-jean-philippe@linaro.org>
 <20191219163033.2608177-10-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191219163033.2608177-10-jean-philippe@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 19, 2019 at 05:30:29PM +0100, Jean-Philippe Brucker wrote:
> Second-level context descriptor tables will be allocated lazily in
> arm_smmu_write_ctx_desc(). Help with handling allocation failure by
> moving the CD write into arm_smmu_domain_finalise_s1().
> 
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
>  drivers/iommu/arm-smmu-v3.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index e147087198ef..b825a5639afc 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -2301,8 +2301,15 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
>  	cfg->cd.ttbr	= pgtbl_cfg->arm_lpae_s1_cfg.ttbr[0];
>  	cfg->cd.tcr	= pgtbl_cfg->arm_lpae_s1_cfg.tcr;
>  	cfg->cd.mair	= pgtbl_cfg->arm_lpae_s1_cfg.mair;
> +
> +	ret = arm_smmu_write_ctx_desc(smmu_domain, 0, &cfg->cd);

Hmm. This ends up calling arm_smmu_sync_cd() but I think that happens before
we've added the master to the devices list of the domain. Does that mean we
miss the new SSID during the invalidation?

> +	if (ret)
> +		goto out_free_tables;
> +
>  	return 0;
>  
> +out_free_tables:

nit: We have more tables in this driver than you can shake a stick at, so
please rename the label "out_free_cd_tables" or something like that.

Will
