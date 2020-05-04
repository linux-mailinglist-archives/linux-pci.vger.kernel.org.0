Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 634481C3CED
	for <lists+linux-pci@lfdr.de>; Mon,  4 May 2020 16:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728786AbgEDO0F (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 May 2020 10:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726922AbgEDO0F (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 May 2020 10:26:05 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69145C061A10
        for <linux-pci@vger.kernel.org>; Mon,  4 May 2020 07:26:03 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id i10so21161636wrv.10
        for <linux-pci@vger.kernel.org>; Mon, 04 May 2020 07:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=F/z0V3mcBGUp+syXehq8FDmPP6eWJmRKpReZL7dY1ho=;
        b=z1iuPCF+taVGKa11c2yjWNjOpHuDo1RB1E7mbiG1WoVCEMCNh5P8g+itjpP3FUb4gs
         mCE66WIAwk3XxYtzkPIlMa2cgsSYqPT/sHmkzg7ZxXM+z96IIV31FcsFHFSq4qIafaMB
         24lM1ATRxsNNtieYoZwGa57aXFJ3ATXi47XR5U3U8SyqHQfieuZVpCa6NuqP10uVhaer
         GlXWtziftzxxoED82b0x2bP5555Q3FS+QQfHvURtC/EZAjTaNVZME8nZQsu/VQSLGBQV
         3URfU7Lb1juS31WTwwRasil1iZl8t0N/SPOSiqBJE6kdXsxH3add7ofJV2qxRW9qCi7T
         V46g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=F/z0V3mcBGUp+syXehq8FDmPP6eWJmRKpReZL7dY1ho=;
        b=bMsvf5s3AF8HkhtoEV/g8STm6tsKgp1JQhhSRuGDQrGhZ1BdEcj8ZBSHemlJssvJmB
         4QQqtICYLu6ZNLOprAwzZA2Gxh6IUVGkl2FQsQHaMs+Dxk+x9tZamWin0IWalJ1mm4Cq
         9LU93mY72/BZso/epOOkzGhAWa2RdDOh7xcOrGLGp/yF6yCvirg5OMS7QuawxlfTmbV3
         J9SVLGF8EPu3bIC6IYCTOJw3qVy1U/EczPPdIh1bYqBj4Q31SAM8MlUB25Udt/dWWfQ1
         uSfqUgeXPqxg01hDRou8GwmrYaF5yhbyTXUNUHdMWBlqsuge6bcjCxZJgVZOMXfz38O/
         S8Bw==
X-Gm-Message-State: AGi0PuZDF0Ua9TidaSpuwQkwoaP5mcYaElUVy8OiJaUDcjxWzcuuaqNY
        mZMFp7YdX9gIww8QFqUh4TjHkA==
X-Google-Smtp-Source: APiQypJvR/uVsrLrYsoae/U5bNYqj69oeGktdTlceIG72vmnH3x2R6717uW94oIHTrpwNOfPUuH1bw==
X-Received: by 2002:adf:e745:: with SMTP id c5mr9977426wrn.263.1588602361937;
        Mon, 04 May 2020 07:26:01 -0700 (PDT)
Received: from myrica ([2001:171b:226e:c200:c43b:ef78:d083:b355])
        by smtp.gmail.com with ESMTPSA id a205sm14484714wmh.29.2020.05.04.07.25.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 07:26:01 -0700 (PDT)
Date:   Mon, 4 May 2020 16:25:48 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, joro@8bytes.org, catalin.marinas@arm.com,
        will@kernel.org, robin.murphy@arm.com, kevin.tian@intel.com,
        baolu.lu@linux.intel.com, Jonathan.Cameron@huawei.com,
        christian.koenig@amd.com, felix.kuehling@amd.com,
        zhangfei.gao@linaro.org, jgg@ziepe.ca, xuzaibo@huawei.com,
        fenghua.yu@intel.com, hch@infradead.org
Subject: Re: [PATCH v6 02/25] iommu/ioasid: Add ioasid references
Message-ID: <20200504142548.GB170104@myrica>
References: <20200430143424.2787566-1-jean-philippe@linaro.org>
 <20200430143424.2787566-3-jean-philippe@linaro.org>
 <20200430113931.0fbf7a37@jacob-builder>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200430113931.0fbf7a37@jacob-builder>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 30, 2020 at 11:39:31AM -0700, Jacob Pan wrote:
> > +/**
> > + * ioasid_get - obtain a reference to the IOASID
> > + */
> > +void ioasid_get(ioasid_t ioasid)
> why void? what if the ioasid is not valid.

My intended use was for the caller to get an additional reference when
they're already holding one. So this should always succeed and I'd prefer
a WARN_ON if the ioasid isn't valid rather than returning an error. But if
you intend to add a state to ioasids between dropping refcount and free,
then a return value makes sense.

Thanks,
Jean

> 
> > +{
> > +	struct ioasid_data *ioasid_data;
> > +
> > +	spin_lock(&ioasid_allocator_lock);
> > +	ioasid_data = xa_load(&active_allocator->xa, ioasid);
> > +	if (ioasid_data)
> > +		refcount_inc(&ioasid_data->refs);
> > +	spin_unlock(&ioasid_allocator_lock);
> > +}
> > +EXPORT_SYMBOL_GPL(ioasid_get);
> > +
> >  /**
> >   * ioasid_free - Free an IOASID
> >   * @ioasid: the ID to remove
> > + *
> > + * Put a reference to the IOASID, free it when the number of
> > references drops to
> > + * zero.
> > + *
> > + * Return: %true if the IOASID was freed, %false otherwise.
> >   */
> > -void ioasid_free(ioasid_t ioasid)
> > +bool ioasid_free(ioasid_t ioasid)
> >  {
> > +	bool free = false;
> >  	struct ioasid_data *ioasid_data;
> >  
> >  	spin_lock(&ioasid_allocator_lock);
> > @@ -360,6 +383,10 @@ void ioasid_free(ioasid_t ioasid)
> >  		goto exit_unlock;
> >  	}
> >  
> > +	free = refcount_dec_and_test(&ioasid_data->refs);
> > +	if (!free)
> > +		goto exit_unlock;
> > +
> Just FYI, we may need to add states for the IOASID, i.g. mark the IOASID
> inactive after free. And prohibit ioasid_get() after freed. For VT-d,
> this is useful when KVM queries the IOASID.
> 
> >  	active_allocator->ops->free(ioasid,
> > active_allocator->ops->pdata); /* Custom allocator needs additional
> > steps to free the xa element */ if (active_allocator->flags &
> > IOASID_ALLOCATOR_CUSTOM) { @@ -369,6 +396,7 @@ void
> > ioasid_free(ioasid_t ioasid) 
> >  exit_unlock:
> >  	spin_unlock(&ioasid_allocator_lock);
> > +	return free;
> >  }
> >  EXPORT_SYMBOL_GPL(ioasid_free);
> >  
> 
> [Jacob Pan]
