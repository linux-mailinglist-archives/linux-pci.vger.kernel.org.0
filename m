Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60F9627C260
	for <lists+linux-pci@lfdr.de>; Tue, 29 Sep 2020 12:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725765AbgI2K2n (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Sep 2020 06:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgI2K2n (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Sep 2020 06:28:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F34AAC061755;
        Tue, 29 Sep 2020 03:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l0kBC8YRNvld01DY4RExCgMbmM/vGes4CE9+2hc44no=; b=a/FmsuMr/HOzXM/Valc3PmTxXh
        LJWqSbOYMfqttmKrQnZIZaQa4kcMJRJHMhebpxEENVaUNArUlAPFeekW6iQwZNUmjiCgraeZFamIi
        NiwR/cbL2HUprKEYTj4gwQDZjbqvx0KRN6dnyQ3hHLDxQKaOZGkhtETyPoincwFwRKZKty8wctx85
        QzSMN5O5ErvNvZfL+ECEz5+wyFPohvQS9U8zq9oF5SD8rRalhAzgFnmuktLDmMSjiwlGDRoViq8oh
        MxKpM2XRHjzAIerhPVZvxyAOQk/FbVJbP3zhqsqmi10DNMVsSXH8GvkS/M7o1godzQQf6U8JYLKRu
        8WME3iKg==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kNCs5-0002f6-U5; Tue, 29 Sep 2020 10:28:34 +0000
Date:   Tue, 29 Sep 2020 11:28:33 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Sherry Sun <sherry.sun@nxp.com>
Cc:     hch@infradead.org, sudeep.dutt@intel.com, ashutosh.dixit@intel.com,
        arnd@arndb.de, gregkh@linuxfoundation.org, kishon@ti.com,
        lorenzo.pieralisi@arm.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-imx@nxp.com
Subject: Re: [PATCH V2 4/4] misc: vop: mapping kernel memory to user space as
 noncached
Message-ID: <20200929102833.GD7784@infradead.org>
References: <20200929084425.24052-1-sherry.sun@nxp.com>
 <20200929084425.24052-5-sherry.sun@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929084425.24052-5-sherry.sun@nxp.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 29, 2020 at 04:44:25PM +0800, Sherry Sun wrote:
> Mapping kernel space memory to user space as noncached, since user space
> need check the updates of avail_idx and device page flags timely.
> 
> Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> ---
>  drivers/misc/mic/vop/vop_vringh.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/mic/vop/vop_vringh.c b/drivers/misc/mic/vop/vop_vringh.c
> index 4d5feb39aeb7..6e193bd64ef1 100644
> --- a/drivers/misc/mic/vop/vop_vringh.c
> +++ b/drivers/misc/mic/vop/vop_vringh.c
> @@ -1057,7 +1057,7 @@ static int vop_mmap(struct file *f, struct vm_area_struct *vma)
>  		}
>  		err = remap_pfn_range(vma, vma->vm_start + offset,
>  				      pa >> PAGE_SHIFT, size,
> -				      vma->vm_page_prot);
> +				      pgprot_noncached(vma->vm_page_prot));

You can't call remap_pfn_range on memory returned from
dma_alloc_coherent (which btw is not marked uncached on many platforms).

You need to use the dma_mmap_coherent helper instead.  And this also
needs to go into the first patch.
