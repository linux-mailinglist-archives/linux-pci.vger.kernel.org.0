Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABB651C1271
	for <lists+linux-pci@lfdr.de>; Fri,  1 May 2020 14:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728586AbgEAMzR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 May 2020 08:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728443AbgEAMzQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 May 2020 08:55:16 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E10EC061A0C
        for <linux-pci@vger.kernel.org>; Fri,  1 May 2020 05:55:16 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id ep1so4680801qvb.0
        for <linux-pci@vger.kernel.org>; Fri, 01 May 2020 05:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=P0z8kBnXrlZIDie1dLQeqogN9MwmVy7z4o7SA4TqzwU=;
        b=Nq8HOg9n7Z+VdnITQnbqqVABmWu3/6twaYJ7q1ZG6DqOfwLX2pqDKfEDSh+EIm/he8
         8XxNujX7EOvHA+Z3U42zDC/h9oN+aKWNxlISO0Rq2tTCVZNWNCIrJWk7sh2DWdjcVwvU
         wCvE4KNEgpOv+mKqLqLC6erVH6iCBHZ3nggeOEQIkaDvn7IPj2tAyOj9O8z6V4Qx2f1V
         20zcGw/GN8o0n+NfO/8kyZsltT7TcTtCKSej9x25s7Vy8ZXZSAEGpL08aolIMnLihAqM
         O4lVQbo50EUAWIw62edP+hXhKTif6IJbYSGaALf2LAPuTPfJPTwd2r2FjwrGZ5t7qGNY
         ydVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=P0z8kBnXrlZIDie1dLQeqogN9MwmVy7z4o7SA4TqzwU=;
        b=pcYP5VqXxtygZsezjyk7BrsqYOqSyPU5K62i62EcuVTu/VuZmMJADwMrZpQ3IgPczO
         M75HcINa0Jm/R5tjd5Z4JFVkvcPmwSIPP6/+jXatUyZqlIw4CTxqwIaJlKGrEgR42tmy
         pEYI4mO81SiwBqb9+ADnXQN/IIjmOai4KVYuWII+62UHgdyUngKuGq19dNZpOyWglEQY
         9qdyx4KgMFOd5jvZS2ah1WzRt0o++TuUhhPmCFV22Mt1+liO2steg4D1PyCpK7rC/Fhh
         qMhQ2HHhxkLFF5+Es+1td6PeaROtqEMnSoUUR4fLeIV3Yw51UD4C8QgMVKGabJwB7/LH
         Vyrg==
X-Gm-Message-State: AGi0PuYHRt3L77Rql7w9v1DVEutkII4Ztmg7i5bGqH12o+A/RCNFqhTA
        V6/DBEUrfvwRtSmrAUzQdHKfWQ==
X-Google-Smtp-Source: APiQypJcH2wlws52fFFXitF6KkzvvmTMs6scpT5jXa1TBx4TcLMsA/h0u5FOFpvXuuZfcR/nYumjiA==
X-Received: by 2002:a05:6214:a4e:: with SMTP id ee14mr3877158qvb.121.1588337715542;
        Fri, 01 May 2020 05:55:15 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id 28sm2645211qkp.10.2020.05.01.05.55.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 May 2020 05:55:14 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jUVCD-0007LO-33; Fri, 01 May 2020 09:55:13 -0300
Date:   Fri, 1 May 2020 09:55:13 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, fenghua.yu@intel.com, kevin.tian@intel.com,
        catalin.marinas@arm.com, robin.murphy@arm.com,
        zhangfei.gao@linaro.org, felix.kuehling@amd.com, will@kernel.org,
        christian.koenig@amd.com
Subject: Re: [PATCH v6 17/25] iommu/arm-smmu-v3: Implement
 iommu_sva_bind/unbind()
Message-ID: <20200501125513.GN26002@ziepe.ca>
References: <20200430143424.2787566-1-jean-philippe@linaro.org>
 <20200430143424.2787566-18-jean-philippe@linaro.org>
 <20200501121552.GA6012@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200501121552.GA6012@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 01, 2020 at 05:15:52AM -0700, Christoph Hellwig wrote:
> > @@ -432,6 +432,7 @@ config ARM_SMMU_V3
> >  	tristate "ARM Ltd. System MMU Version 3 (SMMUv3) Support"
> >  	depends on ARM64
> >  	select IOMMU_API
> > +	select IOMMU_SVA
> >  	select IOMMU_IO_PGTABLE_LPAE
> >  	select GENERIC_MSI_IRQ_DOMAIN
> 
> Doesn't this need to select MMU_NOTIFIER now?
> 
> > +	struct mmu_notifier_ops		mn_ops;
> 
> Note: not a pointer.
> 
> > +	/* If bind() was already called for this (dev, mm) pair, reuse it. */
> > +	list_for_each_entry(bond, &master->bonds, list) {
> > +		if (bond->mm == mm) {
> > +			refcount_inc(&bond->refs);
> > +			return &bond->sva;
> > +		}
> > +	}

I also would like it if searching for mms in linked lists was not
necessary, this is kind of the point of 'get'

Is this a side effect of the earlier remark to get rid of the linked
list inside the notifier?

> Or we could enhance the mmu_notifier_get to pass a private
> oaque instance ID pointer, which is checked in addition to the ops,
> and you could probably kill off the bonds list and lookup.

This might be the best option if it can absorb the above search..

Jason
