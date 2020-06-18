Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3537B1FFA18
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jun 2020 19:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732090AbgFRRYU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Jun 2020 13:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732095AbgFRRYT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Jun 2020 13:24:19 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C8AC0613EE
        for <linux-pci@vger.kernel.org>; Thu, 18 Jun 2020 10:24:19 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id n24so8188535lji.10
        for <linux-pci@vger.kernel.org>; Thu, 18 Jun 2020 10:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IYlmzlXm+VrJo7JYODsM8cd9UWnB3bZArKAUI6t3sVA=;
        b=VwqXe+SC9JBUUohRt1aVE6bPQXlMwSRhAaTu+S1Nde6pinRGw/JacoeMqkVAyD0Tm9
         TVYeNmo71/8OpIBMvakVOTRQ4qdt7N2gWHl0KoBND9b2yGBmLhGD9FHUXmMmGj7k6Chk
         EFs44/ZeAbBAcrTdN3aT8D2KnyrTPPfhfClu/0sofjIVcmRQS81JNj13Xca9teYGGKKi
         YkjuuIbBrIBIAhlln8dD6OXGjyPAs6J8c5Ghh9XfRl6Q19hGHUNKRtIjJ84FHV4kXucZ
         IIob5LqKzd2fyEMF5BjzUJjc3R+oQE1aN9N3sqafgghbekZ01vHrvykL8xbIXG1NPZQs
         Q8Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IYlmzlXm+VrJo7JYODsM8cd9UWnB3bZArKAUI6t3sVA=;
        b=eFDrU8Y5vsbEPPupY7ESWvG5RnJm+pl3fKcTPW5BTsCC8DksTCZ8cPJu1bNJP/2sXw
         kyb5MYZWYJpmhiGB85oPP7rkMzWWzlRLW0oQmN0kXUY/eCf1Lmlwg/9mZWvW2iA54141
         OrM3bEVfvtm5mDngL1/CeYo//7KPbkPlBMLRGaoAqaEzzNxp0yPKZxOrGFtws3CDWIjC
         xfZG9Fe63hOdu2iG2UJpKCpmf6TwC5KaQya3mGihzL3WcoIvEBo2mdWnPepnTTFiIMfk
         c/TIK3tY/zds30w9HhWJGnkrE+GTMXu2ENkH7ZRVHcuPBjIxdP2q0zzecYwebZvnZUMh
         y38g==
X-Gm-Message-State: AOAM530fXrmgVhQXEikavUzBecm+LElpsBQtX2Q0yFe3it1/fc5O37xa
        ZMpbLsp8/DPiywm70UzpK34KX6Wb0BYDu12r4LQAXA==
X-Google-Smtp-Source: ABdhPJyCAdMN0uphyaz9XQHN+YjMSKmZ98XA0/imPSKpbF7ImtJk9dhI7N6nTJB9E4MY2U8MoJdqhVK4c1KFSjUwvcA=
X-Received: by 2002:a2e:8e8d:: with SMTP id z13mr2640858ljk.461.1592501057300;
 Thu, 18 Jun 2020 10:24:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200616011742.138975-4-rajatja@google.com> <20200616073249.GB30385@infradead.org>
 <CACK8Z6ELaM8KxbwPor=BUquWN7pALQmmHu5geSOc71P3KoJ1QA@mail.gmail.com>
 <20200617073100.GA14424@infradead.org> <CACK8Z6FecYkAYQh4sm4RbAQ1iwb9gexqgY9ExD9BH2p-5Usj=g@mail.gmail.com>
 <CAHp75Vc6eA33cyAQH-m+yixTuHqiobg6fo7nzbbb-J6vN6qFcA@mail.gmail.com>
 <20200618083646.GA1066967@kroah.com> <CAHp75Vf71f2s6yipHJ4Ys1oe1v7L4PiqBCEbo0uBcG7Wpcs5dQ@mail.gmail.com>
 <CACK8Z6F2Ssj=EqhR2DZ114ETgQ-3PhzVi2rm2xxenCNOVH=60g@mail.gmail.com>
 <20200618160212.GB3076467@kroah.com> <20200618162322.GI34820@otc-nc-03>
In-Reply-To: <20200618162322.GI34820@otc-nc-03>
From:   Rajat Jain <rajatja@google.com>
Date:   Thu, 18 Jun 2020 10:23:38 -0700
Message-ID: <CACK8Z6EnqmJtSqPPz2ARk0jwFLR_yCTS0vSLQ0v4C9QF-6BQ1w@mail.gmail.com>
Subject: Re: [PATCH 4/4] pci: export untrusted attribute in sysfs
To:     "Raj, Ashok" <ashok.raj@intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, iommu@lists.linux-foundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
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
        "Oliver O'Halloran" <oohall@gmail.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Thanks Greg and Andy for your continued inputs, and thanks Ashok for chiming in.

On Thu, Jun 18, 2020 at 9:23 AM Raj, Ashok <ashok.raj@intel.com> wrote:
>
> Hi Greg,
>
>
> On Thu, Jun 18, 2020 at 06:02:12PM +0200, Greg Kroah-Hartman wrote:
> > On Thu, Jun 18, 2020 at 08:03:49AM -0700, Rajat Jain wrote:
> > > Hello,
> > >
> > > On Thu, Jun 18, 2020 at 2:14 AM Andy Shevchenko
> > > <andy.shevchenko@gmail.com> wrote:
> > > >
> > > > On Thu, Jun 18, 2020 at 11:36 AM Greg Kroah-Hartman
> > > > <gregkh@linuxfoundation.org> wrote:
> > > > >
> > > > > On Thu, Jun 18, 2020 at 11:12:56AM +0300, Andy Shevchenko wrote:
> > > > > > On Wed, Jun 17, 2020 at 10:56 PM Rajat Jain <rajatja@google.com> wrote:
> > > > > > > On Wed, Jun 17, 2020 at 12:31 AM Christoph Hellwig <hch@infradead.org> wrote:
> > > > > >
> > > > > > ...
> > > > > >
> > > > > > > (and likely call it "external" instead of "untrusted".
> > > > > >
> > > > > > Which is not okay. 'External' to what? 'untrusted' has been carefully
> > > > > > chosen by the meaning of it.
> > > > > > What external does mean for M.2. WWAN card in my laptop? It's in ACPI
> > > > > > tables, but I can replace it.
> > > > >
> > > > > Then your ACPI tables should show this, there is an attribute for it,
> > > > > right?
> > > >
> > > > There is a _PLD() method, but it's for the USB devices (or optional
> > > > for others, I don't remember by heart). So, most of the ACPI tables,
> > > > alas, don't show this.
> > > >
> > > > > > This is only one example. Or if firmware of some device is altered,
> > > > > > and it's internal (whatever it means) is it trusted or not?
> > > > >
> > > > > That is what people are using policy for today, if you object to this,
> > > > > please bring it up to those developers :)
> > > >
> > > > > > So, please leave it as is (I mean name).
> > > > >
> > > > > firmware today exports this attribute, why do you not want userspace to
> > > > > also know it?
> > >
> > > To clarify, the attribute exposed by the firmware today is
> > > "ExternalFacingPort" and "external-facing" respectively:
> > >
> > > 617654aae50e ("PCI / ACPI: Identify untrusted PCI devices")
> > > 9cb30a71ac45d("PCI: OF: Support "external-facing" property")
> > >
> > > The kernel flag was named "untrusted" though, hence the assumption
> > > that "external=untrusted" is currently baked into the kernel today.
> > > IMHO, using "external" would fix that (The assumption can thus be
> > > contained in the IOMMU drivers) and at the same time allow more use of
> > > this attribute.
> > >
> > > > >
> > > > > Trust is different, yes, don't get the two mixed up please.  That should
> > > > > be a different sysfs attribute for obvious reasons.
> > > >
> > > > Yes, as a bottom line that's what I meant as well.
> > >
> > > So what is the consensus here? I don't have a strong opinion - but it
> > > seemed to me Greg is saying "external" and Andy is saying "untrusted"?
> >
> > Those two things are totally separate things when it comes to a device.
>
> Agree that these are two separate attributes, and better not mixed.

+1.

>
> >
> > One (external) describes the location of the device in the system.
> >
> > The other (untrusted) describes what you want the kernel to do with this
> > device (trust or not trust it).
> >
> > One you can change (from trust to untrusted or back), the other you can
> > not, it is a fixed read-only property that describes the hardware device
> > as defined by the firmware.

Correct. I believe what is being described by the firmware is a fixed
read-only property describing the location of the device ("external")
- not what to do with it ("untrusted").

>
> The genesis is due to lack of a mechanism to establish if the device
> is trusted or not was the due lack of some specs and implementation around
> Component Measurement And Authentication (CMA). Treating external as
> untrusted was the best first effort. i.e trust internal
> devices and don't trust external devices for enabling ATS.
>
> But that said external is just describing topology, and if Linux wants to
> use that in the policy that's different. Some day external device may also
> use CMA to estabilish trust. FWIW even internal devices aren't trust
> worthy, except maybe RCIEP's.

Correct. Since the firmware is actually describing the unchangeable
topology (and not the policy), the takeaway I am taking from this
discussion is that the flag should be called "external".

Like I said, I don't have any hard opinions on this. So if you feel
that my conclusion is wrong and consensus was the other way around
("untrusted"), let me know and I'll be happy to change this.

Thanks,

Rajat

>
> >
> > Depending on the policy you wish to define, you can use the location of
> > the device to determine if you want to trust the device or not.
> >
>
> Cheers,
> Ashok
