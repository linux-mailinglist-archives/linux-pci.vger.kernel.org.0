Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E89C663D81
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jan 2023 11:07:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjAJKG7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Jan 2023 05:06:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231332AbjAJKG6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Jan 2023 05:06:58 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E748164AB
        for <linux-pci@vger.kernel.org>; Tue, 10 Jan 2023 02:06:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673345216; x=1704881216;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8okIwzDk2INnnDEsSLWvtB8cquhInlQg5xx74fTtp68=;
  b=V694Vcd8Ts+0FKfmMI4/O0NnDTFXY/9UJRmHfxXILpQanQZwnwljP+i4
   CuTgXwkikfs42JJtzMcxVKjaZTcHMwgs3wx8yyJxL9u0+nuBDjd1O+UUl
   /Dr6H5N9OS/PS3qPaRnOj4S2ujvoYEwTyzQGYm/stMMS+eKPMgLVeRtW9
   ETwLydmMaiIqLaLmP79/rf8g0FVFTvikUveevezEs3UMGURr091Qk3FTq
   UAo3+zIQ5ZoSCZTtq2DCh3BRiQs0Cp4zm4RiAFe7k+YTZoWJLNksozBow
   dU8A8yEkwDl/BScj00ys+myXyaKKMIqX1Rx63rJEUggsqUdDL7ODwU651
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="350330720"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="350330720"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2023 02:06:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="902316819"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="902316819"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 10 Jan 2023 02:06:49 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 2BA63E1; Tue, 10 Jan 2023 12:07:22 +0200 (EET)
Date:   Tue, 10 Jan 2023 12:07:22 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Alexander Motin <mav@ixsystems.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lukas Wunner <lukas@wunner.de>,
        Chris Chiu <chris.chiu@canonical.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 1/2] PCI: Take other bus devices into account when
 distributing resources
Message-ID: <Y7042gQsfPmD+21D@black.fi.intel.com>
References: <Y7bUAaxt6viswdXV@black.fi.intel.com>
 <20230105170413.GA1150738@bhelgaas>
 <Y7v2XT1N4J1deVEt@black.fi.intel.com>
 <2f33bc51-7473-58fc-0b87-fad3984375d6@ixsystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2f33bc51-7473-58fc-0b87-fad3984375d6@ixsystems.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On Mon, Jan 09, 2023 at 01:27:07PM -0500, Alexander Motin wrote:
> On 09.01.2023 06:11, Mika Westerberg wrote:
> > On Thu, Jan 05, 2023 at 11:04:13AM -0600, Bjorn Helgaas wrote:
> > > On Thu, Jan 05, 2023 at 03:43:29PM +0200, Mika Westerberg wrote:
> > > > On Thu, Jan 05, 2023 at 11:12:11AM +0200, Mika Westerberg wrote:
> > > > > > What happens in a topology like this:
> > > > > > 
> > > > > >    10:00.0 non-hotplug bridge to [bus 20-3f]
> > > > > >    10:01.0 non-hotplug bridge to [bus 40]
> > > > > >    20:00.0 hotplug bridge
> > > > > >    40:00.0 NIC
> > > > > > 
> > > > > > where we're distributing space on "bus" 10, hotplug_bridges == 0 and
> > > > > > normal_bridges == 2?  Do we give half the extra space to bus 20 and
> > > > > > the other half to bus 40, even though we could tell up front that bus
> > > > > > 20 is the only place that can actually use any extra space?
> > > > > 
> > > > > Yes we split it into half.
> > > > 
> > > > Forgot to reply also that would it make sense here to look at below the
> > > > non-hotplug bridges and if we find hotplug bridges, distribute the space
> > > > equally between those or something like that?
> > > 
> > > Yes, I do think ultimately it would make sense to keep track at every
> > > bridge whether it or any descendant is a hotplug bridge so we could
> > > distribute extra space only to bridges that could potentially use it.
> > > 
> > > But I don't know if that needs to be done in this series.  This code
> > > is so complicated and fragile that I think being ruthless about
> > > defining the minimal problem we're solving and avoiding scope creep
> > > will improve our chances of success.
> > > 
> > > So treat this as a question to improve my understanding more than
> > > anything.
> > 
> > Okay, undestood ;-)
> 
> I was also wondering about this problem.  But my first though was: if we are
> not going to look down through all the tree, may be we should better
> distribute resources between all bridges no this bus, no matter whether they
> are hot-plug or not?  Because behind any non-hotplug bridge may appear a
> hot-plug one.  As a possible trivial approach, give hot-plug bridges twice
> of what is given to non-hot-plug ones. ;)

Yeah, this may end up running out of resources pretty quickly. This is
primarily used with Thunderbolt/USB4 devices and the recent ones have up
to 3 downstream PCIe hotplug ports (along with the non-hotplug ones) so
chaining a couple of those quickly consumes all that space.

I'm all ears if there is a good (and simple) strategy for dealing with
this but at least we should not make the functionality worse than what
the current situation is IMHO. I'm going to try the suggestion to look
behind non-hotplug bridges for hotplug ones and see how complex that
becomes ;-)

> PS: Thank you, Mika, for working on this.

No problem :)
