Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00D321347B
	for <lists+linux-pci@lfdr.de>; Fri,  3 May 2019 22:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbfECUs4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 May 2019 16:48:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:37224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726304AbfECUs4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 3 May 2019 16:48:56 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4180206E0;
        Fri,  3 May 2019 20:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556916535;
        bh=gdtFp7aoPyJfOJpVNUw+9lIri9+LDRR06YYdBQlCGv8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gcDbNnGYI4UvbBWeG5SuWl+5hlrkeKsTDzTY94diElbiBo3K9hR9TQrfzKrX4ChQn
         hoFrgh3KQaB96FZsGgNou+xa/hO8K8ad+ct3YWoV5mnkVAAEk0g8O3zF+Ip27gVgZs
         EGGuA25XU+RxD/5YmtYiQf09zuekV+NEJavtG6Lw=
Date:   Fri, 3 May 2019 15:48:52 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Frederick Lawler <fred@fredlawl.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        mika.westerberg@linux.intel.com, lukas@wunner.de,
        andriy.shevchenko@linux.intel.com, keith.busch@intel.com,
        mr.nuke.me@gmail.com, liudongdong3@huawei.com, thesven73@gmail.com
Subject: Re: [PATCH v2 7/9] PCI: hotplug: Prefer CONFIG_DYNAMIC_DEBUG/DEBUG
 for dmesg logs
Message-ID: <20190503204852.GE180403@google.com>
References: <20190503035946.23608-1-fred@fredlawl.com>
 <20190503035946.23608-8-fred@fredlawl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190503035946.23608-8-fred@fredlawl.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 02, 2019 at 10:59:44PM -0500, Frederick Lawler wrote:
> dbg() and ctrl_dbg() requires pciehp_debug module parameter to be set
> for debug log purposes. There are niche situations in pciehp_hpc.c where
> pciehp_debug is used: dbg_ctrl(), and pci_bus_check_dev().
> 
> Enabling CONFIG_DYNAMIC_DEBUG/DEBUG is well known for logging debug
> information. Therefore, prefer pr/pci_dbg() for debug information, and
> reserve pciehp_debug for niche situations.

I guess by "niche situations", you mean the tests in
pci_bus_check_dev() and dbg_ctrl()?

I think pci_bus_check_dev() could skip the test and just use pr_dbg().
For dbg_ctrl(), we could just remove the test (and maybe reformat
those strings so they match other messages).  That's a one-time thing
so I don't think two extra config reads that we might not print are a
problem.

I'd probably reorder these so you have five patches (or maybe more if
I missed something):

  - remove pciehp_debug uses from pci_bus_check_dev() and dbg_ctrl()
  - convert pciehp_debug to dyndbg
  - convert "dev_*(&ctrl->pcie->device)" to "pci_*(ctrl->pcie->port)"
  - add "Slot(%s)" to wrappers (could this be done with dev_fmt?)
  - remove unused wrappers

> Signed-off-by: Frederick Lawler <fred@fredlawl.com>
> ---
>  drivers/pci/hotplug/pciehp.h | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
> index 78325c8d961e..e852aa478802 100644
> --- a/drivers/pci/hotplug/pciehp.h
> +++ b/drivers/pci/hotplug/pciehp.h
> @@ -32,10 +32,7 @@ extern int pciehp_poll_time;
>  extern bool pciehp_debug;
>  
>  #define dbg(format, arg...)						\
> -do {									\
> -	if (pciehp_debug)						\
> -		pr_info(format, ## arg);				\
> -} while (0)
> +	pr_debug(format, ## arg);
>  #define err(format, arg...)						\
>  	pr_err(format, ## arg)
>  #define info(format, arg...)						\
> @@ -44,11 +41,7 @@ do {									\
>  	pr_warn(format, ## arg)
>  
>  #define ctrl_dbg(ctrl, format, arg...)					\
> -	do {								\
> -		if (pciehp_debug)					\
> -			pci_info(ctrl->pcie->port,			\
> -				 format, ## arg);			\
> -	} while (0)
> +	pci_dbg(ctrl->pcie->port, format, ## arg)
>  #define ctrl_err(ctrl, format, arg...)					\
>  	pci_err(ctrl->pcie->port, format, ## arg)
>  #define ctrl_info(ctrl, format, arg...)					\
> -- 
> 2.17.1
> 
