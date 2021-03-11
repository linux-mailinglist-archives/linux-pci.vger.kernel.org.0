Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0EFC3381FF
	for <lists+linux-pci@lfdr.de>; Fri, 12 Mar 2021 01:00:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbhCLAAX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Mar 2021 19:00:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbhCKX7r (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Mar 2021 18:59:47 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C45A2C061574
        for <linux-pci@vger.kernel.org>; Thu, 11 Mar 2021 15:59:46 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id 6so2548896qty.3
        for <linux-pci@vger.kernel.org>; Thu, 11 Mar 2021 15:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9rzGlCXRuAYzD4FxF8/kX8t+sLM/xQ6RjW+kfB9MHUI=;
        b=Sht35sRAWhjUnG/vlACxlUdN1NXxZ2hn78xSNsQrOQiOnK1nALUmlUGHUAK1T+DYhZ
         MX3lwQI/UxwTrkQv8d3kMYROr1PLyoiqVafUPMi7P056ufFmL/tRZlvShlZxbmxqDyNW
         NLKw5iBy24OxHbW+DCJ1DQJfzdSe8iTc3c8sHbtF9tFwbdZcos5KLgrKfPlUhIrDUvII
         vIew7klGAO8Wn/28Da6K3YhKEWpKl3Z8yXO4c0K2hvWjTBIXhDYwZP0hefzSiur217jB
         Lo+rOwqj5lF4a/tIzhlWfi67C2vz4vtRgSFudHgU/4CmiKi4zEw8bQzulGoxFckdnomp
         ZbNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9rzGlCXRuAYzD4FxF8/kX8t+sLM/xQ6RjW+kfB9MHUI=;
        b=Y/qkgo6fic0DYyQ8jOHkPIVrEtEkG2jEaEUVuHjL2gYRwIHxwo3+gBdLjNrZKxrzHc
         sg6f/fYm0C1i19O7yfh88YZDvzloi8mdgYBvZXCK7QfD/Pt3oxxBd783Xm5ssaFgkwIq
         qaR/MyRkpCifukk3PBlJVCic468UywgUTsfqkGpYFIqGbKdFjztKR80k84vmhJ9VhGEG
         MBpLut0HErtGItsE1GF+qDCKjNlTVKxGLEtFvKeTGdAU0t5hBDfbtk/N6fGCevHo1P2r
         2zJq8T7RZPv3KyhQJEK2hz2luaFOBGMTjSSs1+7EGoM5WaUkgf9D0aqSXpFTuDrOx/Uq
         LIDQ==
X-Gm-Message-State: AOAM532GqVnqdu3J55YB3UVFwWXEgrCv6n5dIwoPebbiOept11aLbTuJ
        2VknJ6yZ+3pc+sfID+O6aXctmQ==
X-Google-Smtp-Source: ABdhPJxiCSaM0aAia7Gh2ystvnvxFkgXLtQu1szm+rOtvCsRMIOPRh5BDiwH0XxEbvHajGL8eIa3Yg==
X-Received: by 2002:aed:20cd:: with SMTP id 71mr9996620qtb.346.1615507185328;
        Thu, 11 Mar 2021 15:59:45 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id z89sm2953405qtd.5.2021.03.11.15.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 15:59:44 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1lKVDT-00BbRW-RG; Thu, 11 Mar 2021 19:59:43 -0400
Date:   Thu, 11 Mar 2021 19:59:43 -0400
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
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jakowski Andrzej <andrzej.jakowski@intel.com>,
        Minturn Dave B <dave.b.minturn@intel.com>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Xiong Jianxin <jianxin.xiong@intel.com>
Subject: Re: [RFC PATCH v2 11/11] nvme-pci: Convert to using dma_map_sg for
 p2pdma pages
Message-ID: <20210311235943.GB2710221@ziepe.ca>
References: <20210311233142.7900-1-logang@deltatee.com>
 <20210311233142.7900-12-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210311233142.7900-12-logang@deltatee.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 11, 2021 at 04:31:41PM -0700, Logan Gunthorpe wrote:
> Convert to using dma_[un]map_sg() for PCI p2pdma pages.
> 
> This should be equivalent, though support will be somewhat less
> (only dma-direct and dma-iommu are currently supported).
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>  drivers/nvme/host/pci.c | 27 +++++++--------------------
>  1 file changed, 7 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 7d40c6a9e58e..89ca5acf7a62 100644
> +++ b/drivers/nvme/host/pci.c
> @@ -577,17 +577,6 @@ static void nvme_free_sgls(struct nvme_dev *dev, struct request *req)
>  
>  }
>  
> -static void nvme_unmap_sg(struct nvme_dev *dev, struct request *req)
> -{
> -	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
> -
> -	if (is_pci_p2pdma_page(sg_page(iod->sg)))
> -		pci_p2pdma_unmap_sg(dev->dev, iod->sg, iod->nents,
> -				    rq_dma_dir(req));
> -	else
> -		dma_unmap_sg(dev->dev, iod->sg, iod->nents, rq_dma_dir(req));
> -}

Can the two other places with this code pattern be changed too?

Jason
