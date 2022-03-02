Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2F724CA2A1
	for <lists+linux-pci@lfdr.de>; Wed,  2 Mar 2022 12:00:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240336AbiCBLBM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Mar 2022 06:01:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238647AbiCBLBL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Mar 2022 06:01:11 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B568F6E7A3
        for <linux-pci@vger.kernel.org>; Wed,  2 Mar 2022 03:00:21 -0800 (PST)
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220302110016epoutp04848c7f8581b5b6a5e7b084af6e0b5dd3~Yi0qiBdpP2625926259epoutp04C
        for <linux-pci@vger.kernel.org>; Wed,  2 Mar 2022 11:00:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220302110016epoutp04848c7f8581b5b6a5e7b084af6e0b5dd3~Yi0qiBdpP2625926259epoutp04C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1646218816;
        bh=kq8MQbVRkc+bOUL5EisgTWGyifp1Wf2QScEObld1uDc=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=VBiAPt2ZvaQ40xwTA8+UZ8RzRuOIDVE9uv49XxDqKoVuisSMBghbFybAjH7/9Iwru
         TMNjOQnksf8x/hQ2B2Yy/KLdmU4zQ/C+QSDhP1DvjRKI7NYAEDACoW9CB2yCOo0wyN
         x7oUTRy6L+AcVZll59VcXkiPT92+vyLyc4V8fRWc=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220302110015epcas1p11e00fb34377d4913a5204264f2a86106~Yi0qGCeoa0938509385epcas1p1j;
        Wed,  2 Mar 2022 11:00:15 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.38.241]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4K7rk64VW2z4x9Ps; Wed,  2 Mar
        2022 11:00:14 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        7F.25.09592.E3E4F126; Wed,  2 Mar 2022 20:00:14 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20220302110014epcas1p48988c9d9e7f43f5ca002f718baa7ae53~Yi0odL9Xt1455414554epcas1p4C;
        Wed,  2 Mar 2022 11:00:14 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220302110014epsmtrp120570eea30bcef7d260dbef848ee1bda~Yi0ocaG5d0587005870epsmtrp1Q;
        Wed,  2 Mar 2022 11:00:14 +0000 (GMT)
X-AuditID: b6c32a37-28fff70000002578-9c-621f4e3e3792
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E7.59.29871.E3E4F126; Wed,  2 Mar 2022 20:00:14 +0900 (KST)
Received: from yj84jang02 (unknown [10.88.97.211]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220302110013epsmtip2d98d3399c45cf71f6484d5611b47ffdc~Yi0oO1qT42184721847epsmtip2H;
        Wed,  2 Mar 2022 11:00:13 +0000 (GMT)
From:   =?ks_c_5601-1987?B?wOW/tcH4L1RWIFMvVyBMYWIoVkQpL1N0YWZmIEVuZ2luZWVyL7vv?=
         =?ks_c_5601-1987?B?vLrA/MDa?= <yj84.jang@samsung.com>
To:     "'Greg Kroah-Hartman'" <gregkh@linuxfoundation.org>
Cc:     "'Rafael J. Wysocki'" <rafael@kernel.org>,
        "'Pavel Machek'" <pavel@ucw.cz>,
        "'Len Brown'" <len.brown@intel.com>,
        "'Bjorn Helgaas'" <bhelgaas@google.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <js07.lee@samsung.com>
In-Reply-To: <Yh8jb/X5ZNFvVQlf@kroah.com>
Subject: RE: [PATCH] PM: Add device name to suspend_report_result()
Date:   Wed, 2 Mar 2022 20:00:14 +0900
Message-ID: <03e001d82e24$b1b0e450$1512acf0$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="ks_c_5601-1987"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGYo0TT2vM3t6OMkLszEBoeXVnaDgIOdYpqAcZRUMetDFa0cA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOJsWRmVeSWpSXmKPExsWy7bCmrq6dn3ySwbk/ihZLmjIsmhevZ7N4
        dPM3q8WsKXuZLJbv62e0uLxrDpvF2XnH2Sw+9x5htFi0rJXZ4u6po2wWc79MZXbg9liwqdRj
        8Z6XTB6bVnWyeeyfu4bdo2/LKkaPFau/s3t83iQXwB6VbZORmpiSWqSQmpecn5KZl26r5B0c
        7xxvamZgqGtoaWGupJCXmJtqq+TiE6DrlpkDdKKSQlliTilQKCCxuFhJ386mKL+0JFUhI7+4
        xFYptSAlp8CsQK84Mbe4NC9dLy+1xMrQwMDIFKgwITtj5aeFLAUz5Cre/V/I0sB4W6KLkYND
        QsBEYsaetC5GLg4hgR2MEnPmH2SCcD4xSrzavIwFwvnGKHGrZSGQwwnWce7zD3aIxF5Gia3H
        Z0G1PGeU2HPqJFiGTaCdUWLnqtXsIC0iAuYScx8eB0swC1xikrh+aQsjSIJTQFNi5cc7rCC2
        sICzxN59R8B2sAioSGw8e4sNxOYVsJT4v+IPE4QtKHFy5hOwGmYBI4klq+czQdjyEtvfzmGG
        uE9B4ufTZawQi50kXl09wQpRIyIxu7ONGeQICYEDHBJbd05ghWhwkejr+cUOYQtLvDq+BcqW
        knjZ3wZlp0tMfPwWyi6Q+Pt4CdQyY4l3b9dC2YoSO3/PZYRYxifx7msPKySIeSU62oQgSpQl
        Hp9fzQZhS0qs/72faQKj0iwkr81C8tosJK/NQvLCAkaWVYxiqQXFuempxYYFxvAIT87P3cQI
        TsFa5jsYp739oHeIkYmD8RCjBAezkgivuLV8khBvSmJlVWpRfnxRaU5q8SFGU2BoT2SWEk3O
        B2aBvJJ4QxNLAxMzIxMLY0tjMyVx3lXTTicKCaQnlqRmp6YWpBbB9DFxcEo1MFkt29pZp93S
        l9jl1F4RbTPj9c3Jel/Z620CNjyz67F33fvw3vWPU7beCUlWuqEgf8Yn6dWiu79nmjJsW7WC
        f/VL8bwNyzaytV8W2av3o3vrmg/rMgJLVjX7uZi7TemzizA5pWtnU143+8058bfKsqdOLLCu
        3VF/t3fxkqWtj1Z/Oc/VxPAy9lU6w+2FB5NSzrRJnk57I/n2wKviWOmauW9iGc6//NnPl9bE
        mW5wqoJhsljcu+BPkkmCm5uZuLfde2+cyqEXM0mhq6LuwSk/iR2vJz61eRQ5zah48WXP8qn2
        fceb368T+tUsclsteVlM+PX3tyS+ODzclRSQp3oqmjd3n9ilM5kikm7ZpZM3/1ZiKc5INNRi
        LipOBABfkH8OSgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAIsWRmVeSWpSXmKPExsWy7bCSvK6dn3ySwZrr7BZLmjIsmhevZ7N4
        dPM3q8WsKXuZLJbv62e0uLxrDpvF2XnH2Sw+9x5htFi0rJXZ4u6po2wWc79MZXbg9liwqdRj
        8Z6XTB6bVnWyeeyfu4bdo2/LKkaPFau/s3t83iQXwB7FZZOSmpNZllqkb5fAlbHy00KWghly
        Fe/+L2RpYLwt0cXIySEhYCJx7vMP9i5GLg4hgd2MEg+X/mSCSEhKfP30ma2LkQPIFpY4fLgY
        ouYpo0Tv100sIA6bQDujxM5Vq9lBGkQEzCXmPjwOZjML3GKS+HvIGaJjJaPEteOtYAlOAU2J
        lR/vsILYwgLOEnv3HWEBsVkEVCQ2nr3FBmLzClhK/F/xhwnCFpQ4OfMJC8RQE4nGw91QtrzE
        9rdzmCEuVZD4+XQZK8QRThKvrp5ghagRkZjd2cY8gVF4FpJRs5CMmoVk1CwkLQsYWVYxSqYW
        FOem5xYbFhjmpZbrFSfmFpfmpesl5+duYgRHopbmDsbtqz7oHWJk4mA8xCjBwawkwituLZ8k
        xJuSWFmVWpQfX1Sak1p8iFGag0VJnPdC18l4IYH0xJLU7NTUgtQimCwTB6dUA9Nkq2vyFpMF
        7k2ZyLl56a/r5x/XHqyaWXFWROdL6qxQQUOVtkqLuefu6N/xE1jZ+Pp8fmed/sp4lvnGQi4n
        Z28vZ+/5U8rZb2av4Kt0Ma/48UbWGy/a448VKMtszNvM/in7S7TTioMxK/crq1QJfjrLfr3F
        Ymt29Y54V//zMfofTRd4pK+N2rmLUeW628H+zqYin3v/rYqMJKdE2xtw7WG4cPq0kPujMF11
        Xe2OPc2BFl6b2AMaJ6zX//H3Pk/8H5F38ml+muv8Fx01NJLbb7m74f1f7q4r2QWOzusZj2ax
        R+442jFJKjjwy/bKB0wup10b/eQCZZQXK/HwvW/tPX51ZUXS8leJxZ9U9VeEKrEUZyQaajEX
        FScCAG+lEs8zAwAA
X-CMS-MailID: 20220302110014epcas1p48988c9d9e7f43f5ca002f718baa7ae53
X-Msg-Generator: CA
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220302064921epcas1p19fbe8c017d776657caa696a3cef10093
References: <CGME20220302064921epcas1p19fbe8c017d776657caa696a3cef10093@epcas1p1.samsung.com>
        <20220302064917.64073-1-yj84.jang@samsung.com> <Yh8jb/X5ZNFvVQlf@kroah.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> -----Original Message-----
> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Sent: Wednesday, March 2, 2022 4:58 PM
> To: Youngjin Jang <yj84.jang@samsung.com>
> Cc: Rafael J. Wysocki <rafael@kernel.org>; Pavel Machek <pavel@ucw.cz>;
> Len Brown <len.brown@intel.com>; Bjorn Helgaas <bhelgaas@google.com>;
> linux-pm@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> pci@vger.kernel.org; linux-acpi@vger.kernel.org; linux-
usb@vger.kernel.org;
> js07.lee@samsung.com
> Subject: Re: [PATCH] PM: Add device name to suspend_report_result()
> 
> On Wed, Mar 02, 2022 at 03:49:17PM +0900, Youngjin Jang wrote:
> > From: "yj84.jang" <yj84.jang@samsung.com>
> >
> > currently, suspend_report_result() prints only function information.
> > If any driver uses common pm function, nobody knows who called failed
> > function exactly.
> >
> > So, device information is needed to recognize specific wrong driver.
> >
> > e.g.)
> > PM: dpm_run_callback(): pm_generic_suspend+0x0/0x48 returns 0
> > PM: dpm_run_callback(): platform_pm_suspend+0x0/0x68 returns 0 after
> > patch,
> > PM: dpm_run_callback(): pm_generic_suspend+0x0/0x48 (amba) returns 0
> > PM: dpm_run_callback(): platform_pm_suspend+0x0/0x68 (armv7-pmu)
> > returns 0
> >
> > Signed-off-by: yj84.jang <yj84.jang@samsung.com>
> > ---
> >  drivers/base/power/main.c  | 10 +++++-----
> >  drivers/pci/pci-driver.c   | 14 +++++++-------
> >  drivers/pnp/driver.c       |  2 +-
> >  drivers/usb/core/hcd-pci.c |  4 ++--
> >  include/linux/pm.h         |  8 ++++----
> >  5 files changed, 19 insertions(+), 19 deletions(-)
> >
> > diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> > index 04ea92c..a762fe8 100644
> > --- a/drivers/base/power/main.c
> > +++ b/drivers/base/power/main.c
> > @@ -485,7 +485,7 @@ static int dpm_run_callback(pm_callback_t cb, struct
> device *dev,
> >  	trace_device_pm_callback_start(dev, info, state.event);
> >  	error = cb(dev);
> >  	trace_device_pm_callback_end(dev, error);
> > -	suspend_report_result(cb, error);
> > +	suspend_report_result(dev, cb, error);
> >
> >  	initcall_debug_report(dev, calltime, cb, error);
> >
> > @@ -1568,7 +1568,7 @@ static int legacy_suspend(struct device *dev,
> pm_message_t state,
> >  	trace_device_pm_callback_start(dev, info, state.event);
> >  	error = cb(dev, state);
> >  	trace_device_pm_callback_end(dev, error);
> > -	suspend_report_result(cb, error);
> > +	suspend_report_result(dev, cb, error);
> >
> >  	initcall_debug_report(dev, calltime, cb, error);
> >
> > @@ -1855,7 +1855,7 @@ static int device_prepare(struct device *dev,
> pm_message_t state)
> >  	device_unlock(dev);
> >
> >  	if (ret < 0) {
> > -		suspend_report_result(callback, ret);
> > +		suspend_report_result(dev, callback, ret);
> >  		pm_runtime_put(dev);
> >  		return ret;
> >  	}
> > @@ -1960,10 +1960,10 @@ int dpm_suspend_start(pm_message_t state)  }
> > EXPORT_SYMBOL_GPL(dpm_suspend_start);
> >
> > -void __suspend_report_result(const char *function, void *fn, int ret)
> > +void __suspend_report_result(const char *function, struct device
> > +*dev, void *fn, int ret)
> >  {
> >  	if (ret)
> > -		pr_err("%s(): %pS returns %d\n", function, fn, ret);
> > +		pr_err("%s(): %pS (%s) returns %d\n", function, fn,
> > +dev_driver_string(dev), ret);
> 
> If you have a struct device, please use dev_err().
> 
> thanks,
> 
> greg k-h

Hello,
Thanks for your review.

I think dev_err() is nice option, but we can see a minor issue.
Prefix log "PM: " would be lost, If I use dev_err() in this context.
As you know, all logs in power management include "PM :" prefix.

So, I think pr_err() with detail information would be better than dev_err().
- PM: amba 1740000.etm: dpm_run_callback(): pm_generic_resume+0x0/0x48
returns 0


