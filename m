Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D196E37FF46
	for <lists+linux-pci@lfdr.de>; Thu, 13 May 2021 22:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233059AbhEMUgM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 May 2021 16:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232959AbhEMUgL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 May 2021 16:36:11 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF9FFC06174A
        for <linux-pci@vger.kernel.org>; Thu, 13 May 2021 13:35:00 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2so40232576lft.4
        for <linux-pci@vger.kernel.org>; Thu, 13 May 2021 13:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KrY5KBxRbqr/N+zWPtbQO+0iHVf/6xLbd2WWFf5zkXE=;
        b=bxOU9My3lmGVJSFRnbTRSHl9P3N7k0MMbptVK/37OKlEAzjH0g1lnd0ECT+Jisx0wW
         aHfZsmLawhD0Uf1o43iTvH/4ZzEZk5OQ1sq401azt/4bKq7vO/ZCamvHFKbwcjmMkhJ8
         4JePMv2sGKK7cXTnjXdXBRB+uFlGScv6TBv5V4SSaEjvFSk/4v2S3cLjyZ5ESI5V8p4r
         +HAslxEfxHYBwwXkrxeCbvFyjRViqG0tPFkMywbAPO9bpTZ1N8VO6R1VW+BbuPZIaJeZ
         YxyLnbPjC5+w1amKKeHy1nmgP4goAOhRM7hFsJoUndzEkdmjBJEgNroy39r8uQwWhwLR
         0xCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KrY5KBxRbqr/N+zWPtbQO+0iHVf/6xLbd2WWFf5zkXE=;
        b=Eo12tQXngHISEJrsuqm/+jWPippIgm2Qo932jYVMl06RaEAgDtYvx3nc9VZAorKSNC
         0MEYxgxNeprv+gLD2XcUKcRJCVak18J0tl3Mw9kTA9Dlwi7eiFYutg7xIqCQ5pe+LGeX
         ep/9DtJ7InZWS5zATIJr+L4ve1D1li4SVCT2g0ifFiEy3nxey0Pu+BOOctB94waRfpLB
         fv9o73YrhOuzRihAKfxeGZca6Ce4hDlM7P4nShY/UvYXi7StFTa7rlcUCKpq34s89NNV
         D/nV4aTR7kNf0EKVSRDTNdREgqI/Xg9gUVj6rvukVos9mwzy30Jp5LQ5C1WkcVF5MWdk
         WyVw==
X-Gm-Message-State: AOAM5327Sa7J4fMsNBOgrM39RH5WmlvN5dbalLT8C70MRCc1t5duDErE
        eGsjTVE4xFB+fyECZoaL96iD2iocQqMNjh6AVh5zR0kFJLeNVQ==
X-Google-Smtp-Source: ABdhPJznDnZDuChM48wSNc/74Afufn3c4ZSyJOXZKYLWqQTzM8c+e4f0gDHfW8mf48mr+GjGMuFLSRUzwcPsEZv8lQw=
X-Received: by 2002:ac2:414e:: with SMTP id c14mr30725547lfi.155.1620938099093;
 Thu, 13 May 2021 13:34:59 -0700 (PDT)
MIME-Version: 1.0
References: <CACK8Z6EPjcRwDB=r6RnsJRjHN4oJXTD0_8zbtUCA+awofY7=5Q@mail.gmail.com>
 <20210513200550.GA2604592@bjorn-Precision-5520>
In-Reply-To: <20210513200550.GA2604592@bjorn-Precision-5520>
From:   Rajat Jain <rajatja@google.com>
Date:   Thu, 13 May 2021 13:34:23 -0700
Message-ID: <CACK8Z6HENcAR-rKnQUVWU4jmqYqzsg95kbYRv3o5Gk7C+eXa-g@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] PCI: Add sysfs "removable" attribute
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        "open list:ULTRA-WIDEBAND (UWB) SUBSYSTEM:" 
        <linux-usb@vger.kernel.org>, Oliver Neukum <oneukum@suse.com>,
        David Laight <David.Laight@aculab.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rajat Jain <rajatxjain@gmail.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Dmitry Torokhov <dtor@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 13, 2021 at 1:05 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Thu, May 13, 2021 at 11:02:10AM -0700, Rajat Jain wrote:
> > On Wed, May 12, 2021 at 2:35 PM Rajat Jain <rajatja@google.com> wrote:
> > >
> > > A PCI device is "external_facing" if it's a Root Port with the ACPI
> > > "ExternalFacingPort" property or if it has the DT "external-facing"
> > > property.  We consider everything downstream from such a device to
> > > be removable by user.
> > >
> > > We're mainly concerned with consumer platforms with user accessible
> > > thunderbolt ports that are vulnerable to DMA attacks, and we expect those
> > > ports to be identified as "ExternalFacingPort". Devices in traditional
> > > hotplug slots can technically be removed, but the expectation is that
> > > unless the port is marked with "ExternalFacingPort", such devices are less
> > > accessible to user / may not be removed by end user, and thus not exposed
> > > as "removable" to userspace.
>
> s/thunderbolt/Thunderbolt/ since I think it's a trademark
> s/identified as/identified by firmware as/

Ack, will do.

>
> > > Set pci_dev_type.supports_removable so the device core exposes the
> > > "removable" file in sysfs, and tell the device core about removable
> > > devices.
> > >
> > > This can be used by userspace to implment any policies it wants to,
> > > tailored specifically for user removable devices. Eg usage:
> > > https://chromium-review.googlesource.com/c/chromiumos/platform2/+/2591812
> > > https://chromium-review.googlesource.com/c/chromiumos/platform2/+/2795038
> > > (code uses such an attribute to remove external PCI devicces or disable
> > > features on them as needed by the policy desired)
>
> s/implment/implement/
> s/devicces/devices/
>
> Or maybe something like:
>
>   This can be used to implement userspace policies tailored for
>   user-removable devices.

Ack, will do.

>
> Not sure exactly what "remove external PCI devices" means.  You're
> talking about the *code* doing something, so I don't think it means
> physically unplugging the device from the system.  Maybe preventing a
> driver from binding to it or something similar?

echo 1 > /sys/bus/pci/devices/<device>/remove

>
> I hesitate slightly to rely on URLs like googlesource.com in commit
> logs because we don't know how long they will remain valid.  But I
> guess there's no real alternative here, since this code probably
> hasn't been posted to any public mailing lists like the ones archived
> at https://lore.kernel.org/lists.html, right?

Yes, chromium reviews (userspace code that shall use the new
attribute) happen over gerrit, and so the publicly available links
would be googlesource.com.

>
> > > Signed-off-by: Rajat Jain <rajatja@google.com>
>
> > > +static void pci_set_removable(struct pci_dev *dev)
> > > +{
> > > +       struct pci_dev *parent = pci_upstream_bridge(dev);
> > > +       if (parent &&
> > > +           (parent->external_facing || dev_is_removable(&parent->dev)))
> > > +               dev_set_removable(&dev->dev, DEVICE_REMOVABLE);
> > > +       else
> > > +               dev_set_removable(&dev->dev, DEVICE_FIXED);
> > > +}
> >
> > Copying comments from Krzysztof from another thread:
> >
> > [Krzysztof] We were also wondering if we should only set DEVICE_REMOVABLE for
> > devices known to be behind an external-facing port, and let everything
> > else be set to "unknown" (or whatever the default would be).
> >
> > [Rajat]: I think I'm fine with this proposal if Bjorn & PCI community
> > also sees this as a better idea. Essentially the question here is,
> > would it be better for the non-removable PCI devices to be shown as
> > "fixed" or "unknown"?
>
> I think I would rather see this as:
>
>   struct pci_dev *parent = pci_upstream_bridge(dev);
>
>   if (parent &&
>       (parent->external_facing || dev_is_removable(&parent->dev)))
>           dev_set_removable(&dev->dev, DEVICE_REMOVABLE);
>
> In other words, assume only that everything below an "external-facing"
> device is removable.
>
> In the absence of an "external-facing" property, we don't know
> anything about the connection, and I'd rather use the default
> (probably "unknown") instead of assuming "fixed."

Ack, will do.

One question: Under Greg's latest suggestion, the decision to show
this attribute does not have to be bus wide / device_type wide i.e.
subsystem can choose for this attribute to show up only under certain
devices. So if it is more preferable, I can have this attribute show
under ONLY PCI devices that attach below "external-facing" PCI devices
(and any other PCI devices will not have this attribute show up at
all). I guess this sounds better than having "unknown" show up on the
rest of the devices that are not removable?

>
> I don't think we have anything that depends on "fixed," so I don't
> think there's value in setting it.
>
> (Note the blank line between local variables and the "if"; maybe
> that's what Greg hinted at?)

Ack, will remove the blank line (didn't know that blank lines between
variables and code is not preferred).

Thanks,
Rajat

>
> Bjorn
