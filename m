Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 420C14CAF7A
	for <lists+linux-pci@lfdr.de>; Wed,  2 Mar 2022 21:16:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242488AbiCBUQu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Mar 2022 15:16:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiCBUQt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Mar 2022 15:16:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB7ECD5E7;
        Wed,  2 Mar 2022 12:16:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EA406B82217;
        Wed,  2 Mar 2022 20:16:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 529A7C004E1;
        Wed,  2 Mar 2022 20:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646252163;
        bh=3uEcPVxR18DIwu+REDKdxAo26fa8S3FNjHjDUImg5oc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=u3wOky+qEPWUobrPJ5u1iR8FeObVZCSM8Gvpk7Z2udD8iXOV2KcUQCqmhyIz8Qb/e
         jlvbp0s80dGVIWP4gITBDvX3aQIqj0i+Tw7gqhVvsvCwMukk298DqJ0+SvZgQbaUHc
         xmkxzYndTse10ayo2vGHPyUGnMDv0kcbtFMM6YCmMApRnV88P9XB2JD9H6ArM9MYiX
         wBo+FvmOCAQNuwPMPTzqe4sL1oqOKB1CZ3ee0dRpSf65IqZqEfbabxaH/Va4S+OkO7
         MjAG0I3zHqGyqcNuUbTl19wQV+gfrVDFE5ybfp7pPE3D6d207ckhHzcl0EuFfHtmql
         Cth4nwsIxHSKQ==
Date:   Wed, 2 Mar 2022 14:16:00 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
Cc:     =?utf-8?B?77+95b+177+977+9L1RWIFMvVyBMYWIoVkQpL1N0YWZmIEVuZ2luZWVyLw==?=
         =?utf-8?B?77+977y677+977+977+977+9?= <yj84.jang@samsung.com>,
        "'Rafael J. Wysocki'" <rafael@kernel.org>,
        'Pavel Machek' <pavel@ucw.cz>,
        'Len Brown' <len.brown@intel.com>,
        'Bjorn Helgaas' <bhelgaas@google.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-usb@vger.kernel.org, js07.lee@samsung.com
Subject: Re: [PATCH] PM: Add device name to suspend_report_result()
Message-ID: <20220302201600.GA746065@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Yh+Ew8nd2C44ShHw@kroah.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 02, 2022 at 03:52:51PM +0100, 'Greg Kroah-Hartman' wrote:
> On Wed, Mar 02, 2022 at 08:00:14PM +0900, �念��/TV S/W Lab(VD)/Staff Engineer/�Ｚ���� wrote:
> > > -----Original Message-----
> > > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Sent: Wednesday, March 2, 2022 4:58 PM
> > > To: Youngjin Jang <yj84.jang@samsung.com>
> > > Cc: Rafael J. Wysocki <rafael@kernel.org>; Pavel Machek <pavel@ucw.cz>;
> > > Len Brown <len.brown@intel.com>; Bjorn Helgaas <bhelgaas@google.com>;
> > > linux-pm@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> > > pci@vger.kernel.org; linux-acpi@vger.kernel.org; linux-
> > usb@vger.kernel.org;
> > > js07.lee@samsung.com
> > > Subject: Re: [PATCH] PM: Add device name to suspend_report_result()
> > > 
> > > On Wed, Mar 02, 2022 at 03:49:17PM +0900, Youngjin Jang wrote:
> > > > From: "yj84.jang" <yj84.jang@samsung.com>
> > > >
> > > > currently, suspend_report_result() prints only function information.
> > > > If any driver uses common pm function, nobody knows who called failed
> > > > function exactly.
> > > >
> > > > So, device information is needed to recognize specific wrong driver.
> > > >
> > > > e.g.)
> > > > PM: dpm_run_callback(): pm_generic_suspend+0x0/0x48 returns 0
> > > > PM: dpm_run_callback(): platform_pm_suspend+0x0/0x68 returns 0 after
> > > > patch,
> > > > PM: dpm_run_callback(): pm_generic_suspend+0x0/0x48 (amba) returns 0
> > > > PM: dpm_run_callback(): platform_pm_suspend+0x0/0x68 (armv7-pmu)
> > > > returns 0

> > > > -		pr_err("%s(): %pS returns %d\n", function, fn, ret);
> > > > +		pr_err("%s(): %pS (%s) returns %d\n", function, fn,
> > > > +dev_driver_string(dev), ret);
> > > 
> > > If you have a struct device, please use dev_err().
> > 
> > I think dev_err() is nice option, but we can see a minor issue.
> > Prefix log "PM: " would be lost, If I use dev_err() in this context.
> > As you know, all logs in power management include "PM :" prefix.
> 
> Why does that matter?  Fix them all to use the struct device pointer and
> then they will be properly unified with the rest of the kernel log
> infrastructure.

You can #define dev_fmt if you need a prefix.
