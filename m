Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8C420B8B8
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jun 2020 20:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725936AbgFZSyO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Jun 2020 14:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbgFZSyO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Jun 2020 14:54:14 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8797C03E979
        for <linux-pci@vger.kernel.org>; Fri, 26 Jun 2020 11:54:12 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id b25so7804443ljp.6
        for <linux-pci@vger.kernel.org>; Fri, 26 Jun 2020 11:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TyklzFj5dCuXNYg3v7eYVOhPNqVFIXACBXr++QvGvZI=;
        b=Q3jSm/c7nM2RMkN/kkJWHeLwAsdboqUxRzth/uSa6NXSM8oXMtiMhj9f8WBol97E5l
         ky6f/QaC4KZ4YCnTQZ3BF5dIXjlSPV4QoV2wqdt2Mxc0dLVha+jmh1N//dKeYUM0kj/p
         Cdd4nWsofe4nR1h6Arv8qYj2pSAqwLLlXKo4g4QCtxbm6LC94tNL9HBuchzz8CHS2BAX
         yl2h1pg/AJIJGgSiC33mfu7Wo9ZAOmNg5sJcT1GNiIaf52Hd/o1vV9XDmSUrR47ulwLj
         ref9AD+MOaS2oD3rCYWv+1d1sjD/0C8RZj9PYTuYlbI4YRzLWzNCmbCgcQYmWu2Ufvyd
         PAzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TyklzFj5dCuXNYg3v7eYVOhPNqVFIXACBXr++QvGvZI=;
        b=ANEfl7ozmJlcTsbYsVpk4oQ69uUNToJQdFHruguF6qdiaYQ+F4Wg65BFMzPCRWBPjs
         tbzPCcpOa+vo7uEVOVsB81/71vwc3+Qel+8GLA0Y6yq1p+OtHW5JfOT0AxEP82h3tgLU
         EPU3lmLLzvCf3LAXosFXIDkEwDypa151jFnhe9zTlK1T2qT3CwueC+2fT+XIcI2uYnfI
         qBxzdrf1+ACNtFsK4o8q7HnkVR76ymXxoHhGpGw2ajdiULkCSm1PYeMukLRm6LOi8OGq
         w4PCUBKumy91E9VU97SV1S7UMd4BOfWcxMiOb/HJ+k/cmRjz5b0ozC3xLLyvR+9zHmk/
         2Rtg==
X-Gm-Message-State: AOAM533gjGOQCZvrnUW5rJF16N/StMAAXLAXPRxsQRSQ29fGhXKl8GGa
        tdxyv/kKg98gKawwO6JWoqF9v2LQ0eGGG7800ZbKRg==
X-Google-Smtp-Source: ABdhPJwEBU78ak0v0VpTknwA5BsMJ5bdkxuMQYVuGSToCCXcbvo/1MlMlImhsgRKT5ooJzz29cDDIywFsWJMzVIeB2E=
X-Received: by 2002:a2e:858e:: with SMTP id b14mr2218327lji.301.1593197651010;
 Fri, 26 Jun 2020 11:54:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200626002710.110200-1-rajatja@google.com> <20200626002710.110200-2-rajatja@google.com>
 <20200626141754.GB4141629@kroah.com>
In-Reply-To: <20200626141754.GB4141629@kroah.com>
From:   Rajat Jain <rajatja@google.com>
Date:   Fri, 26 Jun 2020 11:53:34 -0700
Message-ID: <CACK8Z6GSN5iOaCh-ZMaJSY4SgEhw=bCRDzaiPEBJbNNFhZZX6Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] pci: Add parameter to disable attaching untrusted devices
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, iommu@lists.linux-foundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Krishnakumar, Lalithambika" <lalithambika.krishnakumar@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Prashant Malani <pmalani@google.com>,
        Benson Leung <bleung@google.com>,
        Todd Broch <tbroch@google.com>,
        Alex Levin <levinale@google.com>,
        Mattias Nissler <mnissler@google.com>,
        Rajat Jain <rajatxjain@gmail.com>,
        Bernie Keany <bernie.keany@intel.com>,
        Aaron Durbin <adurbin@google.com>,
        Diego Rivas <diegorivas@google.com>,
        Duncan Laurie <dlaurie@google.com>,
        Furquan Shaikh <furquan@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Christian Kellner <christian@kellner.me>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Oliver O'Halloran" <oohall@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

Thanks for taking a look.

On Fri, Jun 26, 2020 at 7:18 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Jun 25, 2020 at 05:27:10PM -0700, Rajat Jain wrote:
> > Introduce a PCI parameter that disables the automatic attachment of
> > untrusted devices to their drivers.
> >
> > Signed-off-by: Rajat Jain <rajatja@google.com>
> > ---
> > Context:
> >
> >   I set out to implement the approach outlined in
> >     https://lkml.org/lkml/2020/6/9/1331
> >     https://lkml.org/lkml/2020/6/15/1453
> >
> >   But to my surprise, I found that the new hotplugged PCI devices
> >   were getting automatically attached to drivers even though
> >   /sys/bus/pci/drivers_autoprobe was set to 0.
> >
> >   I realized that the device core's "drivers_autoprobe":
> >
> >   * only disables the *initial* probe of the device (i.e. from
> >     device_add()). If a subsystem calls device_attach() explicitly
> >     for its devices like PCI subsystem does, the drivers_autoprobe
> >     setting does not matter. The core will attach device to the driver.
> >     This looks like correct semantic behavior to me because PCI is
> >     explicitly calling device_attach(), which is a way to explicitly
> >     ask the core to find and attach a driver for a device.
> >
> >   * "drivers_autoprobe" cannot be controlled at boot time (to restrict
> >     any drivers before userspace comes up).
> >
> >   The options I considered were:
> >
> >   1) Change device_attach() so that it takes into consideration the
> >      drivers_autoprobe property. Not sure if this is semantically correct
> >      thing to do though. If I do this, then the only way a driver can
> >      be attached to the drivers would be via userspace
> >      (/sys/bus/pci/drivers/bind) (Good for our use case though!).
>
> This is the correct thing to do here, haven't I been asking you do move
> this logic into the driver core so that all busses can use it?

(please see below)

>
> >   2) Make the drivers_autoprobe property available to PCI to use
> >      (currently it is private to device core). The PCI could use this
> >      to determine whether or not to call device_attach(). This still
> >      leaves the other problem (of not being able to set
> >      drivers_autoprobe via command line open).
>
> Ick, command lines are horrible, don't do that if at all possible.  On
> some systems they are not able to be changed which can be good or bad...

(please see below)

>
> >   3) I found the pci_dev->match_driver, which seemed similar to what I
> >      am trying to do, but can't be controlled from userspace. I considered
> >      populating that field based on drivers_autoprobe (still need (2)).
> >      But the problem is that there is the AMD IOMMU driver which is setting
> >      this independently, so setting the match_driver based on
> >      drivers_autoprobe may not be a good idea. May be we can populate it
> >      for untrusted devicesi, based on the parameter that I'm introducing?
> >
> >   4) This patch was my option 4 that helps fix both the problems for me.
>
> I suggest putting some of the above text in the changelog, as it has a
> lot of good context, while your existing changelog is pretty sparse and
> does not explain anything...

Will do.

>
>
> >
> >  drivers/pci/bus.c | 11 ++++++++---
> >  drivers/pci/pci.c |  9 +++++++++
> >  drivers/pci/pci.h |  1 +
> >  3 files changed, 18 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> > index 3cef835b375fd..336aeeb4c4ebf 100644
> > --- a/drivers/pci/bus.c
> > +++ b/drivers/pci/bus.c
> > @@ -321,9 +321,14 @@ void pci_bus_add_device(struct pci_dev *dev)
> >       pci_bridge_d3_update(dev);
> >
> >       dev->match_driver = true;
> > -     retval = device_attach(&dev->dev);
> > -     if (retval < 0 && retval != -EPROBE_DEFER)
> > -             pci_warn(dev, "device attach failed (%d)\n", retval);
> > +
> > +     if (dev->untrusted && pci_dont_attach_untrusted_devs) {
> > +             pci_info(dev, "not attaching untrusted device\n");
> > +     } else {
> > +             retval = device_attach(&dev->dev);
> > +             if (retval < 0 && retval != -EPROBE_DEFER)
> > +                     pci_warn(dev, "device attach failed (%d)\n", retval);
> > +     }
> >
> >       pci_dev_assign_added(dev, true);
> >  }
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index ce096272f52b1..dec1f9ef27d71 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -127,6 +127,13 @@ static bool pcie_ats_disabled;
> >  /* If set, the PCI config space of each device is printed during boot. */
> >  bool pci_early_dump;
> >
> > +/*
> > + * If set, the devices with "untrusted" flag shall not be attached automatically
> > + * Userspace will need to attach them manually:
> > + * echo <pci device>  > /sys/bus/pci/drivers/<driver>/bind
> > + */
> > +bool pci_dont_attach_untrusted_devs;
> > +
> >  bool pci_ats_disabled(void)
> >  {
> >       return pcie_ats_disabled;
> > @@ -6522,6 +6529,8 @@ static int __init pci_setup(char *str)
> >                               pci_add_flags(PCI_SCAN_ALL_PCIE_DEVS);
> >                       } else if (!strncmp(str, "disable_acs_redir=", 18)) {
> >                               disable_acs_redir_param = str + 18;
> > +                     } else if (!strcmp(str, "dont_attach_untrusted_devs")) {
> > +                             pci_dont_attach_untrusted_devs = true;
> >                       } else {
> >                               pr_err("PCI: Unknown option `%s'\n", str);
> >                       }
> > diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> > index 6d3f758671064..30ffad047d926 100644
> > --- a/drivers/pci/pci.h
> > +++ b/drivers/pci/pci.h
> > @@ -13,6 +13,7 @@
> >
> >  extern const unsigned char pcie_link_speed[];
> >  extern bool pci_early_dump;
> > +extern bool pci_dont_attach_untrusted_devs;
> >
> >  bool pcie_cap_has_lnkctl(const struct pci_dev *dev);
> >  bool pcie_cap_has_rtctl(const struct pci_dev *dev);
> > --
> > 2.27.0.212.ge8ba1cc988-goog
> >
>
> What happened to the split of "trust" and "internal/external" logic that
> we discussed before?

a) I think what was decided was introducing a device core "location"
property that can be exposed to userspace to help it to decide whether
or not to attach a driver to a device. Yes, that is still the plan.
(Mild sidenote: userspace may not need to distinguish between internal
and external devices if it can assume that no internal PCI devices
will show up after "echo 0 > /sys/bus/pci/drivers_autoprobe". But
nevertheless...)

b) Note that even with (a) in place, we still need a parameter that
can ensure that drivers are not bound to external devices at boot,
*before* userspace gets a chance to disable "drivers_autoprobe".
https://lkml.org/lkml/2020/6/15/1453
Is it OK to add such a parameter in device core?

Thanks,

Rajat





> This seems to ignore all of that and go straight
> to some form of "we know what we trust, so all is fine!".
>
> It's not obvious what this is really doing here at all, sorry...
>
> greg k-h
