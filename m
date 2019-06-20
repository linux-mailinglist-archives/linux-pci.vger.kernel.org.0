Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B33544DA47
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jun 2019 21:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbfFTTgW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Jun 2019 15:36:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:37314 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726169AbfFTTgV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 20 Jun 2019 15:36:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A71FAAEEC;
        Thu, 20 Jun 2019 19:36:20 +0000 (UTC)
Date:   Thu, 20 Jun 2019 21:36:19 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/22] mm: don't clear ->mapping in hmm_devmem_free
Message-ID: <20190620193619.GK12083@dhcp22.suse.cz>
References: <20190613094326.24093-1-hch@lst.de>
 <20190613094326.24093-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190613094326.24093-5-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu 13-06-19 11:43:07, Christoph Hellwig wrote:
> ->mapping isn't even used by HMM users, and the field at the same offset
> in the zone_device part of the union is declared as pad.  (Which btw is
> rather confusing, as DAX uses ->pgmap and ->mapping from two different
> sides of the union, but DAX doesn't use hmm_devmem_free).
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

I cannot really judge here but setting mapping here without any comment
is quite confusing. So if this is safe to remove then it is certainly an
improvement.

> ---
>  mm/hmm.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/mm/hmm.c b/mm/hmm.c
> index 0c62426d1257..e1dc98407e7b 100644
> --- a/mm/hmm.c
> +++ b/mm/hmm.c
> @@ -1347,8 +1347,6 @@ static void hmm_devmem_free(struct page *page, void *data)
>  {
>  	struct hmm_devmem *devmem = data;
>  
> -	page->mapping = NULL;
> -
>  	devmem->ops->free(devmem, page);
>  }
>  
> -- 
> 2.20.1

-- 
Michal Hocko
SUSE Labs
