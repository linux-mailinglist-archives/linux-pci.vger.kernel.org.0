Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD3F1F4A10
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jun 2020 01:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725999AbgFIXYh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Jun 2020 19:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbgFIXYf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 Jun 2020 19:24:35 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6A5C08C5C2
        for <linux-pci@vger.kernel.org>; Tue,  9 Jun 2020 16:24:34 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id c12so314760lfc.10
        for <linux-pci@vger.kernel.org>; Tue, 09 Jun 2020 16:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sMtF/qC2PC0Fc7hbbofyHpRlWklTrVKaPLffR+XkU1w=;
        b=a9UnKgq3w+NZfrSXnyBqyipJbKa0Tuo3dnojjNN8atnvbBP6GEk3z2QlX1imC756KM
         0tJiq6hRUkc6dTpdFJah7PgXagtdk+AxgsDwSbqw0U9Zjh/JncC/0El99i9r1N0/Spa6
         p79TY7zT08KC5mIDFXGG9IAfq+8wtHM+wYM1r/sqlIniOncZ4GBL++cTx9MCo26DcbPt
         L7r4sHXsT1zf22C0FSGNtjXqLMzG/mY8Z0AJe/Kj6nWXihSIHW8UzduTok+oObIwbse4
         DUSvWWtfZXEatB84BYi1qo8c/lFJgnXxYbt8snslXCBa6+I/s/0ZBGr0XWn1nx/F+MRf
         fvvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sMtF/qC2PC0Fc7hbbofyHpRlWklTrVKaPLffR+XkU1w=;
        b=tf4aD6wTgtA0SafbsL9tLayYomSlbHAPKFT8R/4oinrSzNiOBta8OC+5e0BT6K9/Te
         uwsK1H6bSFqxM3u+mWfm3+92m3+t1cXsEl0mGqH3BYEF5D9Vhq5xx1IgJmO0psy3cdUx
         R2KFIrBL/ZpMpt2UoGCXke5NkJIRCe7DxLOBB0nfef5mdlKckIus+VW33cUZQax8Pxqd
         bWqXO/3rjLxJrgMRWrFBQ/9gJU1t8fJUvsPNudSWGui8XtN3XIecOyh1WxUA2J24UMeS
         jztTCcSAEomhe2Z56sIEDYqc00OlVP7nZ+wBHNk6DlXrFYrtOVO2YAYXQeplCRUkiKZ2
         FwyA==
X-Gm-Message-State: AOAM532eKKRqUXiHct0rDio1y3uDe/R8/Ml6pzxLqIHAwyltx0zkslWu
        rad9dtK4Jtk+GpxCwtxfw0+C7x+v7V/eL3exCiOETA==
X-Google-Smtp-Source: ABdhPJzZrY0DI2VZNNrS4hhO2yx7vrk8VLovugxJWWKM5VjHU5bg/zH1GQOap9q4/SV4DIRAMadbJWFRtgiQBcfd3bo=
X-Received: by 2002:a19:434e:: with SMTP id m14mr151638lfj.40.1591745072660;
 Tue, 09 Jun 2020 16:24:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200607113632.GA49147@kroah.com> <20200609210400.GA1461839@bjorn-Precision-5520>
In-Reply-To: <20200609210400.GA1461839@bjorn-Precision-5520>
From:   Rajat Jain <rajatja@google.com>
Date:   Tue, 9 Jun 2020 16:23:54 -0700
Message-ID: <CACK8Z6E0s-Y207sb-AqSHVB7KmhvDgJQFFaz6ijQ_0OS3Qjisw@mail.gmail.com>
Subject: Re: [RFC] Restrict the untrusted devices, to bind to only a set of
 "whitelisted" drivers
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rajat Jain <rajatxjain@gmail.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Krishnakumar, Lalithambika" <lalithambika.krishnakumar@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Prashant Malani <pmalani@google.com>,
        Benson Leung <bleung@google.com>,
        Todd Broch <tbroch@google.com>,
        Alex Levin <levinale@google.com>,
        Mattias Nissler <mnissler@google.com>,
        Zubin Mithra <zsm@google.com>,
        Bernie Keany <bernie.keany@intel.com>,
        Aaron Durbin <adurbin@google.com>,
        Diego Rivas <diegorivas@google.com>,
        Duncan Laurie <dlaurie@google.com>,
        Furquan Shaikh <furquan@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Christian Kellner <christian@kellner.me>,
        Alex Williamson <alex.williamson@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

Thanks for sending out the summary, I was about to send it out but got lazy.

On Tue, Jun 9, 2020 at 2:04 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Sun, Jun 07, 2020 at 01:36:32PM +0200, Greg Kroah-Hartman wrote:
>
> > Your "problem" I think can be summed up a bit more concise:
> >       - you don't trust kernel drivers to be "secure" for untrusted
> >         devices
> >       - you only want to bind kernel drivers to "internal" devices
> >         automatically as you "trust" drivers in that situation.
> >       - you want to only bind specific kernel drivers that you somehow
> >         feel are "secure" to untrusted devices "outside" of a system
> >         when those devices are added to the system.
> >
> > Is that correct?
> >
> > If so, fine, you can do that today with the bind/unbind ability of
> > drivers, right?  After boot with your "trusted" drivers bound to
> > "internal" devices, turn off autobind of drivers to devices and then
> > manually bind them when you see new devices show up, as those "must" be
> > from external devices (see the bind/unbind files that all drivers export
> > for how to do this, and old lwn.net articles, this feature has been
> > around for a very long time.)
> >
> > I know for USB you can do this, odds are PCI you can turn off
> > autobinding as well, as I think this is a per-bus flag somewhere.  If
> > that's not exported to userspace, should be trivial to do so, should be
> > somewere in the driver model already...
> >
> > Ah, yes, look at the "drivers_autoprobe" and "drivers_probe" files in
> > sysfs for all busses.  Do those not work for you?
> >
> > My other points are the fact that you don't want to put policy in the
> > kernel, and I think that you can do everything you want in userspace
> > today, except maybe the fact that trying to determine what is "inside"
> > and "outside" is not always easy given that most hardware does not
> > export this information properly, if at all.  Go work with the firmware
> > people on that issue please, that would be most helpful for everyone
> > involved to get that finally straightened out.
>
> To sketch this out, my understanding of how this would work is:
>
>   - Expose the PCI pdev->untrusted bit in sysfs.  We don't expose this
>     today, but doing so would be trivial.  I think I would prefer a
>     sysfs name like "external" so it's more descriptive and less of a
>     judgment.

Yes. I think we should probably semantically differentiate between
"external" and "external facing" devices. Root ports and downstream
ports can be "external facing" but are actually internal devices.
Anything below an "external facing" device is "external". So the sysfs
attribute "external" should be set only for devices that are truly
external.

So I think we can possibly synthesize "external" sysfs attribute from
"untrusted" bit like this (Sorry code looks more complex than it is):

parent = pdev->bus->self;

if (pdev->untrusted) {
        if (parent && parent->untrusted)
                pdev->external = true;   /* Device downstream of
un-trusted device = external */
        else {
                pdev->external = false   /* Root complex or an
internal Downstream port */
} else {
        pdev->external = false; /* Trusted device = Internal device */
}

For platforms that don't expose and untrusted" device, everything is
assumed to be an "internal device".

Just a suggestion: Do you think an enum attribute may be better
instead, whose values could be "internal" / "external" /
"external-facing" in case need arises later to distinguish between
them?

>
>     This comes from either the DT "external-facing" property or the
>     ACPI "ExternalFacingPort" property.
>
>   - All devices present at boot are enumerated.  Any statically built
>     drivers will bind to them before any userspace code runs.

Yes. For our (thunderbolt / USB4) use case, we'd still be protected
because we can control the PCIe tunnels to thunderbolt / USB4 devices
and will not enable them until we are ready. So while this approach
may not work for a system that always enables PCIe connections to
external devices at boot, it works for our use case as we are looking
for only thunderbolt / USB4 devices. (Not a problem or concern, just
wanted to be clear).

>
>     If you want to keep statically built drivers from binding, you'd
>     need to invent some mechanism so pci_driver_init() could clear
>     drivers_autoprobe after registering pci_bus_type.

At present I am not planning this.

>
>   - Early userspace code prevents modular drivers from automatically
>     binding to PCI devices:
>
>       echo 0 > /sys/bus/pci/drivers_autoprobe

Yes.
I believe this setting will apply it equally to both modular and
statically linked drivers?

>
>     This prevents modular drivers from binding to all devices, whether
>     present at boot or hot-added.

Yes, at this time, the userspace will need to monitor udev events for
any new PCI devices hot added, and lookup the VID/DID in pci driver
database (Isn't it somewhere like modules.pcimap modules.dap or
something in /lib/modules?) to get the driver name. and then after
consulting a maintained whitelist, do the following:

>
>   - Userspace code uses the sysfs "bind" file to control which drivers
>     are loaded and can bind to each device, e.g.,
>
>       echo 0000:02:00.0 > /sys/bus/pci/drivers/nvme/bind
>
> Is that what you're thinking?  Is that enough for the control you
> need, Rajat?

Yes, It sounds like it. That is my current plan.

The one thing that still needs more thought is how about the
"pcieport" driver that enumerates the PCI bridges. I'm unsure if it
needs to be whitelisted for further enumeration downstream. What do
you think?

Thanks & Best Regards,

Rajat
