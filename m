Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C839610517E
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2019 12:34:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbfKULef (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Nov 2019 06:34:35 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:32932 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbfKULef (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Nov 2019 06:34:35 -0500
Received: by mail-ot1-f68.google.com with SMTP id u13so2648633ote.0;
        Thu, 21 Nov 2019 03:34:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kuqs327pUhPcYZgV8CR1QRbPOc0dkeg/XwrNu/owu1o=;
        b=Rf63ka8JaHij+58jN/MC52o6+z/uqnyeoXo12S8lbV+xA+c+JoiArrrSWwPicbIkuz
         mBo6RxYOAi1/eatFM6rKsmhCKQo1yG4x88HjknummjrkdCWtvpCOPuveUlKBYeOz/Tgg
         XCAxyJgpI2oorzOHYa6Yi8R6mqnxH0IcF0MomsDEu97h160JU46uDo9Ug/aibY+7aI9p
         WzS7pFTGU3nylxNaQcC/cd58cufYmP52T0WYhwyeK41ko6LXhh2+YW4u5xcvg3b/fX1U
         KjLlaLammzRR9dOewUmn4deg7CChHceEfEaPuDt4a865eOyEEkovAB/KHkgHmN7zBsv4
         NmxA==
X-Gm-Message-State: APjAAAXEW0fO1hboxxg3lVEbQepzVWvyIXrTso8qgOE7aTl9bXOzqNyi
        Uvw5G4CLtwqEiZRkioJMObiXyZT0z+nWXJ9p6Zc=
X-Google-Smtp-Source: APXvYqy+gJzz6eLtFc3d/wbKk0w7lTaILzB/lspRYo4XruXCjYN7NRCgCvcvUCZmIe0BinxitYhww1KtRDfarQFUdcY=
X-Received: by 2002:a05:6830:103:: with SMTP id i3mr6231632otp.266.1574336073815;
 Thu, 21 Nov 2019 03:34:33 -0800 (PST)
MIME-Version: 1.0
References: <CACO55tsfNOdtu5SZ-4HzO4Ji6gQtafvZ7Rm19nkPcJAgwUBFMw@mail.gmail.com>
 <CACO55tscD_96jUVts+MTAUsCt-fZx4O5kyhRKoo4mKoC84io8A@mail.gmail.com>
 <20191120120913.GE11621@lahna.fi.intel.com> <CACO55tsHy6yZQZ8PkdW8iPA7+uc5rdcEwRJwYEQ3iqu85F8Sqg@mail.gmail.com>
 <20191120151542.GH11621@lahna.fi.intel.com> <CACO55tvo3rbPtYJcioEgXCEQqVXcVAm-iowr9Nim=bgTdMjgLw@mail.gmail.com>
 <20191120155301.GL11621@lahna.fi.intel.com> <CAJZ5v0hkT-fHFOQKzp2qYPyR+NUa4c-G-uGLPZuQxqsG454PiQ@mail.gmail.com>
 <CACO55ttTPi2XpRRM_NYJU5c5=OvG0=-YngFy1BiR8WpHkavwXw@mail.gmail.com>
 <CAJZ5v0h=7zu3A+ojgUSmwTH0KeXmYP5OKDL__rwkkWaWqcJcWQ@mail.gmail.com> <20191121112821.GU11621@lahna.fi.intel.com>
In-Reply-To: <20191121112821.GU11621@lahna.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 21 Nov 2019 12:34:22 +0100
Message-ID: <CAJZ5v0hQhj5Wf+piU11abC4pF26yM=XHGHAcDv8Jsgdx04aN-w@mail.gmail.com>
Subject: Re: [PATCH v4] pci: prevent putting nvidia GPUs into lower device
 states on certain intel bridges
To:     Mika Westerberg <mika.westerberg@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Karol Herbst <kherbst@redhat.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lyude Paul <lyude@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau <nouveau@lists.freedesktop.org>,
        Dave Airlie <airlied@gmail.com>,
        Mario Limonciello <Mario.Limonciello@dell.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 21, 2019 at 12:28 PM Mika Westerberg
<mika.westerberg@intel.com> wrote:
>
> On Wed, Nov 20, 2019 at 11:29:33PM +0100, Rafael J. Wysocki wrote:
> > > last week or so I found systems where the GPU was under the "PCI
> > > Express Root Port" (name from lspci) and on those systems all of that
> > > seems to work. So I am wondering if it's indeed just the 0x1901 one,
> > > which also explains Mikas case that Thunderbolt stuff works as devices
> > > never get populated under this particular bridge controller, but under
> > > those "Root Port"s
> >
> > It always is a PCIe port, but its location within the SoC may matter.
>
> Exactly. Intel hardware has PCIe ports on CPU side (these are called
> PEG, PCI Express Graphics, ports), and the PCH side. I think the IP is
> still the same.
>
> > Also some custom AML-based power management is involved and that may
> > be making specific assumptions on the configuration of the SoC and the
> > GPU at the time of its invocation which unfortunately are not known to
> > us.
> >
> > However, it looks like the AML invoked to power down the GPU from
> > acpi_pci_set_power_state() gets confused if it is not in PCI D0 at
> > that point, so it looks like that AML tries to access device memory on
> > the GPU (beyond the PCI config space) or similar which is not
> > accessible in PCI power states below D0.
>
> Or the PCI config space of the GPU when the parent root port is in D3hot
> (as it is the case here). Also then the GPU config space is not
> accessible.

Why would the parent port be in D3hot at that point?  Wouldn't that be
a suspend ordering violation?

> I took a look at the HP Omen ACPI tables which has similar problem and
> there is also check for Windows 7 (but not Linux) so I think one
> alternative workaround would be to add these devices into
> acpi_osi_dmi_table[] where .callback is set to dmi_disable_osi_win8 (or
> pass 'acpi_osi="!Windows 2012"' in the kernel command line).

I'd like to understand the facts that have been established so far
before deciding what to do about them. :-)
