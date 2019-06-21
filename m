Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9F404E9DF
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jun 2019 15:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbfFUNt6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Jun 2019 09:49:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:54406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725975AbfFUNt6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 21 Jun 2019 09:49:58 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84291206B7;
        Fri, 21 Jun 2019 13:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561124996;
        bh=TYSsT51Xz3GeDF4sZAlGlEM3XXEHsXXsXEk0JEKHfMY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0apCicMFLRhawaH+9AaFoZi+UlfNHqhejuMSpVDTL7PEBOwnCU/dvxoigoP5eCavq
         bOoGxoMtBSwSiDL26czZdBo8TJBMSCHiB+u1Ye1n1z7TCX+Q+9cgiQgXIBNyPQs2+d
         Gjjp0f07GCckoDTwbmR5b8o06nB5BGxB8K2uvSvA=
Date:   Fri, 21 Jun 2019 08:49:55 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     xuwei5@huawei.com, linuxarm@huawei.com, arm@kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        joe@perches.com
Subject: Re: [PATCH 2/5] lib: logic_pio: Add logic_pio_unregister_range()
Message-ID: <20190621134955.GD82584@google.com>
References: <1561026716-140537-1-git-send-email-john.garry@huawei.com>
 <1561026716-140537-3-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1561026716-140537-3-git-send-email-john.garry@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 20, 2019 at 06:31:53PM +0800, John Garry wrote:
> Add a function to unregister a logical PIO range.
> 
> The method used to allocate LOGIC_PIO_CPU_MMIO regions during registration
> is slightly modified to ensure that we get no overlap when regions are
> unregistered. This is needed because the allocation scheme assumed that no
> regions are ever unregistered.
> 
> Logical PIO space can still be leaked when unregistering certain
> LOGIC_PIO_CPU_MMIO regions, but this acceptable for now since there are no
> callers to unregister LOGIC_PIO_CPU_MMIO regions, and the logical PIO
> region allocation scheme would need significant work to improve this.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>  include/linux/logic_pio.h |  1 +
>  lib/logic_pio.c           | 16 +++++++++++++++-
>  2 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/logic_pio.h b/include/linux/logic_pio.h
> index cbd9d8495690..88e1e6304a71 100644
> --- a/include/linux/logic_pio.h
> +++ b/include/linux/logic_pio.h
> @@ -117,6 +117,7 @@ struct logic_pio_hwaddr *find_io_range_by_fwnode(struct fwnode_handle *fwnode);
>  unsigned long logic_pio_trans_hwaddr(struct fwnode_handle *fwnode,
>  			resource_size_t hw_addr, resource_size_t size);
>  int logic_pio_register_range(struct logic_pio_hwaddr *newrange);
> +void logic_pio_unregister_range(struct logic_pio_hwaddr *range);
>  resource_size_t logic_pio_to_hwaddr(unsigned long pio);
>  unsigned long logic_pio_trans_cpuaddr(resource_size_t hw_addr);
>  
> diff --git a/lib/logic_pio.c b/lib/logic_pio.c
> index 761296376fbc..45eb57af2574 100644
> --- a/lib/logic_pio.c
> +++ b/lib/logic_pio.c
> @@ -56,7 +56,7 @@ int logic_pio_register_range(struct logic_pio_hwaddr *new_range)
>  			/* for MMIO ranges we need to check for overlap */
>  			if (start >= range->hw_start + range->size ||
>  			    end < range->hw_start) {
> -				mmio_sz += range->size;
> +				mmio_sz = range->io_start + range->size;

Should this be renamed to something like "mmio_end"?  Computing a
"size" as "start + size" looks wrong at first glance.  The code overall
probably makes sense, but maybe breaking this out as a separate "avoid
overlaps" patch that renames "mmio_sz" might make it clearer.

>  			} else {
>  				ret = -EFAULT;
>  				goto end_register;
> @@ -98,6 +98,20 @@ int logic_pio_register_range(struct logic_pio_hwaddr *new_range)
>  	return ret;
>  }
>  
> +/**
> + * logic_pio_unregister_range - unregister logical PIO range for a host
> + * @range: pointer to the IO range which has been already registered.
> + *
> + * Unregister a previously-registered IO range node.
> + */
> +void logic_pio_unregister_range(struct logic_pio_hwaddr *range)
> +{
> +	mutex_lock(&io_range_mutex);
> +	list_del_rcu(&range->list);
> +	mutex_unlock(&io_range_mutex);
> +	synchronize_rcu();
> +}
> +
>  /**
>   * find_io_range_by_fwnode - find logical PIO range for given FW node
>   * @fwnode: FW node handle associated with logical PIO range
> -- 
> 2.17.1
> 
