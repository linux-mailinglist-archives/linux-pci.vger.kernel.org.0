Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF6436CBD7
	for <lists+linux-pci@lfdr.de>; Tue, 27 Apr 2021 21:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238142AbhD0ToZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Apr 2021 15:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236459AbhD0ToX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Apr 2021 15:44:23 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C57B0C061760
        for <linux-pci@vger.kernel.org>; Tue, 27 Apr 2021 12:43:39 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id x14so6309505qvr.5
        for <linux-pci@vger.kernel.org>; Tue, 27 Apr 2021 12:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pMOFBLR9bPrFoZFV8TQo6qdI8xIDUT5QowoTJPAfwoI=;
        b=M20T+1aMae4u0P7fbin4a8R02TMD5t96H2aiOMf8qw2rTRAo2RugFe0ku6l9VPeevP
         xZtgBQRLaSsu9aYFKNdNDSiFe3aolwh10xjABQqThOUIndi0+s4d+Eo1XLPCXC3nfxUm
         lD1alvOMjEL0+ef6cYE7iSz2VLoq5w2e7VmYnhskgoJag9ZejVAXw548Sw3tJzTwQ1LK
         Hq28R0ucjVcFeEwJijDgtLouLoL1kPblKx+vhiQSapRdIiXAHGIAof9xt+quTVbA5Swo
         WJ9Cx6H5u7fywz1Osz6ow6XWlpeS1lNkpzj+0hZhr2dKqs99inl2pJxQ1Z2SVZi0WDJl
         pNzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pMOFBLR9bPrFoZFV8TQo6qdI8xIDUT5QowoTJPAfwoI=;
        b=ObKUgjEw0lLavfbIZtN4bnN7ew5kSnd20qR+Te6F5rwnNBESTP9LV6f7G0V4lwgu6K
         J5r/Nn5eYGUXO4nLt3upK3ap8+O47uOvSpyvzo+31EVBd7k1HD+4LinvOM60mxV389mD
         /Ukd21w3KPWojR3zSBDPq2QWqYsit/cahWGHhptrIdKDh8i2/SJ3fzqkDVTCScBvIMFk
         scIWhqCbYgaoOxNch1g8MBmwHl6OwSJ+tKeLe3jLCqDg9oTBnCuQsgDGJefPPPBlYW8J
         0WYluHdZQWsBlBrUDlDAU5a1ZH5D0SUPCO6osHFO8LXC0uh8tAUBK6U4EXRTUCfEgOeP
         7k4A==
X-Gm-Message-State: AOAM532fBSnoTvgB/c6vXAjRmzTz0j+EHGUb4ApT49O0KEA22bV1vpQy
        XbIRjrfwWjtPk0Rvv1OcYSJU7A==
X-Google-Smtp-Source: ABdhPJzaHrq9X7iYnbBeG48woUZiUTHE+b/d9aEc9zMuai3hrX463cNK4Akxfstc2Wbz1Cy4s9UnAQ==
X-Received: by 2002:a0c:e8c4:: with SMTP id m4mr2551153qvo.21.1619552619024;
        Tue, 27 Apr 2021 12:43:39 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id y26sm688104qtf.66.2021.04.27.12.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 12:43:38 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1lbTcP-00Dh5j-HM; Tue, 27 Apr 2021 16:43:37 -0300
Date:   Tue, 27 Apr 2021 16:43:37 -0300
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
Subject: Re: [PATCH 11/16] iommu/dma: Support PCI P2PDMA pages in dma-iommu
 map_sg
Message-ID: <20210427194337.GT2047089@ziepe.ca>
References: <20210408170123.8788-1-logang@deltatee.com>
 <20210408170123.8788-12-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210408170123.8788-12-logang@deltatee.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 08, 2021 at 11:01:18AM -0600, Logan Gunthorpe wrote:
> When a PCI P2PDMA page is seen, set the IOVA length of the segment
> to zero so that it is not mapped into the IOVA. Then, in finalise_sg(),
> apply the appropriate bus address to the segment. The IOVA is not
> created if the scatterlist only consists of P2PDMA pages.

I expect P2P to work with systems that use ATS, so we'd want to see
those systems have the IOMMU programmed with the bus address.

Is it OK like this because the other logic prohibits all PCI cases
that would lean on the IOMMU, like ATS, hairpinning through the root
port, or transiting the root complex?

If yes, the code deserves a big comment explaining this is incomplete,
and I'd want to know we can finish this to include ATS at least based
on this series.

Jason
