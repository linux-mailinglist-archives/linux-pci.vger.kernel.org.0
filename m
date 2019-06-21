Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6814E9B1
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jun 2019 15:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726052AbfFUNnh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Jun 2019 09:43:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:49562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725985AbfFUNng (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 21 Jun 2019 09:43:36 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31387206B7;
        Fri, 21 Jun 2019 13:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561124615;
        bh=j7CrSlfQAmRQGesg3mqy/vLQAoSNzS1OohkNwYrKLXM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fZcpYdKLbdodX/fGQwJ3O5sT84JfuexstDzFvbQ1a9rlx6xwFxEA7EACKzuwY+iu8
         NUjmeZgGcTiSn3xNRjqMNiXG/jbF96btkM5PTzeUKhXS+H/veJaA47U6ETYYTus0mA
         sdnKlp14BpLpis+dOlOnATjrl4PpN9Et6X1S8MeU=
Date:   Fri, 21 Jun 2019 08:43:32 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     xuwei5@huawei.com, linuxarm@huawei.com, arm@kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        joe@perches.com
Subject: Re: [PATCH 1/5] lib: logic_pio: Fix RCU usage
Message-ID: <20190621134332.GC82584@google.com>
References: <1561026716-140537-1-git-send-email-john.garry@huawei.com>
 <1561026716-140537-2-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1561026716-140537-2-git-send-email-john.garry@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 20, 2019 at 06:31:52PM +0800, John Garry wrote:
> The traversing of io_range_list with list_for_each_entry_rcu()
> is not properly protected by rcu_read_lock(), so add it.
> 
> In addition, the list traversing used in logic_pio_register_range()
> does not need to use the rcu variant.

Not being an RCU expert myself, a few words here about why one path
needs protection but the other doesn't would be helpful.  This
basically restates what the patch *does*, which is obvious from the
diff, but not *why*.

> Fixes: 031e3601869c ("lib: Add generic PIO mapping method")
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>  lib/logic_pio.c | 49 +++++++++++++++++++++++++++++++++++--------------
>  1 file changed, 35 insertions(+), 14 deletions(-)
> 
> diff --git a/lib/logic_pio.c b/lib/logic_pio.c
> index feea48fd1a0d..761296376fbc 100644
> --- a/lib/logic_pio.c
> +++ b/lib/logic_pio.c
> @@ -46,7 +46,7 @@ int logic_pio_register_range(struct logic_pio_hwaddr *new_range)
>  	end = new_range->hw_start + new_range->size;
>  
>  	mutex_lock(&io_range_mutex);
> -	list_for_each_entry_rcu(range, &io_range_list, list) {
> +	list_for_each_entry(range, &io_range_list, list) {
>  		if (range->fwnode == new_range->fwnode) {
>  			/* range already there */
>  			goto end_register;
> @@ -108,26 +108,38 @@ int logic_pio_register_range(struct logic_pio_hwaddr *new_range)
>   */
>  struct logic_pio_hwaddr *find_io_range_by_fwnode(struct fwnode_handle *fwnode)
>  {
> -	struct logic_pio_hwaddr *range;
> +	struct logic_pio_hwaddr *range, *found_range = NULL;
>  
> +	rcu_read_lock();
>  	list_for_each_entry_rcu(range, &io_range_list, list) {
> -		if (range->fwnode == fwnode)
> -			return range;
> +		if (range->fwnode == fwnode) {
> +			found_range = range;
> +			break;
> +		}
>  	}
> -	return NULL;
> +	rcu_read_unlock();
> +
> +	return found_range;
>  }
>  
>  /* Return a registered range given an input PIO token */
>  static struct logic_pio_hwaddr *find_io_range(unsigned long pio)
>  {
> -	struct logic_pio_hwaddr *range;
> +	struct logic_pio_hwaddr *range, *found_range = NULL;
>  
> +	rcu_read_lock();
>  	list_for_each_entry_rcu(range, &io_range_list, list) {
> -		if (in_range(pio, range->io_start, range->size))
> -			return range;
> +		if (in_range(pio, range->io_start, range->size)) {
> +			found_range = range;
> +			break;
> +		}
>  	}
> -	pr_err("PIO entry token %lx invalid\n", pio);
> -	return NULL;
> +	rcu_read_unlock();
> +
> +	if (!found_range)
> +		pr_err("PIO entry token 0x%lx invalid\n", pio);
> +
> +	return found_range;
>  }
>  
>  /**
> @@ -180,14 +192,23 @@ unsigned long logic_pio_trans_cpuaddr(resource_size_t addr)
>  {
>  	struct logic_pio_hwaddr *range;
>  
> +	rcu_read_lock();
>  	list_for_each_entry_rcu(range, &io_range_list, list) {
>  		if (range->flags != LOGIC_PIO_CPU_MMIO)
>  			continue;
> -		if (in_range(addr, range->hw_start, range->size))
> -			return addr - range->hw_start + range->io_start;
> +		if (in_range(addr, range->hw_start, range->size)) {
> +			unsigned long cpuaddr;
> +
> +			cpuaddr = addr - range->hw_start + range->io_start;
> +
> +			rcu_read_unlock();
> +			return cpuaddr;
> +		}
>  	}
> -	pr_err("addr %llx not registered in io_range_list\n",
> -	       (unsigned long long) addr);
> +	rcu_read_unlock();
> +
> +	pr_err("addr %pa not registered in io_range_list\n", &addr);
> +
>  	return ~0UL;
>  }
>  
> -- 
> 2.17.1
> 
