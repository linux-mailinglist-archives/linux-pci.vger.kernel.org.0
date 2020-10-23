Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42CB5296C1C
	for <lists+linux-pci@lfdr.de>; Fri, 23 Oct 2020 11:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S461416AbgJWJ2q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Oct 2020 05:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S461352AbgJWJ2p (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Oct 2020 05:28:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C92D8C0613D2;
        Fri, 23 Oct 2020 02:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RcZrg5iTgx39CCWiF4Bw7KGnw7RxQPUoisl8ivnmDYE=; b=I2GKRjc6IMwaK/325KY4bThf39
        FK5f9dLxCcXsHHMmAtC++skmbDZDIuDiGQQEw+GiRPWHNID/+B/kqlnHa1LlTEvy+dldBzlvaiOJc
        qzyaFybkJesvpDfMRtTD0nO9A53dSwQKfhy7MvSdUteHC+Noe8LOQCWRW6kI1AiqZh/PC4YZih9AS
        sqsuLJQCNOgPWqy0IbN8rZpC/eZF8xBDCQDKpvinA+FWyrUwxea3FVACU/Fqq7Wv3zjAQQRgOI5D0
        YlGbmzRVZTpkvild7leSBSGEFFuA/Xh6BtVAhLH0yeov6lK78GFzlg5rsInXm0E5GYwqCXt+jz60R
        dc5QAnuA==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kVtNG-000868-1j; Fri, 23 Oct 2020 09:28:38 +0000
Date:   Fri, 23 Oct 2020 10:28:37 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Sherry Sun <sherry.sun@nxp.com>
Cc:     hch@infradead.org, sudeep.dutt@intel.com, ashutosh.dixit@intel.com,
        arnd@arndb.de, gregkh@linuxfoundation.org, kishon@ti.com,
        lorenzo.pieralisi@arm.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-imx@nxp.com
Subject: Re: [PATCH V3 4/4] misc: vop: mapping kernel memory to user space as
 noncached
Message-ID: <20201023092837.GC29066@infradead.org>
References: <20201022050638.29641-1-sherry.sun@nxp.com>
 <20201022050638.29641-5-sherry.sun@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201022050638.29641-5-sherry.sun@nxp.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 22, 2020 at 01:06:38PM +0800, Sherry Sun wrote:
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
> index b5612183dcb8..b75c2b713a3b 100644
> --- a/drivers/misc/mic/vop/vop_vringh.c
> +++ b/drivers/misc/mic/vop/vop_vringh.c
> @@ -1058,7 +1058,7 @@ static int vop_mmap(struct file *f, struct vm_area_struct *vma)
>  		}
>  		err = remap_pfn_range(vma, vma->vm_start + offset,
>  				      pa >> PAGE_SHIFT, size,
> -				      vma->vm_page_prot);
> +				      pgprot_noncached(vma->vm_page_prot));

Again, memory allocated using dma_alloc_coherent can only be mapped
using dma_mmap_coherent, which will use the right attributes for the
mapping, which often are cached.
