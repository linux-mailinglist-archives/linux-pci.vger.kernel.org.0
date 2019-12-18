Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCC4212443A
	for <lists+linux-pci@lfdr.de>; Wed, 18 Dec 2019 11:18:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbfLRKSJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Dec 2019 05:18:09 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:36109 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726682AbfLRKSJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Dec 2019 05:18:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576664288;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LzL7HDaM7h2etRJEiQVdhdl2GZL68l8lKd1Hg2rlDWU=;
        b=CPgiqdY2T3pVW0bvEqhr2mpD/NtnRyJKAeDmAKjQOQohbzPigWVx4XFu82zCZ3YZVd7uxa
        HS3DRIf67zsBEBlFfdyQwkDf2CTIxPeqZxX9X+PZf1D9J+KyksHT+WEY+SmJFPRw3K+pA0
        G5Vo0+vG65tLYTUzmmxlhJ5phhmggNM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-420-l4BNxwTgNk6_xZLcRT0how-1; Wed, 18 Dec 2019 05:18:03 -0500
X-MC-Unique: l4BNxwTgNk6_xZLcRT0how-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D7B7E800D48;
        Wed, 18 Dec 2019 10:18:00 +0000 (UTC)
Received: from [10.36.116.117] (ovpn-116-117.ams2.redhat.com [10.36.116.117])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EC21026DF8;
        Wed, 18 Dec 2019 10:17:56 +0000 (UTC)
Subject: Re: [PATCH v3 13/13] iommu/arm-smmu-v3: Add support for PCI PASID
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
 <20191209180514.272727-14-jean-philippe@linaro.org>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <551ce08c-4160-72c9-05b5-97799f6e5d25@redhat.com>
Date:   Wed, 18 Dec 2019 11:17:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20191209180514.272727-14-jean-philippe@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Jean,

On 12/9/19 7:05 PM, Jean-Philippe Brucker wrote:
> Enable PASID for PCI devices that support it. Since the SSID tables are
> allocated by arm_smmu_attach_dev(), PASID has to be enabled early enough.
> arm_smmu_dev_feature_enable() would be too late, since by that time the
> main DMA domain has already been attached. Do it in add_device() instead.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
>  drivers/iommu/arm-smmu-v3.c | 51 ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 50 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index d20a79108f8a..cde7af39681c 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -2643,6 +2643,49 @@ static void arm_smmu_disable_ats(struct arm_smmu_master *master)
>  	atomic_dec(&smmu_domain->nr_ats_masters);
>  }
>  
> +static int arm_smmu_enable_pasid(struct arm_smmu_master *master)
> +{
> +	int ret;
> +	int features;
> +	int num_pasids;
> +	struct pci_dev *pdev;
> +
> +	if (!dev_is_pci(master->dev))
> +		return -ENODEV;
> +
> +	pdev = to_pci_dev(master->dev);
> +
> +	features = pci_pasid_features(pdev);
> +	if (features < 0)
> +		return -ENODEV;
why -ENODEV?
> +
> +	num_pasids = pci_max_pasids(pdev);
> +	if (num_pasids <= 0)
> +		return -ENODEV;
> +
> +	ret = pci_enable_pasid(pdev, features);
> +	if (!ret)
> +		master->ssid_bits = min_t(u8, ilog2(num_pasids),
> +					  master->smmu->ssid_bits);
so here we are ;-)
> +	return ret;
> +}
> +
> +static void arm_smmu_disable_pasid(struct arm_smmu_master *master)
> +{
> +	struct pci_dev *pdev;
> +
> +	if (!dev_is_pci(master->dev))
> +		return;
> +
> +	pdev = to_pci_dev(master->dev);
> +
> +	if (!pdev->pasid_enabled)
> +		return;
> +
> +	master->ssid_bits = 0;
> +	pci_disable_pasid(pdev);
> +}
> +
>  static void arm_smmu_detach_dev(struct arm_smmu_master *master)
>  {
>  	unsigned long flags;
> @@ -2851,13 +2894,16 @@ static int arm_smmu_add_device(struct device *dev)
>  
>  	master->ssid_bits = min(smmu->ssid_bits, fwspec->num_pasid_bits);
>  
> +	/* Note that PASID must be enabled before, and disabled after ATS */
> +	arm_smmu_enable_pasid(master);
No error handling?
> +
>  	if (!(smmu->features & ARM_SMMU_FEAT_2_LVL_CDTAB))
>  		master->ssid_bits = min_t(u8, master->ssid_bits,
>  					  CTXDESC_LINEAR_CDMAX);
>  
>  	ret = iommu_device_link(&smmu->iommu, dev);
>  	if (ret)
> -		goto err_free_master;
> +		goto err_disable_pasid;
>  
>  	group = iommu_group_get_for_dev(dev);
>  	if (IS_ERR(group)) {
> @@ -2870,6 +2916,8 @@ static int arm_smmu_add_device(struct device *dev)
>  
>  err_unlink:
>  	iommu_device_unlink(&smmu->iommu, dev);
> +err_disable_pasid:
> +	arm_smmu_disable_pasid(master);
>  err_free_master:
>  	kfree(master);
>  	fwspec->iommu_priv = NULL;
> @@ -2890,6 +2938,7 @@ static void arm_smmu_remove_device(struct device *dev)
>  	arm_smmu_detach_dev(master);
>  	iommu_group_remove_device(dev);
>  	iommu_device_unlink(&smmu->iommu, dev);
> +	arm_smmu_disable_pasid(master);
>  	kfree(master);
>  	iommu_fwspec_free(dev);
>  }
> 

Thanks

Eric

