Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D287A604625
	for <lists+linux-pci@lfdr.de>; Wed, 19 Oct 2022 15:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbiJSM77 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Oct 2022 08:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233856AbiJSM7g (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Oct 2022 08:59:36 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE31710EA0B;
        Wed, 19 Oct 2022 05:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666183403; x=1697719403;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=E2p35ATnNVue4S2XAAi/7LxZWtiUvtDcbfvFBxl94qs=;
  b=RNNKEUwcTAONFtb0H179Nuo6L7lN47dyyy4jdteRhSHt3I/bDFmtZMUz
   BLOYNY9lE+NklnP4ZSgBHvXxwvxHqFTvI9PwaObyhC1y3xPai4zb2/iY8
   FfxJytjO3c2wNv0hFKc8z2PobDjqpIxO3wa6WvCPaMSEjdmYNieOhXSyp
   lrOuCxaQee9e/3QtPEAqmjTj6+fmwfNi4L8c/c8S2T+g0KY0kLke3YQDj
   HS++7W6dEFmxwb68QOgkidmCAvmuyibZz+/mYh8NbJ4gyrDuvY5CzwcuC
   m6lch8AvE+HAIOmmWaR6xfu9ohfgmH6YZ23S6Mtrqq7VoQRfWV3Awq3Eu
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="308080448"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="308080448"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 05:22:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="662439218"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="662439218"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.191])
  by orsmga001.jf.intel.com with SMTP; 19 Oct 2022 05:22:51 -0700
Received: by stinkbox (sSMTP sendmail emulation); Wed, 19 Oct 2022 15:22:50 +0300
Date:   Wed, 19 Oct 2022 15:22:50 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH] ACPI: PCI: Fix device reference counting in
 acpi_get_pci_dev()
Message-ID: <Y0/sGveKPjuUWOhO@intel.com>
References: <12097002.O9o76ZdvQC@kreacher>
 <Y0+7Ug9Yh6J6uHVr@intel.com>
 <CAJZ5v0gKW9S29xS2+qkcopzYtZKTcM=ZT-Jjc4fnEJfu=oYKaw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0gKW9S29xS2+qkcopzYtZKTcM=ZT-Jjc4fnEJfu=oYKaw@mail.gmail.com>
X-Patchwork-Hint: comment
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 19, 2022 at 01:35:26PM +0200, Rafael J. Wysocki wrote:
> On Wed, Oct 19, 2022 at 11:02 AM Ville Syrjälä
> <ville.syrjala@linux.intel.com> wrote:
> >
> > On Tue, Oct 18, 2022 at 07:34:03PM +0200, Rafael J. Wysocki wrote:
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > Commit 63f534b8bad9 ("ACPI: PCI: Rework acpi_get_pci_dev()") failed
> > > to reference count the device returned by acpi_get_pci_dev() as
> > > expected by its callers which in some cases may cause device objects
> > > to be dropped prematurely.
> > >
> > > Add the missing get_device() to acpi_get_pci_dev().
> > >
> > > Fixes: 63f534b8bad9 ("ACPI: PCI: Rework acpi_get_pci_dev()")
> >
> > FYI this (and the rtc-cmos regression discussed in
> > https://lore.kernel.org/linux-acpi/5887691.lOV4Wx5bFT@kreacher/)
> > took down the entire Intel gfx CI.
> 
> Sorry for the disturbance.
> 
> > I've applied both fixes into our fixup branch and things are looking much
> > healthier now.
> 
> Thanks for letting me know.
> 
> I've just added the $subject patch to my linux-next branch as an
> urgent fix and the other one has been applied to the RTC tree.
> 
> > This one caused i915 selftests to eat a lot of POISON_FREE
> > in the CI. While bisecting it locally I didn't have
> > poisoning enabled so I got refcount_t undeflows instead.
> 
> Unfortunately, making no mistakes is generally hard to offer.
> 
> If catching things like this early is better, what about pulling my
> bleeding-edge branch, where all of my changes are staged before going
> into linux-next, into the CI?

Pretty sure we don't have the resources to become the CI for
everyone. So testing random trees is not really possible. And 
the alternative of pulling random trees into drm-tip is probably
a not a popular idea either. We used to pull in the sound tree
since it's pretty closely tied to graphics, but I think we
stopped even that because it eneded up pulling the whole of
-rc1 in at random points in time when we were't expecting it.

Ideally each subsystem would have its own CI, or there should
be some kernel wide thing. But I suppose the progress towards
something like that is glacial.

That said, we do test linux-next to some degree. And looks like
at least one of these could have been caught a bit earlier through
that. Unfortunately no one is really keeping an eye on that so
things tend to slip through. Probably need to figure out something
to make better use of that.

> 
> > https://intel-gfx-ci.01.org/tree/drm-tip/index.html has a lot
> > of colorful boxes to click if you're interested in any of the
> > logs. The fixes are included in the CI_DRM_12259 build. Earlier
> > builds were broken.
> 
> Thanks!

-- 
Ville Syrjälä
Intel
