Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F382E41F5F5
	for <lists+linux-pci@lfdr.de>; Fri,  1 Oct 2021 21:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbhJAT7O (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 Oct 2021 15:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbhJAT7N (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Oct 2021 15:59:13 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 079E9C061775
        for <linux-pci@vger.kernel.org>; Fri,  1 Oct 2021 12:57:29 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id oj16so4001346pjb.1
        for <linux-pci@vger.kernel.org>; Fri, 01 Oct 2021 12:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j2fdDN3PiozWbni44hrcUM4tELJqdxqZaFoTlKL68Vs=;
        b=0JGuFckDuefx1bCUOQQTKROf8SkvsfTfm2aQYr6hDdqwzPH2hVDfwY5YXCRic8Cq91
         ELgl97w/iPOpc3I3dFiz4HMaQyqK86awMgz33OjajUmsBCByhP3QlKPUsuZZth75UuNf
         AxjeZK9xRw5esr+uKx2BHs/U1paJi146gE1L2rwzir/8YRTP3fppWIc/OsukJNfCjcnt
         UT1hznJk+ffLu6SvWVFfdLFXYl0JpOEvJcEx/qJCgT/AXRX7xYTyoX/NicL2Hg8ObdVN
         SCpQrUtUbqFWISWbd7KHBrB0fvBmA1iK40S5N/F/NGKMFompoWkiIFxXYIY8KECPScj6
         oabw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j2fdDN3PiozWbni44hrcUM4tELJqdxqZaFoTlKL68Vs=;
        b=zlpnVUrHQgMb450iKgEhsiBfZgRxeo18aEheFTJlo5kyxjGAPV+vCmhgBTBQtHJc2A
         3FHdbbFwze0UKGCm9WPC5NzU4cVjF5GFhBCZmAsdV10wgxxnOzWVR5iBsxwmqcCU9daD
         gDSo7xkLnJMGESZ2IMpC+xIm/htkx28Gyqo4nRYRFrKfbpWN6zGJyEBwA+KlnrX11VAj
         z6eZ7FVWgxzmb8T3cj+y/pgI0oL9sVhYOg6MAa6Tqpo+uEAIGUikYpxPXlfWPsXLxGgB
         tOnOMM1SiZP0ftzCJWmpkc1aYhSqMpqDj6NduqGQm0MEXvm+fJgMxXHJe5r3LsZI15iQ
         nNDg==
X-Gm-Message-State: AOAM533oXYOcIuvPB3MOD1zHtvN1oVq9SBxxSh3PgEsKkRnaCnte1Y7+
        FmFXfU1XUTgYrgJ5l7yEEI26/RVGkZGLgMFOMRXN1g==
X-Google-Smtp-Source: ABdhPJyYGsOX6LM9svlvUKXQV6gXINpbe2lghZhRPNGB5T8BuB8dNpJg0NT6Sk/CXd08VvLAzRuUb+K/TIbmj7eSIoE=
X-Received: by 2002:a17:90b:3b84:: with SMTP id pc4mr15214648pjb.220.1633118248489;
 Fri, 01 Oct 2021 12:57:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210930010511.3387967-5-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210930065953-mutt-send-email-mst@kernel.org> <CAPcyv4hP6mtzKS-CVb-aKf-kYuiLM771PMxN2zeBEfoj6NbctA@mail.gmail.com>
 <6d1e2701-5095-d110-3b0a-2697abd0c489@linux.intel.com> <YVXWaF73gcrlvpnf@kroah.com>
 <1cfdce51-6bb4-f7af-a86b-5854b6737253@linux.intel.com> <YVaywQLAboZ6b36V@kroah.com>
 <CAPcyv4gqs=KuGyxFR61QWqF6HKrRg851roCGUqrq585+s2Cm=w@mail.gmail.com>
 <20211001164533.GC505557@rowland.harvard.edu> <CAPcyv4i__reKFRP1KjWUov_W5jBQN9_vbUbKRL_V7KMM3oPuuQ@mail.gmail.com>
 <20211001190048.GA512418@rowland.harvard.edu>
In-Reply-To: <20211001190048.GA512418@rowland.harvard.edu>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 1 Oct 2021 12:57:18 -0700
Message-ID: <CAPcyv4hYL51DcBuSuyMRFo5Jcc=zLd=Ugo+H_2saELcZ5AJBeQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] virtio: Initialize authorized attribute for
 confidential guest
To:     Alan Stern <stern@rowland.harvard.edu>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
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

On Fri, Oct 1, 2021 at 12:02 PM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Fri, Oct 01, 2021 at 11:09:52AM -0700, Dan Williams wrote:
> > On Fri, Oct 1, 2021 at 9:47 AM Alan Stern <stern@rowland.harvard.edu> wrote:
> > >
> > > On Fri, Oct 01, 2021 at 09:13:54AM -0700, Dan Williams wrote:
> > > > Bear with me, and perhaps it's a lack of imagination on my part, but I
> > > > don't see how to get to a globally generic "authorized" sysfs ABI
> > > > given that USB and Thunderbolt want to do bus specific actions on
> > > > authorization toggle events. Certainly a default generic authorized
> > > > attribute can be defined for all the other buses that don't have
> > > > legacy here, but Thunderbolt will still require support for '2' as an
> > > > authorized value, and USB will still want to base probe decisions on
> > > > the authorization state of both the usb_device and the usb_interface.
> > >
> > > The USB part isn't really accurate (I can't speak for Thunderbolt).
> > > When a usb_device is deauthorized, the device will be unconfigured,
> > > deleting all its interfaces and removing the need for any probe
> > > decisions about them.  In other words, the probe decision for a
> > > usb_device or usb_interface depends only on the device's/interface's
> > > own authorization state.
> > >
> > > True, the interface binding code does contain a test of the device's
> > > authorization setting.  That test is redundant and can be removed.
> > >
> > > The actions that USB wants to take on authorization toggle events for
> > > usb_devices are: for authorize, select and install a configuration;
> > > for deauthorize, unconfigure the device.  Each of these could be
> > > handled simply enough just by binding/unbinding the device.  (There
> > > is some special code for handling wireless USB devices, but wireless
> > > USB is now defunct.)
> >
> > Ah, so are you saying that it would be sufficient for USB if the
> > generic authorized implementation did something like:
> >
> > dev->authorized = 1;
> > device_attach(dev);
> >
> > ...for the authorize case, and:
> >
> > dev->authorize = 0;
> > device_release_driver(dev);
> >
> > ...for the deauthorize case?
>
> Yes, I think so.  But I haven't tried making this change to test and
> see what really happens.

Sounds like a useful path for this effort to explore. Especially as
Greg seems to want the proposed "has_probe_authorization" flag in the
bus_type to disappear and make this all generic. It just seems that
Thunderbolt would need deeper surgery to move what it does in the
authorization toggle path into the probe and remove paths.

Mika, do you see a path for Thunderbolt to align its authorization
paths behind bus ->probe() ->remove() events similar to what USB might
be able to support for a generic authorization path?
