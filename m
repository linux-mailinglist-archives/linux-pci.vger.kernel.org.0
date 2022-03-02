Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 779904C9EC7
	for <lists+linux-pci@lfdr.de>; Wed,  2 Mar 2022 08:57:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237483AbiCBH6Z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Mar 2022 02:58:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236101AbiCBH6Y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Mar 2022 02:58:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 113DF33E03;
        Tue,  1 Mar 2022 23:57:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A1CCC6091F;
        Wed,  2 Mar 2022 07:57:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 800BFC004E1;
        Wed,  2 Mar 2022 07:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1646207860;
        bh=sE3KvyyqnB13hEUuAfARfOA7aKTVzjN39A4KBMKEWmI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K+uaCR+ZHGIk2a9vkcZ2GZIDnzA1nOq5Mog+MTTZO7TpHanYei0eixq1HXKnO2KyY
         LCWfEqd4tTveNXWETjwTjUxz1GHP2O9rlrc52PvY9OEsZQ59JyQXCfInymbHtkeIdI
         U/wzQGSj0DEW1xqTOl2Lo15zw7QigsZBmyDyhMHc=
Date:   Wed, 2 Mar 2022 08:57:35 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Youngjin Jang <yj84.jang@samsung.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-usb@vger.kernel.org,
        js07.lee@samsung.com
Subject: Re: [PATCH] PM: Add device name to suspend_report_result()
Message-ID: <Yh8jb/X5ZNFvVQlf@kroah.com>
References: <CGME20220302064921epcas1p19fbe8c017d776657caa696a3cef10093@epcas1p1.samsung.com>
 <20220302064917.64073-1-yj84.jang@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220302064917.64073-1-yj84.jang@samsung.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 02, 2022 at 03:49:17PM +0900, Youngjin Jang wrote:
> From: "yj84.jang" <yj84.jang@samsung.com>
> 
> currently, suspend_report_result() prints only function information.
> If any driver uses common pm function, nobody knows who called
> failed function exactly.
> 
> So, device information is needed to recognize specific wrong driver.
> 
> e.g.)
> PM: dpm_run_callback(): pm_generic_suspend+0x0/0x48 returns 0
> PM: dpm_run_callback(): platform_pm_suspend+0x0/0x68 returns 0
> after patch,
> PM: dpm_run_callback(): pm_generic_suspend+0x0/0x48 (amba) returns 0
> PM: dpm_run_callback(): platform_pm_suspend+0x0/0x68 (armv7-pmu) returns 0
> 
> Signed-off-by: yj84.jang <yj84.jang@samsung.com>
> ---
>  drivers/base/power/main.c  | 10 +++++-----
>  drivers/pci/pci-driver.c   | 14 +++++++-------
>  drivers/pnp/driver.c       |  2 +-
>  drivers/usb/core/hcd-pci.c |  4 ++--
>  include/linux/pm.h         |  8 ++++----
>  5 files changed, 19 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index 04ea92c..a762fe8 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -485,7 +485,7 @@ static int dpm_run_callback(pm_callback_t cb, struct device *dev,
>  	trace_device_pm_callback_start(dev, info, state.event);
>  	error = cb(dev);
>  	trace_device_pm_callback_end(dev, error);
> -	suspend_report_result(cb, error);
> +	suspend_report_result(dev, cb, error);
>  
>  	initcall_debug_report(dev, calltime, cb, error);
>  
> @@ -1568,7 +1568,7 @@ static int legacy_suspend(struct device *dev, pm_message_t state,
>  	trace_device_pm_callback_start(dev, info, state.event);
>  	error = cb(dev, state);
>  	trace_device_pm_callback_end(dev, error);
> -	suspend_report_result(cb, error);
> +	suspend_report_result(dev, cb, error);
>  
>  	initcall_debug_report(dev, calltime, cb, error);
>  
> @@ -1855,7 +1855,7 @@ static int device_prepare(struct device *dev, pm_message_t state)
>  	device_unlock(dev);
>  
>  	if (ret < 0) {
> -		suspend_report_result(callback, ret);
> +		suspend_report_result(dev, callback, ret);
>  		pm_runtime_put(dev);
>  		return ret;
>  	}
> @@ -1960,10 +1960,10 @@ int dpm_suspend_start(pm_message_t state)
>  }
>  EXPORT_SYMBOL_GPL(dpm_suspend_start);
>  
> -void __suspend_report_result(const char *function, void *fn, int ret)
> +void __suspend_report_result(const char *function, struct device *dev, void *fn, int ret)
>  {
>  	if (ret)
> -		pr_err("%s(): %pS returns %d\n", function, fn, ret);
> +		pr_err("%s(): %pS (%s) returns %d\n", function, fn, dev_driver_string(dev), ret);

If you have a struct device, please use dev_err().

thanks,

greg k-h
