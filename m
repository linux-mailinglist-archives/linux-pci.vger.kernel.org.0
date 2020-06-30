Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8F620F91C
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jun 2020 18:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbgF3QIq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Jun 2020 12:08:46 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42176 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726117AbgF3QIq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Jun 2020 12:08:46 -0400
Received: by mail-ot1-f67.google.com with SMTP id 76so4410060otu.9;
        Tue, 30 Jun 2020 09:08:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jQDz/WabqYjbF35ePxjq+94tU34dFjVcRR53QQxEhIE=;
        b=K1q9NJXTaJ3HUAez4QAa7bUgGd/B59WXkiVSTRwyVEJ5lir+keaS5BcKvwLftJmws4
         ZgsZo26J22s4uYGQj8T9NaDwtCFXkWmet1LzOXzbIniQ7I0jyi0lt2Uh9CDKLoruE2Oz
         vWDS5XxgVntVzkCSkY+pp8K5F7ruTuHSujPrNbgGg8/jc64J1fK5bZVK+RQZdedFwhoZ
         5DUpv0R4jlHPusEoEH3r36B2hcNQYPuwlNGldIL8AZleVi17D5XrebxrXBm07s1JHuYH
         Y2wyCNbV2YY34QcAFKWOw3f/MacIhCLSyEztLoOIfDDijAOcvihX6d96OiZy8SLkXyHG
         DlVQ==
X-Gm-Message-State: AOAM530kjvkx1t9KNdMVhqqUguYr//cKN6HVM8e8OnVpEFQBAJ30mhVp
        cgVgvssvfOjpWubRiz/o7Myp/cjuLcdWtTNxcMc=
X-Google-Smtp-Source: ABdhPJxaWnX9yrMQHErQh8Vw+ezc/MNNEhYcKVhPEqUi65LAtj57f/zeJ/ze1v+SS/GdZrhEkvjMvThwgj4FoHTcVQM=
X-Received: by 2002:a9d:1c82:: with SMTP id l2mr1108124ota.167.1593533322766;
 Tue, 30 Jun 2020 09:08:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200630044943.3425049-1-rajatja@google.com> <20200630044943.3425049-6-rajatja@google.com>
 <20200630104948.GC856968@kuha.fi.intel.com> <20200630125216.GA1109228@kroah.com>
 <CAJZ5v0iYFKrouQx_b7afPnz7ohjWOKKDhdHj_3HObKYV_rRhiw@mail.gmail.com> <20200630153816.GD1785141@kroah.com>
In-Reply-To: <20200630153816.GD1785141@kroah.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 30 Jun 2020 18:08:31 +0200
Message-ID: <CAJZ5v0jUx-RVhJRDngkOXx-3szFJDOgCJs2yuGKFyo2f1qZAwA@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] driver core: Add device location to "struct
 device" and expose it in sysfs
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Rajat Jain <rajatja@google.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
        lalithambika.krishnakumar@intel.com,
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
        "Oliver O'Halloran" <oohall@gmail.com>,
        Saravana Kannan <saravanak@google.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 30, 2020 at 5:38 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Jun 30, 2020 at 03:00:34PM +0200, Rafael J. Wysocki wrote:
> > On Tue, Jun 30, 2020 at 2:52 PM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Tue, Jun 30, 2020 at 01:49:48PM +0300, Heikki Krogerus wrote:
> > > > On Mon, Jun 29, 2020 at 09:49:41PM -0700, Rajat Jain wrote:
> > > > > Add a new (optional) field to denote the physical location of a device
> > > > > in the system, and expose it in sysfs. This was discussed here:
> > > > > https://lore.kernel.org/linux-acpi/20200618184621.GA446639@kroah.com/
> > > > >
> > > > > (The primary choice for attribute name i.e. "location" is already
> > > > > exposed as an ABI elsewhere, so settled for "site"). Individual buses
> > > > > that want to support this new attribute can opt-in by setting a flag in
> > > > > bus_type, and then populating the location of device while enumerating
> > > > > it.
> > > >
> > > > So why not just call it "physical_location"?
> > >
> > > That's better, and will allow us to put "3rd blue plug from the left,
> > > 4th row down" in there someday :)
> > >
> > > All of this is "relative" to the CPU, right?  But what CPU?  Again, how
> > > are the systems with drawers of PCI and CPUs and memory that can be
> > > added/removed at any point in time being handled here?  What is
> > > "internal" and "external" for them?
> > >
> > > What exactly is the physical boundry here that is attempting to be
> > > described?
> >
> > Also, where is the "physical location" information going to come from?
>
> Who knows?  :)
>
> Some BIOS seem to provide this, but do you trust that?
>
> > If that is the platform firmware (which I suspect is the anticipated
> > case), there may be problems with reliability related to that.
>
> s/may/will/
>
> which means making the kernel inact a policy like this patch series
> tries to add, will result in a lot of broken systems, which is why I
> keep saying that it needs to be done in userspace.
>
> It's as if some of us haven't been down this road before and just keep
> being ignored...
>
> {sigh}

Well, to be honest, if you are a "vertical" vendor and you control the
entire stack, *including* the platform firmware, it would be kind of
OK for you to do that in a product kernel.

However, this is not a practical thing to do in the mainline kernel
which must work for everybody, including people who happen to use
systems with broken or even actively unfriendly firmware on them.

So I'm inclined to say that IMO this series "as is" would not be an
improvement from the mainline perspective.

I guess it would make sense to have an attribute for user space to
write to in order to make the kernel reject device plug-in events
coming from a given port or connector, but the kernel has no reliable
means to determine *which* ports or connectors are "safe", and even if
there was a way for it to do that, it still may not agree with user
space on which ports or connectors should be regarded as "safe".

Cheers!
