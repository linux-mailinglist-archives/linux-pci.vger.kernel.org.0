Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6393D47D285
	for <lists+linux-pci@lfdr.de>; Wed, 22 Dec 2021 13:57:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245018AbhLVM5N (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Dec 2021 07:57:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233901AbhLVM5M (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Dec 2021 07:57:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B60C061574;
        Wed, 22 Dec 2021 04:57:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 24042B819C9;
        Wed, 22 Dec 2021 12:57:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 581CDC36AE8;
        Wed, 22 Dec 2021 12:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640177829;
        bh=DZHZR74Wmdv1RT8DZTvhHyHxk/8UcomFC4JcqKGKo/U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EKq4/MTiROv1nwsHueBcs8ZE/6uIqEOgKnaQpwkSjKrPkl4rIkWWfuLSKJ9RYoveB
         I6P+ixlixVbQomdzq7e2nZpOG2AExsXehfdnL08mjYs8ziFqN+uqqRN4Cjkt4GhQNP
         W0RkGWGiz45rLiWzn8NOQJte0v1l+Zw71VJWU/uU=
Date:   Wed, 22 Dec 2021 13:57:07 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     david.e.box@linux.intel.com, lee.jones@linaro.org,
        bhelgaas@google.com, andriy.shevchenko@linux.intel.com,
        srinivas.pandruvada@intel.com, mgross@linux.intel.com,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-pci@vger.kernel.org, Mark Gross <markgross@kernel.org>
Subject: Re: [PATCH RESEND V2 3/6] platform/x86/intel: Move intel_pmt from
 MFD to Auxiliary Bus
Message-ID: <YcMgoxbi6PwLQXzM@kroah.com>
References: <YbD1NsYHbU8FvtTN@kroah.com>
 <a70956e1c4da10603e29087e893cbae62ce82631.camel@linux.intel.com>
 <YbEFuN7fwdiNI8vW@kroah.com>
 <622887d53eaf6e6ae36354bfa0ed483df1cd9214.camel@linux.intel.com>
 <YcGEaH0oAAocziU2@kroah.com>
 <e9648546c3fb751954e411dfa392f0e0f90f0c85.camel@linux.intel.com>
 <YcIGwZqm2sfIixkH@kroah.com>
 <3913dfd7-3872-7d69-24af-eba747a7a92d@redhat.com>
 <be2a1cce5691e5dc7fb875f46d5f2085b6a55542.camel@linux.intel.com>
 <8c9d0a86-cbbb-be1b-41b1-61f27890b77d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c9d0a86-cbbb-be1b-41b1-61f27890b77d@redhat.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 21, 2021 at 07:38:38PM +0100, Hans de Goede wrote:
> Hi,
> 
> On 12/21/21 19:16, David E. Box wrote:
> > On Tue, 2021-12-21 at 18:04 +0100, Hans de Goede wrote:
> >> Hi,
> >>
> >> On 12/21/21 17:54, Greg KH wrote:
> >>> On Tue, Dec 21, 2021 at 08:44:57AM -0800, David E. Box wrote:
> >>>> On Tue, 2021-12-21 at 08:38 +0100, Greg KH wrote:
> >>>>> On Wed, Dec 08, 2021 at 01:30:06PM -0800, David E. Box wrote:
> >>>>>> On Wed, 2021-12-08 at 20:21 +0100, Greg KH wrote:
> >>>>>>> On Wed, Dec 08, 2021 at 11:09:48AM -0800, David E. Box wrote:
> >>>>>>>> On Wed, 2021-12-08 at 19:11 +0100, Greg KH wrote:
> >>>>>>>>> On Wed, Dec 08, 2021 at 09:47:26AM -0800, David E. Box wrote:
> >>>>>>>>>> On Wed, 2021-12-08 at 17:22 +0100, Greg KH wrote:
> >>>>>>>>>>> On Tue, Dec 07, 2021 at 05:50:12PM -0800, David E. Box
> >>>>>>>>>>> wrote:
> >>>>>>>>>>>> +static struct pci_driver intel_vsec_pci_driver = {
> >>>>>>>>>>>> +       .name = "intel_vsec",
> >>>>>>>>>>>> +       .id_table = intel_vsec_pci_ids,
> >>>>>>>>>>>> +       .probe = intel_vsec_pci_probe,
> >>>>>>>>>>>> +};
> >>>>>>>>>>>
> >>>>>>>>>>> So when the PCI device is removed from the system you leak
> >>>>>>>>>>> resources and
> >>>>>>>>>>> have dangling devices?
> >>>>>>>>>>
> >>>>>>>>>> No.
> >>>>>>>>>>
> >>>>>>>>>>> Why no PCI remove driver callback?
> >>>>>>>>>>
> >>>>>>>>>> After probe all resources are device managed. There's nothing
> >>>>>>>>>> to
> >>>>>>>>>> explicitly clean up. When
> >>>>>>>>>> the
> >>>>>>>>>> PCI
> >>>>>>>>>> device is removed, all aux devices are automatically removed.
> >>>>>>>>>> This
> >>>>>>>>>> is the case for the SDSi
> >>>>>>>>>> driver
> >>>>>>>>>> as well.
> >>>>>>>>>
> >>>>>>>>> Where is the "automatic cleanup" happening?  As this pci driver
> >>>>>>>>> is
> >>>>>>>>> bound
> >>>>>>>>> to the PCI device, when the device is removed, what is called in
> >>>>>>>>> this
> >>>>>>>>> driver to remove the resources allocated in the probe callback?
> >>>>>>>>>
> >>>>>>>>> confused,
> >>>>>>>>
> >>>>>>>> devm_add_action_or_reset(&pdev->dev, intel_vsec_remove_aux,
> >>>>>>>> auxdev)
> >>>>>>>
> >>>>>>> Wow that is opaque.  Why not do it on remove instead?
> >>>>>>
> >>>>>> This code is common for auxdev cleanup. AFAICT most auxiliary bus code
> >>>>>> is
> >>>>>> done by drivers that have
> >>>>>> some other primary function. They clean up their primary function
> >>>>>> resources
> >>>>>> in remove, but they
> >>>>>> clean up the auxdev using the method above. In this case the sole
> >>>>>> purpose of
> >>>>>> this driver is to
> >>>>>> create the auxdev. There are no other resources beyond what the auxdev
> >>>>>> is
> >>>>>> using.
> >>>>>>
> >>>>>> Adding runtime pm to the pci driver will change this. Remove will be
> >>>>>> needed
> >>>>>> then.
> >>>>>
> >>>>> And who will notice that being required when that happens?
> >>>>>
> >>>>> Why is there no runtime PM for this driver?  Do you not care about power
> >>>>> consumption?  :)
> >>>>
> >>>> Of course. :)
> >>>>
> >>>> There's a backlog of patches waiting for this series. One adds support for
> >>>> the
> >>>> telemetry device (an auxdev) on the DG2 GPU. This device requires runtime
> >>>> pm in
> >>>> order for the slot to go D3. But this also requires changes to the
> >>>> telemetry
> >>>> driver in order for runtime pm to be handled correctly. These and other
> >>>> patches,
> >>>> including a series to have all current aux drivers use the new drvdata
> >>>> helpers,
> >>>> are waiting for this.
> >>>
> >>> I can take the aux driver drvdata patch now, through my tree, if you
> >>> want, no need to make it wait for this tiny driver.
> >>>
> >>> Feel free to send it independant of the existing patchset, and with the
> >>> cleanup patches at the same time, should be quite easy to get merged.
> >>
> >> If you're going to take that one, can you perhaps take patches
> >> 1-3 for 5.17 through your tree as well (patch 3 depends on 2/it) ?
> >>
> >> Note there is a v4 of this series, see please use that :)
> >>
> >> I assume the follow up patches are also going to need patch 3
> >> (the actual conversion of the driver to aux-bus).
> > 
> > Yes.
> > 
> >>
> >> Here is my Ack for the pdx86 bits in patch 3:
> >>
> >> Acked-by: Hans de Goede <hdegoede@redhat.com>
> >>
> >> And patch 1 and 3 also have acks from the PCI resp. MFD subsys maintainers,
> >> so I guess taking this all upstream through your tree is fine.
> > 
> > Should I send 1-3 plus the drvdata cleanup patches I have to Grep? V5?
> 
> No there is no need for that v4 is fine, since no changes have been
> requested there is no need to send out a new version.

I've taken patches 1-3 of this series now, thanks.

greg k-h
