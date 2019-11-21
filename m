Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC9C105B9F
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2019 22:10:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbfKUVKV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Nov 2019 16:10:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:36118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726293AbfKUVKV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 21 Nov 2019 16:10:21 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3739D2067D;
        Thu, 21 Nov 2019 21:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574370619;
        bh=3AcIf3ak72WZOe4Y+EsIK3BMGHG7xj9GzBzRmC5CTgc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hoz9sgUScI5d6ZzJReoCFnjd4OVlS7NMRNckXpzkH2h/C3xcf/QieJJRx+DeaZF3d
         Qv6K0bC64IxVriA8/nEcPRyWFCKLFdWrHMc8njj9HRNy1J0yeMZEBuFdxntdQvExf+
         LaRpBoCn2Hg3EIb05gIz0cA3Fq2EPc07sj/JW+/A=
Date:   Thu, 21 Nov 2019 22:10:17 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Rajat Jain <rajatja@google.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Frederick Lawler <fred@fredlawl.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Wong Vee Khee <vee.khee.wong@ni.com>,
        Hui Chun Ong <hui.chun.ong@ni.com>,
        Keith Busch <keith.busch@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 4/5] PCI/ASPM: Add sysfs attributes for controlling
 ASPM link states
Message-ID: <20191121211017.GA854512@kroah.com>
References: <b1c83f8a-9bf6-eac5-82d0-cf5b90128fbf@gmail.com>
 <20191121204924.GA81030@google.com>
 <CACK8Z6HTiMNOHx6favzWyN6ZbVD9d2WVmf6KTxt_n0O+EpJ97A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACK8Z6HTiMNOHx6favzWyN6ZbVD9d2WVmf6KTxt_n0O+EpJ97A@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 21, 2019 at 01:03:06PM -0800, Rajat Jain wrote:
> Hi,
> 
> On Thu, Nov 21, 2019 at 12:49 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > [+cc Rafael, Mika, Wong, Hui, Rajat, Keith, LKML, original patch at [5]]
> >
> > On Sat, Oct 05, 2019 at 02:07:56PM +0200, Heiner Kallweit wrote:
> >
> > > +What:                /sys/bus/pci/devices/.../link_pm/clkpm
> > > +             /sys/bus/pci/devices/.../link_pm/l0s_aspm
> > > +             /sys/bus/pci/devices/.../link_pm/l1_aspm
> > > +             /sys/bus/pci/devices/.../link_pm/l1_1_aspm
> > > +             /sys/bus/pci/devices/.../link_pm/l1_2_aspm
> > > +             /sys/bus/pci/devices/.../link_pm/l1_1_pcipm
> > > +             /sys/bus/pci/devices/.../link_pm/l1_2_pcipm
> > > +Date:                October 2019
> > > +Contact:     Heiner Kallweit <hkallweit1@gmail.com>
> > > +Description: If ASPM is supported for an endpoint, then these files
> > > +             can be used to disable or enable the individual
> > > +             power management states. Write y/1/on to enable,
> > > +             n/0/off to disable.
> >
> > This is queued up for the v5.5 merge window, so if we want to tweak
> > anything (path names or otherwise), now is the time.
> >
> > I think I might be inclined to change the directory from "link_pm" to
> > "link", e.g.,
> >
> >   - /sys/bus/pci/devices/0000:00:1c.0/link_pm/clkpm
> >   + /sys/bus/pci/devices/0000:00:1c.0/link/clkpm
> >
> > because there are other things that haven't been merged yet that could
> > go in link/ as well:
> >
> >   * Mika's "link disable" control [1]
> >   * Dilip's link width/speed controls [2,3]
> >
> > The max_link_speed, max_link_width, current_link_speed,
> > current_link_width files could also logically be in link/, although
> > they've already been merged at the top level.
> >
> > Rajat's AER statistics change [4] is also coming.  Those stats aren't
> > link-related, so they wouldn't go in link/.  The current strawman is
> > an "aer_stats" directory, but I wonder if we should make a more
> > generic directory like "errors" that could be used for both AER and
> > DPC and potentially other error-related things.
> 
> Sorry, I haven't been able to find time for it for some time. I doubt
> if I'll be able to make it to 5.6 timeframe. Nevertheless...
> 
> >
> > For example, we could have these link-related things:
> >
> >   /sys/.../0000:00:1c.0/link/clkpm            # RW ASPM stuff
> >   /sys/.../0000:00:1c.0/link/l0s_aspm
> >   /sys/.../0000:00:1c.0/link/...
> >   /sys/.../0000:00:1c.0/link/disable          # RW Mika
> >   /sys/.../0000:00:1c.0/link/speed            # RW Dilip's control
> >   /sys/.../0000:00:1c.0/link/width            # RW Dilip's control
> >   /sys/.../0000:00:1c.0/link/max_speed        # RO possible rework
> >   /sys/.../0000:00:1c.0/link/max_width        # RO possible rework
> >
> > With these backwards compatibility symlinks:
> >
> >   /sys/.../0000:00:1c.0/max_link_speed     -> link/max_speed
> >   /sys/.../0000:00:1c.0/current_link_speed -> link/speed
> >
> > Rajat's current patch puts the AER stats here at the top level:
> >
> >   /sys/.../0000:00:1c.0/aer_stats/fatal_bit4_DLP
> >
> > But maybe we could push them down like this:
> >
> >   /sys/.../0000:00:1c.0/errors/aer/stats/unc_04_dlp
> >   /sys/.../0000:00:1c.0/errors/aer/stats/unc_26_poison_tlb_blocked
> >   /sys/.../0000:00:1c.0/errors/aer/stats/cor_00_rx_err
> >   /sys/.../0000:00:1c.0/errors/aer/stats/cor_15_hdr_log_overflow
> 
> How do we create sub-sub-sub directories in sysfs (errors/aer/stats)?

You should not.

> My understanding is that we can only create 1 subdirectory by using a
> "named" attribute group. If we want more hierarchy, the "errors" and
> the "aer" will need to be backed up by a kobject. Doable, but just
> mentioning.

Not doable, you break userspace tools as they will not "see" those
directories or attributes.

Keep it only 1 deep if at all possible please.

thanks,

greg k-h
