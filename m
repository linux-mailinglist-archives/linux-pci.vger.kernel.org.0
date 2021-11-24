Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9DEC45CB62
	for <lists+linux-pci@lfdr.de>; Wed, 24 Nov 2021 18:51:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242743AbhKXRy0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Nov 2021 12:54:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240911AbhKXRyZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Nov 2021 12:54:25 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A76C061574
        for <linux-pci@vger.kernel.org>; Wed, 24 Nov 2021 09:51:16 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id q16so2817648pgq.10
        for <linux-pci@vger.kernel.org>; Wed, 24 Nov 2021 09:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oTDchkafpOp/46IgeNxQuNHz+bM7M0+5Ox+wOnWqwfQ=;
        b=Qb2R4+I+DtEcOkXq0TYH/CagTNAxs9vdwiKlDdzULoiuVos13Xj0bBoEZSIPlJijzR
         C478wnOgwX2OIroiZLUXmkCPPl7ne/tYZ6BhKk2rJK6CwWNPOkQPdhuayJPTVdRrDcgL
         lYvMSdRGlCmlv6Yx0LePe8p8yv07r0peWf6/ErtsteaCes01s8SNwZ2q+UfiZQEciJ5R
         14+qbgLpmXR5b1sK15zTGPdKVkRwKQ9vgA4LZtRxlhr6dxnNSySqCpZULAsRTj6j4ZuC
         AymmMd7hKuQHEFmtp6YoDZPpoqm3daj0NDEv0m+0NdMYu4USrjQ47MKRLlI/ImkVjBPx
         BcWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oTDchkafpOp/46IgeNxQuNHz+bM7M0+5Ox+wOnWqwfQ=;
        b=MfRHGLQqCJ62MlJmbvxC5iJqZwSMVAEiakJYds7rB2l7xZbKLL8N/SImPVwxaSdCst
         xruT9ukl46Szs5XuJLZl7PQj5l5eKpnkzrYHH9ESZ/Z9z1QpZXjFHfXFklpp0aEkpW2f
         kCUUsdE4NsemgiM/R0AkgpvChyOjiMBrjEVDP0HeH2eOyRO/uAFWZznNBnaElsCZSVvu
         v3Qrd3OyJYgSmtKrEQdfzbfj6pRdnJjxHPpFVZJpFko07pjcjOWZ/yoWfmSLbk0JWmIc
         eVnKZfIE5PmfEVclb3kezcxoVn3DV2Rkg0tnQl5prPfRnXcENY/a/O8Ya365XNXjnPJH
         LJ+A==
X-Gm-Message-State: AOAM531/MU6e0M9hnPZjZ8xufb5YkG9qSntVKP6Sd+iMuJd9E92blkli
        oG6HsP0CFAcIHD/q3B+kmZ71SQ==
X-Google-Smtp-Source: ABdhPJwuLqZldVSYdI75Ai+PcBDkHa+xkpmfqt3+9vDSJ2R9/PWi5Orovy471RaYzID644RlCM4n+A==
X-Received: by 2002:aa7:9404:0:b0:494:6e78:67cd with SMTP id x4-20020aa79404000000b004946e7867cdmr7671622pfo.84.1637776275657;
        Wed, 24 Nov 2021 09:51:15 -0800 (PST)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id d2sm330981pfu.203.2021.11.24.09.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 09:51:14 -0800 (PST)
Date:   Wed, 24 Nov 2021 10:51:11 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Yicong Yang <yangyicong@hisilicon.com>
Cc:     gregkh@linuxfoundation.org, helgaas@kernel.org,
        alexander.shishkin@linux.intel.com, lorenzo.pieralisi@arm.com,
        will@kernel.org, mark.rutland@arm.com, suzuki.poulose@arm.com,
        mike.leach@linaro.org, leo.yan@linaro.org,
        jonathan.cameron@huawei.com, daniel.thompson@linaro.org,
        joro@8bytes.org, john.garry@huawei.com,
        shameerali.kolothum.thodi@huawei.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        linux-pci@vger.kernel.org, linux-perf-users@vger.kernel.org,
        iommu@lists.linux-foundation.org, prime.zeng@huawei.com,
        liuqi115@huawei.com, zhangshaokun@hisilicon.com,
        linuxarm@huawei.com, song.bao.hua@hisilicon.com
Subject: Re: [PATCH v2 1/6] iommu: Export iommu_{get,put}_resv_regions()
Message-ID: <20211124175111.GA35341@p14s>
References: <20211116090625.53702-1-yangyicong@hisilicon.com>
 <20211116090625.53702-2-yangyicong@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211116090625.53702-2-yangyicong@hisilicon.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 16, 2021 at 05:06:20PM +0800, Yicong Yang wrote:
> Export iommu_{get,put}_resv_regions() to the modules so that the driver
> can retrieve and use the reserved regions of the device.
> 
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> ---
>  drivers/iommu/iommu.c | 2 ++
>  include/linux/iommu.h | 4 ++--
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index dd7863e453a5..e96711eee965 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2792,6 +2792,7 @@ void iommu_get_resv_regions(struct device *dev, struct list_head *list)
>  	if (ops && ops->get_resv_regions)
>  		ops->get_resv_regions(dev, list);
>  }
> +EXPORT_SYMBOL_GPL(iommu_get_resv_regions);
>  
>  void iommu_put_resv_regions(struct device *dev, struct list_head *list)
>  {
> @@ -2800,6 +2801,7 @@ void iommu_put_resv_regions(struct device *dev, struct list_head *list)
>  	if (ops && ops->put_resv_regions)
>  		ops->put_resv_regions(dev, list);
>  }
> +EXPORT_SYMBOL_GPL(iommu_put_resv_regions);
>  
>  /**
>   * generic_iommu_put_resv_regions - Reserved region driver helper
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index d2f3435e7d17..1b7b0f370e28 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -450,8 +450,8 @@ extern phys_addr_t iommu_iova_to_phys(struct iommu_domain *domain, dma_addr_t io
>  extern void iommu_set_fault_handler(struct iommu_domain *domain,
>  			iommu_fault_handler_t handler, void *token);
>  
> -extern void iommu_get_resv_regions(struct device *dev, struct list_head *list);
> -extern void iommu_put_resv_regions(struct device *dev, struct list_head *list);
> +void iommu_get_resv_regions(struct device *dev, struct list_head *list);
> +void iommu_put_resv_regions(struct device *dev, struct list_head *list);

Acked-by: Mathieu Poirier <mathieu.poirier@linaro.org>

>  extern void generic_iommu_put_resv_regions(struct device *dev,
>  					   struct list_head *list);
>  extern void iommu_set_default_passthrough(bool cmd_line);
> -- 
> 2.33.0
> 
