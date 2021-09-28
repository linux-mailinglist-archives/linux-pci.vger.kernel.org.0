Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE2DA41B75C
	for <lists+linux-pci@lfdr.de>; Tue, 28 Sep 2021 21:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242449AbhI1TTY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Sep 2021 15:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237134AbhI1TTX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Sep 2021 15:19:23 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF5F8C061745
        for <linux-pci@vger.kernel.org>; Tue, 28 Sep 2021 12:17:43 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id x9so45863qtv.0
        for <linux-pci@vger.kernel.org>; Tue, 28 Sep 2021 12:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7f1QZiONeDrfm8AhTnbc53U7HhkzQ840mRRtmUewnCI=;
        b=jv2OU4dRonKtBmDWObStEgucOWtPlJyqGW207XvuQpqOpfcn92InOEODzxDn3983J8
         NWUMSihLuwJkDTW1ES/IWD1pW4f1IgZWhUtRjvhMkDyUbQyYUzTcg2auWALiBpPMh6T5
         o6Y/op/SaG0z9lus3Le6nGPTcAsbC0wYw1OmeasBeOOIc0Unh8ixnfIYVGFTDQvdWUf7
         ejnTvxk5F1g8wMgxUrGGmpVnriP2WtOERNRAu+rKxEr8b83QkHsd4GVA2mxfZkrmQHOF
         YHUBTillHF8tNjol2rYAKfciv/4RCk/9bFro7e8E17vrA8nf9zNDkX9XT7E2zrdw+Kvq
         T7bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7f1QZiONeDrfm8AhTnbc53U7HhkzQ840mRRtmUewnCI=;
        b=FIfCwPDKfZOl7hBxS6LizqWU+SLlIEgmTyKZqFaR3lm6gYPXL7nZcMOyt5GGQtAecL
         xXvG8ml8Y9FAU09pQMlb/GPTwZEEGe3O/B+ncvctLmqQzEFryo3x4omklo8hpDXzbWXx
         aYzttHiRDuyTyMTd/TV8FYDEV2VGsa6dDaF2Nt9CNp0ESsFij13BVfr3sA+4hcC2thUe
         EFKlFJPhfeycvMp83p+UxzfhjlQDEELEBiDArBiyLYj6zTthJHVgy5+oaNh/lVE6F58l
         mmFuwFWa9X0BAqpvTJxVikNJzsLuLAaJ9WLT8v9Jnvgr0lQ8nM8LGmKAALedIDlOGMGA
         ykQQ==
X-Gm-Message-State: AOAM5303diTzOHtcwHiXOPMgoM8XcbYz00P28eT3gpH8NSNeRK0OB8Bx
        lQHmWvwJ9zd/cj7fAxfjdrXgZA==
X-Google-Smtp-Source: ABdhPJzuCBFM9bapdOvbnZSM2ycmiyqPK8ZUR9G41TIe6DE91xtbhVAs4nO11mNSn8qAAkRHmlWp7A==
X-Received: by 2002:ac8:7d4b:: with SMTP id h11mr7542407qtb.333.1632856663191;
        Tue, 28 Sep 2021 12:17:43 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id c6sm5387224qtx.72.2021.09.28.12.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 12:17:42 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mVIbl-007G4o-JW; Tue, 28 Sep 2021 16:17:41 -0300
Date:   Tue, 28 Sep 2021 16:17:41 -0300
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
        Robin Murphy <robin.murphy@arm.com>,
        Martin Oliveira <martin.oliveira@eideticom.com>,
        Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Subject: Re: [PATCH v3 11/20] RDMA/core: introduce
 ib_dma_pci_p2p_dma_supported()
Message-ID: <20210928191741.GQ3544071@ziepe.ca>
References: <20210916234100.122368-1-logang@deltatee.com>
 <20210916234100.122368-12-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210916234100.122368-12-logang@deltatee.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 16, 2021 at 05:40:51PM -0600, Logan Gunthorpe wrote:
> Introduce the helper function ib_dma_pci_p2p_dma_supported() to check
> if a given ib_device can be used in P2PDMA transfers. This ensures
> the ib_device is not using virt_dma and also that the underlying
> dma_device supports P2PDMA.
> 
> Use the new helper in nvme-rdma to replace the existing check for
> ib_uses_virt_dma(). Adding the dma_pci_p2pdma_supported() check allows
> switching away from pci_p2pdma_[un]map_sg().
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>  drivers/nvme/target/rdma.c |  2 +-
>  include/rdma/ib_verbs.h    | 11 +++++++++++
>  2 files changed, 12 insertions(+), 1 deletion(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

> +/*
> + * Check if a IB device's underlying DMA mapping supports P2PDMA transfers.
> + */
> +static inline bool ib_dma_pci_p2p_dma_supported(struct ib_device *dev)
> +{
> +	if (ib_uses_virt_dma(dev))
> +		return false;

If someone wants to make rxe/hfi/qib use this stuff then they will
have to teach the the driver to do all the p2p checks and add some
struct ib_device flag

Jason
