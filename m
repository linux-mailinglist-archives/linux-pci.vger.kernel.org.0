Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47E884506C4
	for <lists+linux-pci@lfdr.de>; Mon, 15 Nov 2021 15:25:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232093AbhKOO2Z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Nov 2021 09:28:25 -0500
Received: from mga12.intel.com ([192.55.52.136]:1899 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236407AbhKOO2A (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 15 Nov 2021 09:28:00 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10168"; a="213481579"
X-IronPort-AV: E=Sophos;i="5.87,236,1631602800"; 
   d="scan'208";a="213481579"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2021 06:25:03 -0800
X-IronPort-AV: E=Sophos;i="5.87,236,1631602800"; 
   d="scan'208";a="503825626"
Received: from smile.fi.intel.com ([10.237.72.184])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2021 06:25:01 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mmcuj-0077Ev-6T;
        Mon, 15 Nov 2021 16:24:53 +0200
Date:   Mon, 15 Nov 2021 16:24:52 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 2/3] driver core: Don't call
 device_remove_properties() from device_del()
Message-ID: <YZJttIYTV+wdpJlx@smile.fi.intel.com>
References: <20211115121001.77041-1-heikki.krogerus@linux.intel.com>
 <20211115121001.77041-3-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211115121001.77041-3-heikki.krogerus@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 15, 2021 at 03:10:00PM +0300, Heikki Krogerus wrote:
> All the drivers that relied on device_del() to call
> device_remove_properties() have now been converted to either
> use device_create_managed_software_node() instead of
> device_add_properties(), or to register the software node
> completely separately from the device.
> 
> This will make it finally possible to share and reuse the
> software nodes that hold the additional device properties.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
>  drivers/base/core.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index fd034d7424472..a40b6fb1ebb01 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -3582,7 +3582,6 @@ void device_del(struct device *dev)
>  	device_pm_remove(dev);
>  	driver_deferred_probe_del(dev);
>  	device_platform_notify_remove(dev);
> -	device_remove_properties(dev);
>  	device_links_purge(dev);
>  
>  	if (dev->bus)
> -- 
> 2.33.0
> 

-- 
With Best Regards,
Andy Shevchenko


