Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE6321C04DF
	for <lists+linux-pci@lfdr.de>; Thu, 30 Apr 2020 20:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbgD3Sda (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Apr 2020 14:33:30 -0400
Received: from mga05.intel.com ([192.55.52.43]:31224 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726318AbgD3Sda (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 30 Apr 2020 14:33:30 -0400
IronPort-SDR: QYeQDpDxDQ0xiIxh+VpYeWRTaw44rMHjkmjzrX7xdWZX3oSlOeS15aqIKKesVzjnBNErrioA8G
 dpv8514pWfXw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2020 11:33:29 -0700
IronPort-SDR: J48xY2cKJPAK1NVryygQbF/nagAXDIYz1I6SC3AHIW5UHcqfCG66Luu3iM/N/zRymWaoSl5F24
 9Hf1OxKC5PKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,336,1583222400"; 
   d="scan'208";a="433056299"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga005.jf.intel.com with ESMTP; 30 Apr 2020 11:33:28 -0700
Date:   Thu, 30 Apr 2020 11:39:31 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, joro@8bytes.org, catalin.marinas@arm.com,
        will@kernel.org, robin.murphy@arm.com, kevin.tian@intel.com,
        baolu.lu@linux.intel.com, Jonathan.Cameron@huawei.com,
        christian.koenig@amd.com, felix.kuehling@amd.com,
        zhangfei.gao@linaro.org, jgg@ziepe.ca, xuzaibo@huawei.com,
        fenghua.yu@intel.com, hch@infradead.org,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v6 02/25] iommu/ioasid: Add ioasid references
Message-ID: <20200430113931.0fbf7a37@jacob-builder>
In-Reply-To: <20200430143424.2787566-3-jean-philippe@linaro.org>
References: <20200430143424.2787566-1-jean-philippe@linaro.org>
        <20200430143424.2787566-3-jean-philippe@linaro.org>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 30 Apr 2020 16:34:01 +0200
Jean-Philippe Brucker <jean-philippe@linaro.org> wrote:

> Let IOASID users take references to existing ioasids with
> ioasid_get(). ioasid_free() drops a reference and only frees the
> ioasid when its reference number is zero. It returns whether the
> ioasid was freed.
> 
Looks good to me, I was planning to do the same for VT-d use. Just a
couple of points for potential extension. I can rebase on top of this.


> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
>  include/linux/ioasid.h | 10 ++++++++--
>  drivers/iommu/ioasid.c | 30 +++++++++++++++++++++++++++++-
>  2 files changed, 37 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
> index 6f000d7a0ddcd..609ba6f15b9e3 100644
> --- a/include/linux/ioasid.h
> +++ b/include/linux/ioasid.h
> @@ -34,7 +34,8 @@ struct ioasid_allocator_ops {
>  #if IS_ENABLED(CONFIG_IOASID)
>  ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min, ioasid_t
> max, void *private);
> -void ioasid_free(ioasid_t ioasid);
> +void ioasid_get(ioasid_t ioasid);
> +bool ioasid_free(ioasid_t ioasid);
>  void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid,
>  		  bool (*getter)(void *));
>  int ioasid_register_allocator(struct ioasid_allocator_ops
> *allocator); @@ -48,10 +49,15 @@ static inline ioasid_t
> ioasid_alloc(struct ioasid_set *set, ioasid_t min, return
> INVALID_IOASID; }
>  
> -static inline void ioasid_free(ioasid_t ioasid)
> +static inline void ioasid_get(ioasid_t ioasid)
>  {
>  }
>  
> +static inline bool ioasid_free(ioasid_t ioasid)
> +{
> +	return false;
> +}
> +
>  static inline void *ioasid_find(struct ioasid_set *set, ioasid_t
> ioasid, bool (*getter)(void *))
>  {
> diff --git a/drivers/iommu/ioasid.c b/drivers/iommu/ioasid.c
> index 0f8dd377aada3..46511ac53e0c8 100644
> --- a/drivers/iommu/ioasid.c
> +++ b/drivers/iommu/ioasid.c
> @@ -15,6 +15,7 @@ struct ioasid_data {
>  	struct ioasid_set *set;
>  	void *private;
>  	struct rcu_head rcu;
> +	refcount_t refs;
>  };
>  
>  /*
> @@ -314,6 +315,7 @@ ioasid_t ioasid_alloc(struct ioasid_set *set,
> ioasid_t min, ioasid_t max, 
>  	data->set = set;
>  	data->private = private;
> +	refcount_set(&data->refs, 1);
>  
>  	/*
>  	 * Custom allocator needs allocator data to perform platform
> specific @@ -345,12 +347,33 @@ ioasid_t ioasid_alloc(struct
> ioasid_set *set, ioasid_t min, ioasid_t max, }
>  EXPORT_SYMBOL_GPL(ioasid_alloc);
>  
> +/**
> + * ioasid_get - obtain a reference to the IOASID
> + */
> +void ioasid_get(ioasid_t ioasid)
why void? what if the ioasid is not valid.

> +{
> +	struct ioasid_data *ioasid_data;
> +
> +	spin_lock(&ioasid_allocator_lock);
> +	ioasid_data = xa_load(&active_allocator->xa, ioasid);
> +	if (ioasid_data)
> +		refcount_inc(&ioasid_data->refs);
> +	spin_unlock(&ioasid_allocator_lock);
> +}
> +EXPORT_SYMBOL_GPL(ioasid_get);
> +
>  /**
>   * ioasid_free - Free an IOASID
>   * @ioasid: the ID to remove
> + *
> + * Put a reference to the IOASID, free it when the number of
> references drops to
> + * zero.
> + *
> + * Return: %true if the IOASID was freed, %false otherwise.
>   */
> -void ioasid_free(ioasid_t ioasid)
> +bool ioasid_free(ioasid_t ioasid)
>  {
> +	bool free = false;
>  	struct ioasid_data *ioasid_data;
>  
>  	spin_lock(&ioasid_allocator_lock);
> @@ -360,6 +383,10 @@ void ioasid_free(ioasid_t ioasid)
>  		goto exit_unlock;
>  	}
>  
> +	free = refcount_dec_and_test(&ioasid_data->refs);
> +	if (!free)
> +		goto exit_unlock;
> +
Just FYI, we may need to add states for the IOASID, i.g. mark the IOASID
inactive after free. And prohibit ioasid_get() after freed. For VT-d,
this is useful when KVM queries the IOASID.

>  	active_allocator->ops->free(ioasid,
> active_allocator->ops->pdata); /* Custom allocator needs additional
> steps to free the xa element */ if (active_allocator->flags &
> IOASID_ALLOCATOR_CUSTOM) { @@ -369,6 +396,7 @@ void
> ioasid_free(ioasid_t ioasid) 
>  exit_unlock:
>  	spin_unlock(&ioasid_allocator_lock);
> +	return free;
>  }
>  EXPORT_SYMBOL_GPL(ioasid_free);
>  

[Jacob Pan]
