Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01AD436CB97
	for <lists+linux-pci@lfdr.de>; Tue, 27 Apr 2021 21:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236287AbhD0TXT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Apr 2021 15:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238074AbhD0TXT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Apr 2021 15:23:19 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF4BC06175F
        for <linux-pci@vger.kernel.org>; Tue, 27 Apr 2021 12:22:35 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id v13so1465755ilj.8
        for <linux-pci@vger.kernel.org>; Tue, 27 Apr 2021 12:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9A9KdhpIimzuD5OzCChHO2CjGhCpPan1yRAo2/CAv+c=;
        b=KmmcN+wJO4XJEW8i1n4M8fdsVxKICGd+cicWY6PhIyfMntf61DWDbN0lYONPfv7avX
         7FxH4J1DcHU+d/BPW07cIeL7M0+KsL2H3xjnwnUShzOsbwp4p1Mstgek0/DJDywqlAvj
         pvQ4AeQxgT8d2B9boE2xCyb2V/QcKRwgqazkbOV36nIXZRCI1I41ENBc9O94GPWzuGWn
         ZoVb91ruebPuMOxROumRJF1bkL3LMcW5p3RL67vEkcYBqN+97GnMi303v4vqdgIYcysj
         J3wZPapZMjRdKb47N21dcq6V8IXSfFXXFfDtIZJD9rm1L4Cs5YgpeYsNB9gao99MRN+M
         bnKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9A9KdhpIimzuD5OzCChHO2CjGhCpPan1yRAo2/CAv+c=;
        b=DFajtj2ssS7e6jnTelfC5RVoT4bVhXdt4DhJsJ+NhaPw9YZ166MmB8MPRqtBfpOzi7
         78v4z6AZT5t6xd/iKTJe+dwEn6YWf5u6Hu1tHzcuIgW9rhVNddjnvl86CMNnV48I5CX3
         ZvMMgd0fEsGcVQiBDWIWs5axFpbqe5OHw6r97HSZE0oV5uJRpn88X4cmJT+qCOb/b81r
         ZeXkSro9LrPphnhWNhm0R2kLvpfYi2vDztmA5jU9TTPL+akt2HVFod9tAZ5CGtLt5sVd
         yyugsDIzinQA1JaYL2Ou/5vjFvW8o1PX9tHR5JBoLbdg9Hn5iXWyj9d5UYV1SdeDO7Tv
         opNA==
X-Gm-Message-State: AOAM530WD/uCiUJ2iXU6C+5eHlK3tSzh2j1SMvqsHKehL1xwA6XDPmbN
        xyyKW1Ad6A3WeuSq3kQGGSyCUg==
X-Google-Smtp-Source: ABdhPJx4F96uXqpXKJbkwUaij1OmBpJfBrZ4CVUAcProKFEqjv4XzeMalTF3wkg8sv23tVBPaKB/YA==
X-Received: by 2002:a05:6e02:13ca:: with SMTP id v10mr18478934ilj.191.1619551354939;
        Tue, 27 Apr 2021 12:22:34 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id d2sm1817918ile.18.2021.04.27.12.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 12:22:34 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1lbTI0-00Dglq-Rs; Tue, 27 Apr 2021 16:22:32 -0300
Date:   Tue, 27 Apr 2021 16:22:32 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Don Dutile <ddutile@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jakowski Andrzej <andrzej.jakowski@intel.com>,
        Minturn Dave B <dave.b.minturn@intel.com>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Xiong Jianxin <jianxin.xiong@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 05/16] dma-mapping: Introduce dma_map_sg_p2pdma()
Message-ID: <20210427192232.GO2047089@ziepe.ca>
References: <20210408170123.8788-1-logang@deltatee.com>
 <20210408170123.8788-6-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210408170123.8788-6-logang@deltatee.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 08, 2021 at 11:01:12AM -0600, Logan Gunthorpe wrote:
> dma_map_sg() either returns a positive number indicating the number
> of entries mapped or zero indicating that resources were not available
> to create the mapping. When zero is returned, it is always safe to retry
> the mapping later once resources have been freed.
> 
> Once P2PDMA pages are mixed into the SGL there may be pages that may
> never be successfully mapped with a given device because that device may
> not actually be able to access those pages. Thus, multiple error
> conditions will need to be distinguished to determine weather a retry
> is safe.
> 
> Introduce dma_map_sg_p2pdma[_attrs]() with a different calling
> convention from dma_map_sg(). The function will return a positive
> integer on success or a negative errno on failure.
> 
> ENOMEM will be used to indicate a resource failure and EREMOTEIO to
> indicate that a P2PDMA page is not mappable.
> 
> The __DMA_ATTR_PCI_P2PDMA attribute is introduced to inform the lower
> level implementations that P2PDMA pages are allowed and to warn if a
> caller introduces them into the regular dma_map_sg() interface.

So this new API is all about being able to return an error code
because auditing the old API is basically terrifying?

OK, but why name everything new P2PDMA? It seems nicer to give this
some generic name and have some general program to gradually deprecate
normal non-error-capable dma_map_sg() ?

I think that will raise less questions when subsystem people see the
changes, as I was wondering why RW was being moved to use what looked
like a p2pdma only API.

dma_map_sg_or_err() would have been clearer

The flag is also clearer as to the purpose if it is named
__DMA_ATTR_ERROR_ALLOWED

Jason
