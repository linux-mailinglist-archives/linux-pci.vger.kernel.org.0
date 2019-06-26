Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5384E56950
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2019 14:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbfFZMg0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Jun 2019 08:36:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:59172 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726339AbfFZMg0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 26 Jun 2019 08:36:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A640BAD78;
        Wed, 26 Jun 2019 12:36:24 +0000 (UTC)
Date:   Wed, 26 Jun 2019 14:36:23 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH 06/25] mm: export alloc_pages_vma
Message-ID: <20190626123623.GU17798@dhcp22.suse.cz>
References: <20190626122724.13313-1-hch@lst.de>
 <20190626122724.13313-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626122724.13313-7-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed 26-06-19 14:27:05, Christoph Hellwig wrote:
> nouveau is currently using this through an odd hmm wrapper, and I plan
> to switch it to the real thing later in this series.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

> ---
>  mm/mempolicy.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 01600d80ae01..f48569aa1863 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -2098,6 +2098,7 @@ alloc_pages_vma(gfp_t gfp, int order, struct vm_area_struct *vma,
>  out:
>  	return page;
>  }
> +EXPORT_SYMBOL(alloc_pages_vma);
>  
>  /**
>   * 	alloc_pages_current - Allocate pages.
> -- 
> 2.20.1

-- 
Michal Hocko
SUSE Labs
