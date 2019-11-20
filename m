Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41275103911
	for <lists+linux-pci@lfdr.de>; Wed, 20 Nov 2019 12:48:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728621AbfKTLsu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Nov 2019 06:48:50 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45590 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727619AbfKTLsu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Nov 2019 06:48:50 -0500
Received: by mail-ot1-f65.google.com with SMTP id r24so20906743otk.12;
        Wed, 20 Nov 2019 03:48:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8MBiO+KFBZB/AcMqbFFJ7k8IDkkWb2NJMLEEew3adx4=;
        b=j/vmUeO7bwfrJtBz9CAXZn794ThwP78FcXP2FCW1CuyTpi/prX5KOrhTWEWlXB116W
         lAC4CDYtd50ZiWXAAcZXKcWpZRm7EAuembQAJC4b9x6+r1OBFTfDTZZm4LlLvUtrWDLD
         okAV92r18cIz2E1HwcvpUeyIVUeHvALJ9tBIxxSf37E0OTZ9Gdbq4hDO+vi6rcxw5XUj
         fbhNdANPAOa4LOKn3QJttmwW9FCUzP0Vf5uGwXv4ZAOOQviPMDCHJRyu4oLN/5cuTJUh
         9zQe6RjotgIJCf5rV4dqCvGDlIfeB/8OpQliP8jdPNrcBomAwCSbXaifobtBVxgLg81T
         Z/dg==
X-Gm-Message-State: APjAAAXpur1RS3O5UiBzW+Dh1+VKiq0CbXG0xpQyLWLMXNuMoADu/1gs
        Ew3BPQP4qUMW9yvQS6JHBWl7bDWWR4HLO6sAbAk=
X-Google-Smtp-Source: APXvYqyzxG4SVTXB145c7Dh1NWcMTP2K36+6cukj2XkQmM4Og2QoAxYzwzeUb6AkFoNZ2YoI06hgPaa9Byig0su7cZ0=
X-Received: by 2002:a9d:7d01:: with SMTP id v1mr1591355otn.167.1574250527002;
 Wed, 20 Nov 2019 03:48:47 -0800 (PST)
MIME-Version: 1.0
References: <20191017121901.13699-1-kherbst@redhat.com> <20191119214955.GA223696@google.com>
 <CACO55tu+8VeyMw1Lb6QvNspaJm9LDgoRbooVhr0s3v9uBt=feg@mail.gmail.com>
 <20191120101816.GX11621@lahna.fi.intel.com> <CAJZ5v0g4vp1C+zHU5nOVnkGsOjBvLaphK1kK=qAT6b=mK8kpsA@mail.gmail.com>
 <20191120112212.GA11621@lahna.fi.intel.com>
In-Reply-To: <20191120112212.GA11621@lahna.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 20 Nov 2019 12:48:35 +0100
Message-ID: <CAJZ5v0in4VSULsfLshHxhNLf+NZxVQM0xx=hzdNa2X3FW=V7DA@mail.gmail.com>
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

On Wed, Nov 20, 2019 at 12:22 PM Mika Westerberg
<mika.westerberg@intel.com> wrote:
>
> On Wed, Nov 20, 2019 at 11:52:22AM +0100, Rafael J. Wysocki wrote:
> > On Wed, Nov 20, 2019 at 11:18 AM Mika Westerberg
> > <mika.westerberg@intel.com> wrote:
> > >
> > > Hi Karol,
> > >
> > > On Tue, Nov 19, 2019 at 11:26:45PM +0100, Karol Herbst wrote:
> > > > On Tue, Nov 19, 2019 at 10:50 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > >
> > > > > [+cc Dave]
> > > > >
> > > > > On Thu, Oct 17, 2019 at 02:19:01PM +0200, Karol Herbst wrote:
> > > > > > Fixes state transitions of Nvidia Pascal GPUs from D3cold into higher device
> > > > > > states.
> > > > > >
> > > > > > v2: convert to pci_dev quirk
> > > > > >     put a proper technical explanation of the issue as a in-code comment
> > > > > > v3: disable it only for certain combinations of intel and nvidia hardware
> > > > > > v4: simplify quirk by setting flag on the GPU itself
> > > > >
> > > > > I have zero confidence that we understand the real problem, but we do
> > > > > need to do something with this.  I'll merge it for v5.5 if we get the
> > > > > minor procedural stuff below straightened out.
> > > > >
> > > >
> > > > Thanks, and I agree with your statement, but at this point I think
> > > > only Intel can help out digging deeper as I see no way to debug this
> > > > further.
> > >
> > > I don't have anything against this patch, as long as the quirk stays
> > > limited to the particular root port leading to the NVIDIA GPU. The
> > > reason why I think it should to be limited is that I'm pretty certain
> > > the problem is not in the root port itself. I have here a KBL based
> > > Thinkpad X1 Carbon 6th gen that can put the TBT controller into D3cold
> > > (it is connected to PCH root port) and it wakes up there just fine, so
> > > don't want to break that.
> > >
> > > Now, PCIe devices cannot go into D3cold all by themselves. They always
> > > need help from the platform side which is ACPI in this case. This is
> > > done by having the device to have _PR3 method that returns one or more
> > > power resources that the OS is supposed to turn off when the device is
> > > put into D3cold. All of that is implemented as form of ACPI methods that
> > > pretty much do the hardware specific things that are outside of PCIe
> > > spec to get the device into D3cold. At high level the _OFF() method
> > > causes the root port to broadcast PME_Turn_Off message that results the
> > > link to enter L2/3 ready, it then asserts PERST, configures WAKE (both
> > > can be GPIOs) and finally removes power (if the link goes into L3,
> > > otherwise it goes into L2).
> > >
> > > I think this is where the problem actually lies - the ASL methods that
> > > are used to put the device into D3cold and back. We know that in Windows
> > > this all works fine so unless Windows quirks the root port the same way
> > > there is another reason behind this.
> > >
> > > In case of Dell XPS 9560 (IIRC that's the machine you have) the
> > > corresponding power resource is called \_SB.PCI0.PEG0.PG00 and its
> > > _ON/_OFF methods end up calling PGON()/PGOF() accordingly. The methods
> > > itself do lots of things and it is hard to follow the dissassembled
> > > ASL which does not have any comments but there are couple of things that
> > > stand out where we may go into a different path. One of them is this in
> > > the PGOF() method:
> > >
> > >    If (((OSYS <= 0x07D9) || ((OSYS == 0x07DF) && (_REV == 0x05))))
> > >
> > > The ((OSYS == 0x07DF) && (_REV == 0x05)) checks specifically for Linux
> > > (see [1] and 18d78b64fddc ("ACPI / init: Make it possible to override
> > > _REV")) so it might be that Dell people tested this at some point in
> > > Linux as well. Added Mario in case he has any ideas.
> > >
> > > Previously I suggested you to try the ACPI method tracing to see what
> > > happens inside PGOF(). Did you have time to try it? It may provide more
> > > information about that is happening inside those methods and hopefully
> > > point us to the root cause.
> > >
> > > Also if you haven't tried already passing acpi_rev_override in the
> > > command line makes the _REV to return 5 so it should go into the "Linux"
> > > path in PGOF().
> >
> > Oh, so does it look like we are trying to work around AML that tried
> > to work around some problematic behavior in Linux at one point?
>
> Yes, it looks like so if I read the ASL right.

OK, so that would call for a DMI-based quirk as the real cause for the
issue seems to be the AML in question, which means a firmware problem.
