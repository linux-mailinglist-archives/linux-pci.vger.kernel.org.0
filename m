Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 451972A9B06
	for <lists+linux-pci@lfdr.de>; Fri,  6 Nov 2020 18:42:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbgKFRm0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Nov 2020 12:42:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727458AbgKFRm0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 Nov 2020 12:42:26 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C190FC0613D3
        for <linux-pci@vger.kernel.org>; Fri,  6 Nov 2020 09:42:25 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id n132so707851qke.1
        for <linux-pci@vger.kernel.org>; Fri, 06 Nov 2020 09:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3buLvlWL+9G09nyEaJ7/3CqkDjgWFOdmZgEsg7qS7YA=;
        b=MOCiBjSN2a1hPwUL+FJFYuzQlwO8wmt6NgCt9FaTyLzUmSuNFZ8pJFJjnpYDGgsQ26
         a8j6AjUBHGPJgl1+H9vdmuYPkKU68pFmYfvE9HQawmCY4vIz+ZApkGBVOkd9dWhh0DXa
         q56QEyRr53QyWSixEoTgaJPahFsdyxl3XbdZlglN7e+iI0rw/ar1o9FTO4zJteIHNrs9
         fCSMQ6f2iYfcLKZJGeHkqKVzX2CdNVjmmqzCZDSDIw8FQ5JzVVCMMhMKmUFdxYZt2g0v
         2SDXecJEMacL6cL9Se7kxpJ/LhH+/YR2QfiDFmQPiXf/MhTYpep4QtUSKXYnfiMtIam2
         37AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3buLvlWL+9G09nyEaJ7/3CqkDjgWFOdmZgEsg7qS7YA=;
        b=E4laZpEI8ZQzw44mC+c58dBCd+Q7yW3DweP553h2inje747na5dHIx4tFxlmqJF9+X
         xdrlxKBHsIWFUrIkgUQIYdfU1NIDXsYVPH++1uHvItGgsGVH+L2a9qKE+bKQWQM6fodH
         dqzP7Cz9qW7QuBvRL0HDdMqiZEUQEHbOZ5TOl2n5bgtahnX3xIz3TlwIvS9PgQ3ldGfA
         QGvguyh+6Uh33yvEYwsn83eOfQoyROCgm1scpWFX9ZbOpNbbX5YVwzEeyAAJoVj73EDX
         Np7CXszQOH4pJYIwyJ+gJ3mKjKPRZllTuEBernOv8lIZLcKTnHBd2c1ebEbUHieLkSDa
         cjHw==
X-Gm-Message-State: AOAM533YtpMG6zEf2qu1zG/VHUk68Q6cK5LEzFSLi4MEWacALNvQyERb
        iKnbdAdvMT9fv8sNiN4mfLwd+Q==
X-Google-Smtp-Source: ABdhPJyPUMTPAlvbc5F9DgPZcTHH53XJriCxbWePpFu8+RK+GJP/zdnWVlnoJA0LQqWFmkayCjYz/g==
X-Received: by 2002:a37:9441:: with SMTP id w62mr2652751qkd.474.1604684545012;
        Fri, 06 Nov 2020 09:42:25 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id t65sm1006283qkc.52.2020.11.06.09.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 09:42:24 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kb5kl-000zVc-Ja; Fri, 06 Nov 2020 13:42:23 -0400
Date:   Fri, 6 Nov 2020 13:42:23 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Ira Weiny <iweiny@intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Don Dutile <ddutile@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: Re: [RFC PATCH 14/15] PCI/P2PDMA: Introduce pci_mmap_p2pmem()
Message-ID: <20201106174223.GU36674@ziepe.ca>
References: <20201106170036.18713-1-logang@deltatee.com>
 <20201106170036.18713-15-logang@deltatee.com>
 <20201106172206.GS36674@ziepe.ca>
 <b1e8dfce-d583-bed8-d04d-b7265a54c99f@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1e8dfce-d583-bed8-d04d-b7265a54c99f@deltatee.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 06, 2020 at 10:28:00AM -0700, Logan Gunthorpe wrote:
> 
> 
> On 2020-11-06 10:22 a.m., Jason Gunthorpe wrote:
> > On Fri, Nov 06, 2020 at 10:00:35AM -0700, Logan Gunthorpe wrote:
> >> Introduce pci_mmap_p2pmem() which is a helper to allocate and mmap
> >> a hunk of p2pmem into userspace.
> >>
> >> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> >>  drivers/pci/p2pdma.c       | 104 +++++++++++++++++++++++++++++++++++++
> >>  include/linux/pci-p2pdma.h |   6 +++
> >>  2 files changed, 110 insertions(+)
> >>
> >> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> >> index 9961e779f430..8eab53ac59ae 100644
> >> +++ b/drivers/pci/p2pdma.c
> >> @@ -16,6 +16,7 @@
> >>  #include <linux/genalloc.h>
> >>  #include <linux/memremap.h>
> >>  #include <linux/percpu-refcount.h>
> >> +#include <linux/pfn_t.h>
> >>  #include <linux/random.h>
> >>  #include <linux/seq_buf.h>
> >>  #include <linux/xarray.h>
> >> @@ -1055,3 +1056,106 @@ ssize_t pci_p2pdma_enable_show(char *page, struct pci_dev *p2p_dev,
> >>  	return sprintf(page, "%s\n", pci_name(p2p_dev));
> >>  }
> >>  EXPORT_SYMBOL_GPL(pci_p2pdma_enable_show);
> >> +
> >> +struct pci_p2pdma_map {
> >> +	struct kref ref;
> >> +	struct pci_dev *pdev;
> >> +	void *kaddr;
> >> +	size_t len;
> >> +};
> > 
> > Why have this at all? Nothing uses it and no vm_operations ops are
> > implemented?
> 
> It's necessary to free the allocated p2pmem when the mapping is torn down.

That's suspicious.. Once in a VMA the lifetime of the page must be
controlled by the page refcount, it can't be put back into the genpool
just because the vma was destroed.

Jason
