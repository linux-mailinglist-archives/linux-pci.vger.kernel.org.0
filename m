Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3E83627AA5
	for <lists+linux-pci@lfdr.de>; Mon, 14 Nov 2022 11:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235890AbiKNKhe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Nov 2022 05:37:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235968AbiKNKh0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Nov 2022 05:37:26 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B1781F622
        for <linux-pci@vger.kernel.org>; Mon, 14 Nov 2022 02:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668422245; x=1699958245;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Fn39sragQQjC/Vc1CWI91MSRQfXBL//swQH9JGFChSw=;
  b=UL4ejq4I0UEgc6vxuiLO60o3fKfMKvFm43qL5eKvR00fOTVIbVKDKDNS
   CsjIhxj7rf/N2TC8gCOPWFfwVu3gryaXmZ31JfSFlItf7u3qLIrmzfZZu
   H4E2QCAGeICZovPGcb9gYHkZSwP1mhs+Rl62MTLfGyAD5ioILxdqynTCo
   0TlMn8X+kbXlfehcn4iw17rAaNlfQgdZ9SoyYfZe07le3yiFFKKqshROd
   bz9od1p6qhF1urLS3UB2AfhiYvHYnS506URiJrzrZyZx/Uq4Bm0EWdnGT
   914RJZQlkROQWooTRUJ9RjsLraFvHQQ5yqSbyvk2N502gJ/zV/1X8bzwN
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10530"; a="311941330"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="311941330"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 02:37:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10530"; a="883489139"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="883489139"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 14 Nov 2022 02:37:24 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 634C732E; Mon, 14 Nov 2022 12:37:48 +0200 (EET)
Date:   Mon, 14 Nov 2022 12:37:48 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Albert Zhou <albert.zhou.50@gmail.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org, lukas@wunner.de
Subject: Re: [PATCH v2 1/2] pci: hotplug: add dependency info to Kconfig
Message-ID: <Y3IafGm+ewR5LJL9@black.fi.intel.com>
References: <20221113112811.22266-1-albert.zhou.50@gmail.com>
 <20221113112811.22266-2-albert.zhou.50@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221113112811.22266-2-albert.zhou.50@gmail.com>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Nov 13, 2022 at 10:28:10PM +1100, Albert Zhou wrote:
> Thunderbolt and USB4 PCI cards require the hotplug feature. This is now
> recorded in the help message for HOTPLUG_PCI. Further, HOTPLUG_PCI is
> defaulted to Y if USB4 is selected.
> 
> Signed-off-by: Albert Zhou <albert.zhou.50@gmail.com>
> ---
>  drivers/pci/hotplug/Kconfig | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/hotplug/Kconfig b/drivers/pci/hotplug/Kconfig
> index 840a84bb5ee2..06cc373834f5 100644
> --- a/drivers/pci/hotplug/Kconfig
> +++ b/drivers/pci/hotplug/Kconfig
> @@ -6,10 +6,12 @@
>  menuconfig HOTPLUG_PCI
>  	bool "Support for PCI Hotplug"
>  	depends on PCI && SYSFS
> +	default y if USB4
>  	help
>  	  Say Y here if you have a motherboard with a PCI Hotplug controller.
>  	  This allows you to add and remove PCI cards while the machine is
> -	  powered up and running.
> +	  powered up and running. Thunderbolt and USB4 PCI cards require
> +	  Hotplug.

I would not say they "require" this. PCIe is completely optional in USB4
systems and it is perfectly fine to have host controllers or
add-in-cards that don't have a single PCIe adapter.

Not objeting the patch, though. For Linux I guess it makes sense to have
this like what you are suggesting. Just perhaps changing the wordirng
;-)
