Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94F54296C09
	for <lists+linux-pci@lfdr.de>; Fri, 23 Oct 2020 11:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S461108AbgJWJZd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Oct 2020 05:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S461101AbgJWJZc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Oct 2020 05:25:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 398D1C0613CE;
        Fri, 23 Oct 2020 02:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bO9d4/8VddxQSew19V0MnlbQL7WrSOvaPC7e14MIGxc=; b=bMs3H12C0UD+AXbZSWgF2V+FVn
        H1GG0oimFk7AUhal9+QFfWnCEIThL0YThVnEKz+E3S3p5+vMAlZsdcogYCE3IaqSvXXCfzwDPYvct
        fjwVAb60LJehSk3xEe+okJz/qEUbqh846voXjVtSRiOlR9Qd74IxR7fnIFgUupCdfb1I+X9MRw0Rd
        3Rvgv8+v7QfPVUKqXE4NEw6CWWEfHX759MwJTy4dhk0gva5Vr7psMOaX/iD8+v6DZa2g8X0ZM0BFs
        wuj4jsgC/Trq0Cch7iqX7OIpZokrA+XiWUXM3gcCF/xq6YWijJbGIkPUfRplGdVseXUI1LmDnDz9s
        2fe089zw==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kVtK8-0007vB-4p; Fri, 23 Oct 2020 09:25:24 +0000
Date:   Fri, 23 Oct 2020 10:25:24 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Sherry Sun <sherry.sun@nxp.com>
Cc:     hch@infradead.org, sudeep.dutt@intel.com, ashutosh.dixit@intel.com,
        arnd@arndb.de, gregkh@linuxfoundation.org, kishon@ti.com,
        lorenzo.pieralisi@arm.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-imx@nxp.com
Subject: Re: [PATCH V3 1/4] misc: vop: change the way of allocating vring and
 device page
Message-ID: <20201023092524.GA29066@infradead.org>
References: <20201022050638.29641-1-sherry.sun@nxp.com>
 <20201022050638.29641-2-sherry.sun@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201022050638.29641-2-sherry.sun@nxp.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

>  static int mic_dp_init(struct mic_device *mdev)
>  {
> -	mdev->dp = kzalloc(MIC_DP_SIZE, GFP_KERNEL);
> +	mdev->dp = dma_alloc_coherent(&mdev->pdev->dev, MIC_DP_SIZE,
> +				      &mdev->dp_dma_addr, GFP_KERNEL);
>  	if (!mdev->dp)
>  		return -ENOMEM;
>  
> -	mdev->dp_dma_addr = mic_map_single(mdev,
> -		mdev->dp, MIC_DP_SIZE);
> -	if (mic_map_error(mdev->dp_dma_addr)) {
> -		kfree(mdev->dp);
> -		dev_err(&mdev->pdev->dev, "%s %d err %d\n",
> -			__func__, __LINE__, -ENOMEM);
> -		return -ENOMEM;
> -	}
>  	mdev->ops->write_spad(mdev, MIC_DPLO_SPAD, mdev->dp_dma_addr);
>  	mdev->ops->write_spad(mdev, MIC_DPHI_SPAD, mdev->dp_dma_addr >> 32);
>  	return 0;
> @@ -68,8 +62,7 @@ static int mic_dp_init(struct mic_device *mdev)
>  /* Uninitialize the device page */
>  static void mic_dp_uninit(struct mic_device *mdev)
>  {
> -	mic_unmap_single(mdev, mdev->dp_dma_addr, MIC_DP_SIZE);
> -	kfree(mdev->dp);
> +	dma_free_coherent(&mdev->pdev->dev, MIC_DP_SIZE, mdev->dp, mdev->dp_dma_addr);
>  }

This adds an over 80 char line.  Also please just kill mic_dp_init and
mic_dp_uninit and inline those into the callers.

> +		vvr->buf = dma_alloc_coherent(vop_dev(vdev), VOP_INT_DMA_BUF_SIZE,
> +					      &vvr->buf_da, GFP_KERNEL);

Another overly long line.

> @@ -1068,7 +1049,7 @@ vop_query_offset(struct vop_vdev *vdev, unsigned long offset,
>  		struct vop_vringh *vvr = &vdev->vvr[i];
>  
>  		if (offset == start) {
> -			*pa = virt_to_phys(vvr->vring.va);
> +			*pa = vqconfig[i].address;

vqconfig[i].address is a __le64, so this needs an endian swap.

But more importantly the caller of vop_query_offset, vop_mmap, uses
remap_pfn_range and pa.  You cannot mix remap_pfn_range with DMA
coherent allocations, it can only be mmaped using dma_mmap_coherent.
