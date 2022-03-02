Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 104104CA890
	for <lists+linux-pci@lfdr.de>; Wed,  2 Mar 2022 15:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243255AbiCBOxj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Mar 2022 09:53:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235638AbiCBOxi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Mar 2022 09:53:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38ABA24F05;
        Wed,  2 Mar 2022 06:52:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC25261631;
        Wed,  2 Mar 2022 14:52:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1043C004E1;
        Wed,  2 Mar 2022 14:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1646232774;
        bh=AaVZTbcwsLoEN6dmpELG2w6iDesUHs9sUP4+Omqezc0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kmJqzFyFBVEXdMwB0eYXxslBglK/+MZ5AFOPSiGR8t3try2vJjoWiGy8wnz2URrGw
         hA8GFBMn5xOuRu5LtAgT8WkMLUhPG0jHyNhC76m4laj5WdP4reH84Q7cTJKuIdpfXD
         xphCFdJ9efrMR7DaHcdLNG/zDWLE9Dc5KhkjfPRc=
Date:   Wed, 2 Mar 2022 15:52:51 +0100
From:   'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
To:     =?utf-8?B?77+95b+177+977+9L1RWIFMvVyBMYWIoVkQpL1N0YWZmIEVuZ2luZWVyLw==?=
         =?utf-8?B?77+977y677+977+977+977+9?= <yj84.jang@samsung.com>
Cc:     "'Rafael J. Wysocki'" <rafael@kernel.org>,
        'Pavel Machek' <pavel@ucw.cz>,
        'Len Brown' <len.brown@intel.com>,
        'Bjorn Helgaas' <bhelgaas@google.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-usb@vger.kernel.org, js07.lee@samsung.com
Subject: Re: [PATCH] PM: Add device name to suspend_report_result()
Message-ID: <Yh+Ew8nd2C44ShHw@kroah.com>
References: <CGME20220302064921epcas1p19fbe8c017d776657caa696a3cef10093@epcas1p1.samsung.com>
 <20220302064917.64073-1-yj84.jang@samsung.com>
 <Yh8jb/X5ZNFvVQlf@kroah.com>
 <03e001d82e24$b1b0e450$1512acf0$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <03e001d82e24$b1b0e450$1512acf0$@samsung.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 02, 2022 at 08:00:14PM +0900, �念��/TV S/W Lab(VD)/Staff Engineer/�Ｚ���� wrote:
> > -----Original Message-----
> > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Sent: Wednesday, March 2, 2022 4:58 PM
> > To: Youngjin Jang <yj84.jang@samsung.com>
> > Cc: Rafael J. Wysocki <rafael@kernel.org>; Pavel Machek <pavel@ucw.cz>;
> > Len Brown <len.brown@intel.com>; Bjorn Helgaas <bhelgaas@google.com>;
> > linux-pm@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> > pci@vger.kernel.org; linux-acpi@vger.kernel.org; linux-
> usb@vger.kernel.org;
> > js07.lee@samsung.com
> > Subject: Re: [PATCH] PM: Add device name to suspend_report_result()
> > 
> > On Wed, Mar 02, 2022 at 03:49:17PM +0900, Youngjin Jang wrote:
> > > From: "yj84.jang" <yj84.jang@samsung.com>
> > >
> > > currently, suspend_report_result() prints only function information.
> > > If any driver uses common pm function, nobody knows who called failed
> > > function exactly.
> > >
> > > So, device information is needed to recognize specific wrong driver.
> > >
> > > e.g.)
> > > PM: dpm_run_callback(): pm_generic_suspend+0x0/0x48 returns 0
> > > PM: dpm_run_callback(): platform_pm_suspend+0x0/0x68 returns 0 after
> > > patch,
> > > PM: dpm_run_callback(): pm_generic_suspend+0x0/0x48 (amba) returns 0
> > > PM: dpm_run_callback(): platform_pm_suspend+0x0/0x68 (armv7-pmu)
> > > returns 0
> > >
> > > Signed-off-by: yj84.jang <yj84.jang@samsung.com>
> > > ---
> > >  drivers/base/power/main.c  | 10 +++++-----
> > >  drivers/pci/pci-driver.c   | 14 +++++++-------
> > >  drivers/pnp/driver.c       |  2 +-
> > >  drivers/usb/core/hcd-pci.c |  4 ++--
> > >  include/linux/pm.h         |  8 ++++----
> > >  5 files changed, 19 insertions(+), 19 deletions(-)
> > >
> > > diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> > > index 04ea92c..a762fe8 100644
> > > --- a/drivers/base/power/main.c
> > > +++ b/drivers/base/power/main.c
> > > @@ -485,7 +485,7 @@ static int dpm_run_callback(pm_callback_t cb, struct
> > device *dev,
> > >  	trace_device_pm_callback_start(dev, info, state.event);
> > >  	error = cb(dev);
> > >  	trace_device_pm_callback_end(dev, error);
> > > -	suspend_report_result(cb, error);
> > > +	suspend_report_result(dev, cb, error);
> > >
> > >  	initcall_debug_report(dev, calltime, cb, error);
> > >
> > > @@ -1568,7 +1568,7 @@ static int legacy_suspend(struct device *dev,
> > pm_message_t state,
> > >  	trace_device_pm_callback_start(dev, info, state.event);
> > >  	error = cb(dev, state);
> > >  	trace_device_pm_callback_end(dev, error);
> > > -	suspend_report_result(cb, error);
> > > +	suspend_report_result(dev, cb, error);
> > >
> > >  	initcall_debug_report(dev, calltime, cb, error);
> > >
> > > @@ -1855,7 +1855,7 @@ static int device_prepare(struct device *dev,
> > pm_message_t state)
> > >  	device_unlock(dev);
> > >
> > >  	if (ret < 0) {
> > > -		suspend_report_result(callback, ret);
> > > +		suspend_report_result(dev, callback, ret);
> > >  		pm_runtime_put(dev);
> > >  		return ret;
> > >  	}
> > > @@ -1960,10 +1960,10 @@ int dpm_suspend_start(pm_message_t state)  }
> > > EXPORT_SYMBOL_GPL(dpm_suspend_start);
> > >
> > > -void __suspend_report_result(const char *function, void *fn, int ret)
> > > +void __suspend_report_result(const char *function, struct device
> > > +*dev, void *fn, int ret)
> > >  {
> > >  	if (ret)
> > > -		pr_err("%s(): %pS returns %d\n", function, fn, ret);
> > > +		pr_err("%s(): %pS (%s) returns %d\n", function, fn,
> > > +dev_driver_string(dev), ret);
> > 
> > If you have a struct device, please use dev_err().
> > 
> > thanks,
> > 
> > greg k-h
> 
> Hello,
> Thanks for your review.
> 
> I think dev_err() is nice option, but we can see a minor issue.
> Prefix log "PM: " would be lost, If I use dev_err() in this context.
> As you know, all logs in power management include "PM :" prefix.

Why does that matter?  Fix them all to use the struct device pointer and
then they will be properly unified with the rest of the kernel log
infrastructure.

thanks,

greg k-h
