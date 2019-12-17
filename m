Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6913122CD2
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2019 14:27:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbfLQN1P (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Dec 2019 08:27:15 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:22069 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726709AbfLQN1P (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Dec 2019 08:27:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576589233;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pUq2a5pZ/dt2qGPzTnxHTjJcR3qch9Jn0NM29Gx0avs=;
        b=GUJigyGWcU335oSByS5Vqq52E8m1ie5RgYu1+SLT3bhurC6t9oKI+SZg6giEaDzAwuP2yX
        mP3zSihoeiDDCROxhnmcMzatLROia6mh+TdPnLWNjd3W5j+H8TofDwfS8nZ4+LLSONUf1p
        foD9hdRomb+1L7dl5L/4LNGocQ+zDcM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-210-D7gd0hVnNieBrcFWJ_UiaQ-1; Tue, 17 Dec 2019 08:27:09 -0500
X-MC-Unique: D7gd0hVnNieBrcFWJ_UiaQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 265F68017DF;
        Tue, 17 Dec 2019 13:27:07 +0000 (UTC)
Received: from [10.36.116.117] (ovpn-116-117.ams2.redhat.com [10.36.116.117])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 24A2060C63;
        Tue, 17 Dec 2019 13:27:02 +0000 (UTC)
Subject: Re: [PATCH v3 05/13] iommu/arm-smmu-v3: Prepare arm_smmu_s1_cfg for
 SSID support
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        iommu@lists.linux-foundation.org
Cc:     joro@8bytes.org, robh+dt@kernel.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, guohanjun@huawei.com,
        sudeep.holla@arm.com, rjw@rjwysocki.net, lenb@kernel.org,
        will@kernel.org, robin.murphy@arm.com, bhelgaas@google.com,
        jonathan.cameron@huawei.com, zhangfei.gao@linaro.org
References: <20191209180514.272727-1-jean-philippe@linaro.org>
 <20191209180514.272727-6-jean-philippe@linaro.org>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <7b20be5c-0b3f-dbec-ffd6-508b4667cf1b@redhat.com>
Date:   Tue, 17 Dec 2019 14:27:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20191209180514.272727-6-jean-philippe@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Jean,

On 12/9/19 7:05 PM, Jean-Philippe Brucker wrote:
> When adding SSID support to the SMMUv3 driver, we'll need to manipulate
> leaf pasid tables and context descriptors. Extract the context
> descriptor structure and introduce a new table structure.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric

> ---
>  drivers/iommu/arm-smmu-v3.c | 44 +++++++++++++++++++++----------------
>  1 file changed, 25 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 837b4283b4dc..b287e303b1d7 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -553,16 +553,21 @@ struct arm_smmu_strtab_l1_desc {
>  	dma_addr_t			l2ptr_dma;
>  };
>  
> +struct arm_smmu_ctx_desc {
> +	u16				asid;
> +	u64				ttbr;
> +	u64				tcr;
> +	u64				mair;
> +};
> +
> +struct arm_smmu_cd_table {
> +	__le64				*ptr;
> +	dma_addr_t			ptr_dma;
> +};
> +
>  struct arm_smmu_s1_cfg {
> -	__le64				*cdptr;
> -	dma_addr_t			cdptr_dma;
> -
> -	struct arm_smmu_ctx_desc {
> -		u16	asid;
> -		u64	ttbr;
> -		u64	tcr;
> -		u64	mair;
> -	}				cd;
> +	struct arm_smmu_cd_table	table;
> +	struct arm_smmu_ctx_desc	cd;
>  };
>  
>  struct arm_smmu_s2_cfg {
> @@ -1471,6 +1476,7 @@ static void arm_smmu_write_ctx_desc(struct arm_smmu_device *smmu,
>  				    struct arm_smmu_s1_cfg *cfg)
>  {
>  	u64 val;
> +	__le64 *cdptr = cfg->table.ptr;
>  
>  	/*
>  	 * We don't need to issue any invalidation here, as we'll invalidate
> @@ -1488,12 +1494,12 @@ static void arm_smmu_write_ctx_desc(struct arm_smmu_device *smmu,
>  	if (smmu->features & ARM_SMMU_FEAT_STALL_FORCE)
>  		val |= CTXDESC_CD_0_S;
>  
> -	cfg->cdptr[0] = cpu_to_le64(val);
> +	cdptr[0] = cpu_to_le64(val);
>  
>  	val = cfg->cd.ttbr & CTXDESC_CD_1_TTB0_MASK;
> -	cfg->cdptr[1] = cpu_to_le64(val);
> +	cdptr[1] = cpu_to_le64(val);
>  
> -	cfg->cdptr[3] = cpu_to_le64(cfg->cd.mair);
> +	cdptr[3] = cpu_to_le64(cfg->cd.mair);
>  }
>  
>  /* Stream table manipulation functions */
> @@ -1624,7 +1630,7 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
>  		   !(smmu->features & ARM_SMMU_FEAT_STALL_FORCE))
>  			dst[1] |= cpu_to_le64(STRTAB_STE_1_S1STALLD);
>  
> -		val |= (s1_cfg->cdptr_dma & STRTAB_STE_0_S1CTXPTR_MASK) |
> +		val |= (s1_cfg->table.ptr_dma & STRTAB_STE_0_S1CTXPTR_MASK) |
>  			FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_S1_TRANS);
>  	}
>  
> @@ -2138,11 +2144,11 @@ static void arm_smmu_domain_free(struct iommu_domain *domain)
>  	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
>  		struct arm_smmu_s1_cfg *cfg = &smmu_domain->s1_cfg;
>  
> -		if (cfg->cdptr) {
> +		if (cfg->table.ptr) {
>  			dmam_free_coherent(smmu_domain->smmu->dev,
>  					   CTXDESC_CD_DWORDS << 3,
> -					   cfg->cdptr,
> -					   cfg->cdptr_dma);
> +					   cfg->table.ptr,
> +					   cfg->table.ptr_dma);
>  
>  			arm_smmu_bitmap_free(smmu->asid_map, cfg->cd.asid);
>  		}
> @@ -2167,9 +2173,9 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
>  	if (asid < 0)
>  		return asid;
>  
> -	cfg->cdptr = dmam_alloc_coherent(smmu->dev, CTXDESC_CD_DWORDS << 3,
> -					 &cfg->cdptr_dma, GFP_KERNEL);
> -	if (!cfg->cdptr) {
> +	cfg->table.ptr = dmam_alloc_coherent(smmu->dev, CTXDESC_CD_DWORDS << 3,
> +					     &cfg->table.ptr_dma, GFP_KERNEL);
> +	if (!cfg->table.ptr) {
>  		dev_warn(smmu->dev, "failed to allocate context descriptor\n");
>  		ret = -ENOMEM;
>  		goto out_free_asid;
> 

