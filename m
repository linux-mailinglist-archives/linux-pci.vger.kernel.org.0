Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE67C41B7B6
	for <lists+linux-pci@lfdr.de>; Tue, 28 Sep 2021 21:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242550AbhI1Tp2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Sep 2021 15:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242470AbhI1Tp2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Sep 2021 15:45:28 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9A26C061745
        for <linux-pci@vger.kernel.org>; Tue, 28 Sep 2021 12:43:48 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id b78so99049iof.2
        for <linux-pci@vger.kernel.org>; Tue, 28 Sep 2021 12:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KMNjWRPS+Q/mkVMPwwRkvOHehmG3YaypC9IFrB3ZJ9Y=;
        b=ZaQqv4m808BuxDtGeChZCPzv4c52NMfLQHqoImEoIEMRktgEpidQ0ZAlaBzLiOgw2y
         4l7Us3OLiVksCSNisKnyEb1D4P1RyMjFLOa8HY/XMbPST1a9XRronsuCK46GdHIoKvOQ
         rVc1XwfKxHSsXcs4HW1yvQf7l+k9oqiRzK1FppsrZ71WeRxwfhW2epLKyirhoD9pZcR+
         9N3kupzPvhNrqC2t4nGZ1pxzZaEA8+UhDCVzAe12EQrq909NaIgptNCZerW6CzU7kfEF
         kpwTu4O75rJ2ShP1PWF7I9mYl3Pu9O8QL99v+c/gI+XAsb1bLcUON8byaZpmO5mXC6R5
         uPjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KMNjWRPS+Q/mkVMPwwRkvOHehmG3YaypC9IFrB3ZJ9Y=;
        b=BzFOHEYzHLIeQLTtac4UrXU1FqevDxOkOvJG0n2JvTdoloaHu3t2Tt/Sc8dpinu58L
         IHjeGeDe5rKJ9pIDOLO0+l6J30usywdRKRw05/dGmj0fCXa7u7wC78Rm78WNTsihiaNX
         xrcUTLpVfRKFDgUq+2FlIUrPKRgqo9KZV+CM7SqsCxZJhFdzWGyux3O1ZunWlx0IzS2B
         Eiy1cCzYNNTuGs1cb/ZIwq3GD/DtCy9OyATUwE1nEqq6cdW18xnAyTdh0Rg3RS3s8tu6
         BGMIDDYKxUF4dpjg5BoeTMxZiFJszWGkixJer8yVABh2eOpRKiwmE731MncEqOhf7AmD
         mQiQ==
X-Gm-Message-State: AOAM531wXj6wtn+Koii2u+ciimxBmuROy8Xz1XnJDu7mzKLzJL2fMT4C
        GKdo+LdwtoYx2FO6tEgK7FR2KQ==
X-Google-Smtp-Source: ABdhPJxmxz+0kmlqXJtf+sZu5nJ5PkoIQJaS8/KyXSBNASkg5OkMz+upj0MvOj1bWgx5qCPm07nk2g==
X-Received: by 2002:a6b:8f47:: with SMTP id r68mr5097857iod.18.1632858228189;
        Tue, 28 Sep 2021 12:43:48 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id l1sm11703946ilc.65.2021.09.28.12.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 12:43:47 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mVJ10-007GXo-Qu; Tue, 28 Sep 2021 16:43:46 -0300
Date:   Tue, 28 Sep 2021 16:43:46 -0300
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
Subject: Re: [PATCH v3 13/20] PCI/P2PDMA: remove pci_p2pdma_[un]map_sg()
Message-ID: <20210928194346.GT3544071@ziepe.ca>
References: <20210916234100.122368-1-logang@deltatee.com>
 <20210916234100.122368-14-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210916234100.122368-14-logang@deltatee.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 16, 2021 at 05:40:53PM -0600, Logan Gunthorpe wrote:
> This interface is superseded by support in dma_map_sg() which now supports
> heterogeneous scatterlists. There are no longer any users, so remove it.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>  drivers/pci/p2pdma.c       | 65 --------------------------------------
>  include/linux/pci-p2pdma.h | 27 ----------------
>  2 files changed, 92 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Good riddance :)

Jason
