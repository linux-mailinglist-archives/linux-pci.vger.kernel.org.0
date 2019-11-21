Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9008105738
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2019 17:39:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbfKUQje (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Nov 2019 11:39:34 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34978 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbfKUQje (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Nov 2019 11:39:34 -0500
Received: by mail-ot1-f65.google.com with SMTP id 23so1715747otf.2;
        Thu, 21 Nov 2019 08:39:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4IrWX6mmJ7b0mwXpxOSU05DSHjWhwtw3uJnCs1X0/To=;
        b=uORh8vgE7pSPRWkrAVlqDgJE7rMnWh5fze8TQgNclvMHwRJr+mgkUgIAwWtvufsYsk
         w04/NVlJbGcwDVIg3fqMVTTm8W1y3Ji54GQ1sgpx1fLkthoWcqPOOua4whGlFXF5ps9D
         v2pk7cUnd6cKCeUUJP3MUnRARSva+xGMHaMr+gWMDbJiirCFeY3VFtxx1dhTUxLDyzJV
         2GwjHxsynEUTAXcpd4V0oxY2sKwBar7/hD+Cmif8P+3vp1h3blPGHAMS3LYTZIHzX3U6
         qQ5jYSniKIsjH7wPsxNgh/2VPH+ugB05XFbsMyBCUOtYldq/X386S+wTanBrTL6Fd7CD
         fdxw==
X-Gm-Message-State: APjAAAW8GvZsHkNf4YMaqmpqmYLLOWZcjXt7PbUyn3E7nFy4Og0z/iWL
        K9IFzDfEmYsvzAggMZYb58yjbUBJYm/PDHwIrKM=
X-Google-Smtp-Source: APXvYqw6yon06gwMBAkTS9wKaEXc0zY3KLNduZz9aAoaAE9fqyZLVmoRNCkTobjOW0RmAi51YDxLQ+kr/wefdJcTvpQ=
X-Received: by 2002:a9d:7d01:: with SMTP id v1mr6911159otn.167.1574354372881;
 Thu, 21 Nov 2019 08:39:32 -0800 (PST)
MIME-Version: 1.0
References: <20191120120913.GE11621@lahna.fi.intel.com> <CACO55tsHy6yZQZ8PkdW8iPA7+uc5rdcEwRJwYEQ3iqu85F8Sqg@mail.gmail.com>
 <20191120151542.GH11621@lahna.fi.intel.com> <CACO55tvo3rbPtYJcioEgXCEQqVXcVAm-iowr9Nim=bgTdMjgLw@mail.gmail.com>
 <20191120155301.GL11621@lahna.fi.intel.com> <CAJZ5v0hkT-fHFOQKzp2qYPyR+NUa4c-G-uGLPZuQxqsG454PiQ@mail.gmail.com>
 <CACO55ttTPi2XpRRM_NYJU5c5=OvG0=-YngFy1BiR8WpHkavwXw@mail.gmail.com>
 <CAJZ5v0h=7zu3A+ojgUSmwTH0KeXmYP5OKDL__rwkkWaWqcJcWQ@mail.gmail.com>
 <20191121112821.GU11621@lahna.fi.intel.com> <CAJZ5v0hQhj5Wf+piU11abC4pF26yM=XHGHAcDv8Jsgdx04aN-w@mail.gmail.com>
 <20191121114610.GW11621@lahna.fi.intel.com> <CACO55ttXJgXG32HzYP_uJDfQ6T-d8zQaGjXK_AZD3kF0Rmft4g@mail.gmail.com>
 <CAJZ5v0ibzcLEm44udUxW2uVgaF9NapdNBF8Ag+RE++u7gi2yNA@mail.gmail.com> <CACO55ttBkZD9dm0Y_jT931NnzHHtDFyLz28aoo+ZG0pnLzPgbA@mail.gmail.com>
In-Reply-To: <CACO55ttBkZD9dm0Y_jT931NnzHHtDFyLz28aoo+ZG0pnLzPgbA@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 21 Nov 2019 17:39:21 +0100
Message-ID: <CAJZ5v0jbh7jz+YQcw-gC5ztmMOc4E9+KFBCy4VGRsRFxBw-gnw@mail.gmail.com>
Subject: Re: [PATCH v4] pci: prevent putting nvidia GPUs into lower device
 states on certain intel bridges
To:     Karol Herbst <kherbst@redhat.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@intel.com>,
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

On Thu, Nov 21, 2019 at 5:06 PM Karol Herbst <kherbst@redhat.com> wrote:
>
> On Thu, Nov 21, 2019 at 4:47 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Thu, Nov 21, 2019 at 1:53 PM Karol Herbst <kherbst@redhat.com> wrote:
> > >
> > > On Thu, Nov 21, 2019 at 12:46 PM Mika Westerberg
> > > <mika.westerberg@intel.com> wrote:
> > > >
> > > > On Thu, Nov 21, 2019 at 12:34:22PM +0100, Rafael J. Wysocki wrote:
> > > > > On Thu, Nov 21, 2019 at 12:28 PM Mika Westerberg
> > > > > <mika.westerberg@intel.com> wrote:
> > > > > >
> > > > > > On Wed, Nov 20, 2019 at 11:29:33PM +0100, Rafael J. Wysocki wrote:
> > > > > > > > last week or so I found systems where the GPU was under the "PCI
> > > > > > > > Express Root Port" (name from lspci) and on those systems all of that
> > > > > > > > seems to work. So I am wondering if it's indeed just the 0x1901 one,
> > > > > > > > which also explains Mikas case that Thunderbolt stuff works as devices
> > > > > > > > never get populated under this particular bridge controller, but under
> > > > > > > > those "Root Port"s
> > > > > > >
> > > > > > > It always is a PCIe port, but its location within the SoC may matter.
> > > > > >
> > > > > > Exactly. Intel hardware has PCIe ports on CPU side (these are called
> > > > > > PEG, PCI Express Graphics, ports), and the PCH side. I think the IP is
> > > > > > still the same.
> > > > > >
> > >
> > > yeah, I meant the bridge controller with the ID 0x1901 is on the CPU
> > > side. And if the Nvidia GPU is on a port on the PCH side it all seems
> > > to work just fine.
> >
> > But that may involve different AML too, may it not?
> >
> > > > > > > Also some custom AML-based power management is involved and that may
> > > > > > > be making specific assumptions on the configuration of the SoC and the
> > > > > > > GPU at the time of its invocation which unfortunately are not known to
> > > > > > > us.
> > > > > > >
> > > > > > > However, it looks like the AML invoked to power down the GPU from
> > > > > > > acpi_pci_set_power_state() gets confused if it is not in PCI D0 at
> > > > > > > that point, so it looks like that AML tries to access device memory on
> > > > > > > the GPU (beyond the PCI config space) or similar which is not
> > > > > > > accessible in PCI power states below D0.
> > > > > >
> > > > > > Or the PCI config space of the GPU when the parent root port is in D3hot
> > > > > > (as it is the case here). Also then the GPU config space is not
> > > > > > accessible.
> > > > >
> > > > > Why would the parent port be in D3hot at that point?  Wouldn't that be
> > > > > a suspend ordering violation?
> > > >
> > > > No. We put the GPU into D3hot first, then the root port and then turn
> > > > off the power resource (which is attached to the root port) resulting
> > > > the topology entering D3cold.
> > > >
> > >
> > > If the kernel does a D0 -> D3hot -> D0 cycle this works as well, but
> > > the power savings are way lower, so I kind of prefer skipping D3hot
> > > instead of D3cold. Skipping D3hot doesn't seem to make any difference
> > > in power savings in my testing.
> >
> > OK
> >
> > What exactly did you do to skip D3cold in your testing?
> >
>
> For that I poked into the PCI registers directly and skipped doing the
> ACPI calls and simply checked for the idle power consumption on my
> laptop.

That doesn't involve the PCIe port PM, however.

> But I guess I should retest with calling pci_d3cold_disable
> from nouveau instead? Or is there a different preferable way of
> testing this?

There is a sysfs attribute called "d3cold_allowed" which can be used
for "blocking" D3cold, so can you please retest using that?
