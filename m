Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0806A124423
	for <lists+linux-pci@lfdr.de>; Wed, 18 Dec 2019 11:17:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbfLRKRy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Dec 2019 05:17:54 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60733 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726360AbfLRKRx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Dec 2019 05:17:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576664271;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ak6ATDFUqAlrkDJyAcSn/Y2cYfzHlLjmCX8QIyVg8Ig=;
        b=D4bUYAMrwlk9fyRoEI6HrHN9uvjx8+iF5p3TixAXyE7hn9rOmF6zMjRYuTIgj/5zH0kqD/
        ti2Iul/gNSEuJjhUKatkWYg1NicFRi4nOrml1DAsJzTKY82aCwQ0NCTakprGOajoFo0aw9
        LoDbOEDYWDNgZDjoZRalyHiYFz6E1/8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-270-lTO4kAjwMJqiIHHZkW6rbQ-1; Wed, 18 Dec 2019 05:17:48 -0500
X-MC-Unique: lTO4kAjwMJqiIHHZkW6rbQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 166DEDB22;
        Wed, 18 Dec 2019 10:17:46 +0000 (UTC)
Received: from [10.36.116.117] (ovpn-116-117.ams2.redhat.com [10.36.116.117])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E974E68882;
        Wed, 18 Dec 2019 10:17:41 +0000 (UTC)
Subject: Re: [PATCH v3 03/13] iommu/arm-smmu-v3: Support platform SSID
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
 <20191209180514.272727-4-jean-philippe@linaro.org>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <06c57de4-cfca-f95f-ac06-ab6f49a028a3@redhat.com>
Date:   Wed, 18 Dec 2019 11:17:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20191209180514.272727-4-jean-philippe@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Jean,

On 12/9/19 7:05 PM, Jean-Philippe Brucker wrote:
> For platform devices that support SubstreamID (SSID), firmware provides
> the number of supported SSID bits. Restrict it to what the SMMU supports
> and cache it into master->ssid_bits, which will also be used for PCI
> PASID.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
the title of the patch does not really explain what it actually does. At
this stage we are far from supporting SSIDs ;-) Same for 04?

Thanks

Eric
> ---
>  drivers/iommu/arm-smmu-v3.c | 13 +++++++++++++
>  drivers/iommu/of_iommu.c    |  6 +++++-
>  include/linux/iommu.h       |  2 ++
>  3 files changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index d4e8b7f8d9f4..837b4283b4dc 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -292,6 +292,12 @@
>  
>  #define CTXDESC_CD_1_TTB0_MASK		GENMASK_ULL(51, 4)
>  
> +/*
> + * When the SMMU only supports linear context descriptor tables, pick a
> + * reasonable size limit (64kB).
> + */
> +#define CTXDESC_LINEAR_CDMAX		ilog2(SZ_64K / (CTXDESC_CD_DWORDS << 3))
> +
>  /* Convert between AArch64 (CPU) TCR format and SMMU CD format */
>  #define ARM_SMMU_TCR2CD(tcr, fld)	FIELD_PREP(CTXDESC_CD_0_TCR_##fld, \
>  					FIELD_GET(ARM64_TCR_##fld, tcr))
> @@ -638,6 +644,7 @@ struct arm_smmu_master {
>  	u32				*sids;
>  	unsigned int			num_sids;
>  	bool				ats_enabled;
> +	unsigned int			ssid_bits;
>  };
>  
>  /* SMMU private data for an IOMMU domain */
> @@ -2571,6 +2578,12 @@ static int arm_smmu_add_device(struct device *dev)
>  		}
>  	}
>  
> +	master->ssid_bits = min(smmu->ssid_bits, fwspec->num_pasid_bits);
> +
> +	if (!(smmu->features & ARM_SMMU_FEAT_2_LVL_CDTAB))
> +		master->ssid_bits = min_t(u8, master->ssid_bits,
> +					  CTXDESC_LINEAR_CDMAX);
> +
>  	group = iommu_group_get_for_dev(dev);
>  	if (!IS_ERR(group)) {
>  		iommu_group_put(group);
> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> index 026ad2b29dcd..b3ccb2f7f1c7 100644
> --- a/drivers/iommu/of_iommu.c
> +++ b/drivers/iommu/of_iommu.c
> @@ -196,8 +196,12 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
>  			if (err)
>  				break;
>  		}
> -	}
>  
> +		fwspec = dev_iommu_fwspec_get(dev);
> +		if (!err && fwspec)
> +			of_property_read_u32(master_np, "pasid-num-bits",
> +					     &fwspec->num_pasid_bits);
> +	}
>  
>  	/*
>  	 * Two success conditions can be represented by non-negative err here:
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 3a113c5d7394..bd46775c3329 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -581,6 +581,7 @@ struct iommu_group *fsl_mc_device_group(struct device *dev);
>   * @ops: ops for this device's IOMMU
>   * @iommu_fwnode: firmware handle for this device's IOMMU
>   * @iommu_priv: IOMMU driver private data for this device
> + * @num_pasid_bits: number of PASID bits supported by this device
>   * @num_ids: number of associated device IDs
>   * @ids: IDs which this device may present to the IOMMU
>   */
> @@ -589,6 +590,7 @@ struct iommu_fwspec {
>  	struct fwnode_handle	*iommu_fwnode;
>  	void			*iommu_priv;
>  	u32			flags;
> +	u32			num_pasid_bits;
>  	unsigned int		num_ids;
>  	u32			ids[1];
>  };
> 

