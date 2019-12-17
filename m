Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1BA7122D04
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2019 14:36:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbfLQNg4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Dec 2019 08:36:56 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:26154 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728011AbfLQNg4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Dec 2019 08:36:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576589814;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HljEq4ef6Mfn+qokWV7Wery5MNEmSIils0rI7SI/d+w=;
        b=ZuqaiVneUDpI2edNn6VFLmDPwFGm7/VS5Ae/CHmfW0ThgVk0X781SiBpFS/GfNvGpjxUR0
        tP3YsT1jlMLm5Al1RD+R8DzxBZzINwx7p/cdRVqFwd0CoKdW5m/PNQQMjB569mTt5bbxoO
        vrVeSarpH8gjizoT/JojpT3ElYXve94=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-382-t-RfVmcOMjq7dYvJBS-ZDw-1; Tue, 17 Dec 2019 08:36:50 -0500
X-MC-Unique: t-RfVmcOMjq7dYvJBS-ZDw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 141A3593A0;
        Tue, 17 Dec 2019 13:36:48 +0000 (UTC)
Received: from [10.36.116.117] (ovpn-116-117.ams2.redhat.com [10.36.116.117])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DA07D620BC;
        Tue, 17 Dec 2019 13:36:43 +0000 (UTC)
Subject: Re: [PATCH v3 06/13] iommu/arm-smmu-v3: Add context descriptor tables
 allocators
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
 <20191209180514.272727-7-jean-philippe@linaro.org>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <58b8fc6a-35f4-2e49-aa24-d184a2dfaeff@redhat.com>
Date:   Tue, 17 Dec 2019 14:36:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20191209180514.272727-7-jean-philippe@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Jean,

On 12/9/19 7:05 PM, Jean-Philippe Brucker wrote:
> Support for SSID will require allocating context descriptor tables. Move
> the context descriptor allocation to separate functions.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric
> ---
>  drivers/iommu/arm-smmu-v3.c | 57 ++++++++++++++++++++++++++++++-------
>  1 file changed, 46 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index b287e303b1d7..43d6a7ded6e4 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -568,6 +568,7 @@ struct arm_smmu_cd_table {
>  struct arm_smmu_s1_cfg {
>  	struct arm_smmu_cd_table	table;
>  	struct arm_smmu_ctx_desc	cd;
> +	u8				s1cdmax;
>  };
>  
>  struct arm_smmu_s2_cfg {
> @@ -1455,6 +1456,31 @@ static int arm_smmu_cmdq_issue_sync(struct arm_smmu_device *smmu)
>  }
>  
>  /* Context descriptor manipulation functions */
> +static int arm_smmu_alloc_cd_leaf_table(struct arm_smmu_device *smmu,
> +					struct arm_smmu_cd_table *table,
> +					size_t num_entries)
> +{
> +	size_t size = num_entries * (CTXDESC_CD_DWORDS << 3);
> +
> +	table->ptr = dmam_alloc_coherent(smmu->dev, size, &table->ptr_dma,
> +					 GFP_KERNEL);
> +	if (!table->ptr) {
> +		dev_warn(smmu->dev,
> +			 "failed to allocate context descriptor table\n");
> +		return -ENOMEM;
> +	}
> +	return 0;
> +}
> +
> +static void arm_smmu_free_cd_leaf_table(struct arm_smmu_device *smmu,
> +					struct arm_smmu_cd_table *table,
> +					size_t num_entries)
> +{
> +	size_t size = num_entries * (CTXDESC_CD_DWORDS << 3);
> +
> +	dmam_free_coherent(smmu->dev, size, table->ptr, table->ptr_dma);
> +}
> +
>  static u64 arm_smmu_cpu_tcr_to_cd(u64 tcr)
>  {
>  	u64 val = 0;
> @@ -1502,6 +1528,23 @@ static void arm_smmu_write_ctx_desc(struct arm_smmu_device *smmu,
>  	cdptr[3] = cpu_to_le64(cfg->cd.mair);
>  }
>  
> +static int arm_smmu_alloc_cd_tables(struct arm_smmu_domain *smmu_domain)
> +{
> +	struct arm_smmu_device *smmu = smmu_domain->smmu;
> +	struct arm_smmu_s1_cfg *cfg = &smmu_domain->s1_cfg;
> +
> +	return arm_smmu_alloc_cd_leaf_table(smmu, &cfg->table,
> +					    1 << cfg->s1cdmax);
> +}
> +
> +static void arm_smmu_free_cd_tables(struct arm_smmu_domain *smmu_domain)
> +{
> +	struct arm_smmu_device *smmu = smmu_domain->smmu;
> +	struct arm_smmu_s1_cfg *cfg = &smmu_domain->s1_cfg;
> +
> +	arm_smmu_free_cd_leaf_table(smmu, &cfg->table, 1 << cfg->s1cdmax);
> +}
> +
>  /* Stream table manipulation functions */
>  static void
>  arm_smmu_write_strtab_l1_desc(__le64 *dst, struct arm_smmu_strtab_l1_desc *desc)
> @@ -2145,11 +2188,7 @@ static void arm_smmu_domain_free(struct iommu_domain *domain)
>  		struct arm_smmu_s1_cfg *cfg = &smmu_domain->s1_cfg;
>  
>  		if (cfg->table.ptr) {
> -			dmam_free_coherent(smmu_domain->smmu->dev,
> -					   CTXDESC_CD_DWORDS << 3,
> -					   cfg->table.ptr,
> -					   cfg->table.ptr_dma);
> -
> +			arm_smmu_free_cd_tables(smmu_domain);
>  			arm_smmu_bitmap_free(smmu->asid_map, cfg->cd.asid);
>  		}
>  	} else {
> @@ -2173,13 +2212,9 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
>  	if (asid < 0)
>  		return asid;
>  
> -	cfg->table.ptr = dmam_alloc_coherent(smmu->dev, CTXDESC_CD_DWORDS << 3,
> -					     &cfg->table.ptr_dma, GFP_KERNEL);
> -	if (!cfg->table.ptr) {
> -		dev_warn(smmu->dev, "failed to allocate context descriptor\n");
> -		ret = -ENOMEM;
> +	ret = arm_smmu_alloc_cd_tables(smmu_domain);
> +	if (ret)
>  		goto out_free_asid;
> -	}
>  
>  	cfg->cd.asid	= (u16)asid;
>  	cfg->cd.ttbr	= pgtbl_cfg->arm_lpae_s1_cfg.ttbr[0];
> 

