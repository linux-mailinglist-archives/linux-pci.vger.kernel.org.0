Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC2E1045ED
	for <lists+linux-pci@lfdr.de>; Wed, 20 Nov 2019 22:40:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbfKTVkq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Nov 2019 16:40:46 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:52223 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725878AbfKTVkq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Nov 2019 16:40:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574286044;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m0UeIrv+uB8K82TvFxL5crQCuye0zjRqSJxGE7ek3js=;
        b=WcbdPyrx/D5ok+l/4KnzfttBumDDIK5+HalwlWrgcZKvgjPOAVkvTTMAQ3y+K/UqCYDDDP
        969bWBKKcjYbnaoEcq6qKHNCy+ibLA4KaTLp/NcRpVBBpUGHsBxxijU+LaAKIWEQGdDaj4
        HHnTUE2SvEW7Fket0Sf2lnitUOQnFYM=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-F70PIxLNPmuik6ObdkJFNw-1; Wed, 20 Nov 2019 16:40:43 -0500
Received: by mail-qk1-f198.google.com with SMTP id o11so621928qkk.7
        for <linux-pci@vger.kernel.org>; Wed, 20 Nov 2019 13:40:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EU4N8GpbC4c7LlzThQCdmuVdlky1o8wM503FH5Pe0D4=;
        b=U9V3wIdBOCnsUwrRERnEiS74l86WeVJ+lxybQVhhBRrycHNz+1sZEAXXMhOZkQqdDM
         fo5eLqhGjTffOmjE9LSVdQvUwP6VLH+paXCC2yekCTZKnCzbBY/0NzHvJ61Y4+vRSMQZ
         9o2WtMPv/Xbvo+6xgWl/KXNYLXmblwxAIIdd/ckWrIlBhGGIs3WrSqgk61ngkJXT7XV6
         3pFvn9AMzfFC8SYPjvpYcfbaM06T42mlFfvhvP5n0DfZ17zMySg4i7NEkxcB/DqRvZu5
         84BgyE2Q7+R6rOu/IYB6EcZCY3y6m3cputRQiaJwzixKYztMrcTbn6WGtvY4pesHi3vA
         o4ZQ==
X-Gm-Message-State: APjAAAUY6w0aeIYFm15Syz6daOcCOUbGSb2/9wA7GFVN6Zka0z15XdRP
        lE9Rns+u0Mf0+yreid7c/pvp8y6rL0JW4S1wm4ivL2ivy4sieUVYpZ0ORn2QuM1nEMOcCLJBKne
        LX3RFmEbi8nBcGKsGo3+6opEeF5FqGprBlBCu
X-Received: by 2002:ac8:5557:: with SMTP id o23mr5052345qtr.378.1574286043265;
        Wed, 20 Nov 2019 13:40:43 -0800 (PST)
X-Google-Smtp-Source: APXvYqw5XTIwl9ODy32VuneMOt1E61xccRRZ15L75RSP9d7Zx2Qa1IB4KTIGuXzijkXHVfuff9mnLwrRh/jCuBCSby4=
X-Received: by 2002:ac8:5557:: with SMTP id o23mr5052335qtr.378.1574286043027;
 Wed, 20 Nov 2019 13:40:43 -0800 (PST)
MIME-Version: 1.0
References: <20191120101816.GX11621@lahna.fi.intel.com> <CAJZ5v0g4vp1C+zHU5nOVnkGsOjBvLaphK1kK=qAT6b=mK8kpsA@mail.gmail.com>
 <20191120112212.GA11621@lahna.fi.intel.com> <20191120115127.GD11621@lahna.fi.intel.com>
 <CACO55tsfNOdtu5SZ-4HzO4Ji6gQtafvZ7Rm19nkPcJAgwUBFMw@mail.gmail.com>
 <CACO55tscD_96jUVts+MTAUsCt-fZx4O5kyhRKoo4mKoC84io8A@mail.gmail.com>
 <20191120120913.GE11621@lahna.fi.intel.com> <CACO55tsHy6yZQZ8PkdW8iPA7+uc5rdcEwRJwYEQ3iqu85F8Sqg@mail.gmail.com>
 <20191120151542.GH11621@lahna.fi.intel.com> <CACO55tvo3rbPtYJcioEgXCEQqVXcVAm-iowr9Nim=bgTdMjgLw@mail.gmail.com>
 <20191120155301.GL11621@lahna.fi.intel.com> <CAJZ5v0hkT-fHFOQKzp2qYPyR+NUa4c-G-uGLPZuQxqsG454PiQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0hkT-fHFOQKzp2qYPyR+NUa4c-G-uGLPZuQxqsG454PiQ@mail.gmail.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Wed, 20 Nov 2019 22:40:31 +0100
Message-ID: <CACO55ttTPi2XpRRM_NYJU5c5=OvG0=-YngFy1BiR8WpHkavwXw@mail.gmail.com>
Subject: Re: [PATCH v4] pci: prevent putting nvidia GPUs into lower device
 states on certain intel bridges
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Mika Westerberg <mika.westerberg@intel.com>,
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
X-MC-Unique: F70PIxLNPmuik6ObdkJFNw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 20, 2019 at 10:37 PM Rafael J. Wysocki <rafael@kernel.org> wrot=
e:
>
> On Wed, Nov 20, 2019 at 4:53 PM Mika Westerberg
> <mika.westerberg@intel.com> wrote:
> >
> > On Wed, Nov 20, 2019 at 04:37:14PM +0100, Karol Herbst wrote:
> > > On Wed, Nov 20, 2019 at 4:15 PM Mika Westerberg
> > > <mika.westerberg@intel.com> wrote:
> > > >
> > > > On Wed, Nov 20, 2019 at 01:11:52PM +0100, Karol Herbst wrote:
> > > > > On Wed, Nov 20, 2019 at 1:09 PM Mika Westerberg
> > > > > <mika.westerberg@intel.com> wrote:
> > > > > >
> > > > > > On Wed, Nov 20, 2019 at 12:58:00PM +0100, Karol Herbst wrote:
> > > > > > > overall, what I really want to know is, _why_ does it work on=
 windows?
> > > > > >
> > > > > > So do I ;-)
> > > > > >
> > > > > > > Or what are we doing differently on Linux so that it doesn't =
work? If
> > > > > > > anybody has any idea on how we could dig into this and figure=
 it out
> > > > > > > on this level, this would probably allow us to get closer to =
the root
> > > > > > > cause? no?
> > > > > >
> > > > > > Have you tried to use the acpi_rev_override parameter in your s=
ystem and
> > > > > > does it have any effect?
> > > > > >
> > > > > > Also did you try to trace the ACPI _ON/_OFF() methods? I think =
that
> > > > > > should hopefully reveal something.
> > > > > >
> > > > >
> > > > > I think I did in the past and it seemed to have worked, there is =
just
> > > > > one big issue with this: it's a Dell specific workaround afaik, a=
nd
> > > > > this issue plagues not just Dell, but we've seen it on HP and Len=
ovo
> > > > > laptops as well, and I've heard about users having the same issue=
s on
> > > > > Asus and MSI laptops as well.
> > > >
> > > > Maybe it is not a workaround at all but instead it simply determine=
s
> > > > whether the system supports RTD3 or something like that (IIRC Windo=
ws 8
> > > > started supporting it). Maybe Dell added check for Linux because at=
 that
> > > > time Linux did not support it.
> > > >
> > >
> > > the point is, it's not checking it by default, so by default you stil=
l
> > > run into the windows 8 codepath.
> >
> > Well you can add the quirk to acpi_rev_dmi_table[] so it goes to that
> > path by default. There are a bunch of similar entries for Dell machines=
.
>
> OK, so the "Linux path" works and the other doesn't.
>
> I thought that this was the other way around, sorry for the confusion.
>
> > Of course this does not help the non-Dell users so we would still need
> > to figure out the root cause.
>
> Right.
>
> Whatever it is, though, AML appears to be involved in it and AFAICS
> there's no evidence that it affects any root ports that are not
> populated with NVidia GPUs.
>

last week or so I found systems where the GPU was under the "PCI
Express Root Port" (name from lspci) and on those systems all of that
seems to work. So I am wondering if it's indeed just the 0x1901 one,
which also explains Mikas case that Thunderbolt stuff works as devices
never get populated under this particular bridge controller, but under
those "Root Port"s

> Now, one thing is still not clear to me from the discussion so far: is
> the _PR3 method you mentioned defined under the GPU device object or
> under the port device object?
>

