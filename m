Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70A669697F
	for <lists+linux-pci@lfdr.de>; Tue, 20 Aug 2019 21:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730334AbfHTTcz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Aug 2019 15:32:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:42408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729409AbfHTTcz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Aug 2019 15:32:55 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CEB6A22DD3;
        Tue, 20 Aug 2019 19:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566329574;
        bh=tVq5rTWmr4OLwXUVTH015NoTG7lHhUq/tN9ZfrvxASs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QcGNXUJ2N5u97JnTrqCZtHMZ8x6TJwImxEzaGWtYbahz+jm7AyF5YTHpi16SPHeb3
         X/9GTQXT8BhNxeTPwmAn61YW/7dbFRUig/N+f1vu/+BtXkWV+jYUuFxcJobki+7doU
         EnwfRfYQ6MTpDcPuV2Q7t4xw2rd48SSonBfiHyEM=
Date:   Tue, 20 Aug 2019 14:32:52 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Rajat Jain <rajatja@google.com>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        Frederick Lawler <fred@fredlawl.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 3/3] PCI/ASPM: add sysfs attribute for controlling ASPM
Message-ID: <20190820193252.GB14450@google.com>
References: <7a6d2f14-f2a6-99ad-3a93-fdaa0726ce86@gmail.com>
 <a0c090cd-e3a4-f667-b99d-f31c48c2e0a3@gmail.com>
 <20190820103400.GY253360@google.com>
 <CACK8Z6HJBoJ_OkHEHY6oYtABDVwRx9eCh9GngHxGE63UPsOHig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACK8Z6HJBoJ_OkHEHY6oYtABDVwRx9eCh9GngHxGE63UPsOHig@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 20, 2019 at 12:05:01PM -0700, Rajat Jain wrote:
> On Tue, Aug 20, 2019 at 3:34 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Thu, May 23, 2019 at 10:05:35PM +0200, Heiner Kallweit wrote:
> > > Background of this extension is a problem with the r8169 network driver.
> > > Several combinations of board chipsets and network chip versions have
> > > problems if ASPM is enabled, therefore we have to disable ASPM per default.
> > > However especially on notebooks ASPM can provide significant power-saving,
> > > therefore we want to give users the option to enable ASPM. With the new sysfs
> > > attribute users can control which ASPM link-states are enabled/disabled.
> > >
> > > Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> > > ---
> > >  Documentation/ABI/testing/sysfs-bus-pci |  13 ++
> > >  drivers/pci/pci.h                       |   8 +-
> > >  drivers/pci/pcie/aspm.c                 | 180 +++++++++++++++++++++++-
> > >  3 files changed, 193 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
> > > index 8bfee557e..38fe358de 100644
> > > --- a/Documentation/ABI/testing/sysfs-bus-pci
> > > +++ b/Documentation/ABI/testing/sysfs-bus-pci
> > > @@ -347,3 +347,16 @@ Description:
> > >               If the device has any Peer-to-Peer memory registered, this
> > >               file contains a '1' if the memory has been published for
> > >               use outside the driver that owns the device.
> > > +
> > > +What:                /sys/bus/pci/devices/.../power/aspm_link_states
> > > +Date:                May 2019
> > > +Contact:     Heiner Kallweit <hkallweit1@gmail.com>
> > > +Description:
> > > +             If ASPM is supported for an endpoint, then this file can be
> > > +             used to enable / disable link states. A link state
> > > +             displayed in brackets is enabled, otherwise it's disabled.
> > > +             To control link states (case insensitive):
> > > +             +state : enables a supported state
> > > +             -state : disables a state
> > > +             none : disables all link states
> > > +             all : enables all supported link states
> >
> > IIUC this "aspm_link_states" file will contain things like this:
> >
> >   L0S L1 L1.1 L1.2                 # All states supported, all disabled
> >   [L0S] L1                         # L0s enabled, L1 supported but disabled
> >   [L0S] [L1]                       # L0s and L1 enabled
> >   ...
> >
> > and the control is by writing things like this to it:
> >
> >   +L1                              # enables L1
> >   +L1.1                            # enables L1.1
> >   -L0S                             # disables L0s
> >
> > I know this file structure is similar to protocol handling in
> > drivers/media/rc/rc-main.c, but Documentation/filesystems/sysfs.txt
> > suggests single values in a file, and Greg recently pointed out that
> > we screwed up some PCI AER stats [1].
> >
> > So I'm thinking maybe we should split this into several files, e.g.,
> >
> >   /sys/devices/pci*/.../power/aspm_l0s
> >   /sys/devices/pci*/.../power/aspm_l1
> >   /sys/devices/pci*/.../power/aspm_l1.1
> >   /sys/devices/pci*/.../power/aspm_l1.2
> >
> > which would contain just 1/0 values, and we'd write 1/0 to
> > enable/disable things.
> >
> > Since the L1 PM Substates control register has separate enable bits
> > for PCI-PM L1.1 and L1.2, we might also want a way to manage those.
> >
> > Bjorn
> >
> > [1] https://lore.kernel.org/r/20190621072911.GA21600@kroah.com
> 
> Sorry, this has been sitting on my plate for some time now. I'll work
> on it and send out a patch later in this week.

Don't worry, I cc'd you mostly as FYI because you're a recent
contributor to aspm.c in this area, though I wouldn't complain about
AER stats sysfs patches either :)

Bjorn
