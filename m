Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4221EEB41
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jun 2020 21:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728116AbgFDTi6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 Jun 2020 15:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727950AbgFDTi6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 Jun 2020 15:38:58 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F00F6C08C5C0
        for <linux-pci@vger.kernel.org>; Thu,  4 Jun 2020 12:38:57 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id z18so8763124lji.12
        for <linux-pci@vger.kernel.org>; Thu, 04 Jun 2020 12:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EC5OcEtQhTge4l+YJjdaj9zLNH3vvY9AIXosw8Q5X1Q=;
        b=bKEL5N+lXZlTR8RT4w88Q2zpLpHg4+ir80lB97eDS31qZVtEzZhYnc0xAn6Bawtk/d
         8dKD7DwCjCqAlDXugJa+r1mDKQXwqgUboJRohkcQgT07Gr1LN5U60kgovgcMAuVmpjeL
         ZCkhsOFen1HbtibyX1iiZjKu0ZPjoZHNtlrKmf4Ki5t2EkvWE9pj27R4+TdESSFnrk2e
         MFHWadn1hlnkguPn9rMHg1ehFiWPQEZvamlOZ/N5JlRqfizXKyEIM50L7iF/enlp9lm/
         BrBWhoTKFEK/aoCBb23kBoTsPYA1QUR4+WpAyefdZHzDQP5CyWZDUMWCGUiV48s5dZp/
         mABw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EC5OcEtQhTge4l+YJjdaj9zLNH3vvY9AIXosw8Q5X1Q=;
        b=N/OEcF42XvCywhQTpS1/Vc8miIspxRSd7rQTsr1WJvREvT30UJ71QFJadKeVso+fIs
         cyPHK5fa7iL20cH5b3b2DhBEHFEqdyCZmcDLWZVsAQaaCQLIzjtwPYlZj7mx/C5h+Yj0
         usKv/UFdEYKYHUHACGMYnbfcU8hYXKruQhprqz3Kb9MqhMlXqdTSNvlHVEdf7FrhYW8z
         EcGwfnFrN0hLVhqeWoHX8ygTtNKzq5j18pOksO8VGTzqVLIzgQthrMCBOYq5ktf3shK0
         gc77iPgeQgssI72FbsSyI2MHya1pbJ7kz/q76+/TEw2eSPG5Z1v3dcSoNDrBg0UAan/V
         5AQw==
X-Gm-Message-State: AOAM5310eGSnmYfLFyeiZ439FJkKCJCXJW6nTfTck/qjIoJjMcf0Z5JG
        PAPPDTmfnwzmVPvwynVWYXzppndZ7hydeMupCqWIxg==
X-Google-Smtp-Source: ABdhPJzH4hCPoN9DQ3CStQ4Mw0y8xn738oIzhgaGEGbe9EAsDN89kcJ68Wzk0ppYx7/p4J7/dHa9+9+M1am9gyKUrO8=
X-Received: by 2002:a2e:b0e9:: with SMTP id h9mr2744476ljl.307.1591299535843;
 Thu, 04 Jun 2020 12:38:55 -0700 (PDT)
MIME-Version: 1.0
References: <CACK8Z6F3jE-aE+N7hArV3iye+9c-COwbi3qPkRPxfrCnccnqrw@mail.gmail.com>
 <20200601232542.GA473883@bjorn-Precision-5520> <20200602050626.GA2174820@kroah.com>
 <CAA93t1puWzFx=1h0xkZEkpzPJJbBAF7ONL_wicSGxHjq7KL+WA@mail.gmail.com>
 <20200603060751.GA465970@kroah.com> <CACK8Z6EXDf2vUuJbKm18R6HovwUZia4y_qUrTW8ZW+8LA2+RgA@mail.gmail.com>
 <20200603121613.GA1488883@kroah.com>
In-Reply-To: <20200603121613.GA1488883@kroah.com>
From:   Rajat Jain <rajatja@google.com>
Date:   Thu, 4 Jun 2020 12:38:18 -0700
Message-ID: <CACK8Z6EOGduHX1m7eyhFgsGV7CYiVN0en4U0cM4BEWJwk2bmoA@mail.gmail.com>
Subject: Re: [RFC] Restrict the untrusted devices, to bind to only a set of
 "whitelisted" drivers
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rajat Jain <rajatxjain@gmail.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
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

Hello,

I spent some more thoughts into this...

On Wed, Jun 3, 2020 at 5:16 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Jun 03, 2020 at 04:51:18AM -0700, Rajat Jain wrote:
> > Hello,
> >
> > >
> > > > Thanks for the pointer! I'm still looking at the details yet, but a
> > > > quick look (usb_dev_authorized()) seems to suggest that this API is
> > > > "device based". The multiple levels of "authorized" seem to take shape
> > > > from either how it is wired or from userspace choice. Once authorized,
> > > > USB device or interface is authorized to be used by *anyone* (can be
> > > > attached to any drivers). Do I understand it right that it does not
> > > > differentiate between drivers?
> > >
> > > Yes, and that is what you should do, don't fixate on drivers.  Users
> > > know how to control and manage devices.  Us kernel developers are
> > > responsible for writing solid drivers and getting them merged into the
> > > kernel tree and maintaining them over time.  Drivers in the kernel
> > > should always be trusted, ...
> >
> > 1) Yes, I agree that this would be ideal, and this should be our
> > mission. I should clarify that I may have used the wrong term
> > "Trusted/Certified drivers". I didn't really mean that the drivers may
> > be malicious by intent. What I really meant is that a driver may have
> > an attack surface, which is a vulnerability that may be exploited.
>
> Any code has such a thing, proving otherwise is a tough problem :)
>
> > Realistically speaking, finding vulnerabilities in drivers, creating
> > attacks to exploit them, and fixing them is a never ending cat and
> > mouse game. At Least "identifying the vulnerabilities" part is better
> > performed by security folks rather than driver writers.
>
> Are you sure about that?  It's hard to prove a negative :)
>
> > Earlier in the
> > thread I had mentioned certain studies/projects that identified and
> > exploited such vulnerabilities in the drivers. I should have used the
> > term "Vetted Drivers" maybe to convey the intent better - drivers that
> > have been vetted by a security focussed team (admin). What I'm
> > advocating here is an administrator's right to control the drivers
> > that he wants to allow for external ports on his systems.
>
> That's an odd thing, but sure, if you want to write up such a policy for
> your systems, great.  But that policy does not belong in the kernel, it
> belongs in userspace.
>
> > 2) In addition to the problem of driver negligences / vulnerabilities
> > to be exploited, we ran into another problem with the "whitelist
> > devices only" approach. We did start with the "device based" approach
> > only initially - but quickly realized that anything we use to
> > whitelist an external device can only be based on the info provided by
> > *that device* itself. So until we have devices that exchange
> > certificates with kernel [1], it is easy for a malicious device to
> > spoof a whitelisted device (by presenting the same VID:DID or any
> > other data that is used by us to whitelist it).
> >
> > [1] https://www.intel.com/content/www/us/en/io/pci-express/pcie-device-security-enhancements-spec.html
> >
> > I hope that helps somewhat clarify how / why we reached here?
>
> Kind of, I still think all you need to do is worry about controling the
> devices and if a driver should bind to it or not.  Again, much like USB
> has been doing for a very long time now.  The idea of "spoofing" ids
> also is not new, and has been around for a very long time as well, and
> again, the controls that the USB core gives you allows you to make any
> type of policy decision you want to, in userspace.

Er, *currently* it doesn't allow the userspace to make the particular
policy I want to, right? Specifically, today an administrator can not
control which USB *drivers* he wants to allow on an *external* USB
port. He can only control which USB devices he wants to authorize, but
once authorized, they are free to bind to any of the USB drivers. So
if I want to allow the administrator to implement a policy that allows
him to control the drivers for external ports, we'll need to enhance
the current code (whether we want to do it specific to a bus, or more
generically in the driver core). Are we on the same page?

To implement the policy that I want to in the driver core, what is
missing today in driver core is a distinction between "internal" and
"external" devices. Some buses have this knowledge locally today (PCI
has "untrusted" flag which can be used, USB uses hcd->wireless and
hub->port->connect_type) but it is not shared with the core.

So just to make sure if I'm thinking in the right direction, this is
what I'm thinking:

1) The device core needs a notion of internal vs external devices (a
flag) - a knowledge that needs to be filled in by the bus as it
discovers the device.

2) The driver core needs to allow an admin to provide a whitelist of
drivers for external devices. (Via Command line or a driver flag.
Default = everything is whitelisted).

3) While matching a driver to a device, the driver core needs to
impose the whitelist if the device is external, and if the
administrator has provided a whitelist.

Any bus that wants to use this can use it if it wants to, for external devices.

Thoughts?

Thanks & Best Regards,

Rajat

>
> So please, in summary:
>         - don't think this is some new type of thing, it's an old issue
>           transferred to yet-another-hardware-bus.  Not to say this is
>           not important, just please look at the work that others have
>           done in the past to help mitigate and solve this (reading the
>           Wireless USB spec should help you out here too, as they
>           detailed all of this.)
>         - do copy what USB did, by moving that logic into the driver
>           core so that all busses who want to take advantage of this
>           type of functionality, easily can do so.
>
> thanks,
>
> greg k-h
