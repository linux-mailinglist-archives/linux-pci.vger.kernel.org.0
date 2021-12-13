Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45AA3473389
	for <lists+linux-pci@lfdr.de>; Mon, 13 Dec 2021 19:07:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238447AbhLMSHB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Dec 2021 13:07:01 -0500
Received: from mga12.intel.com ([192.55.52.136]:16786 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241613AbhLMSG4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 13 Dec 2021 13:06:56 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="218807443"
X-IronPort-AV: E=Sophos;i="5.88,203,1635231600"; 
   d="scan'208";a="218807443"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 10:05:31 -0800
X-IronPort-AV: E=Sophos;i="5.88,203,1635231600"; 
   d="scan'208";a="613918383"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 10:05:27 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mwpgc-005iPz-HI;
        Mon, 13 Dec 2021 20:04:30 +0200
Date:   Mon, 13 Dec 2021 20:04:30 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     lee.jones@linaro.org, hdegoede@redhat.com, bhelgaas@google.com,
        gregkh@linuxfoundation.org, srinivas.pandruvada@intel.com,
        mgross@linux.intel.com, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-pci@vger.kernel.org,
        Mark Gross <markgross@kernel.org>
Subject: Re: [PATCH V3 2/6] driver core: auxiliary bus: Add driver data
 helpers
Message-ID: <YbeLLpu80EIQY3R5@smile.fi.intel.com>
References: <20211213175921.1897860-1-david.e.box@linux.intel.com>
 <20211213175921.1897860-3-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213175921.1897860-3-david.e.box@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Dec 13, 2021 at 09:59:17AM -0800, David E. Box wrote:
> Adds get/set driver data helpers for auxiliary devices.

I though I gave you a tag... Hint: use `b4 am ...` against previous version and
you won't lose the individual tags.

Anyway,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> Reviewed-by: Mark Gross <markgross@kernel.org>
> ---
> V3
>   - No changes
> V2
>   - No changes
> 
>  include/linux/auxiliary_bus.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/include/linux/auxiliary_bus.h b/include/linux/auxiliary_bus.h
> index fc51d45f106b..a8338d456e81 100644
> --- a/include/linux/auxiliary_bus.h
> +++ b/include/linux/auxiliary_bus.h
> @@ -28,6 +28,16 @@ struct auxiliary_driver {
>  	const struct auxiliary_device_id *id_table;
>  };
>  
> +static inline void *auxiliary_get_drvdata(struct auxiliary_device *auxdev)
> +{
> +	return dev_get_drvdata(&auxdev->dev);
> +}
> +
> +static inline void auxiliary_set_drvdata(struct auxiliary_device *auxdev, void *data)
> +{
> +	dev_set_drvdata(&auxdev->dev, data);
> +}
> +
>  static inline struct auxiliary_device *to_auxiliary_dev(struct device *dev)
>  {
>  	return container_of(dev, struct auxiliary_device, dev);
> -- 
> 2.25.1
> 

-- 
With Best Regards,
Andy Shevchenko


