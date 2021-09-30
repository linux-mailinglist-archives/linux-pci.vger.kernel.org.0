Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C25AA41D5F2
	for <lists+linux-pci@lfdr.de>; Thu, 30 Sep 2021 11:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348938AbhI3JGy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Sep 2021 05:06:54 -0400
Received: from mail-ot1-f42.google.com ([209.85.210.42]:39505 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348505AbhI3JGy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Sep 2021 05:06:54 -0400
Received: by mail-ot1-f42.google.com with SMTP id j11-20020a9d190b000000b00546fac94456so6413383ota.6;
        Thu, 30 Sep 2021 02:05:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A0kBNA83hCb4HCc/FO3KjbqdDYyweltNhd4aS4t5/kU=;
        b=ZQ03FvJTEVQgULL5OLEhNdTmZvrPWMrXROd0pTRxLQZ+a6FeveJ+mcBQqrxogW1hQ5
         mdz0OPDeb36InyIXjRXRuu1rvSZWm60yjIZtW80Sm3TfQ760acisFrq0bATbPppPGVtW
         cuWt529BWO7y9B5RDxBC+rgdaeTgp5PTMKPTgLjtvQD1R6DmxL3zdiltg22154XI5r89
         1J8QwxfL47Jiv1P18MVOTs54AAS2ljT+v/lMkX9oEOZurxNi1lYYgBl2UXjpTUcJW8TJ
         pzdOlfzssehxDMidDcALXpEqUyEjK0/2p5gu7t38ywiP1V7mlIKnpifgk9aEGXf2aKAY
         cEbw==
X-Gm-Message-State: AOAM530FwqgiVHJN65gBistiziBI4/Qc3LOQgMmGfk9atCYeMDIMVHTI
        LYLS80UoHF3AMorsAnkfTEsMvqoPEVXohcQk2nk=
X-Google-Smtp-Source: ABdhPJxQvr32DBDvE9GooVKcASD2AsIl4lfSqdKR1BOYS2VPGs0tjNvE9npSlrVtmKJ8P2bAkPp+G83bpdvcAuxPNP4=
X-Received: by 2002:a05:6830:2784:: with SMTP id x4mr4274581otu.86.1632992711404;
 Thu, 30 Sep 2021 02:05:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210930010511.3387967-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210930010511.3387967-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210930014229.GA447956@rowland.harvard.edu> <CAPcyv4iiEC3B2i81evZpLP+XHa8dLkfgWmrY7HocORwP8FMPZQ@mail.gmail.com>
 <f9b7cf97-0a14-1c80-12ab-23213ec2f4f2@linux.intel.com> <CAPcyv4gDgQYf0ct_Xy32gQBcWhs6d2uL+wUq4pfzszDHcUHbwQ@mail.gmail.com>
In-Reply-To: <CAPcyv4gDgQYf0ct_Xy32gQBcWhs6d2uL+wUq4pfzszDHcUHbwQ@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 30 Sep 2021 11:05:00 +0200
Message-ID: <CAJZ5v0gOEffKJoH7P9=QOAxXFbMGOf9j0V1DsixQwaAehicnfA@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] driver core: Move the "authorized" attribute from
 USB/Thunderbolt to core
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jason Wang <jasowang@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 30, 2021 at 6:59 AM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Wed, Sep 29, 2021 at 7:39 PM Kuppuswamy, Sathyanarayanan
> <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
> >
> >
> >
> > On 9/29/21 6:55 PM, Dan Williams wrote:
> > >> Also, you ignored the usb_[de]authorize_interface() functions and
> > >> their friends.
> > > Ugh, yes.
> >
> > I did not change it because I am not sure about the interface vs device
> > dependency.
> >
>
> This is was the rationale for has_probe_authorization flag. USB
> performs authorization of child devices based on the authorization
> state of the parent interface.
>
> > I think following change should work.
> >
> > diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
> > index f57b5a7a90ca..84969732d09c 100644
> > --- a/drivers/usb/core/driver.c
> > +++ b/drivers/usb/core/driver.c
> > @@ -334,7 +334,7 @@ static int usb_probe_interface(struct device *dev)
> >         if (udev->dev.authorized == false) {
> >                 dev_err(&intf->dev, "Device is not authorized for usage\n");
> >                 return error;
> > -       } else if (intf->authorized == 0) {
> > +       } else if (intf->dev.authorized == 0) {
>
> == false

Or even (!intf->dev.authorized).

> >                 dev_err(&intf->dev, "Interface %d is not authorized for usage\n",
> >                                 intf->altsetting->desc.bInterfaceNumber);
> >                 return error;
> > @@ -546,7 +546,7 @@ int usb_driver_claim_interface(struct usb_driver *driver,
> >                 return -EBUSY;
> >
> >         /* reject claim if interface is not authorized */
> > -       if (!iface->authorized)
> > +       if (!iface->dev.authorized)
>
> I'd do == false to keep it consistent with other conversions.

But this looks odd, FWIW.
