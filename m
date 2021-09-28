Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1F341B74E
	for <lists+linux-pci@lfdr.de>; Tue, 28 Sep 2021 21:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242358AbhI1TR3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Sep 2021 15:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240547AbhI1TR3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Sep 2021 15:17:29 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E6FC061745
        for <linux-pci@vger.kernel.org>; Tue, 28 Sep 2021 12:15:49 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id gs10so14097615qvb.13
        for <linux-pci@vger.kernel.org>; Tue, 28 Sep 2021 12:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tcyMivDSSj98xjcYfl0Ss83FFw70+B/UboxWuutjjDI=;
        b=ZXqOBoW2zcRY/XCsYnDKUJm0jeVb6g6QynSlK5Ml/gYsHIPYVyWznW28IH/m39nrRs
         rG+j+z/VkkqSaLLAsjs0lqXyt+KgS2pwIFFxGvKOTpp6OskwVnUll7c0SZ88LW5r3udd
         0x2by8/0zgW10HXmR0atwW5ZveJ3LbAJ7dsEEUr2Gu8vBnEg7aKaIp30t+n3dbCJEhXZ
         2aFI7yDiqqERTNEfaySqTNHIuhyRB286ED8KYrDS7lbzOda3vmUboyfsyK3esMfGV4a8
         lPty5Chcgd6dyRXlzNl6IVGzK8Mh2KFiv4dYejeXY92N3QfzHRKzIOavZpEbU+UISfzK
         CNNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tcyMivDSSj98xjcYfl0Ss83FFw70+B/UboxWuutjjDI=;
        b=GbMzLftI6pSsGcnU7ims2cbd2+b4NLtlEdGehfkuvLq9aLYc4ja2CVvSJPgSMSd7hc
         agt8wpGkTEo1uwsyDz7y6ZA88gF2w3D0iu4u9ZCuF+DnafXZnhPejNzkC6537Cm9Q2Bu
         P0JJ5KWBqwCUOGrjQa9en9vLDdX24YkqWFBMVvWcnI3UsLrPAgdQTc1Ku+SekQmE1eXW
         ezKkhI9QDeF0vllHHyrGaIEcI8KBDH2zykaN0TjTTAXjajyy79GD5xjypAyQ4Q8KLXwV
         JeXFKO/ozKJ0Ri54DC17+fLrQTJ9f6bEMBnG2QPkqXT1wvNbluowNBfmj+KgmY0juvYi
         7Vmg==
X-Gm-Message-State: AOAM533e0uzf2XQ6jkVhZJOrUaRgO144lSAc62POy4E+fVKz8kl2onZ6
        ++82wP5i2jEycJp0t2HaehBkP4aZ28cfdA==
X-Google-Smtp-Source: ABdhPJwurJl1S4rZ2pOn1DTdiP6TavgJzB4eTygZmyEB+s55pljNt5t0RfW6XCRuHe8/1mcYm0z9gQ==
X-Received: by 2002:a0c:dd92:: with SMTP id v18mr7551030qvk.41.1632856548504;
        Tue, 28 Sep 2021 12:15:48 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id p9sm6469qkm.23.2021.09.28.12.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 12:15:48 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mVIZv-007G30-3V; Tue, 28 Sep 2021 16:15:47 -0300
Date:   Tue, 28 Sep 2021 16:15:47 -0300
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
Subject: Re: [PATCH v3 08/20] iommu/dma: support PCI P2PDMA pages in
 dma-iommu map_sg
Message-ID: <20210928191547.GP3544071@ziepe.ca>
References: <20210916234100.122368-1-logang@deltatee.com>
 <20210916234100.122368-9-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210916234100.122368-9-logang@deltatee.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 16, 2021 at 05:40:48PM -0600, Logan Gunthorpe wrote:
> When a PCI P2PDMA page is seen, set the IOVA length of the segment
> to zero so that it is not mapped into the IOVA. Then, in finalise_sg(),
> apply the appropriate bus address to the segment. The IOVA is not
> created if the scatterlist only consists of P2PDMA pages.
> 
> A P2PDMA page may have three possible outcomes when being mapped:
>   1) If the data path between the two devices doesn't go through
>      the root port, then it should be mapped with a PCI bus address
>   2) If the data path goes through the host bridge, it should be mapped
>      normally with an IOMMU IOVA.
>   3) It is not possible for the two devices to communicate and thus
>      the mapping operation should fail (and it will return -EREMOTEIO).
> 
> Similar to dma-direct, the sg_dma_mark_pci_p2pdma() flag is used to
> indicate bus address segments. On unmap, P2PDMA segments are skipped
> over when determining the start and end IOVA addresses.
> 
> With this change, the flags variable in the dma_map_ops is set to
> DMA_F_PCI_P2PDMA_SUPPORTED to indicate support for P2PDMA pages.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>  drivers/iommu/dma-iommu.c | 68 +++++++++++++++++++++++++++++++++++----
>  1 file changed, 61 insertions(+), 7 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
